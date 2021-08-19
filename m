Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1590C4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 10:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C019661101
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 10:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237862AbhHSKKG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 06:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbhHSKKF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 06:10:05 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F039C061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 03:09:29 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q10so8245636wro.2
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 03:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CdKmrNkYc+lmlMCm8ZZiZ+8mN1WTh0h4qCfzGA7UbSs=;
        b=ozI6I7KanQhTO1uYTydj+/pT8R7md7ED3ZV0MVbKscL0ecCp2LmWetCLUqR3WpEeY4
         phce/y3cYPFMflRTrNjLQcQS7sfh+1y9dvaYhd9yezDtBi83GFa7iIGNCUrh9gw6u7l0
         8C8sNJbC0ZnKOE5BSoSCNlVaqXSp6b6hl/LjyTdWwzpPKJOYIbpCK2e95pf5mmkozfsH
         XI+4eoJqYEKhbLGdYDXGaXSIkPEDW0Y6i6RgX5z7d19v3l28NTqy8brwVO8UxMkXueSi
         Zg7Ou4rZMfEuP3scW7DR+B5gtUXcsPwd0LWpaDlR+rdo34W7ukXRIE1uoqfUUhTMtdtI
         sfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CdKmrNkYc+lmlMCm8ZZiZ+8mN1WTh0h4qCfzGA7UbSs=;
        b=i1icJL4Cda1Uig2P4FwcagE6WEI7e5ieyustYR6H/uo6//W4WSf4q0MHaMXSNGnbOc
         sQQ2YvUiBKd2oxqXuuZcqXZbkSf5/0unszQCTGMkX8WDnRGjBYnFmSbjVBB6M10n2ojx
         DoB/3hCaPCWF+q6NUBrSbRWbcBcjBXaR6WkQS0HA1TbHTeHK6+oeQtFLEsXO35MpdVRM
         lS29OEv5XwdhekXrbb+amT3pW/ZGzPH0z58ir+VzaDzMy/TSB0S7+sIxqTtGHvmlaCF3
         eaOWv8dxDzJM8PebxPKERnbQeA4xvzEtMRr6ZP5m31UTcOL7DS9YHmvuEiITzQqZRH9t
         WSzw==
X-Gm-Message-State: AOAM5325wNFsKPLf+WaqVx5lmLfgZ+gUVHOwm8eGG2vyUlD5B/A3Pe/S
        Yy2YXg+Jr17OsbBSRRTn9VQ=
X-Google-Smtp-Source: ABdhPJwkOk8qIvRvMNZH3K3Ys0LZzDoaaSo22OzCjUlf76FTPbyHvvgfGYVl+kd95fZxQ1HAeFb5VA==
X-Received: by 2002:a5d:634a:: with SMTP id b10mr2844461wrw.305.1629367767788;
        Thu, 19 Aug 2021 03:09:27 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.144])
        by smtp.googlemail.com with ESMTPSA id v1sm2378182wrt.93.2021.08.19.03.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 03:09:27 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/4] rebase -r: don't write .git/MERGE_MSG when
 fast-forwarding
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1015.git.1628860053.gitgitgadget@gmail.com>
 <01d5ed4cba04d69e484d2c040635632df914bfa6.1628860053.git.gitgitgadget@gmail.com>
 <20210817172609.GB2257957@szeder.dev>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <49aba79b-14ed-cee0-4e4c-1f98306f1b45@gmail.com>
Date:   Thu, 19 Aug 2021 11:09:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210817172609.GB2257957@szeder.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/08/2021 18:26, SZEDER Gábor wrote:
> On Fri, Aug 13, 2021 at 01:07:32PM +0000, Phillip Wood via GitGitGadget wrote:
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> When fast-forwarding we do not create a new commit so .git/MERGE_MSG
>> is not removed and can end up seeding the message of a commit made
>> after the rebase has finished. Avoid writing .git/MERGE_MSG when we
>> are fast-forwarding by writing the file after the fast-forward
>> checks.
>>
>> Note that the way this change is implemented means we no longer write
>> the author script when fast-forwarding either. I believe this is safe
>> for the reasons below but it is a departure from what we do when
>> fast-forwarding a non-merge commit. If we reword the merge then 'git
>> commit --amend' will keep the authorship of the commit we're rewording
>> as it ignores GIT_AUTHOR_* unless --reset-author is passed. It will
>> also export the correct GIT_AUTHOR_* variables to any hooks and we
>> already test the authorship of the reworded commit. If we are not
>> rewording then we no longer call spilt_ident() which means we are no
>> longer checking the commit author header looks sane. However this is
>> what we already do when fast-forwarding non-merge commits in
>> skip_unnecessary_picks() so I don't think we're breaking any promises
>> by not checking the author here.
> 
> Thanks you for fixing this bug.
> 
> FWIW (not that much, I'm afraid), I think your reasoning about the
> harmlessness of the behavior change concerning the author script makes
> sense.
> 
> My only nit is that the movement of a ~40 lines block of code makes
> out the bulk of the patch; perhaps it would be worth mentioning it
> explicitly in the commit message, so future readers of this commit
> won't look for changes in those hunks.

Thanks for reading through the patch, I take your point about the code 
movement and will add a comment (I have --color-moved turned on by 
default and tend to forget others may not)

Best Wishes

Phillip

>> Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   sequencer.c     | 81 +++++++++++++++++++++++++------------------------
>>   t/lib-rebase.sh | 10 ++++--
>>   2 files changed, 49 insertions(+), 42 deletions(-)
>>
>> diff --git a/sequencer.c b/sequencer.c
>> index cc8a361cceb..c2cba5ed4b1 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -983,7 +983,8 @@ static int run_git_commit(const char *defmsg,
>>   
>>   	cmd.git_cmd = 1;
>>   
>> -	if (is_rebase_i(opts) && read_env_script(&cmd.env_array)) {
>> +	if (is_rebase_i(opts) && !(!defmsg && (flags & AMEND_MSG)) &&
>> +	    read_env_script(&cmd.env_array)) {
>>   		const char *gpg_opt = gpg_sign_opt_quoted(opts);
>>   
>>   		return error(_(staged_changes_advice),
>> @@ -3815,6 +3816,45 @@ static int do_merge(struct repository *r,
>>   		goto leave_merge;
>>   	}
>>   
>> +	/*
>> +	 * If HEAD is not identical to the first parent of the original merge
>> +	 * commit, we cannot fast-forward.
>> +	 */
>> +	can_fast_forward = opts->allow_ff && commit && commit->parents &&
>> +		oideq(&commit->parents->item->object.oid,
>> +		      &head_commit->object.oid);
>> +
>> +	/*
>> +	 * If any merge head is different from the original one, we cannot
>> +	 * fast-forward.
>> +	 */
>> +	if (can_fast_forward) {
>> +		struct commit_list *p = commit->parents->next;
>> +
>> +		for (j = to_merge; j && p; j = j->next, p = p->next)
>> +			if (!oideq(&j->item->object.oid,
>> +				   &p->item->object.oid)) {
>> +				can_fast_forward = 0;
>> +				break;
>> +			}
>> +		/*
>> +		 * If the number of merge heads differs from the original merge
>> +		 * commit, we cannot fast-forward.
>> +		 */
>> +		if (j || p)
>> +			can_fast_forward = 0;
>> +	}
>> +
>> +	if (can_fast_forward) {
>> +		rollback_lock_file(&lock);
>> +		ret = fast_forward_to(r, &commit->object.oid,
>> +				      &head_commit->object.oid, 0, opts);
>> +		if (flags & TODO_EDIT_MERGE_MSG)
>> +			goto fast_forward_edit;
>> +
>> +		goto leave_merge;
>> +	}
>> +
>>   	if (commit) {
>>   		const char *encoding = get_commit_output_encoding();
>>   		const char *message = logmsg_reencode(commit, NULL, encoding);
>> @@ -3864,45 +3904,6 @@ static int do_merge(struct repository *r,
>>   		}
>>   	}
>>   
>> -	/*
>> -	 * If HEAD is not identical to the first parent of the original merge
>> -	 * commit, we cannot fast-forward.
>> -	 */
>> -	can_fast_forward = opts->allow_ff && commit && commit->parents &&
>> -		oideq(&commit->parents->item->object.oid,
>> -		      &head_commit->object.oid);
>> -
>> -	/*
>> -	 * If any merge head is different from the original one, we cannot
>> -	 * fast-forward.
>> -	 */
>> -	if (can_fast_forward) {
>> -		struct commit_list *p = commit->parents->next;
>> -
>> -		for (j = to_merge; j && p; j = j->next, p = p->next)
>> -			if (!oideq(&j->item->object.oid,
>> -				   &p->item->object.oid)) {
>> -				can_fast_forward = 0;
>> -				break;
>> -			}
>> -		/*
>> -		 * If the number of merge heads differs from the original merge
>> -		 * commit, we cannot fast-forward.
>> -		 */
>> -		if (j || p)
>> -			can_fast_forward = 0;
>> -	}
>> -
>> -	if (can_fast_forward) {
>> -		rollback_lock_file(&lock);
>> -		ret = fast_forward_to(r, &commit->object.oid,
>> -				      &head_commit->object.oid, 0, opts);
>> -		if (flags & TODO_EDIT_MERGE_MSG)
>> -			goto fast_forward_edit;
>> -
>> -		goto leave_merge;
>> -	}
>> -
>>   	if (strategy || to_merge->next) {
>>   		/* Octopus merge */
>>   		struct child_process cmd = CHILD_PROCESS_INIT;
>> diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
>> index 99d9e7efd2d..ec6b9b107da 100644
>> --- a/t/lib-rebase.sh
>> +++ b/t/lib-rebase.sh
>> @@ -173,10 +173,16 @@ set_reword_editor () {
>>   
>>   	write_script reword-editor.sh <<-EOF &&
>>   	# Save the oid of the first reworded commit so we can check rebase
>> -	# fast-forwards to it
>> +	# fast-forwards to it. Also check that we do not write .git/MERGE_MSG
>> +	# when fast-forwarding
>>   	if ! test -s reword-oid
>>   	then
>> -		git rev-parse HEAD >reword-oid
>> +		git rev-parse HEAD >reword-oid &&
>> +		if test -f .git/MERGE_MSG
>> +		then
>> +			echo 1>&2 "error: .git/MERGE_MSG exists"
>> +			exit 1
>> +		fi
>>   	fi &&
>>   	# There should be no uncommited changes
>>   	git diff --exit-code HEAD &&
>> -- 
>> gitgitgadget
>>

