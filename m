Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B95C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351749AbiCXQlg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351756AbiCXQlf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:41:35 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E0558830
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:40:02 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so5463881fac.7
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vGrYn5l1qbtUgkLesVrNII0Q+/G38/JecIZFIc06BpA=;
        b=KtvNjFnDY4rUCvZFsCRJFKADe90s8RvS0DFSLQE8Y8HDGoDb6mvtjlQ+75IolZ9EeD
         jTiE3mHPdGW/TKEp+Qbtw3gNABaDYAQjQE+bFVo0cioQZN14QpnaPlSjsXB9AKmJk2qA
         rVNL94sBQguZLLdD0nAbDXdTE0XPb87WeNosSG2YlPepzTfmdmEA9B/9B1eDT/1RthW9
         dt2uylgF1A4ExfpCkbwOEbvcanzE1wvtfUiKDh8kJQk3p3WSy9yfK/Iyb+QlCx5qfVDZ
         XecJDohTAZStTRr3FrlvkEVBRaPFdMs/7iKmctLOG8Z2VDckD5xtYuadTHA3R7MwFmmJ
         5Ysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vGrYn5l1qbtUgkLesVrNII0Q+/G38/JecIZFIc06BpA=;
        b=MP7hQHVMrmcar1a6ZdejVb2RjcwBPmnhYfN9RTUo9DSQu2M4HY7A4QgLo0caU2vik0
         zk0FAmaa5dXAGlmJyEMNwIds7XrX+3ewcimWQ2jAtArxPSHyGkgK2jzdAb6z0u/MuK7/
         zEhMS7YpxO9R2jnw8qLPtG4PWoY3ukBSr9TKJh4r6nyzVNEKSYHEtxYF6xIEJ3tog6NC
         x+3tSYvFg5ruqbIvWfEqX4vbEfjLcnpETj+ZXuEPL3Ji4U3rhhy83QONS00MjrfB2zw5
         ZRu62NvUCT5+zjNpEiY9DPofADOzaes2gVrlmfDnut9lX+YDsFz13T2NTzAaXNIXw/lp
         q9nA==
X-Gm-Message-State: AOAM5312K4H56XiDieg2KVeHpK4WZjB9EHUW83vGODLUfQtgyL+DbBNg
        2AnUoKXoQYJpMzumVUjBMFTYSrX/cYsK
X-Google-Smtp-Source: ABdhPJyk7kyG5XfbtkPgOdJ0AeCQYpE4glctMhQhCgYJJZ+m4ppK4JofLOW6lS8DZM8lubXIaHFCwQ==
X-Received: by 2002:a05:6871:726:b0:dd:a581:998e with SMTP id f38-20020a056871072600b000dda581998emr3013731oap.128.1648140002008;
        Thu, 24 Mar 2022 09:40:02 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id m3-20020a4ae3c3000000b00320d7c78b01sm1445067oov.20.2022.03.24.09.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 09:40:01 -0700 (PDT)
Message-ID: <4897c433-92a5-3bfb-ba9f-44000748fcc5@github.com>
Date:   Thu, 24 Mar 2022 12:39:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] test-lib-functions: fix test_subcommand_inexact
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, chakrabortyabhradeep79@gmail.com
References: <pull.1185.git.1647894845421.gitgitgadget@gmail.com>
 <540936ba-7287-77fa-9cee-e257ed3c119d@github.com>
 <xmqqmthgu3e6.fsf@gitster.g>
 <e5331972-512a-c498-6a1b-927f21ef9de2@github.com>
 <YjuVAgjaiqrcT7P1@nand.local> <xmqqfsn8p8nr.fsf@gitster.g>
 <72c54461-8af7-29fc-04da-f435adee9bbe@github.com>
 <YjyWFqjkaGpC8NxQ@nand.local>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <YjyWFqjkaGpC8NxQ@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/24/2022 12:02 PM, Taylor Blau wrote:
> On Thu, Mar 24, 2022 at 11:42:44AM -0400, Derrick Stolee wrote:
>> As I'm looking at Taylor's test case example, the one thing I notice
>> is that there is only one pack-file before the repack. It would be
>> good to have a non-kept packfile get repacked in the process, not
>> just the loose objects added by the test_commit. I'll take a look at
>> what can be done here.
> 
> I think you are too good at nerd-sniping me ;-). Here's a more robust
> test, that I think reads a little cleaner than the previous round. Let
> me know what you think:

Finally, you found my most redeeming quality!

> +		test_commit kept &&
> +		git repack -ad &&
> +
> +		>$packdir/$(basename $packdir/pack-*.pack .pack).keep &&
> +
> +		test_commit unkept &&
> +		git repack -d &&
> +
> +		test_commit new &&
> +
> +		find $packdir -type f -name "pack-*.idx" | sort >before &&
> +		git repack --write-midx -a -b -d &&
> +		find $packdir -type f -name "pack-*.idx" | sort >after &&
> +
> +		git rev-list --objects --no-object-names kept.. >expect.raw &&
> +		sort expect.raw >expect &&

This is an interesting way to get this set of objects without storing
the original pack name. It might be good to keep consistent with the
way we get the new objects, though.

> +
> +		git show-index <$(comm -13 before after) >actual.raw &&
> +		cut -d" " -f2 actual.raw >actual &&
> +
> +		test_cmp expect actual
> +	)

I've got a modification of your original design prepared in my GGG PR
and will send a v2 including it after it passes all of the builds.

Thanks,
-Stolee
