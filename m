Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9270EC43217
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 15:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345633AbiDAP4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 11:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354913AbiDAPMl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 11:12:41 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC3D2B19C2
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 07:56:00 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id g21so3385894iom.13
        for <git@vger.kernel.org>; Fri, 01 Apr 2022 07:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=r4zSPoGvKI7lVGPe239FByPlrEaH47ZhnOPGh8MUzmQ=;
        b=ZBPM4oiny8+iGQ7VoCa8WO4AxsCbaBpuPl4zR6HEDRP/ppExGymMQ3d4vfkXJ9l/zW
         TFBqyVO7HU29PrDC2ztOrRVwGFZ6PzOZusN/ozLp4PmWrrF3XBkRpCca4d3i7Vm4jCs3
         5SbXVzrT8jj+DUr+q2osPhDQxTkb61vrwa+t18FTX3iyhGdsSTQIkt1gILQfxlyWmF0e
         5ruTazeYJwGjeJMQf8HaKjT7F4w4MuThE4ygZolyRt0JRokHn1lPfA96pNmrktVvdBiA
         GGawqOssoQFdcVFJbVDHAJBhN2wVNT5/CChNGQyX8y60eBFspdpZziFmueX80HQt0DkJ
         +kWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r4zSPoGvKI7lVGPe239FByPlrEaH47ZhnOPGh8MUzmQ=;
        b=dREHYcNiPBxNyd56GLT/fIxMS6xz+xbwH3EePI9WVUR1otvibBQcn/eUu5T2gvvzyF
         QEKRDP3ObDsqLSAvNaP0E3V/Sf2i0hK6Civdo4jBAIXLU5K+/nAz2OupKlTLI/WTYpZ4
         QBU+zDLP1Pob3o+CfflfEQ1r/Q6GRO37D/cwNNR/HMfJT2VYQ6Fh+3D51CckO9pajVjN
         hvw44UeQrZ+6NWQauankJIGCFfFwkNIlz3Eqwq6jAo3Ni4S78hMcNpG+yB6+B+aZGMJe
         rCeLQ53bMWbyM33MNfkpK5OCMFEmcIA1M6T0VTyhLOIpYBIuDMXGKmSLDxpM3ppRT3HP
         ibzw==
X-Gm-Message-State: AOAM532sXWOEdTscgm/6qj3uvX8LunuwPm9N4OY3RvW7/aO6yPUJ/JaX
        P0P80f7IzKZ5b/4Ot3QS5hWQAVNt3Emi
X-Google-Smtp-Source: ABdhPJwGDq3h4Got9DH1NtnmdCtWjfhw2DH7D8YoR28BllCsw2HdiOaBzzlr/ZoMSrdJmC6ujuzyZQ==
X-Received: by 2002:a05:6638:16d2:b0:323:7285:474b with SMTP id g18-20020a05663816d200b003237285474bmr6060682jat.61.1648824959465;
        Fri, 01 Apr 2022 07:55:59 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id l14-20020a05660227ce00b00645ebb013c1sm1752819ios.45.2022.04.01.07.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 07:55:59 -0700 (PDT)
Message-ID: <c97cfe34-50d3-f7dd-bfc3-428d4518f308@github.com>
Date:   Fri, 1 Apr 2022 10:55:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [WIP v1 3/4] mv: add advise_to_reapply hint for moving file into
 cone
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     vdye@github.com, gitster@pobox.com
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220331091755.385961-4-shaoxuan.yuan02@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220331091755.385961-4-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/31/2022 5:17 AM, Shaoxuan Yuan wrote:
> Originally, the SKIP_WORKTREE bit is not removed when moving an out-of-cone
> file into sparse cone, thus the moved file does not show up in the working tree.
> Hint the user to use "git sparse-checkout reapply" to reapply the sparsity rules
> to the working tree, by which the SKIP_WORKTREE bit is removed.
> 
> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
> ---
> I offered this solution becasue I'm not sure how to turn a cache_entry's 
> ce_flags back to a non-sparse state. I tried directly set it to 0 like this:
> 
> 	ce->ce_flags = 0;
> 
> But the behavior after this seems undefined. The file still won't show up
> in the working tree.
> 
> And I found that "git sparse-checkout reapply" seems to be a nice fit for the
> job. But I guess if there is a way (there must be but I don't know) to do it
> direcly in the code, that could also be nice.

I point out lower down the API that the 'reapply' command uses to gain
this functionality.

>  	if (gitmodules_modified)
> @@ -392,6 +398,9 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
>  		die(_("Unable to write new index file"));
>  
> +	if (advise_to_reapply)
> +		printf(_("Please use \"git sparse-checkout reapply\" to reapply the sparsity.\n"));
> +

I think we can skip the advice here and instead run update_sparsity()
from unpack-trees.c (see update_working_directory() in builtin/sparse-checkout.c
for an example using it). Something along those lines would double-check the
new cache entries against the sparse-checkout patterns and update the worktree
to match expectation.

I originally thought we wouldn't want to run update_sparsity() unless we
interacted with a cache entry with SKIP_WORKTREE, but this could be important
for moving things from inside the cone to outside. In addition, in non-cone
mode there is no way to predict how the new cache entry could match the
patterns once its name changes.

Hopefully this gives you something to try, especially because it should be
simple to check that a file exists or not after the 'git mv' call, making
testing relatively easy.

Thanks,
-Stolee
