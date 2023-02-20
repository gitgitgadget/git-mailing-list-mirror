Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA76BC636CC
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 09:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjBTJZG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 04:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjBTJZF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 04:25:05 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A0E10A8A
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 01:25:02 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id c17so1905385wrx.0
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 01:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AnUtGNpiIS7JFtwmBtEMmQ1HkWL79Lz51h4VNZrQFqw=;
        b=iWeMKnLBqp3H4btrSvqvp6tuwGE2EicxrEuYa5lmtuyG4U9F/+pFd9ksXQnBIhcFO3
         mHaxUQpyZ0eqqjXCjV/oY5VyZdhR3txJ/b+0aYYsRP5DbpjfFdDtwcxC0uMt67rFY3bL
         hkd2swVKHyPKPdNwOrOTZooTmqIa0Fe3hR2u8pCVN71qRNXNwtPh49M4xU7+GSVrRuqQ
         jEwvJR41eJkpIjMlX4zqFvpyHP+E5hSWX0JGFTSIXc0pKicpY/QPC33JWRI2KDE0ZQVb
         uM8I6t0PtuXnxoI4k9cKeF/D4VW6HM3cr8PiEaUKZ/DrwxtVOEWfspVy5w5Sj8j15qpo
         sdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnUtGNpiIS7JFtwmBtEMmQ1HkWL79Lz51h4VNZrQFqw=;
        b=6Uy7R2/nZ90ycH+jE5Lz8bYhWAiukJjxcOaEi1jLp/d9NU3+mKqsXVoy5agjvl+8Us
         as8Yt3mvxttUuXmPsnLZ+a8Zq4d7tVCHYboQYTk3kp9HBROgcYh3n9x+Pg2MDFK203lj
         U6i4MWfWpWbAHUHjrXiOgxXeIKTjo5MHhJD5/Lx5FWofJS+hlcKP/HCQONuruba2EbRr
         nLj2pdOQbG1LKbTZ8wnCQILMA74YUItyCQG3lXvZpLtTbkuazJU2tjiSWuit1DqJBm7j
         941kxniYs/gfoU6nY3KfCw+/m1b/WsTrOlSu00NJnxUPkgcjsxo5zcekeEP42JJqc2FS
         Z2KQ==
X-Gm-Message-State: AO0yUKXqm++aWR3SK7mLLsu4ryORAO739gFmmzHQjfojXyDTl3zpS4N3
        WrnJvw3AtSAvnl8uJRL4t9Q=
X-Google-Smtp-Source: AK7set+1GnP7yJfyZHqXYrCs3Dpa0Pw91uDBRJBMaboM3G7ubnOPmb+bXuWAug0UfV3GAQfN4Dzpug==
X-Received: by 2002:a5d:5610:0:b0:2c5:8dac:fc5c with SMTP id l16-20020a5d5610000000b002c58dacfc5cmr1084597wrv.2.1676885101208;
        Mon, 20 Feb 2023 01:25:01 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id s5-20020adfeb05000000b002c54c0a5aa9sm11852185wrn.74.2023.02.20.01.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 01:25:00 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <5a2a62cc-134c-adb0-7cab-c08c16c2dfdf@dunelm.org.uk>
Date:   Mon, 20 Feb 2023 09:24:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase -i: check labels and refs when parsing todo list
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1482.git.1676644675638.gitgitgadget@gmail.com>
 <0578e154-4c28-ffd9-03fc-5f9f5939cd17@github.com>
In-Reply-To: <0578e154-4c28-ffd9-03fc-5f9f5939cd17@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 17/02/2023 15:32, Derrick Stolee wrote:
> On 2/17/2023 9:37 AM, Phillip Wood via GitGitGadget wrote:
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Check that the argument to the "label" and "update-ref" commands is a
>> valid refname when the todo list is parsed rather than waiting until the
>> command is executed. This means that the user can deal with any errors
>> at the beginning of the rebase rather than having it stop halfway
>> through due to a typo in a label name.
> 
> Thanks for thinking about this user experience. This is a good
> improvement to the user interaction.
> 
>> The "update-ref" command is
>> changed to reject single level refs as it is all to easy to type
>> "update-ref branch" which is incorrect rather than "update-ref
>> refs/heads/branch"
> 
> I think it's good to start by adding the restriction in this
> check, but we could revisit this requirement in the future to
> see if it is worth allowing the user to drop "refs/heads/" and
> let it be implied. It just adds some complexity to the parsing,
> so this patch adds helpful scaffolding (in checks and tests)
> such that we could do that later in a safer way.
> 
>> +static int check_label_or_ref_arg(enum todo_command command, const char *arg)
>> +{
>> +	int allow_onelevel =
>> +		command == TODO_LABEL ? REFNAME_ALLOW_ONELEVEL : 0;
>> +
>> +	if ((command == TODO_LABEL && !strcmp(arg, "#")) ||
> 
> Interesting that "#" means something special for the label, and
> it's not limited to just the start of the label name, but must
> be the entire string. Is this not something that
> check_refname_format() would catch?

"#" is a valid refname, but the merge command uses it to separate the 
merge parents from the commit summary so it cannot be used as a label. 
It is rejected at the start of do_label() (arguably that check could be 
removed with this series but I'm tempted to leave it alone)

> Is the motivation that users
> might add what they think is a comment, such as:
> 
>    label # make a label here
> 
> but oddly, this doesn't include something strange like
> 
>    label #make a label here

I've actually got some patches based on this that add support for 
comments like this, but they are not the reason that "#" is forbidden as 
a label here.

>> +	    check_refname_format(arg, allow_onelevel)) {
>> +		if (command == TODO_LABEL)
>> +			error(_("'%s' is not a valid label"), arg);
> 
> If we have any kind of error and we are in TODO_LABEL, then
> we can use a label message. Good.
> 
>> +		else if (check_refname_format(arg, REFNAME_ALLOW_ONELEVEL))
>> +			error(_("'%s' is not a valid refname"), arg);
>> +		else
>> +			error(_("update-ref requires a fully qualified refname e.g. refs/heads/%s"),
>> +			      arg);
> 
> This took me a little while to grok, but I think I have it
> now: when in the update-ref mode, it could fail because of a
> one-level ref (the else case) or it could fail because the
> ref name uses forbidden characters (the else if case).
> 
> This nesting of conditions seems a bit fragile if we were to
> add a new todo_command to check here. Perhaps reorganize it
> to switch on the command?
> 
> 	switch (command) {
> 	case TODO_LABEL:
> 		if (!strcmp(arg, "#") ||
> 		    check_refname_format(arg, REFNAME_ALLOW_ONELEVEL))
> 			return error(_("'%s' is not a valid label", arg);
> 		break;
> 
> 	case TODO_UPDATE_REF:
> 		if (check_refname_format(arg, REFNAME_ALLOW_ONELEVEL))
> 			return error(_("'%s' is not a valid refname"), arg);
> 		else if (check_refname_format(arg, 0))
> 			return error(_("update-ref reqruies a fully qualified refname (e.g. refs/heads/%s)",
> 				     arg);
> 		break;
> 
> 	default:
> 		BUG("unexpected todo_command");
> 	}
> 
> 	return 0;

That's definitely clearer, thanks for the suggestion

>> @@ -2523,8 +2543,23 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
>>   		return error(_("missing arguments for %s"),
>>   			     command_to_string(item->command));
>>   
>> -	if (item->command == TODO_EXEC || item->command == TODO_LABEL ||
>> +	if (item->command == TODO_LABEL ||
>>   	    item->command == TODO_RESET || item->command == TODO_UPDATE_REF) {
>> +		int ret = 0;
>> +
>> +		item->commit = NULL;
>> +		item->arg_offset = bol - buf;
>> +		item->arg_len = (int)(eol - bol);
>> +		if (item->command != TODO_RESET) {
>> +			saved = *eol;
>> +			*eol = '\0';
>> +			ret = check_label_or_ref_arg(item->command, bol);
>> +			*eol = saved;
>> +		}
>> +		return ret;
>> +	}
>> +
>> +	if (item->command == TODO_EXEC) {
>>   		item->commit = NULL;
>>   		item->arg_offset = bol - buf;
>>   		item->arg_len = (int)(eol - bol);
> 
> (What's missing from this context is "return 0;")
> 
> Is there an important reason why you separated TODO_EXEC and
> its identical item->arg_(offset|len) parsing into its own
> block?

In a word no! This patch was pulled out from the series I mentioned 
above that adds support for comments. There it makes sense to treat exec 
commands separately as they cannot have comments but you're right that 
there is no need to do that in this patch.

> It seems like we could modify your change to look like
> this:
> 
> 
> 	if (item->command == TODO_EXEC || item->command == TODO_LABEL ||
>    	    item->command == TODO_RESET || item->command == TODO_UPDATE_REF) {
> 		int ret = 0;
> 
> 		item->commit = NULL;
> 		item->arg_offset = bol - buf;
> 		item->arg_len = (int)(eol - bol);
> 		if (item->command == TODO_RESET ||
> 		    item->command == TODO_UPDATE_REF) {
> 			saved = *eol;
> 			*eol = '\0';
> 			ret = check_label_or_ref_arg(item->command, bol);
> 			*eol = saved;
> 		}
> 		return ret;
> 	}
> 
> and the diff will have fewer new lines as well as fewer
> duplicate lines in the post-image. Am I missing something
> about TODO_EXEC being special?

I'll update as you suggest

>> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
>> index 462cefd25df..2cf2d2b8a24 100755
>> --- a/t/t3404-rebase-interactive.sh
>> +++ b/t/t3404-rebase-interactive.sh
>> @@ -2120,7 +2120,30 @@ test_expect_success '--update-refs: check failed ref update' '
>>   	tail -n 6 err >err.last &&
>>   	sed -e "s/Rebasing.*Successfully/Successfully/g" -e "s/^\t//g" \
>>   		<err.last >err.trimmed &&
>> -	test_cmp expect err.trimmed
>> +	test_cmp expect err.trimmed &&
>> +	git rebase --abort
>> +'
> 
> Perhaps this `git rebase --abort` should be part of a
> `test_when_finished test_may_fail git rebase --abort` at
> the start of the test so that your new test can succeed
> even if an earlier test step caused the test to fail.

That's a good idea (and for the next test as well)

Thanks for you're thoughtful comments and suggestions

Best Wishes

Phillip

>> +test_expect_success 'bad labels and refs rejected when parsing todo list' '
>> +	cat >todo <<-\EOF &&
>> +	exec >execed
>> +	label #
>> +	label :invalid
>> +	update-ref :bad
>> +	update-ref topic
>> +	EOF
>> +	rm -f execed &&
>> +	(
>> +		set_replace_editor todo &&
>> +		test_must_fail git rebase -i HEAD 2>err
>> +	) &&
>> +	grep "'\''#'\'' is not a valid label" err &&
>> +	grep "'\'':invalid'\'' is not a valid label" err &&
>> +	grep "'\'':bad'\'' is not a valid refname" err &&
>> +	grep "update-ref requires a fully qualified refname e.g. refs/heads/topic" \
>> +		err &&
>> +	test_path_is_missing execed &&
>> +	git rebase --abort
>>   '
> 
> Again, the `git rebase --abort` seems like protection for
> future tests, so a test_when_finished would help.
> 
> Thanks,
> -Stolee
