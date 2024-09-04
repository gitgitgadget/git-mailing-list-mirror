Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F70F44376
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 17:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725471059; cv=none; b=ebxRUv5g4BngdziMifWmwD5vGFwqvUmGzbWuW2JolSZ0qgr6xKzKT1d0wHZrW/S8yh8AqoFzXSEEo4X4fILl5JjH4ImfDfIiUOQ/J9fPCPFtUmPy1X6pCkmvdv/iZWX5mbf2Y0ebehso2vjiqRf49yox1hJvi6vE/cmCI7B8HpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725471059; c=relaxed/simple;
	bh=Mf/gZMPhkVoOonJ1arO5KTrqmMQT+/HuQe7h4QBwilM=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=qVyUvHZ9GCf7Ufn3Nz0w3O5oUYc4FTAOpnpSz2nfrb+wjlVoMfXN+aWOTGLMG8GW1AHVYuNuqYbXJvVsAhtBUU652zCtf8GvEp3rW3wh2hYBLuLp4fmeMELsm2iOiSpu1ARA+gyJBVV5BF9Kccm8V9v7SCh61GTW6sfZZR5jgJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=we2K/p0I; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="we2K/p0I"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d73d0944acso89447687b3.1
        for <git@vger.kernel.org>; Wed, 04 Sep 2024 10:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725471056; x=1726075856; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ddzVl6OyB0dYI8Mwia21cDdlGz8fCVYd4ruIV/8sxJw=;
        b=we2K/p0IwNvq53EvW8WqBNE9wdDtBh49CXD5EurIVIUZqvCNbgAGOOxxqPyYflnTfT
         ecSR5OrR/vWhEDn6c9TYcfl6KkWWq8irExEd9SbEXQCnANq/sQ2DMwUIR92NYYriCiHD
         qghdE177pWMCqFVg5aoZK2HWUEpIstpBL6vZa9hcyWbBsziX8REkwSEg3qedZ+jceMoH
         FBiWS0jeKd6oxg3CnNsKUY3+ovX/PHgWCcENXYf8xIJz2lv7LF4EIbXC1ecY9qSiL8U0
         QnFhtoYnyUc04L1b5duvcrsRlbJxCC2TKMm5C5mS011sLoQP3ZxgJiBCK48QX3qWJHhr
         tZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725471056; x=1726075856;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddzVl6OyB0dYI8Mwia21cDdlGz8fCVYd4ruIV/8sxJw=;
        b=LcG8i9/gsDp4dARde1JBZ67GNGR0yT4W4AfH6CY8zilEitTBzcYgLDlrd9XKUR1JsB
         QlaaPT9S0D/cSlFdU4ZYDEn694Vnmg3rS9YUI9LDFHOBsvDdNuHKnxPiXpN0ETp+eW15
         RsJ05y5nvmVNYtNC1/caqXejnw664Wxgi6k9A1AxSZ2l0elw+i6heqnLFWBCh8zXmicy
         7VKp/ZCjJNtOaB4JY+4GDl8qGM7c3a78JHgzJvRx7N5DgFESWH8tGul4RmzHRWR/ZbmI
         aOSN3UILeWJbYBKjdQuRFQ/bYpTQho7Qe5AiPox6R1Sf63V48kHyddaR2Pp+KyAZMXpg
         +VRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3mkZXEcmNLViWVHWWCDOrIBy0B7OiXWnBX/w98bVfKld8bAw2L+3Y3GLPQq+/gu2QXW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVpCN4qZWwCz4wTyzKlWXAfiL7i7aDvlETEWYMPk2oCQ6Mmrp2
	zhU1uMZUdlHMcB9l9khrd5HTJrN1jy/HU4RGV2NwBWum4akbmHRM2vbIlPUE8MEmcOGleWCnhdB
	L1QcuE6gmC4Upbg==
X-Google-Smtp-Source: AGHT+IHIydXKIxMI85k20QsSF1mMhO/LLl2tPfri+5Vmh5ZmYk4YssU1U0EM5kD+XffywyNJcn3lCoBjO9c9D0c=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:690c:418c:b0:667:8a45:d0f9 with SMTP
 id 00721157ae682-6d40af0505bmr415497b3.0.1725471056553; Wed, 04 Sep 2024
 10:30:56 -0700 (PDT)
Date: Wed,  4 Sep 2024 17:30:53 +0000
In-Reply-To: <ZrPpxE7OZtqsbD81@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240904173053.1220621-1-calvinwan@google.com>
Subject: Re: [RFC PATCH 6/6] contrib/cgit-rs: add a subset of configset wrappers
From: Calvin Wan <calvinwan@google.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Calvin Wan <calvinwan@google.com>, Josh Steadmon <steadmon@google.com>, git@vger.kernel.org, 
	spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com
Content-Type: text/plain; charset="UTF-8"

"brian m. carlson" <sandals@crustytoothpaste.net> writes:
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

After getting rid of the `home` crate, the only other issue we ran into
downgrading the version to 1.63 was with `std::ffi{c_char, c_int}`.
Those were only made available in 1.64 and they are obviously quite
necessary for us to be able to call C functions. Do you know of any
alternatives we can use? I also don't think reinventing the wheel with
our own implementation makes sense in this case, and even if Debian were
to upgrade stable to a higher version today, we would still need to
support oldstable for another year.
