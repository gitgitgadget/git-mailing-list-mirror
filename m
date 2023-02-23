Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62E8C636D6
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 15:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbjBWP0T (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 10:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBWP0S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 10:26:18 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870B257D11
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 07:26:17 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id ff4so11374472qvb.2
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 07:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ooSjVj4Ymure1INHdNTVwNnc+sXp/L2Xu78nANBvnRc=;
        b=jToyR1zPMhlRS0ZIavbkWt7+iQsx3z5C/ddpaiedmvhnOmKZYxSnWqVJV2ODQMoHk6
         PZvsRnoZsZ9XpcBzMBZkCooo2foSYA1W9dkfPQkFPLdyenUm4v7ZPOvxSvv7HGSLbYSt
         DDvT9bk/mc9+Lk43CUNL6KO7YLtJ/2m98yea9BmNH7gq4T4CoQHhNjCBBLbWtm19S3ab
         XWydctIy/f93xf267sgEJSLzPmC/Sj7mH3N+CnCpCmRJs43Xl0496KbXf2lRutyswY7N
         agre/+TqEM5aYU4ZWSjNbefZwuf+AwCVa/vwljXCTPbZItQ6w5Dq+RAnxL9IWYmM1XM+
         AlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ooSjVj4Ymure1INHdNTVwNnc+sXp/L2Xu78nANBvnRc=;
        b=idBDZ5wzm+ELCx9/seTr94arnhKE3OaoyoGviot4zUzWm1gNfkB/eYY8d2p/J64rpX
         4oKDcVzM4cc9/cx/N8Tp4xFFruKpmdsyfPMumbTNLRo9S7ViFZ0O/jeWpZw4V+jFVDcm
         L7n0ar1CUiuaf0BOcWMHYTbDxndoGwnd9w+R2ayilLU00wrF6ZekjJLCrXPJQiExMD7E
         qi8RAe4i1PCFBB4P67cDrss3a6p1vn3jIge2osp7594W/jD75N/Tf7o78Kd5pnETBJgz
         tbpaSUI6CQWrFXQx6qVfIlYuTsAxMaVfHLN8iaV0krU0c9z1gbdDuruCX5XVwwnE0D+n
         /evQ==
X-Gm-Message-State: AO0yUKUEx/2oS95U7/if+KvW038hxaKfCtycjEy5mGLyeP2uZnsR31Mh
        QTkRONni2gpDidn1HSZB5IRA
X-Google-Smtp-Source: AK7set9yeIUPvUP7kHPSMhuHDND5SyNyGyiaJYruQTNAY2uWD+iwmxx2o7nxh+jOeTgt+/rdbCLaFg==
X-Received: by 2002:a05:6214:ccb:b0:570:bf43:475 with SMTP id 11-20020a0562140ccb00b00570bf430475mr19996519qvx.22.1677165976607;
        Thu, 23 Feb 2023 07:26:16 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:e099:82d3:1307:6825? ([2600:1700:e72:80a0:e099:82d3:1307:6825])
        by smtp.gmail.com with ESMTPSA id e8-20020a05620a014800b0073b399700adsm6391290qkn.3.2023.02.23.07.26.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 07:26:16 -0800 (PST)
Message-ID: <73d694c5-f2d9-c05b-c880-8d5650f36797@github.com>
Date:   Thu, 23 Feb 2023 10:26:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 00/11] Clarify API for dir.[ch] and unpack-trees.[ch] --
 mark relevant fields as internal
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
 <16ff5069-0408-21cd-995c-8b47afb9810d@github.com>
In-Reply-To: <16ff5069-0408-21cd-995c-8b47afb9810d@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/23/2023 10:18 AM, Derrick Stolee wrote:
> On 2/23/2023 4:14 AM, Elijah Newren via GitGitGadget wrote:
>> This patch is primarily about moving internal-only fields within these two
>> structs into an embedded internal struct. Patch breakdown:
>>
>>  * Patches 1-3: Restructuring dir_struct
>>    * Patch 1: Splitting off internal-use-only fields
>>    * Patch 2: Add important usage note to avoid accidentally using
>>      deprecated API
>>    * Patch 3: Mark output-only fields as such
>>  * Patches 4-11: Restructuring unpack_trees_options
>>    * Patches 4-6: Preparatory cleanup
>>    * Patches 7-10: Splitting off internal-use-only fields
>>    * Patch 11: Mark output-only field as such
...
> The best news is that your existing series makes it easier to flip
> to the internal pointer method in the future, since we can shift
> the 'd->internal.member" uses into "d->internal->member" in a
> mechanical way. Thus, the change you are proposing does not lock us
> into this approach if we change our minds later.

And now that I've read the series in its entirety, I think it is
well organized and does not need any updates. It creates a better
situation than what we already have, and any changes to split the
internal structs to be anonymous to callers can be done as a
follow-up.

Thanks,
-Stolee
