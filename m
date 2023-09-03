Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506E0C83F2C
	for <git@archiver.kernel.org>; Sun,  3 Sep 2023 19:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347502AbjICTs3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Sep 2023 15:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347364AbjICTs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Sep 2023 15:48:28 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81168C0
        for <git@vger.kernel.org>; Sun,  3 Sep 2023 12:48:25 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3ff1c397405so7772605e9.3
        for <git@vger.kernel.org>; Sun, 03 Sep 2023 12:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693770504; x=1694375304; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5AC+3ljgVjhWqymycQpkqJKQtURCocX+/f6G3japCRg=;
        b=BOjJsMJ9NHKZ/IuNziKRZmxW6wyl1zELdq3dyOjXG96j2KBoK2SjxWpVeD86glhNwB
         28sIRBeM+3icAw51dtyd9vHqILpGRJcXZ1C0gku+FXp0NQrAYT358sFjSSXKuVs/+Bvh
         LXbYFuFG3J2kRjswQ04huFaT/ZGeFQ58xsSoCNRbpSjbjTJE5To6ut4AW0MdLIVpuQvd
         0/yZRR3OsJ7fqHJq5qOxiJJVYm2zA8cMogHC5bqTk5XuC4TCfYre+7RcW040/uaFBkHU
         y6DI8SuegkYp6zbwhEDlNUEJW2fvTAkMQNGGP67GNLZNO4RY/k3Xg6cGALye9GgP2ASj
         EemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693770504; x=1694375304;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5AC+3ljgVjhWqymycQpkqJKQtURCocX+/f6G3japCRg=;
        b=YY8Vpp37fs4eEcxoWTWpO9QxJ8NjEWGDgV5fFckUsGxP8WzdrT5x7VIMkbsZVTsbje
         l65b94S1YuQI62pgxt8c6h6wxNw3to5nr287TKsvuT/Lc1xQ4tQASm/NxaIN1YcXuRcm
         rZC7YCB3nNoq/nMoVBPQarNVYlW6RNJepEtKvg+jYp0EuNJyrV9XgM0NESJXPiYD9cxv
         AaZaCBEi79CrBB/Qi4V55/rICMtasyrllBmPE/0xrWzYMVTNZ5gH8cysiH+84oy0ER3u
         EK1BgRPtjnCTNqmAYtbgEd3k0+1ncBNTdYQB/rxYhy4Cn/IzLirBTdKg69q8JvFASnYg
         zWmw==
X-Gm-Message-State: AOJu0YyLYn01PNCnVmgaEC2HNMud4IQzZ0ymYvhnwEAyqUpztH4HhTek
        k88s0MpuDzGgN6DxHSoRnRY=
X-Google-Smtp-Source: AGHT+IEqfhhAS8QXKZr4SIb+85VCE3a06FXGWvQKcbdUafG4DcxWPrIeQr3GrA/A4lYA9d9w0b513g==
X-Received: by 2002:a05:600c:2283:b0:401:b2c7:34a4 with SMTP id 3-20020a05600c228300b00401b2c734a4mr6306313wmf.11.1693770503703;
        Sun, 03 Sep 2023 12:48:23 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id j22-20020a05600c1c1600b00402be2666bcsm7373840wms.6.2023.09.03.12.48.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 12:48:23 -0700 (PDT)
Message-ID: <fdf80c36-0e28-44f3-9cef-85d38d2d48f1@gmail.com>
Date:   Sun, 3 Sep 2023 20:48:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sequencer: update abort safety file more sparingly
Content-Language: en-US
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20230903151132.739166-1-oswald.buddenhagen@gmx.de>
 <29fb7a38-1e92-457a-93ff-0e64ac09b907@gmail.com> <ZPTdmnHfDcTBqaSl@ugly>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ZPTdmnHfDcTBqaSl@ugly>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/09/2023 20:25, Oswald Buddenhagen wrote:
> On Sun, Sep 03, 2023 at 07:40:00PM +0100, Phillip Wood wrote:
>> On 03/09/2023 16:11, Oswald Buddenhagen wrote:
>>> The only situation where the file's content matters is --continue'ing
>>> (after a multi-cherry-pick merge conflict).
>>
>> I don't think "cherry-pick --continue" consults the abort safety file,
> duh, obvious blunder.
> 
>> it only matters for "cherry-pick --skip"
>>
> that doesn't seem right. a --skip is just a --continue with a prior 
> reset, more or less.

sequencer_skip() calls rollback_is_safe() which checks the abort safety 
file.

>> and "cherry-pick --abort".
>>
> that one, of course.
> 
>>> This means that it is
>>> sufficient to write it in a single place, when we are prematurely
>>> exiting the main workhorse.
>>
>> I think this introduces a regression because the safety file will not 
>> get updated when "cherry-pick --continue" stops for the user to 
>> resolve conflicts.
>>
> true, there is indeed this second entry point.
> i'll try to find a better "choke point".

I think that is probably tricky, I'm not really clear what the 
aim/purpose of this refactoring is.

>>> which wasn't even reliable: a single pick executed during an 
>>> interrupted sequence would bypass the safety.
>>
>> An alternate view is that the abort safety file exists to prevent the 
>> user losing commits that have not been cherry-picked and it is 
>> desirable to be able to abort after cherry-picking a single pick in 
>> the middle of a sequence of cherry-picks.
>>
> if you did a fresh commit before or after the single pick, you'd lose it.
> also,

Oh, I can see that you'd lose a commit made before a single pick but I 
don't see how you'd lose a commit made after it. I'm still not convinced 
it is a particularly helpful change.

> the feature doesn't actually prevent aborting, only the automatic 
> reset.

Oh right, it removes the state directory but leaves HEAD untouched if it 
does not match the commit recorded in the abort safety file.

Best Wishes

Phillip

> regards
