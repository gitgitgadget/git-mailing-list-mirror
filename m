Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05F5261372
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 17:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925442; cv=none; b=GQiY0x/Fmq3uCiwVnTDajwM9X4Mp1OnP/mVYYon9ChtcACeSIr90LJkt/MoYp6bCo6fvymPpsvuK4MkD4lqLdiawXNNC5cgctC/5bS9zcT/6XU0x5WVg2K5yjUDaWalUMu6/EA0e5pnrunpPW4adtVvPova6lROu2c+yoy4C+HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925442; c=relaxed/simple;
	bh=Vt/N6O9xv7epbzzSm8D8H59MhyA2Q7D2Od2n/0KNEXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdx3TqLPd93TFzP3De5DTlVkIoJ8wmFpsm8eJucTmrLyczuoUY9us5geKRvqSornaUnvi/j/jcwfSbvPhBa0/UlWRIE6WI+9fH+jKtPUftEF6YyVbsnYBjD5MKjYwLqxZoEzX6R8bXl90btohjJRgnxCGNnoKB8PxWvNAgL9xkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h2CniUcm; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h2CniUcm"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2240aad70f2so22045ad.0
        for <git@vger.kernel.org>; Tue, 25 Mar 2025 10:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742925439; x=1743530239; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NAW65hfWIgQk3KDUjwIaWbL2DazUONWiVXbFSW0YnWA=;
        b=h2CniUcmHlJdCSofeppV6y4Dg9H1dOraSxf/Jh4c2WbJOKZjWNJ658GPFotNeyCYaE
         rmfbO9s6mEA9DlYQbH2JbwHOXwBG+dNJuip0+bhRPs1gGo7GDmn9lAoX8NEZ7ZbPY54R
         Ms/ZKPAE5yYsMevvORDYvUovzdh8WEtAxfXVm8+hKrOhYwvkkLQXWDjNi7n/i8ozkFU0
         X9Kk7jwXasQzUESIylPqoITusKVDOTFXLDiua8GAw6R64E+mIInAPwhUNPU9D5Upz6Cv
         CVO60BhciT1UTANdrvC+E1+RHZG/It4QwgZZ5YsE5g5IWU4/+KiTSpLn9MD5M2Ofvht6
         3kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742925439; x=1743530239;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NAW65hfWIgQk3KDUjwIaWbL2DazUONWiVXbFSW0YnWA=;
        b=ot8Xo2FRD8PXd5bLotZyx2Wiw0PqRC/livThgW1FOgIx+QXSTLxMpj80Wnr+rUFod9
         dzNCotdcRcAmnHxs8tfXR3GTBKkLeTuBkqSh7pKueN9cpqJzB7yjcI/dqzVOVxzj54eh
         /vukpWDj+ePx+vudTUrd0qPkdAcbS18+RCPpZSW1lqgZK8Q+aKYEANVyQERmOh7Vy9ld
         d1tGNmupbFQXBUCZPYJOVIItnUjDi5p2ueb3Ni27BTnC0dIGPuO8AFgFHuvL9Iv60+qz
         8A+4d3K2RwEuoG5aWwIXbrLKh3dqY/eGqgQSYgKmeo35VDj9N+GYg9foGJGJx5g7jhkc
         l1gg==
X-Forwarded-Encrypted: i=1; AJvYcCV/qndlL516brGYX1IYMMhDXV9HyklehqWuHqTp9yfgCvkGxdfbwi133ARTuyq6ZwUT/vw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1XTqwuepPXzKqAtpmGrlHQF9yFzX+cfmjEs8OEAKFdsxr9zsW
	v7XyYuzzFPUAlQLjN9JobLDLqRp+DAS4rVPAUQ+r7d2a2baRX6FacG8FJTcR1g==
X-Gm-Gg: ASbGncteWURjRLX8/prCTHOAEixIZp2jpDK4sBgq6rvdik0/ZJBbMy5bsPEFR26Fwq6
	fhnfmgzqfdDM5W3hvY+pSxBu0jhJ0K+BOlcwyOIDvR3yvFpX/DMq97UQAn3qz4MlWV/uXO3AzlS
	i87gZ5yz61HRSHUsD1ox+wl54F0p1qak7DRa38NZYPbS/+3Olz3eds192CAsolovyLpOZjsSQpG
	fCIDVvGuGUOGzkO3s1euAC9yuc5zC+GQ2g4J82UNcfe+bgQHXjN7Pv0+m2+LGaHlZRM3Q2axWDI
	Bv2S2rFoxzrQzifULaooGZjdk1DU4YwWoi2up/d8pb4=
X-Google-Smtp-Source: AGHT+IGRYV+UG60rJqBbSwqOKynLKXzwmD6z7hkhuYwc5aNlGGGdAvX/ZSdBbVhxuIYRaabOpJ6/cg==
X-Received: by 2002:a17:903:2ad0:b0:223:f479:3860 with SMTP id d9443c01a7336-227f203223fmr157855ad.18.1742925438482;
        Tue, 25 Mar 2025 10:57:18 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:30c7:dc6c:854a:8283])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a27d9a13sm9500536a12.6.2025.03.25.10.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 10:57:17 -0700 (PDT)
Date: Tue, 25 Mar 2025 10:57:11 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 2/5] libgit-sys: add symlink to git repo root and
 build out of tree
Message-ID: <5qvxvuquk2yuyoyoctz2ji6sj4yld4ridig24elpoiytghlovw@a5hgdufrchwr>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Phillip Wood <phillip.wood123@gmail.com>
References: <cover.1742339107.git.josh@steadmon.net>
 <cover.1742594960.git.steadmon@google.com>
 <6befc95a2d0893aa269142a18d60ad07e79c6e88.1742594960.git.steadmon@google.com>
 <CAPig+cQ+05r0iJO3me2=yz1KWaU_S_WQmbeciOqZGxYWgbT8dw@mail.gmail.com>
 <xmqqo6xqo2o1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqo6xqo2o1.fsf@gitster.g>

On 2025.03.24 08:42, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> > On Fri, Mar 21, 2025 at 6:14 PM Josh Steadmon <steadmon@google.com> wrote:
> >> Unlike `cargo build`, `cargo package` does not get access to the entire Git repo
> >> containing a Rust crate. Instead, it prepares a directory starting from the
> >> crate root (potentially excluding files, such as those not under version
> >> control, or explicity excluded in the Cargo.toml file).
> >
> > s/explicity/explicitly/
> >
> >> diff --git a/contrib/libgit-sys/git-src b/contrib/libgit-sys/git-src
> >> @@ -0,0 +1 @@
> >> +../..
> >> \ No newline at end of file
> >
> > Meh.
> 
> https://github.com/git/git/actions/runs/14030831429/job/39278185588#step:3:1
> 
> All of the Windows test jobs (not build ones) are broken due to the
> presence of ../.. symbolic link.
> 
> Is that ugly hack the only way we can make this work?

It's the only way I know of to accomplish both:
1) creating a packaged crate with `cargo package` and
2) keeping the top-level clean of any Rust code or configuration.

If we're willing to have a Cargo.toml file in the repo root, we could
create a "Cargo workspace", but I'm not sure yet if that avoids the same
problem with accessing sources outside of the crates themselves. I'll be
able to test it out later this week.

If the workspace approach doesn't work, the alternatives are:

1) avoid the issue for now; anyone who wants to experiment with
libgit-rs can do so by building from source (but it will prevent them
from creating their own packaged crates IIUC).

2) move libgit-sys and libgit-rs to separate repos and depend on the Git
source via submodules. This is what I've seen done in other -sys crates
such as zlib-sys (https://github.com/rust-lang/libz-sys).

Of those alternatives, I prefer #1 for now. If we build enough momentum
on libification and expanding the coverage of these crates, then we
could think about switching to #2.
