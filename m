Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B72D1494B1
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 21:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726695213; cv=none; b=qSlB99Ljj1lPpPVc7mxlbCp1a3HupA0lQTN7AExeYJuL9nuEzMXufMXLXouvcMMHADuGt1gzYm3utn2XdJVCLIQrJFCSr3xPrejVR9w2/iEqIPdz2ESUB8PdXBFz7HiWOsaxSwkDAgG2nzu9l8bZloUaA4GUitGTFwHZOGzoewY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726695213; c=relaxed/simple;
	bh=khUPuDtU7qHTr2j7gJakFGeGyT8LT51D/8E9XVucXEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsKdiDLBkHIhTjdYya1yw77yGRljgidjajVTiC/O6kizwwMNbM5N4WKHD5iGyQSDHI/QssED/wPpUSQo8EREXeipRFtinCxlQZawQp/4p6kGHw3CPS/EMT9iaDMgl+Qe6+v/NB+GsLTfIij0FmHYxjqTfUcyYNOlPMIqoR8bLxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0ZrKgKOC; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0ZrKgKOC"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2056aa5cefcso261645ad.0
        for <git@vger.kernel.org>; Wed, 18 Sep 2024 14:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726695211; x=1727300011; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1J4vWrPzeOzu++SofnpH8iwU3VoPv4j8p1DmX8erpU4=;
        b=0ZrKgKOChEcJLIAItlhDkCesZKlzRrkLoupOiPDTuyG8fTMHx8VdEw/TiUvT7/hTGZ
         NXrTW89Oyk28+fLjzx50M0kK2Yd46XgCchqcdo9+sEQgCJOMet7AjpRGpVltCk1BxPqJ
         EDtMEGMIGg9o4YdwmoR4n15a9gVYiUUD/pWIW6WsTN5OaVqsOvmwFXAcLRYVETukapxZ
         8jPDU4peYYGyMZwBBA5qk5y+1IzXCyJDsGlpGrkbdXawSgxafoeG+vedW2IPdKWizUtJ
         8d8D+gQolDbdRXySIGLVtUdTdfwiRGxdeFV+OdEX0b1iAVXcOAaYVVWRCM0T1OEVbidj
         wDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726695211; x=1727300011;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1J4vWrPzeOzu++SofnpH8iwU3VoPv4j8p1DmX8erpU4=;
        b=FYA57hCMwtgY+UUWLgm0M4h4VJcbBlAi2s3kdhOnji+3MXyIxVixY2sw646rcSKIvD
         sSQJp1+X0v1dh2WfTatMmvz9bfwEJ4k5E2T0JHdN1pnobM0Om1g76PtM1H/Sd46s3ZE6
         PUs9W9hVf6mYenbBXwwqbdyZGExBAc1oQNolVBUeXeWAKl3KF9GhYdSKG0pC3gMIPcrj
         9lixLjr09OIK7j4KnRzaKBiFWi/OU4EOYvWpOIAZUwjo+NkU1005yJbb04/2mbjGQzPY
         2S4oX0OpSzbYtc7yzfa/eCN9i1o++Y6Vi0UKbdj7u19Wsjw55psnH+4JU6YOWDJNA0Jz
         qfQg==
X-Forwarded-Encrypted: i=1; AJvYcCVb2NV6jiicxUC8irL1Kd6DPdh6PacVhHI2phuToBzxt4rNXC7egtfYbuCm/v6VgpTWdMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YykQulegd25IlHU3I0q6K95vTq9j2wNCBfRDAXovPFPy5if6uTT
	jV4koEHyJ60HVwqFF1NAxIs0D9hx7pj1tJ6eAJJ6bLoBaxgkAoRE3PWksFaQRQ==
X-Google-Smtp-Source: AGHT+IEJ/BgkC6nT02rj12NHPKp8Y/ddhyqr69y5ERTchFankrUSo+lGuhynzVHUHQmgJh+gsmH2+w==
X-Received: by 2002:a17:903:186:b0:1fb:19fb:a1f0 with SMTP id d9443c01a7336-208cd599c8fmr495255ad.4.1726695211073;
        Wed, 18 Sep 2024 14:33:31 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:8e56:45c4:ecbf:a6fa])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db4998e21dsm7995451a12.75.2024.09.18.14.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 14:33:30 -0700 (PDT)
Date: Wed, 18 Sep 2024 14:33:25 -0700
From: Josh Steadmon <steadmon@google.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Calvin Wan <calvinwan@google.com>, git@vger.kernel.org, 
	spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com, gitster@pobox.com, mh@glandium.org, sandals@crustytoothpaste.net, 
	Jason@zx2c4.com, dsimic@manjaro.org
Subject: Re: [PATCH v3 3/6] libgit-sys: add repo initialization and config
 access
Message-ID: <pci7ayjv2llvcj6yjtupxwslaa7gy4fx4tnxuenavlgn2xer5v@vcestj4xvbff>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Calvin Wan <calvinwan@google.com>, git@vger.kernel.org, 
	spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com, gitster@pobox.com, mh@glandium.org, sandals@crustytoothpaste.net, 
	Jason@zx2c4.com, dsimic@manjaro.org
References: <20240906221853.257984-1-calvinwan@google.com>
 <20240906222116.270196-3-calvinwan@google.com>
 <CAPig+cQDa7pw5p22CQJZsm8BF_0b6MMyoknAAkFO2zcrPciSiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cQDa7pw5p22CQJZsm8BF_0b6MMyoknAAkFO2zcrPciSiw@mail.gmail.com>

On 2024.09.06 18:53, Eric Sunshine wrote:
> On Fri, Sep 6, 2024 at 6:21 PM Calvin Wan <calvinwan@google.com> wrote:
> > Wrap a few repo setup and config access functions in libgit-sys. These
> > were selected as proof-of-concept items to show that we can access local
> > config from Rust.
> >
> > Co-authored-by: Josh Steadmon <steadmon@google.com>
> > Signed-off-by: Calvin Wan <calvinwan@google.com>
> 
> Josh's sign-off is missing?
> 
> > ---
> > diff --git a/contrib/libgit-rs/libgit-sys/src/lib.rs b/contrib/libgit-rs/libgit-sys/src/lib.rs
> > @@ -1,8 +1,19 @@
> >  extern "C" {
> > +    pub fn libgit_setup_git_directory() -> *const c_char;
> > +
> > +    // From config.c
> > +    pub fn libgit_config_get_int(key: *const c_char, dest: *mut c_int) -> c_int;
> 
> Perhaps add a comment above libgit_setup_git_directory() stating its
> origin, as you do for the other functions mentioned here?
> 
>     // From setup.c
>     pub fn libgit_setup_git_directory() -> *const c_char;
> 
> (Nit: I would probably drop the word "From" from these comments, as it
> doesn't seem to add value and ends up being noise. Even better, drop
> the comments altogether since they don't really add value and can
> easily become outdated if code is ever moved around.)

Removed in V4.

> > +
> > +    // From common-init.c
> > +    pub fn libgit_init_git(argv: *const *const c_char);
> > +
> > +    // From parse.c
> > +    pub fn libgit_parse_maybe_bool(val: *const c_char) -> c_int;
