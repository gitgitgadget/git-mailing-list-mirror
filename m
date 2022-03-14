Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BC4C433EF
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 23:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239436AbiCNXuJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 19:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiCNXuH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 19:50:07 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6A3220E4
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 16:48:56 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id t5so16737810pfg.4
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 16:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+xg1wfLtkxblruV0pSAtwjS5wKtFnInThyr1dzsfd8M=;
        b=SVuch+TETLrv3x1sRJyvpx7Qx8T1zrS6z+9By1abTTfHBVqrqJkiWRckmHhgQmmXff
         EI0CAxw9MGRbYDPuy0cEIpDD+gHdbi76jzLDFvcNM4Uc3CJfHxu0wn7fRQGNwoV6pCD7
         WkiFpSD4KZK4vlK2nxSBMC+g6Vmxs3cn7Xqare08IRdoQnvZ7KngcNSiz11fMD/btPu1
         46nWSd7kp4YTtrnaliv8EyWrm94QgUIoMNkuYMvP6fwlmmsP1nF2QdTJNvFQtbDO/Cqw
         uqYgYHx9hb28L2FYxFoEXZ/B/lkipr+zNmkPftuw6Mz/rZRJ7T/TY1o3KZExDgE6qOWJ
         cvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+xg1wfLtkxblruV0pSAtwjS5wKtFnInThyr1dzsfd8M=;
        b=7uMMg4ZCv4w3wpVjBcJQ+6NkgA7SoqMw+idkhjOmM6jLFPMDfPL/+TF2CZ/7+Uq3Rw
         IxWzkfbiW54vj4iCVoIb6aDsRlWExErH0yZ9BRoiBwz+6fkWyv0VHF0vv5yaPTANSFBw
         Q3cehP28Fu8M7c3oeeBma4aED5xEe1Ocg4SO9pIauWRGD9KeT7LDcAFbXcz2OedSfGN7
         GOSMaaMaKT1anvFxDAWWkVBXAxTYVIPjSXsA0w9Kz7vO7kkn1UlcmSlZSKcwUII0a6/c
         XmvOLZbfBN0gaf637Nm1l9yQNy2cw7ZKPqvO2I+DKjWbSsKL5BeonAMnW107oSOxEC0P
         h9Tw==
X-Gm-Message-State: AOAM532r63T9125INuRMSiCKCXK9lUdZwEi+WxcvmestSoFxO5W6MpxL
        QFf2SLoULkSQWWMc5b2RCHXUDcJYRVhx
X-Google-Smtp-Source: ABdhPJzzx2f1rZp0NokU3uy0daAZEyNE3m1+4Eyyau3wjyyfRX9UP2ztTjGa0OcmnxWDKGLzd3z7vw==
X-Received: by 2002:a63:f40e:0:b0:380:6a04:4335 with SMTP id g14-20020a63f40e000000b003806a044335mr22017612pgi.523.1647301736452;
        Mon, 14 Mar 2022 16:48:56 -0700 (PDT)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id h8-20020a17090a648800b001bf2b437609sm613675pjj.24.2022.03.14.16.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 16:48:56 -0700 (PDT)
Message-ID: <ce5904f1-ee15-1be8-4019-d1cd10ac83f7@github.com>
Date:   Mon, 14 Mar 2022 16:48:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/5] reset: introduce --[no-]refresh option to --mixed
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com
References: <pull.1170.git.1647043729.gitgitgadget@gmail.com>
 <pull.1170.v2.git.1647274230.gitgitgadget@gmail.com>
 <7f0226bc3e646167808fbd2413dc54e87417230c.1647274230.git.gitgitgadget@gmail.com>
 <xmqq7d8ws5bo.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqq7d8ws5bo.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Victoria Dye <vdye@github.com>
>>
>> Add a new --[no-]refresh option that is intended to explicitly determine
>> whether a mixed reset should end in an index refresh.
>>
>> Starting at 9ac8125d1a (reset: don't compute unstaged changes after reset
>> when --quiet, 2018-10-23), using the '--quiet' option results in skipping
>> the call to 'refresh_index(...)' at the end of a mixed reset with the goal
>> of improving performance. However, by coupling behavior that modifies the
>> index with the option that silences logs, there is no way for users to have
>> one without the other (i.e., silenced logs with a refreshed index) without
>> incurring the overhead of a separate call to 'git update-index --refresh'.
>> Furthermore, there is minimal user-facing documentation indicating that
>> --quiet skips the index refresh, potentially leading to unexpected issues
>> executing commands after 'git reset --quiet' that do not themselves refresh
>> the index (e.g., internals of 'git stash', 'git read-tree').
>>
>> To mitigate these issues, '--[no-]refresh' and 'reset.refresh' are
>> introduced to provide a dedicated mechanism for refreshing the index. When
>> either is set, '--quiet' and 'reset.quiet' revert to controlling only
>> whether logs are silenced and do not affect index refresh.
>>
>> Helped-by: Derrick Stolee <derrickstolee@github.com>
>> Signed-off-by: Victoria Dye <vdye@github.com>
>> ---
>>  Documentation/git-reset.txt |  9 +++++
>>  builtin/reset.c             | 13 ++++++-
>>  t/t7102-reset.sh            | 77 +++++++++++++++++++++++++++++++++----
>>  3 files changed, 91 insertions(+), 8 deletions(-)
> 
> No complaints, but it is somewhat unsatisfying that we need these
> two steps that keep --quiet tied to the decision to or not to
> refresh.  In the longer term, it may be cleaner to completely
> dissociate them, but it probably is not a huge deal.
> 
>> +	/*
>> +	 * If refresh is completely unspecified (either by config or by command
>> +	 * line option), decide based on 'quiet'.
>> +	 */
>> +	if (refresh < 0)
>> +		refresh = !quiet;
> 
> OK.
> 
>> @@ -517,7 +528,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>>  			if (read_from_tree(&pathspec, &oid, intent_to_add))
>>  				return 1;
>>  			the_index.updated_skipworktree = 1;
>> -			if (!quiet && get_git_work_tree()) {
>> +			if (refresh && get_git_work_tree()) {
>>  				uint64_t t_begin, t_delta_in_ms;
>>  
>>  				t_begin = getnanotime();
> 
> Quite sensible.
> 
>> diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
>> index d05426062ec..005940778b7 100755
>> --- a/t/t7102-reset.sh
>> +++ b/t/t7102-reset.sh
>> @@ -462,14 +462,77 @@ test_expect_success 'resetting an unmodified path is a no-op' '
>>  	git diff-index --cached --exit-code HEAD
>>  '
>>  
>> +test_index_refreshed () {
>> +
>> +	# To test whether the index is refresh, create a scenario where a
> 
> Doesn't the verb "refresh" refer to the act of making it "fresh"
> (again)?  i.e. update the cached stat info to up-to-date?
> 
> "To test whether the index has been refreshed" or "To test whether
> the cached stat info is up-to-date", perhaps?
> 
>> +	# command will fail if the index is *not* refreshed:
>> +	#   1. update the worktree to match HEAD & remove file2 in the index
> 
> In other words, file2 tentatively becomes untracked.
> 
>> +	#   2. reset --mixed to unstage the change from step 1
> 
> But then, file2 is "added" to the index again, but added from the
> HEAD.  If this did not refresh, then we do not know if the contents
> of the file in the working tree is the same, and "diff-files" may
> say "file2 may be modified".  If "reset" refreshes, this will take
> us back to the same state as "reset --hard HEAD", and "diff-files"
> will not report that "file2" is different.
> 
>> +	#   3. read-tree HEAD~1 (which differs from HEAD in file2)
> 
> With "-m" option, I presume?  Do we want "-u" here, too?
> 
>> +	# If the index is refreshed in step 2, then file2 in the index will be
>> +	# up-to-date with HEAD and read-tree will succeed (thus failing the
>> +	# test). If the index is *not* refreshed, however, the staged deletion
>> +	# of file2 from step 1 will conflict with the changes from the tree read
>> +	# in step 3, resulting in a failure.
> 
> This feels a bit brittle.  The implementation of "read-tree -m" may
> choose to refresh beforehand to avoid such a failure.
> 
> In any case, the name of the helper alone wasn't of any help to
> realize that this is about checking if "reset" refreshes the index
> or not.  Perhaps call it more like
> 
> 	reset_refreshes_index
> 
> or something?
> 
> In any case, instead of the big comment block, comments interspersed
> in the steps may be easier to follow.  
> 
>> +	# Step 0: start with a clean index
>> +	git reset --hard HEAD &&
>> +
>> +	# Step 1
> 	# remove file2 from the index
>> +	git rm --cached file2 &&
>> +
>> +	# Step 2
> 	# resurrect file2 to the index from HEAD; if the cached stat
> 	# info gets refreshed, this brings us back to the state
>         # after Step 0.  If not, "diff-files" would report file2 is
> 	# different.
>> +	git $1 reset $2 --mixed HEAD &&
>> +
>> +	# Step 3
>> +	git read-tree -m HEAD~1
> 
> And use "diff-files file2" here?  Then you do not even have to rely
> on HEAD and HEAD~1 being different at file2.
> 

These are all helpful suggestions, I'll include them in a re-roll
(specifically: rename 'test_index_refreshed' to something mentioning
'reset', move the test comments inline with the steps they execute, and use
'diff-files' rather than 'read-tree'). 

Thanks!
