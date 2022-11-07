Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D76C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 02:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiKGCv7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Nov 2022 21:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiKGCv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2022 21:51:58 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C54AA465
        for <git@vger.kernel.org>; Sun,  6 Nov 2022 18:51:57 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id k4so6500049qkj.8
        for <git@vger.kernel.org>; Sun, 06 Nov 2022 18:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wTjIjEMRKVCApZwb6RCGGEcWRAzAvyxRIniDrkIJ0j8=;
        b=jbYojb15rmYCgxfMzsZBC9QjnU1FxiGOfqI46gVxtDrRgtqkWhNdxC0BsBNktTHUNh
         Lyn7sKnpsoPsZGumDz0sDQcpXagSlfCUllSyi8rkD6WJ7vmjAo8y2G+8CLD1Z/zEE/kO
         F6p1DCS6xV8eBYpYxw4Siecep1Uf0GEQLDq7+3ey3h16n1uWnPFg7PhJ8qJoR3yS36uc
         oRnFGwef0smNbFL/mpNl2SOqCECrfJ9UftumTd9cVlguIBdoE609OA2HDemdsWnHkxGZ
         vffY7sjqZcjz+mg/BJm/1J7M3Mu41gzy2tCpKIIJElPuG+jk56kGpuyw/ZT3gKkOEp90
         XzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wTjIjEMRKVCApZwb6RCGGEcWRAzAvyxRIniDrkIJ0j8=;
        b=3RkHsuotHaHM9r3oR9Y3DUHms3hG3wg8pOP/vqGHqdD273CDqdE8ooE6fQhyn+7sdY
         ZJbBpsGpXXYIm0DEqUnY0W4NEfkHcmATsaN9AL4B4U0TAB9eH+qjkVtw323TGoGrGQLS
         GL9ut6ZVUMdVib8bIsVeRjjK91pVx2yLf4uei968JKF5nBqqcktck8RDUXVzFGgisdRi
         +yiqq0g7IuqLYBT/TMJDiIcV1vteSySUP9kCYX5NP2YaEAveTl/ceI9mocBK9xqSF4M5
         mSfcWr8J6qiQWnIe74Seqthke8gGcTbIErbPSLs9me2j1OD6DNq6UyF8KLDo92U6jVyT
         De2A==
X-Gm-Message-State: ACrzQf22jzJv93UjDY8VYYfhoPw8JamrJ9EW1Pl4CyO9ZUn/DhelVl+l
        VXRhjuVNKTASkz4I/dax9uD3yY05Ozss
X-Google-Smtp-Source: AMsMyM76+Xuu1TKzhj2iHPU6z7P7eZ0MmhYjVTkVKobxzvvJ5D8/y7dDQTI0Rbz5UcqkcAyGgGSBgA==
X-Received: by 2002:a05:620a:1214:b0:6fa:4af5:7003 with SMTP id u20-20020a05620a121400b006fa4af57003mr22369868qkj.84.1667789516566;
        Sun, 06 Nov 2022 18:51:56 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d948:f30c:63de:b667? ([2600:1700:e72:80a0:d948:f30c:63de:b667])
        by smtp.gmail.com with ESMTPSA id s15-20020a05620a29cf00b006fa1dc83a36sm5969929qkp.64.2022.11.06.18.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 18:51:56 -0800 (PST)
Message-ID: <42804b53-7035-1ba0-3076-2207e63681b7@github.com>
Date:   Sun, 6 Nov 2022 21:51:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: Git Bug Report: 'scalar register' command failed at Mac m1
Content-Language: en-US
To:     Albert Lv <albert.lv-us-icloud@outlook.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <PSBPR01MB3541FDC2CB117051A01A9418FA3D9@PSBPR01MB3541.apcprd01.prod.exchangelabs.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <PSBPR01MB3541FDC2CB117051A01A9418FA3D9@PSBPR01MB3541.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/6/22 8:56 AM, Albert Lv wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> 1. First I run 'scalar register' to register current git repo'.
> 2. Because previous command report 'Permission denied', so I run 'sudo scalar register'.
> 
> What did you expect to happen? (Expected behavior)
> Scalar successfully registered
> 
> What happened instead? (Actual behavior)
> Command report:
> fatal: failed to bootstrap service /Users/albert/Library/LaunchAgents/org.git-scm.git.hourly.plist
> error: could not turn on maintenance

Thanks for the report, Albert!

I suspect that you get the same problem with
"git maintenance start" which is the underlying
command that "scalar register" is running at this
point of failure.

The "~/Library/LaunchAgents/" should be owned by
your user, allowing this to work without needing
to "sudo". However, if your permissions on that
directory have changed, then the "sudo" will be
necessary. Could you double-check your permissions
by running "ls -al ~/Library"?

Thanks,
-Stolee
