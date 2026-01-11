Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BDD34B682
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 18:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768156897; cv=none; b=FVW5SMa26TSqqbhuAd//xPD7q7X85TBYytpc75e1791AU/AobicQlDYDIJHzxhaATssZ6u5q+qcFdtaNXngGqX0Xvnh7P8BqFj5KPxyrlsomM2gusMq93X5j5OVeoBUJR2Q2VTOMZVagsGutJMSgN1XSwa4Gr0S+E5MMoc4NaU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768156897; c=relaxed/simple;
	bh=GeT/leIoSbgtXXQsuCFgJTxUcRurGys/ft8AZw9bs1I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z314BjNVOTWIJCtdoflKDMQPW+QIu+G0ie2Y639K4eIARpPDaPy3/Uw1MX+ZId1q0AM7EW1Nnli6r3dQkT3w5OTAA1xNZRIWkciuZBGrT3X9pdMpF5fqogqqJSx7ucioiBM+Q9wFZSsv/iS+5YTQY6UJ4L13P8Mpz3RRBhSC//4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Sfw7XFQE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0e2Kdn3r; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Sfw7XFQE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0e2Kdn3r"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 6A5F6EC0087;
	Sun, 11 Jan 2026 13:41:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sun, 11 Jan 2026 13:41:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768156894; x=1768243294; bh=GeT/leIoSb
	gtXXQsuCFgJTxUcRurGys/ft8AZw9bs1I=; b=Sfw7XFQEVszPOBCT3HFYp7F7+d
	RGbuAlf6oe8bX2/PXYmArah4yRh6YrSBUKvsQYhuw2oES5Rv6bZJSC/P89DsadNs
	zhtS093Q7QKzS+gQJkNk7jg+wTUSDmHobxxhg41lyvTmuWmhzqt0fTmUlhbR6AbY
	CngXnOiB0RtNt3gdHKv2LM9oyMQkvD+dQgpszcFCCABlMAgyZIGcUVS5T8GOUwuu
	+ZwTAod0sjG8Gv+cfw8VErgbOxW8RCIn0cWH+wXvoqDywHW9NVfiLA/pJXqEf0h4
	NwIN+Of+2aoyuS7TOLL8lQyRt+r8G/buYa7ZLNlePDT1X2b0WyYoD44EI7qQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768156894; x=1768243294; bh=GeT/leIoSbgtXXQsuCFgJTxUcRurGys/ft8
	AZw9bs1I=; b=0e2Kdn3rJMjmiXjZnoo8He7+vg1tFK8j9UW/sJNDLRLNyRe09F3
	5cL2wSBzw5xDktWM3nk2vQGS6lmWW8QJ9+wSRAhjyjitTUxBUQieFYxY1R3WrSTf
	IsU5g6nPqUy3wmq1eeO7XRZxMuVUUju2l4Vfxt/VJzMVA7eQCITEq9kVFAI3eh05
	b9Ze5aEYFgZ0hS4wlFEWQ7j5VetXNCrcsxAtQzWb27cxL6a46X46TV273t7Fu4QO
	WtnXpOSnNg+9jM3ZezhY7DdZa8ECU9pS/yXxFK5+HofSOBDma9pth5OX9aeswbAA
	NhsctXvFJM4Yn4ilSGahENFvyEahhYez9Rg==
X-ME-Sender: <xms:3u5jaTvVIpN_7q-tjwNQvXbvFIBwrvianJPeSpQr9f_I6goH2dNqyA>
    <xme:3u5jab7DnV88U27vIccpCYF2U00E0qCnHjDHnB_FPPQqaS3RapNGBfi4ENbZOPX73
    GsGOX9565SDnZ3VaUWq8QQIBShyP2xKByHhfoIAEkgZ2t60dg1MQQ>
X-ME-Received: <xmr:3u5jaUIUr99sCg8UVWIo1S6ZPCt5xxS6TliVSRLbW9PAMWrq7XF2gPWtHp4QO_lg-Fdts9-vSHtWy9sMyW_vupag4l3NWHZm9pt61oE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudehfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhushhhkhgrrhhkuhhmrghrshhinhhghhduleejtd
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:3u5jab5vYVvnZeW8JkZQ4jo-stg_cRtgT8BIqi-jIr2aWH3FHB4yfA>
    <xmx:3u5jaXzDaqRbY4zKT71Wsth2_WO-9XvfIuy1Yo1gpXrrrAu1dN0YPQ>
    <xmx:3u5jafYk-LX8vpmPhREcWQ3LaEv20bwkfsd5vg_EGXHMXIoLqeMGUQ>
    <xmx:3u5jaZTKd0AQC6n2gCTxUpxVmRzRpIoof5_Uoq4-6tqLR8w3pn1I3A>
    <xmx:3u5jaUyv7Lhmtch5b1ZkcXnm25_YNPI96euWD7ZWdFDJ-D_3cX2-WOxs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 11 Jan 2026 13:41:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t1410: check files and missing paths after reflog rewind
In-Reply-To: <20260111140417.36274-1-pushkarkumarsingh1970@gmail.com> (Pushkar
	Singh's message of "Sun, 11 Jan 2026 14:03:27 +0000")
References: <20260111140417.36274-1-pushkarkumarsingh1970@gmail.com>
Date: Sun, 11 Jan 2026 10:41:32 -0800
Message-ID: <xmqqh5ssouub.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pushkar Singh <pushkarkumarsingh1970@gmail.com> writes:

> Subject: [PATCH] t1410: check files and missing paths after reflog rewind

That sounds as if the original did not check these things after
"reflog rewind" and this patch is about correcting it, doesn't it?

That is a bit different from what is really happening in this patch.

> Replace raw `test -f` and `! test -f` checks in the rewind test with
> `test_path_is_file` and `test_path_is_missing`. This provides clearer
> failure diagnostics and keeps the test consistent with the rest of
> the test suite.

On the other hand, this describes what the patch does nicely.

