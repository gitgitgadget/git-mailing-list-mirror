Return-Path: <SRS0=d2Ax=EG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2F2C388F9
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 10:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08C8A20739
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 10:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anrwn1UR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgJaKz4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Oct 2020 06:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgJaKzz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Oct 2020 06:55:55 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3CEC0613D5
        for <git@vger.kernel.org>; Sat, 31 Oct 2020 03:55:55 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id h22so5077839wmb.0
        for <git@vger.kernel.org>; Sat, 31 Oct 2020 03:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SrYDbbwOoJnhFQ+vUVCSptfPme1Vuax7gioUy9SL2KI=;
        b=anrwn1URdBS1mDyqRRv50hSji853fqbMN1SYTyKOcOTsUlTMjUI379xUWdbt05+VX4
         sZWp3AxgpeU35KiGH55lcS62PF3M2gAG7+mD0HbirBVu3f5C8+UswFlSPhocjcsdBrSK
         Sd4JZhJdE++Y9iCGXQ+CccbZAkmwFBUW97MBMTDtfjeXz1sDYZ7j4aJUMniYIudkkWAA
         HyRN4wOGtgLPHwqASvTLIpBe1PEAuQOcOhMmH0lQ6kNKdd9zIA0nNjVQN1uRyNcAWvJI
         98GI6IJAoq8lvylJT8CA8gJoRNlzlrKCFMeZj8KQFCJeRjQAlMJGmhQyf87mR2Iv+4VO
         kcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SrYDbbwOoJnhFQ+vUVCSptfPme1Vuax7gioUy9SL2KI=;
        b=jXIMHmhMjTZ1wwzixVv2QS5mmhFROj8DYPS57AIPymHmkMdzwPYBFN+y6XKZmpK+Qt
         440Tj12SJeqai5ik8j7tfg/jHo/sFwnkoMie7v8zDaTVoiFR5vR6ULQSn+wORKt7yHT6
         jMvSzXDBFwtizbBbjS/cXVJ0bppp0BVDmHzj2px/28fnZDTFdBJ9vfdcJrvbOnrSldzE
         +acd2QjmPPqmS3IolywRYGeIW1iyOajvCQvGxeMU9atEBcsVxRuvBfxxlRERwD+vFVxM
         Jasnxhe32SWCkqw4I1u2GI+6o7+1/2TAyZHLAv1iTGRxU6R0jf8IiZjFnIZmyOVoMI2x
         Q8bg==
X-Gm-Message-State: AOAM531GrWI3ltCWxueVzGwx5s3onH+JU8KXTpKn4/5I4iLwHQk1zXXI
        LsTBMnq4W72Ykpw9gigzFD6KAbsZg0Q=
X-Google-Smtp-Source: ABdhPJyH4dHgYL4S09sMYSbkQobanptvK1zkkE0r/+Va8q1cpdC/8jqb4V5UjqEywLxKKr1e96QmCA==
X-Received: by 2002:a1c:3846:: with SMTP id f67mr7764843wma.33.1604141754066;
        Sat, 31 Oct 2020 03:55:54 -0700 (PDT)
Received: from [192.168.1.201] (189.55.7.51.dyn.plus.net. [51.7.55.189])
        by smtp.googlemail.com with ESMTPSA id e25sm15653954wrc.76.2020.10.31.03.55.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2020 03:55:53 -0700 (PDT)
Subject: Re: [PATCH 1/4] rebase -i: stop overwriting ORIG_HEAD buffer
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Caspar Duregger <herr.kaste@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.773.git.1603807337.gitgitgadget@gmail.com>
 <24f2c4a62317231f4eabed23bb24d345abc9d67e.1603807338.git.gitgitgadget@gmail.com>
 <xmqq7drbbcj5.fsf@gitster.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <fa2d75ee-e692-a400-e9f7-8f13a5c220e8@gmail.com>
Date:   Sat, 31 Oct 2020 10:55:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <xmqq7drbbcj5.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/10/2020 21:10, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> My initial impression after seeing the recent report about ORIG_HEAD
> was "hmph, these days, rebasing is done on detached HEAD and the
> final step updates the target branch only once, so @{1} is much
> easier to use---perhaps it is time to deprecate use of ORIG_HEAD?".
> After all, ORIG_HEAD was invented way before we had reflog, and
> given that one of the goal of reflog was to give more general
> recovery mechanism than going back one-step like ORIG_HEAD allowed
> us to, and "rebase" were taught to work on detached HEAD to make
> @{1} more useful, it would not be too bad to eventually retire
> ORIG_HEAD in a distant future, I thought.

Thanks for filling in the history. As reset sets ORIG_HEAD as well as 
rebase it can be confusing so retiring it in the future maybe a good idea.

> But it is a good initiative anyway to make ORIG_HEAD again work as
> documented.  Thanks for working on it.
> 
>> After rebasing ORIG_HEAD is supposed to point to the old HEAD of the
> 
> A comma after "rebasing".

Sure

>> rebased branch. Unfortunately the buffer storing the oid was
>> overwritten with a new oid before ORIG_HEAD was created. The buffer is
>> also used when writing .git/rebase-merge/orig-head which is used by
>> `rebase --abort` to restore the previous head. Luckily that file is
>> written before the buffer is overwritten.  As we want the full oid
>> find_unique_abbrev() is replaced with oid_to_hex_r() rather than
>> find_unique_abbrev_r().
> 
> The above is hard to read and understand.  It is unclear where the
> observation of the current behaviour (which is often the explanation
> of the cause of the bug) ends and the description of new behaviour
> begins.
> 
>      ... old HEAD of the rebased branch.  The code used
>      find_unique_abbrev() to obtain the object name of the old HEAD
>      and wrote to both .git/rebase-merge/orig-head (used by `rebase
>      --abort` to go back to the previous state) and to ORIG_HEAD.
>      The buffer find_unique_abbrev() gives back is volatile,
>      unfortunately, and was overwritten after the former file is
>      written but before ORIG_FILE is written, leaving an incorrect
>      object name in it.
> 
> Up to that point is the observation of the current code, which
> explains where the bug comes from.  Please have a paragraph break
> after that, before explaining the solution, e.g.
> 
>      Avoid relying on the volatile buffer of find_unique_abbrev(),
>      and instead supply our own buffer to keep the object name.
>      Because we want to use the full object name, use oid_to_hex_r()
>      instead of find_unique_abbrev_r() to do so.

That's much clearer thanks. I wonder if swapping to oid_to_hex_r() 
rather than find_unique_abbev_r() is complicating this commit 
unnecessarily as the code that is changed here is deleted in patch 4, 
maybe we should do the switch there.

>> I think that all of the users of head_hash should actually be using
>> opts->orig_head instead as passing a string rather than a struct
>> object_id around is a hang over from the scripted implementation. This
>> patch just fixes the immediate bug and adds a regression test based on
>> Caspar's reproduction example. The users will be converted to use
>> struct object_id and head_hash removed in the next few commits.
> 
> Makes sense.
> 
>>
>> Reported-by: Caspar Duregger <herr.kaste@gmail.com>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
> 
> If you cite "Caspar's repro example" like that in the log message,
> it is incomplete to leave out a URL to the mail archive.

Good point I'll add a url

Thanks for your comments

Phillip

>>   builtin/rebase.c              | 10 +++++-----
>>   t/t3404-rebase-interactive.sh | 11 +++++++++++
>>   2 files changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/builtin/rebase.c b/builtin/rebase.c
>> index eeca53382f..6def28a533 100644
>> --- a/builtin/rebase.c
>> +++ b/builtin/rebase.c
>> @@ -270,15 +270,15 @@ static int edit_todo_file(unsigned flags)
>>   }
>>   
>>   static int get_revision_ranges(struct commit *upstream, struct commit *onto,
>> -			       struct object_id *orig_head, const char **head_hash,
>> +			       struct object_id *orig_head, char *head_hash,
>>   			       char **revisions, char **shortrevisions)
>>   {
>>   	struct commit *base_rev = upstream ? upstream : onto;
>>   	const char *shorthead;
>>   
>> -	*head_hash = find_unique_abbrev(orig_head, GIT_MAX_HEXSZ);
>> +	oid_to_hex_r(head_hash, orig_head);
>>   	*revisions = xstrfmt("%s...%s", oid_to_hex(&base_rev->object.oid),
>> -						   *head_hash);
>> +						   head_hash);
>>   
>>   	shorthead = find_unique_abbrev(orig_head, DEFAULT_ABBREV);
>>   
>> @@ -327,7 +327,7 @@ static void split_exec_commands(const char *cmd, struct string_list *commands)
>>   static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
>>   {
>>   	int ret;
>> -	const char *head_hash = NULL;
>> +	char head_hash[GIT_MAX_HEXSZ];
>>   	char *revisions = NULL, *shortrevisions = NULL;
>>   	struct strvec make_script_args = STRVEC_INIT;
>>   	struct todo_list todo_list = TODO_LIST_INIT;
>> @@ -335,7 +335,7 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
>>   	struct string_list commands = STRING_LIST_INIT_DUP;
>>   
>>   	if (get_revision_ranges(opts->upstream, opts->onto, &opts->orig_head,
>> -				&head_hash, &revisions, &shortrevisions))
>> +				head_hash, &revisions, &shortrevisions))
>>   		return -1;
>>   
>>   	if (init_basic_state(&replay,
>> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
>> index 07a1617351..1e56696e4f 100755
>> --- a/t/t3404-rebase-interactive.sh
>> +++ b/t/t3404-rebase-interactive.sh
>> @@ -1797,6 +1797,17 @@ test_expect_success 'todo has correct onto hash' '
>>   	test_i18ngrep "^# Rebase ..* onto $onto" actual
>>   '
>>   
>> +test_expect_success 'ORIG_HEAD is updated correctly' '
>> +	test_when_finished "git checkout master && git branch -D test-orig-head" &&
>> +	git checkout -b test-orig-head A &&
>> +	git commit --allow-empty -m A1 &&
>> +	git commit --allow-empty -m A2 &&
>> +	git commit --allow-empty -m A3 &&
>> +	git commit --allow-empty -m A4 &&
>> +	git rebase master &&
>> +	test_cmp_rev ORIG_HEAD test-orig-head@{1}
>> +'
>> +
>>   # This must be the last test in this file
>>   test_expect_success '$EDITOR and friends are unchanged' '
>>   	test_editor_unchanged

