Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF98BC433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 18:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B043E61B44
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 18:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhKQSie (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 13:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbhKQSid (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 13:38:33 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FE2C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 10:35:35 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id m11so3777424ilh.5
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 10:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=iJWZ1vsXCJuw2GKQqhrzUFARTq11fgN6RD0HbnPpC8o=;
        b=o3m75jgKvO7eFvEJ9OYScJ6UOLzwIKr3uJXTrVdzH0gMBVdpstc0STrtbhXuRxpQPc
         UuJXAl4SRp/huYLq+uOPTxt8YyOCSmgH+AWqnD8JdxazPKG895Sxx8nyveq4f/8TfpOh
         YqAaLr3ACD8qQBcHn1QhDaZd8nXNBmV0ginU8ijTIln7XxIItjcYTXY++FpoKMMzGtG4
         W8X15CQODeyq41lLEuRwMUQol/mA7w0rTpDOFg5Lh8EZsrpsJe6rXLJ5fuRA9v9K8bZi
         Zw8+zmTot4/iX3zIRftvYAqMvCub9zMv196n3f57FkhDzw8dhWNcW3Hh8zS94ITih3TX
         vZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=iJWZ1vsXCJuw2GKQqhrzUFARTq11fgN6RD0HbnPpC8o=;
        b=0fvZDZHamnsqSfkCRv9ge8fJEageL2+WkBC8dDuo5KmoyowER+Ejwt9pi1DexSl0rZ
         rziEdzCQrgiSX5Rt/D/VTzORYkzyrPbu3iPbTs+HRJ2DgVThOfC7ilQCd1RE91FNHFBi
         +eyB1y5vwXqmEOLi4njGrjhCyOyBe5f0Tm+2Yge216dn2uBopk9ckxKQUaEgtTSy77VU
         ktRgTc74Da1bkTrT9U7pf5iD/gGz6oN525yCtjBsH1ixYisVgT4teLzdHcoDRTGwb0gy
         pne0zXTHRmM3LZmb7IZQ0GbQ5EQRWb9F+7BbS4m+mlKMKfpNtvUT1IOLZjJE9EAnZzA0
         0Twg==
X-Gm-Message-State: AOAM533auUM3pPa1cS2SgS5OvzTz5bUqc5j9w6M5WmBoRkaIfMuB7oRT
        +Vid/IVY7goRSLItZKt3LS8=
X-Google-Smtp-Source: ABdhPJxsLBBZO/vlqDamYKvNdRCdp4OqNGhYupGps1okyImPo227Dtrk9YNCO715+VS6JYMqICzQWg==
X-Received: by 2002:a92:dc0c:: with SMTP id t12mr12548771iln.198.1637174134547;
        Wed, 17 Nov 2021 10:35:34 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d1ee:6c8f:319:f5? ([2600:1700:e72:80a0:d1ee:6c8f:319:f5])
        by smtp.gmail.com with ESMTPSA id h10sm406896ild.85.2021.11.17.10.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 10:35:34 -0800 (PST)
Message-ID: <5d1b5ce6-d9ff-1b2a-2ff2-19813c957a24@gmail.com>
Date:   Wed, 17 Nov 2021 13:35:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [Question] Unicode weirdness breaking tests on ZFS?
Content-Language: en-US
From:   Derrick Stolee <stolee@gmail.com>
To:     Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <9393e572-0666-6485-df29-abad5e0d32a1@gmail.com>
 <20211117161226.xcat77ewhf5inaif@tb-raspi4>
 <20211117170613.kyoe6ov2m5wi2i56@tb-raspi4>
 <20211117173924.maporsti5cz2ixsu@tb-raspi4>
 <8a3d0d0e-cc82-b696-00f4-b71e6452e1bd@gmail.com>
In-Reply-To: <8a3d0d0e-cc82-b696-00f4-b71e6452e1bd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/17/2021 1:29 PM, Derrick Stolee wrote:
> On 11/17/2021 12:39 PM, Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= wrote:
>> On Wed, Nov 17, 2021 at 06:06:13PM +0100, Torsten B??gershausen wrote:
>>> On Wed, Nov 17, 2021 at 05:12:26PM +0100, Torsten B??gershausen wrote:
>>>> I'll can have a look - just installing in a virtual machine.
>>>
>>> So, the virtual machine is up-and-running.
>>>
>>> I got 2 messages:
>>>
>>> ok 9 - rename (silent unicode normalization) # TODO known breakage vanished
>>> ok 10 - merge (silent unicode normalization) # TODO known breakage vanished
>>>
>>> Do you get the same ?
> 
> Halfway, I see this:
> 
> ok 9 - rename (silent unicode normalization) # TODO known breakage vanished
> not ok 10 - merge (silent unicode normalization) # TODO known breakage

Making this even more confusing, my original output shows both of
the TODOs vanishing, but I can't make that happen only running this
test. However, with "prove -j8 t00*.sh" I can get them to both
vanish:

Test Summary Report
-------------------
t0050-filesystem.sh           (Wstat: 0 Tests: 11 Failed: 0)
  TODO passed:   9-10
t0021-conversion.sh           (Wstat: 256 Tests: 41 Failed: 1)
  Failed test:  31
  Non-zero exit status: 1
Files=53, Tests=2896, 15 wallclock secs ( 0.59 usr  0.07 sys + 26.96 cusr 13.95 csys = 41.57 CPU)
Result: FAIL

