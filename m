Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0CDC7618E
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 20:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbjDUUA7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 16:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbjDUUAx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 16:00:53 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D517D2D5A
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 13:00:50 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f18335a870so14426585e9.0
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 13:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682107249; x=1684699249;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ici5oTN4iZg7eiCipMOho7IZW0JMN+fd5FObiOVsdp0=;
        b=aQM3fvgMuEO/BwWxDkXgp/7Q03hZ9kSXpFU5ZE1MCs2YAcWkqqhUv2CqQVfwni3tjt
         BbKl/+QQOI6zg2fUulLL4M56Dm17L6NYxB/y7Nda3pUP1CuaM1HTxrP5ctuMoPXflM0w
         i9D+EVmDiS15FKk1B3E58WhxSZUCKavb1/+NXHhrlEsSp+1plYWBisxHuZx5bHq9lIsK
         nPI6DymhXQBCP5u/Kbn9eHgCy7xoXXNx0z28oFLZCEfhbvEs7TI3Ia+5rL6vUQfKD081
         swRjSMCS2a7dgM0/egoXeyRmEI5ug09EiZ9VhH29hI6lVWjDMYDMPeLJ3Vye8SPINAs9
         qEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682107249; x=1684699249;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ici5oTN4iZg7eiCipMOho7IZW0JMN+fd5FObiOVsdp0=;
        b=kvVuju4L0x09fyRQLlTdoR1+ur0Yb+7tiolw/oZf82ygk+9HcB+I46whG1Y/wvy9+C
         6CPS076A/LfVPZx0AcEoKcAo9AeJ6o9cI1xXAzaX1SeZ3I6Uo2oe2u3PVLPQbLWdvnWY
         h92zP52c2kEuUyMxe3z37uOfwLOaGxMik4wTQWLXgWYCwqNM//Q/8o7IneHyT66WMGv5
         9FDHr9NTL086tCsSJqmDYk/+FVY2GS1/SgtYjW0+wliILx7rvSBmCNmdxN+/70imzde9
         9Nr4XEXWrpy/Q6PJhpZNzX60CIzEzHT0/SQae5KCXlKFQwnTIzxpI/DkVTdspfZgiRce
         JWuA==
X-Gm-Message-State: AAQBX9dTTGzbkORs+setFX5fj0OUgFvAraQmUpCsH/NsAeq7SiurTYxY
        WHAs6Kl2rnaSDUAQ3zjbP+hr+dlTWU8=
X-Google-Smtp-Source: AKy350aL4pc7XcLANXXUE9DRIp5JBLNimhI+rrnwCeU8aYnNhTC3Gh0WcsnUFzaQle6HhyDECaq9AA==
X-Received: by 2002:a7b:ce87:0:b0:3f1:7277:eaa with SMTP id q7-20020a7bce87000000b003f172770eaamr2784258wmj.31.1682107249244;
        Fri, 21 Apr 2023 13:00:49 -0700 (PDT)
Received: from [192.168.1.212] ([90.255.142.254])
        by smtp.gmail.com with ESMTPSA id f3-20020adfdb43000000b002efb2d861dasm5066200wrj.77.2023.04.21.13.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 13:00:48 -0700 (PDT)
Message-ID: <049a792d-e015-3583-452d-923b9aee4a72@gmail.com>
Date:   Fri, 21 Apr 2023 21:00:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/6] sequencer: factor out part of pick_commits()
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
 <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
 <31bb644e769a085bd2db97cdb5aae78729efc52d.1682089075.git.gitgitgadget@gmail.com>
 <xmqqpm7xjam2.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqpm7xjam2.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 21/04/2023 20:31, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> This is simplifies a change in a later commit. If a pick fails we now
>> return the error at then end of the loop body rather than returning
>> early but there is no change in behavior.
> 
> The new pick_one_commit() function is pretty much verbatim copy/move
> from inside the "any command below SQUASH" block, and in the
> original code, the block returned with an error whenever res is not
> 0, with one exception that TODO_EDIT would return with 0 if there is
> no error (but still with a patch).
> 
> The new code that calls pick_one_commit() helper lets this exception
> case to return from the function in the "any command below SQUASH"
> block, but everything else falls through *and* eventually at the end
> of the outer block there is
> 
> 	if (res)
> 		return res;
> 
> that makes us return from the function.
> 
> But there are now a few other things done after the if/else if/else
> cascade, namely
> 
>   * there is an extra "if (reschedule)" and "else if (rebase-i) etc"
>     logic.

There are two blocks that might be entered. One guarded by "if 
(reschedule)" - this is not entered because reschedlue is always zero 
when picking a commit. The other is guarded by "else if 
(is_rebase_i(opts) && check_todo && !res)" and so will not be entered 
when we want to return an error because "res" is non-zero in that case.

Best Wishes

Phillip
>   * the todo_list->current counter is incremented
> 
> are done BEFORE that "if res is not zero return".  I am not sure we
> can safely claim "there is no change in behaviour".
> 
> Am I missing something?
> 
> Thanks.
> 
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   sequencer.c | 129 ++++++++++++++++++++++++++++------------------------
>>   1 file changed, 69 insertions(+), 60 deletions(-)
>>
>> diff --git a/sequencer.c b/sequencer.c
>> index c4a548f2c98..2d463818dd1 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -4628,6 +4628,72 @@ N_("Could not execute the todo command\n"
>>   "    git rebase --edit-todo\n"
>>   "    git rebase --continue\n");
>>   
>> +static int pick_one_commit(struct repository *r,
>> +			   struct todo_list *todo_list,
>> +			   struct replay_opts *opts,
>> +			   int *check_todo)
>> +{
>> +	int res;
>> +	struct todo_item *item = todo_list->items + todo_list->current;
>> +	const char *arg = todo_item_get_arg(todo_list, item);
>> +	if (is_rebase_i(opts))
>> +		opts->reflog_message = reflog_message(
>> +			opts, command_to_string(item->command), NULL);
>> +
>> +	res = do_pick_commit(r, item, opts, is_final_fixup(todo_list),
>> +			     check_todo);
>> +	if (is_rebase_i(opts) && res < 0) {
>> +		/* Reschedule */
>> +		advise(_(rescheduled_advice),
>> +		       get_item_line_length(todo_list, todo_list->current),
>> +		       get_item_line(todo_list, todo_list->current));
>> +		todo_list->current--;
>> +		if (save_todo(todo_list, opts))
>> +			return -1;
>> +	}
>> +	if (item->command == TODO_EDIT) {
>> +		struct commit *commit = item->commit;
>> +		if (!res) {
>> +			if (!opts->verbose)
>> +				term_clear_line();
>> +			fprintf(stderr, _("Stopped at %s...  %.*s\n"),
>> +				short_commit_name(commit), item->arg_len, arg);
>> +		}
>> +		return error_with_patch(r, commit,
>> +					arg, item->arg_len, opts, res, !res);
>> +	}
>> +	if (is_rebase_i(opts) && !res)
>> +		record_in_rewritten(&item->commit->object.oid,
>> +				    peek_command(todo_list, 1));
>> +	if (res && is_fixup(item->command)) {
>> +		if (res == 1)
>> +			intend_to_amend();
>> +		return error_failed_squash(r, item->commit, opts,
>> +					   item->arg_len, arg);
>> +	} else if (res && is_rebase_i(opts) && item->commit) {
>> +		int to_amend = 0;
>> +		struct object_id oid;
>> +
>> +		/*
>> +		 * If we are rewording and have either
>> +		 * fast-forwarded already, or are about to
>> +		 * create a new root commit, we want to amend,
>> +		 * otherwise we do not.
>> +		 */
>> +		if (item->command == TODO_REWORD &&
>> +		    !repo_get_oid(r, "HEAD", &oid) &&
>> +		    (oideq(&item->commit->object.oid, &oid) ||
>> +		     (opts->have_squash_onto &&
>> +		      oideq(&opts->squash_onto, &oid))))
>> +			to_amend = 1;
>> +
>> +		return res | error_with_patch(r, item->commit,
>> +					      arg, item->arg_len, opts,
>> +					      res, to_amend);
>> +	}
>> +	return res;
>> +}
>> +
>>   static int pick_commits(struct repository *r,
>>   			struct todo_list *todo_list,
>>   			struct replay_opts *opts)
>> @@ -4683,66 +4749,9 @@ static int pick_commits(struct repository *r,
>>   			}
>>   		}
>>   		if (item->command <= TODO_SQUASH) {
>> -			if (is_rebase_i(opts))
>> -				opts->reflog_message = reflog_message(opts,
>> -				      command_to_string(item->command), NULL);
>> -
>> -			res = do_pick_commit(r, item, opts,
>> -					     is_final_fixup(todo_list),
>> -					     &check_todo);
>> -			if (is_rebase_i(opts) && res < 0) {
>> -				/* Reschedule */
>> -				advise(_(rescheduled_advice),
>> -				       get_item_line_length(todo_list,
>> -							    todo_list->current),
>> -				       get_item_line(todo_list,
>> -						     todo_list->current));
>> -				todo_list->current--;
>> -				if (save_todo(todo_list, opts))
>> -					return -1;
>> -			}
>> -			if (item->command == TODO_EDIT) {
>> -				struct commit *commit = item->commit;
>> -				if (!res) {
>> -					if (!opts->verbose)
>> -						term_clear_line();
>> -					fprintf(stderr,
>> -						_("Stopped at %s...  %.*s\n"),
>> -						short_commit_name(commit),
>> -						item->arg_len, arg);
>> -				}
>> -				return error_with_patch(r, commit,
>> -					arg, item->arg_len, opts, res, !res);
>> -			}
>> -			if (is_rebase_i(opts) && !res)
>> -				record_in_rewritten(&item->commit->object.oid,
>> -					peek_command(todo_list, 1));
>> -			if (res && is_fixup(item->command)) {
>> -				if (res == 1)
>> -					intend_to_amend();
>> -				return error_failed_squash(r, item->commit, opts,
>> -					item->arg_len, arg);
>> -			} else if (res && is_rebase_i(opts) && item->commit) {
>> -				int to_amend = 0;
>> -				struct object_id oid;
>> -
>> -				/*
>> -				 * If we are rewording and have either
>> -				 * fast-forwarded already, or are about to
>> -				 * create a new root commit, we want to amend,
>> -				 * otherwise we do not.
>> -				 */
>> -				if (item->command == TODO_REWORD &&
>> -				    !repo_get_oid(r, "HEAD", &oid) &&
>> -				    (oideq(&item->commit->object.oid, &oid) ||
>> -				     (opts->have_squash_onto &&
>> -				      oideq(&opts->squash_onto, &oid))))
>> -					to_amend = 1;
>> -
>> -				return res | error_with_patch(r, item->commit,
>> -						arg, item->arg_len, opts,
>> -						res, to_amend);
>> -			}
>> +			res = pick_one_commit(r, todo_list, opts, &check_todo);
>> +			if (!res && item->command == TODO_EDIT)
>> +				return 0;
>>   		} else if (item->command == TODO_EXEC) {
>>   			char *end_of_arg = (char *)(arg + item->arg_len);
>>   			int saved = *end_of_arg;
