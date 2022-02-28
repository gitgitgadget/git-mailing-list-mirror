Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72D3C433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 23:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiB1XSd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 18:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiB1XSb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 18:18:31 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74163464A
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 15:17:50 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id s1so11989271plg.12
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 15:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0ZvcKR4MYNtl9ARqS+efz/8iwhBY5jrAMgjChxNKCfo=;
        b=MOQMxQJsRGOS1hIxPl2A4ei9EKhOcO2akMeikEfVDJy0z3Orx/oVrOf/bg+3otVNcI
         N1EU2UOhJnXLoOq0Z1zC5eRrjo8q4Ayk4ICOGPaqFSnmjvKzlesHPeIpTn/22NC94BXQ
         nDX9yRoqC1BjgBpsBx2N5fI333yyXO3S+4KSKwNTyfifvaJIJ8JEYpyG94MInQ8pQgbJ
         d9E2M0491aLo5HEhGWTv8QxEKSh1rxgQ6f/vbJqvRT2RRV+ByjQMg8YDT2UWqm0yfcmW
         K8xacDrx63/Hgdh21l8zNWviHtIhsrfpwtmFtbBhdxTsCVBEyBYhJhanNEUBy/HoJ0XY
         ZhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0ZvcKR4MYNtl9ARqS+efz/8iwhBY5jrAMgjChxNKCfo=;
        b=ATsuJ8uTUOH3ePZhhEdPPgVidYC4Shn2cFpNX2MRjEOEx7q/Z5aUyVBdvCoiy31duJ
         lX1gSYxusFGmkp6/UIR8htqzc9ny9X2Uu6+ixpgOKPLJX+YnU8ucPWMDgHFx1I29s8qy
         xS9LFGm5E75gHqbAXOHbQqBAVjbKgviZIVEzQfeSNIAlDl7ZnSFAnwOtiRtUfjUHxdyk
         euE59e5BEgRSbd+qUGN8h9Xg1Eh8s/WkF5M8oLfwL1A+5JRYFco88tRSzkIl9dcwqxE8
         5Cuzx9Gv92EppBulbl/qRQNS/8HQdNFQjJniNcO8uPNuxMdUh7QgvtCsEIf1yi3z69fW
         J9Yw==
X-Gm-Message-State: AOAM533VOqDq9nnh/QeAx+9N9q0AWNNLkxUKxpJK/s9HFxQGP2IfKYIm
        Eek99vUGnCzreuABo2a5y8eIGFpmHfLu
X-Google-Smtp-Source: ABdhPJwsiJ03H0dgUimX/GtaP6uwtG3t0i5hLZPL+HbXhiIVoDZW3AnRxCXwPbxcM8U2cp1IXySBlQ==
X-Received: by 2002:a17:902:d50a:b0:14f:a194:9d12 with SMTP id b10-20020a170902d50a00b0014fa1949d12mr23054773plg.147.1646090270332;
        Mon, 28 Feb 2022 15:17:50 -0800 (PST)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id f13-20020a056a001acd00b004f0f9a967basm15077909pfv.100.2022.02.28.15.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 15:17:49 -0800 (PST)
Message-ID: <7cc515a0-2690-3e54-de87-8e065095dae7@github.com>
Date:   Mon, 28 Feb 2022 15:17:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v2 2/7] status: fix nested sparse directory diff in sparse
 index
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
 <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
 <f0cff03b95d574dff414a63325a0f1c6d2d1ff96.1645742073.git.gitgitgadget@gmail.com>
 <CABPp-BGLG15g1UYanaNy=zM320DEYWW52xKNRDA_87mcVXWhYQ@mail.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <CABPp-BGLG15g1UYanaNy=zM320DEYWW52xKNRDA_87mcVXWhYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Thu, Feb 24, 2022 at 2:34 PM Victoria Dye via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Victoria Dye <vdye@github.com>
>>
>> Add the 'recursive' flag to 'wt_status_collect_changes_index(...)'. Without
> 
> Perhaps "Set the 'recursive' diff option flag in
> 'wt_status_collect_changes_index(...)'" ?  There's no function
> argument named 'recursive' in wt_status_collect_changes_index() before
> or after your changes, which is what the wording led me to think of.
> 

Re-reading that now, I agree. Will fix!

>> the 'recursive' flag, 'git status' could report index changes incorrectly
>> when the following conditions were met:
>>
>> * sparse index is enabled
>> * there is a difference between the index and HEAD in a file inside a
>>   *subdirectory* of a sparse directory
>> * the sparse directory index entry is *not* expanded in-core
>>
>> In this scenario, 'git status' would not recurse into the sparse directory's
>> subdirectories to identify which file contained the difference between the
>> index and HEAD. Instead, it would report the immediate subdirectory itself
>> as "modified".
>>
>> Example:
>>
>> $ git init
>> $ mkdir -p sparse/sub
>> $ echo test >sparse/sub/foo
>> $ git add .
>> $ git commit -m "commit 1"
>> $ echo somethingelse >sparse/sub/foo
>> $ git add .
>> $ git commit -a -m "commit 2"
>> $ git sparse-checkout set --cone --sparse-index 'sparse'
>> $ git reset --soft HEAD~1
>> $ git status
>> On branch master
>> You are in a sparse checkout.
>>
>> Changes to be committed:
>>   (use "git restore --staged <file>..." to unstage)
>>         modified:   sparse/sub
>>
>> The 'recursive' diff option in 'wt_status_collect_changes_index' corrects
>> this by indicating that 'git status' should recurse into sparse directories
>> to find modified files. Given the same repository setup as the example
>> above, the corrected result of `git status` is:
>>
>> $ git status
>> On branch master
>> You are in a sparse checkout.
>>
>> Changes to be committed:
>>   (use "git restore --staged <file>..." to unstage)
>>         modified:   sparse/sub/foo
>>
>> Signed-off-by: Victoria Dye <vdye@github.com>
>> ---
>>  t/t1092-sparse-checkout-compatibility.sh | 7 +++++++
>>  wt-status.c                              | 9 +++++++++
>>  2 files changed, 16 insertions(+)
>>
>> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
>> index 9ef7cd80885..b1dcaa0e642 100755
>> --- a/t/t1092-sparse-checkout-compatibility.sh
>> +++ b/t/t1092-sparse-checkout-compatibility.sh
>> @@ -278,6 +278,13 @@ test_expect_success 'status with options' '
>>         test_all_match git status --porcelain=v2 -uno
>>  '
>>
>> +test_expect_success 'status with diff in unexpanded sparse directory' '
>> +       init_repos &&
>> +       test_all_match git checkout rename-base &&
>> +       test_all_match git reset --soft rename-out-to-out &&
>> +       test_all_match git status --porcelain=v2
>> +'
>> +
>>  test_expect_success 'status reports sparse-checkout' '
>>         init_repos &&
>>         git -C sparse-checkout status >full &&
>> diff --git a/wt-status.c b/wt-status.c
>> index 335e723a71e..4a5b9beeca1 100644
>> --- a/wt-status.c
>> +++ b/wt-status.c
>> @@ -651,6 +651,15 @@ static void wt_status_collect_changes_index(struct wt_status *s)
>>         rev.diffopt.detect_rename = s->detect_rename >= 0 ? s->detect_rename : rev.diffopt.detect_rename;
>>         rev.diffopt.rename_limit = s->rename_limit >= 0 ? s->rename_limit : rev.diffopt.rename_limit;
>>         rev.diffopt.rename_score = s->rename_score >= 0 ? s->rename_score : rev.diffopt.rename_score;
>> +
>> +       /*
>> +        * The `recursive` option must be enabled to show differences in files
>> +        * *more than* one level deep in a sparse directory index entry (e.g., given
>> +        * sparse directory 'sparse-dir/', reporting a difference in the file
>> +        * 'sparse-dir/another-dir/my-file').
>> +        */
>> +       rev.diffopt.flags.recursive = 1;
> 
> Kind of clever, and makes sense.
> 
> I'm wondering if there's an alternate wording that might be helpful
> here or in the commit message, that instead of just saying the
> 'recursive' option is necessary, perhaps says a little bit about why
> it helps.  In particular, the diff machinery, by default, is not
> recursive and stops at comparing the first level of trees.  (See e.g.
> the -r option in diff-tree, it's just that it's turned on by default
> in 'git diff' and by the -p option in 'git log'.)  I'm guessing the
> recursive option never needed to be turned on previously within
> wt-status, due to something about the nature of the index only holding
> files previously.  Now, however, the sparse index changes that.  (And
> it also suggests that perhaps we should look to see if other commands
> run the diff machinery without the recursive flag, and see if they
> need it now due to sparse indices.)
> 
> Granted, I'm not totally sure how to work these facts in (in part
> because I don't know how comparison to the index normally avoids the
> need for the recursive flag), and maybe what you have is fine.  Just
> thought I'd point it out since I wasn't aware of the non-recursive
> nature of the diff machinery until I started doing things with
> diff-tree.
>

All good points - I'll reword the commit message and code comment to explain
that 1) diff is not recursive by default, and 2) why the diff of a sparse
directory requires `recursive = 1`.
 
> 
>> +
>>         copy_pathspec(&rev.prune_data, &s->pathspec);
>>         run_diff_index(&rev, 1);
>>         object_array_clear(&rev.pending);
>> --
>> gitgitgadget

