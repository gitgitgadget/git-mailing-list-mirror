Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAF061F404
	for <e@80x24.org>; Mon, 10 Sep 2018 17:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbeIJWUM (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 18:20:12 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32822 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbeIJWUM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 18:20:12 -0400
Received: by mail-wm0-f66.google.com with SMTP id r1-v6so6009118wmh.0
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 10:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=py/7VFNRCQthKDK6wXuOtig98EDZzVtuB0SROk8spZs=;
        b=qLB2D6Fsc996m7qJk6Z8iQZGqHZwaQedfTLma3+1aYCnneynnc1FaeWPeQhL8ZpY4E
         kVQA3TGkvUVwySRMUWmCCBUNUZfq4vMF9Ndkp0VWjzWNV/4y+ODRwndz68vb+2Oa+HbG
         b7gGF1PXbYxbJpV10tpdW6tfWYK0b60KaYOZZFUjFRRP62SAqWbkQ6yvhI287UA6bo/o
         Vl2jXrW6L+lvqeAi3Vy696AWWttRSm+s8w35azjA1THhaWgZIJEC93Te0Dzy8cWoMIq2
         zdzcTGb2UbGV+oz7Jt5JWSUNR7vYp/CdoLs4PPoOqJTJqLDE8nCgVWe3/ATe8TbnwYx/
         eJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=py/7VFNRCQthKDK6wXuOtig98EDZzVtuB0SROk8spZs=;
        b=cucPJ0HyvhBaEzgdmzFmApTK1p9L2KjM76z8OqCpyvRL4VoJ8RdgapSB7owsA9X2D9
         mX5KlkqLQzMlqdJkCSZbdTLDlrhnXqLGpQHwAlXlFE2I9fIKDEiDVpJ4hty8KCnjqF6X
         5MaFLrcelMv2ojTMucklMfliLI7EYe1l9N8pOmSb5icZRlbg605yFo3A+Fa63zZW4xDY
         +QRzEm7zgBL5CibWP7seEyEpQnDynk1rib5xhoddij1JIImXevnkvjqeIw2ysB45+5l+
         hM7fGHQrC7hUx8c90h8wo+mC9Gughdxl1ZmlbOCmdvy5JWbccb+6hu90MlYGeNL625pL
         z2mA==
X-Gm-Message-State: APzg51BNdSyZX9JIFzX8h1weabAIL+ujwlYkRpPgJZslg4IaxioyMeq/
        jmGkeV84ti4Yiw6rT7L0tYY=
X-Google-Smtp-Source: ANB0VdaRWBvQD0Fst8+LEcJLr46skbWuANpazyTScPbvr0alrY4ICSVXR7jleK87UWwZjAB39aJ0Hw==
X-Received: by 2002:a1c:7c13:: with SMTP id x19-v6mr1395543wmc.27.1536600303239;
        Mon, 10 Sep 2018 10:25:03 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f18-v6sm14409692wru.51.2018.09.10.10.25.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 10:25:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] t3701-add-interactive: tighten the check of trace output
References: <20180910140714.19617-1-szeder.dev@gmail.com>
        <20180910154453.GA15270@sigill.intra.peff.net>
Date:   Mon, 10 Sep 2018 10:25:01 -0700
In-Reply-To: <20180910154453.GA15270@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 10 Sep 2018 11:44:54 -0400")
Message-ID: <xmqqin3dtgcy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Not that I'm totally opposed to your patch, but it's a little sad that
> we have to match the specific text used in GIT_TRACE now (and if they
> ever changed we won't even notice, but rather the test will just become
> a silent noop).
>
> I think it would be nice if we could move towards something like:
>
>   - move current GIT_TRACE messages to use GIT_TRACE_COMMAND or similar
>
>   - abolish trace_printf() without a specific subsystem key
>
>   - do one of:
>
>     - keep GIT_TRACE as a historical synonym for GIT_TRACE_COMMAND; that
>       keeps things working as they are now
>
>     - have GIT_TRACE enable _all_ tracing; that's a change in behavior,
>       but arguably a more useful thing to have going forward (e.g., when
>       you're not sure which traces are even available)
>
> And then a test like this would just use GIT_TRACE_COMMAND.

Yup.  Sounds like a better world.

>
>> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
>> index 609fbfdc31..65dfbc033a 100755
>> --- a/t/t3701-add-interactive.sh
>> +++ b/t/t3701-add-interactive.sh
>> @@ -540,7 +540,7 @@ test_expect_success 'add -p does not expand argument lists' '
>>  	# update it, but we want to be sure that our "." pathspec
>>  	# was not expanded into the argument list of any command.
>>  	# So look only for "not-changed".
>> -	! grep not-changed trace.out
>> +	! grep -E "^trace: (built-in|exec|run_command): .*not-changed" trace.out
>
> I had a vague recollection that we preferred "egrep" to "grep -E" due to
> portability. But digging in the history, I could only find "fgrep" over
> "grep -F". And we seem to have plenty of "grep -E" invocations already.

I had the same reaction and came to the same conclusion.  FWIW, the
"favor fgrep over -F" was done by you with 87539416 ("tests: grep
portability fixes", 2008-09-30).

