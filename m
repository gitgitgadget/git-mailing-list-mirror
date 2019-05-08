Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ACE41F488
	for <e@80x24.org>; Wed,  8 May 2019 14:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfEHOU1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 10:20:27 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37251 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbfEHOU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 10:20:27 -0400
Received: by mail-qt1-f194.google.com with SMTP id o7so1280878qtp.4
        for <git@vger.kernel.org>; Wed, 08 May 2019 07:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S40Gm18Mh9p2CQCTBhywi4Bb+9fl3iBq61uQxwVis4o=;
        b=DUwnhCTpMj0sjXS3SEVoPXK/iBFehl9xKvLrLBFBWqa+7srywGzJr6PgM317/jJkxA
         CPfO4/CgnJvbLxHeQtoih5Gse+xgVy3H0mKagxpvohBhhdwY3uSSZdotsP59rTzy3sWW
         RkOOusVNQnVNlbYu8cSHmafci5a9I4lFb4ILZ15PieTriS5SXefnWTb+sMXubpElVjZ5
         k0ZzDk2jEAAlkZoPWcltLhAIVpPrdw0XDtRRfvil3khefqftGKu/J/uWIeubr+1lONEQ
         oDnIkoarMD9/2V61sEazlpuE5UGb/i+bZtKn+NrkBKp4CSyxu13eJhiAR08Lc+P2FYG1
         vSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S40Gm18Mh9p2CQCTBhywi4Bb+9fl3iBq61uQxwVis4o=;
        b=VZnCZ+baUJsORNNgH4K9HGqF7FKQkAT3o56xdqoapeiSaJFQtrKJGVa1zmuupPQj8y
         cgzBUizIL13XUFQWY2zjLAv+UsWjpoBena4WyGMTDNBBmVZoa1SdN73905XIf3ztY3ic
         2pcgNP0vRTDFfvS2yBmE+eZrYdUyN8XWUOQVYRCvmLOJs4xvjdchV0TAFGJ8ZLSdf80y
         Lizr4bRnsIwNSQsE1E/HilirrELLTlRAmiHa+h2Z+WsuHWf1SePQVj+HSR2W5lFV+RJc
         cImBsCkkmkAlkSlMvYXCckDkmkpmB4hnxvJHfyqLn8yCTSUBaqB/p3SSZfHMP3CqZpRa
         Fg0A==
X-Gm-Message-State: APjAAAW+sgMBm2sIQs1QBn6lfgITnXNNzDHmiLdwaJLDCNRmRDeHCRTW
        bIPCI5nBJi9mteWX3IrpmZTb2YibJgQ=
X-Google-Smtp-Source: APXvYqwc7WkTv+R+NfC1+sbd6TrqMMCiXB7Jv/cfgB5tSzYQV4F0f7lYZMYSuvOq0e5bg3+jL3qSfw==
X-Received: by 2002:a0c:c581:: with SMTP id a1mr27511206qvj.79.1557325225971;
        Wed, 08 May 2019 07:20:25 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:243f:92bd:dfb0:fd97? ([2001:4898:8010:2:d73:92bd:dfb0:fd97])
        by smtp.gmail.com with ESMTPSA id e4sm9093775qtb.61.2019.05.08.07.20.24
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 07:20:24 -0700 (PDT)
Subject: Re: [PATCH v3] repack: enable bitmaps by default on bare repos
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20190313015133.n7f7lyujnlwfytre@dcvr>
 <20190313145417.GA24101@sigill.intra.peff.net>
 <20190314091254.nescpfp3n6mbjpmh@dcvr> <87zhoz8b9o.fsf@evledraar.gmail.com>
 <20190410225721.GA32262@sigill.intra.peff.net>
 <xmqq1s1qy2ox.fsf@gitster-ct.c.googlers.com>
 <20190504013713.GC17551@sigill.intra.peff.net>
 <87a7g2iuem.fsf@evledraar.gmail.com>
 <20190507074506.GF28060@sigill.intra.peff.net>
 <8736lqisyx.fsf@evledraar.gmail.com>
 <20190508071105.GA14043@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <561912f3-4761-c690-5327-501e20023e4d@gmail.com>
Date:   Wed, 8 May 2019 10:20:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <20190508071105.GA14043@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/8/2019 3:11 AM, Jeff King wrote:
> On Tue, May 07, 2019 at 10:12:06AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
>>> I think we'd want a way to tell the bitmap code to update our progress
>>> meter as it traverses (both single objects, but also taking into account
>>> when it finds a bitmap and then suddenly bumps the value by a large
>>> amount).
>>
>> Not splitting it will fix the progress bar stalling, so it fixes the
>> problem that the user is wondering if the command is entirely hanging.
>>
>> But I was hoping to give the user an idea of roughly where we're
>> spending our time, e.g. so you can see how much the pack.useSparse
>> setting is helping (or not).
> 
> Yeah, I think that's a bigger and more complicated problem. I admit that
> my main annoyance is just the stall while we fill in the bitmaps (and
> it's easy because the bitmap traversal is the same unit of work as a
> regular traversal).

The pack.useSparse setting also speeds up a section that is not marked
by progress: that portion usually is walking all UNINTERESTING trees and
the"Enumerating Objects" progress is just for walking the INTERESTING objects.
 
>> So something where we report sub-progress as we go along, and perhaps
>> print some brief summary at the end if it took long enough, e.g.:
>>
>>     Enumerating Objects (X^1%) => Marking trees (Y^1%)
>>     Enumerating Objects (X^2%) => Calculating bitmaps (Y^2%)

I like this idea for splitting the "normal" mechanism, too:

     Enumerating Objects (X^1%) => Marking trees (Y^1%)
     Enumerating Objects (X^2%) => Enumerating objects to pack (Y^2%)

>> I.e. bringing the whole "nested" trace2 regions full circle with the
>> progress bar where we could elect to trace/show some of that info, and
>> then you could turn on some trace2 mode/verbose progress to see more.
> 
> I do wonder if this really needs to be part of the progress bar. The
> goal of the progress bar is to give the user a sense that work is
> happening, and (if possible, but not for "enumerating") an idea of when
> it might finish. If the trace code can already do detailed timings, then
> shouldn't we just be encouraging people to use that?

The problem I've seen (without bitmaps) is that running `git push` can
take a while before _any_ progress is listed.

Good news is: `pack.useSparse` fixed our push problem in the Windows OS
repo. The end-to-end time for `git push` sped up by 7.7x with the change,
and this "blank" time is too fast for users to notice.

Updating the progress could help in cases without pack.useSparse.

Thanks,
-Stolee
