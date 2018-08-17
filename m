Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 758A11F954
	for <e@80x24.org>; Fri, 17 Aug 2018 20:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbeHQXN5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 19:13:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36486 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeHQXN5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 19:13:57 -0400
Received: by mail-wm0-f68.google.com with SMTP id w24-v6so8353189wmc.1
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 13:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=s6cVF0oBTFF2D88OXlOiwrg7qZ7XCjISUd52iuEBBNw=;
        b=DK/LsFioWXfExRfKUuuJ0H+vdQMKavQpf4rtbtz5DGBMl/bOZ6OBq31r+oFxPQa9JU
         yvF1bYJhc+k1z3fNFT5GaZJuwt6hCuFYLWwb2O8aVnerNqDkNvY/UYIi/x2TrdhavdFa
         o8lo24gIFP50/D+wOOyQB8uG7V6UHaexu6M4Cc9RGRaUojEuNWgLD2vN2OTevFUQ9XOj
         CuDQI6I7LOYvNm/sEGiSl7mREqd4IFeG/c5D4a3Z6BhpzzO2+tBfNIJFyLh76LfJxPUz
         t/JZ7ipVf34We8BIC1zfRMT8w0Yr4Efe7Y4ADGDaM/WnnvuOgm2oBAjtVAVzGwWeR48N
         pkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=s6cVF0oBTFF2D88OXlOiwrg7qZ7XCjISUd52iuEBBNw=;
        b=cbRuWfJe4FVtDn9V2vUtrGZ/9imHfUtkGKJRQP64FI/t21kAkTeusGENuK9Wi1gT3B
         MbFwb8/mJoHav7zROz6OzU98ejI8HAAybl/gXLRPBnRiPGSjz/x6skGoJIvCVefujyL8
         /s8Q3kVheMWPncoBNERjfMH2yjQeAt/qrJwHrVcRe5/S1SUAOQIwn69Ed+kLaSZvRlEd
         pgCL92EkKR6Zy6uSe3oVq+wgGNJm7957jpD9NgQ8YPZLRnGaWIBDuHj0Mdo8XWeihW6S
         KoAV25PfAL3/cxD70kuoXp7SCb5Z0c8IT06RtAJ/9pwhQdSBZMfBjSyumTz7m5z0N+q8
         0sOg==
X-Gm-Message-State: AOUpUlEJqT2JVIsktyB1U1erHJLG1Rzn9Eh8QOCCCgrxXWxqxa6Kd4ED
        DOHrXtZrAw4W7iGh6sGpGbY=
X-Google-Smtp-Source: AA+uWPzI8Bs5UoK5IdTO2oRundOBV+rsadpBJmvDVsFzCCzFYFqYq0e+35RXl+3IcpwPrZzGimV66Q==
X-Received: by 2002:a1c:588c:: with SMTP id m134-v6mr17604106wmb.154.1534536550927;
        Fri, 17 Aug 2018 13:09:10 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l72-v6sm14051755wma.17.2018.08.17.13.09.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 13:09:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Kirill Smelkov <kirr@nexedi.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] t5310-pack-bitmaps: fix bogus 'pack-objects to file can use bitmap' test
References: <20180814114721.25577-1-szeder.dev@gmail.com>
        <4d6ffc81-a1e8-a60f-d53f-2ec159160fcd@gmail.com>
        <xmqqr2iyc526.fsf@gitster-ct.c.googlers.com>
        <CAM0VKjkT7fBJRie_3f4B13BHT9hp9MxRhuX5r1sogh2x7KQzbg@mail.gmail.com>
        <eeb04c94-50c1-13ee-880b-ea380031a685@gmail.com>
Date:   Fri, 17 Aug 2018 13:09:09 -0700
In-Reply-To: <eeb04c94-50c1-13ee-880b-ea380031a685@gmail.com> (Andrei Rybak's
        message of "Fri, 17 Aug 2018 21:27:22 +0200")
Message-ID: <xmqq4lfsbvru.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> I think it would be a good trade-off to allow these helper functions to skip
> checking emptiness of arguments for test_cmp. Such patch will require only
> s/test_cmp/&_allow_empty/ for these helper functions and it will help catch
> cases as bogus test in t5310.
>
> I'll try something like the following on the weekend:
>
> 	test_cmp() {

Style: SP before and after ().

> 		if test "$1" != - && ! test -s "$1"
> 		then
> 			echo >&4 "error: trying to compare empty file '$1'"
> 			return 1
> 		fi
> 		if test "$2" != - && ! test -s "$2"
> 		then
> 			echo >&4 "error: trying to compare empty file '$2'"
> 			return 1
> 		fi
> 		test_cmp_allow_empty "$@"
> 	}

I actually think the above gives way too confusing output, when the
actual output is empty and we are expecting some output.  I.e.

	: >expect &&
	git cmd >actual &&
	test_cmp expect actual

The tester wants to hear from test_cmp "your 'git cmd' produced some
output when we are expecting none" as the primary message.  We are
trying to find bugs in "git" under development, and diagnosing iffy
tests is secondary.  But with your change, the first thing that is
checked is if 'expect' is an empty file and that is what we get
complaints about, without even looking at what is in 'actual'.

It's the same story, and it is even worse than the above, when we
are expecting some output but the command produced no output, i.e.


	echo Everything up-to-date. >expect &&
	git cmd >actual &&
	test_cmp expect actual

We should get a complaint from test_cmp that 'actual' does not match
the string we were expecting (and even better, we show how they are
different by running them thru "diff -u"), not that 'actual' is an
empty file.


> 	test_cmp_allow_empty() {
> 		$GIT_TEST_CMP "$@"
> 	}
>
> (I'm not sure about redirections in test lib functions. The two if's would
> probably be in a separate function to be re-used by test_i18ncmp.)
