Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB10C00140
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 19:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbiHLTha (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 15:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiHLTh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 15:37:27 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52CCADCEF
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 12:37:25 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id g14so968133ile.11
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 12:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=zacGa8/23vxGXg0MWnOG0hySCZjm5Dc9WoWzT/hWCQk=;
        b=iU+fX3ZhIxvoLBwktam25iitj/GkXuab0qVWJAwg8wuoM0YhP4fguptiMS5Ne6MgI6
         yG4LAT3GqreSyuXBTuJPggwz9inpqouoSZuO7WJtxN8blgCiFj4Tl79CvrrxZEWI1IB+
         VHFz0lEG7XFhJPUhpM3gQRu7XrUL5zVtfe2ar89ukYxSNFcf20768YlZQ2er3u+DQQ87
         EyvTPYV3D4Jdq5NsHsFwmW2tKC4J3doxgOaZAOc5Y0jEwSay9YYqgY5qdlzSrTsUv6L6
         pJ7hQ6sWwD2RLBbzJpJRGep59Wb9hsIv7t08AugTTfO6St2PxTlhFgdovDFvK4l9ixK6
         PNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=zacGa8/23vxGXg0MWnOG0hySCZjm5Dc9WoWzT/hWCQk=;
        b=DIyN8KhapXytnIKEE8WouqjTizf/ZmyRWqGAJl56VaXdOfLNfE69mrFraf4spfCWUk
         ryritRfkWDYzlImbCclDu0EtdWGSfCExgyAVr7F4v+c4UGlmSrJD50ZcHqsquG4AKrFh
         Fu4b740OrweqFu07isDAzhCPtGJiNrDdfEL3y3rZLnWhEIMZZgqRE39+kZ3NvFY7jvrH
         NE+apop+CeL3Q10G1BgRLkW9sjQISLn7zzhD3Wmd9vCPCeMukjmaU9hcY5IR42iJZixS
         ATRTPd0/xw4RTvnBcunEnVXA+Zb1dW4xNxWsqF1IZjXEXQz/B7BAWgZupRMe0o8T6Spj
         tdmA==
X-Gm-Message-State: ACgBeo3rdxBk6stb2lEhil2aT6jMvxuFVbqY1MWD1ljtXU9JmcvLm9hm
        sY0aXyaB043neZbvpZLuk7d1
X-Google-Smtp-Source: AA6agR6Db+UDA9YBYDPeAu23PawA6grYCWTDQpkwe5gmXIeX/xb/ys8xfGjN4zHvVwDfGSwh0mVyxQ==
X-Received: by 2002:a05:6e02:12c9:b0:2df:1c38:94c3 with SMTP id i9-20020a056e0212c900b002df1c3894c3mr2436087ilm.62.1660333045249;
        Fri, 12 Aug 2022 12:37:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:f58c:d8c5:7c0e:77b6? ([2600:1700:e72:80a0:f58c:d8c5:7c0e:77b6])
        by smtp.gmail.com with ESMTPSA id u7-20020a056e02110700b002dcafb975c6sm1104725ilk.82.2022.08.12.12.37.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 12:37:25 -0700 (PDT)
Message-ID: <d4b78b33-5b27-b536-1534-6a5201d392f0@github.com>
Date:   Fri, 12 Aug 2022 15:37:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 06/10] log: add default decoration filter
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com, steadmon@google.com
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
 <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
 <bec532fb8c63b3ae784d442f438687a4f0bbad37.1659122979.git.gitgitgadget@gmail.com>
 <220804.86iln8e9hl.gmgdl@evledraar.gmail.com>
 <ac7b3a81-7ca6-05d3-6633-4204066aa933@github.com>
 <220805.86zggirb7b.gmgdl@evledraar.gmail.com>
 <2184ffe4-4fde-878f-052f-e7dcdebe8161@github.com>
 <220811.86k07eplty.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220811.86k07eplty.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/11/2022 3:30 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Aug 05 2022, Derrick Stolee wrote:
> 
>> On 8/5/2022 10:50 AM, Ævar Arnfjörð Bjarmason wrote:
>>>
>>> On Fri, Aug 05 2022, Derrick Stolee wrote:
>>
>>>> Now that this version removed the notes ref from the
>>>> decoration, the stance for inclusion is simple:
>>>>
>>>>   If Git offers to color the namespace with color.decoration.<slot>,
>>>>   then Git decorates with that namespace by default.
>>>
>>> I'm a bit confused, sorry.
>>>
>>> So aside from "notes", if we have a color.decoration.<slot> applying to
>>> a ref now, it's a bug in your series if it's not showing up anymore?
>>
>> The possible slots are:
>>
>>  * branch (refs/heads/)
>>  * remoteBranch (refs/remotes/)
>>  * tag (refs/tags/)
>>  * stash (refs/stash)
>>  * HEAD (HEAD)
>>  * grafted (refs/replace/ or GIT_REPLACE_REF_BASE)
>>
>> These are exactly the namespaces that are now shown by default in
>> this series.
> 
> No, e.g. "tag" doesn't mean "refs/tags/*", it means *a tag object*.

You are half right. It means "refs/tags/*" _or_ "a tag object". A
lightweight tag is still counted based only on its ref namespace.

> Try
> this on master:
> 
> 	git update-ref refs/archived-tags/v2.36.0 refs/tags/v2.36.0
> 
> Then on master:
> 
> 	./git -P -c color.decorate.tag="bold blue" log --oneline -1 v2.36.0
> 	6cd33dceed6 (tag: v2.36.0, gitster/yw/cmake-use-pcre2, gitgitgadget/yw/cmake-use-pcre2, tag: refs/archived-tags/v2.36.0) Git 2.36
> 
> But on "seen" currently:
> 
> 	$ ./git -P -c color.decorate.tag="bold blue" log --oneline -1 v2.36.0
> 	6cd33dceed6 (tag: v2.36.0, gitster/yw/cmake-use-pcre2, gitgitgadget/yw/cmake-use-pcre2) Git 2.36

You initially made me think there was a bug that was not covered
by our existing test infrastructure. We may still be missing a
test about this "annotated tag outside of refs/tags/*" behavior,
but it is not broken with this series.

The change of behavior here is that refs/archived-tags is excluded
from the list of decorations. If you applied --clear-decorations to
your log command, then it would appear. It would also receive the
bold blue coloring (and the "tag:" prefix) since it points to an
annotated tag object.

I also tested non-annotated tags in the refs/tags/* space and the
coloring continues to work correctly before and after this change.

Thanks,
-Stolee
