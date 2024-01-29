Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985D876040
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 20:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706559727; cv=none; b=XlveN4rfAq6W0i2Q9xtAXn7JHEebt9O+m2JDhwL6aG+IubHG/xHs+Xg2gYZkyKNIVhwPqLLJvAgLCbLmMh/JDMuCJeHiNX6ZkKu5yumYhdRrcHvKuqcX02xP2gRJnip7kfxS/JBpSB5zlSkmC8SNGCG6H0GUVqSn/HFEv96IdCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706559727; c=relaxed/simple;
	bh=7G+YxWEJa4/Dzz90ldQaZPVmRIHLXqW+lpuhvmkzRR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsK5UWga7soL961YuWh27ly1JEciYjA27HQXX8SIiJb94o3zqfoiqrGkgFNIH5N96sqq/ayydd2MET3DOuKyYmSRchccrhDuIXEsT04dOb04tWUorOO5nS8tXX6Ji9SLrgSeiHkODioGMbix/fzYDQ0kvNvIWpuFFqJmZHWNWFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBbR0Re0; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBbR0Re0"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a35e9161b8cso139193466b.3
        for <git@vger.kernel.org>; Mon, 29 Jan 2024 12:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706559723; x=1707164523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jezDbWY957VWqJdeWN6l2cVkrX/C3iUCNlTBSQesf00=;
        b=nBbR0Re0T8XFNdvZnfnc0U3Lr4SHP+T2X2s7pGttxVuZNYK4sD1zTookfe0Ftq4mfi
         zeUd4BRE/BfiodoMJWuiXKNfPrj2GU4ojUpr6rx5WAAhIyJ6gbCEeaBidulL2gZpBa4y
         tBMBbGt/VzGeR5m+0ksFnlTZGu/bqyLxFfVS9ODZC2XsHzmRA1e4Ja1D8J0FyJvQolxq
         KECC+jtIE9j0uyfuoeLqDsv0kGV3sgF6aOmr/R969jG2GNqt9nVzHb6qUI7lRoxr1dUy
         8tStiv+dQorkdqbLQgTrhgE4y+q/mcE8nvXZOJg22kUvRjeE7zZke1Ow8H8rIolEBF8G
         R9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706559723; x=1707164523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jezDbWY957VWqJdeWN6l2cVkrX/C3iUCNlTBSQesf00=;
        b=JacYAdsJ1zFKuEn+r30V8hRgl/JcteqOYHJs3G38BnsaA7bKsioWddxr2Ag0iGQj1u
         rfnJ0seqeKFvrdYkJsA4HLCCoMAtXSN4CYIk2HaLM8ZF24tDgXlpeyVegKUZ/jgYyyWT
         jtpBTAAT3W0jjouDhTYb82/5ixCpeNnDxEABLjGjftVQd3jo1/Koefwi1is33LTc/byA
         /m5uUKjZs0PBP6KfF2sOY91VkpMs5IpqHh0qFBvMEdiVlU82jAiPG1AQEhW1j0dKEMF3
         lXTkIpLAJmTFOX9XlJFvuRGwb68lgPrYLRgY+oS6z+Wderj/VkL7yUXdF4MajskEIriB
         xdDA==
X-Gm-Message-State: AOJu0Ywwt/F2pbMFrFVyj9kfQEhaDjJQvEd4/mZlBE7nx7zRADLJIl6U
	FgYAF+bjSxp1ksca1vp3/U3CQ5XpdEPzxHsUh5A8sMij3X+/DIKF
X-Google-Smtp-Source: AGHT+IE9wY5hm8Z6RQS07YT5bECBnNknhWeSF/j99xuFtUdvcP0li+qteCTEUcCa687GecvBMP8YRg==
X-Received: by 2002:a17:906:494a:b0:a35:a4c9:fcb2 with SMTP id f10-20020a170906494a00b00a35a4c9fcb2mr2764542ejt.6.1706559722466;
        Mon, 29 Jan 2024 12:22:02 -0800 (PST)
Received: from localhost (84-236-109-111.pool.digikabel.hu. [84.236.109.111])
        by smtp.gmail.com with ESMTPSA id a5-20020a17090680c500b00a35d2dfc77esm1046395ejx.205.2024.01.29.12.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 12:22:02 -0800 (PST)
Date: Mon, 29 Jan 2024 21:22:01 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/2] Makefile: use order-only prereq for UNIT_TEST_BIN
Message-ID: <20240129202201.GA9612@szeder.dev>
References: <20240129031540.GA2433764@coredump.intra.peff.net>
 <20240129031816.GA2433899@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240129031816.GA2433899@coredump.intra.peff.net>

On Sun, Jan 28, 2024 at 10:18:16PM -0500, Jeff King wrote:
> We build the UNIT_TEST_BIN directory (t/unit-tests/bin) on the fly with
> "mkdir -p". And so the recipe for UNIT_TEST_PROGS, which put their
> output in that directory, depend on UNIT_TEST_BIN to make sure it's
> there.
> 
> But using a normal dependency leads to weird outcomes, because the
> timestamp of the directory is important. For example, try this:
> 
>   $ make
>   [...builds everything...]
> 
>   [now re-build one unit test]
>   $ touch t/unit-tests/t-ctype.c
>   $ make
>       SUBDIR templates
>       CC t/unit-tests/t-ctype.o
>       LINK t/unit-tests/bin/t-ctype
> 
> So far so good. Now running make again should build nothing. But it
> doesn't!
> 
>   $ make
>       SUBDIR templates
>       LINK t/unit-tests/bin/t-basic
>       LINK t/unit-tests/bin/t-mem-pool
>       LINK t/unit-tests/bin/t-strbuf
> 
> Er, what? Let's rebuild again:
> 
>   $ make
>       SUBDIR templates
>       LINK t/unit-tests/bin/t-ctype
> 
> Weird. And now we ping-pong back and forth forever:
> 
>   $ make
>       SUBDIR templates
>       LINK t/unit-tests/bin/t-basic
>       LINK t/unit-tests/bin/t-mem-pool
>       LINK t/unit-tests/bin/t-strbuf
>   $ make
>       SUBDIR templates
>       LINK t/unit-tests/bin/t-ctype
> 
> What happens is that writing t/unit-tests/bin/t-ctype updates the mtime
> of the directory t/unit-tests/bin. And then on the next invocation of
> make, all of those other tests are now older and so get rebuilt. And
> back and forth forever.
> 
> We can fix this by using an order-only prereq. This is a GNU-ism that
> tells make to only care that the dependency exists at all, and to ignore
> its mtime. It was designed for exactly this sort of situation (the
> documentation example even uses "mkdir").
> 
> We already rely on GNU make, so that's not a problem. This particular
> feature was added in GNU make 3.80, released in October 2002. This is
> obviously quite old by date, but it's also worth thinking about macOS,
> as Apple stopped updating packages that switched to GPLv3 tools. In this
> their dev tools ship GNU make 3.81, which is recent enough.
> 
> If it is a problem, there are two alternatives:
> 
>   - we can just "mkdir -p" in the recipe to build the individual
>     binaries. This will mean some redundant "mkdir" calls, but only when
>     actually invoking the compiler.
> 
>   - we could stop making the directory on the fly, and just add it with
>     a .gitignore of "*". This would work fine, but might be awkward when
>     moving back and forth in history.

A third alternative is to use $(call mkdir_p_parent_template) in the
recipe and get rid of the thus unnecessary UNIT_TEST_BIN dependency
and target.  It will only run mkdir when needed, and it's a well
established pattern in our Makefile, so you won't have to spend a
paragraph or two arguing about potential problems with GNU-isms :)

On a related note, 'make clean' doesn't remove this 't/unit-tests/bin'
directory.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I may be overly paranoid about the ".gitignore" strategy. I feel like
> I've been bitten by this in the past by things switching from source to
> build (I think with git-remote-testgit). But that's an actual built
> file. Git would probably be OK with the "bin/" directory coming and
> going as a tracked entity, because the index really only cares about
> the file "bin/.gitignore". Still, this make fix was easy enough.
> 
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 1a62e48759..958f4cd0bf 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3866,7 +3866,7 @@ fuzz-all: $(FUZZ_PROGRAMS)
>  $(UNIT_TEST_BIN):
>  	@mkdir -p $(UNIT_TEST_BIN)
>  
> -$(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o $(UNIT_TEST_DIR)/test-lib.o $(GITLIBS) GIT-LDFLAGS $(UNIT_TEST_BIN)
> +$(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o $(UNIT_TEST_DIR)/test-lib.o $(GITLIBS) GIT-LDFLAGS | $(UNIT_TEST_BIN)
>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
>  		$(filter %.o,$^) $(filter %.a,$^) $(LIBS)
>  
> -- 
> 2.43.0.797.g29b680fc68
> 
> 
