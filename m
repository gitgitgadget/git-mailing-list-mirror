Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB13BC2B9F4
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 11:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 892256198D
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 11:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbhF1LY5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 07:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbhF1LY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 07:24:56 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C77C061574
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 04:22:29 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id w13so19386689edc.0
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 04:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=an30fwC7y/PyCfVik5jH5/Pq8KX7wimv5VVWQkNgsyk=;
        b=ROnVArzkjLLRdCa5HiH8VhU6Cxf7k5I83++O09gSdKH4h4s78NP2rL/hbaCPJH+qM/
         VcUzCcsSbgaehKXA0Wgu9MhWktQKiCAnAvvoyLmtAx1PWmITZLDeDX3yhG1yXWl+OrAO
         D+3eiZbwXBVKdrYeyukYTPgmoNpTnwo9fAAecogWjIKPBmJK4s7YOPSv7chIj23flIZl
         aXBy//YuFP5xvNkmV29Yinb1sTJp50nNo6+6mcX6eW3byoRWYw1zVr10cqXCFxF0uU3F
         RLIRnWbeyofJpOrY3bojH6k+XOPDFdRjMwrlFOQwyxK4OUg4RxOhSUbUGqj+ZiL2prS0
         qjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=an30fwC7y/PyCfVik5jH5/Pq8KX7wimv5VVWQkNgsyk=;
        b=IaT/FZ6F2gvpMr6hQJVvYpkqqqnHPo98TX/zwiE/qNpjEPGOf6KDI6CuBs5zrCHZmL
         6m1jVCLsh+dPT9OQ3hclkkQKz8lxNNTFaITxLNuDrUA7fMuufXGy7fvZLjk3rNC1N+a9
         OJpV1TBgcOaOzl//0AQ0pbpi+OHq3/oBuu9BubU2HveIPoOzIGBqW5Ot1e0saIQHtiUt
         9Eyt6nApNtH7khZAs5KErC2e3BARQ5iCcey1sdmnExZ2asE5hFn3rBclzbgEexc/nd+x
         /3Mdl2Ph+gAK2ZDmGnr75+SceWWAPw2O2F4GOLaKPT8wdekozxjAzfvNeMJsXsx0ouZm
         +isg==
X-Gm-Message-State: AOAM533nLeodRLKgRTKiy4YuDkoJ68DVzuNK67+mRnUQaIKwUT/t+qVf
        45770cwkyoMcf4hKgPP4JnM=
X-Google-Smtp-Source: ABdhPJxhLI741wwykf3oOEV6u3HXgpYhUS0jjLbSnM6u0i3Gx6xe55ZM2TVJHLdiWWEVPSrlibikpQ==
X-Received: by 2002:a05:6402:2913:: with SMTP id ee19mr31894310edb.361.1624879347907;
        Mon, 28 Jun 2021 04:22:27 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id b10sm9095780edx.4.2021.06.28.04.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 04:22:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     peff@peff.net, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: Antw: [EXT] Re: git add --interactive patch improvement for
 split hunks
Date:   Mon, 28 Jun 2021 13:20:46 +0200
References: <60D45FE4020000A100041FCE@gwsmtp.uni-regensburg.de>
 <YNSnlhbE30xDfVMY@coredump.intra.peff.net>
 <60D9A01C020000A100042099@gwsmtp.uni-regensburg.de>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <60D9A01C020000A100042099@gwsmtp.uni-regensburg.de>
Message-ID: <87eecmgrnx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 28 2021, Ulrich Windl wrote:

>>>> Jeff King <peff@peff.net> schrieb am 24.06.2021 um 17:41 in Nachricht
> <YNSnlhbE30xDfVMY@coredump.intra.peff.net>:
>
> [...]
>> One thing you may not like, though: both the builtin version and that
>> patch only put the funcname context in the _first_ hunk of the split.
>> Doing it for subsequent hunks is much trickier, since there can be a
>> funcname in the split context itself. E.g.:
>> 
>>   @@ ... @@ void foo()
>>            int x;
>>   -        int y = 1;
>>   +        int y = 2;
>>    
>>   -        x = 3;
>>   +        x = 4;
>>    }
>> 
>> could split into two hunks, both annotated with "void foo()". But:
>> 
>>   @@ ... @@ void foo()
>>            int x;
>>   -        x = 3;
>>   +        x = 4;
>>    }
>>    void bar()
>>    {
>>   -        int y = 1;
>>   +        int y = 2;
>>    }
>> 
>> would be wrong to say "void foo()" for the second hunk. We'd have to
>> re-scan the interior context lines for a funcname to find it. That's
>> all-but-impossible in the perl version, but might be do-able in the C
>> version (since it has easy access to the funcname-matching patterns and
>> machinery).
>
> There always was a related bug (IMHO) that showed the context of the
> previous function even though the actual change was within a new
> function (that starts within the context lines). So if that bug were
> fixed, my guess is that the other would be as well.
> However I don't know how easy or hard the fix will be.
> Maybe the "definition" of function context is just different; I don't really know.

Does that bug perhaps have anything to do with:
https://lore.kernel.org/git/20210215155020.2804-2-avarab@gmail.com/

I have some planned fixes to that behavior, but it's currently blocked
on a combination of myself having a lot of outstanding patches, and that
linked patch needing another series (as of yet unsubmitted/un-re-rolled)
to get us proper testing in this area of git. I.e. our testing of what
function context we should find is really lacking.
