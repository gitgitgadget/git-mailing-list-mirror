Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FF0C352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 14:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiLGOok (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 09:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLGOoj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 09:44:39 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928632671
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 06:44:38 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id y15so16278885qtv.5
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 06:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tNUrr1PKKLtBXf7Iup/gU8VcmaZjLJgYVJ7qiRk1F4M=;
        b=IhBxrKLDn9CUhMmvCtRkkL+p42U5nTVopjZL8nUjU73th+tsBvudOEat/uNcuSD5lN
         gEK+iOpIBJ6ILo1ZO51boq6kV28KxCmVXZ0NrI8YmAg7SHARiNMIhjuX894ryCwM1dz4
         x8XlXRx/NCexS+C6Sis8V/kivhapheWlIjbkmqeg8odyIqOOaOxXXR01/MZWnA1QyjoU
         3V6XZ+EB+LrOrB6hNUYRoA3VINO5XrdN1XMLeKzukrp2NTPRZvA1hxTFvj2erLRE3RpV
         UTTx+6+1dXj0Qr1mRCB1Iz9tZ7SKjG2YaHAhV+DcYxhzWFuMapm8Ejt7+8694PEg+Fin
         Pi5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tNUrr1PKKLtBXf7Iup/gU8VcmaZjLJgYVJ7qiRk1F4M=;
        b=FnRT/WHlGJcjy1jheZCkBwxcW5MvLUybcR0Y7zcnvtneXrdth5YgHMIFOnWtoKOZMf
         EN7liC4O4NTayBLAYA2OfdqOM5grEX3wq3UcVwPyF3hpfm+vIMvwEO1z2N6ppMQgNXMg
         FNvgyUxXYfNj+rfTMblMxzBmfdvtIBCpeBFdleoOBXDD9XlfvUYXYKCDtbdpNUPj5OvL
         V6KEBFbm8ioOrKSMvxwv9KLz4h1H9nAGA0+a/TWwVzv+ZvAA6YNTyiW6lT9c8lD7r2P9
         MAbLsGWwl5UFebF8MW4v0GxrQbMGnuHgpyDUteTZ4CizK0t5X5QWDtPg8nC3BflOg2sf
         OunA==
X-Gm-Message-State: ANoB5pkPXPyCq4jAbH/3YqLaWYTR73rFXNYBIaO+lAETVUjVgqbrDYe6
        +IequFL21TxYfMMLs8smmxnY
X-Google-Smtp-Source: AA0mqf5PHjYM3UAIVXs0rUz7Ox+prrvH20tSP4xVN8Ayz0ssOiiOVTa9vK68sYaUFMyETCm2u1JhhQ==
X-Received: by 2002:ac8:5311:0:b0:3a7:d893:3ec9 with SMTP id t17-20020ac85311000000b003a7d8933ec9mr13872715qtn.454.1670424277695;
        Wed, 07 Dec 2022 06:44:37 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:340d:5282:3bc6:4541? ([2600:1700:e72:80a0:340d:5282:3bc6:4541])
        by smtp.gmail.com with ESMTPSA id g17-20020ac870d1000000b003a7e66e5b67sm5083907qtp.78.2022.12.07.06.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 06:44:37 -0800 (PST)
Message-ID: <98ee4b5b-9d72-31fc-d5b1-1a978450973f@github.com>
Date:   Wed, 7 Dec 2022 09:44:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v3 08/11] strbuf: introduce strbuf_strip_file_from_path()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com, dyroneteng@gmail.com
References: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
 <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
 <1eec3426aee12bbd674ebd646075f0d4c0b1f5af.1670262639.git.gitgitgadget@gmail.com>
 <221206.86a640dda3.gmgdl@evledraar.gmail.com>
 <221206.86wn74bw35.gmgdl@evledraar.gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <221206.86wn74bw35.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/6/22 6:37 AM, Ævar Arnfjörð Bjarmason wrote:

> FWIW the "overkill" change on top to do this via callbacks is the
> below. Which I tested just to see how easy it was, and whether it would
> fail your tests (it doesn't).
> 
> -- >8 --
> Subject: [PATCH] strbuf: generalize "{,r,l}trim" to a callback interface

I don't like this approach and think it distracts from the goal
of the series. If you want to update it afterwards, then by all
means go for it.

Thanks,
-Stolee
