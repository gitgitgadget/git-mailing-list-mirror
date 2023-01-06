Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CC1C3DA7A
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 14:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbjAFONV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 09:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjAFONU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 09:13:20 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC957B481
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 06:13:19 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id x25-20020a056830115900b00670932eff32so981557otq.3
        for <git@vger.kernel.org>; Fri, 06 Jan 2023 06:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fde2JvIRSjkKQtzBkeUbq/ue3vL3mJUofL6BnKxsbqU=;
        b=OWZIOBaZBHUrkWOsS7d9MmJV+Bwh2aciqcbf2s04RIC08Ms/3ZgJsl1aNC88WshLAC
         KVvKTCATuQm/NURM4up8CC2CtZyw3r5iIwtpxcIGwWcRgAfFeT8C4fGHWuijty5eNtDM
         NAwGJ5N5xhkVTjLzavsGQls4GSpBVgJqIk1bBEOwMvZjT+2I7+tFXuT6Kf8GLbIAXl1u
         CFOhzuNuQ1nLdAgfE+DcNe9OT2KeU7eAoF0ZIGcVTXq7z8yU2dOfAxPUlZ8UG+ss8ZBM
         ziMF/qcR6OLfwC+T1k1SYJp9VZXxpZv+bm/7AWsVMktt8B/NzDSg0Us6KBx0LVHO8RC+
         4cqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fde2JvIRSjkKQtzBkeUbq/ue3vL3mJUofL6BnKxsbqU=;
        b=e+PI9pO+Q4+P+T26ekStZD+bbCl4y8Q4+6C2GS90YkAPLccBjMeCFtffNPMLeq6DBm
         +kv0UmyLEtll75RlKDZe/MiM0Xx9P2wUzXqGll/KKhx2ZlHqGDKeQk4rYu3nm6EPQR5Q
         ji5EmGuM8XkagJecS1EHzRJJbHDGFnLfSWRH7ZipdUD9h1gY0ZMy9RvCW4J9LWcJk+Ra
         SND8QMcOT4eMi1aF3XEdgm8K6euYNODp4iWXsdeNvn0QbFLpyz5ZVN0pjAJCftT0jGvl
         ooyIDZUXvg3ZwoE1j09Jb1Y/GdJ71NEtuJK5T7a75YtVFf3i/eN2vMu1lE7sXCr2BX7p
         PcjA==
X-Gm-Message-State: AFqh2kq/O7xYuNosKAvO4An1gEQguvbsYRUyhlPKkVpxsyF138d1blUm
        mb6+xhecOH6CB2+zPmPQtOwW
X-Google-Smtp-Source: AMrXdXtMiYA4WLU/upk3a1+FGUCwSa7/B9fE3AJFSH46g3Gpg2LqNhWvQs1oClcj3rTnha3b8bhs6A==
X-Received: by 2002:a9d:7a86:0:b0:677:9d4e:14a5 with SMTP id l6-20020a9d7a86000000b006779d4e14a5mr27750662otn.35.1673014399110;
        Fri, 06 Jan 2023 06:13:19 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:715c:222d:8069:3fe7? ([2600:1700:e72:80a0:715c:222d:8069:3fe7])
        by smtp.gmail.com with ESMTPSA id a20-20020a056830101400b00670668c2e7bsm577094otp.62.2023.01.06.06.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 06:13:18 -0800 (PST)
Message-ID: <12bfe644-1781-fb68-6b1d-edbe60ba9527@github.com>
Date:   Fri, 6 Jan 2023 09:13:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] test-bundle-uri: drop unused variables
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?=c3=86var_Arnfj=c3=b6r=c3=b0_Bjarmason_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org, gitster@pobox.com,
        me@ttaylorr.com, newren@gmail.com, avarab@gmail.com,
        mjcheetham@outlook.com, steadmon@google.com, chooglen@google.com,
        jonathantanmy@google.com, dyroneteng@gmail.com,
        Victoria Dye <vdye@github.com>
References: <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
 <pull.1400.v4.git.1671722058.gitgitgadget@gmail.com>
 <13e4c82e3380d8b91583550e61671bd8eac69ab1.1671722058.git.gitgitgadget@gmail.com>
 <Y68Sc3V5x6xSucZW@coredump.intra.peff.net>
 <9bc96719-d6c7-a127-d80e-a42ecaa0803c@github.com>
 <Y7fgV5eFx78BHdQ4@coredump.intra.peff.net>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Y7fgV5eFx78BHdQ4@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/6/2023 3:48 AM, Jeff King wrote:
> On Thu, Jan 05, 2023 at 02:09:34PM -0500, Derrick Stolee wrote:
> 
>>> Not a huge deal, but I noticed that Coverity complained about the
>>> uploadpack one because this hit 'next' (the server_options one I found
>>> manually, but it was kind of obvious when looking at the other).
>>
>> Yes, removing these lines would be fine. Perhaps there were
>> uses for these in an earlier version that were dropped. But
>> we can remove them now and then add them back when they
>> actually connect to functionality.
> 
> Thanks for confirming. Here's a patch that can go on top of
> ds/bundle-uri-4 (or just on master, as that topic has now graduated).
> 
> -- >8 --
> Subject: [PATCH] test-bundle-uri: drop unused variables

Thanks for putting together a formal patch. LGTM.

-Stolee
