Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955C3C76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 20:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjC1UfK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 16:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjC1UfI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 16:35:08 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312D5C9
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 13:35:08 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id cn12so9855559qtb.8
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 13:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1680035707;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rGrXMq/t7shr62pRyFVCIn4B9Ne0MrBbWg2dLoDdSNg=;
        b=H7ieSliF1xAlr1XhtzHdaUIrShwiL83CkLxXuFnlk3E2h8uWXXnT6eZpxQdvhJtLtM
         AltZI/KFLXHbRQznpp9bbi4YxfD4YxeMP4i9wacsApfi1oQvJwlJ7xyvFImDY/Y9nBDJ
         eNdOQ/nGDaW0nxdL5u7EgPllCQzhDSW+sgKJhRH0ZJ1I9LmKydWe3O6fYtz2Tr8CuFo4
         EvByq50DwUd5Xw4ZHtg0ba/ItTtUBfoKTaEAq+DbUcSJCQRtdzuiWzlt32zkiDfaj4OR
         UwX8xSzP4VMY2uC8IQb2EI+nsO8QJUD2sKRC9bJHvtBjRnsbR6/FSNgiyLczcNkWL+6l
         9WnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680035707;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rGrXMq/t7shr62pRyFVCIn4B9Ne0MrBbWg2dLoDdSNg=;
        b=xhgTVUI4FEKxj6w73aH7qaN3/V7j205rpbSKZz/bcZrV+8Kn0MGnb+BSayQhzr6JrF
         JliEpb0YBa0iyb42jk5bimeyIbqXeQ1o607AJbiJyfWQ5OEI65xYUftzFlR9iCcUPnF4
         ocDASzjwN+tREfgyiJtL38ECErMUFGSln+ePSn378vDDZvtPJNynCoSvm4LOYG0yq6Ke
         8xaxfY2nsaGF71TYUx/XWryBMbtdM/RAgTEkXejT2XikR+okur1IDx+Rc/p3xQ2xGqMY
         +5uRZ5/81aKDakK9zIOyynGEhukBttCikxFckjG3j1qMbIqoMZtPX4Ck/55+EhXlicdL
         c3Ug==
X-Gm-Message-State: AO0yUKWTL87+NoN1R1UWk0XX7fXpxsvmfXZSrzrw50TMbVERXAeqy8CU
        1OPo9yeoxNM+RStWS13YVxFMt5fNgTiLqd8dHQ==
X-Google-Smtp-Source: AK7set8Klf/bprXcuXFMLbg2dqztZKKTrmj4XQYAyMp2RsX/c/ipB6Ukdh9SJP0Ic7SBp7tfDU9ceQ==
X-Received: by 2002:ac8:5f0a:0:b0:3b9:bd05:bdf1 with SMTP id x10-20020ac85f0a000000b003b9bd05bdf1mr26864497qta.14.1680035707289;
        Tue, 28 Mar 2023 13:35:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:5188:124d:a12d:bff? ([2600:1700:e72:80a0:5188:124d:a12d:bff])
        by smtp.gmail.com with ESMTPSA id t9-20020ac86a09000000b003e393c9feb7sm4728998qtr.58.2023.03.28.13.35.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 13:35:07 -0700 (PDT)
Message-ID: <2c420712-148e-65a4-2aea-9cfdc920ce2f@github.com>
Date:   Tue, 28 Mar 2023 16:35:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH] describe: enable sparse index for describe
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Raghul Nanth A via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Raghul Nanth A <nanth.raghul@gmail.com>
References: <pull.1480.git.git.1679926829475.gitgitgadget@gmail.com>
 <xmqqjzz29hkw.fsf@gitster.g>
 <ff521177-b0ad-c567-c51a-a6c191584d7c@github.com>
 <xmqqo7oceiab.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqo7oceiab.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/28/23 4:24 PM, Junio C Hamano wrote:
> Derrick Stolee <derrickstolee@github.com> writes:
> 
>>>>  			setup_work_tree();
>>>> +			prepare_repo_settings(the_repository);
>>>> +			the_repository->settings.command_requires_full_index = 0;
>>>
>>> Offhand, the only case I know that "describe" even _needs_ a working
>>> tree or the index is when asked to do the "--dirty" thing.  To
>>> figure out if the working tree files are modified, the code calls
>>> into run_diff_index(), but has that codepath been made sparse-index
>>> aware already?
>>
>> It seems that this is a case where we can rely on the existing
>> changes around run_diff_index(), which is nice. We get a very
>> easy win for a narrow case.
> 
> Hmph, so "diff-index" is already sparse-index aware?  I looked for
> any old commit that flips .command_requires_full_index to false for
> the command and didn't find it, and if I recall correctly (I only
> checked when I wrote the comment you are responding to),
> cmd_diff_index() does not do that, either, so I assumed that nobody
> has converted run_diff_index() yet.  And that was where my question
> came from.

Since 'git diff --cached' is covered as of 51ba65b5c35 (diff:
enable and test the sparse index, 2021-12-06), that means that
the implementation run_diff_index() is covered.

In fact, it's likely that the reason it's covered is because
run_diff_index() calls diff_cache() which calls unpack_trees() and
unpack_trees() needs to work for _anything_ to work, especially
'git status' and 'git checkout'.

The only thing keeping us from enabling the sparse index on many
of these "diff" builtins is the necessary testing in t1092. I'm
sure that diff-index is very easy to convert. Hopefully, we will
have a GSoC student this summer who can tackle most of these easy
ones, as well as a tricky one or two.

Thanks,
-Stolee
