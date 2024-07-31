Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B734B33CFC
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722450843; cv=none; b=pGr3kTsKYLmbVmITm/o735aAI1ZN7ZFWgI0am2cdw9mTmnG1T7MjaVL/fiDjhZrGP7IwCOyUVzij0dzLXS63dGe7IscjKC8Sv+rh5DyERBa5F38H1Wy+MWhvvCShbsTGm3FciHHNoRY3iES34gf1mC9eBVyi2R0BxxuYREkB56I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722450843; c=relaxed/simple;
	bh=R++wBEa3s93YjdoWU6WKVbB5KD8jEGoh/bsNrKSvyok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5EGQXQesEMENuTqLiwlRVQk5AxhAwm4xDNDSAhuG2R1deWnX4ySoDVJ1+qXR0bCr7vL35xHC8s+7VOKa5UelVHX35giLcmLJoJVVPZxbaogg7h7fc/O7tsKIrPaUpfz7p5XBv2ftSN5Ph4VX+qDLUlcR8gcn1tgnMWnlh1KAfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HBZNwaH5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HBZNwaH5"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc60c3ead4so42885075ad.0
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 11:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722450841; x=1723055641; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/e4M47aiIDJ5YRf8dnqnxwFO2b14tq6jX1MoXi2Y2mc=;
        b=HBZNwaH5dmm2DaYOWntUrRN09TLuNS+8RVFY171IjXcs0aNNa9QDr+iMDbXo5Ft1Mg
         1Y/SpQlwcmtcd+PIQsv/4boSv1DYkoiCPT8wM4soq7HJ1VZ+QtPyqkdSqK6r0owrr+12
         H7Wzx4PM4x2zSk7LOgCNTh1OQGoiyIpxkRWi0a/1GvfYkkhoBWSW+COsG79H6/vTIT0G
         l+NSnih7VJQrvnH1YZIWtUxZ2AGVwk/7HY5Hta5txd/3pDIkJ5xXW+JpSFtT/QH2FKF4
         1iZ8Guf22lLwFhaTQLCYI0P7ewPXk8caJ6lfGEZ9BD9vgxSMzvs5BGrhpSNB/jiHJrV7
         qqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722450841; x=1723055641;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/e4M47aiIDJ5YRf8dnqnxwFO2b14tq6jX1MoXi2Y2mc=;
        b=Ry1I+vKtARjlwTGo99SVghB5Iwc1yL8QHxpspnvrhp0yuyRSntcQou57yfWYu1gDlx
         5LTImEc0NztDKZXen0htUni+JfzUbAim5YkfLJ98JDryTHJ4T5JVviuLMvCzbNrXmUpz
         t7Aq3b5BZE4QIpbEG8uf5hXEAEP6hIPhqhO8eZJQE5WztmC2CJ+bXtH5C0P0JUae1vOQ
         dapkQu1C4K07EfS6uUvaZSP8qpIhCe9a3nL+3WwCmlDc55GwhgCca4r8/Dbyxi2I4nr+
         LBUBdA/qSPcm565td0yptMWL0+S5A5fRILMdM7PAVlr/oq8VxeC+kbmsfnmjr6lGhNqI
         iqfQ==
X-Gm-Message-State: AOJu0YyJATqI5/JR6lj1HTx2a6JyTi/JK4ij0qg2dzY50iIn93Xnh4Js
	06zJlGVgfMx9ZK5WbUKt22dQHc5PeiYBaCWv54m21JLix8hew1sbN/fpwPJqPA==
X-Google-Smtp-Source: AGHT+IEnia/wqH9doi3O35njEZRLsnlm74Nw+4k8Dyi/+6gWlXve5AzZdNuzHqSUIxoll0T+0qeFIw==
X-Received: by 2002:a17:902:d50b:b0:1fd:ae10:722b with SMTP id d9443c01a7336-1ff4d27a725mr2048925ad.63.1722450840556;
        Wed, 31 Jul 2024 11:34:00 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:ec46:755c:60f:a94d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ff622asm123606935ad.301.2024.07.31.11.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 11:34:00 -0700 (PDT)
Date: Wed, 31 Jul 2024 11:33:55 -0700
From: Josh Steadmon <steadmon@google.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, 
	Junio C Hamano <gitster@pobox.com>, Kyle Lippincott <spectral@google.com>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC PATCH 0/3] Introduce clar testing framework
Message-ID: <avbtyqklmtwmz63vbpevkz4xyv3dboyghwhkodxjlb3ur6zt36@afi5ptrsvpz2>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, 
	Junio C Hamano <gitster@pobox.com>, Kyle Lippincott <spectral@google.com>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>
References: <cover.1722415748.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1722415748.git.ps@pks.im>

On 2024.07.31 11:04, Patrick Steinhardt wrote:
> Hi,
> 
> there's been some discussion around extending our unit testing framework
> to avoid duplication when declaring test functions. Right now, a testing
> function has to be declared and then wired up via the test's main
> function, which can be a bit annoying. In the thread, René proposes an
> alternative that gets rid of this duplication by using macros. And while
> that does solve the issue, there were some concerns about things being
> too much "magic" while at the same time not being flexible enough.
> 
> Part of the discussion revolved around whether we maybe want to have a
> proper unit testing framework in our codebase instead of reinventing the
> wheel. As I quite liked the "clar" [2] testing framework from back when
> I was still developing libgit2 I proposed it as a possible alternative.
> This patch series wires up the clar framework as a proof of concept and
> converts the strvec test suite to use it.
> 
> The magic to avoid the above code duplication is quite self-contained in
> a "generate.py" file. This script extracts function declarations from
> all unit test suites and then writes those into a "clar.suite" header
> file. All that one needs to do is thus to declare a function with a
> specific name "test_<suite>__<name>" and then everything else gets wired
> up automatically.
> 
> Whether this is better than the solution proposed by René is probably a
> matter of taste. While I'm not a huge fan of the macro-based solution,
> I don't want to veto it either (not that I'd have that power anyway). So
> please, you should rather read this as a proof of concept to see how
> alternatives could look like such that we have a better picture of where
> we want to end up.
> 
> Some random thoughts:
> 
>   - The mandated Python dependency is suboptimal in my opinion.
>     Rewriting the script in e.g. Perl should be easy enough though, it's
>     no rocket science.
> 
>   - I prefer that the proposed solution results in a single binary as
>     compared to one binary per test system.

Does clar allow running test functions in parallel? With multiple
binaries, we can at least run independent tests in parallel (although
right now the unit tests are fewer and so much faster than the shell
tests that it's hardly noticeable).

>   - The clar gives us the ability to pick which tests to run via command
>     line parameters, which I personally like more than picking the
>     specific binary to run.

Yes this is a nice improvement.

>   - The clar replaces some test assertions that we already have. They
>     feel a bit more mature, but overall there aren't all that many
>     assertions available. If we wanted to pick it up, then we'd likely
>     have to add some more wrappers.
> 
>   - The clar uses longjmp instead of manually having to `return` from
>     functions in case there was an assertion failure. This is easier to
>     work with in my opinion.
> 
> Also, note that I only tested this on my Linux machine. I have no clue
> whether this works as-is on Windows, but I do know that libgit2 tests
> run on Linux, macOS and Windows. So it should work in theory, it's just
> a matter of polishing this series.
> 
> I'm happy to hear your thoughts on this, even if it ultimately ends up
> being shot down.

As part of the original unit-test series, I wrote a comparison between
different frameworks: Documentation/technical/unit-tests.txt, poorly
rendered at [1]. Could you add a row to the table evaluating clar on the
individual points there?

[1] https://git-scm.com/docs/unit-tests#framework-selection

> Patrick
> 
> [1]: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
> [2]: https://github.com/clar-test/clar
> 
> Patrick Steinhardt (3):
>   t: import the clar unit testing framework
>   Makefile: wire up the clar unit testing framework
>   t/unit-tests: convert strvec tests to use clar
> 
>  .gitignore                                 |   1 +
>  Makefile                                   |  36 +-
>  t/Makefile                                 |   1 +
>  t/unit-tests/.gitignore                    |   3 +
>  t/unit-tests/clar/.github/workflows/ci.yml |  23 +
>  t/unit-tests/clar/COPYING                  |  15 +
>  t/unit-tests/clar/README.md                | 329 ++++++++
>  t/unit-tests/clar/clar.c                   | 842 +++++++++++++++++++++
>  t/unit-tests/clar/clar.h                   | 173 +++++
>  t/unit-tests/clar/clar/fixtures.h          |  50 ++
>  t/unit-tests/clar/clar/fs.h                | 522 +++++++++++++
>  t/unit-tests/clar/clar/print.h             | 211 ++++++
>  t/unit-tests/clar/clar/sandbox.h           | 154 ++++
>  t/unit-tests/clar/clar/summary.h           | 143 ++++
>  t/unit-tests/clar/generate.py              | 267 +++++++
>  t/unit-tests/clar/test/.gitignore          |   5 +
>  t/unit-tests/clar/test/Makefile            |  39 +
>  t/unit-tests/clar/test/clar_test.h         |  16 +
>  t/unit-tests/clar/test/main.c              |  40 +
>  t/unit-tests/clar/test/main.c.sample       |  27 +
>  t/unit-tests/clar/test/resources/test/file |   1 +
>  t/unit-tests/clar/test/sample.c            |  84 ++
>  t/unit-tests/{t-strvec.c => strvec.c}      | 124 ++-
>  t/unit-tests/unit-test.c                   |  16 +
>  t/unit-tests/unit-test.h                   |   3 +
>  25 files changed, 3041 insertions(+), 84 deletions(-)
>  create mode 100644 t/unit-tests/clar/.github/workflows/ci.yml
>  create mode 100644 t/unit-tests/clar/COPYING
>  create mode 100644 t/unit-tests/clar/README.md
>  create mode 100644 t/unit-tests/clar/clar.c
>  create mode 100644 t/unit-tests/clar/clar.h
>  create mode 100644 t/unit-tests/clar/clar/fixtures.h
>  create mode 100644 t/unit-tests/clar/clar/fs.h
>  create mode 100644 t/unit-tests/clar/clar/print.h
>  create mode 100644 t/unit-tests/clar/clar/sandbox.h
>  create mode 100644 t/unit-tests/clar/clar/summary.h
>  create mode 100755 t/unit-tests/clar/generate.py
>  create mode 100644 t/unit-tests/clar/test/.gitignore
>  create mode 100644 t/unit-tests/clar/test/Makefile
>  create mode 100644 t/unit-tests/clar/test/clar_test.h
>  create mode 100644 t/unit-tests/clar/test/main.c
>  create mode 100644 t/unit-tests/clar/test/main.c.sample
>  create mode 100644 t/unit-tests/clar/test/resources/test/file
>  create mode 100644 t/unit-tests/clar/test/sample.c
>  rename t/unit-tests/{t-strvec.c => strvec.c} (54%)
>  create mode 100644 t/unit-tests/unit-test.c
>  create mode 100644 t/unit-tests/unit-test.h
> 
> -- 
> 2.46.0.dirty
> 


