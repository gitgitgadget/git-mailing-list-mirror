Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAC818E0E
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 20:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712782737; cv=none; b=MCRkpAQAz1XYem67Y7v785x18J3pgqq3DTlH54yaPG39S/5tJyc2FlgiiF3in6cGCmZU0Xc0aIcej5TVrdgVsKpk7nGHZCuvPyOe4OKqhCIFOix9tTYCIiDUKxpS6f5SO2as4TdcBDzzPClp0ch8UCzmMcVaEHlRPsANNBFZAnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712782737; c=relaxed/simple;
	bh=FEgNuk+4zxpUh78xFf/8RtlV/CBw70yj3n9ctSOXzEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmu58AJI4BPGFGppdV2Cmqg+VK4raBSbBmtpUIl76CjZL9AucpRUoV7AqInkk+bV/RCgdN4q20JO0u91jEKv5O4aixm5sIxYzy//apL6TjVMOZgzvA0l5eljUVoU2QFZs2bwf6I5yudB6tG8qSWdAvm7lo8x06oMqvpSh06vbOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jsDOT5cZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jsDOT5cZ"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e2b1cd446fso52949465ad.3
        for <git@vger.kernel.org>; Wed, 10 Apr 2024 13:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712782735; x=1713387535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJLEnne6UkMd10kXikjP/27udfaMOjBsOHVcGjyuBPI=;
        b=jsDOT5cZxp7mpniRCfSzOgOA/nWaKp/rNG1JFZViWmUXboapWcNDw2sMaT+TlCQhsA
         jUgEQHJeAy7tGPBfyRYcQx4zlJWulvVj7S7j6jlr7wQ8y0RvomQCDJRPgX3+CzMT7JW3
         KIK0EjAdzdDOwNZGJkUOagBjfW3Fmimhyj5RAuQ1Sa5PzpQX8hnIDeLVY0pWxea3UKFG
         xyMSC10NGIOmKNr4OjgqVzVlCXWgl+9sZFXu3aRZImTHvrL2yBvOD9xAmxJ56jjKK0lP
         hH9GciL+2zDeFNKO7X7ZJYmN9zZE1VTDj8yi4SotdsJ8lxPcnHKfciCvQKl2a6Sl0jDD
         mgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712782735; x=1713387535;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OJLEnne6UkMd10kXikjP/27udfaMOjBsOHVcGjyuBPI=;
        b=FFqZmyIp7QGcQGQAusw7c0Qs6L0GYFlCx/cWPzyO0Fw3gBFuD3011cXkCm64M702nQ
         ym4nehgCXeM4P+/E86VXZ3AiimtoPxfatZUsnCx96JEviK99eFucqN2zRtscVhccrZ71
         Ec1fEdjIdsNcK13dgpO+EHYlqOnmoZ0dKrH3mbKMSjXQgrassxSOl+7Nj4kps8YHJxZ0
         AfOhKyt5NSHh1h08HkFnzUqDYsyqa1LH8tU+IxsLdOvRbHWNnElEynUEdSQItI/yxKiE
         EiwLUvHCWVbcflyWHdLIBg0UiBwGuxrp3hnmY1ovE9C6WeK8OXQYi1uCpRGyzrpcRD+j
         bVWg==
X-Gm-Message-State: AOJu0Yys352nrtVta9JV1HIyebyaU9/HmuJnMln4XU1YLWj8q5ssaaCb
	6YbxOEOb+fJmWaJZJilLU7QL+EqNvI4raJq+YKfB0Ej24haKNRINRbssIDSJcQ==
X-Google-Smtp-Source: AGHT+IHL5oTrvCTQEAnqNkh3fTFCDAqwsqqr+H7HrmojcJHKHDFNj1K12MIfYkDtO4eOwVU10nMk6w==
X-Received: by 2002:a17:902:e84f:b0:1e4:c75e:aae2 with SMTP id t15-20020a170902e84f00b001e4c75eaae2mr4911162plg.59.1712782735157;
        Wed, 10 Apr 2024 13:58:55 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:bac7:cc84:8615:9b55])
        by smtp.gmail.com with ESMTPSA id u8-20020a1709026e0800b001e0e5722788sm11465780plk.17.2024.04.10.13.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 13:58:54 -0700 (PDT)
Date: Wed, 10 Apr 2024 13:58:50 -0700
From: Josh Steadmon <steadmon@google.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] ci: also define CXX environment variable
Message-ID: <Zhb9ioeICP6FRJlu@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
References: <cover.1709673020.git.steadmon@google.com>
 <75f98cbf98005b0a069977096ec5501f2f7830fe.1709673020.git.steadmon@google.com>
 <20240306005057.GC3797463@coredump.intra.peff.net>
 <20240306010016.GA3811328@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306010016.GA3811328@coredump.intra.peff.net>

On 2024.03.05 20:00, Jeff King wrote:
> On Tue, Mar 05, 2024 at 07:50:58PM -0500, Jeff King wrote:
> 
> > On Tue, Mar 05, 2024 at 01:11:59PM -0800, Josh Steadmon wrote:
> > 
> > > In a future commit, we will build the fuzzer executables as part of the
> > > default 'make all' target, which requires a C++ compiler. If we do not
> > > explicitly set CXX, it defaults to g++ on GitHub CI. However, this can
> > > lead to incorrect feature detection when CC=clang, since the
> > > 'detect-compiler' script only looks at CC. Fix the issue by always
> > > setting CXX to match CC in our CI config.
> > > 
> > > We only plan on building fuzzers on Linux, so none of the other CI
> > > configs need a similar adjustment.
> > 
> > Does this mean that after your patch 2, running:
> > 
> >   make CC=clang
> > 
> > may have problems on Linux, because it will now try to link fuzzers
> > using g++, even though everything else is built with clang (and ditto
> > the detect-compiler used it)?
> 
> Also, if the answer is "yes": do we really need a c++ linker here? My
> understanding from reading "git log -SCXX Makefile" is that when using
> oss-fuzz, you'd sometimes want to pass c++ specific things in
> FUZZ_CXXFLAGS. But we're not using that here, and are just making sure
> that things can be linked. Can we just use $(CC) by default here, then?
> 
> Something like:
> 
> diff --git a/Makefile b/Makefile
> index f74e96d7c2..3f09d75f46 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3861,17 +3861,18 @@ cover_db_html: cover_db
>  #
>  # An example command to build against libFuzzer from LLVM 11.0.0:
>  #
> -# make CC=clang CXX=clang++ \
> +# make CC=clang FUZZ_CXX=clang++ \
>  #      CFLAGS="-fsanitize=fuzzer-no-link,address" \
>  #      LIB_FUZZING_ENGINE="-fsanitize=fuzzer,address" \
>  #      fuzz-all
>  #
> +FUZZ_CXX ?= $(CC)
>  FUZZ_CXXFLAGS ?= $(ALL_CFLAGS)
>  
>  .PHONY: fuzz-all
>  
>  $(FUZZ_PROGRAMS): %: %.o oss-fuzz/dummy-cmd-main.o $(GITLIBS) GIT-LDFLAGS
> -	$(QUIET_LINK)$(CXX) $(FUZZ_CXXFLAGS) -o $@ $(ALL_LDFLAGS) \
> +	$(QUIET_LINK)$(FUZZ_CXX) $(FUZZ_CXXFLAGS) -o $@ $(ALL_LDFLAGS) \
>  		-Wl,--allow-multiple-definition \
>  		$(filter %.o,$^) $(filter %.a,$^) $(LIBS) $(LIB_FUZZING_ENGINE)
>  
> 
> -Peff

Indeed, it does break, and this is a good fix. Thanks for the catch!
