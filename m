Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF791154C12
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 11:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739879242; cv=none; b=A97h3nTJO+2B6AKnZCYUTZHa5MmffIP7KGw8l3C8OHAI/Iob2/Cu+8oZKL8RsACgBhbHkbKahgqRch9rwGBXokwtnbDjTo1l3CTiCDe4MXGI7kO2HyyrlqQxoH0CeRA9B10JWI0x0kvdC2mm9V6u5Ak3kqfmRbJ/LI++LF82Z1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739879242; c=relaxed/simple;
	bh=qR2r3KZJ5fT0Tdsi/fvqlky1XhGOIJUkKjcmPgJBHF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9xsiCUTcaqMryDfGblm3AXvWQtJ6Mpni3uifmW6vnTwMEizQ/ZmW02fksfz3qV2D0nEVIc/BYl8/JL+BThkeTYyPpm3XKrFBpixQd0geKdrgIV6AQMZmX4KQrsKl3AMGH9uPD1LP0gOnEY5nDIKpVgSD2xvXkOABGMrlPraop0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jBgiG25x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D50NrBed; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jBgiG25x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D50NrBed"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6F71B114025A;
	Tue, 18 Feb 2025 06:47:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 18 Feb 2025 06:47:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739879238; x=1739965638; bh=v7rkQMDf/m
	5SwXDuWBfv/YzR64NKJ85m12VQgtcGE3A=; b=jBgiG25xlrylvl8S4EmWNJxTM2
	bvlBPeA8qJxUaRT9BD/XiEIYTHwUX8ptju02IE3GzNCx/6ImRHgO21alrC27X7My
	kEX5sBuVcY2z2CupffgoRVz/zH/sn2N1RvVWwehJ4IQwO8qKCQtki/NkHR6H+r9k
	fJRb84ADzPaHDjthAKw7zZ+WnQcMTddovnpx95k/IgPX473i/TbbQUxppwzXFMQY
	dycI4jVHzxqLpYgJ3Xv89LUx2z7Hk1l/U+9oELNZsVjRl4TnzCKbJpgprGWbOqgc
	0gMpDRLquo71bxVkGNWRvO5PuTwN18ImkPHj1Mcnm+3vLH8QgNx5J6nT7XTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739879238; x=1739965638; bh=v7rkQMDf/m5SwXDuWBfv/YzR64NKJ85m12V
	QgtcGE3A=; b=D50NrBedFojs72mKYrbDGAjqcEog91irEFwfZnRWk0RKxADtZQx
	SCwJQM5MKjS5dJNrtmZbILeGXAGmqdT37/1vstzFfWo+3UfdQzStkFeAqRwBuybZ
	MXDWlIwJrDdKKe0jo08U+BJ3775dCFKXF4uxOV+4JZN056ksZ6zMog4bz+HthaAG
	+i5J4Zt4up4Oq8M0elThf+6AM1WAu96ZXPPHftUuSMos28I+dUbiBBTz06w/Pmp9
	GbEX4C067hUrUMG+TidhbqgNVXB1fb0jYlSabV2vezcvQLPPj8Ho+VXIDQZoGIEJ
	rgHUw+rWS5A7unrFFUdAksZyPsGd4ZVNPGQ==
X-ME-Sender: <xms:RnO0Z7BE0EKi-V1NLbvnmx-vXk9xgYv85WKs9KEsL7EgarM5TWznOA>
    <xme:RnO0Zxh7mcobp4F2fc08jRUdFFoM0UpJGFhN_z4JbqbXMIX7_kl8WPA2IeLh2P3EA
    IJNfyrbuc95olhFbg>
X-ME-Received: <xmr:RnO0Z2lRcWkadMT-Qh136hgDOvaK1XfXYqSlyq9C7zGDqXYWZ6Of0qkl8cXXU5IR0QuG7U4T0JaIADm4DgAR6eyPK6I8qRGTDj3Nnq5dHqA_3hrp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiuddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffgffffeduhfdvjeduudeijedtfffggedvkeeigfek
    teevkeeghfefudeutedvheenucffohhmrghinhepmhgvshhonhgsuhhilhgurdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehp
    khhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshdrrhgvphhorhhtsehgmh
    igrdhnvght
X-ME-Proxy: <xmx:RnO0Z9xrExQiqZyMyrXen2HhccX7IlcuS7AeJ4fkG3Q39bxPsTuJRQ>
    <xmx:RnO0ZwRZQHLLjU1Ge3TdDb4sZu-ByxSc9zRvs_pGGdbhcZdToGbJPQ>
    <xmx:RnO0ZwYb9n2KBduAmCI2vt3lVBUhCnBaLGsQLq5QxE7L0y3J2AL17A>
    <xmx:RnO0ZxR3Nk6AqQRFMdqvhKTswk968VVJD1IeGNEupCjb019eDJfuNg>
    <xmx:RnO0Z2ebCJ-FLRF4cv9sFPYZSaCQQMl2V6mtUKA9ty9H9cmQDoOxy05q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 06:47:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3128258c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Feb 2025 11:47:15 +0000 (UTC)
Date: Tue, 18 Feb 2025 12:47:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Peter Seiderer <ps.report@gmx.net>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: Meson build leaks host 'sh' path to target build when
 cross-compiled
Message-ID: <Z7RzPkiBfbYPhKp_@pks.im>
References: <20250209133027.64a865aa@gmx.net>
 <Z6mtnmvKMsIOEVz5@pks.im>
 <20250210122603.5130e309@gmx.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210122603.5130e309@gmx.net>

On Mon, Feb 10, 2025 at 12:26:03PM +0100, Peter Seiderer wrote:
> On Mon, 10 Feb 2025 08:41:18 +0100, Patrick Steinhardt <ps@pks.im> wrote:
> > On Sun, Feb 09, 2025 at 01:30:27PM +0100, Peter Seiderer wrote:
> > [snip]
> > >   The meson build tries to execute the non-existent '/usr/bin/sh' (instead of
> > >   '/bin/sh' as the autoconf build), 'which sh' on the host returns
> > >   '/usr/bin/sh'...
> > >
> > >   From meson.build
> > >
> > >    [...]
> > >    186 shell = find_program('sh', dirs: program_path)
> > >    [...]
> > >    685   '-DSHELL_PATH="' + fs.as_posix(shell.full_path()) + '"',
> > >
> > >   Do not use the result of 'find_program('sh',...)' for '-DSHELL_PATH='
> > >   (at least not for cross-compile), use fix '/bin/sh' instead or make it
> > >   configurable via a meson option?
> >
> > Hm, very true. We're mixing up concerns here by treating the build
> > environment and the target environment the same.
> >
> > I guess the proper fix is to wire up the "native:" parameter when we
> > call `find_program()`, which allows us to tell Meson whether it should
> > find an executable for the build or the target host. And then, for those
> > binaries where we actually need to know about both the build and target
> > host's locations, we'd end up calling `find_program()` twice.
> >
> > For executables that are supposed to be used on the target host Meson
> > would then know to first consult the cross file, which could look like
> > this:
> >
> >     [binaries]
> >     sh = '/target/path/to/sh'
> >     perl = '/target/path/to/perl'
> >
> > Meson would then pick up that file via `meson setup --cross-file
> > <CROSSFILE_PATH> <BUILDDIR>`.
> 
> Sorry, I believe this will not work..., the description of the native
> parameter in find_program ([2]) on the first sight sounds like doing the
> right thing, but as far as I read the 'Cross compilation' page ([3], [4]) the
> tools under the '[binaries]' section are the tools used while cross-compiling
> (running on the build machine) and not the paths/tools on the target
> (or as meson nomenclature host/target)...

Quoting the documentation of `find_program()`'s `native` parameter [1]:

    Defines how this executable should be searched. By default it is set to
    false, which causes Meson to first look for the executable in the cross
    file (when cross building) and if it is not defined there, then from the
    system. If set to true, the cross file is ignored and the program is
    only searched from the system.

So I think this should work as expected when passing the file via
`--cross-file`, shouldn't it? If we are cross-compiling we'd find the
target binaries via the cross file when `native: false`, which is
exactly what we want.

But I see what you're saying. The _intent_ is to specify the environment
of the cross-compiling environment, and not to describe the target
environment.

I can think of two alternatives:

  - We can introduce build options for this. If unset, we continue to
    use the result of `find_program()`. Otherwise, we use the value
    specified by the user.

  - We can introduce properties into the cross file that allow the user
    to specify those parameters. We can then retrieve them by calling
    `meson.get_external_property()`, but only when cross-compiling.

Let me also Cc Eli, he might have an opinion on how to do this.

> > diff --git a/templates/meson.build b/templates/meson.build
> > index 1faf9a44ce..986c2e03be 100644
> > --- a/templates/meson.build
> > +++ b/templates/meson.build
> > @@ -1,6 +1,6 @@
> >  template_config = configuration_data()
> > -template_config.set('PERL_PATH', perl.found() ? fs.as_posix(perl.full_path()) : '')
> > -template_config.set('SHELL_PATH', fs.as_posix(shell.full_path()))
> > +template_config.set('PERL_PATH', perl.found() ? fs.as_posix(target_perl.full_path()) : '')
> 
> Above should read (perl.found() vs. target_perl.found()):
> 
>    +template_config.set('PERL_PATH', target_perl.found() ? fs.as_posix(target_perl.full_path()) : '')

Ah, yes, indeed.

Patrick

[1]: https://mesonbuild.com/Reference-manual_functions.html#find_program
