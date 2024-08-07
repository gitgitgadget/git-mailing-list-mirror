Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF8D1509A5
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 23:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723072764; cv=none; b=Zaoqp5FCeu1fqIYfTsX6xNbvMYAdRijZjVehNJwDZ3mEOZ27fRp8Vs82i1Boouz/zi+xGji2LIiCiwSWbceZz2xOpg6cx/Fs8qj16OxtqxM0kmeQ7rtINm5fO3JBWHhnpYo9GmBjZjV6MXmwo2F2SdmYSUPXE794Eh6mNiFwJ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723072764; c=relaxed/simple;
	bh=FKkxH6GRtIKtprqSeYAY4dINzx68B5CNJRwULDRiMh4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVj+sCQULgYQsiAh4D+wckybgC9qLo1BUgwTLJAWwtxOchbwx+XzOielfB+0J0r0peyWg4L9yQyq5VHvvoOuydSv6t9ijevcqCTCcaeHxRtbzmiow9fmnyzKuFwdpLrOC8a2cTaf3x5imf9TgwrGgomszSw/wXdssKyoj1xU41c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p7aqVyIB; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p7aqVyIB"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc66fc35f2so10867695ad.0
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 16:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723072762; x=1723677562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=anCNHc22Jsjv+GxeLs/sW9zbYpwNh4LCNC+1F/jdueA=;
        b=p7aqVyIBmny10e05F4AL+9x7ku+0ZzyYu15bkyud8GbWmzbZ4VMEk9Gb/S6kfWZ1ao
         ZZNz4osSEvtQ5DjUwqDmZfb0A9fv1yfgArWxI2jxYcmL8qE1qVg1mMzmZ0cDhHFJrOab
         R+6skzYkM2/RNdkfw6SEYVDMi+8D9IfghCF0haekOleHQtyxp7FrjbfKbjn1GODLxZoZ
         KSVsimBPyzvJ4l6itvKsIzunqB4/vWREoM1z6KHpihHJ5hIzwrFCLHKgepo/286LpUKl
         GRobS4ebgDTIjzHS5234zauYvRkzuEpk4+fwz69OzJim4uvcbnGXSRU3xiY3r3fuHHEe
         hR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723072762; x=1723677562;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=anCNHc22Jsjv+GxeLs/sW9zbYpwNh4LCNC+1F/jdueA=;
        b=hnfjkgGEw8PzPvx9pnfLvOU0o8jSEHWh4gglMCwtBU/KcINK4LcU6ahwaV5MNVAiRq
         Fm1xgEwp20GAUNggWKr6od3nknjvxIWS8T+OMmMchtXPvCmP5ckFQkjTncW6M74hew8x
         cYRrR2HyMzfv/p65aZ7oet/u40N8fGnyLvXFxm7DmH+4YzoQlgYbj5thJRQDXBVyvmlb
         iW7/1EW3kjF0PH20cUmWM6kW2GVolP4gbAVnrbYxKfDSTvN/vrHtNE35fJ6iPJbXeco4
         +otDMMi/k3UbTJcnMKC8rXSAg2DjAeoEdyu+XhL6oxgW4qUS0Ahz1VHR9vop7cMdEUS1
         TCIw==
X-Forwarded-Encrypted: i=1; AJvYcCXXhNVWsATheXRfNRC/NMP9yAS6FI7dmeL8zsj8PrG69qMoPAYoGrgrWsZjEAoEQWMBwr81TypIXUi+Y1fP9Q61gpaI
X-Gm-Message-State: AOJu0YxDWI+f3jZtvpdx9HqLfJR3b/JKzt0ugTLUKdMvk4K61L91879R
	psndwZAtbxxAc0B3FBQ67tyi5Ue9kqSBm2egEi6JaspbSo2DRz7djQeSCsg4Dg==
X-Google-Smtp-Source: AGHT+IHF3bEHRWdRe+1EYc0iSsqlbzk4leeBQskVT/qnPd+7HJMsk2DKzEDukY1TCRBTDW364zffng==
X-Received: by 2002:a17:903:22c1:b0:1fd:7ff5:c673 with SMTP id d9443c01a7336-200853a50b2mr60359465ad.2.1723072762082;
        Wed, 07 Aug 2024 16:19:22 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:c023:b8:a8df:17c3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200775d1b92sm39971375ad.77.2024.08.07.16.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 16:19:21 -0700 (PDT)
Date: Wed, 7 Aug 2024 16:19:17 -0700
From: Josh Steadmon <steadmon@google.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, 
	calvinwan@google.com, spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 0/6] [RFC] Introduce cgit-rs, a Rust wrapper around
 libgit.a
Message-ID: <izpeuh3hjhsutfubyipqairso4pmqghhryndu64skib5p2yvvc@wetoctwy2jty>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com
References: <cover.1723054623.git.steadmon@google.com>
 <ZrPvSWoUOEaUIjWq@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrPvSWoUOEaUIjWq@tapette.crustytoothpaste.net>

On 2024.08.07 22:03, brian m. carlson wrote:
> On 2024-08-07 at 18:21:25, Josh Steadmon wrote:
> > We are putting error handling on hold for now since it is too complex
> > and we intend other CLIs to be our first customers, in which case
> > printing out errors is not the worst.
> 
> While I think that's okay for now, that really needs to be one of the
> first priorities of things we fix.  I have some ideas about an approach
> which we can take, which I'll send out in the next few days in a
> separate thread.

I'll be very interested in seeing this, please CC me.


> > While the wrapper itself lives in contrib/, there are a couple of
> > patches that touch git.git code. These patches are necessary for the
> > wrapper, but not for git.git itself, which may seem unnecessary to
> > merge. However, I would argue that other languages (not just limited to
> > Rust) have issues calling functions that require a pointer to
> > non-generic objects and essentially require a redefinition in their own
> > language.
> 
> I don't see a problem with this.  It seems very self contained.
> 
> > We're sending this series as RFC because there is remaining work
> > we'd like to do, but we'd like to get early feedback on this approach,
> > and particularly to ask for advice on a few topics:
> > 
> > * alternative methods of exposing only a subset of symbols in our
> >   library
> 
> We should probably support symbol versioning in the libgit_ code on
> supported platforms if we're going to expose it.  Otherwise, we're
> setting ourselves and distributors up for a world of pain when we change
> the ABI, such as when we add error handling.

Symbol visibility and versioning are both areas I'm not very familiar
with. I'll do some homework but might need additional help later on, so
please keep an eye out for beginner mistakes I might make in later
versions.


> > * bikeshedding on the name (yes, really). There is an active, unrelated
> >   CGit project [4] that we only recently became aware of. We originally
> >   took the name "cgit" because at $DAYJOB we sometimes refer to git.git
> >   as "cgit" to distinguish it from jgit [5].
> > 
> > * gauging the level of interest in calling Git code from Rust
> 
> I left some comments in the series.  I think this is a nice first step
> as a proof of concept, and I'm very pleased to see it.
> 
> If your goal is to simply expose C APIs, I suggest calling it something
> like cgit-sys, since the -sys suffix is customary for wrappers of C
> libraries.  If your goal is to provide actual wrappers that people will
> use in real Rust code, then I think that we should _not_ expose the C
> API, since most Rust users will not want to use that.
> -- 
> brian m. carlson (they/them or he/him)
> Toronto, Ontario, CA


