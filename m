Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F121B0437
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 00:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766018860; cv=none; b=HJyQsnxLm2NcodPqxBGx60hqWFZglb6Wc9EoDy3B4F3y5Tg7XVwnMXUVN8d/EWQx9i1OE54xx/RDE3q9UpDCIerkX3B8Hoe7UXxx2CTJc7usCk5iYfPKjp7JdyjlIDedZ5t/OrOHZzAcIIEU7Iq07J/OuoBdFLXuwe48haEugUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766018860; c=relaxed/simple;
	bh=CMaEUUfLPWSGThN2V3OFQja9QqV/jdm7yZSFulwI+D0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HC9i8pQQynGVkmGjUA37rooRDZFk7b/ITI0OdjW9kfjL1WXhWBhtMCJ3jLefsC/ioQYhj+PV45rzb08JNK657dEsW73KPeHaqseoLCjHe+kC2IeHlE43KHSvmCq36j0qhdHI+fF3BxnSdO/kxHShmGc15hsZkq2ukigsX6n/vDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J6+7lW5j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NscN6B0h; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J6+7lW5j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NscN6B0h"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E3C871400188;
	Wed, 17 Dec 2025 19:47:36 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 17 Dec 2025 19:47:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766018856; x=1766105256; bh=jSUX7FfInQ
	45c34ks/l+aq/XzRwnZzN72ySVFb1uP9s=; b=J6+7lW5jqyMZm5WL2uCEB7blce
	pKtscrd3IRjkC4eCC5HsZ65fhAIm2ck5DRF2aTuMt5AZE2pqyx1an2RqqOeCGuSc
	V9ox6UbTKipXTiic/l+iTZrRPxTwAcDw1p1M7ANScr/7vT/t+xrTHhyFiaxS+S9A
	jSTEbCJMKc32sPnO8TbfAbbNkOGTtLriI6Jk/kYg0Lgr9csBw07rl8plGvJRazIJ
	ltbpwu+wo7HWWXqyV9en4X3w8Zpc9SDrMwI9fJ/5nAIeuZ3NRbHM17bHyB/9MBzx
	T0R9T5AHZMrLiP/HMwgmk0lRSaMw+iRHamizccGz1DRU1oZ4Zxd673YwZibw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766018856; x=1766105256; bh=jSUX7FfInQ45c34ks/l+aq/XzRwnZzN72yS
	VFb1uP9s=; b=NscN6B0hOY36ktPqS/uMSxfl4RbEWT2UQrCuwSFQXmuHDCeGA4u
	8roxR8ssSPAvimETt0LYKHrOLTK+8c+NXpz5FLcMz7AySPGuLdtBBQqhm5M1bMMy
	mn29KlikNtbSVeoFvpQMsrLGCPRSYshx+NM98urR4WdNm2cJTFji76WfATkq7Qky
	Kn9Hv4QuanjwKsy64cz7VJ9dwYXl3s3D4uYGO38k2Al4his1+yGJlI/86iG8X3Ft
	hWm34aCxHv8I4AtUorbco3uQNE0xIKT3KXKytKZTY06czR7pSgQhbsImrmyWbtQM
	kaEwgTEnpWxh5GXiSIKvFmDQX6i68huQaBw==
X-ME-Sender: <xms:KE9DaWTz7naxBV4p3x_JuAR2WdJOcoakgyr_qidlGImV7w_RIQQ-Ug>
    <xme:KE9DaeVZTZ2KaL0sq0FS4VK-PRCN4-fqX8exabLgBQ5vRfz4M4BLr7XgeByuz_Tts
    cGtyu2n4n2n7Bz-H3Cb-UMV1sgHBy4kFEroni_IQLlaUbAWEtKg>
X-ME-Received: <xmr:KE9DaXfZ7HT7Nwq4Q8ehsQWrGcRu-StYPDqUZwU-F-yofJ4OBsZFmZi77coTG_QUWrUX1mqm6xyCfDVUWqiEzYRwV8fZsNWlxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggedtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    mhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesgh
    hmrghilhdrtghomhdprhgtphhtthhopehtsghovghgihesfigvsgdruggvpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehprghulhhordgtrghsrghrvg
    htthhosehshhhophhifhihrdgtohhmpdhrtghpthhtohepphgtrghsrghrvghtthhosehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:KE9DaSI3ek2Hez7VH6UuTxLieVaygN-jcGn4sRGkbnTeUNTgSuHbSw>
    <xmx:KE9DaUw1apsKb47IAHXSuYvz2vB_qPucFFBPdVHe66sAXxY1fw2pbw>
    <xmx:KE9DaYuvzLN27wQkGi2nzGrvCBNRgegy4SLi0sw257Gd_tThW7_xXg>
    <xmx:KE9DaXCcCJuFLpAmV0aFtdc-_cck708uel_cmTzLC7azDCajE7DPoQ>
    <xmx:KE9Dae39qSG-WDcclTcLKF8g2FiCk7P-sNnSrqd5xTz7BXTVHulmsBSa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Dec 2025 19:47:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Paulo Casaretto via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Torsten =?utf-8?Q?B=C3=B6gershausen?=
 <tboegi@web.de>,  Jeff King
 <peff@peff.net>,  "Paulo Casaretto (Shopify)"
 <paulo.casaretto@shopify.com>,  Paulo Casaretto <pcasaretto@gmail.com>
Subject: Re: [PATCH v2] lockfile: add PID file for debugging stale locks
In-Reply-To: <pull.2011.v2.git.1765997966593.gitgitgadget@gmail.com> (Paulo
	Casaretto via GitGitGadget's message of "Wed, 17 Dec 2025 18:59:26
	+0000")
References: <pull.2011.git.1764688047077.gitgitgadget@gmail.com>
	<pull.2011.v2.git.1765997966593.gitgitgadget@gmail.com>
Date: Thu, 18 Dec 2025 09:47:35 +0900
Message-ID: <xmqqbjjwzkd4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Paulo Casaretto via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The feature is controlled via core.lockfilePid configuration, which
> accepts per-component values similar to core.fsync:
>
>   - none: Disable for all components (default)
>   - all: Enable for all components
>   - index, config, refs, commit-graph, midx, shallow, gc, other:
>     Enable for specific components

As this is about lockfile, you need to decide what should happen
when an older version of Git, which is unaware of this new world
order where .git/index.pid.lock declares ".git/index is being
updated; you should not touch it!", comes to the repository.  You,
as a user of the updated Git, do want them to stop interferring with
the operation on the repository your new Git is making, and it means
you should have some way to telling them "do not touch---you do not
even understand what is in this repository!".

The established way to do so is with a repository extension.  Having
core.lockfilePid that is a plain vanilla configuration variable
would not affect Git that is not aware of the variable, but unknown
repository extension will cause setup.c::verify_repository_format()
to stop Git from making damage.  Perhaps use extensions.lockfilePID
instead?

By the way, we name multi-word configuration variables in CamelCase,
but PID (not "process identifier") is an already all-caps word, so
core.lockfilePid looks awkward.  Call it core.lockfilePID instead?
Oh, with "core.lockfilePID" -> "extensions.lockfilePID", perhaps.

