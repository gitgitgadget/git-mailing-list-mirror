Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F94FC61DD8
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 16:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22F342076E
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 16:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TprSsef0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgKMQMM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 11:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgKMQMK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 11:12:10 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29576C0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 08:12:10 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id o15so10489157wru.6
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 08:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RUIIIkVtg6tdqqX0321ZMytL6vJHUa3OUpeyx8bNca4=;
        b=TprSsef0T6K5zGxutAG1K/0hpoWu8zfCejD4WO/FNCiicZUgVgbmmPn+C4pGYPIkoi
         sc89EwdK/lAWgf4veJ3THX3ilD2u2YGlG2ul6kun9tKj2VWMmmnK0g+hcCHS0JYot7ce
         xy5RxBYp07OAboJBebqz2HEHXwpQZuEhZ6IBN34s+FUz+VwAHdd4MgG9i87UDlKnAwSD
         20JK0a4phdnRwfUS1YJI6wEqwpURAUmDc+cw8Vi69MR9CPYtDeOO/Y0zX+T9tNQQDAcf
         xcMoCqw3Yr8lClWxMgyZOL8D6cc6e53Y1f4eciOvnhXREeoU6hQ5CHY6cloFNetmrpi6
         6DCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RUIIIkVtg6tdqqX0321ZMytL6vJHUa3OUpeyx8bNca4=;
        b=PKS33IkFqfbIUrMG4GwBrOqUoc2w/I2MXmqEdU4D24mKRTWZSHhmdFLdm7jjKvKKAM
         gHiIh0NkqATOM3g59nNpNxbQtvES4dHuRSN9xdi7qSlGcrLrV0AGNscNSIB/gr68qTwq
         L262qNfg+uu4R/3D9u9tCDxOpZUMs6HB/FOYhxMg3cRy+Y33IQc8DeSnY8W+LBOlnUqW
         SvKYBax7VSdvpc3H9I5Xd6+MfVftAXDQwpI5rrJKCQTo+B2HsedwyrG99fP6cdIPTivj
         hYkkKemPCRj2EqXYTuVut2X/hA2hQ0VJsqgOZpxZLaAnxwL229gG+qjRzO9ggneEeF4F
         SelA==
X-Gm-Message-State: AOAM532N7dy0+VZgkM8I2YWH+AE4lUZDZV+tRdNylM5fppn3j8473+bk
        bDJRPTJVmTcvIY2Ak8OpGoAoxi0W2/E=
X-Google-Smtp-Source: ABdhPJxzTKlkRJZzXnrc8Zf3cqKvPmh6S7WYj6CGCrOdl9wKWtcSlQOvlkAItkV8TUEogrfv8hsDhQ==
X-Received: by 2002:adf:e60e:: with SMTP id p14mr4545898wrm.188.1605283923970;
        Fri, 13 Nov 2020 08:12:03 -0800 (PST)
Received: from [192.168.1.240] (194.55.7.51.dyn.plus.net. [51.7.55.194])
        by smtp.gmail.com with ESMTPSA id g4sm10874720wrp.0.2020.11.13.08.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 08:12:03 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 09/11] add -i (Perl version): include indentation in
 the colored header
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com>
 <pull.785.v2.git.1605097704.gitgitgadget@gmail.com>
 <304614751ea1b1db80fbbbdc909b3d198c20313e.1605097704.git.gitgitgadget@gmail.com>
 <70fae5a9-354d-978b-c560-d7fcabb25c76@gmail.com>
 <nycvar.QRO.7.76.6.2011131457420.18437@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <041e9ff3-2447-e55d-f40d-079a84f0ad44@gmail.com>
Date:   Fri, 13 Nov 2020 16:12:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2011131457420.18437@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 13/11/2020 13:58, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Fri, 13 Nov 2020, Phillip Wood wrote:
> 
>> On 11/11/2020 12:28, Johannes Schindelin via GitGitGadget wrote:
>>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>>
>>> The header is formatted by padding each column heading with spaces up to
>>> the length of 12 characters. These padding spaces are naturally included
>>> when coloring the entire header.
>>>
>>> However, the preceding five spaces indentation for non-flat lists were
>>> _not_ included in the Perl version, but _were_ included in the built-in
>>> version. Let's adjust the former to align with the latter's behavior.
>>
>> I had trouble understanding this. I think my confusion is that the padding was
>> printed when the header was colored, but it was not inside the colored part
>> whereas the subject lead be to think there was no indentation printed when the
>> header was colored.
> 
> Right, this is ambiguous, but I thought it was clear from the first
> paragraph that "included" means "when coloring".
> 
> I'm not a native speaker, though, so I welcome suggestions to improve
> this.

Maybe something along the lines of

add -i (Perl version): color header to match the C version

Both versions of `add -i` indent non-flat lists by five spaces. However 
when using color the C version prints these spaces after the ANSI color 
codes whereas the Perl version prints them before the color codes. 
Change the Perl version to match the C version to make testing easier.

Best Wishes

Phillip

>> I assume this change is so that we can use the same test for both
>> versions?
> 
> Correct.
> 
> Thanks,
> Dscho
> 
