Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48A522619
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 21:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738186854; cv=none; b=Nh9oegVFHATzRBnxB3pqHMVkP5mjFWS4i8JFa9jqNHK6XPKdhAq4Z3pTBYI923HPw6S7mp0afb5G+O8uh6t6tSQQfE/tY0ccqhmeDNm2iG2lG3zgGc3M+yUJjBOIF0KdOM5bmNhwG89ILrR3eW2pkFTVZnl3x8Jb7UEy7fHrs5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738186854; c=relaxed/simple;
	bh=bVHYGL3ZarW8vKXEMXF28rYvCVsgtzJeX5TzyZzIcAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GW3PnBqkqPVQHwH0Xf3zI8aTm6zkcMGQJPQwQHZpNHhxvKy8072S1JGYrsov45z/LsLhR6RM94kcjl7q0wAuc9FtLVFnn+Kf8YQoxUy8iIWSTmLzIOvqA3VqC0o2y/FsRP+drdrjNgFmkwl41sFI+W1Av1yQLyG9RSbrfFlKj4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A8q7hRbE; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A8q7hRbE"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2163affd184so12525ad.1
        for <git@vger.kernel.org>; Wed, 29 Jan 2025 13:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738186852; x=1738791652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIDa04ccsaFYPEAbob4lUV1jxbADttKEiogMOxli8mg=;
        b=A8q7hRbESQyIuu6qLe7Qy/KSP1zUzWt90ruBtqvSQ0xNpVTLt9otBNyjiFj/E6SWHG
         JNxLCpY+B5v15Qf/7Z60P0rxIdscuua/WIoWPqFY0lzINg4MYO4sdB+ZqcfiJigOUPRF
         YFMDt0JlagpIPXKbxHPpHaugaSXqd0L8mgYs28fG0yJs/WVRDWtxBVCFMtNk4NXGE6nt
         oBKJmolFqLGaiZTmMe7tY6v3BBJ1gIKj3PaHgxdCi9TZs0iFWHGtS19dNGZuUzNtFKCw
         e/PGdmmGsg7NXVsJemlvy1XfzrLxIfzaXYVJyG+GH8MzqjnVLHXneHTnszAZb2P5YJQf
         gqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738186852; x=1738791652;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AIDa04ccsaFYPEAbob4lUV1jxbADttKEiogMOxli8mg=;
        b=PSnD97YsYGN6802cYwh615XeBGutIStNhfOmlNyM4vp4V1FsahNWljcXk4e3hCxVuz
         88tmcHfaropI13ZFZAXgaCAbLHHTDuZDaPE3raA68zPcD0oA2fFAHrgkRCvfu4veVbd8
         qBhSv6CCGmG1P7F/MClrXAs8ZO4wrjy0qOv0O8FgA9BnN6+3dXu24GKkBTDLEeqOd/MX
         c10rJ1jTbW9QOhB3wBWOLaNktkyueiUONGPiobj5F6S2pAdDGI3IRRVGI2ihfM8SDfLb
         MCcmvVLTHyU671di1yKKwcLowkh+GTKe64NtIGlJW9aWt02GVUTqMOSnhDoXz+vRYQYU
         HTug==
X-Gm-Message-State: AOJu0YzXt1lOeiKgf/zDN9JTMpVFn/xIqppN3TbNYv9BGIrw9yDNDbwS
	fxaoyqQY/FVPSsVKhnanMSF/jqjAGu/OKg/xa1WR/24CXLLDwLFKUgte2zCCbg==
X-Gm-Gg: ASbGncvKwlT7gPpxDs1enIT0BEjP8Rll4np4TtqOdga9AmTHVvp8mJz9mKiSOkDrIbJ
	X4yGYRbh/GQPbv491XcIbzWG9YEmBuTg8odYvIuA2tuSIWaJG7tgyEOFhkmHe9TLH0CpdKhpS8y
	vH21ZaEsPPlQ5Tcyk9U3L2S54pI6d3LaD9lH76dxzXFKhSIvIehvQ4w0eOkklzw2g5TfDOMy2oO
	JJenBNx0aVXWubvQvRjB6NLPvv8xBwmLP0ORamsEn1/KM/wCJcnjbu0tQAqihuBDZJ16C4xuclc
	wObmbJHnBc994w==
X-Google-Smtp-Source: AGHT+IHjTzg5JcVUP1t0ukvQR1inG+YLpvvt6O7zTwY7DjYggWvx87ZCvEMyWtemYO4dPTHqy1hGqw==
X-Received: by 2002:a17:902:cf11:b0:21d:dba1:dd72 with SMTP id d9443c01a7336-21de369723bmr91185ad.15.1738186851735;
        Wed, 29 Jan 2025 13:40:51 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:5d5a:f768:336e:8f6b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bccd590sm2321057a91.12.2025.01.29.13.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 13:40:50 -0800 (PST)
Date: Wed, 29 Jan 2025 13:40:46 -0800
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, calvinwan@google.com, nasamuffin@google.com, 
	emrass@google.com, sandals@crustytoothpaste.net, ps@pks.im, 
	phillip.wood123@gmail.com
Subject: Re: [PATCH v8 2/4] libgit-sys: introduce Rust wrapper for libgit.a
Message-ID: <xie3u2fhhkuhwezhi23ivs2wuzkkxt2drnq6jvcjb7432hqiol@du4wavlj3imv>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, calvinwan@google.com, nasamuffin@google.com, 
	emrass@google.com, sandals@crustytoothpaste.net, ps@pks.im, 
	phillip.wood123@gmail.com
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1738101256.git.steadmon@google.com>
 <3588a3c3fc76fd2a98b89e837dae07fd97fb88af.1738101256.git.steadmon@google.com>
 <xmqqcyg6mudv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcyg6mudv.fsf@gitster.g>

On 2025.01.28 14:43, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > diff --git a/Makefile b/Makefile
> > index 27e68ac039..f2c08df4cb 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -416,6 +416,9 @@ include shared.mak
> >  # Define LINK_FUZZ_PROGRAMS if you want `make all` to also build the fuzz test
> >  # programs in oss-fuzz/.
> >  #
> > +# Define INCLUDE_LIBGIT_RS if you want `make all` and `make test` to build and
> > +# test the Rust crate in contrib/libgit-sys.
> > +#
> >  # === Optional library: libintl ===
> >  #
> >  # Define NO_GETTEXT if you don't want Git output to be translated.
> > @@ -657,6 +660,8 @@ CURL_CONFIG = curl-config
> >  GCOV = gcov
> >  STRIP = strip
> >  SPATCH = spatch
> > +LD = ld
> > +OBJCOPY = objcopy
> >  
> >  export TCL_PATH TCLTK_PATH
> 
> Good.
> 
> > +LIBGIT_PUB_OBJS = contrib/libgit-sys/public_symbol_export.o
> > +LIBGIT_PUB_OBJS += libgit.a
> > +LIBGIT_PUB_OBJS += reftable/libreftable.a
> > +LIBGIT_PUB_OBJS += xdiff/lib.a
> 
> This is a fairly minor point, but if we look at the places where
> OBJECTS, PROGRAMS, and friends are prepared in the Makefile, they
> all start with empty, i.e.
> 
> 	LIBGIT_PUB_OBJS =
> 
> at a fairly early place in the file, and then appends real contents
> to the symbol with += assignment.  It probably makes sense to follow
> suit, although the result would be the same.
> 
> Other than that, nothing jumped at me as fishy.  Nicely done.
> 
> Thanks.  Will replace.

Ack, will send a V9 soon with this & a fix for Phillip's feedback.
Thanks.

