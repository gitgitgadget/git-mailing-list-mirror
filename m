Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9E9C433EF
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 23:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343781AbiCNXz0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 19:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbiCNXzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 19:55:25 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D699533E17
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 16:54:14 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n2so14879653plf.4
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 16:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9vx/LFqEyqA3jV07nA/jhAZedC9Mka/f36smDnR0+Ig=;
        b=DbvCB5UwrgIg5jwaOzapAr74EDXt7bEx8e+ZkOWjRhVLtejfqY72AdPzC5zGcYbVoi
         1JOQzAD9Zikzk4Z9/Wv8uuzNUKbr+XURsOYW64F43QqSLNnTpcrYt8MRMr746JLWIDLB
         kVhJmapkr7015qzWHkvobOUtXGjK5emDrox6iditGEVCJ+2WgCPr4nEXIOPsyrZa2LlX
         2073wKNtazqGtk2hN5P/hpk2Lq7rntLi86yRx4jZYABtt4P/FEioI7m6tQCiElj6o4Xv
         +5QSraJKYUgoAKC5IkcklTkS82kr1xmHWb8Uf7EbAmEz6jr9fGNi2d2B1skjycmIRKbO
         hXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9vx/LFqEyqA3jV07nA/jhAZedC9Mka/f36smDnR0+Ig=;
        b=OSf+vsAaY2g/Crs/O7IZ50/gdhkrNt5q7WvlWuDcjUUaH3PVoA3xQD09UsPUBzacId
         JWhPfqKyDwTo1vyoOhqG7VcFaNQVAXJo5r8psjUfu6UmmH953n5zUidoXn95/vqmlwGF
         iLqiIH3O44KgzT0Ay/ce2Uj2dTXn05C3TaXVsPeXsoFcEs1fdMUuy4VB8T7ZMuTCBNsl
         d8GkXrJUa77I5rn6nYF14/ELIS/mVxxQSgp4NgX64L4TfwyEPeXe8AWEHyWD6IpVWjuC
         4JTMfB92sghXbEwL3LCuex05ishEAOkSEZboQXbGoEv3JblU5m5AD/N8joyhlnWF77rU
         q5PQ==
X-Gm-Message-State: AOAM531ZDyktkvTcai7ikkJ6PAT5rZDBd9qVyTefR5Q26x1G83bQRSPV
        taJ786Tf+8tYr30VhLn4E+82
X-Google-Smtp-Source: ABdhPJyZVpZ/TOvA4BrukowTAkBkYnXOKEU5znAgkDTsVrpzwX7+wLVuvibeXUdJJQLZNZT6VHz9fQ==
X-Received: by 2002:a17:90a:8543:b0:1bc:c302:7030 with SMTP id a3-20020a17090a854300b001bcc3027030mr1614987pjw.182.1647302054383;
        Mon, 14 Mar 2022 16:54:14 -0700 (PDT)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id d4-20020aa78e44000000b004f6aaa184c9sm20553969pfr.71.2022.03.14.16.54.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 16:54:14 -0700 (PDT)
Message-ID: <cccf5552-a753-b472-0e22-d7f45542d424@github.com>
Date:   Mon, 14 Mar 2022 16:54:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v2 5/5] stash: make internal resets quiet and refresh
 index
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com
References: <pull.1170.git.1647043729.gitgitgadget@gmail.com>
 <pull.1170.v2.git.1647274230.gitgitgadget@gmail.com>
 <3334d4cb6f302a35986d94ea8ffcd1ee9c6aae5d.1647274230.git.gitgitgadget@gmail.com>
 <xmqqtuc0qq0w.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqqtuc0qq0w.fsf@gitster.g>
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
>> Add the options '-q' and '--refresh' to the 'git reset' executed in
>> 'reset_head()', and '--refresh' to the 'git reset -q' executed in
>> 'do_push_stash(...)'.
>>
>> 'stash' is implemented such that git commands invoked  as part of it (e.g.,
>> 'clean', 'read-tree', 'reset', etc.) have their informational output
>> silenced. However, the 'reset' in 'reset_head()' is *not* called with '-q',
>> leading to the potential for a misleading printout from 'git stash apply
>> --index' if the stash included a removed file:
>>
>> Unstaged changes after reset: D      <deleted file>
>>
>> Not only is this confusing in its own right (since, after the reset, 'git
>> stash' execution would stage the deletion in the index), it would be printed
>> even when the stash was applied with the '-q' option. As a result, the
>> messaging is removed entirely by calling 'git status' with '-q'.
>>
>> Additionally, because the default behavior of 'git reset -q' is to skip
>> refreshing the index, but later operations in 'git stash' subcommands expect
>> a non-stale index, enable '--refresh' as well.
>>
>> Signed-off-by: Victoria Dye <vdye@github.com>
>> ---
>>  builtin/stash.c  |  5 +++--
>>  t/t3903-stash.sh | 12 ++++++++++++
>>  2 files changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/builtin/stash.c b/builtin/stash.c
>> index 3e8af210fde..91407d9bbe0 100644
>> --- a/builtin/stash.c
>> +++ b/builtin/stash.c
>> @@ -310,7 +310,7 @@ static int reset_head(void)
>>  	 * API for resetting.
>>  	 */
>>  	cp.git_cmd = 1;
>> -	strvec_push(&cp.args, "reset");
>> +	strvec_pushl(&cp.args, "reset", "--quiet", "--refresh", NULL);
>>  
>>  	return run_command(&cp);
>>  }
>> @@ -1633,7 +1633,8 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
>>  			struct child_process cp = CHILD_PROCESS_INIT;
>>  
>>  			cp.git_cmd = 1;
>> -			strvec_pushl(&cp.args, "reset", "-q", "--", NULL);
>> +			strvec_pushl(&cp.args, "reset", "-q", "--refresh", "--",
>> +				     NULL);
>>  			add_pathspecs(&cp.args, ps);
>>  			if (run_command(&cp)) {
>>  				ret = -1;
>> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
>> index f36e121210e..17f2ad2344c 100755
>> --- a/t/t3903-stash.sh
>> +++ b/t/t3903-stash.sh
>> @@ -261,6 +261,18 @@ test_expect_success 'apply -q is quiet' '
>>  	test_must_be_empty output.out
>>  '
>>  
>> +test_expect_success 'apply --index -q is quiet' '
>> +	# Added file, deleted file, modified file all staged for commit
>> +	echo foo >new-file &&
>> +	echo test >file &&
>> +	git add new-file file &&
>> +	git rm other-file &&
>> +
>> +	git stash &&
> 
> Hpmh.  The hunk that updates reset_head() does get exercised by
> "apply --index", so testing that is OK, but we are also patching
> "do_push_stash()" to be quiet, so don't we care the chattyness of
> this step, too?
> 

The '-q' option was already present in the reset in 'do_push_stash()', but I
did add the '--refresh' option to ensure that (for example) 'git stash push
--staged' refreshes the index. With that in mind...

> In these steps, we also want the same "did the command refresh the
> index?" tests, no?
> 

yes, both cases where '--refresh' was added should be tested (since both
will fail if they don't include that option). I'll add them in the next
iteration.

>> +	git stash apply --index -q >output.out 2>&1 &&
>> +	test_must_be_empty output.out
>> +'
>> +
>>  test_expect_success 'save -q is quiet' '
>>  	git stash save --quiet >output.out 2>&1 &&
>>  	test_must_be_empty output.out
> 
> Other than these nits I noticed, the overall idea of the topic is
> well presented.  Thanks for working on this.
> 

