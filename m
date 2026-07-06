Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64A63AFAED
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 10:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783334990; cv=none; b=SKQhReYUMrmQ3sQR2sUx1tzYbakSkH2EvHjXEjcFIslw1IJWjbEKxnwy3nr/a9H1QkZttMRINcDZkHPB7OebSTM3IMP8qaaT10MCSszNw7Qnypy98hMUvbyMs/CvnVeWYE87Oy1s5JnE4EqGL0/O0z9Dulvt0fgHVrg41uKj/vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783334990; c=relaxed/simple;
	bh=PtUu6WF79gvWEFWmYHin9HXIy9xcev5A5brdf2zjRW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjscQoH5Qp2zX7SiSnJ9TXwVXmDcQ8CxlUaYBwrIfa2u8XCQUAHjqbTtCbvErP9xMniED0fO5WEGjwo81nxvizqTLpFfSKM4cvsef0QgbZSkWFnpUpmbBsib4UsOourMC+LfemZ3HUPyb9KjbTLPzT15mtTVasZfxP2uEshtWJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N0IokNpw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gaqSuRc3; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N0IokNpw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gaqSuRc3"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id E88831D00124;
	Mon,  6 Jul 2026 06:49:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 06 Jul 2026 06:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783334987; x=1783421387; bh=vzMz2shuzS
	vHsZURfTrLBEC/GZ5Qji63xm3SwYUxesU=; b=N0IokNpwokKcsTbgKf1NbUirOh
	+E6sEU3vSQ8DbXe5RUP8YHlQ2lsZOzlBwKeT5i+IXtxbOL3/5fGuJCkzXPu+JVJw
	1S8v1/3o8yW9Ux+OuFAh08/+NL72CncMFUyFj7MUKlNABNztyAQFr05s5J19o/Yc
	vOjHpuBmYAyKnYa1g67wzU1ceGTkPw8+gBL2Iouq8nQ+lNZsyd9Va3YpTC+t3dns
	grl+6EzvHelh777lyyFRORlHqOfCaxCQYoJGRTTIa5swogyWWbmnj8ZWlQPqx0JE
	yeVY33XCcDsvYi4xXmxdJCIDa+u1CZSI+JIYcEiAW8b8Kmm0gT0JnclxjYhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783334987; x=1783421387; bh=vzMz2shuzSvHsZURfTrLBEC/GZ5Qji63xm3
	SwYUxesU=; b=gaqSuRc32deSWfWC4KY785W4XUm1o/KJq4s4efOgx9BGyRfjEc9
	1+kJXVGNytjn+2bUxA2MjOP0tBYDCdHJqEvnN5xC0rxRBjXsRPGp0VUUnNwYZQDO
	oWKQSsbl0zXS8vAb+7hbnq8BFo9ZK4fiOu5vgoXBNsCmhaf6OrBcmlLO5GIwG4Fy
	pURICu2dcbPvHvWgP6HO+7/TNrMjDyD6CzkwzSIS6loYC7DCgEn5qXCMxx0eBpRv
	mx3b2HJDcJhDrFnmNAgi/cjioMRN6U6kvGywDrWrK7BrrxRavrBRA7g5iLkUGeHH
	yVJAjVKcBLNmiCbMsUmhwX+X5uD45fyjHLw==
X-ME-Sender: <xms:S4hLaiUvuhJ-B3WaFn_e7gbfiG-oRaeW73fl93Sivomotww65jlZAw>
    <xme:S4hLalc36uamrgn0LnO9EcCU5in9vFXwh-bVfaTrog8_gugjETKoy2mJb5Wik3l0V
    E0KVqoxUGwx9CJN18_kaoaC2xw2dHIrMr0H7H9cW_yOCLnB3GhaVg>
X-ME-Received: <xmr:S4hLautMuNj7LrYSqjq4YY26AwLyqxpN8sl42jyxKp-iNAkvda9oO1MkbAymV3r0X8ak1r1itcrp9_6512jdm5Yjjm2SW2wBj9y0hHlT2xU>
X-ME-Proxy-Cause: dmFkZTFD10TcuDPAH0cNPpo52DhWt8u1rrOL7/OIeHoKTIvCvIdckXJpBmr2UXeFwFvYrD
    z+0W/4MUnM+ru2eRQexz3unX8Z9Q8Vy27RUXusUOhxK4ycDXB/eAPwbk+6RAKGczbMoZPR
    fGxDn/cg1Y9n4WifAw65C/KqnRJ3vzKG/6w+uqeCZ6JI9VGxmPalJWojIkEZTLone+CFHN
    x0XkFIRlXzTnaPyfcVqwFfCX7P9AlMk5qwJz+I75WeyeQ7jUCGPmL1tVZm8yfqTVEjDJd0
    Qn3HNh1MXd1guxwVvs08hTCKZ9cNZrwp/j4R8eIz4Eo/mhqz0ku9UJJlNtoSz6G8t6Crcj
    OrZq/7avnp9XyZi+F3MEYuI4CsgWmgQoJ87SVAIiezgd7vWqDofPEEV5jGFce7JrL+9uaB
    4vhoS1FeW/lw0xCc/lKg/0btYlsewjnoEu8+LLbkRrlJ/soIJA0dyfiXVGa1EL3LCYg+Pl
    bwxlA6Yd1VHnWy3TDYWOf+nIsbYZ6/UmtentaYtajiL/uWMr5llOlaNdG9I1iMYZZ3Unrf
    ok0mdMJyL2ixhW3n+sgsFJIu0OBbvHry4WOImtAaKJClGEU76I+CSD4BXvV91owMqrmxEn
    Hg6BvcNK0plh/4XujiaDM7TenlgX8f1H/O5RxtxA9tVlzsQVSr3JANDCnEVQ
X-ME-Proxy: <xmx:S4hLak8M2ROTmBl6eOmoRvTAvqQ5VoJ_n6iSi23BaKSkyRcgTr2AkA>
    <xmx:S4hLap30YoSAgZSyH4pAOD1DyAQVGLxuc55-uiJadyBTHHzvGBh5dw>
    <xmx:S4hLapCOn_AqY9QCp5iF2lu-YzgHkLVr8TzZrUeHcv-XgGK1qVRy-Q>
    <xmx:S4hLaldb_nDIdp06NnNELLXoszXLykSVpy30z674N50sA0YutpyGaw>
    <xmx:S4hLahYBTHua6Vxgvy5IGWGMDZYwOlW0FCeaSRXOgHf3QLoz4oQHMIm1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 06:49:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 484e459f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jul 2026 10:49:39 +0000 (UTC)
Date: Mon, 6 Jul 2026 12:49:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Shardul Natu via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Shardul Natu <snatu@google.com>,
	Koji Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH v4 2/2] Makefile: support universal macOS builds via
 RUST_TARGETS
Message-ID: <akuIQADP_aRb5pY6@pks.im>
References: <pull.2288.v3.git.git.1783030971.gitgitgadget@gmail.com>
 <pull.2288.v4.git.git.1783188355.gitgitgadget@gmail.com>
 <88fc2e0bd88756a07467bdaf75f6a344d2e58b41.1783188355.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88fc2e0bd88756a07467bdaf75f6a344d2e58b41.1783188355.git.gitgitgadget@gmail.com>

On Sat, Jul 04, 2026 at 06:05:55PM +0000, Shardul Natu via GitGitGadget wrote:
> From: Shardul Natu <snatu@google.com>
> 
> On macOS, Universal Binaries contain native executable code for
> multiple architectures (such as Intel x86_64 and Apple Silicon arm64)
> bundled into a single file. This is standard practice for macOS
> distribution and CI packaging (such as internal distribution packages
> or tooling like Burrito/Homebrew), allowing a single build artifact
> to run natively across all Macs without Rosetta emulation or
> maintaining separate packages.
> 
> When building Git C code for multiple architectures on macOS, the
> Apple toolchain (clang) natively supports universal builds via
> CFLAGS/LDFLAGS. When "-arch x86_64 -arch arm64" is passed, clang
> automatically compiles and links universal binaries for all C object
> files and executables out of the box.
> 
> Cargo and rustc, however, do not support multiple "-arch" flags or
> emitting universal binaries in a single invocation. Instead, Cargo
> requires invoking each target triple independently (e.g., passing
> "--target x86_64-apple-darwin" and "--target aarch64-apple-darwin").
> 
> To bridge this gap when Rust is enabled:
>   1. Allow specifying space-separated target triples in RUST_TARGETS.
>   2. Introduce declarative pattern rules (target/%/...) to compile
>      each target-specific library slice via Cargo.
>   3. On macOS, if multiple targets are specified, use "lipo" (part of
>      the mandatory Xcode Command Line Tools) to combine the resulting
>      static libraries into target/release/libgitcore.a.
>   4. Ensure target directory creation before invoking lipo via
>      mkdir_p_parent_template.

Nit: The last item really is quite uninteresting in the bigger scheme of
things.

> Once $(RUST_LIB) is compiled into a universal static archive, the
> standard C linker seamlessly links it with the C object files to
> produce universal Git executables.

Okay, this overall reads a lot better now.

> diff --git a/Makefile b/Makefile
> index 7db38ecce9..ecada0acb4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -500,6 +500,14 @@ include shared.mak
>  #
>  # Building Rust code requires Cargo.
>  #
> +# Define RUST_TARGETS if you want to cross-compile. If left unspecified, it uses
> +# the default rust target on the system.

s/rust/Rust/

> @@ -3022,8 +3031,30 @@ $(LIB_FILE): $(LIB_OBJS)
>  	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
>  
>  ifndef NO_RUST
> +ifeq ($(RUST_TARGETS),)
>  $(RUST_LIB): Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
>  	$(QUIET_CARGO)cargo build $(CARGO_ARGS)
> +else
> +ifneq ($(words $(RUST_TARGETS)),1)
> +ifneq ($(uname_S),Darwin)
> +$(error Building universal Rust libraries requires macOS (lipo is not available on $(uname_S)))
> +endif
> +endif
> +
> +RUST_MEMBER_LIBS = $(foreach target,$(RUST_TARGETS),target/$(target)/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME))
> +$(RUST_MEMBER_LIBS): target/%/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME): Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
> +	$(QUIET_CARGO)cargo build $(CARGO_ARGS) --target $*

With this we now have both:

    - target/$ARCH/$BUILD_CONFIG/

    - target/$BUILD_CONFIG/

Is there any reason why we have to have those two different layouts
instead of swapping the order in the first item so that all artifacts
are in "target/$BUILD_CONFIG/"? Essentially, what I'm proposing instead
is:

    - "target/$BUILD_CONFIG/" for the final universal executable.

    - "target/$BUILD_CONFIG/$ARCH" for the per-arch artifacts.

Patrick
