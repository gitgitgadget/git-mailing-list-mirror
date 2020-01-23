Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBACDC2D0DB
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 15:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A85A821D7E
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 15:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJYsYV+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgAWPpg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 10:45:36 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33785 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbgAWPpf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 10:45:35 -0500
Received: by mail-qt1-f194.google.com with SMTP id d5so2826482qto.0
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 07:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h0uYLtoN8YaaMQwRXbDpBqrQ0Tey/1w4RNCAKKpIerQ=;
        b=GJYsYV+CRzqz6e99Eovyz6LpFSMu8SC3EYK5DrCex64RQBzC1wpgp9F2sKCDkXCU3y
         G2aG+IHNIld1AaKFP4+HgE5Pi6SYt+l2qHvAk32qvbqEJ8U5EUntTo4jXian4//hAUOD
         JJyHYNf0inqgc5aOYm9HbSdxKMgTvxYNaMP5v+zSKE8dCb4RH3PwnNcIZYrwa5B+umgt
         HAdrdvVqqlhF4qy3fQgpsfmjizxwiRq6w8hwj7INanEpgvp5wmpKp1J5iqrpcFEDlGNp
         A2j9WMRCs+RpDV9ir+HOeBb96qzpxLthGsZfal2+esHRfbhXUAOuulWroGwyaZA/RSq7
         LvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h0uYLtoN8YaaMQwRXbDpBqrQ0Tey/1w4RNCAKKpIerQ=;
        b=UIpycscuiguweRA50CRLu4dUtU6nkIHciD3jiuwKjXpGR9FoZM6OsHN6VuB+TqMe7y
         sCVRm+k1Cf4yctByiQQf6133Wh5Nl7URr/wwbB0uJqtAxRUYlgAHIZNn2+izRXLoEx+H
         i+D97s4Igsmxyx22BMqsyy1Ij8ZXyiCRUbe9w/1QkVN/pW+dcGNzierhN4w+8FpVH5Ce
         rvqx0aVBXl2+r/92r63WI3TBF2Jbs2Qy70j/aWK6mQv9STPxMKjkcwoafSUqnJq7ToWu
         LFyZT0RNp4hXDZpMFxcAUU5/YgOhK2YsXIfXHmjuWzo3FgaqSqeYwlM9bAWD+q7kv/pv
         vfEQ==
X-Gm-Message-State: APjAAAXcSpEnxucGXMLa3tZRJohD4nAd8/unD2lr680f0TeZOIfWL6EG
        str6UkTK92bQgrhx3Lo32e8=
X-Google-Smtp-Source: APXvYqzUkwv409YMdwC/ouPFYU7h3zeOwYg3TssVSlhKk3fIK0YWxjCjno4yFwRvMCYWPuFZ/j4GSg==
X-Received: by 2002:ac8:7501:: with SMTP id u1mr16772707qtq.149.1579794334657;
        Thu, 23 Jan 2020 07:45:34 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:fdb6:49de:4189:c4f0? ([2001:4898:a800:1010:aeec:49de:4189:c4f0])
        by smtp.gmail.com with ESMTPSA id k4sm1027045qki.35.2020.01.23.07.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 07:45:33 -0800 (PST)
Subject: Re: [PATCH v2 4/8] t3030-merge-recursive.sh: disable fsmonitor when
 tweaking GIT_WORK_TREE
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, ukshah2@illinois.edu,
        Kevin.Willford@microsoft.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
 <pull.466.v2.git.1575907804.gitgitgadget@gmail.com>
 <efc16962ee2595db50bf051fc84632b8c70036b3.1575907804.git.gitgitgadget@gmail.com>
 <20191210100732.GD6527@szeder.dev>
 <b3e8ad07-b2cb-e024-405e-27d9f065f5fc@gmail.com>
 <20191210150745.GH6527@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <73ca58e8-bc04-5607-c21e-e7cfacd8df37@gmail.com>
Date:   Thu, 23 Jan 2020 10:45:32 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <20191210150745.GH6527@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/10/2019 10:07 AM, SZEDER Gábor wrote:
> On Tue, Dec 10, 2019 at 08:45:27AM -0500, Derrick Stolee wrote:
>>>> Worktrees use a ".git" _file_ instead of a folder to point to
>>>> the base repo's .git directory and the proper worktree HEAD. The
>>>> fsmonitor hook tries to create a JSON file inside the ".git" folder
>>>> which violates the expectation here.
>>>
>>> Yeah, there are a couple hardcoded paths in there, e.g.:
>>>
>>>   open ($fh, ">", ".git/watchman-response.json");
>>>
>>> and, worse, not only in the test helper hook in
>>> 't/t7519/fsmonitor-watchman' but in the sample hook template
>>> 'templates/hooks--fsmonitor-watchman.sample' as well.
>>>
>>>> It would be better to properly
>>>> find a safe folder for storing this JSON file.
>>>
>>>   git rev-parse --git-path ''
>>>
>>> gives us the right directory prefix to use and we could then append
>>> the various filenames that must be accessed in there.
>>
>> Adding another git process inside the hook is hopefully not
>> the only way to achieve something like this. The performance
>> hit (mostly on Windows) would be a non-starter for me.
> 
> Oh, hang on, it seems that we could simply use $GIT_DIR.
> 
> I added
> 
>   echo >&2 "GIT_DIR in the fsmonitor hook: '$GIT_DIR'"
> 
> to 't/t7519/fsmonitor-all', and then run the test:
> 
>   test_expect_success 'test' '
>           echo 1 >file &&
>           git add file &&
>           git commit -m first &&
>   
>           git worktree add --detach WT &&
>           cd WT &&
>           echo 2 >file &&
>           git add -u
>   '
> 
> with 'GIT_TEST_FSMONITOR=$(pwd)/t7519/fsmonitor-all', and in the
> verbose output got lines like:
> 
>   GIT_DIR in the fsmonitor hook: ''
>   GIT_DIR in the fsmonitor hook: ''
>   GIT_DIR in the fsmonitor hook: '/home/szeder/src/git/t/trash directory.t9999-test/.git/worktrees/WT'
>   GIT_DIR in the fsmonitor hook: '/home/szeder/src/git/t/trash directory.t9999-test/.git/worktrees/WT'
> 
> I'm not sure why $GIT_DIR is not exported to the hook script while in
> the main working tree.  Anyway, as it is now, if $GIT_DIR is
> unset/empty, then the hook should write to ".git/<whatever>", and if
> it is set, then to "$GIT_DIR/<whatever>", so no git process is needed
> in the hook, only a getenv() and a condition.

Thanks for this. It helps that also the test hooks were using the
.git directory only for debug information, and that was commented-out
in the v2 version of the hook.

Thanks,
-Stolee

