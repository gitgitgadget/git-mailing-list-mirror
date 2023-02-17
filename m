Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A71C05027
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 15:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjBQPcx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 10:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjBQPcw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 10:32:52 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A0E55BD
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 07:32:50 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id bc7so1011638qtb.0
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 07:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F06AYwQNXjkCOhBfXBjnVFUIZkfYFftyNUv3u24ZWrk=;
        b=HJa/5sZ7qP+KnYWJUNTaYuYLnAAsRMlvhkRnX266AQ7y/ZDAlUOCSGiz/Ru2CGarFf
         D8PY8y25q0O4hztp11iSBXQ4a0kxnqrrtCpoa2xdinJzWXn/fX08zEbfek5o9Um7PFJt
         KnVd4MqAalLY6E2wRJhPEt5TzO+Xqyb1RYdrfGNSg8JSPh2CjNzy7Mfl4a3RCZhPxsFS
         Y7CCBChg4KPfl77XVnqdniEKKkD/NoC1aYkJecT/wdBdaBNcr4HLZ+HpFOZWsQ6aRvG3
         4lkLiVKvs1SL6346a8DuPPbsdOArd5mjd+LLce2fZQW7Ozy4yUgTgS/bMgMQF1x2H5tp
         lL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F06AYwQNXjkCOhBfXBjnVFUIZkfYFftyNUv3u24ZWrk=;
        b=HdWIzv9Z9w+EZ6sv5QhojKOwDl6oxCRFOEGhBSFxwzqfpyyebYzw4qoXnETv3GsZ+O
         VLePdEAw1xLXakVaeN0k7SDZI8LFb2FHtwcL1xaKuHAadNLbZBW1inTvwwDNFoxnWEve
         aoTxPm910ZQJmSSUEWgw9pDGjbvNRMIhlJPKl53PXB2fPlMCL9X0Z7eOvJJH70ULdfGR
         OMqNxeaOVt1PAlDlcJ/wpjwylmThslga7jAttKVQbr74g7Kpvgfa5zF6MUnfXcEqzsXC
         pZfHNFYaVz7k8W4N2S1DfcVoo9JwundeZGqR74YkFqoxz2E1kUs7h6Q/m9gkQ2CjCgtl
         MZSg==
X-Gm-Message-State: AO0yUKX51IsKnqC3iJ6kD20RWM8Ip90Y2/AgQM9Gbkam+SFm2Hn42hKI
        U2UEsZR1L+O8A4sIUZ7FCR/m
X-Google-Smtp-Source: AK7set9ONTSgfhnCcf1Ym9p6RN2Y8l5mfbPLioH+AfRqDJFlRqwGNRwLDG+/SvlAqbwlNmeclnd6Aw==
X-Received: by 2002:ac8:7f4a:0:b0:3b8:6d3a:5ec7 with SMTP id g10-20020ac87f4a000000b003b86d3a5ec7mr1684192qtk.22.1676647969085;
        Fri, 17 Feb 2023 07:32:49 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d845:6877:2daa:ccbf? ([2600:1700:e72:80a0:d845:6877:2daa:ccbf])
        by smtp.gmail.com with ESMTPSA id b14-20020ac801ce000000b003b880ef08acsm3369098qtg.35.2023.02.17.07.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 07:32:48 -0800 (PST)
Message-ID: <0578e154-4c28-ffd9-03fc-5f9f5939cd17@github.com>
Date:   Fri, 17 Feb 2023 10:32:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] rebase -i: check labels and refs when parsing todo list
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1482.git.1676644675638.gitgitgadget@gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1482.git.1676644675638.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/17/2023 9:37 AM, Phillip Wood via GitGitGadget wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> Check that the argument to the "label" and "update-ref" commands is a
> valid refname when the todo list is parsed rather than waiting until the
> command is executed. This means that the user can deal with any errors
> at the beginning of the rebase rather than having it stop halfway
> through due to a typo in a label name.

Thanks for thinking about this user experience. This is a good
improvement to the user interaction.

> The "update-ref" command is
> changed to reject single level refs as it is all to easy to type
> "update-ref branch" which is incorrect rather than "update-ref
> refs/heads/branch"

I think it's good to start by adding the restriction in this
check, but we could revisit this requirement in the future to
see if it is worth allowing the user to drop "refs/heads/" and
let it be implied. It just adds some complexity to the parsing,
so this patch adds helpful scaffolding (in checks and tests)
such that we could do that later in a safer way.

> +static int check_label_or_ref_arg(enum todo_command command, const char *arg)
> +{
> +	int allow_onelevel =
> +		command == TODO_LABEL ? REFNAME_ALLOW_ONELEVEL : 0;
> +
> +	if ((command == TODO_LABEL && !strcmp(arg, "#")) ||

Interesting that "#" means something special for the label, and
it's not limited to just the start of the label name, but must
be the entire string. Is this not something that
check_refname_format() would catch? Is the motivation that users
might add what they think is a comment, such as:

  label # make a label here

but oddly, this doesn't include something strange like

  label #make a label here

> +	    check_refname_format(arg, allow_onelevel)) {
> +		if (command == TODO_LABEL)
> +			error(_("'%s' is not a valid label"), arg);

If we have any kind of error and we are in TODO_LABEL, then
we can use a label message. Good.

> +		else if (check_refname_format(arg, REFNAME_ALLOW_ONELEVEL))
> +			error(_("'%s' is not a valid refname"), arg);
> +		else
> +			error(_("update-ref requires a fully qualified refname e.g. refs/heads/%s"),
> +			      arg);

This took me a little while to grok, but I think I have it
now: when in the update-ref mode, it could fail because of a
one-level ref (the else case) or it could fail because the
ref name uses forbidden characters (the else if case).

This nesting of conditions seems a bit fragile if we were to
add a new todo_command to check here. Perhaps reorganize it
to switch on the command?

	switch (command) {
	case TODO_LABEL:
		if (!strcmp(arg, "#") ||
		    check_refname_format(arg, REFNAME_ALLOW_ONELEVEL))
			return error(_("'%s' is not a valid label", arg);
		break;

	case TODO_UPDATE_REF:
		if (check_refname_format(arg, REFNAME_ALLOW_ONELEVEL))
			return error(_("'%s' is not a valid refname"), arg);
		else if (check_refname_format(arg, 0))
			return error(_("update-ref reqruies a fully qualified refname (e.g. refs/heads/%s)",
				     arg);
		break;

	default:
		BUG("unexpected todo_command");
	}

	return 0;

> @@ -2523,8 +2543,23 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
>  		return error(_("missing arguments for %s"),
>  			     command_to_string(item->command));
>  
> -	if (item->command == TODO_EXEC || item->command == TODO_LABEL ||
> +	if (item->command == TODO_LABEL ||
>  	    item->command == TODO_RESET || item->command == TODO_UPDATE_REF) {
> +		int ret = 0;
> +
> +		item->commit = NULL;
> +		item->arg_offset = bol - buf;
> +		item->arg_len = (int)(eol - bol);
> +		if (item->command != TODO_RESET) {
> +			saved = *eol;
> +			*eol = '\0';
> +			ret = check_label_or_ref_arg(item->command, bol);
> +			*eol = saved;
> +		}
> +		return ret;
> +	}
> +
> +	if (item->command == TODO_EXEC) {
>  		item->commit = NULL;
>  		item->arg_offset = bol - buf;
>  		item->arg_len = (int)(eol - bol);

(What's missing from this context is "return 0;")

Is there an important reason why you separated TODO_EXEC and
its identical item->arg_(offset|len) parsing into its own
block? It seems like we could modify your change to look like
this:


	if (item->command == TODO_EXEC || item->command == TODO_LABEL ||
  	    item->command == TODO_RESET || item->command == TODO_UPDATE_REF) {
		int ret = 0;

		item->commit = NULL;
		item->arg_offset = bol - buf;
		item->arg_len = (int)(eol - bol);
		if (item->command == TODO_RESET ||
		    item->command == TODO_UPDATE_REF) {
			saved = *eol;
			*eol = '\0';
			ret = check_label_or_ref_arg(item->command, bol);
			*eol = saved;
		}
		return ret;
	}

and the diff will have fewer new lines as well as fewer
duplicate lines in the post-image. Am I missing something
about TODO_EXEC being special?

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 462cefd25df..2cf2d2b8a24 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -2120,7 +2120,30 @@ test_expect_success '--update-refs: check failed ref update' '
>  	tail -n 6 err >err.last &&
>  	sed -e "s/Rebasing.*Successfully/Successfully/g" -e "s/^\t//g" \
>  		<err.last >err.trimmed &&
> -	test_cmp expect err.trimmed
> +	test_cmp expect err.trimmed &&
> +	git rebase --abort
> +'

Perhaps this `git rebase --abort` should be part of a
`test_when_finished test_may_fail git rebase --abort` at
the start of the test so that your new test can succeed
even if an earlier test step caused the test to fail.

> +test_expect_success 'bad labels and refs rejected when parsing todo list' '
> +	cat >todo <<-\EOF &&
> +	exec >execed
> +	label #
> +	label :invalid
> +	update-ref :bad
> +	update-ref topic
> +	EOF
> +	rm -f execed &&
> +	(
> +		set_replace_editor todo &&
> +		test_must_fail git rebase -i HEAD 2>err
> +	) &&
> +	grep "'\''#'\'' is not a valid label" err &&
> +	grep "'\'':invalid'\'' is not a valid label" err &&
> +	grep "'\'':bad'\'' is not a valid refname" err &&
> +	grep "update-ref requires a fully qualified refname e.g. refs/heads/topic" \
> +		err &&
> +	test_path_is_missing execed &&
> +	git rebase --abort
>  '

Again, the `git rebase --abort` seems like protection for
future tests, so a test_when_finished would help.

Thanks,
-Stolee
