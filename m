Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C757E40849
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 21:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728510806; cv=none; b=o14qPvhcnqdE45blIlzqD4HFrAptSb7bHqg9kDMRHZlgvNoocIPWBR6IfYqoTFtND07AHDERmvAYLfIiUc/v611si8RYeQHUlGfxpmCom0Rq3G+/u3ctX0ZFp27tq7nRwiw2QywhPpy188yF4cRveRom0b52OA5dhKtb67VrWbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728510806; c=relaxed/simple;
	bh=eWRBKfjru4YmUsE6pKFhPFTZCE1DSyWqiD5OJPvhtHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFv93Lfl9rDPSiJy5oZF1U/+Wd2TIyMCJRwBkgnsdhrS6lxrlLi+iA/56G0TPaoQoJRHxyc3D2DcCi/706Jhznnmp20zE1lySEYaxXN4OOoVOawhbqSOo0N1rp3G3jWIEkMg8mfZTyi3v2r9ApTawNLfsyxEsONqEErtUVyNRV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KPW+gPIY; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KPW+gPIY"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20c5fdd0fe3so73005ad.0
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 14:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728510803; x=1729115603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2DbDsqeELN9Az1Na8mV277gsiz7Id+Wi70oh5rkMiLA=;
        b=KPW+gPIY2dSrczTzzpPXiuabnZS0Wm6SB/eATa3fcSwJodsueHeM/AtlKKxZB4w8X8
         mZ15qfZ14U7dWiWlFpYYl2sQErBPKLDCaTPirHdRC/EbocbAXbtW24IGRx70IbpbKQuq
         8Em/6nDaWztD82wMvh1RtOGC2DqZsnN7pCX/txbpmmHhk7EwxR4ZvoEN0LIzgbjcykhv
         ZhoeUGvzmPOXY/VT3FEUWSOZkAfVRbS6Cc5AXdqdHl7O5Bst4KaKO/vaY3dNj3lBeHTq
         dz2mezKNYT/XO1e0acHVOoFau7F3JBdUC4XyJCURwWglF+LWQT/Qk+OOoFZA5fiXbMPP
         Qo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728510803; x=1729115603;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2DbDsqeELN9Az1Na8mV277gsiz7Id+Wi70oh5rkMiLA=;
        b=oKEsrAYWOSH3G7xvBAeaVPEpnbMaUSa3lQg4w0XVacIO924FSdHIND2xFacqnqoJWE
         viFj1xVSZLurxqvIzmZ/GGLvpb24T1Yid4a8aklIJsLyR49lP7sju4a2igMpZ1MPoaFa
         fQJhgLxUXeMkfCCdXvH7kjJ7O2kese7dLVIVTgT4C4/RYtOpoZXG/N5co8gBpbyt8Vn9
         LKDbDDg469aT6w7TyfRDmfOkGxk+2ZTtelDKMS+3zi3uX4pXO0rQ420HqPwMONtd33x9
         kbHduXeUSPJgGdaq8JNUqr5RjrRuSngU7q7K5RltgxEc+l+h5Q0lJ24NpDF7dosNNTQc
         g/SQ==
X-Gm-Message-State: AOJu0Yy6kmVXGH17txtu2g1B7908FzFYJ7F1HEUoN0tgFLVNNCApyh4A
	l47rE5Xnua/IxFI62UVb/ST5B+ZgOJ+4z3jDbAenct5Z4hVHSdVsyEFs9/gZfY3/PnUX/6+IlZO
	3NQ==
X-Google-Smtp-Source: AGHT+IFzXma7IB36VHTIPp7clZTyjxUItyW0YG7wO8ge3/KMfb2CP7Zk0x1LpdnN+q3T88O0OpKrrA==
X-Received: by 2002:a17:902:cec2:b0:20b:b48d:6ae with SMTP id d9443c01a7336-20c8720e49cmr326375ad.13.1728510802853;
        Wed, 09 Oct 2024 14:53:22 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:4268:1c66:e2c:2ffb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a5751d75sm2240938a91.25.2024.10.09.14.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 14:53:22 -0700 (PDT)
Date: Wed, 9 Oct 2024 14:53:17 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, mh@glandium.org, sandals@crustytoothpaste.net, 
	ps@pks.im, sunshine@sunshineco.com, phillip.wood123@gmail.com, 
	allred.sean@gmail.com
Subject: Re: [PATCH v4 5/5] Makefile: add option to build and test libgit-rs
 and libgit-rs-sys
Message-ID: <yynolodpcv43doqcab4bin7z7gembixqfhvqdzpcoeipnyjwl4@ek3gr4l2ycrr>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, mh@glandium.org, sandals@crustytoothpaste.net, 
	ps@pks.im, sunshine@sunshineco.com, phillip.wood123@gmail.com, 
	allred.sean@gmail.com
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1728429158.git.steadmon@google.com>
 <2ed503216f8e14d7b516c488caf3c76ffcb15697.1728429158.git.steadmon@google.com>
 <xmqq7caixhz0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7caixhz0.fsf@gitster.g>

On 2024.10.08 17:01, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > From: Calvin Wan <calvinwan@google.com>
> >
> > Add libgitrs, libgitrs-sys, libgitrs-test, and libgitrs-sys-test targets
> > to their respective Makefiles so they can be built and tested without
> > having to run cargo build/test.
> >
> > Add environment variable, INCLUDE_LIBGIT_RS, that when set,
> > automatically builds and tests libgit-rs and libgit-rs-sys when `make
> > all` is ran.
> >
> > Signed-off-by: Calvin Wan <calvinwan@google.com>
> > Signed-off-by: Josh Steadmon <steadmon@google.com>
> > ---
> >  Makefile   | 16 ++++++++++++++++
> >  t/Makefile | 16 ++++++++++++++++
> >  2 files changed, 32 insertions(+)
> 
> Interesting.
> 
> I tried
> 
> 	$ make INCLUDE_LIBGIT_RS=YesPlease
> 
> which did not fail, and then did the same
> 
> 	$ make INCLUDE_LIBGIT_RS=YesPlease
> 
> and was surprised to see that not only the libgit-sys part but
> everything was recompiled and rebuilt.
> 
> > diff --git a/Makefile b/Makefile
> > ...
> > +.PHONY: libgitrs
> > +libgitrs:
> > +	$(QUIET)(\
> > +		cd contrib/libgit-rs && \
> > +		cargo build \
> > +	)
> > +ifdef INCLUDE_LIBGIT_RS
> > +all:: libgitrs
> > +endif
> > +
> >  contrib/libgit-rs/libgit-sys/partial_symbol_export.o: contrib/libgit-rs/libgit-sys/public_symbol_export.o libgit.a reftable/libreftable.a xdiff/lib.a
> >  	$(LD) -r $^ -o $@
> 
> I can see libgitrs is a phony target designed to run every time it
> gets triggered, and I would imagine "cargo build" itself would avoid
> repeating unnecessary work, but I do not see this patch screwing up
> with the dependencies for other object files.
> 
> Is it fair to say this is still a WIP?  Showing a WIP to others and
> asking for help is OK, but it is fair to make sure that others know
> what is expected of them.

Hmm, I think this may be an unfortunate interaction between Git's `make
all`, followed by libgit-sys's `build.rs` calling make again (with
different CFLAGS, specifically '-fvisibility=hidden') to build
libgitpub.a. So then the second `make all` has to rebuild everything due
to changing the CFLAGS back, and then libgit-sys has to rebuild
libgitpub.a once again.

Unfortunately, I don't see a way around this problem, at least with our
current approach for building libgitpub.a. We have to pass
'-fvisibility=hidden' when compiling each source file, not just at link
time, so I think the object files created when building vanilla Git will
necessarily differ from those created when building libgit-rs.

I think that means we'll need to drop this patch for now, and revisit
if/when we change our libgitpub.a strategy.
