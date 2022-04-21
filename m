Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50F7C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 19:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392130AbiDUT6e (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 15:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392122AbiDUT6b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 15:58:31 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACE531DD9
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 12:55:40 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id b5so3758791ile.0
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 12:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=D0TOmEfwSrebLiGqcntHCde79jtzZFrqlyF4Ij35Lr4=;
        b=cwN4wlOLiGHqS1aewZuBuiaAE1S3xOCxWJbzP8JR+cUYLuLYrFHTIbRPLRrEYcS79W
         6nGGsVotbuHKkRr3bkC/cBoyuGUVPDJBI1NQS5htNhIDu0r86QAi+42gFDtktaRVqXQF
         gsRM9E8QTtCFcQWRbuN0nknslswASfEZR4SZWsAcllXKvT3Kdr0Ioeu5Gnwmx3DCcqKd
         E0Lw3mr31SWJN0jSqOKMLr2Y6Y13lSOSbLFUD/wJANC+ghkaM2frfq+mxmYPz4gOCQi7
         SynX9ME8YpAu9Nzpu885k7R4m+jYJfI9aEw7OtqdNVg3JP2Cww44w8kainEaruZ7pdYD
         kiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=D0TOmEfwSrebLiGqcntHCde79jtzZFrqlyF4Ij35Lr4=;
        b=oDZ8rL7MCGlo6NZBYCcuoXRvuGgA6jclkGrlInbl1Hn4xA5BlhFyxutLMU63C7PPA4
         AUnt4j/daZ1uqW4Rf/rlgHnGT9cX/ZxmmPIcGHHy9ZTe3MPeqfZHBN+GAHPFx7jyCGCh
         yTzABCLNQzXPQXtUbeCKqr/12JNwaqlEJ2r7BSmGtd5MRmFLpZdW4HUhv/JldzZtCgBv
         tveNu1L8WIQo4u3waLc/6O8f9nXKUecDp5gNI9AaLMqARoFGlKVh5SvRMQiucURwSjBz
         RGQzCAu2Utkd7QIVL2Lqr51pFTmMwuc95izvwD/wN+sK/VewXYol8uDMjWwuWAhu2pnf
         nUtw==
X-Gm-Message-State: AOAM533iXK/eoWg7M57M6IyvxopRL8hOQgtJKEsdQrdXaIsjszdITX8c
        7KNbQ6kRCaJjmrOoKNEyjE8n
X-Google-Smtp-Source: ABdhPJxjNDkToE2w1TEctRYygtagmLCaC91MZK0gYzsNS6hSsfbrV9s3cziL2r2VJSPSytAbTvIftw==
X-Received: by 2002:a05:6e02:1946:b0:2cd:5b9b:c679 with SMTP id x6-20020a056e02194600b002cd5b9bc679mr572513ilu.247.1650570939750;
        Thu, 21 Apr 2022 12:55:39 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id q3-20020a927503000000b002cc4ce08871sm4797010ilc.24.2022.04.21.12.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 12:55:39 -0700 (PDT)
Message-ID: <be6aed1c-6237-3090-983f-42ef7e043d72@github.com>
Date:   Thu, 21 Apr 2022 15:55:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] multi-pack-index: use --object-dir real path
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com
References: <pull.1221.git.1650553069.gitgitgadget@gmail.com>
 <0435406e2db6c5977928a2b0b0b79e66c0a078ee.1650553069.git.gitgitgadget@gmail.com>
 <936e7f12-362d-3303-ddf4-5b40f17a0b9e@github.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <936e7f12-362d-3303-ddf4-5b40f17a0b9e@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/21/2022 3:50 PM, Victoria Dye wrote:
> Derrick Stolee via GitGitGadget wrote:
>> +static void normalize_object_dir(void)
>> +{
>> +	if (!opts.object_dir)
>> +		opts.object_dir = get_object_directory();
>> +	else
>> +		opts.object_dir = real_pathdup(opts.object_dir, 1);
>> +}
>> +
> 
> Rather than copy the 'normalize_object_dir()' calls to every subcommand, you
> could "centralize" this by making the 'object_dir' option an 'OPT_CALLBACK'
> option, something like:
> 
> static struct option common_opts[] = {
> 	OPT_CALLBACK(0, "object-dir", &opts.object_dir, N_("file"),
> 		     N_("object directory containing set of packfile and pack-index pairs"),
> 		     normalize_object_dir),
> 	OPT_END(),
> };
> 
> It would require changing the function signature of 'normalize_object_dir'
> to match what's shown in 'Documentation/technical/api-parse-options.txt',
> and it potentially needs prefix handling similar to what's done in
> parse-options.c:get_value() (which internally calls 'fix_filename()' for
> filename opts), but I think it's probably worth reducing duplication here
> and avoiding the need to add 'normalize_object_dir()' to any new subcommand
> in the future.

Thanks! I agree that that would be a cleaner approach, especially if
a new subcommand is added in the future.

Thanks,
-Stolee
