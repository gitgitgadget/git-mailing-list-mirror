Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD4B4EB36
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 20:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ERcsujCg"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bc1414b48eso5046141b6e.2
        for <git@vger.kernel.org>; Wed, 10 Jan 2024 12:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704917815; x=1705522615; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=COXzVv5BnBG2u5Xwh65Xg1ArVLw+Yr13+J0AgZnOYeY=;
        b=ERcsujCgLdSD8lUyBdsBkvqnVumf1f0ER6YLhqurtq4DfMrUkKn4JLLKFN7jxGaWl0
         E8QyQxR1P9EPhVeiso8RtkTTnMH9s8tzDDvWygUUWWOxsn+WwbtxpNk2LQ2CdF133+yb
         +VkvbNNzy9sN+UNmK2MlDHt6IOnD7xzqZ3XGNUZ/8YJsFZSQz84anSyGMn2/kJ4q4a5G
         P/B2Yonf/6hAlsWkJMYRhgjjhgM2GRCg2pyB2hdI7jNgO689m10je/ZQIv/2MKQXDVQK
         kRw/yRxbh9FpwxoV4Adj0X/Gq9kmLxbResCRohZnvGGWLr2peTUGRzM/GWNMFOG4cx6S
         WXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704917815; x=1705522615;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=COXzVv5BnBG2u5Xwh65Xg1ArVLw+Yr13+J0AgZnOYeY=;
        b=mJFOf8TfpkxuDog0pD+QibPUtEs8D1rPs2G0fCE9cWr/VYH9YztK6Ryez9GM9C6zwY
         trmY7eCzLio4o+ExsyTWiH8LG6e0VfEQayWle17NI1xuT75NfLPoNpcjyXM6iJXpzIMd
         2K8VKqzOC29KTDXEkYQ/G+gf2Ocmv64b27bVfJqmUdeN8VDWQEFGu7pK42oj+SD49XWf
         T/Fli2Z7D77tHEllRgd8bFLGBseuVuhBRzBrzI+Ohn4noarrFSkOXuWD8ZE4pw45/vmT
         omk07sIyMfzLwLQMwQ9UJND3LtjC+BwX05Lrh05iXcYzEbgs/DJ0uyUxLEvPwn7UbHbL
         GZQw==
X-Gm-Message-State: AOJu0YwKHX5ngLjlbkMCEZAqIBFJCOyzoqVB44hqXvdNezGg6n3Sacrk
	WcB5mhXtf3xMt9zrLECyR3v825KAmQkTnsC6Y4EfULTAEYijiw==
X-Google-Smtp-Source: AGHT+IFHLba86crNmT700XOwn1ixLOU5BjzFj+V5cMmN2yf3fUDrHAOvR9jr1PXwFBcdGdynFR8CBw==
X-Received: by 2002:a05:6808:1208:b0:3bc:12af:5528 with SMTP id a8-20020a056808120800b003bc12af5528mr223974oil.76.1704917815250;
        Wed, 10 Jan 2024 12:16:55 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d1-20020a05620a158100b00783244c7a95sm1857242qkk.24.2024.01.10.12.16.54
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 12:16:54 -0800 (PST)
Date: Wed, 10 Jan 2024 15:16:53 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [DISCUSS] Introducing Rust into the Git project
Message-ID: <ZZ77NQkSuiRxRDwt@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Over the holiday break at the end of last year I spent some time
thinking on what it would take to introduce Rust into the Git project.

There is significant work underway to introduce Rust into the Linux
kernel (see [1], [2]). Among their stated goals, I think there are a few
which could be potentially relevant to the Git project:

  - Lower risk of memory safety bugs, data races, memory leaks, etc.
    thanks to the language's safety guarantees.

  - Easier to gain confidence when refactoring or introducing new code
    in Rust (assuming little to no use of the language's `unsafe`
    feature).

  - Contributing to Git becomes easier and accessible to a broader group
    of programmers by relying on a more modern language.

Given the allure of these benefits, I think it's at least worth
considering and discussing how Rust might make its way into Junio's
tree.

I imagine that the transition state would involve some parts of the
project being built in C and calling into Rust code via FFI (and perhaps
vice-versa, with Rust code calling back into the existing C codebase).
Luckily for us, Rust's FFI provides a zero-cost abstraction [3], meaning
there is no performance impact when calling code from one language in
the other.

Some open questions from me, at least to get the discussion going are:

  1. Platform support. The Rust compiler (rustc) does not enjoy the same
     widespread availability that C compilers do. For instance, I
     suspect that NonStop, AIX, Solaris, among others may not be
     supported.

     One possible alternative is to have those platforms use a Rust
     front-end for a compiler that they do support. The gccrs [4]
     project would allow us to compile Rust anywhere where GCC is
     available. The rustc_codegen_gcc [5] project uses GCC's libgccjit
     API to target GCC from rustc itself.

  2. Migration. What parts of Git are easiest to convert to Rust? My
     hunch is that the answer is any stand-alone libraries, like
     strbuf.h. I'm not sure how we should identify these, though, and in
     what order we would want to move them over.

  3. Interaction with the lib-ification effort. There is lots of work
     going on in an effort to lib-ify much of the Git codebase done by
     Google. I'm not sure how this would interact with that effort, but
     we should make sure that one isn't a blocker for the other.

I'm curious to hear what others think about this. I think that this
would be an exciting and worthwhile direction for the project. Let's
see!

Thanks,
Taylor

[1]: https://rust-for-linux.com/
[2]: https://lore.kernel.org/rust-for-linux/20210414184604.23473-1-ojeda@kernel.org/
[3]: https://blog.rust-lang.org/2015/04/24/Rust-Once-Run-Everywhere.html#c-talking-to-rust
[4]: https://github.com/Rust-GCC/gccrs
[5]: https://github.com/rust-lang/rustc_codegen_gcc
