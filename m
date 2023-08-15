Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3142C04FE0
	for <git@archiver.kernel.org>; Tue, 15 Aug 2023 09:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbjHOJQT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Aug 2023 05:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbjHOJPk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2023 05:15:40 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB49A6
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 02:15:39 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe24dd8898so48667355e9.2
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 02:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692090937; x=1692695737;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9VpElbbDNLpbpBiYnTGp68OppolZ+UTdZcJQ3qJnE1I=;
        b=QcOOSzfGXVafboXHM4iwlGiVZ5h0W8z9KSMhsPRu7Y5Zehzhgk951LTvT7ImoT42Fs
         VreHwyVvOD/f07qZ71z4mhxyz8rG/+jFLfXMyc//+WmV32WIOyDX/VGg2Q1d+lLsr120
         Boi3LIvRwEr+edLAuoO7CEgbtaGRyQxIQ9D4cXf/zVlJsngsUEvO/Q9AR3g9iAMC6wHe
         d2nzkasPkVLW816NXXS3cymKmK/U4wHO+4PzibWcwGv298IAeCJvQwGDVhKVxdDIoDrD
         xyKoVBg5xd5u8jgH18xCfBMwpafbj5y3oJ90l7Kzqgd3BIurMeBWWnDAQmKsBd86TnO4
         mCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692090937; x=1692695737;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9VpElbbDNLpbpBiYnTGp68OppolZ+UTdZcJQ3qJnE1I=;
        b=Kznkocc5BPN5UWsedPW5sJ2S5WGWd8wVhNXkKW/YoC1mEA+o/ckUoSN4cn8gBfDvCW
         hgoZjxws2noq7lLCP4dS5Z15Sh8sQiaBA1uALW+h7Xeg5ua14WLel0iORcgTk6wMZSX7
         +N2QeyG8niAIKlTDJ5WkeK/WcOjAhEF2IcWGjd9QrfsGWIo92a6BLIzVFILloPyX3ba5
         D/NVGdvpKqyaBK1CpH4sfZVO2ysEMlHoWZYbM2UWXsPH39ZBA1HNpuQeU5XMeLr3b8Mn
         5Tt6wdG0cvDZbKtP5g7la9wdbmuIpU6HruT2pv9AMzSYHVBovGDna6kqf2B2YuQYWR7v
         xmJA==
X-Gm-Message-State: AOJu0YyEhO9zzd0nSrXEDtfBw9zzrlqbHIbvuuXHZvq6OcCZ60PL0a7B
        2AYTdCAqjKvHyMTS4HfnLYk=
X-Google-Smtp-Source: AGHT+IEun8c2/I8CU2ljSgIAu4DKCXXYdo+Y8EyQTDz4XomfMHL5VS7g61F3GwFcJLWvEdWDnIMAYQ==
X-Received: by 2002:a05:600c:204e:b0:3fe:1287:d2a0 with SMTP id p14-20020a05600c204e00b003fe1287d2a0mr8936267wmg.21.1692090937273;
        Tue, 15 Aug 2023 02:15:37 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id k5-20020a7bc405000000b003fbdbd0a7desm19934561wmi.27.2023.08.15.02.15.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 02:15:37 -0700 (PDT)
Message-ID: <9f76de24-d337-ed41-fb81-888dba0b1656@gmail.com>
Date:   Tue, 15 Aug 2023 10:15:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v1 1/1] git stash needing mkdir deletes untracked file
Content-Language: en-US
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, friebetill@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <5260C6A0-C53C-4F6D-B899-6AD8601F8458@gmail.com>
 <20230808172624.14205-1-tboegi@web.de>
 <6e40eb0b-2331-1e39-bee0-c9720c24d1c8@gmail.com>
 <20230809184751.ffwolkvjwoptnmen@tb-raspi4>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230809184751.ffwolkvjwoptnmen@tb-raspi4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Torsten

Sorry for the slow reply

On 09/08/2023 19:47, Torsten Bögershausen wrote:
> On Wed, Aug 09, 2023 at 02:15:28PM +0100, Phillip Wood wrote:
>> Hi Torsten
>>
>> Thanks for working on this. I've cc'd Junio for his unpack_trees()
>> knowledge.
> 
> Thanks Eric for the review.
> 
> Hej Phillip,
> I have been playing around with the whole thing some time.
> At the end I had a version, which did fiddle the information
> that we are doing a `git stash` (and not any other operation)
> into entry.c, and all test cases passed.
> So in principle I can dig out all changes, polish them
> and send them out, after doing cleanups of course.

I don't think we should be treating "git stash" as a special case here - 
commands like "git checkout" should not be removing untracked files 
unprompted either.

> (And that could take a couple of days, or weeks ;-)
> 
> My main question is still open:
> Is it a good idea, to create a "helper file" ?
> The naming can be discussed, we may stick the date/time
> into the filename to make it really unique, or so.

I think stopping and telling the user that the file would be overwritten 
as we do in other cases would be better.

> Reading the different reports and including own experience,
> I still think that a directory called ".deleted-by-user"
> or ".wastebin" or something in that style is a good idea.

I can see an argument for being able to opt-in to that for "git restore" 
and "git reset --hard" but that is a different problem to the one here.

Best Wishes

Phillip

