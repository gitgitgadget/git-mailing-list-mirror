Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2439C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 12:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9F3160720
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 12:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241563AbhHEM6f (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 08:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241538AbhHEM6d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 08:58:33 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7D2C061765
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 05:58:19 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l4-20020a05600c1d04b02902506f89ad2dso5472048wms.1
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 05:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=tIv7pQkxmTdpomwc9oFgttsVG3VgIwpvPeFXJCkfUd4=;
        b=OKElkIssSKOq8EFLTERA7o6q4Z9wl/TpSaojax9WCnTf1lIxeSwM0K6LC091kYiwVg
         Bi+xEbFE4yHABrQrrfqCdzKFV+o6IRI045ouoKgDOUkwonU6t6Be7lqe0vR9kCmOkySI
         llCthE3guTiL+gF3A1XITM1OlcFW/VRpvFsdpR3JsW/7HFinJrUPohQ6VlgVXmgBaAgE
         n09eLcLVGxnB9nfVlnwgGr4rvj6wQ3uE2wT2/t7Cj121mhbYrvs3i4GS59n756QkOldp
         lq/zATeAg4j1+aka5SAJmJYLi1w+LSAUzKDZPirfy57c9FG4M2QMbreOn6jiNU9xXDS1
         ozoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tIv7pQkxmTdpomwc9oFgttsVG3VgIwpvPeFXJCkfUd4=;
        b=qfGuM7QLHCQvBdv4R97ERYpG2+pdy9qfwVJDIOYFr4TVDVOEHHp03GfplZyocAiTOq
         2anO5EeQ93ugMcePDV+ulUZ3PGsSMlOx+1mfZUR8kMpxa1bnY21B83K3Lhun6fwhscZU
         qzjRbYas04LWZzMaAXuJ1Y+1x1PTcJjt+2wm6QqFIwj32ydXr7hNBwCgck84Bi+0tvmB
         CEHbT+VhA1ZAPjbXCOg8FsqhhcDXGWYi0UmDVOKeHAi+KthWAgLymUEyISt/IfeJ2FbA
         9mlof/uubkBAur0hzYi0rSva4duoFuFfeUI82sP/cb9hQIoJgwY1azu0U+EMqMjGBRwt
         DPJg==
X-Gm-Message-State: AOAM533+kVw8DubzAWrrZRVqPCRrDsfs+QZcXfW7Ix4wQmNCtLzVYSve
        2jqEVtRpdK/z0rA1syhLegdluJWIzHU=
X-Google-Smtp-Source: ABdhPJxdAMH/1yNOC767NAIuI6Bm/K9obBCVtqTLBCyVCXmhtlCulSLCVvJs4ITx8yyilpBlo+6diw==
X-Received: by 2002:a05:600c:2159:: with SMTP id v25mr4998436wml.42.1628168297959;
        Thu, 05 Aug 2021 05:58:17 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.232])
        by smtp.googlemail.com with ESMTPSA id o2sm5571604wmq.30.2021.08.05.05.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 05:58:17 -0700 (PDT)
Subject: Re: [BUG] 'git rebase -i ---rebase-merges' can leave MERGE_MSG behind
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
References: <20210731062322.GB23408@szeder.dev>
 <80afcf4f-fc5a-7722-1a4d-c3e1f1de1e09@gmail.com>
Message-ID: <3fde8317-e157-f6a9-5954-3623ce0215ab@gmail.com>
Date:   Thu, 5 Aug 2021 13:58:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <80afcf4f-fc5a-7722-1a4d-c3e1f1de1e09@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/08/2021 10:56, Phillip Wood wrote:
> On 31/07/2021 07:23, SZEDER Gábor wrote:
>> Hi,
>>
>> 'git rebase -i --rebase-merges' leaves a stray '.git/MERGE_MSG' file
>> behind after it re-created an unchanged merge commit.  The test script
>> below demonstrates this issue (it doesn't fail, but look at its
>> verbose output to see what the issue and its consequences are).
>>
>> This issue is as old as --rebase-merges, I see the same output with
>> v2.18.0, the first release containing this feature.
>>
>> I suspect that fixing this is merely a matter of adding a missing
>> unlink(".git/MERGE_MSG") to the right place, but I won't dive into the
>> sequencer machinery to figure out where that right place might be :)
> 
> Looking at do_merge() in sequencer.c .git/MERGE_MSG is written before it 
> checks if it can fast-forward. If it does fast-forward then 'git commit' 
> is not run and .git/MERGE_MSG is not removed. I think the best way to 
> fix it would be to move the fast-forward code so it comes before the 
> code that writes .git/MERGE_MSG. That way we'll not write the message if 
> we can fast-forward.

I've spotted a couple of other small issues in do_merge(), I'll try and 
post some patches next week.

Best Wishes

Phillip


> Best Wishes
> 
> Phillip
> 
>>
>>    ---  >8  ---
>>
>> #!/bin/sh
>>
>> test_description='test'
>>
>> . ./test-lib.sh
>> . "$TEST_DIRECTORY"/lib-rebase.sh
>>
>> test_expect_success '--rebase-merges leaves MERGE_MSG behind' '
>>     # A-B-M-D-E-F
>>     #  \ /
>>     #   C
>>     test_commit A &&
>>     test_commit B &&
>>     git checkout -b branch HEAD^ &&
>>     test_commit C &&
>>     git checkout master &&
>>     git merge --log branch &&
>>     test_commit D &&
>>     test_commit E &&
>>     test_commit F &&
>>
>>     # Rewrite a commit after the merge:
>>     write_script todo-editor <<-\EOF &&
>>     sed -i -e "/^pick .* E$/ s/^pick/edit/" "$1"
>>     EOF
>>
>>     # No MERGE_MSG present before starting the rebase, good:
>>     test_path_is_missing .git/MERGE_MSG &&
>>
>>     # Start rebasing before the merge, so the sequencer has to
>>     # re-create an identical merge commit.
>>     GIT_EDITOR=./todo-editor git rebase -i --rebase-merges A &&
>>
>>     # Just to make sure that the history so far is unchanged:
>>     test_cmp_rev E HEAD &&
>>
>>     # BUG: now there is a stray MERGE_MSG file:
>>     cat .git/MERGE_MSG &&
>>
>>     # And it interferes with the next "git commit", because its
>>     # content is included in the commit message template:
>>     echo foo >>E.t &&
>>     GIT_EDITOR=cat git commit -a
>> '
>>
>> test_done
>>

