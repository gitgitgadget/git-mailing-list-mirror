Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF222ECE93
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 00:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773276723; cv=none; b=P09F+Sr+pbmiZqz2cTbceHMkRTIKkAuAyqb5Dgnxmk2QBGr095Pu0TnEQIXrqN/mDv3LxLWZ3SM+pay1mUY6rls7/dzEemFZR2+aFmqiNMyRSwo2X0GIUSixnf0onaWBcTdPTT5dbSp290Yd+X/pV70h4pSZyXEzw+AXn5AmEQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773276723; c=relaxed/simple;
	bh=RwTGk+7tCw2vcbaxXhuMw9SHWxc8Th+7VrfUsVflfC0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e+yFPl4DOGPSLP85qIv6ItpZ0HDM0ziuHFY9ubXncGcwxs4o4Dang14VqqwSEBqSGdwZigKdKQ7sZfK9GgqgvuGNGjcH/GcDEmHcLpioRE+cXY3BtlZiz2ImPiLIjDkqPxa2Df7WuEr5oKmzMpGl4f5wtVb372EyPy1rvOB2rZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=O978h2Pn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dVMD0MrC; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="O978h2Pn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dVMD0MrC"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 94B4F7A018A;
	Wed, 11 Mar 2026 20:52:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Wed, 11 Mar 2026 20:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773276721; x=1773363121; bh=DcUheeEZlt
	Evw7nKBVbYR9p+nSVJRGLtee9/5uV1+7o=; b=O978h2PndfOK9l5uPJKOkCwRhs
	mSu5oCuSxXmpCulH3C1W2R6PeUR+RzdpWBBezfxRqCzRMwMp2miNhRLNILpKxxfG
	Z/t5kOyv6XhKfkH4y6EHXhhr8W6f5OuUF3JF1T9CxvJTgtlp90YlWNuXq+pUrfQM
	pCrCUuQSUMShCZr4hea4l1rempuG3ybYNWahMVD+eVe2XLMbV8jv9ls1WqRlFBLE
	PiOQx7Z9c1pjwWO3HIKlQ63tUI8b7CIK9jjEpmDG/zZDD//9T4DueNhKad7lZlaH
	y7T1JTX3SfdsPSO61OK97MaNQYAMjldRtZodQZMic5d0upmIiE1IIwGfBESg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773276721; x=1773363121; bh=DcUheeEZltEvw7nKBVbYR9p+nSVJRGLtee9
	/5uV1+7o=; b=dVMD0MrCwSvAY4/QiXAWvpl/rNNqg94xpz/8EKwpIYzc5SbzfTd
	pKDSgbcYUswT+0O3VH9fXkJlKYqMSZ9HBT9MGTUI98FM6CsunWYJAJOmsF71ZDB5
	LGvN5smAOwACjt7WAZy7GrU5CgmaMzvxiGdEr9DFUaM3CFZN3uzoS0gNlZoWr5xM
	mICN9R3UqGg96HlptgS2cDUWd3NFIop3WLyZDaDmERZXecns0m+4bTZHx/O7NOME
	7+gOiHNvtktN98tJ0fY5V/AAzMJnV1gP5CR2DkxwnBCgWXJD1gytZyX0hEehdrQ0
	5/opMU3uZoUsi/ZlkAwuQE6PDnIH/BqCTww==
X-ME-Sender: <xms:MQ6yaaVswVpwo9HFrfFDg0UOhJ2biOb-pV65fW5hDCQ8FGGXKu-vpA>
    <xme:MQ6yaddmQMXTe2O8oAsPjQqAXM3l8RGTS_tipt09knLBUMwH-6fVP28dbuDUEdlbs
    SvvjurVZxfyYj1yMye75svdjqHQ6YbCnm4Do8TjZvy1mc5S03zKrA>
X-ME-Received: <xmr:MQ6yaWuGF7yjXszrEdYEEatrUoX9Phgp58O6T0IoEUeFzkcY_nGLZlugB3L-AgVA07bbldeo1YLEG9gaTR9X3EsLeHZsJiWDGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeehfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtph
    htthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:MQ6yac-HDXMrc6YI2-Kzux-SSsjOpfuKtCPNb2xIrv2TByFHgn_Lrg>
    <xmx:MQ6yaR2KsA590zlNBuaTXqNFU07YR0sODezxnYmKaQzyMhtJ-O24og>
    <xmx:MQ6yaRA2-VlxS7UaFfFL8OMRcaJaGQr-wXwK9inJFppPeYgXRYNqaA>
    <xmx:MQ6yadesp0LoAEc3vTG3Yin78eVnDIifipA5OwKJbbgppF9tv0ydEw>
    <xmx:MQ6yaaIoK8HnF_pO3Dz9suIknVBqvLRlc5m2iNQS6B5e8P7ieLO-XcYt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 20:52:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH 0/3] doc: interpret-trailers: convert to synopsis and
 update options
In-Reply-To: <CV_doc_interpret-tr_synopsis.48a@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Wed, 11 Mar 2026
	23:31:03 +0100")
References: <CV_doc_interpret-tr_synopsis.48a@msgid.xyz>
Date: Wed, 11 Mar 2026 17:51:59 -0700
Message-ID: <xmqqy0jxkgy8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Topic name: doc-interpret-trailers-1
>
> Topic summary: Convert to synopsis style and update options.
>
> [3/1] doc: interpret-trailers: convert to synopsis style
> [3/2] doc: interpret-trailers: normalize and fill out options
> [3/3] doc: config: convert trailers section to synopsis style

Somebody swapped %(count) and %(total)?


>  Documentation/config/trailer.adoc         | 121 +++++++--------
>  Documentation/git-interpret-trailers.adoc | 170 ++++++++++++----------
>  2 files changed, 156 insertions(+), 135 deletions(-)
>
>
> base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
