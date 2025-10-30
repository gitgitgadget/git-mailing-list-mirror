Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2404E34DB57
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 09:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817870; cv=none; b=QOAqr4uCb2BzrMebeN+U9QeYK4CmC3mHofQBhtStrIPagXW9jhdKBPK7llvOr8NT0sA9pSNRl3vJR9xitRYZ663s+OCYnSr/xdhlzaB/LtydvvzJFvWC4Ogp9mhZbpM0uR2Yz1S0RnLM4BnhSR2lRLsRVm4QcA4EW6i45W+djN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817870; c=relaxed/simple;
	bh=KB7QYfeewp3+biXoy7UcEO3PDp063rBSFVAtSz+6FOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBIiCfIlN5sNEcKpOxXhZZ/wLpjCu9swCgChbsssjX95k6CeSuGqAuWVl8DIYE0bzWKzllF7+VqMd7PBWnb7KPhS3psLa9iZjQr6yDBC7bDxHwo98Tu2tYyuxix7z/CNqjWH/oJbKEFNst6R5epMfKSlRsEh5DAqaHWnL62TqZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dHmiUsNp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0NRRPv0A; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dHmiUsNp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0NRRPv0A"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 2476EEC0102;
	Thu, 30 Oct 2025 05:51:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 30 Oct 2025 05:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761817866; x=1761904266; bh=pbJXSyYazI
	3PwR3Y0E+pDNc9abQdi86k2ulnNtjLy1s=; b=dHmiUsNpTa2cDMoKZ8A63pSAJu
	n3Yi6i5GHevqF3vTdZ8pyVq8cOEEX4XW4gx5JQB6PP5c3i7C6zerUpYrDgt1YL58
	F6eOTjBof2vmgzDmE4Od5lkcB+Vjp+LPHQeFp0hyeO8Kae7pInNWZakHeig7JtsL
	jaSbD3kTxKq/EEUI2w9ovxUuq1NblFx3noQEKc7CF0RxI3WKBcqtuWizidMQSjPl
	FXtaBP3xRgHDaXO61QP/kfSrYp05eGkQ0vRhGExWQi8OFZxLMtTzVVZowbT8zCBy
	GXeVnNRE1bulQDFPpv0g0NXW2ZYxleupN/jOkr07MXYypMh7u12Gb+csV+dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761817866; x=1761904266; bh=pbJXSyYazI3PwR3Y0E+pDNc9abQdi86k2ul
	nNtjLy1s=; b=0NRRPv0AI3eURAs+PXGa4suiO9+EZSXv+ABY4YJdATW8t9XJlwk
	SAg1BF7iUon8JiWhr2My6clgMfZPTdloEZK+wFdpjfyfiOrtNdUwazhQ/O+vKRk1
	pFbtW1SHHlo374m2o4PIOqrb6KpU//X9YJc357adl8y2aC2URSRlSa0pjYWk3ACi
	FhqbhpQKs7lYDbTkXbtgPQE1//QNeqTfQdxXW6XXd1iEgKxeGrrrjU+LA2v4a1wA
	ZPakwEjJj/ViP/wHzp1TNbURXHEBQj9T43NZWVJApbHbKvAIOc1LCblrCP0FnOM+
	dvIsxI2PGAsrH8lQmfPNXFDO3RU0sNId2mg==
X-ME-Sender: <xms:CTUDaQR-2_po92i9NYoaL-1tyklY85DmEZY384qYYj8J7Sk9CeUmGA>
    <xme:CTUDaUomicEdiTXKngzttfWx87Dr3e4vAb2IO1OZubfpqsAfXJJjIZ-FweVVyzRrr
    qGPNYv2cS14TuxTF0dpUPxQ0VfoeRuaERWJW2vUWaWFmqNRhvB9Zw>
X-ME-Received: <xmr:CTUDaWJcFruHOVp4NU3dgfwFdvpAzBFQlAT7CdAEgennHieF7UeUo8j-uhNk7GqIzajB0mbhdiNYx_oJeSNc1CzaKipVuIZvon99cJMG4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeifedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhr
    tghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtth
    hopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:CTUDafqLfmu6ISue3OloIw73gYmC6eKJSsuWnj_MfAjFa0kTYB7FpA>
    <xmx:CTUDaWzyMYJ2zgYrGm4EjtyXykR0XhKVJ_N8diZe6lHFuZFpIwZVcA>
    <xmx:CTUDabOZnXaKnwUtaPR-V9SWVxyEwpJTXzBijps2dYstgJ098Jp9XA>
    <xmx:CTUDaT6Lblo-Yp5ori6HlmeHWyYAVL4f1zCn3s02f1MpgY5jYZL5tg>
    <xmx:CjUDaUCDCsSCdH3zPcbdFBqBciru_GwGW4THWSwSTz8Iz9_nLEUKJgCx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 05:51:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f1aca8ee (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 30 Oct 2025 09:51:04 +0000 (UTC)
Date: Thu, 30 Oct 2025 10:51:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/5] rust: generate bindings via cbindgen
Message-ID: <aQM1Bdwrf0tEluEM@pks.im>
References: <20251024-b4-pks-rust-cbindgen-v2-0-4b4bd4f18490@pks.im>
 <20251024-b4-pks-rust-cbindgen-v2-5-4b4bd4f18490@pks.im>
 <87v7k4pffg.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v7k4pffg.fsf@iotcl.com>

On Fri, Oct 24, 2025 at 04:01:07PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/meson.build b/meson.build
> > index 308798e861..b4acc417ad 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -523,6 +523,7 @@ libgit_sources = [
> >    'usage.c',
> >    'userdiff.c',
> >    'utf8.c',
> > +  'varint.c',
> >    'version.c',
> >    'versioncmp.c',
> >    'walker.c',
> > @@ -1704,7 +1705,9 @@ version_def_h = custom_target(
> >  libgit_sources += version_def_h
> >  
> >  cargo = find_program('cargo', dirs: program_path, native: true, required: get_option('rust'))
> > -rust_option = get_option('rust').disable_auto_if(not cargo.found())
> > +cbindgen = find_program('cbindgen', dirs: program_path, native: true, required: get_option('rust'))
> > +
> > +rust_option = get_option('rust').disable_auto_if(not cargo.found() or not cbindgen.found())
> 
> This means to compile with Rust we not only need cargo, but also
> cbindgen. As we ideally want to have a broad platform support, would
> adding another dependency (i.e. `cbindgen`) narrow the platforms we'd
> eventually support? Or can we consider platforms supporting Rust also
> have cbindgen?

cbindgen is written in Rust, so as long as you have Rust you should also
be able to have cbindgen. The obvious catch though is that cbindgen also
has a minimum supported Rust version, so we need to ensure that the
version of cbindgen that we pick is supported by our MSRV.

> > diff --git a/varint.c b/varint.c
> > index 03cd54416b..1ed738a756 100644
> > --- a/varint.c
> > +++ b/varint.c
> > @@ -1,6 +1,14 @@
> >  #include "git-compat-util.h"
> >  #include "varint.h"
> >  
> > +/*
> > + * When building with Rust we don't compile the C code, but we only verify
> > + * whether the function signatures of our C bindings match the ones we have
> > + * declared in "varint.h".
> > + */
> > +#ifdef WITH_RUST
> > +# include "c-bindings.h"
> 
> So when we rewrite more subsystems into Rust, this will include
> definitions from all those subsystems into this compilation unit.
> If one subsystem with a Rust alternative implementation includes the
> header from another subsystem with a Rust-alternative implementation,
> the function signatures are checked twice, and errors are surfaced
> twice. I guess this is a tradeoff we can accept for now, because:
> 
> * We only have one subsystem in Rust now.
> * The approach in this patch simplifies the build setup.
> 
> We might revisit that at some point, but I can agree this is the most
> sensical approach for now.

Yeah. I guess this is also something that may be helped by introducing
Rust workspaces as Ezekiel proposes. But for now it's going to be good
enough, I think.

Patrick
