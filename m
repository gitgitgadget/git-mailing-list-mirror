Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E1D13A244
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 03:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767758184; cv=none; b=ZYLMDIfZ204mgVlACaYMTL2iMDoa4xftxuTAP0/N0T3NFcH5cJiY0578051BBMzESPxu89TxSfYMqV4/ycLNJFyV3MvH/gFmNu+5ArgxSP+9HrmTyS0MYo95JhzudCHiT/GzV1WOYj8Ee+VrvE7lTTfR7iAfVrbMMm6xXeJKfvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767758184; c=relaxed/simple;
	bh=vg+DfGRqSq8JZrKx73WZa/RQZyrMSNANBWzSXMie7bE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cSUfyzl2jf8MHCs06AKNiEPIlqm1RvwuoH3dmXEtiBoShGceSA9jclMSllyIMzx4/4OYQEybMojFUUNAUN6fGoizr+6RJOJUMErqMX2iu6ptfcZrAHLptzROS2CuEqSGcn0g9zKOUpzSiq8igKwgUTnVWK7WXPuUoUMcLgwcB9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qcFsIxX8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=y00UfD5b; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qcFsIxX8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="y00UfD5b"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9BE977A008A;
	Tue,  6 Jan 2026 22:56:21 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 06 Jan 2026 22:56:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1767758181;
	 x=1767844581; bh=LA9UgEKq5TJplCnN1K4cGvtLwayMqx19CE4QJ+qO9Ag=; b=
	qcFsIxX8vI2Wux+rFPFmt+zk7ncOk2d198TE0meFgaHSn85IqT1TJjjDgQDl9BgL
	paFlNsrgeC+dMMgEQt6fWugEyXySukra42lBsYjABNTLKBDtz3Qo83FN8LYwCWB5
	jKT01Ue58n1K317bbR96LrWwIia4dRIxrrM6TmwriITt2SdlaOJhgJU4tBcgDprZ
	p4NqsVYy5kBcGoFKUcJC+R5Wz8W2wVhrBwzCgSK4vzaNGWLL4/cLvYtN/R+4+1dc
	A+ieJsjJdbrFoDMci2fDHigRItfYclOyDHThpRIZBrGm2I1KbrhrsWnNej7DdIu0
	6qD741PlKB2aqcMHx2kS/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767758181; x=
	1767844581; bh=LA9UgEKq5TJplCnN1K4cGvtLwayMqx19CE4QJ+qO9Ag=; b=y
	00UfD5b7aUPxHBY9fUZZ8hVva4Tw0uViMvz0sphP3160asDA9TVDLgB7lc6M6nLS
	0J3pqDhkLRmaQGofXHlmk3UE980WTcaSt8+BxfgymjJkXGi0Kfw9LiW3PgibZKCB
	JU3oBdKlqJ4LRVUdMkD1iukNoSO6v8UH3kcVIGJJ+S4oj+RkGk4Rd9pXgBjHkXS9
	LjY/UofmnhGSfI1/hqpuQWQPdAsamboBcUQyJXhgweheT8JRcLNaQanbYxQyvqDe
	89CaJlxlAE1Z8qfg7WJZKmyWqzJzMLzaNpIqfIPyQtvmRRtedaMyQOHls06Lk2Hd
	oVXyGCikY9fDwU7MKJqlA==
X-ME-Sender: <xms:ZdldabOmWeFMi-9rS-t1V5MmHmRBDKWrl15-BATz-d5w5_hK8z12ow>
    <xme:Zdldaf_p3dqWfEB3Js28gyRZTVtfm9aqAUDyfO3KXymwK3oFFjIfNiGSdS9U3gyaV
    kId7vg4lDrxd6VJ_XVvIwDeFh5y4KcnhQguyJsaZgrSOS77vgdlqw>
X-ME-Received: <xmr:ZdldaQ5KCpJ1mLtjn-ZQ6tyUN_IgsR3G6TeR6Sq9G2A5rkQRiJmCe0Wu-ylmTWgKr5YOR4CnxIKlfXCvu-QR68chkZNdei_ACw5ng8E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddvtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtoheptghhrhhishht
    ihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhiugguhhgrrh
    hthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhi
    phdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:Zdldad4ZirbtHpdQDnMh-BRCmHp6gvG9lBaO9ArlhktYEU_5PvcbBQ>
    <xmx:ZdldaRrIdatWRAQWlrQvJvBMBhC2OklOzgqRhcgJLxi4IJ_lRdR7MA>
    <xmx:ZdldaWNvmQkYRmAZecL_ONu4CbALmwXCJ8hDDJS3Cv5R9gHBHiJYpQ>
    <xmx:ZdldaR00yQDZ6J0-SXgpJt9ndPIAQeQengMOGEgV_cSNtaCXTEsDCg>
    <xmx:ZdldacQGwLrR2hPGYdoQy80PPA1YWhwRhK4U7CPOq0UJKW05LITdoJES>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 22:56:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: kristofferhaugsbakk@fastmail.com,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <code@khaugsbakk.name>,  christian.couder@gmail.com,  Siddharth
 Asthana <siddharthasthana31@gmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 0/6] replay: die descriptively when invalid commit-ish
In-Reply-To: <CABPp-BGFNyKkpcWWksqvNqyXspMqfywbYyyhuSUaL41YHNHoNg@mail.gmail.com>
	(Elijah Newren's message of "Tue, 6 Jan 2026 15:12:09 -0800")
References: <V2_CV_replay_die_descr.17b@msgid.xyz>
	<V3_CV_replay_die_descr.1a4@msgid.xyz>
	<CABPp-BGFNyKkpcWWksqvNqyXspMqfywbYyyhuSUaL41YHNHoNg@mail.gmail.com>
Date: Wed, 07 Jan 2026 12:56:19 +0900
Message-ID: <xmqqbjj6hy8s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Elijah Newren <newren@gmail.com> writes:

> On Mon, Jan 5, 2026 at 11:53 AM <kristofferhaugsbakk@fastmail.com> wrote:
>>
> [...]
>> § Changes in v3
>>
>> Apply review feedback from Elijah. See patches for details.
>>
>> • Patch 1: More terse function name
>> • Patch 2: Improve commit message
>> • Patch 3: Improve commit message: fix outdated function name mention
>> • Patch 4: [new] Apply code comment/error message tweaks
>
> This round looks good to me; thanks!

Thanks, both.  Let's mark it for 'next'.
