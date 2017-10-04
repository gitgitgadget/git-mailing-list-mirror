Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C15932036C
	for <e@80x24.org>; Wed,  4 Oct 2017 19:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751066AbdJDT3R (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 15:29:17 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50717 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbdJDT3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 15:29:16 -0400
Received: by mail-wm0-f65.google.com with SMTP id u138so24767728wmu.5
        for <git@vger.kernel.org>; Wed, 04 Oct 2017 12:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o61z/iL3R6urKJaLLHl7x6d+LRluT0G6zRLtyJWw3O4=;
        b=U6pBcTrVjrjbpYKvrtkSBlGkue1j3VB+48FdNPUMRs1O0OhQA1FwMLOXnu6CTMrB7D
         KZmmG6t5wPruXMy3IOfErJ3ploGUCxyNojclZ+mhppx5NNJ8sDL6ioTlYURRVTO7kXAf
         FUocPX84/EfftiLecNWd1rf04OSdW9+6oLXz9cR56tL+06Z8MT8ov0z6B3TBk0dtntdU
         OHMTUja3ZSlHPbrPnbtoJL+VNwi0AGAwNFmPAG7EGwNhB23sJYNWfccbwZf3MclCdXWE
         zVkkGmX/8T3G/wlLGDTDBlJfuDC+2TFTHAAruZT9NPeeIGTHZbgUOYn4a0iFw4muw9SL
         kl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o61z/iL3R6urKJaLLHl7x6d+LRluT0G6zRLtyJWw3O4=;
        b=j/HHtbWreo9mdcE0uVyZmQcULpuxGadFXxfJWjngEVOLYast31lQ4P/ZQ2IYaVtBFe
         KckdctDej5tIZGdWXcX648vbAWxikax5au4NIUf+I6oYngraxxZFRuTNjJ7j4hhdoiqw
         8YPIIE6DNLaiKEkCi2Rgt66YAuNLk0zDQkYp2wfE7D2TVoPU8bAHnpeYFaWNrFOCRTeT
         yinGBu2Pw3RM3/8aKHlgrtfBA/yok9eDYCxIy5rM6hxHvK0tzJtxjYrqVIFqDsx82xIe
         8norJDL092F11cBAIahva2WnpMNWRXUCoR3lZ19XGJ9T2v+xwz9Lz8QA3qDHXkjzZXNv
         0JYA==
X-Gm-Message-State: AMCzsaWtewHt2tokbak2rcSJjUwox+JYscesM/AvUnvjlyIqLZmj5rJM
        EXEhbntSTj6adrvYoXIa3IA=
X-Google-Smtp-Source: AOwi7QAn8ZElFxILC+k8tWnHHiJXbiMRBYTjx5t315bm4/qf9fIDxHnjZLa2zhBEBR4B2huCoHs2PA==
X-Received: by 10.28.63.134 with SMTP id m128mr18404487wma.137.1507145354733;
        Wed, 04 Oct 2017 12:29:14 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id m28sm20721338wmi.20.2017.10.04.12.29.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Oct 2017 12:29:13 -0700 (PDT)
Date:   Wed, 4 Oct 2017 20:30:05 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: playing with MSan, was Re: [PATCH 0/3] fixes for running the
 test suite with --valgrind
Message-ID: <20171004193005.GD30301@hank>
References: <20171003195713.13395-1-t.gummerer@gmail.com>
 <20171003234153.pmslizidgbifl6en@sigill.intra.peff.net>
 <20171004101932.pai6wzcv2eohsicr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171004101932.pai6wzcv2eohsicr@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/04, Jeff King wrote:
> On Tue, Oct 03, 2017 at 07:41:54PM -0400, Jeff King wrote:
> 
> > I think using SANITIZE=memory would catch these, but it needs some
> > suppressions tuning. The weird "zlib reads uninitialized memory" error
> > is a problem (valgrind sees this, too, but we have suppressions).
> 
> I dug into this a little more. You can blacklist certain functions from
> getting MSan treatment, but that's not quite what we want. We want to
> mark bytes from certain _sources_ as being initialized, even if MSan
> doesn't agree.
> 
> And indeed, you can do that. As far as I can tell, MSan works by keeping
> a shadow map of memory and setting flags when it believes it has been
> initialized, and then checking that map when we make decisions based on
> the memory. But it can only do that if it instruments all writes. So the
> MSan documentation recommends that you build _everything_, including
> libraries, with it. Which obviously we don't do if we're using a system
> zlib. Or a system libc for that matter (though they intercept many
> common libc functions to handle this).
> 
> So one strategy is to "cheat" a bit at the library interfaces, and claim
> whatever they send us is properly initialized. The patch below tries
> that with zlib, and it does seem to work. It would fail to notice a real
> problem with any input we send _to_ the library (since the library isn't
> instrumented, and we claim that whatever comes out of it is legitimate).
> I could probably live with that.
> 
> But there are quite a few test failures that would still need
> investigating and annotating:
> 
>   - Certainly it's confused by looking at regmatch_t results from
>     regexec(). We can fix that by building with NO_REGEX. But pcre has
>     a similar problem.
> 
>   - Ditto curl and openssl, whose exit points would need annotations.
> 
>   - For some reason test-sigchain segfaults when it raise()s in the
>     signal handler and recurses. Not sure if this is an MSan bug or
>     what.
> 
> So I dunno. This approach is a _lot_ more convenient than trying to
> rebuild all the dependencies from scratch, and it runs way faster than
> valgrind.  It did find the cases that led to the patches in this
> series, and at least one more: if the lstat() at the end of
> entry.c:write_entry() fails, we write nonsense into the cache_entry.

Yeah valgrind found that one too, as I tried (and apparently failed :))
to explain in the cover letter.  I just haven't found the time yet to
actually try and go fix that one.

> I think we could probably get it to zero false positives without _too_
> much effort. I'll stop here for tonight, but I may pick it up again
> later (of course anybody else is welcome to fool around with it, too).
> 
> Below is the patch that let me run:
> 
>   make SANITIZE=memory CC=clang-6.0 NO_REGEX=1
> 
> and get a tractable number of errors.
> 
> -- >8 --
> diff --git a/Makefile b/Makefile
> index b143e4eea3..1da5c01211 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1047,6 +1047,9 @@ endif
>  ifneq ($(filter leak,$(SANITIZERS)),)
>  BASIC_CFLAGS += -DSUPPRESS_ANNOTATED_LEAKS
>  endif
> +ifneq ($(filter memory,$(SANITIZERS)),)
> +BASIC_CFLAGS += -DENABLE_MSAN_UNPOISON
> +endif
>  endif
>  
>  ifndef sysconfdir
> diff --git a/git-compat-util.h b/git-compat-util.h
> index cedad4d581..836a4c0b54 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1191,4 +1191,11 @@ extern void unleak_memory(const void *ptr, size_t len);
>  #define UNLEAK(var) do {} while (0)
>  #endif
>  
> +#ifdef ENABLE_MSAN_UNPOISON
> +#include <sanitizer/msan_interface.h>
> +#define msan_unpoison(ptr, len) __msan_unpoison(ptr, len)
> +#else
> +#define msan_unpoison(ptr, len) do {} while (0)
> +#endif
> +
>  #endif
> diff --git a/zlib.c b/zlib.c
> index 4223f1a8c5..5fa8f12507 100644
> --- a/zlib.c
> +++ b/zlib.c
> @@ -56,6 +56,8 @@ static void zlib_post_call(git_zstream *s)
>  	if (s->z.total_in != s->total_in + bytes_consumed)
>  		die("BUG: total_in mismatch");
>  
> +	msan_unpoison(s->next_out, bytes_produced);
> +
>  	s->total_out = s->z.total_out;
>  	s->total_in = s->z.total_in;
>  	s->next_in = s->z.next_in;
