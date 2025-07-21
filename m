Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6B83D6D
	for <git@vger.kernel.org>; Mon, 21 Jul 2025 18:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753122838; cv=none; b=fV7+N5IyGZGaAId6tLGKEWQ+YhmHP88PA1pNBxvxPZ97uu9a3nSa1WHp8Wir8XcwauhK0KF2nuuJxhJdjHOwybnN/ruqiH3RDNO8st5njEWbumFKTvx5JX/GaluORna+6Vx8JxtzvGx/zCPwmzmLM5HTkl2leiqGgIWIKm/A9qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753122838; c=relaxed/simple;
	bh=bKuNZT0FU9mHWl0OQCe+YVShMly6k3o52N4R1guQffA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LuLnb42lftdzVvO3E0qq3Pp13AYnwAVNtD/x7/mGx+WqJW5Uyajf14P1O3pGsByEuP9K2duQtbhKtyXIKHvfNObaLlENkytEXIHIV1SrHiaXhWECjC/amEU4R2wAXoy1xhsE2JeUd8Gfxp2Ulh+X08YPO5yW8p0jBvNhZlKZ5fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Lg3mHhN4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f0sj3PDy; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Lg3mHhN4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f0sj3PDy"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 031B61D0008B;
	Mon, 21 Jul 2025 14:33:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 21 Jul 2025 14:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753122834; x=1753209234; bh=bKuNZT0FU9
	mHWl0OQCe+YVShMly6k3o52N4R1guQffA=; b=Lg3mHhN4Q8vUxU08nsGu7E4ZWN
	Amr4jNWtLHpWmAyo0vkIpU99AUq2Y2U1x38LI7cvb12dUVb4HavD6KUM4OJGEagh
	3MzrLiq/XSrWtsx9CdZCBoDYkwwa+rIqUDvlCgJe03Bz/I5BLNufFOZ4PTi53OfT
	NzfkCVuNb7nn14EJHh76xEX3Cd6wc/V1rQImSQ0vEGNEwPoAi+fewu+DaCWHy5FU
	5xEuu4Tc1i3RJX9m/sCydjSbkNun+WTzZCiq2VKCL2KrSGelV9IGgN9xvLurcJdX
	VSYqIFlyelYMNM6I5cHfwD/o9CwSLHi/wf//60N4jGk9XyKp4rn36+2Wh6+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753122834; x=1753209234; bh=bKuNZT0FU9mHWl0OQCe+YVShMly6k3o52N4
	R1guQffA=; b=f0sj3PDyRAHFvAt69G31RX1e4dY3Qa49hm8L14uG+M24pIjRfl2
	HOrur+n2L0AfU/Q7AO8zueWcvUw9a88gyyjrTCabnMylMyQkegFmR3+mtSOwut3t
	6hoNO24WxfXr1JG73pvnq8bKhXdjso6ZKo6zuBUgKSDyFgt9pht2/j5vzX6jBH/u
	RcCIrOnpluQ19AtDDynj4OgrBCnrSjRH621ZYpjWY1MzOOn8Pk8SexyCBeTeg0ys
	qbr0S+qfFRi9nVofzB+Bso06qb2zz6sxTUhqjuzy7DMoTWskupHGU8mL5H0pkDAD
	n5tKgyylIQuYTgfCkMViKM/XoIeJE9L5Thw==
X-ME-Sender: <xms:Eoh-aJI9qNgBt37GhO_4O52fgrWqj0k-1IZ8wesHzDCiqXZCMq7_3w>
    <xme:Eoh-aNm9Tg5_pBvbSqPbesP68Yi26V_DZVTAtZS_wALhzHhiUTgxFTK1AAIFcH3KB
    7qTGdSaDA7cFV9PyQ>
X-ME-Received: <xmr:Eoh-aCI7EexdaOJ6jHdYFrNWjIrvdAvL2yHKdjEzwhk6MmyLQVnlHfFsBDMuF9OY8W9P2bwIZ_Yt0Dc1Y8c5u2laLX81wCST1JKP_hI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejvdektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvg
    ifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghn
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Eoh-aK6IRGRRm9qLLAc_JRCp3v4RheVkU9Rf-KTlApA5THi1zPK-VQ>
    <xmx:Eoh-aO2kkrdY_fFAvSU3MmFljlKMRnb742d3X4qURIGX5TcPdfw8TA>
    <xmx:Eoh-aIedIYjzRVM68A43QOtNbXuCVxvQ6vM9-vTmAkEwo1e7VurWEA>
    <xmx:Eoh-aMdgGXPUB1kDFzj5MK3ZU9gcaU_uVc3qhmaCmR_x-DwlP3at_g>
    <xmx:Eoh-aFsj6UmcWHMsi5eMt5fBSfrBIT0EjrKrsIjRZMGEDhafYqK0Caio>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 14:33:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Ezekiel Newren
 <ezekielnewren@gmail.com>
Subject: Re: [PATCH 0/7] RFC: Accelerate xdiff and begin its rustification
In-Reply-To: <45ea5d1d-05dd-4f7a-bee5-ea3936d23d0a@gmail.com> (Phillip Wood's
	message of "Mon, 21 Jul 2025 11:14:38 +0100")
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
	<xmqqjz454l96.fsf@gitster.g>
	<45ea5d1d-05dd-4f7a-bee5-ea3936d23d0a@gmail.com>
Date: Mon, 21 Jul 2025 11:33:52 -0700
Message-ID: <xmqq4iv5z94f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> ... by 15%. Just over half of that seems to come from hoisting the
> check for whitespace flags in xdl_hash_record() out of the loop
> in xdl_prepare_ctx() and the rest comes from the change in hash
> function.

The first half of that alone is interesting enough ;-).

> As I understand it the hash is implemented using SIMD
> compiler intrinsics and the rust implementation is basically a
> copy of the C code in libxxhash. I wonder how well xxhash performs
> compared to our existing hash on platforms without an optimized
> implementation.

Yeah, that indeed is worth investigating.

Thanks.

