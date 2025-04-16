Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217B0224235
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 18:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744829448; cv=none; b=AoQ/ijrfSP/E4jkjipdvOM2CfoZX20E7w6XbYGgjwXovWSpp1yi/aJ595cwKblrGwMlnig9CclhFiV0s16bHLCa2wxzDP5QA3m/l+L9SH2hhsqEvac2HrvY1FBNVnwr6TGgzSv0SNhUFe/KS7frViifn+jksP7Aurd1JmJGSQX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744829448; c=relaxed/simple;
	bh=hbDRGijf3hVrBZ2R9KTssWLfqhX/xNj5wfLVpM7jeww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kDLd7GeYC9HkIfMYiz7kx4FEzpSdtceV+9in3Xq42n/iUWLhEcVpsmQW7YCt+jpK1m8F+kZcMeZlkiwtRSzCN3MqnjjWoAAKq4xHiDqT2WXr0r63F2j5MDLZFcnTEweOu1KWi9HfcD2T0al+wpPeeq1uLOdseIWnJcSdXEOmVwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AUmha3ny; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bs2JjO3u; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AUmha3ny";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bs2JjO3u"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E1C0A25402FD;
	Wed, 16 Apr 2025 14:50:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 16 Apr 2025 14:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744829444; x=1744915844; bh=XE3Ppv3IEG
	wVhAXW2lqTQ2UeXt22oj4PfFQS39dbN8g=; b=AUmha3nybiepHcdGqlTMmzr+GY
	/VZqBKkSXIcET/ehYRqkG0Cs3LoVe5xMBCsELy9uh4Njq/rDZfGh1TfiufiLfJfL
	hg3jz2+Xq5penfivUxwlzEPeymdllFifM81xzqSsE9vFAZeOjAFJhaVYn9HpScjg
	WmaYXf1XDG3vtP7aVIzg6ENyRLMHaPV8kfHdkjs1+z+LG+SJhq0VAUfmtGGlcAVL
	r4e0W6xQWqdROldnUOgtjjqlC4278hLCaGVmaW1GwPkf+ImQUfqKEVnFGlbU8N0b
	GUnvMDNabmV9KHTZSLJkgqAgbOoIhLdDUQrJUfdrmDmuMsehVJqaz85KwwEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744829444; x=1744915844; bh=XE3Ppv3IEGwVhAXW2lqTQ2UeXt22oj4PfFQ
	S39dbN8g=; b=Bs2JjO3uaKMxW4yzUGClZgibVrGW9L5T2o2SqBdfXbERSrSP1l1
	ACeK4L6jZ+Fja/56g60fpgnn9jTdsj8fZnjWepCmzhFVMENwi2lwAuaHzJ7flxym
	ZxzxyV4H6UEKOTv0Zgm3qu45P+qXu1kKD1L7of/c9tfTmI3ilZeK3C6dA5d3S0xz
	uxwWYDrKoSduVFtoaE4ZQP2RuZRc3loUD35Uofnz/QDuHLY+C27wIWvzp8F2fKyb
	vkzvEOHg4EGhYzH3RgZkOmoyKjbgiF8tHwMsgMhgHL34zdWsa903/ZWC0Mreb47z
	ImaPFbA1KrnBSmiVPy0TwxeBFiOsEMkQaXA==
X-ME-Sender: <xms:BPz_ZwbiR4QCsBqidTOfisbcgr3UBxIRihypYSaqD8iHSqHd_RkoaQ>
    <xme:BPz_Z7a8KsGYRxhLgYJ4uOUcn5UQHgsakmqR6iBxVA-TopvhOSFBF6twCXKeFB4dM
    wM4z6ZxWsLvX9Lcdw>
X-ME-Received: <xmr:BPz_Z6815mfuQQLufOEc98s92Yfh34ZJhV2RHX-_SBeLY5F2Fj65asX6n52BQZn6JJgvWxqpG49HDV7QCLmuFhMbjlxU35u7ofDr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdejudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhksh
    drihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehglhgruhgsihhtiiesphhhhihsihhkrdhfuhdqsggvrhhlihhnrdguvgdprhgtph
    htthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtoheplhdrshdrrhesfigvsgdr
    uggvpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhm
X-ME-Proxy: <xmx:BPz_Z6qBd5UpJs8ht0_CrwyG1JavvBTO-Oen_ywBbjMVK40jhqAf1w>
    <xmx:BPz_Z7q1XDMYwEMr6_CYcVD0DaGtlVg43Z6BV3BVzOy_0lltLJjaAQ>
    <xmx:BPz_Z4QYHX6r4_I2IIdRCtpKpSoQKHFoV9Rh8WmkD8jXFWUUXY8Q_g>
    <xmx:BPz_Z7qZt1q5XGFm8mzlmvs5mxo5pB2fm9P_uMqguz2YWf8t_zan1A>
    <xmx:BPz_ZwpFuA1raR1tPi-NsK3nUnX0Zzgl5CB3lzXzSJVNEAFXlffSvWHv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 14:50:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>,  Todd Zullinger <tmz@pobox.com>,
  =?utf-8?Q?Ren=C3=A9?=
 Scharfe <l.s.r@web.de>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,  Derrick
 Stolee <stolee@gmail.com>,  Jeff King <peff@peff.net>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 5/7] parse-options: introduce `OPTION_UNSIGNED`
In-Reply-To: <20250416-b4-pks-parse-options-integers-v3-5-d390746bea79@pks.im>
	(Patrick Steinhardt's message of "Wed, 16 Apr 2025 12:02:14 +0200")
References: <20250416-b4-pks-parse-options-integers-v3-0-d390746bea79@pks.im>
	<20250416-b4-pks-parse-options-integers-v3-5-d390746bea79@pks.im>
Date: Wed, 16 Apr 2025 11:50:42 -0700
Message-ID: <xmqqwmbkgcu5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> We have two generic ways to parse integers in the "parse-options"
> subsystem:
>
>   - `OPTION_INTEGER` parses a signed integer.
>
>   - `OPTION_MAGNITUDE` parses an unsigned integer, but it also
>     interprets suffixes like "k" or "g".
>
> Notably missing is a middle ground that parses unsigned integers without
> interpreting suffixes. Introduce a new `OPTION_UNSIGNED` option type to
> plug this gap. This option type will be used in subsequent commits.

This takes a turn in a bit unexpected direction.  Because the way to
spell a scaled quantity is unambiguous in the sense that anything
that used to be parsed with OPT_INTEGER() couldn't have had anything
but "^-?[0-9]+$", an obvious alternative is to teach OPTION_INTEGER
to always allow the scaling suffix if the user wants to use one,
without adding a new "only numbers but this one does not even allow
a sign" variant.

Seriously, are there good candidates for an option where we want to
absolutely refuse to take scaling suffix and insist only on a bare
number?
