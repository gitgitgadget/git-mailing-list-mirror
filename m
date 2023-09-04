Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64A9C83F33
	for <git@archiver.kernel.org>; Mon,  4 Sep 2023 14:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244347AbjIDOcI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Sep 2023 10:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjIDOcH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Sep 2023 10:32:07 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E5094
        for <git@vger.kernel.org>; Mon,  4 Sep 2023 07:32:03 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31f4950333cso702528f8f.3
        for <git@vger.kernel.org>; Mon, 04 Sep 2023 07:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693837922; x=1694442722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ciidY0sOgEEVjdxj7sx8EMj8gNiVtevKcUbkCPqFcC8=;
        b=QwUUeckHZsigYqUSLylcQ0uewQmu8Ld9f+DAi2HyIP7wsfg+zKLuOSUOuT/1zntDn+
         IR+F3jQsgdmDlwxiE/Y2SM4k1I2rsYVI0DhVuNM+8Yyc/qZIiWqPR/pc2HlwQYyzqduH
         pzPGCAcQfhgTXp0VimZj0DT1XYR05hZx9300EpY1CTKvTcUgnpWGQ5ebUbWspoSYB3wb
         FMmfiqtQ3PKCKPVdvlGpWFhjunEs61P5OoN0bfFuIMUqGxWKSnZtT9W64uK8HPrECjE5
         GNH8Pl45q+Qz8BiHg+K1nmowas+NmKcbAKHxLK2x9Kdv/ibFm6pFlU4fLbCt/IMx8Iqt
         hIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693837922; x=1694442722;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ciidY0sOgEEVjdxj7sx8EMj8gNiVtevKcUbkCPqFcC8=;
        b=jZd7BUga5w4kufXU2MiU4Sk4waOCEO/wpvOiS6ans+Sd2OpG1di+6odkNxPDQ0XVbn
         LP0gBOv1FvvxWN/LYTekA3Hn0Qk4a4tmF1KKknRYlkUX6bUWBMI1bpR/mCEgMEOuRAhK
         Ag0ulbgw3vY10p+R+lIPDlweFf0uAZEgGqTGJObWgkw/v+IrNnwCUz8UcAsjJRTPper5
         TFpNP3ihpGMRiWy0l4uL4IntuNkIr/yyoYUr0M+SczoRIZ2n6uBdXj60wxCczeO0waiR
         Ht1IPzB/NKeNUzVdmJH67E6Z2rD2AqzOI6PAkAwGtOeCBsbQiEHpiZymMFgH9Uk5Zv0s
         J32g==
X-Gm-Message-State: AOJu0YwxnnYdvYBFV0mq+Wjf8LHqQUPPAgnkhKD0nDTkqqiMKpJRdW1v
        DSjLeKxm6glXvR6B7wK8WDM=
X-Google-Smtp-Source: AGHT+IEGKZxX5vtNds0hfVyhIcLt5Vzkb9f7N8NOreInCsOIcK2Pg7m35NDuI3evMfk+TIvToBILHA==
X-Received: by 2002:a05:6000:787:b0:31f:4173:2ac8 with SMTP id bu7-20020a056000078700b0031f41732ac8mr3888451wrb.18.1693837921509;
        Mon, 04 Sep 2023 07:32:01 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id d15-20020adffd8f000000b00317ab75748bsm14702546wrr.49.2023.09.04.07.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 07:32:01 -0700 (PDT)
Message-ID: <4606961d-6ead-4cad-8831-5bbded31b23b@gmail.com>
Date:   Mon, 4 Sep 2023 15:31:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 5/7] rebase: fix rewritten list for failed pick
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
 <pull.1492.v3.git.1690903412.gitgitgadget@gmail.com>
 <df4019458665eccf2b16cdf1d6c1061186a62711.1690903412.git.gitgitgadget@gmail.com>
 <304553b3-3668-0b98-c6dc-3c047fd9e34c@gmx.de>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <304553b3-3668-0b98-c6dc-3c047fd9e34c@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 23/08/2023 09:55, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Tue, 1 Aug 2023, Phillip Wood via GitGitGadget wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> git rebase keeps a list that maps the OID of each commit before it was
>> rebased to the OID of the equivalent commit after the rebase.  This list
>> is used to drive the "post-rewrite" hook that is called at the end of a
>> successful rebase. When a rebase stops for the user to resolve merge
>> conflicts the OID of the commit being picked is written to
>> ".git/rebase-merge/stopped-sha". Then when the rebase is continued that
>> OID is added to the list of rewritten commits. Unfortunately if a commit
>> cannot be picked because it would overwrite an untracked file we still
>> write the "stopped-sha1" file. This means that when the rebase is
>> continued the commit is added into the list of rewritten commits even
>> though it has not been picked yet.
>>
>> Fix this by not calling error_with_patch() for failed commands. The pick
>> has failed so there is nothing to commit and therefore we do not want to
>> set up the state files for committing staged changes when the rebase
>> continues. This change means we no-longer write a patch for the failed
>> command or display the error message printed by error_with_patch(). As
>> the command has failed the patch isn't really useful and in any case the
>> user can inspect the commit associated with the failed command by
>> inspecting REBASE_HEAD. Unless the user has disabled it we already print
>> an advice message that is more helpful than the message from
>> error_with_patch() which the user will still see. Even if the advice is
>> disabled the user will see the messages from the merge machinery
>> detailing the problem.
>>
>> To simplify writing REBASE_HEAD in this case pick_one_commit() is
>> modified to avoid duplicating the code that adds the failed command
>> back into the todo list.
> 
> This motivates the change well, and answered all but one of the questions
> I had about it, being:
> 
>> diff --git a/sequencer.c b/sequencer.c
>> index 62277e7bcc1..e25abfd2fb4 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> [...]
>> @@ -4658,12 +4659,8 @@ static int pick_one_commit(struct repository *r,
>>   			     check_todo);
>>   	if (is_rebase_i(opts) && res < 0) {
>>   		/* Reschedule */
>> -		advise(_(rescheduled_advice),
>> -		       get_item_line_length(todo_list, todo_list->current),
>> -		       get_item_line(todo_list, todo_list->current));
>> -		todo_list->current--;
> 
> Why is it okay to remove this decrement?
> 
> Here is why: The code that calls `save_todo()` in the `if (reschedule)`
> block of the loop of `pick_commits()` _duplicates_ the logic that is
> removed here, including the advice and the decrementing of `current`.
> 
> I had to instrument the code before and after this patch to figure this
> out, as I had missed the fact that the now-remaining code also decremented
> the `current` attribute.
> 
> So: All is good with this patch. If you'd like to amend the commit message
> accordingly, I would not be opposed, but I could now live equally as
> easily without it.

I'll try and add something to the commit message when I re-roll

Thanks

Phillip

>> -		if (save_todo(todo_list, opts))
>> -			return -1;
>> +		*reschedule = 1;
>> +		return -1;
>>   	}
>>   	if (item->command == TODO_EDIT) {
>>   		struct commit *commit = item->commit;
> 
> I'd like to point out how delighted I am about this careful test case:
> 
>> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
>> index 96ae0edf1e1..4938ebb1c17 100755
>> --- a/t/t3430-rebase-merges.sh
>> +++ b/t/t3430-rebase-merges.sh
>> @@ -165,12 +165,12 @@ test_expect_success 'failed `merge -C` writes patch (may be rescheduled, too)' '
>>   	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
>>   	test_tick &&
>>   	test_must_fail git rebase -ir HEAD &&
>> +	test_cmp_rev REBASE_HEAD H^0 &&
>>   	grep "^merge -C .* G$" .git/rebase-merge/done &&
>>   	grep "^merge -C .* G$" .git/rebase-merge/git-rebase-todo &&
>> -	test_path_is_file .git/rebase-merge/patch &&
>> +	test_path_is_missing .git/rebase-merge/patch &&
>>
>>   	: fail because of merge conflict &&
>> -	rm G.t .git/rebase-merge/patch &&
>>   	git reset --hard conflicting-G &&
>>   	test_must_fail git rebase --continue &&
>>   	! grep "^merge -C .* G$" .git/rebase-merge/git-rebase-todo &&
>> diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
>> index 5f3ff051ca2..ad7f8c6f002 100755
>> --- a/t/t5407-post-rewrite-hook.sh
>> +++ b/t/t5407-post-rewrite-hook.sh
>> @@ -17,6 +17,12 @@ test_expect_success 'setup' '
>>   	git checkout A^0 &&
>>   	test_commit E bar E &&
>>   	test_commit F foo F &&
>> +	git checkout B &&
>> +	git merge E &&
>> +	git tag merge-E &&
>> +	test_commit G G &&
>> +	test_commit H H &&
>> +	test_commit I I &&
>>   	git checkout main &&
>>
>>   	test_hook --setup post-rewrite <<-EOF
>> @@ -173,6 +179,48 @@ test_fail_interactive_rebase () {
>>   	)
>>   }
>>
>> +test_expect_success 'git rebase with failed pick' '
>> +	clear_hook_input &&
>> +	cat >todo <<-\EOF &&
>> +	exec >bar
>> +	merge -C merge-E E
>> +	exec >G
>> +	pick G
>> +	exec >H 2>I
>> +	pick H
>> +	fixup I
>> +	EOF
>> +
>> +	(
>> +		set_replace_editor todo &&
>> +		test_must_fail git rebase -i D D 2>err
>> +	) &&
>> +	grep "would be overwritten" err &&
>> +	rm bar &&
>> +
>> +	test_must_fail git rebase --continue 2>err &&
>> +	grep "would be overwritten" err &&
>> +	rm G &&
>> +
>> +	test_must_fail git rebase --continue 2>err &&
>> +	grep "would be overwritten" err &&
>> +	rm H &&
>> +
>> +	test_must_fail git rebase --continue 2>err &&
>> +	grep "would be overwritten" err &&
>> +	rm I &&
>> +
>> +	git rebase --continue &&
>> +	echo rebase >expected.args &&
>> +	cat >expected.data <<-EOF &&
>> +	$(git rev-parse merge-E) $(git rev-parse HEAD~2)
>> +	$(git rev-parse G) $(git rev-parse HEAD~1)
>> +	$(git rev-parse H) $(git rev-parse HEAD)
>> +	$(git rev-parse I) $(git rev-parse HEAD)
>> +	EOF
>> +	verify_hook_input
>> +'
>> +
>>   test_expect_success 'git rebase -i (unchanged)' '
>>   	git reset --hard D &&
>>   	clear_hook_input &&
> 
> Here is my ACK.
> 
> Thank you,
> Johannes
