Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60140C4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 08:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbiKVIIY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 03:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbiKVIIW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 03:08:22 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0096D1570B
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 00:08:20 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id q1so13402044pgl.11
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 00:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y467znR6fAOY61vfE8YkYjrIUE5P760sUNKwytZGCCM=;
        b=cl2YbwUSsmT0ZU1Vq/2LwSXO40EqRIZTazRgKr9iyjefIFzEXrJjSwHLOHnq2gwjuM
         OfxSkvf3Tpd9iTy8NT3eC5C4vrmyudUjjvw1zpXiT7n0pckDjJydzuu+5xADy2jTctqE
         MgLDYBrFBbBgOsaojw1CRossFs1sjaGZr0vHa8qy7+ZmSjHh+vefgOChUfc4FE+Y04ic
         tEl1bwT9Hc9HsXZV3LPLRmi09zwprwRu8oVC+2W2pN7MMEvNDbj/PumftyJAFQI/EuP+
         wW+w2QmitOuCFue5+6dE45X4qs9vMNcT+hCpqK0yIqtbJF3OyX5nvu1YRXU15Ql+B2HK
         S/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y467znR6fAOY61vfE8YkYjrIUE5P760sUNKwytZGCCM=;
        b=nOZ2ep25u8Nojk/scWbpe3EQevtcuetMon2MtVqeZicgdTPfVZdNTlCQoZkUIG8dSR
         jG1wKzqlkZkUNe3D7mrPSce/IgRMa6I6ru/Q5/Do2qpPOgINXmcJSxuHXKlXw9yI9UCr
         qUECPFOJmWk7FOMtkT6ZME+WLLru+hOaZ6eP1NB8B3zDH5s+B7deFDsCnNdrF5tFab1s
         T/mPChBVPguvWPRKTIhXysExRrgXjHMxOU23xMuaZOqHMgIQ8QrQPxNlAcNWpX/bigye
         EhwxXTMve2L3Yjf+Fl08V0tEwqIJTWnCdsi5DiQF8CXJa72a0SHiKIOWNBZz/oYGWvhm
         5Qww==
X-Gm-Message-State: ANoB5pnooBj1y3xIQvX45D6BfHWkH6pugY968M5lfmrRbagW0xhkMClJ
        98jY/MFvOFCCy5XNU+9XAtnyt5TY4KY=
X-Google-Smtp-Source: AA0mqf40fT6XNRGFq150mwuvCgrp+hGRSr7bPC45KeXyY6t+5hYF0wA1ZFhoitVvHBqAa04drPbpqA==
X-Received: by 2002:a62:6142:0:b0:56c:cde:1a49 with SMTP id v63-20020a626142000000b0056c0cde1a49mr3264160pfb.9.1669104500441;
        Tue, 22 Nov 2022 00:08:20 -0800 (PST)
Received: from [192.168.43.80] (subs03-180-214-233-4.three.co.id. [180.214.233.4])
        by smtp.gmail.com with ESMTPSA id 72-20020a62184b000000b0056bb0357f5bsm9936886pfy.192.2022.11.22.00.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 00:08:20 -0800 (PST)
Message-ID: <6c81f4b0-065f-01db-09ef-6ad9e3b0b39c@gmail.com>
Date:   Tue, 22 Nov 2022 15:08:17 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] builtin: submodule--helper: Add allocation check of
 module_cb structure objects may be helpful in case of allocation failure
Content-Language: en-US
To:     Li kunyu <kunyu@nfschina.com>, git@vger.kernel.org
References: <20221122031739.3440-1-kunyu@nfschina.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20221122031739.3440-1-kunyu@nfschina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/22/22 10:17, Li kunyu wrote:
> The purpose of using temp is unknown, but adding an allocation failure
> report should be helpful.
> 

Don't you understand the code?

> Signed-off-by: Li kunyu <kunyu@nfschina.com>
> ---
>  builtin/submodule--helper.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index b63f420ece..2e379623ea 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1077,6 +1077,9 @@ static void submodule_summary_callback(struct diff_queue_struct *q,
>  		if (!S_ISGITLINK(p->one->mode) && !S_ISGITLINK(p->two->mode))
>  			continue;
>  		temp = (struct module_cb*)malloc(sizeof(struct module_cb));
> +		if (!temp)
> +			 BUG("The module_cb structure object fails to be allocated and the program may terminate abnormally");
> +

Why do you check whenever allocating temp is successful?

-- 
An old man doll... just what I always wanted! - Clara

