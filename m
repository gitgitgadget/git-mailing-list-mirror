Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011CF30C34E
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 17:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758735800; cv=none; b=ereHsj3uVZD51i0sF/3Gu3t/xpsW4UFJdsdJiaMrBt8JZ08Tnabk6vPWbVn5cIlbaCvRG02vOvAJljodmUXI8S1a3XBf74hddqPqOjek2Tyn0JXzEK/fvTLX7hHMhnPx5o7B2Liu/VCUVaBRzaMw2LSU/0b4IJ7ZzTHBtsM7KV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758735800; c=relaxed/simple;
	bh=8QQLs6MI8UEu9QqXzvHBuSudGataMxiKnoBq6ikegIE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=crm1CMLOYrQ5/0+W+qQgis/QZWQeFjm2LKsDU2ABpEhWovRt9P4xl8pS6PimdtWCMMRlX1pWmYyO4T2hOdz5qXe3WQ/DxuM48t0Ua933GZ8YWGZbJaNrAgqXEoyCQUSxBoYhp4KKneCTw2SYmhuqCUM/Hjan55doi5td7csjF/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=D788LRCq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jJvxJqkB; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="D788LRCq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jJvxJqkB"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 17D99EC00B6;
	Wed, 24 Sep 2025 13:43:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 24 Sep 2025 13:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758735797; x=1758822197; bh=FBC1FJ0YaV
	Rw3Vqaf9PYtauEldtEtNoXt3sgZCebgQU=; b=D788LRCqtBvxI7qLzKsbB4CHtt
	g1Z93gsthFmdGZMfP+A/UNGVF6tPQA7OMqceFHHV0Yr9vqfJBEihtxl0HnDeI0U3
	QemQ4sN2quJyJROaECUJ6sJJkdcOpGZygJvd1BKXVMkpJI9y0VzDe3qWvmzjsRLq
	0mjpFkBkJ1083IHVr6jFUiMLoFadFgGMAMpJ3GzbBta7GGvgvCrThkfIGCwowudl
	AFkS5HquQISVoEaljBvP0XgHrX8IYAm7ccRU1Uf5JlnrFQ4VM4bY838Uup2uqD+a
	5vH3Jf7qhLJlJd5wfCfJsMj0clxLqNaDGIhKELVKeQWoJaIvcZnUne2Pk/3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758735797; x=1758822197; bh=FBC1FJ0YaVRw3Vqaf9PYtauEldtEtNoXt3s
	gZCebgQU=; b=jJvxJqkBvYCpL3XEoyuMoHnf0rqOKXZo7/6c63qg8/C2cULSbf6
	ucUew+C2/GgFDYt4/MIXWL4AvuiSqOZBUfvHEf12NQjCo0PWj5kj6UF85EP04fbv
	uhk9kEpLG7Pz8ngiCyjqbDydZiUNwMdLKCRMVBm+ROlZc+enI0OsaynuY3x5PzDT
	lE5WINRxkIke6GQeUvd7PcQMY5vC2zTVGi1hyS/9mPMcteynDvu0JdnwzBJXdiLp
	mz5nI0Xf1jcb8jQKD9GYrbhwQGgHGSAVM9KLUZswO9D/HPbR264C7wfY+v/eogoH
	IUNBA6JIaxKfy9IXI3MFBOMyZevpXnGepMQ==
X-ME-Sender: <xms:tC3UaMqgSHg1P0OMGCMxAtEvGTE-DjF6nG5bFqMbxCIJrCtbOsz-0g>
    <xme:tC3UaDFlRBFayzhnDAawHnpj-LQUwpDZIW_JUONmBH-QjbZ_NCgMsBR6NscK_ADE2
    1Fsvfv5ni7u_j6DWo6KJpGM9rklm183Ck9Zid0_ESgsE8_Qx3MW0A>
X-ME-Received: <xmr:tC3UaA-MGPUmrNgjNRyJfmXyHLIBCFVGYBL2oqfYGT4px5nDQSIKCiEA6KYzenrLJOM2S8KhC3yYKeG1Ip9BT1U6bSXrrzarMVen>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhtrggttheshhgrtghk
    thhivhhishdrmhgvpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthh
    hprghsthgvrdhnvghtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheptggssedvheeisghithdrohhrghdprhgtphhtthhopegtohhllh
    hinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtthhopegvshgthhifrghrthii
    sehgvghnthhoohdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:tC3UaATsrt_c3aSDh_CAH2mJT3noEzBvx9lLNcDdrI8juVx1obeK_w>
    <xmx:tC3UaFog4Yt3DdsGlpSyWSJwzSDZWVb_vpOUlmw69C6EDUFNWQmKng>
    <xmx:tC3UaNMBl2T0sSzEh4az-bRTrYt63SQiDfugpWx6JwaNFFXPpRv2CA>
    <xmx:tC3UaLzgxDx_Nta7z9ZXb3psP08FBqruNB6Ay71KbNU_zZz-mVdSYQ>
    <xmx:tS3UaL0te2FVLPsMjqmwXJCBXylsNPfep-XCICW5HrQHB1YwifPZjPyu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 13:43:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "Haelwenn (lanodan) Monnier"
 <contact@hacktivis.me>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Ben Knoble <ben.knoble@gmail.com>,
  Christian Brabandt <cb@256bit.org>,  Collin Funk
 <collin.funk1@gmail.com>,  Eli Schwartz <eschwartz@gentoo.org>,  Elijah
 Newren <newren@gmail.com>,  Ezekiel Newren <ezekielnewren@gmail.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Pierre-Emmanuel Patry
 <pierre-emmanuel.patry@embecosm.com>,  Sam James <sam@gentoo.org>,  Taylor
 Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v4 7/9] BreakingChanges: announce Rust becoming
 mandatory
In-Reply-To: <aNPp5jA5k_nDNmyd@pks.im> (Patrick Steinhardt's message of "Wed,
	24 Sep 2025 14:53:58 +0200")
References: <20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im>
	<20250910-b4-pks-rust-breaking-change-v4-7-4a63fc69278d@pks.im>
	<xmqqldmmqa1z.fsf@gitster.g> <aMfwGHL7dh8dk2cQ@pks.im>
	<xmqqsegev4jp.fsf@gitster.g> <aNIw23JzQE1vz2JD@pks.im>
	<xmqqqzvxp7ej.fsf@gitster.g> <aNPp5jA5k_nDNmyd@pks.im>
Date: Wed, 24 Sep 2025 10:43:14 -0700
Message-ID: <xmqqms6jlpal.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> So maybe it's premature at the current point in time to already spell
> out details. Should we maybe just defer that decision into the future?
> E.g. something like the below patch.
>
> Patrick
>
> diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
> index 3b54750621..bf3173013d 100644
> --- a/Documentation/BreakingChanges.adoc
> +++ b/Documentation/BreakingChanges.adoc
> @@ -200,9 +200,9 @@ The Git project will declare the last version before Git 3.0 to be a long-term
>  support release. This long-term release will receive important bug fixes for at
>  least four release cycles and security fixes for six release cycles. The Git
>  project will hand over maintainership of the long-term release to distributors
> -in case they need to extend the life of that long-term release even further. In
> -that case, the backporting process will be handled by these distributors, but
> -the long-term release tags will be created in the canonical Git repository.
> +in case they need to extend the life of that long-term release even further.
> +Details of how this long-term release will be handed over to the community will
> +be decided once the Git project decides to stop officially supporting it.
>  +
>  We will evaluate the impact on downstream distributions before making Rust
>  mandatory in Git 3.0. If we see that the impact on downstream distributions

Yup, punting on this would not hurt our overall timeline, so let's
achieve concensus on other parts of the document and the patches.

Thanks.
