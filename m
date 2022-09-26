Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD28C07E9D
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 14:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbiIZOyL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 10:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235431AbiIZOxp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 10:53:45 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71C95A179
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 06:20:00 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id h194so5173410iof.4
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 06:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=bLgtQzhEx5OdQWPenSWumqzcRC4YmtumdKYSQucupQY=;
        b=ApNg37ULlYc3k1m8I233MQnhda1dmH6tZqezhEf1JtjFUWIp7cbgWoA0rCK4GH7ZUj
         dEQwoZfyo/aX7PXod0VEDHzknnSKx55nWz5ibrjPt0v2yO8p9PQDke7mlRCLFuaQ9wHz
         rtQ4jrgRrzYLTqDCfCW+qycjNAnQHBw/8KFiuVzbgfijxNg7mu9tUkCY2BxzXHMvtnkH
         55Hkr91klPpt/I1UueaxFroFbcYeUjtpzEC7ajEGNvd94JCh6Dej1eGN3nkNZ60OIbPM
         QgK8bhCDOwsE2p07GOoDeQVq6CtDPxJw0XOA7cdGruswCJz6WfqcA6iYqJ4qbH0ztKpu
         Eg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=bLgtQzhEx5OdQWPenSWumqzcRC4YmtumdKYSQucupQY=;
        b=Iftn6oOM4p4ZuY1zXDLS2pBkPoRBSSh4Cb7ttq+6Ab4w1L6M7u0zV/2xGIaCIFcWJ3
         kjGXx/MxiXzouxz65vTF/SaWDDqEBR2RIAqaMLDevzj6aNI3J4Wo14Oq7akVTxH0Cfgy
         i+NJ3wvwKfI46GEQcR5rNC9uTGFxkUjb23fnOaCMcCiCmo6vZJNX1OQLAFHNNjHSZ01/
         Lz3X27mowvzcfjLc7MTaqE86SFBNIdQ440028a0dMor9n+mLG3pISALyyO4tGI9LhHZj
         ZDTuAelcZbOs33fy+q0WyqMQzZ2RL1z33cwAtXPoGtRpvx0FcSItRXHqO2BgOXeT/ekR
         Ad/g==
X-Gm-Message-State: ACrzQf0oXZvm0vhu6RGTcuSianFkMSBFPqvrZQOxOSBRuiHbDERqbI3b
        1Xhv4O+dgoPJT+BmkoY7J0rb
X-Google-Smtp-Source: AMsMyM62IVSRMNymI6tChlVOwi5feRsp15f3VhkMrpJ4DwnxWBkgB0q73+5quKRwApfcQCQ4EWcXvg==
X-Received: by 2002:a05:6638:2584:b0:349:edd4:4fed with SMTP id s4-20020a056638258400b00349edd44fedmr11355248jat.26.1664198400105;
        Mon, 26 Sep 2022 06:20:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:6c7d:bb49:cfa:a946? ([2600:1700:e72:80a0:6c7d:bb49:cfa:a946])
        by smtp.gmail.com with ESMTPSA id e27-20020a02211b000000b00349e0800e49sm6964051jaa.156.2022.09.26.06.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 06:19:59 -0700 (PDT)
Message-ID: <f61e5940-41d0-39dd-39fa-048acccfe221@github.com>
Date:   Mon, 26 Sep 2022 09:19:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 0/9] Bundle URIs III: Parse and download from bundle
 lists
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Teng Long <dyroneteng@gmail.com>
References: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
 <pull.1333.v2.git.1662734015.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1333.v2.git.1662734015.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/9/2022 10:33 AM, Derrick Stolee via GitGitGadget wrote:

> Updates in v2
> =============
> 
> Thank you to all of the voices who chimed in on the previous version. I'm
> sorry it took so long for me to get a new version.
> 
>  * I've done a rather thorough overhaul to minimize how often later patches
>    rewrite portions of earlier patches.
> 
>  * We no longer use a strbuf in struct remote_bundle_info. Instead, use a
>    'char *' and only in the patch where it is first used.
> 
>  * The config documentation is more clearly indicating that the bundle.*
>    section has no effect in the repository config (at the moment, which will
>    change in the next series).
> 
>  * The bundle.version value is now parsed using git_parse_int().
> 
>  * The config key is now parsed using parse_config_key().
> 
>  * Commit messages clarify more about the context of the change in the
>    bigger picture of the bundle URI effort.
> 
>  * Some printf()s are correctly changed to fprintf()s.
> 
>  * The test helper CLI is unified across the two modes. They both take a
>    filename now.
> 
>  * The count of downloaded bundles is now only updated after a successful
>    download, allowing the "any" mode to keep trying after a failure.

If some of the reviewers from v1 could check that I responded to their
comments, then that would be a big help to getting this series moving
again.

Thanks,
-Stolee
