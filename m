Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F6813AC1
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 21:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745877015; cv=none; b=cVvkNyD0FA+ZZt4DuqPmwTx0EpktimZcMtG8p9o79YZmjeIbUx43wErQrX9rO+GXDknxsFQkJQ5WH3Uh7x3dQUXgT0kGna54AjHdngHuPfbW8nZoH+xPJnXfPFv5ONe4DWXmha769dFkuKD9qLojCpoeRhCBO1WjrGgsqwG7RDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745877015; c=relaxed/simple;
	bh=b9HAzEghYnUfpgsPvTKV4YWNzNk6U9XGKMr+EOGpDzk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q8lWAbrtogv25Vd4DbOOGt2jx2TDT1VKp9xzKaxtjCgJifDs5nmalrT3Zv5iu/7d7yKCesbcsRuMsRAF1YrCH/esWtBgaiQwGpZGEpZ+dkLSDoyyQrU2D631wivmn8sXBPad06xYloAEV17uMV7eBAL/e6IRBcNBPIgP0EnwLjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RV7Y1DJa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HoJx3ePH; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RV7Y1DJa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HoJx3ePH"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 5A06F13800DF;
	Mon, 28 Apr 2025 17:50:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 28 Apr 2025 17:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745877012; x=1745963412; bh=lslXSvI21D
	OlcMEFF28WbVqJ2mpLs4mAroSn8iAfDCQ=; b=RV7Y1DJaLbKWovQ3gAx9RSRSJp
	ud95HcW21u811lqls414qtupnhmcoEVdBzhSP3/QJvnfiuSrK3bDztPzwQMXDCCl
	S+WURz2RuDpvS8BhqKrofBI6LxlyP3lo5og18QWgFQuqHD02iYGBz1BlXmAdUsQc
	J1RQghIrXsoX1HDr0wUZQODBumw/saNOmn0eccLy2mwh3blTOKkqfB+KGA5mCdCu
	gsM0xY3uE4ZPbS86kS51Yy3NQLcqFO1qbrSdggs6slqrbxLKq8gSj/hinuHtITxe
	REcteniqgakJFNDB3Y3WkaL0luAa7bgm1B1ESaBMb1j2nripKEE/30MtpXtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745877012; x=1745963412; bh=lslXSvI21DOlcMEFF28WbVqJ2mpLs4mAroS
	n8iAfDCQ=; b=HoJx3ePHKdkeejnfGX2RHkxXpn5dfbTGSufBRyICe4itVgkneE+
	WRuqUZecBj9cI39k+UU/S8MwMcIcfjWgTal8ZvHKBQupiLloNdXtigwtUH206Gzf
	aS9lUnmMG8vGzYL1Avmdej6aPPtJynkXFyEo/anMVhLWvJCyxEEoFoALu4xrMaIp
	/qeSecqMLV7ROzmIfx2lB/ZN4ext1ydve7e9T3ipO6sZKSrFZeUOCw+AKQsZW+7e
	5d1vZOBtX7BFn+ndV3O1s1QnJRXPhWIpvxy3xrhRiA/cn0fx+H4VHofC64OVDwJu
	w3+hfDXUrRHs3br7SgQSNX1r9DIN7gY/5NA==
X-ME-Sender: <xms:FPgPaM4RsrNLCay7D1pRwCfUEkkid2zkqCdtDSsEc9Rd_wYKsFkWCw>
    <xme:FPgPaN7ErtR-88ipRs_II0ElGaxoDH1BP-EpySrQ9jTgXvFciHY6I8oG2UB9riTgG
    BFtP7wtq6L7ihfqVw>
X-ME-Received: <xmr:FPgPaLeeUYvl5gq0AKjZdIxMoudlaZQk1jgz2h98OnJosOMl1UjWNu2ugRb3ahwgeHFOwicP_WiPwgyKx3803bnYvEkVKCPGd1XO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedvtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:FPgPaBJq8O0Px0P0Th7iv-pBnaVS-15nBL39sCZnfOr1aIRBmOFoEw>
    <xmx:FPgPaAIahe_KtXWF-bcUrYv1Jle3ZioIEoPJ0Pv_fkK9YrNSZzqEAg>
    <xmx:FPgPaCx7yMfAuwtlZZoqzxi8ucSCeioW_BZeE2u-NkQ0VdTh0JOeJw>
    <xmx:FPgPaEKLM1b1OTES9_A5F8jDsZdgRzZ82dz1IQlGWe741t8ORasb0A>
    <xmx:FPgPaDXqyv9OtXeKm3ivx3fVRVfNWDJK1sCG6rjBYqE1mD_NQ2hrK79P>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Apr 2025 17:50:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 08/13] builtin/show-ref: don't fetch objects when
 printing refs
In-Reply-To: <20250425-pks-object-store-cleanups-v2-8-63f1695b7700@pks.im>
	(Patrick Steinhardt's message of "Fri, 25 Apr 2025 09:08:59 +0200")
References: <20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im>
	<20250425-pks-object-store-cleanups-v2-8-63f1695b7700@pks.im>
Date: Mon, 28 Apr 2025 14:50:10 -0700
Message-ID: <xmqqy0vk9crx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> When printing references via git-show-ref(1) we double check that their
> respective object IDs point to an existing object. This check is
> performed via `repo_has_object_file()`, which knows to fetch missing
> promised objects in the background. We shouldn't have a need to fetch
> such objects though as no reference should ever point to a missing
> object at all.

But hasn't the earlier part of this series made sure that asking
has_object() without an extra flag would make it say "no" if the
object that we know we can obtain is kept in our promisor remote
to be lazily fetched?  Or am I missing some other mechanism to make
sure that somebody does any necessary lazy fetching of an object
before we point our refs at it?

Thanks.
