Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4A2186294
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 08:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762935448; cv=none; b=jmu/rmwxUSuB2b+JVucxGYKVNlNScEJWUtM8Bq4qxBd+u1GJOKEGmxpvb4EwDECvewBLpgqETbRjbF4OAwiGbQ836iNiDCHBQO0ZcZ8GMZ168CoxExsixdakRKOPak2ctAFPkUqJKyimPmYT6WQyZEtUJi2Dk01j7cyiTJC+s8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762935448; c=relaxed/simple;
	bh=hGmmXOdHBPS8ul9BIdKjkIx5oth6G0xhJUZnZ3qDjyI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bzcxm8AfOINLNr+ikEV2n0iMFs5eSDJlVg7HBJuiCxS5+S7vgfBeu/7qEAaUHrnWh8vokRm5IP5s02Ma9M2wF9+PASd9rpeDT1VPWqz35kG9ZZ7AXhYxX17P2IP4VVaVYQy3cFLK0+TRotcR0vLheYrF+CyykPKitGGZaivO2E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzxj8mko; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzxj8mko"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2984dfae0acso6999425ad.0
        for <git@vger.kernel.org>; Wed, 12 Nov 2025 00:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762935446; x=1763540246; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nr2fUD40pbkJmsG6J43U47ozVY1XWvTJ9Ba3jx4ngvI=;
        b=lzxj8mkoLLiZiVFTr6VjJfMcNLa6ktmktJkzpa6+N5Uy2qoXuTvc+6l3Wyp2cLyG7w
         FJ09/czM5ZlHvxJz8NBD+hI5jORlTRndFDj8BenqmJ+x9NUd806YfcgOA6e8QuNRAgAH
         zyMglAS7f/q1KmgCS6J06UwTCzG0ygWP8ttJBJpxFqcx6raIgwtkEjdCjguRN8VTHzdY
         /4r1HhReFMflj03micI/Iiii5V3FEY6G1bd1if55tZK/V3R98QIxWl6sA1N070eogASI
         BLeEiz7JySsNw0zd8dIvqCBs5WUqNDQ60jajUyBxQap4cBn0Pm2LSr/viyKCb/LWKvyU
         jsrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762935446; x=1763540246;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nr2fUD40pbkJmsG6J43U47ozVY1XWvTJ9Ba3jx4ngvI=;
        b=Ob5v3/mcWTIDYUlh5jhABcIliwF9/5MlSfYrjBtF6kgqdO0ePYdbH9H3rM96L8SAHC
         Dj+i8RaYkgANV6MgKJXpXAaHQef9unLYcwfft0e1XFHGVh0H9qhNC/exdAL0HRFGiGVX
         ioqQb5xV9/+vupUjs114SrM3XY3lN6hNFxj9rn8NOgPmC+PEIyCQ5qWhRErCH4uWHxd5
         aQMHbCEm2byejj1Ok9HdqfZ89W/+NrtmdTCRvJbo6XV9QtiwuSfZGPyVe6KgnQ4Y/PA2
         gGzUZshCos3DUK7aZsaE3iF1xB781SEGQux2DetONV1t6kXYGt/R7IgsYK8XaBeJKSyx
         Kn5w==
X-Gm-Message-State: AOJu0Yw5R4kLMrF6L4l7N7RZenR/WOb1fWffSwC3CVBSsiJjeDHF/hc4
	FW1qOmRinQqaubWcJcjSKEW6gbiJZIodVm/4SCylOx+NzXfNQvVYcNpE
X-Gm-Gg: ASbGnctqyhIbnWXMoYdKL0rLJ5hipyAPaDW2MvNzj97sSFlIc5pw6/8gKUCIZ3L1iHT
	WhOxvrtIH24U0YhRf2y0W6vDg/oKXRkvE9iBS/q2OpMGr0Bh1U2ih2lz+j68YSzBQIr1E2uKkWJ
	ssMiBIhQNoJTHpn6g4Rxhh4RKi9sCc5HB5iYxJJzwNX2A7u26sPFnfDMTmC4HnxV6o98pyjtap+
	JozA1v8sxWbSTJs4f64u2eJFfGfFgq5oScxG6MX1l2LQALIpslCr4jUQlO1J2fMy1gjli5JprRE
	bEQftxygmBH/6omRYCiFFJI9LRIcOAO0pZ95oI4NsRiIBJPWhk4vhtJbq2c1g6DQSEXoOzKkuHF
	TQq3DAnazY5CGoHElaLroGSoTmrBdkv60jzthUNhnxzIEypcdbCdbJiU8sg==
X-Google-Smtp-Source: AGHT+IFLPwoDwsegkO/eCo4ZKgYmw9svZ0CfhySzPuil0R5a1Q8NW0eILVeGZ0jvXey7hbTUP3usAg==
X-Received: by 2002:a17:903:4407:b0:297:c889:ba2b with SMTP id d9443c01a7336-2984edcac15mr30072565ad.33.1762935446077;
        Wed, 12 Nov 2025 00:17:26 -0800 (PST)
Received: from fedora ([2601:646:8081:3770::43bc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dbf54e6sm21632665ad.37.2025.11.12.00.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 00:17:25 -0800 (PST)
From: Collin Funk <collin.funk1@gmail.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  correctmost <cmlists@sent.com>,  Taylor Blau
 <me@ttaylorr.com>
Subject: Re: [PATCH 3/9] Makefile: turn on NO_MMAP when building with ASan
In-Reply-To: <20251112080215.GC979063@coredump.intra.peff.net>
References: <20251112075522.GA978866@coredump.intra.peff.net>
	<20251112080215.GC979063@coredump.intra.peff.net>
Date: Wed, 12 Nov 2025 00:17:24 -0800
Message-ID: <87y0obis17.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Git often uses mmap() to access on-disk files. This leaves a blind spot
> in our SANITIZE=address builds, since ASan does not seem to handle mmap
> at all. Nor does the OS notice most out-of-bounds access, since it tends
> to round up to the nearest page size (so depending on how big the map
> is, you might have to overrun it by up to 4095 bytes to trigger a
> segfault).
>
> The previous commit demonstrates a memory bug that we missed. We could
> have made a new test where the out-of-bounds access was much larger, or
> where the mapped file ended closer to a page boundary. But the point of
> running the test suite with sanitizers is to catch these problems
> without having to construct specific tests.
>
> Let's enable NO_MMAP for our ASan builds by default, which should give
> us better coverage. This does increase the memory usage of Git, since
> we're copying from the filesystem into heap. But the repositories in the
> test suite tend to be small, so the overhead isn't really noticeable
> (and ASan already has quite a performance penalty).
>
> There are a few other known bugs that this patch will help flush out.
> However, they aren't directly triggered in the test suite (yet). So
> it's safe to turn this on now without breaking the test suite, which
> will help us add new tests to demonstrate those other bugs as we fix
> them.
>
> Signed-off-by: Jeff King <peff@peff.net>

I see that an interceptor was added in 2023 [1]. Maybe your compiler is
older than that?

On my system:

    $ cat main.c 
    #include <stdlib.h>
    #include <unistd.h>
    #include <sys/mman.h>
    int
    main (void)
    {
      char *ptr = mmap (NULL, getpagesize (), PROT_READ | PROT_WRITE,
    		    MAP_ANONYMOUS, -1, 0);
      if (ptr == NULL)
        abort ();
      ptr[getpagesize () + 1] = 'a';
      return 0;
    }
    $ gcc --version | head -n 1
    gcc (GCC) 15.2.1 20251022 (Red Hat 15.2.1-3)
    $ clang --version | head -n 1
    clang version 21.1.4 (Fedora 21.1.4-1.fc43)
    $ gcc -fsanitize=address main.c && ./a.out 2>&1 | grep ^SUMMARY:
    SUMMARY: AddressSanitizer: SEGV (/home/collin/a.out+0x400554) (BuildId: 1b7a82189bfffb3f73d420e138b9859add25901a) in main
    $ clang -fsanitize=address main.c && ./a.out 2>&1 | grep ^SUMMARY:
    SUMMARY: AddressSanitizer: SEGV (/home/collin/a.out+0x4e9ee6) (BuildId: aca1d168eacebaa239082d8a45ab74c8470f4b31) in main


Collin

[1] https://github.com/llvm/llvm-project/commit/a34e702aa16fde4cc76e9360d985a64e008e0b23
