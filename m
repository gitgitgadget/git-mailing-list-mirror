Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC34C43334
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 15:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiFWPGv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 11:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiFWPGu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 11:06:50 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79923120C
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 08:06:49 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1013ecaf7e0so26998191fac.13
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 08:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7v8MSUFYymEb33GLVlRqCFsN2mLq2BBBr10vITZe3wI=;
        b=SMqNSVDcv3mx3WbWfsCbrNUh9nBESiA2D6cRST/HL/YGOPBcSlOMGtMQXVKhJDjYXP
         rBL7vZSX45iDvQLwUGrFXnzEimLm5A0uOlYip7NB78gmYI8L6nl/tO91QPsIg09Es7B2
         6Micb+0QtekIXkxhzvNz3+WxyRv7OwD6cC8ZIKcRycXx511IITmXp87t4giNOqhR44gJ
         TumMJGuD4yDpsYyR6b67rRTbYMkx6LmdycXR9AJ3kyUzgULxyRg/XYPk/Cc15khjga2F
         CcZpzl7GURvQMNY8pWPomQM/YpetOj1qGq7GvwylSyLnYIBiLagEkQVVgPmmIp1G7VG2
         7BoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7v8MSUFYymEb33GLVlRqCFsN2mLq2BBBr10vITZe3wI=;
        b=IsYdN+dwwM8lwVgeTavoSH1Bu/F6yCMYSxY5ogQFldHsLGQwqzxi1kRWoYzXuWUwjJ
         ej34RhWJKqOerFYMaPMGBX5htmQpXtlv2C1QMkNclE69SiXcp+hOvNwdEGLT7slu4DhO
         6Hj+m0TJ/2aIOILXRH9qXz1R3kooHFTwh5o+wdhi//i6lnDRmr+Z1/QXt3jGEgrcaw1X
         dUrPVpnReiWucSd6GJN7EW//tcxUP2DNQ0oEDfROjxOAUCSEaRh5vZ6iX71AKawQ4M5j
         mAr8HnIMpSP0T4qBO4J5tSMxFdqGl8TEa2AFOtfR7lOmC29N+dlokFWlt02RWXxE+bFG
         evfg==
X-Gm-Message-State: AJIora9Zr5AquK+Q0leKr98kPZsl/s+3L2pMAqZdlbwuqSw78reDdi45
        XvNiCBF3ABW1UdpR32dpaeZd
X-Google-Smtp-Source: AGRyM1uGSGMob8PXPLwlROUDfI1CXl9H+Ogaq+gTVO9pB07EAiZUW/fELpw+fu9OgBKqZiiMvJOknA==
X-Received: by 2002:a05:6870:d392:b0:e2:aa54:9601 with SMTP id k18-20020a056870d39200b000e2aa549601mr2884605oag.184.1655996809295;
        Thu, 23 Jun 2022 08:06:49 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:7549:2a5a:7ed5:f864? ([2600:1700:e72:80a0:7549:2a5a:7ed5:f864])
        by smtp.gmail.com with ESMTPSA id b205-20020aca34d6000000b0032b1b84f4e3sm12985246oia.22.2022.06.23.08.06.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 08:06:49 -0700 (PDT)
Message-ID: <553ea547-9641-eb95-a474-db046fdc05dc@github.com>
Date:   Thu, 23 Jun 2022 11:06:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [WIP v3 0/7] mv: fix out-of-cone file/directory move logic
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220619032549.156335-1-shaoxuan.yuan02@gmail.com>
 <d3aa35e4-5bad-2bbb-2a25-d82064d6ec81@github.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <d3aa35e4-5bad-2bbb-2a25-d82064d6ec81@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/21/2022 7:30 PM, Victoria Dye wrote:
> Shaoxuan Yuan wrote:
>> But I think it worth discuss if we should implement in-cone to 
>> out-of-cone move, since it will be nice (naturally) to have it working.
>>
>> However, I noticed this from the mv man page:
>>
>> "In the second form, the last argument has to be an existing directory; 
>> the given sources will be moved into this directory."
>>
>> I think trying to move out-of-cone, the last argument has to be an non-existent
>> directory? I'm a bit confused: should we update some of mv basic logic to 
>> accomplish this?
>>
> 
> I suspect this requirement is related to the POSIX 'mv' [1] (and
> corresponding 'rename()', used in 'git mv'), which also requires that the
> destination directory exists. I personally don't think this requirement
> needs to apply to 'git mv' at all, but note that changing the behavior would
> require first creating the necessary directories before calling 'rename()'. 
> 
> As a more conservative solution, you could do the parent directory creation
> *only* in the case of moving to a sparse contents-only directory (using
> something like the 'check_dir_in_index()' function you introduced to
> identify).
> 
> I'm also interested in hearing what others have to say, especially regarding
> historical context/use cases of 'git mv'.
> 
> [1] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/mv.html

I wanted to reply here to maybe get more attention on this point.

My personal opinion is that `git mv` should move to the location requested,
even if it requires adding parent directories. Changing that behavior might
need to come as its own topic, before doing the in-cone-to-out-of-cone work.
Knowing if this behavior can change (or must stay the same) informs how that
sparse case will work.

Thanks,
-Stolee
