Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1718C47080
	for <git@archiver.kernel.org>; Sun, 23 May 2021 18:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A514661263
	for <git@archiver.kernel.org>; Sun, 23 May 2021 18:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhEWSW2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 14:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbhEWSW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 May 2021 14:22:28 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927EFC061574
        for <git@vger.kernel.org>; Sun, 23 May 2021 11:21:01 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id h21so19150521qtu.5
        for <git@vger.kernel.org>; Sun, 23 May 2021 11:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7ned0EFZCSLYNO7+L/FPwtdF2JCnepbpwJYncxof3Es=;
        b=vM50Vc6YRC8ajLCcA1a/slRuDUuyTZp/amTwKcf/pcg8FEtW6ePhKwbc0FmkbH5bSw
         Js5SjG/+3PZ1WtcG9uQFrcJKrPP8GVzud9c6pGy+N0URXcKE/nolMcTap24JuFx+MGkw
         p416y82puBYdcaWfMokDniLECCE+dyzce5ThRcE5nIvgaY8Xnd6wAEusiFpHawi0ZHeB
         Wn2z65dxMt2wlIc690QsgfIbnMGYB3vAtYvemrwt9+pcYPM1yd2Sg7HooZH/w41q89Wy
         uVEzzGGGt+GNcraOnyv6PdWwms6jY9opnScJZpHXi01OIcbSA+E+kIg1fMHtEUF4k6hJ
         B9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7ned0EFZCSLYNO7+L/FPwtdF2JCnepbpwJYncxof3Es=;
        b=hOGarM/49CDvQA1tY+EdJIoBasb1/0xK4hfE0HWZpI7BW+pGNKw0RH3a7cLe20+8qb
         YioS+ceUHdAgECKk1J2ZgiJi/YdeoZ0mt6gj7Cjk492SOShzReOl7uLP4iWqx7If6Wd7
         X1IFjI2YwPF41CF3sZcacleIivb5gX0AeUtGqPLImuG8W3uiLtAUhceUCHKF/GvSTEMp
         Vy51Bgw2BBJX1BKxzR+huJxXhNJrQOUq4IejbLsi9eaDjj6GqqBKiV6GqiZSa73TTi5u
         bUI2enJSLUgqdtuSv8PfeWysQVuP91QBthjjXxc8gb0J73OtXEb6hckXwXhX01phUEOl
         +IQg==
X-Gm-Message-State: AOAM530GB7LlNaMKb6fnVIK/JabDDtssCx2Nake0/pCsNbODADo24SNI
        CBTSlaWET/UakOVUSqjEj98=
X-Google-Smtp-Source: ABdhPJwu7/TYSQQb7YV+HT/5YULIaa5bZshKXnTvH82nyxZT9a0Q3QKb1v6Z4iHscFfNKtzmuD6R2A==
X-Received: by 2002:aed:210f:: with SMTP id 15mr23352636qtc.149.1621794060526;
        Sun, 23 May 2021 11:21:00 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id q21sm8129233qke.32.2021.05.23.11.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 May 2021 11:20:59 -0700 (PDT)
Subject: Re: Formatting options are ignored when tracking functions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     aidgal2@gmail.com, git@vger.kernel.org,
        Thomas Rast <tr@thomasrast.ch>
References: <EE7D39E6-D826-49E2-AD0E-090A83DFDEC1@gmail.com>
 <xmqqczthnwuu.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <d801fe76-f40d-91ef-653e-925aba0fbdf4@gmail.com>
Date:   Sun, 23 May 2021 14:20:58 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <xmqqczthnwuu.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 2021-05-23 à 14:11, Junio C Hamano a écrit :
> Philippe Blain <levraiphilippeblain@gmail.com> writes:
> 
>> I believe this is working as advertised: only the first line of
>> the commit message is shown.
>> However as mentioned in the doc, the -L option also triggers patch
>> output (-p), which you can omit if you explicitely add --no-patch
>> (or shorter, -s).
> 
> Heh, I think "working as advertised" is not wrong per-se, but this
> feels like a clear design mistake to me, at least at the UI level.
> Admittedly, I've never used "log -L" in scripts and I've always used
> it interactively, in a context that I want to see the patch output,
> so this did not bother me so far.
> 
> But what commits -L decides have relevant changes and how these
> commits are shown ought to be orthogonal.  It surely may need to run
> the content-level diff machinery to see if each commit affects the
> area of the code specified via the -L option, but just like "git log
> -S<text>" can be used to find commits that change the number of
> occurrences of <text>, and allows the users to choose to view them
> with "-p" (but not force the --patch mode on), it should behave the
> same way, I would think.
> 
> With a clear migration plan, we should be able to fix this over
> time, I would think.
> 

I agree with that. I was just pointing out that it does work as the doc
says it should work, without implying anything about what should be the
behaviour in an ideal world.

In fact in an ideal world, '-L' would support all "kinds" of diff output,
i.e. --stat, --summary, etc.

I do not have a clear opinion on a migration path; if consensus can be reached
that not implying '--patch' is a better behaviour, then changing the behaviour
would be OK. If some people use scripts that parse 'git log -L' ouptut expecting
that '-p' is implied, I would expect it's pretty easy to notice the breakage and
add the now-required switch... but I'll let others be the judge of that.

Cheers,

Philippe.
