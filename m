Return-Path: <SRS0=yx/J=7F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48884C433E0
	for <git@archiver.kernel.org>; Sat, 23 May 2020 18:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2006F20735
	for <git@archiver.kernel.org>; Sat, 23 May 2020 18:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1TDb8e0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387587AbgEWSuo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 May 2020 14:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgEWSun (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 May 2020 14:50:43 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AD1C061A0E
        for <git@vger.kernel.org>; Sat, 23 May 2020 11:50:43 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u188so13182556wmu.1
        for <git@vger.kernel.org>; Sat, 23 May 2020 11:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nnonvk7g0v1VbJlY3qSRa80Y1JTNirQOZiJScfsqVzg=;
        b=R1TDb8e0fzqCE/7UXk0ThGabp8DjynH2kV8rdyabvKD9UX/cBWkLNoRvZXhdV/i6s8
         ihiIQ7bZKUGe3MAUSWfQ0worXFRZ3YPff7Vzgw3hHiYP5JyhPisWlDYo4Zz8j+a/wftk
         OJ9jYB/EEOPGyxJP4TW1QkFKBzaWkX5vVb7KQtmjGoIqTteaHSll1K6TR9B2sQfu6hSG
         Ygbe7/+dXlksvousr6cD/tN2U9X68j/Le5emja/CH8x0fdt35Pt/u9kp3TheK3ns3s84
         KtbmkqvTXVGT//yZ8id/tBCuAY3DNYqKxxIW76RGb/xkL6yA153QD0Ogg+NL7SwouXRG
         hZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Nnonvk7g0v1VbJlY3qSRa80Y1JTNirQOZiJScfsqVzg=;
        b=Caqf03P/Fx94LInc7A/F5MUusV5kF47Shv9fAL0Kg9us+LXD/S2wqRvNuWBUQ+WMbd
         BSRie6BB6iCg5V3d96762V45S2VFN5vPAOuKZiDc/I9+GzlP6FjOK8TQfGBmZkltrnF3
         4LoDHn7ssi0JMKWE54DPkMwYDIQoee6N8PIxfmIiaajzTISCX2nl1RVVW472S5qKqv9i
         UnCsHBDRpxDtm6hDq7MPSulTY4HLQs8WmzWic10sBM3GF7GxcL2rKdTTjkhN07hG01Js
         LXKbH4GsEdAn78zUg3blifbJ13P7PDQ60ymEm1c2Nw8Hg7l6MrRugJ7jiGexhr1iqYdi
         q3hQ==
X-Gm-Message-State: AOAM531OhBvEKQdaspE3XCACkTFw2JGRrEfmrhOfLIJUWhsprM8Cld6v
        6WGAWnrNgY4tvtDCAdPL7/lD74AT
X-Google-Smtp-Source: ABdhPJyaIoOdt6Fafeb5ORCygpQWOLEHnzT8YKoY6qBDNPtFPPKthhndjImH/stn0+Td5hhju/IDjQ==
X-Received: by 2002:a1c:bc42:: with SMTP id m63mr6691657wmf.11.1590259841875;
        Sat, 23 May 2020 11:50:41 -0700 (PDT)
Received: from [192.168.1.240] (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.gmail.com with ESMTPSA id n17sm12597058wrr.42.2020.05.23.11.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2020 11:50:41 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 4/5] rebase -i: support --ignore-date
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        phillip.wood@dunelm.org.uk
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200521101455.63484-1-phillip.wood123@gmail.com>
 <20200521101455.63484-5-phillip.wood123@gmail.com>
 <20200523123025.GA20683@danh.dev>
 <bc6bc4d4-79cb-f788-deca-41a3735fcaae@gmail.com>
 <20200523155203.GA10163@danh.dev>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <0cf07e92-25f2-ae0f-6f44-c2cd9e9f4851@gmail.com>
Date:   Sat, 23 May 2020 19:50:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200523155203.GA10163@danh.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Danh

On 23/05/2020 16:52, Đoàn Trần Công Danh wrote:
> Hi Phillip
> 
> On 2020-05-23 16:43:39+0100, Phillip Wood <phillip.wood123@gmail.com> wrote:
>>> On 2020-05-21 11:14:54+0100, Phillip Wood <phillip.wood123@gmail.com> wrote:
>>>> +# Checking for +0000 in author time is enough since default
>>>> +# timezone is UTC, but the timezone used while committing
>>>> +# sets to +0530.
>>>> +test_expect_success '--ignore-date works with apply backend' '
>>>> +	git commit --amend --date="$GIT_AUTHOR_DATE" &&
>>>> +	git rebase --apply --ignore-date HEAD^ &&
>>>> +	git log -1 --pretty="format:%ai" >authortime &&
>>>
>>> Those --pretty="format:%ai" won't print the newline character in my
>>> test environment.
>>> It looks like it won't print the newline if stdout isn't a tty.
>>>
>>> 	git log -1 --pretty=%ai
>>>
>>> doesn't have that issue.
>>>
>>> I think there're some grep out there considers file doesn't end with
>>> newline as non-text files.
>>
>> Yes it would be better to print the newline, thanks
>>
>> Junio - are you happy to fix this up (assuming there are no other issues) or
>> do you want a re-roll?
> 
> There're 11 invocation of git-log with "--pretty=format",
> in 2/5 and 4/5
> 
> I think it's worth to have a re-roll to avoid mistake.

The part of my reply you've cut said "I've checked the log invocations 
in the other tests and I think they're all OK." So it is just the one 
that you pointed out that needs to be fixed up (the others without -1 
are all checking the result of rebase --root). I'm happy to re-roll if 
Junio wants - lets wait and see what he says.

Best Wishes

Phillip
Phillip
