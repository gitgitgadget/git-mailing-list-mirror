Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2171A23BE
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744820475; cv=none; b=iWjH+LaCvqk4do/kegeD4YZYLzfoFu1QLkJ69XQ1FtzbbTxd86FwfN0vQpM/9CDxGt6iaGAZI1Z2gglhPWt0FNvOP4yPLmihpI/Z38/rl00g6rat4QDosGYNZSm2mlGvzItYx330/kaahHxDpnD17OJBzpXkA/llTcHf/4x6sDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744820475; c=relaxed/simple;
	bh=PZc2T5CeN1S+I6PVtZrdbDmgBWtnMOcvazhuYkA5wTU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GwDQ64PSy1phFVMo7FMypaaMtFyupX4uLatKxklE8CxGVXDio9wkgTCIObE2FWB6YPncktSoQ/16eAl04rct7YQ3D60qqwBfAv45AAy23JSOpunlYL/K8ATWtZ0/tu6TZzeFpWknZkIkgfCj1hkDOFnR+pgwFKvlHV11LLwuozg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ogrGV1DK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rg5f6BYW; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ogrGV1DK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rg5f6BYW"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B69661140274;
	Wed, 16 Apr 2025 12:21:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 16 Apr 2025 12:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744820472; x=1744906872; bh=REx02S5t4w
	2kXx/G1Sww5xKRtxzhJOgdxoAmXdeZhPA=; b=ogrGV1DKEYCg3PmMJlPZg4fElD
	QGOU+CG0LtQjhaJ/qCR53pNgzz6+plmM5jDU3BHK2Ypi/oZ9cx7sD05Lh3QxyzsG
	wYJRZCQGCc15Ao0TNzi52+9oXYf7NnbZ6Jwixq8nbVbFR09pu2Oh2LE8yS9GJIr4
	ejwmShkx6P/TRk+k47NaUn1cWVPaHfzsMib6Oh8v5UGVtvuUQImjFbTVOKq1kLDS
	m5t/q+dIOqFXiMun2hVR7wx1/yIHy2GRBFwk8hJPNwcf5TZEdQpLs2qItvXF1ZHI
	ax1GnHBLQByEGUD5XR28pYdc/hparAmef56yxYCo/uyLCQKYN4rZ3tAjFTLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744820472; x=1744906872; bh=REx02S5t4w2kXx/G1Sww5xKRtxzhJOgdxoA
	mXdeZhPA=; b=Rg5f6BYWpCQ0KK7Gop0W0zIYmLapC3f9auu2CcFUDD7MfTvyZXw
	hol98+oy0yyR7VlhBvAu+JJpzpSKDerSIjZAJlBSgYgcG0uycvxmNRcfV8CeC2Q8
	RsBrPcxVV1nDaqHpiBI/CqFgm6XhmHmi+pWd6STuDkN+vGB52Rh2xMJiIgMg5g7b
	b8s3nAMPAuJSmAgpmuOyPkDC/Zt++/i3K0nyvuav8Ec78JXD+tzUbrz4TFJr2BbL
	4EiU1Vt4iwQEy9Xy2RjBLRA6OYSy60X14fSK2R7IDIpzj2ZuXtbzPngZiarZFBKI
	AhgcOtgjKo18LwV0o3W+pae+nY4wyLO6XiQ==
X-ME-Sender: <xms:-Nj_Zxyal56_6WDQkxb_431C6PZUGGzIyP67IbWbJQw_kBaOWrnvdw>
    <xme:-Nj_ZxTix1wW-HBUXmRx8AJY5Kj7qHS3ZFZX0fLwJhFWyM9ZIzv85Fz6zl_BOIo21
    E7rrPdRnFvk5UKnQA>
X-ME-Received: <xmr:-Nj_Z7WSCdCOdE5DkpVRK-RdjbrLlZ6l0Z8TyBYk7G6TCkXEKmM3HhcKfslYd_XlYVAuw11FUXUtraIDj0Lv6D3urKhb0lSS215K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeikeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvse
    hsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-Nj_ZziBoacEzg3gbHG_fiT8DW0XNM6_WCjj2lyRPynW4YcDY5AbSQ>
    <xmx:-Nj_ZzAZwGVfDNzwuXFWJspzkG16yN0dNeicafYGllFKOzJLvLpNsA>
    <xmx:-Nj_Z8J1kkL03Y8f70lxZPk3syubov10sRKOsaglecMqWaaedR2ZFQ>
    <xmx:-Nj_ZyABnisu-5IxDQSepX4PvToLN9dv0bIUUO0LkXFsXaUgBh-e0Q>
    <xmx:-Nj_Z_Zu3A_qeJj3RUhzdI_YZVNimemCzOf5oyDKjbElm_ccFegNvsj7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 12:21:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Eric Sunshine
 <sunshine@sunshineco.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 00/10] Split up "object-file.c"
In-Reply-To: <CABPp-BFGeJ6eANb_5m4KSWRY_r9KCWarzya_qMkQNchKD5Q=xg@mail.gmail.com>
	(Elijah Newren's message of "Tue, 15 Apr 2025 23:41:34 -0700")
References: <20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im>
	<20250415-pks-split-object-file-v3-0-6aa7db7ad7b0@pks.im>
	<CABPp-BFGeJ6eANb_5m4KSWRY_r9KCWarzya_qMkQNchKD5Q=xg@mail.gmail.com>
Date: Wed, 16 Apr 2025 09:21:10 -0700
Message-ID: <xmqq7c3khybt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> I read over the range-diff and the three new patches (1, 2, & 7); this
> round looks good to me.  I particularly like the extended rationale in
> the commit message for what is now patch 9.

Thanks, both, this round looked good to me, too.

