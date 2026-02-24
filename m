Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B17377541
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 10:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771928859; cv=none; b=ZVFb14nW+MmT0IwLVpWXa/x5IiziG5pEcQML7AcbTDhx7SOez1VDe383bl7m6SPzawWcgCEL7a1WG9VVPwfDhlPgfB7AAYLcAqov92M2E76nRa5tU3QIw7FZOo9uAsPTuzgfGQJRBGA6HOQXxwyKE6Doy17xqaC2f17IghA/rTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771928859; c=relaxed/simple;
	bh=kQalDDrj+r8EnlCyE0Zb+4JbuMU9aFYJC4+ADEBgko8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMbx3tSzDHSKzp+24HfJ6X95ck16Cf7pPvjVptLJelaT5g/Rp9d0dVCtkW3TFqJWEq0D9H6LZh5tq8iw9ICfPByh/NyGTSGUOzY1tBOLaTXGCzxdXhgHcPRPAmuKDSZLi8/zfMd1ZsTOOqh1IgAr0KcVq93sq81cgjHaL0JMNC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BBBez3pr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MsDOJxv3; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BBBez3pr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MsDOJxv3"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 73E0AEC04F2;
	Tue, 24 Feb 2026 05:27:37 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 24 Feb 2026 05:27:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771928857;
	 x=1772015257; bh=ZteebkQVnDq9BesiukjqrhLgQ/L6gOWbT9vQgdkw/qw=; b=
	BBBez3prdbEtmaCaFw2fp2St8s6OrWfmK+QJWovELmRJyXGGjcoYLLMYWVpnNgvE
	MYr3fLuGxOO5XhE8XVAfZBfEvq3FZPApFTW3U2DS4kZ1j6jg32a3n9BoE2KgJH4y
	8hCgmKMraSESZE4S0KqRASciBNrBxo67Uhc4smFTgVmTbu8wOkQdoJFyWKTOvsMq
	0kSz1rMCqCw6ejoS1XEqJUrga+anUPWTXnUFicCY1VTYZCy/EyJLkZuwcz13BEwk
	Noe1xI5wo0OdiYya8N2BYFoRP1aj+Wg1Y3UGCveTWeO26G+551k/yzjWMLkLDYbJ
	C/sXMr+pO/m6am4hR14z0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771928857; x=
	1772015257; bh=ZteebkQVnDq9BesiukjqrhLgQ/L6gOWbT9vQgdkw/qw=; b=M
	sDOJxv3FTKuVhi9R025KpAGmOqabThEaaPNzVthNr9rxrPFdlHtlpaP2Xv/M7HPb
	PiJ+85O3tUdjmkupuydsDskUgH+VFcj2R8/+RMk5wAmLJueYhuglnmfiOtQnjuy0
	O7Zf1pPC6AZSLHR72IKfydxCl2izDYXysbUexN99WjP3XdSCP/OChx9S3W/xCASk
	lgymqTTdAMEcDKtRjqdu37QBtKtnncICPguvq+gIYtEtN3EZ22+2velVWeqiuaOy
	5PIRMyhRC/VmbTvwk0LzYhMJPljyLBZO8FKIWATDcu/cxj9nXFTpWPIpUkBS0XYz
	rrBUr/BuO3vfFQlaXFIgg==
X-ME-Sender: <xms:GX2daYIrwV7KAr4Gixi4tcFexsg-kbBw6cCEVcT4sW29tyelRVcFHw>
    <xme:GX2daaZW_Luwr3PW1YMz3TzmxhzTfu24rMs_UPb9JGiiH4S_Grm7wBZb2UeZ_f0a3
    2Lptbz8v8-di47bkCR3BFeRkQw0RwiSuixZVNtzoJGtNj6kd-iR_A>
X-ME-Received: <xmr:GX2daa_klYBq3V8MPo9O2BN4wDxLVRiWB2W8OdzWZjJw8rDIFav2TebUDqowq8YEOD6R6T7eVzgxuCaVHluCsCFxNmSUWdsDcfL_RyHi81aPlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeelledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeelkeeikeejueejkeehhfehgeevvdffheeiieehgfekueekvdfhkedvjeevveetuden
    ucffohhmrghinhepghhithhhuhgsrdgtohhmpdhshhgvrghrshdrshhhnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdp
    nhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnh
    hknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhu
    shhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehjohhnrghtrghnsehjoh
    hnthgvshdrphgrghgvpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:GX2dabYGS434YuQyVCZHobqqDXcVZ353JnVR1zWh8spcIkCYduAaUA>
    <xmx:GX2daeMzdtxsF4x65pYV9a-z5KKI6XbA48qbmiNvKFdeUXbJAn7ebQ>
    <xmx:GX2daXBpgxKnKEXqYK29wgcxbRS41u6Xv31Rzn91cc06gs1b0WvA9w>
    <xmx:GX2daVLgyLmqL-IO68_kbdl9VzyNfIkKbJbKghhhwkeknycRR7eeng>
    <xmx:GX2daTmzs1sss_i2Fp-V1SQDQVjczPg3T8zAldk1bW8totRuy8UILT5K>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 05:27:36 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 48f609d4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Feb 2026 10:27:34 +0000 (UTC)
Date: Tue, 24 Feb 2026 11:27:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jonatan Holmgren <jonatan@jontes.page>
Cc: git@vger.kernel.org, peff@peff.net, gitster@pobox.com,
	"D . Ben Knoble" <benknoble@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 2/2] alias: support non-alphanumeric names via
 subsection syntax
Message-ID: <aZ19E2Bs0iIt2TN2@pks.im>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260210183110.1151072-1-jonatan@jontes.page>
 <20260210183110.1151072-3-jonatan@jontes.page>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260210183110.1151072-3-jonatan@jontes.page>

On Tue, Feb 10, 2026 at 07:31:10PM +0100, Jonatan Holmgren wrote:
> Git alias names are limited to alphanumeric characters and dashes
> because config variable names are validated by iskeychar(). This
> prevents non-English speakers from creating aliases in their native
> languages.
> 
> Add support for arbitrary alias names by using config subsections:
> 
>     [alias "förgrena"]
>         command = branch
> 
> The subsection name is matched as-is (case-sensitive byte comparison),
> while the existing definition without a subsection (e.g.,
> "[alias] co = checkout") remains case-insensitive for backward
> compatibility. This uses existing config infrastructure since
> subsections already support arbitrary bytes, and avoids introducing
> Unicode normalization.
> 
> Also teach the help subsystem about the new syntax so that "git help
> -a" properly lists subsection aliases and the autocorrect feature can
> suggest them. Use utf8_strwidth() instead of strlen() for column
> alignment so that non-alphanumeric alias names display correctly.

This patch has caused a regression in a somewhat esoteric use case.
Before this patch, you could do the following:

    $ git config set "alias..foobar" "!echo barfoo"
    $ git .foobar
    barfoo

Or, phrased as a test case:

    diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
    index a13d2be8ca..dca50e87e2 100755
    --- a/t/t0014-alias.sh
    +++ b/t/t0014-alias.sh
    @@ -4,6 +4,13 @@ test_description='git command aliasing'

     . ./test-lib.sh

    +test_expect_success 'alias with leading dot' '
    +	test_config_global alias..something "!echo foobar" &&
    +	git .something >actual &&
    +	echo foobar >expect &&
    +	test_cmp expect actual
    +'
    +
     test_expect_success 'nested aliases - internal execution' '
     	git config alias.nested-internal-1 nested-internal-2 &&
     	git config alias.nested-internal-2 status &&

I kind of doubt that this was intentional design, but I know that it is
used e.g. by Dscho in his shears scripts [1]. What this script does is
to create a temporary alias "alias..r" that then gets executed via the
sequencer, and this patch broke this. I happened to discover the
regression as I use shears myself.

Chances are that there are other users out there that rely on the
current behaviour.

Thanks!

Patrick

[1]: https://github.com/git-for-windows/build-extra/blob/a82c8fcb0b8f165c1379c12b0cf914741b8dc8d5/shears.sh
