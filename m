Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C9AC433EF
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 13:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbiGVNUl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 09:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbiGVNUc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 09:20:32 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A303186E6
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 06:20:31 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-10d867a8358so6257255fac.10
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 06:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Fv3oVVEM4SCHXrKj6+Z+WqnOLimdVptVnKh+QjUCQJg=;
        b=NQBJUy0E9fd5Dy/O4K+flDRPUWydVLx63a1F9GYexZhPvCx8hOSGiOX5oPTP7dzX3I
         3joqEba0j7zmxir4YB0e7OBg5y9dXOO4cBkzO54m0SlRIwtpNg0PTQ1ND6mnwSBVPY2f
         XeQ7ChlLZCVQKMIjA+6WAZL4Mo8C9kLkk9/gD6IPmoC8XIYOuOzXF4hwmpmW2whELbOm
         Spe/4TjDD08cdBmWWOh4n5yASL3MOoCBhRsWYsttdwduDyptseRssCPqigGHXzsIO5Lb
         2Rul0ZN9GC3nncCfY76ZxjCd/LZj+kJmndM89fcmTWmTJFYLxDg5xmmnSepGjVOITaRe
         iQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Fv3oVVEM4SCHXrKj6+Z+WqnOLimdVptVnKh+QjUCQJg=;
        b=lWGGBqtKqa997Ji0mJqQimmpGfXmW5z72SPYq6VuAZ2VARneEgL2rSGPdEnRqav4c2
         ZSux0Bk1gxwpLll8Lni+PuJrtfCh0z0w+grWtVFoxD2FebbKfQfB6pe7Exx87nEgT9Ub
         dNke+HLll7t02EzC00O371Lmt/CEz6+u2FwmXMWEm4SWVuGjWtpH2igWeCIqRKZBcU9p
         bRuU51Jsbyff2mUyCdc1Mnv9IqmSZ7M7MTShpf423Sv8vgizP+Z5ulEfAV8+cr0k8Q2L
         uRQDt0nl40C4zS2vIDwbqRua21fwobeNiwor6cG/hu8k39KAV1AtJiNbRlGsbRjRT78N
         fquA==
X-Gm-Message-State: AJIora9mtWVVRy3UPGBuhDhKD1CCOjeLS+16kXXZ47XqAaUYm0mVgwRK
        LS3h/MuG9aXibTidcpAkD5r8
X-Google-Smtp-Source: AGRyM1vtD7ZndMFtGHZc7wH1ymcDINElXgJawSgPo1MoBdRZL0MsunLVSACC2UB2QSELtetCqFkyqA==
X-Received: by 2002:a05:6870:818f:b0:10d:8870:6906 with SMTP id k15-20020a056870818f00b0010d88706906mr6209893oae.35.1658496030642;
        Fri, 22 Jul 2022 06:20:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:89e1:7440:c819:d192? ([2600:1700:e72:80a0:89e1:7440:c819:d192])
        by smtp.gmail.com with ESMTPSA id q8-20020a4ae648000000b0043540f7701esm1831236oot.31.2022.07.22.06.20.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 06:20:30 -0700 (PDT)
Message-ID: <c34e7106-4409-27db-80b4-44219f5b1518@github.com>
Date:   Fri, 22 Jul 2022 09:20:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 6/6] fetch: add 'refs/bundle/' to log.excludeDecoration
Content-Language: en-US
To:     Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, dyroneteng@gmail.com,
        Johannes.Schindelin@gmx.de
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
 <pull.1248.v2.git.1656535245.gitgitgadget@gmail.com>
 <a217e9a0640b45d21ef971d6e91cee3f1993f383.1656535245.git.gitgitgadget@gmail.com>
 <YtnJd+jxDXW4L10R@google.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <YtnJd+jxDXW4L10R@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/21/2022 5:47 PM, Josh Steadmon wrote:
> On 2022.06.29 20:40, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> When fetching from a bundle URI, the branches of that bundle are stored
>> in a different ref namespace: refs/bundles/. This namespace is intended
>> to assist with later 'git fetch' negotiations with a Git server,
>> allowing the client to advertise which data it already has from a bundle
>> URI.
>>
>> These references can be confusing for a user when they appear as a
>> decoration in 'git log' output. Add "refs/bundles/" to the multi-valued
>> log.excludeDecoration config value. This is similar to the way
>> "refs/prefetch/" is hidden by background prefetch operations in 'git
>> maintenance' as added by 96eaffebb (maintenance: set
>> log.excludeDecoration durin prefetch, 2021-01-19).

>> +	git_config_set_multivar_gently("log.excludedecoration",
>> +					"refs/bundle/",
>> +					"refs/bundle/",
>> +					CONFIG_FLAGS_FIXED_VALUE |
>> +					CONFIG_FLAGS_MULTI_REPLACE);
>> +
> 
> I dislike the idea of modifying the user's config as a side effect here.
> Since it's a cosmetic issue, can we drop this patch and figure out
> better default values for log.excludedecoration?

You're right.

log.excludeDecoration was initially created precisely for enabling it
within the prefetch maintenance task, but it would be better to change
which decoration set is shown by default. I'll pull this patch out of
this series and bring out another one that rethinks this entire space.

Thanks,
-Stolee
