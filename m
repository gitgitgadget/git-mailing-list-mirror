Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109EBC47089
	for <git@archiver.kernel.org>; Sun,  4 Dec 2022 15:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiLDPOC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Dec 2022 10:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiLDPN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Dec 2022 10:13:58 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2A613F3A
        for <git@vger.kernel.org>; Sun,  4 Dec 2022 07:13:57 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id ay40so291219wmb.2
        for <git@vger.kernel.org>; Sun, 04 Dec 2022 07:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYN+IeX3XVSYIjKk6PYUS/Jcewb37RlLog/8heXw2to=;
        b=Gck/nLkZw/0YUeZjxARCdiDR0yASL8vY4Lk43ahBvllj8bH0YtQZja+ivGuvZx6yMy
         Uoou03ZxwVufH77yfTZOSDq/iPRHKJBkU+Im+N1YKD4ozJ4VsABh9H5K9ZYBfPsDoxHs
         8hZXSNEjrcbNPzTvP6gLNOMaKhT6E4c1Pz5mPNfwgbtn9KCpYBQGG5tfvGDQLGZiJiyN
         Uqoe4+/but39+rcXWFrpYzEIQ1hR+PxDL9dFSAWyC7N7QdZx4e3/Si3XgisbsCJu6Ukb
         v3zYRJg0X6OkzHl8Fl2jF0s5i4RcfAJ6C5YWR0EqO5xwSzrM4y7TTYdr8JnnVr90MGSc
         fmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYN+IeX3XVSYIjKk6PYUS/Jcewb37RlLog/8heXw2to=;
        b=k4TDcPVPBeh4rZ8PlIzOIn6igriTXW+Zf86xl0vQwEMwMDXe8ReSZxRzDv/XztguOU
         OND1FL6aqxV17dZfMJoqSaJDGXfipuNh+GzzBCZ5TxHYIp1A+5t+Odv1GgXli2TF2dlR
         uZhFBmGo/j7PmzmAdQR2n4Z8Vb5PWOSBTcgufwnOMYdQrtKPodODMiPwqMpz3FATD14T
         WIAHRQzu7KC+U6tny8Is8tixf1dp3IAsQKWS3uZAvyPV0qVJF9GN/6ReoTTSANzhztrE
         cVukoy+wjh6D2HbIWhoa+yEGekhYvX4Asz8XuDetNtOjiWXWNeWzDl6gwAbjMSWWkGzO
         Vglw==
X-Gm-Message-State: ANoB5pn7lrp81AWgatDVXvOJ2C33skZO42m6ot5oNN4uzfhNBqWCeAM+
        I7mse/MQnPdkrCMfNnu3mdPl0tGjF1Y=
X-Google-Smtp-Source: AA0mqf5ABE5DeC0ofhEMBx1gFdIkjemjGjLAbVxHW0DA8e0m8PSX+Dta8CGh2QtVY5r0S3tz623DJw==
X-Received: by 2002:a05:600c:2e12:b0:3d0:7e33:9e39 with SMTP id o18-20020a05600c2e1200b003d07e339e39mr10831565wmf.18.1670166836283;
        Sun, 04 Dec 2022 07:13:56 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c468800b003cfaae07f68sm19837239wmo.17.2022.12.04.07.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Dec 2022 07:13:55 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <a97758b5-dfdc-9a24-654b-8846a9feb45d@dunelm.org.uk>
Date:   Sun, 4 Dec 2022 15:13:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git cherry-pick -x: missing blank line before the "cherry picked
 from commit" line
Content-Language: en-US
To:     Vincent Lefevre <vincent@vinc17.net>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
References: <20221202141153.GA5599@cventin.lip.ens-lyon.fr>
 <75e00d43-3184-dcf8-4621-cdf02c9f7320@dunelm.org.uk>
 <20221202170144.GC5599@cventin.lip.ens-lyon.fr>
In-Reply-To: <20221202170144.GC5599@cventin.lip.ens-lyon.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Vincent

On 02/12/2022 17:01, Vincent Lefevre wrote:
> Hi Phillip,
> 
> On 2022-12-02 16:41:23 +0000, Phillip Wood wrote:
>> On 02/12/2022 14:11, Vincent Lefevre wrote:
>>> With git 2.38.1 under Debian, when I use "git cherry-pick -x"
>>> on a commit such that the last line of the log message starts
>>> with "note:" (case insensitively), the blank line before the
>>> "cherry picked from commit" line is missing.
>>>
>>> For instance:
>>>
>>>       New commit
>>>       foo
>>>       nOtE:
>>>       (cherry picked from commit 3ba643e2eec4bdc1cd46b478ab36ee0707d241c2)
>>
>> "git cherry-pick -x" takes care not to add a blank line if there are
>> trailers such as Signed-off-by: at the end of the message (if it did then
>> the trailers would no longer be recognized as trailers as they would not be
>> the last paragraph). In this case the "nOtE:" line looks like a trailer and
>> so no blank line is added.
>>
>> I can see it is annoying in this case but I'm afraid I don't have any ideas
>> of how we could avoid it without breaking the case where the message does
>> contain trailers.
> 
> First, one issue is that this is not documented (I was not aware of
> the notion of trailers, well, at least concerning a special handling
> by Git).

They are mentioned in the documentation for 'git commit' see the 
--signoff and --trailer options. The main reference is 'git 
interpret-trailers'

> Then perhaps there should be some configuration to define which
> tokens are allowed (or forbidden) for trailers. For instance,
> I would say that "Note" is too common in log messages to be
> regarded as a trailer token.

There are some safeguards when looking for trailers (see the 
interpret-trailers man page) I think you have been unlucky here, I don't 
remember this being reported before. I've cc'd Christian who knows more 
about trailers than I do to see if he has anything to add.

Best Wishes

Phillip
