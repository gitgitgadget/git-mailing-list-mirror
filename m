Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659C9C43381
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 16:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44A0164F38
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 16:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbhCOQYD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 12:24:03 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:55442 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232474AbhCOQXw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 12:23:52 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 042A540D54;
        Mon, 15 Mar 2021 17:23:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id
        :references:from:from:subject:subject:received:received
        :received; s=dkim20160331; t=1615825430; x=1617639831; bh=kFNGLr
        iPxSZLli4DCUS+KJIykE4TBuPnzKjcDutfrlA=; b=qN7ldaDk1sN+FaSCBtHYKz
        U8Wk6+PiawLh+BYN/huLfQcFd7zSbb3i7sibfCPWGXdKwMurznJeFZv8pU8U8p01
        3E6ycuCvHFwGxUxYUb0U2dW4ui23MntanwzEvLExv7wpPZ/LpoZq6Jjc1SkRkS/n
        UAc2/DJFFziq5/G0a5XvcgmO1n9iWCyq7+DMu3cycDGMrfeP2sAiyRj1h/SYklrR
        tzBZQBkIWpaw4jai3GXs2fHwX82dJ/fDbBLT3vEllpFtpn9Pz5wd1ANGiUDGAVTl
        AeK0855NxlbaZYdE9y9uHyv2/SZEDqQGbOIx11mYGQGUpbN8jmXRwyo8unY/iwFi
        pNytIjcLhdCOQBMZJeN7D3c2m5FATP6cA1/bwCPI92gLWOvcoM+05FJ1Tz2ba4WC
        /TZNgHREKaoAUa+zwqUxO1zU/lQQ2MfQrZEVSg15fcHs+5ajd5FGwoym4KVJbB7f
        RC9Y+B3g+1cz2LU3Wp6oU8yeQEDSP+mkvX8wwTvOES4JGryPjj1NbHh2kJKZlBvm
        /ebSBRuV3coqDOM1TVXnQqRfcOl+TgVAaGje1zuUHBLBZ4/vnCxfKfp2lQl1btYG
        hRZLScUFXYrvjn4nXtnuIuuLemHRpDmeXrY34X1j/Znc+fUPmEd5Zz3YvK5eDKtq
        gJ57GcO5U18JQOIsWL65Q=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gcbJVyt-S_O9; Mon, 15 Mar 2021 17:23:50 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 72833403A2;
        Mon, 15 Mar 2021 17:23:50 +0100 (CET)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 2FF86340C;
        Mon, 15 Mar 2021 17:23:46 +0100 (CET)
Subject: Re: [PATCH 0/7] Fix all leaks in t0001
From:   Andrzej Hunt <andrzej@ahunt.org>
To:     Jeff King <peff@peff.net>,
        Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.899.git.1615228580.gitgitgadget@gmail.com>
 <YEZzGjNMSj+MkDUH@coredump.intra.peff.net>
 <d22dc5e6-415e-e265-e894-67b28fe9fe54@ahunt.org>
Message-ID: <6a072f9a-ac12-0cfe-9b04-c9342017f071@ahunt.org>
Date:   Mon, 15 Mar 2021 17:23:44 +0100
MIME-Version: 1.0
In-Reply-To: <d22dc5e6-415e-e265-e894-67b28fe9fe54@ahunt.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 14/03/2021 17:54, Andrzej Hunt wrote:
> 
> I was wrong when it comes to LSAN being broken. What was actually 
> happening is: we default to running ASAN and LSAN with abort_on_error=1, 
> and I had overridden that setting when running with ASAN. When I 
> switched to LSAN, abort_on_error was enabled again - and I was just 
> misinterpreting the intentional abortion as opposed to seeing an 
> unexplained crashes. [As far as I can tell, abort_on_error is needed to 
> detect leaks during a test_must_fail and similar scenarios.]

Actually I might have been unintentionally right the first time round: 
running clang+LSAN against t0000 (with pipe-related fixes applied) 
results in reports as follows, which are effectively useless:

Direct leak of 41 byte(s) in 1 object(s) allocated from:
     #0 0x44fc98 in malloc 
/home/abuild/rpmbuild/BUILD/llvm-11.0.0.src/build/../projects/compiler-rt/lib/lsan/lsan_interceptors.cpp:56:3
     #1 0x7fcdbb3dc749 in strdup (/lib64/libc.so.6+0x8b749)

Switching back to ASAN shows me the real stack instead:

Direct leak of 41 byte(s) in 1 object(s) allocated from:
     #0 0x486834 in strdup 
/home/abuild/rpmbuild/BUILD/llvm-11.0.0.src/build/../projects/compiler-rt/lib/asan/asan_interceptors.cpp:452:3
     #1 0x9ab1b8 in xstrdup /home/ahunt/oss-fuzz/git/wrapper.c:29:14
     ... rest of stack here ...
> 
> To make it trickier, that new "leak" happens inside a test_must_fail - 
> the LSAN output is swallowed, making it hard to diagnose. I'll try to 
> prepare a separate patch to not discard stderr in that scenario.

The issue here is that:

  - test_must_fail does actually keep git's stderr on stderr (there is
    some redirection within test_must_fail itself - but eventually
    what was git's stderr becomes test_must_fail's stderr).
  - many uses of test_must_fail redirect stderr into a temporary file.
  - when git fails as expected, test_must_fail succeeds, and the
    next command in the test validates that temporary file (that
    validation step prints that error output on failure).
  - however if git aborted, or didn't fail as expected: test_must_fail
    returns an error code. git's error messages remain in the temporary
    file and aren't printed.

My potentially naive idea is that within test_must_fail, git's output 
should be sent to both test_must_fail's stderr, and also to fd-4 (which 
seems to be where verbose output should be sent).

However hat might also result in errors being printed twice (I believe 
that will happen for test_must_fail uses that don't redirect stderr into 
a temporary file).
