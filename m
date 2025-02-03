Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4DE202C53
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 23:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738625167; cv=none; b=dMigTdGat2OnKU3vyxbpF1NWYr/Xi13ptsrS4Z6p91Gkrj1ogDbAE2an4HltQcT3ymer01Dyqlhcv5Hxk9Ppp8wPPbyAxft8mKvv8sVbXJ32Lt9Fuv07sWT6gb02dgCwu+zr5z7yfwjoFl7B1An93eY3NeEoiLZ8Zhm4Q8TePck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738625167; c=relaxed/simple;
	bh=4MrtOsRtM9tgeU0gJ/OKNykmFXx4qK1JMwMzwNopybM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g5QeuyBYLI2VJLH652eG/Jw91842WS/XHY/27qjWUMRLNu+jqkYeGeRU1/IBtvF9x+Vy9HbiPHPFvoO7y5++wmYYG5jgXyUyYDLtoeFtFOXx1RRTFillpy4X1Ra4C4a+TInk+STUbm28Tnc2Vdex5VDeC5C+dE5Ec1n5PFGAyOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=v0zmaZVY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LGpvYNBz; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="v0zmaZVY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LGpvYNBz"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id CE3351140102;
	Mon,  3 Feb 2025 18:26:03 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 03 Feb 2025 18:26:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738625163; x=1738711563; bh=UD+C0eJv2i
	unfffhXx/zvJc9NsaM3yBY8unXwaU4aJQ=; b=v0zmaZVYlF/W6wYbWi+MUtVfjo
	vNa/KYL+EG6kQCMIk5nfonsrh333hF0xF7RtGaz3ttixwV9QA1sjvZ66eXJ5kON1
	lXYCJRz1StXc7+Jx+TXPZNlElQjd6ngmSDqSoNXLcQG9pJ2wxIXF9wYhlaHtFmeo
	strXpQAnJ9n3RNb9aYU4uF1KSc3YHZ9cjvmyQGTigGPen41dC7koXNJMjwUrYKN0
	f3xoV7Q9JpmsFYWuy+3nT/t1Pc0rsC2JCyHiCDpucOQP0CSOPOGzaDWkgd+dg3Uc
	huWuWs5RuPp50RIit3j53x5Da84TITcj/BzwCF7lB/9pMBeWHynlqzPurwag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738625163; x=1738711563; bh=UD+C0eJv2iunfffhXx/zvJc9NsaM3yBY8un
	XwaU4aJQ=; b=LGpvYNBzogs0Hb7kywj+EEmEhm8q38LjxyEk5l5kV20N+DVub1+
	jO3xWobkGnApGA2hXDdOmcPJVm5tB9hF5YSYh+CSCHOEqIngW2b1WmkXTtzpT2TA
	a1GGEpJAJIJ1tvYSuuYrojYEHav9ag+LnoYlgWke8DUMZTKNVTZW83VgU7BRzTP6
	vwlB335S06PHwHukcZCAhfHr2dPHAbIQ3g9dHKSpD7RdX/Cs5uInipZn4NtSJrnT
	5yI7cQd0LD0Qoy28P0m4yKEHeIewsWBd4qPEOaxJSnJ16KyGONvnqx1n1XpyDLrL
	KFzhkHX1AZu886z2W3DtnZA4CsCWUdt4Jgg==
X-ME-Sender: <xms:i1ChZ4-j7bS_CJLLv166P82b_6fowtSptnsUzAeVrdvjzrHjieiMpA>
    <xme:i1ChZws665t-UFLY9ZJPxdW1pOk5weGW1M8CA0GCUiVerO67O3YWupDRgQrJwMXkK
    951G7KEqs-osQb3lg>
X-ME-Received: <xmr:i1ChZ-Dw0by_gRnQFLDfiw0bxxVyOvIuKbSvM5qUeEY9bJfvPaMLOp-inMPjafxYqxuoAiMUseWjDUKcssCJevxsZvF_Zqg4soJU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeev
    teevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepiihhihihohhurdhjgiesrghlihgsrg
    gsrgdqihhntgdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgv
    tghordgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:i1ChZ4c7MJdzCOWx4IT3to77sxUYCV1-9a5xOFK2bf_adz-2cK9nqg>
    <xmx:i1ChZ9NmvOMwMlj3BGTHa3qUEtXHM6ZIloEpo3eJyyVbIvuABvDQ-A>
    <xmx:i1ChZyn2A4FqX6_Tf0hBPqx6PK9kGo1VUcTVOwcyKnszt4eLkTedLA>
    <xmx:i1ChZ_s2Qmw5nqpZonBWf9Ya-8r-i_Rz2bdibAJ9iN32o6ZgNEaPaw>
    <xmx:i1ChZw2GuKdqw9GrruAive7h6c20ZAsev-XS748Wv1RKXm6-4gXhk7KE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 18:26:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jiang Xin <zhiyou.jx@alibaba-inc.com>,  Eric
 Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 0/8] transport: don't ignore git-receive-pack(1) exit
 code on atomic push
In-Reply-To: <20250203-pks-push-atomic-respect-exit-code-v5-0-d66481e36622@pks.im>
	(Patrick Steinhardt's message of "Mon, 03 Feb 2025 07:29:30 +0100")
References: <20241113-pks-push-atomic-respect-exit-code-v1-0-7965f01e7f4e@pks.im>
	<20250203-pks-push-atomic-respect-exit-code-v5-0-d66481e36622@pks.im>
Date: Mon, 03 Feb 2025 15:26:01 -0800
Message-ID: <xmqqh65azk3a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Changes in v5:
>   - Escape heredocs where possible.
>   - Link to v4: https://lore.kernel.org/r/20250131-pks-push-atomic-respect-exit-code-v4-0-a8b41f01a676@pks.im
>
> Thanks!

Changes since the last round looked trivially correct ;-)

Will replace.
