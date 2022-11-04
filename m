Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0280CC43217
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 11:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbiKDLrz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 07:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbiKDLrt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 07:47:49 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343D32CE18
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 04:47:49 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id x21so2886835qkj.0
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 04:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wmanCtdCfdBXULL+ulQKPKewkYYusIimhJ+Oc6D2is=;
        b=h0uNK5YISp0N4lh8VmZO8cTT1snA2ns2J92q+9S82wkCTba7NqYTvivQFcvEpd2qoR
         5w8nobBfQw6yYHERJlwJSup1ESCO+rfrBWz+yvw86ZlExg7Zr2REK7k1D6QAHK1sbNRg
         AAEZMevOnSfMY75u7JkSUY78VFYDH1ZJA01z+d78PUj9oe6iSMnwXbh2Gyk9u9cjbkZV
         P/XSXxxHQW2gEpfH7pFkyFSScZ3qnHwr3JpdMr3Ovxne+sNSV0BMEB2VOhUxDFDrFuSu
         uuePEx+CM5I3oBEEM3IQYQbpSGv7axgm+bFRFufMj1qBK+a7Jcl9OEY+xd9t/ak9rnVj
         NbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4wmanCtdCfdBXULL+ulQKPKewkYYusIimhJ+Oc6D2is=;
        b=trrcH8ipQdiPc7OceP+X5V0rwSkkWxYUVYvWqTECafCA3mPZ/uh5ro3bJ7oPM+vTCc
         /XDSDFcjf7dYtlrA7bv8RabvIlMUOIw7/VgnkzgzXd9kC5iGPPc0CaZytnnHd9hWrJai
         z5m7Hs/S79mqMVvE9Q04Hvu176MPJyTuuDxvaolI29uRLyCJWdPs7MEMi+T4gOlo+7fc
         I9L0GA7y1PbHFTNSnKoqCAey7kfySTFTO2+/fUEXVSyH+BA/BLsi5ohNzCttuHyL+2Fz
         1WJwLRLVZnqzvDCNGcryZKkVwHzggpSoMi62NDVQxLpSWDV+OfNScCq/eCIdgX++HTbZ
         95ig==
X-Gm-Message-State: ACrzQf2rlkAKylaohD9JYXG0W4mhGR5Vj901jILQcwgH+/uYpki8mx1M
        hGMiq5FIMQCGtJAp1IEcUtPO96KIbMc=
X-Google-Smtp-Source: AMsMyM7Vk4c6bKfRaqpoxP5CAhZvf7hmYVIzeKfNJ5wGroPQe102KpU2HV9MTontmFsuLycyQYDHsw==
X-Received: by 2002:a05:620a:2109:b0:6fa:75bb:c766 with SMTP id l9-20020a05620a210900b006fa75bbc766mr5463170qkl.369.1667562468106;
        Fri, 04 Nov 2022 04:47:48 -0700 (PDT)
Received: from ?IPV6:2605:2a00:9005:dead:a5ad:28f9:f53:90b4? ([2605:2a00:9005:dead:a5ad:28f9:f53:90b4])
        by smtp.gmail.com with ESMTPSA id j21-20020a05620a289500b006b949afa980sm2382993qkp.56.2022.11.04.04.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 04:47:47 -0700 (PDT)
Message-ID: <bc3aa4b1-4716-cf9c-5dff-22b25793f66c@gmail.com>
Date:   Fri, 4 Nov 2022 07:47:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
To:     "J. Paul Reed" <preed@sigkill.com>, git@vger.kernel.org
References: <Y2A1bdiw6kGC65f/@sigkill.com>
From:   Thomas Guyot <tguyot@gmail.com>
Subject: Re: Odd git-config behavior
In-Reply-To: <Y2A1bdiw6kGC65f/@sigkill.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul,

On 2022-10-31 16:51, J. Paul Reed wrote:
> So... my maintenance automation runs as root, and the repo directories are
> uid/gid'd someone else (though, the config file inside the [bare] repo
> happens to be owned by root)... so I suppose what I'm observing is expected
> behavior?

You definitively shouldn't run these checks as root. Git is a highly 
flexible/extensible product and god knows (and likely a few others in 
this ML too) what could happen while you run git commands as root on an 
"untrusted" user repository.

What prevents you from getting the owned uid or the repos and forking a 
process as that user to run the check?

> I guess this leaves me with two questions:
>
>      1. Why does "git config" refuse to run due to this security check, but
>         other git commands ("git fsck," at least) run?

Arguably a read-only config operation could likely be allowed, unless 
there is a possibility for some untrusted commands to be executed as 
part of this. I'm going to guess this was an easy entry point to cover 
dangerous commands, but having a finer-grained check would require 
making sure there's no dangerous code paths that could be exposed. The 
change was to address CVE-2022-24765 - commit 8959555cee7 - so there was 
likely time constraints to consider as well.

>      2. I think it might be useful to warn the user that the behavior they're
>         expecting isn't happening due to this security check, instead of just
>         outputting objectively wrong information (i.e. that no config options
>         exist when they actually do exist); I'd be curious what others think.

What was the return code for the git config command? If it was zero when 
it didn't parse/output the config option you asked for that is 
definitively a bug. If you failed to check the return code of git-config 
then you should fix your script/tool instead.

Regards,

--
Thomas
