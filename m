Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419CF8827
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 21:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723153470; cv=none; b=JJcWf6KD/KVj9sgfov8od3zh2U/EnDbCNqJG30A9RM3Dkb/5gPVkP8aMt8y8TrOiiAqeydRUSBY7qQEqEU1+CZPyyX1eGmKozo0/etx6q0r96X6eK/R0y5ZDePgxlM0pGLTibIv8t0AjDSBzKOjnEn0+JXeWPUpqVgWDnm15C+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723153470; c=relaxed/simple;
	bh=JsXGcD/CHQkvm9U8LP91cmWUsjjA7UlZYKIzgMIuykA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ko2Z2fM1zDyvcJc63xm/tIXnWoaQxC2OAZusp+GVwqPu43SfBpwSvCkilyJdrGlsYUHG1eqIgGslNwTIRxCIrLVCxhxtMUwChAyuE+ePmajLKtlTKdshnxVWQ8DtET88Mnv939V8gUFcNn5ovl9VrUXv7K3MpP88AvXK+y1fxZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zHSwwhpY; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zHSwwhpY"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-710cad5778fso994633b3a.3
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 14:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723153468; x=1723758268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0NnC0iGRyj5s/5RKFEI1280dlMMl0/5ktrpC7mkBbIc=;
        b=zHSwwhpYInzMWVFIQW5/ssvpBqHmP8zFci1sqcwLdZUI+PWuampVy253uqYQMRsQLH
         bJcTcb28EnK+fY/mq1pPK5+aqB9jS+ll9yTt43518ny3R7k70ql5odJtpO1UvODSlSyN
         6sHUNjM1UGaJNfz6n+BEuqzMv7eiVuKUmHXY721JlhjOIpUfLul8r0oElXutL5qftde8
         yr9ho0Yz2mpWz0903xBDlylHXA5CBag+ulBcHAnoj2xLD1gE0k40AKS3hEL0Kzai/64x
         NoEPn69F+94OKjCbqetbS0o9bMkrqZQp0zZbMLvacEK7sb+YOpfjcdP1SE9ym4hoRrxS
         Er2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723153468; x=1723758268;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0NnC0iGRyj5s/5RKFEI1280dlMMl0/5ktrpC7mkBbIc=;
        b=Hl0Q42GtiXatWff0RtLRnw0G1hLNG36HuzfT9jdE2nCJ8S6+DKQkrYs8QEPjYzdMW0
         ttO058PUkwHd9AXeXm07ymYMGyoO03pr8t5rHNJlyxooxtfDN4yPUgsUVjeg7tbnwB+v
         exrHd+QiWwQcYviJB5t6maZT+odT2ismHE/UqfUUrrTbfisAhzni9E+0oLMyJ1ZxIpH6
         8v3imW+Xs94VpWUBbOEClc3OgT8OoPRnccLiEpg+SvEpNHMCIAMtkZAsPfSefsKG01ZU
         bmECugfOiuFP6Ypptn0g+1ACqN62MATewqUMxc9HNsvkojjehnKkk7or6gDnmQmqC19z
         ME6w==
X-Forwarded-Encrypted: i=1; AJvYcCVbANsBHmKkbnjj1k6lch3IsirWvYDub2DHZ+VpoVhDja4iw5nrAiwM4VSfp68n+JjnR2wNZe32FM1IayXPl4Yttk0E
X-Gm-Message-State: AOJu0Yz36Jad2tb4gUqtOtcHyPiGJlw9dZom5yrYe5MtqZPXNRaQKXtb
	ki9HGnAymvnkraxLOI4w5DEgQCXIH3FHhGAgt5IQ3+zIT6s2C1IqSGZfi29jSQ==
X-Google-Smtp-Source: AGHT+IHgyN9TJ+oHd6bWmx58oXkjRtaAaH1yQqmzXFBZatDs9Jvs3vK+lt6Qnp5zinUT4J6a5b0oyQ==
X-Received: by 2002:a05:6a20:7292:b0:1bd:709:e4cc with SMTP id adf61e73a8af0-1c6fcf87f66mr4347995637.38.1723153468117;
        Thu, 08 Aug 2024 14:44:28 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:fa12:a76d:ac7c:e104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb2e58bbsm1549049b3a.156.2024.08.08.14.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 14:44:27 -0700 (PDT)
Date: Thu, 8 Aug 2024 14:44:23 -0700
From: Josh Steadmon <steadmon@google.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, 
	calvinwan@google.com, spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 6/6] contrib/cgit-rs: add a subset of configset
 wrappers
Message-ID: <lclyd6lzrtoc3mndaz3ghfpbuaa4yu2q65mar24ge6qwpt3rit@trwicfugsx23>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com
References: <cover.1723054623.git.steadmon@google.com>
 <1e981a68802ac5aa7538381eb9469e524265ee40.1723054623.git.steadmon@google.com>
 <ZrPpxE7OZtqsbD81@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrPpxE7OZtqsbD81@tapette.crustytoothpaste.net>

On 2024.08.07 21:40, brian m. carlson wrote:
> On 2024-08-07 at 18:21:31, Josh Steadmon wrote:
> > diff --git a/contrib/cgit-rs/Cargo.toml b/contrib/cgit-rs/Cargo.toml
> > index 7b55e6f3e1..5768fce9e5 100644
> > --- a/contrib/cgit-rs/Cargo.toml
> > +++ b/contrib/cgit-rs/Cargo.toml
> > @@ -14,3 +14,4 @@ path = "src/lib.rs"
> >  
> >  [dependencies]
> >  libc = "0.2.155"
> > +home = "0.5.9"
> 
> Okay, here's where we get to my previous mention of supported platforms.
> This depends on Rust 1.70, and Debian stable has only 1.63.  Trying
> `cargo build --release` on that version returns this:
> 
>   Downloaded home v0.5.9
>   Downloaded libc v0.2.155
>   Downloaded 2 crates (752.3 KB) in 0.17s
> error: package `home v0.5.9` cannot be built because it requires rustc 1.70.0 or newer, while the currently active rustc version is 1.63.0
> 
> My recommended approach here is to support the version in Debian stable,
> plus the version in Debian oldstable for a year after the new stable
> comes out, which is what I do.  That gives people a year to upgrade if
> they want to use our code.  We _don't_ want to follow the
> latest-stable-Rust approach because it isn't appropriate that software
> has a six-week lifespan of support and that isn't going to work for
> software like Git that people often compile locally on older versions.
> 
> We also need to be conscious that while Rust upstream provides some
> binaries for some platforms, many platforms rely on the distro packages
> because Rust upstream doesn't ship binaries for their target.  Thus,
> simply using rustup is not viable for many targets, which is another
> reason that latest-stable-Rust won't fly.
> 
> Debian stable is the version that most projects who have defined
> lifespans track, so it's also what we should track.  According to my
> recommended approach, that would be 1.63.
> 
> If the Rust project agrees to provide LTS versions, then we can switch
> to those.
> 
> In any event, whatever we decide is necessarily going to involve us very
> carefully planning our dependencies since some crates depend on the
> latest version whenever it comes out and we're not going to want to do
> that.
> 
> I'd also note that we don't actually want the home crate.  The
> README says this:
> 
>   The definition of home_dir provided by the standard library is
>   incorrect because it considers the HOME environment variable on
>   Windows. This causes surprising situations where a Rust program will
>   behave differently depending on whether it is run under a Unix
>   emulation environment like Cygwin or MinGW. Neither Cargo nor rustup
>   use the standard library's definition - they use the definition here.
> 
> Except that in Git, we _do_ want to honour `HOME` at all times.  Thus,
> the use of the `home` crate instead of the standard library provides
> exactly the wrong behaviour, and we should remove this dependency.
> -- 
> brian m. carlson (they/them or he/him)
> Toronto, Ontario, CA

I've replaced home::home_dir with std::env::home_dir, however the latter
is deprecated, so we may want to reimplement this entirely.
