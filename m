Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3992F6168
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759937668; cv=none; b=k1588MSw4RGhQdUd3jioIntXYBTRAUy41Zq9Dg5aenkitbSt6mnydf1pEzz788iJhCEIcBA7aQ2kmCVBqJB7pxBZl1v2WixxWupL1ZCOt5SANRLXtHxIqkhGKiTiAI83E1QBGn772+lvvo1RMngfVwExUua9OmDX8MHLaHc6ybM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759937668; c=relaxed/simple;
	bh=B08AgR+9pP+MekH8PNpoazscr0eL+UXVHRxOX/ywKvY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YL9KnN015DcOaqiK2ExInYXnXkAHWqRSbjG7ZUuP5C99l+lY7cIhSkJ7q0H7zQxRtuunMEsrkBZuCXEcxdX197bjy3j08aGUYpb7+kECMI10ps3r7vT1WvcbssAarLqk+ujBelkOlnskGY1dpHTUv7IsvubjBVg/+73KP2sJkE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eLSXgMRC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cK7uygKS; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eLSXgMRC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cK7uygKS"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E55217A0026;
	Wed,  8 Oct 2025 11:34:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 08 Oct 2025 11:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759937664; x=1760024064; bh=mvBl12BeZS
	9ttCH5Bpa0CZ3xxtjdMKQ2a1/NDSxyEuI=; b=eLSXgMRCnvb21KYzoc4rcxE0X6
	EyhzKTzMzTXkQgZwDrl703x0H0o5DVtij2WlJ/W4RryCuWHCk9eDgJulpAwt7Dup
	DEccc76hF+v/CHk0/gpASRPbSWFXMQsCy7QtcpjQ8aFyo2Tu3+4svU2/JgiD3Nnt
	4tkE3yzVv7BSRZA4R5da3O+jWNdhoNlBaOEtgKvrHpLcMSh9GwIybCrxzZukuQJX
	h6A5CLnVw3wq/n3NBcxeZwZwuLr4nvqP0xFEcOqr3rtWvsH75OzNMRQhCsaiULiZ
	UZ7QWKc0pvVp9qJN5IKGMUaAAWG5Y6/NHp7EOyf4ptD/ZvLO28Pgq0HvBNXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759937664; x=1760024064; bh=mvBl12BeZS9ttCH5Bpa0CZ3xxtjdMKQ2a1/
	NDSxyEuI=; b=cK7uygKSvP5uUJgKduHYmSWoQS1Z5tgvQcNd6b500/RwScyvrZR
	h8hgJOJN5E2DTFhDZYVXIOUEPlliyvuCDL3PlV43yngAtKQG+WtVq60RHFShJPQx
	TSBhQ37LDgFuHRSCv3kvAO/YOjwcVG3U9Ru2od2ozHHpK8ai+jmw4yEXa5Jug1wI
	Zha3rJT0tfGNYhwLPrQ/APDW4OT/R/Qi1Ga6EWwLeJZzfmDPSUjRiE8rahgtu2QC
	irBgdxUuOdNx5d9OObTgcsNTgQKbDpH3yx1+/FEtvdeOX+cvs/10SJSZ53eQfyjP
	dMk6xsY+zG2ykpm8cOl0xRJH/Xwxp3XhfSg==
X-ME-Sender: <xms:gITmaFtmbYfh4EsjkKGNCivicXn9CHkvffgjYLrIvOt2TJ61K1Rp8w>
    <xme:gITmaAtbPDgKN1AsLdM1onNhoOEsmKVyr_AkbY3r9KplVqzYqAHnVc7EkOJQtxvsy
    XaeJCzEJHbEcw-kyKb32rrWAEWE-onNSsh7BkfPS2q22dNlaBPsbaY>
X-ME-Received: <xmr:gITmaLCB5o7g0UFhAQpz6sPSj3Rqc8Svde1ob2NmEFw-f9oz0DFSgp3DFJwDvWLdU-STkPhPnt0AGmIFffG9xXc7h346aFXJTUyh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsrghnug
    grlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegvrhhi
    tghsuhhnshhhihhnvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhm
    rghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnse
    hgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:gITmaCPGmK0JwN-11VHVc_jq0LCuE8dzyh3xHv3bt6DrBH4nRFt0YA>
    <xmx:gITmaEyjCHZQygEv4jbsbOjFyP9u3ghFLwhB5Nyzl6cpFIwO4QILNQ>
    <xmx:gITmaCUvwchPLR8Sf5BE1DlqubZXPqzVSKBv0_TBX2cooEC8reCPbw>
    <xmx:gITmaGOskgomFGxL7pvcmTNc2_hdbxnNG0_k8VJfP-MvRAczgG0tSg>
    <xmx:gITmaKd27I2vQsS9_jSMNTv-aGMlXHkhSmfm45xggvPBlFQgaOeCVjs2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 11:34:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Eric Sunshine
 <ericsunshine@gmail.com>,  git@vger.kernel.org,  Ezekiel Newren
 <ezekielnewren@gmail.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/6] ci: check formatting of our Rust code
In-Reply-To: <aOXsjnWBOt0qFGwc@pks.im> (Patrick Steinhardt's message of "Wed,
	8 Oct 2025 06:46:06 +0200")
References: <20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im>
	<20251007-b4-pks-ci-rust-v1-2-394502abe7ea@pks.im>
	<CAPig+cQ7xJky+F=g=NMrN6BQfP+ZV2KF4RF2eLqtULKgMTR5_g@mail.gmail.com>
	<aOWXSO5GInJI8-NZ@fruit.crustytoothpaste.net>
	<aOXsjnWBOt0qFGwc@pks.im>
Date: Wed, 08 Oct 2025 08:34:22 -0700
Message-ID: <xmqqms61h0g1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> ... but I also think we should take this
>> opportunity to choose the Rust defaults for Rust.  C, Perl, and text
>> formats like AsciiDoc do not have rigid defaults about indentation
>> style, tabs vs. spaces, and line length; Rust does.  We wouldn't use
>> tabs in Rust (the default is four spaces) because we use it everywhere
>> else, so I think we should take the opportunity to use the Rust defaults
>> here as well.
>
> I am also slightly leaning into the direction of sticking with Rust's
> default of 100 characters. It's not substantially more than 80, should
> be reasonable to accommodate for in most modern setups, and sticks with
> what the remainder of the ecosystem is doing.
>
> So for now I'll leave it at 80 characters. But I don't feel strongly
> about this, so if there is a majority in favor of 80 characters I'm
> happy to adjust.

So the question is if we want consistency across files regardless of
what language they are written in (i.e. 80-columns everywhere) or we
treat our existing rules a "fallback rules" we have adopted while
dealing with languages without their own strict rules, and use the
default for a language with its own rule (i.e. whatever rustfmt
wants is used for Rust, our own rules still apply to everything
else)?

I actually am fine with the latter myself.

If people strongly prefer, I also can be talked into adopting
slightly wider limit for our fallback rules for everything else, but
that is probably a separate discussion.  It is a bit unfriendly move
against folks with aging eyeballs like myself, though.

Thanks.

