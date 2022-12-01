Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDE5C43217
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 14:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiLAOnT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 09:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiLAOnS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 09:43:18 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A1F9E44B
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 06:43:17 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 125-20020a1c0283000000b003d076ee89d6so1388241wmc.0
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 06:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9A+7ros1OV6CaHt7I44/NyRdUP02pdMAJi0hy1rceU8=;
        b=mgiby0i7FciE4BNmX3exGDtg4sxVkxsuIaRb92I+tnIDYdIg0Ah0J3vn14DAQVigDH
         LmkgJLRKgBRX+2MW3CKWNhaTotrrhPar/6OganLNMc/zxu8aV4960+LCW2MEOBXcxmll
         m5IDT6NPb850TE0zhfYJ6o8ESsvF3r8w7goHOKBPmrlS5ffakq4lmCgcp7nQiYjkFP/c
         Bp8jS8wwBV+Pz5yEysRSmQfD7tOSnjRrO+oVf4IEwRLrQm/+v0JmeU42zAUH8NumMppk
         uFeJtJGypHq0l/ZkRVZQ67aqJiBfzu4PZ1nb/kdNsrYDbqdHrWDzppH1c/jIW5pBjd4O
         gcyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9A+7ros1OV6CaHt7I44/NyRdUP02pdMAJi0hy1rceU8=;
        b=ndqF7t8iiUGHNUEJ4Suqj/+IPDK2N2CzgKcUVXLIjaJq36oVoTXzDQ5oIXVDolHb6E
         /B9QMVmUCI4mWLbKWOuWbsG/wsNXmKa94L/Yri3f1/RXzo/XBW27hIDYQsMgWXwQmS7Z
         i+PPMyq3Od/1iw+EnGFewLb1c3YKp8aONSiIRjDUvzy9LR7Jii6jHzKz04DyfQDWwe1V
         OPidr+9OmWCgQEt597RGzWXEl0+tjjFLa+eK6Go2SfboYkJw8nyDpW0WyfLZyHLtx1PB
         sxXfdiGeHH32SvauLR8uZS+4Y7GQ5eqWFwyHW+SN244w2WBbKdCSm7uWjS790reUBCse
         niPw==
X-Gm-Message-State: ANoB5pmLgMj5+lKGz2TN5gj+2FClK1At6a0YcxRa/VlGS19QxLQIqEvb
        BnhcpzS6Dm8dJKZmUIZ0Z9o=
X-Google-Smtp-Source: AA0mqf5Fn/DuOS0qHvMkl5kBqEdhCKF7CU+SuJyh2WMbcORvyotf2/SaLKZMQusssbRSo92wPI9s1Q==
X-Received: by 2002:a7b:c3c9:0:b0:3cf:5442:bbe with SMTP id t9-20020a7bc3c9000000b003cf54420bbemr53220124wmj.2.1669905795865;
        Thu, 01 Dec 2022 06:43:15 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id k26-20020a05600c1c9a00b003b47b80cec3sm10404910wms.42.2022.12.01.06.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 06:43:15 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <40ffe56e-cec2-7130-ca4f-2186a1b7681c@dunelm.org.uk>
Date:   Thu, 1 Dec 2022 14:43:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What are cherry-pick's exit codes?
Content-Language: en-US
To:     Sean Allred <allred.sean@gmail.com>, git <git@vger.kernel.org>
References: <878rjry5a7.fsf@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
In-Reply-To: <878rjry5a7.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sean

On 01/12/2022 06:39, Sean Allred wrote:
> Hi folks,
> 
> We're developing some internal tooling wrapping git-cherry-pick and need
> to be able to distinguish its different error codes. Problem is: these
> exit codes don't seem to be documented in git-cherry-pick.txt.
> 
> Looking at the source, I found myself down the rabbit-hole very quickly.
> I'm not too familiar with the coding patterns quite yet -- but I'm
> pretty sure I eventually found myself redirected to git-commit in one
> case. At that point, I thought it better to ask here.
> 
> I'd like to document these exit codes in the manpage and I'm more than
> happy to submit the patch, but I thought I'd confirm my understanding
> first since it's based purely on reading the cherry-pick tests:
> 
> Exit code:
> 
>    - 0: success, sequencer complete -- no conflicts

I believe this is correct.

>    - 1: 'success', sequencer incomplete -- conflicts encountered

One can get exit code 1 without conflicts. One example is when it cannot 
cherry-pick a commit because it would overwrite an untracked file. 
Another example is when a picked commit would be empty because the 
changes are already in HEAD.

>    - 127: fatal -- lots of reasons -- I'm guessing this is value for the
>      'return -1' and 'return error(...)' statements speckled throughout
>      the code, but it's been a long time since I cared about two's
>      complement so I may be wrong here.
> 
>    - 128: fatal -- sequence is interrupted, possibly due to some other
>      fatal error, e.g., 'commit doesn't exist' or 'mainline parent number
>      doesn't exist'
> 
>    - 129: fatal -- there was nothing to cherry-pick at all (e.g. empty
>      range)

A high exit code from die() indicates something bad happened but I'm not 
sure one can rely on the exact value to tell you what happened.

Best Wishes

Phillip

> I'm reasonably confident about 0/1 just anecdotally -- I'm less sure
> about everything else.
> 
> Obviously the actual text put in the manpage should be friendlier and
> possibly vaguer for clarity (paradoxical, perhaps, but it seems more
> direct to say '0 for success, 1 for conflicts, and anything else is a
> fatal error'), but I wanted to make sure that I have an actually-
> accurate understanding rather than something only surface-level.
> 
> Two questions:
> 
>    1. Are the exit codes actually documented somewhere already that
>       should simply be linked from git-cherry-pick.txt?
> 
>    2. If not, is the above listing the exit codes accurate and complete?
> 
> Thanks!
> 
> --
> Sean Allred
