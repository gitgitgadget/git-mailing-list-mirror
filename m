Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A461C352A4
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 22:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632942168B
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 22:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjwNDeyC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgBLW0B (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 17:26:01 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33058 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbgBLW0B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 17:26:01 -0500
Received: by mail-pf1-f195.google.com with SMTP id n7so1948379pfn.0
        for <git@vger.kernel.org>; Wed, 12 Feb 2020 14:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:references:from:to:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=tyUSt5wnWfud31qxloqsDKBDE8nint8GWO7Rm5Egy0A=;
        b=JjwNDeyCOA5TeSPPpFUxRhL5415lf6/tXq12i1i2EPTewwL19vbA6NP8LsUVaQywz4
         9KBVWWNxw0Wr6co7RXjFH3XJTmS5dD3sV8B9n8HtEUjOepmGM8Jdh6WjzXC8A8GC8jPQ
         bpmz18S3eh66A0zx3PXS+6YG3heXx/e4qJguGQpxyTzgKFCh8OiaesBghbwTyMoaLVXf
         E0aSRcxM5S9LOJyjvgHuDryTTXorHIt2mMZy9A2P12XkZsuO8xq7zAS9ReSwN/894vOz
         DXi4/mQ86F4uWP788yCEA/1R2fp/NjqWWXRMcG+5FrKMhXonD2nKhMvfQjz79e1pd5sy
         gMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:from:to:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tyUSt5wnWfud31qxloqsDKBDE8nint8GWO7Rm5Egy0A=;
        b=oH4H7xI6+c4YjzvJTF9zczo+lp9pDxtGEshePY4GOKGT2Bj7yPRaFqqZHRheqfgXRv
         XvQCsAeMCSMPAF8CuhFhV0Sulr01VgSx9DUvHWio0ufXfWx52UfdzBmlFkX4HUrdBgL8
         NL8EFJLj0PkzovB1lk9SVkGsYjWdTBQuH8pLTCo1dSf661kqpjlnc4/iVnujAC5QbcHH
         qL9sAZ9CmpU4nWdAUWMF6YOAeYHSrqVzFbMGzXmGkfcjXkOyGAV10snVIMRiL3/su7ol
         3F2mnVEnZFzGKhmhTdgc3SeDKWaGyGHoqYuoYaWrpfH3ND2YLdKzTGfiGW4iP+kTxE75
         ZtvA==
X-Gm-Message-State: APjAAAWx8iFJiVxV4MUvkGfPEulosiBCp1lv2KnmsHu537k7s5jPNOWy
        P7Rq5lL+2l5rZIzsli9IKW9uclhE
X-Google-Smtp-Source: APXvYqzGKmll9yS+CU1An/fIvFYsnxS0G0Ph6/lHR7N7CvkDsHKFujjajgQV8fnstfV/Xnc23Eqhdw==
X-Received: by 2002:a63:1503:: with SMTP id v3mr10879257pgl.295.1581546360027;
        Wed, 12 Feb 2020 14:26:00 -0800 (PST)
Received: from [192.168.0.113] ([27.106.79.123])
        by smtp.gmail.com with ESMTPSA id z30sm242442pfq.154.2020.02.12.14.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 14:25:59 -0800 (PST)
Subject: Fwd: Re: [PATCH 0/5] object.c: localize global the_repository
 variable into r
References: <4cb3c2cc-b73d-0ea6-1f56-4c7a18d05532@gmail.com>
From:   parth gala <parthpgala@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git Mailing List <git@vger.kernel.org>
X-Forwarded-Message-Id: <4cb3c2cc-b73d-0ea6-1f56-4c7a18d05532@gmail.com>
Message-ID: <dac7264e-969d-259f-3d43-ac69a628d624@gmail.com>
Date:   Thu, 13 Feb 2020 03:55:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <4cb3c2cc-b73d-0ea6-1f56-4c7a18d05532@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org




-------- Forwarded Message --------
Subject: 	Re: [PATCH 0/5] object.c: localize global the_repository 
variable into r
Date: 	Thu, 13 Feb 2020 03:26:30 +0530
From: 	parth gala <parthpgala@gmail.com>
To: 	Taylor Blau <me@ttaylorr.com>




On 13/02/20 1:48 am, Taylor Blau wrote:
> Hi Parth,
>
> On Wed, Feb 12, 2020 at 07:19:06PM +0000, Parth Gala via GitGitGadget wrote:
>> I have created this commit in response to
>> https://github.com/gitgitgadget/git/issues/379#issue-503866117.
> Fantastic! Thank you for working on this.
>
>> All the functions in object.c which relied on 'the_repository' have
>> been modified.  The functions calling these functions in object.c
>> consisted calls to other functions using 'the_repository' as well, and
>> although I intended to use 'r' at all those instances, I thought it
>> would make more sense when we would deal with their callee functions
>> in another similar patch. What do you think ?
> That makes sense, and follows the conventions that other similar
> refactorings have done in the past.
>
> Any reason why you decided to start with 'object.c'? Not that any such
> reason is necessary, I'm just curious about how you came to this
> decision.

I am new to the git community and while searching for issues to solve I
found the issue linked above.
I figured solving it would give me a good experience navigating
and exploring the huge repository.

Initially I grepped to find all functions using `the_repository` but
randomly chose object.c since the refactoring had to start somewhere.
Special thanks to Johannes Schindelin for this.

>> Signed-off-by: Parth Gala parthpgala@gmail.com [parthpgala@gmail.com]
> Even though you *do* need a 'Signed-off-by' in each of your patches,
> adding it in the cover letter is not necessary.

I probably did not check the preview I sent to myself carefully for
this. Will make note of it.

>> Parth Gala (5):
>>     object.c: get_max_object_index and get_indexed_object accept 'r'
>>       parameter
>>     object.c: lookup_unknown_object() accept 'r' as parameter
>>     object.c: parse_object_or_die() accept 'r' as parameter
>>     object.c: clear_object_flags() accept 'r' as parameter
>>     object.c: clear_commit_marks_all() accept 'r' as parameter
>>
>>    builtin/checkout.c               |  3 ++-
>>    builtin/fsck.c                   |  8 +++++---
>>    builtin/grep.c                   |  6 ++++--
>>    builtin/index-pack.c             |  5 +++--
>>    builtin/log.c                    |  3 ++-
>>    builtin/name-rev.c               |  5 +++--
>>    builtin/pack-objects.c           |  3 ++-
>>    builtin/prune.c                  |  3 ++-
>>    bundle.c                         |  8 +++++---
>>    http-push.c                      |  3 ++-
>>    object.c                         | 32 ++++++++++++++++----------------
>>    object.h                         | 12 ++++++------
>>    pack-bitmap.c                    |  5 +++--
>>    reachable.c                      |  6 ++++--
>>    refs.c                           |  3 ++-
>>    revision.c                       |  3 ++-
>>    shallow.c                        | 13 ++++++++-----
>>    t/helper/test-example-decorate.c |  7 ++++---
>>    upload-pack.c                    | 19 ++++++++++++-------
>>    walker.c                         |  3 ++-
>>    20 files changed, 89 insertions(+), 61 deletions(-)
>>
>>
>> base-commit: 0ad714499976290d9a0229230cbe4efae930b8dc
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-545%2FParthGala2k%2Flocalize-the_repository-variable-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-545/ParthGala2k/localize-the_repository-variable-v1
>> Pull-Request: https://github.com/gitgitgadget/git/pull/545
>> --
>> gitgitgadget
> Thanks,
> Taylor
