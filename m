Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17C1EB64DC
	for <git@archiver.kernel.org>; Thu, 20 Jul 2023 09:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjGTJqn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jul 2023 05:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjGTJqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2023 05:46:25 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C534220
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 02:42:36 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fc03aa6e04so4260145e9.2
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 02:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689846154; x=1690450954;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7UT84qV2S9J/3MIYo62/iuBgc1eyWfPFymwYNwTw2t8=;
        b=dJU9DxfZgBf8AfhI5t+Qlc2afeKDqpjOdnOvtS012bzDX0x6euuMPAcodLWb2L/Ojv
         I4yORDl8Ttpw3iMnpNtO0K7DcEpiHLM0ntMCuCfk0XAoNQNGPTUKL9KCNF5M/ObUvPbW
         DS1xoc0Ys0zHBvAMRU5fAnjVv0sfljRsUnjAX0MpnDbrQTN2iPb1s0pgJCcS0bvCF3rg
         HAJblbOhWbTAgs+jIQSlIbmnUK3SfQ665/Qdcxk8Iawawmlvx7vQWf8xZ/w9xkTJi2Dp
         nTb7qfteFnBjMGkXAVuCyr5W68J11c/+DZDuvSBxTIlJsII2IpO04CnFjLoQly0Q3SKl
         XPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689846154; x=1690450954;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7UT84qV2S9J/3MIYo62/iuBgc1eyWfPFymwYNwTw2t8=;
        b=UXrwyblA0BTwtWbc7MYM+xkUKAbKfUulvjdYoaz9hY4jqiGZ42eBGffDysRBF0SZDn
         eJbGLBydUfEcFumnoWgLSIDoi6EpedIhpI7GyRUaZTfpq2gzkO4gN+1nKyn6jFhsxt3L
         C3Hm+SCCzLnUvrLqocfr5hOP7Ntj5nUgAOmnmzt6AFDoBKCRS6OM4U4lSLo7hG118d9d
         aiscqn/tNrN8ra4RaJ6t85YFZuQO+k0dnDNN7NRvuqArCjuk/oMTc+OUd7dIct2/JQ1h
         5E47SqRIcRp1Oy09VGaDJztS97P/qNKoX61lyz/gZz8LY60luA4kSF2QKwqtqeqrminw
         EQHg==
X-Gm-Message-State: ABy/qLY1yYQ9UejzMpMCwL7BB3giZvwC9z0tjS6123IXouJ8368Y0kMi
        qKF8t/dox2Egf7rhtGPByl71TsNo5ae1Yg==
X-Google-Smtp-Source: APBJJlH8E5mDHkAz2DgZ4t7Z4uhUfD8rZ+D8WSiZriPKXpKHoeI4b+CiUtuAFCDtHwVa2xG8GOJLlQ==
X-Received: by 2002:a1c:790b:0:b0:3fb:d1c1:9b79 with SMTP id l11-20020a1c790b000000b003fbd1c19b79mr3686681wme.30.1689846154013;
        Thu, 20 Jul 2023 02:42:34 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.235.211])
        by smtp.gmail.com with ESMTPSA id j9-20020a5d4529000000b0030fd03e3d25sm790588wra.75.2023.07.20.02.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 02:42:33 -0700 (PDT)
Message-ID: <395274b4-37a9-8c95-203f-94178c99772a@gmail.com>
Date:   Thu, 20 Jul 2023 10:42:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sequencer: finish parsing the todo list despite an
 invalid first line
Content-Language: en-US
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        alban.gruin@gmail.com, gitster@pobox.com
References: <20230719144339.447852-1-alexhenrie24@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230719144339.447852-1-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

Thanks for working on this.

On 19/07/2023 15:43, Alex Henrie wrote:
> ddb81e5072 (rebase-interactive: use todo_list_write_to_file() in
> edit_todo_list(), 2019-03-05) made edit_todo_list more efficient by
> replacing transform_todo_file with todo_list_parse_insn_buffer.
> Unfortunately, that innocuous change caused a regression because
> todo_list_parse_insn_buffer would stop parsing after encountering an
> invalid 'fixup' line. If the user accidentally made the first line a
> 'fixup' and tried to recover from their mistake with `git rebase
> --edit-todo`, all of the commands after the first would be lost.

I found this description a little confusing as transform_todo_file() 
also called todo_list_parse_insn_buffer(). transform_todo_file() does 
not exist anymore but it looked like

static int transform_todo_file(unsigned flags)
{
         const char *todo_file = rebase_path_todo();
         struct todo_list todo_list = TODO_LIST_INIT;
         int res;

         if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
                 return error_errno(_("could not read '%s'."), todo_file);

         if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
                                         &todo_list)) {
                 todo_list_release(&todo_list);
                 return error(_("unusable todo list: '%s'"), todo_file);
         }

         res = todo_list_write_to_file(the_repository, &todo_list, 
todo_file,
                                       NULL, NULL, -1, flags);
         todo_list_release(&todo_list);

         if (res)
                 return error_errno(_("could not write '%s'."), todo_file);
         return 0;
}

If it could not parse the todo list it did not try and write it to disc. 
After ddb81e5072 this changed as edit_todo_list() tries to shorten the 
OIDs in the todo list before it is edited even if it cannot be parsed. 
The fix below works around that by making sure we always try and parse 
the whole todo list even if the the first line is a fixup command. That 
is a worthwhile improvement because it means we notify the user of all 
the errors we find rather than just the first one and is in keeping with 
the way we handle other invalid lines. It does not however fix the root 
cause of this regression which is the change in behavior in 
edit_todo_list().

After the user edits the todo file we do not try to transform the OIDs 
if it cannot be parsed or has missing commits. Therefore it still 
contains the shortened OIDs and editing hints and there is no need for 
edit_todo_list() to call write_todo_list() when "incorrect" is true.


> To avoid throwing away important parts of the todo list, change
> todo_list_parse_insn_buffer to keep going and not return early on error.
> 
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>   sequencer.c                   |  2 +-
>   t/t3404-rebase-interactive.sh | 19 +++++++++++++++++++
>   2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index cc9821ece2..adc9cfb4df 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2702,7 +2702,7 @@ int todo_list_parse_insn_buffer(struct repository *r, char *buf,
>   		if (fixup_okay)
>   			; /* do nothing */
>   		else if (is_fixup(item->command))
> -			return error(_("cannot '%s' without a previous commit"),
> +			res = error(_("cannot '%s' without a previous commit"),
>   				command_to_string(item->command));
>   		else if (!is_noop(item->command))
>   			fixup_okay = 1;
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index ff0afad63e..d2801ffee4 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1596,6 +1596,25 @@ test_expect_success 'static check of bad command' '
>   	test C = $(git cat-file commit HEAD^ | sed -ne \$p)
>   '
>   
> +test_expect_success 'the first command cannot be a fixup' '
> +	# When using `git rebase --edit-todo` to recover from this error, ensure
> +	# that none of the original todo list is lost
> +	rebase_setup_and_clean fixup-first &&
> +	(
> +		set_fake_editor &&
> +		test_must_fail env FAKE_LINES="fixup 1 2 3 4 5" \
> +			       git rebase -i --root 2>actual &&

Thanks for taking the time to add a test. It is not worth a re-roll on 
its own, but there is no need to use "--root" here. It is confusing as 
it is not clear if we're refusing "fixup" as the first command because 
we're rewriting the root commit or if we always refuse to have "fixup" 
as the first command.

As an aside this restriction is pretty easy to defeat. In fact I think 
we probably allow a todo list that starts with

[new root]
fixup <commit>

which is a bug. We certainly allow todo lists starting with

exec true / label <label> / reset <commit>
fixup <commit>

but that is not the concern of this patch.

> +		test_i18ngrep "cannot .fixup. without a previous commit" \
> +				actual &&
> +		test_i18ngrep "You can fix this with .git rebase --edit-todo.." \
> +				actual &&
> +		grep -v "^#" .git/rebase-merge/git-rebase-todo >orig &&
> +		test_must_fail git rebase --edit-todo &&
> +		grep -v "^#" .git/rebase-merge/git-rebase-todo >actual &&
> +		test_cmp orig actual

We check that the uncommitted lines after running "git rebase 
--edit-todo" match the uncommitted lines after the initial edit. That's 
fine to detect if the second edit truncates the file but it will still 
pass if the initial edit starts truncating the todo list as well. As we 
expect that git should not change an incorrect todo list we do not need 
to filter out the lines beginning with "#".

To ensure we detect a regression where the first edit truncates the todo 
list we could do something like

	test_when_finished "git rebase --abort" &&
	cat >todo <<-EOF &&
	fixup $(git log -1 --format="%h %s" B)
	pick $(git log -1 --format="%h %s" C)
	EOF

	(
		set_replace_editor todo &&
		test_must_fail git rebase -i A 2>actual
	) &&
	test_i18ngrep "cannot .fixup. without a previous commit" actual &&
	test_i18ngrep "You can fix this with .git rebase --edit-todo.." actual &&
	# check initial edit has not truncated todo list
	grep -v "^#" .git/rebase-merge/git-rebase-todo >actual &&
	test_cmp todo actual &&
	cat .git/rebase-merge/git-rebase-todo >expect &&
	test_must_fail git rebase --edit-todo &&
	# check the list is unchanged by --edit-todo
	test_cmp expect .git/rebase-merge/git-rebase-todo

We could perhaps check the error message from "git rebase --edit-todo" 
as well.

Thanks for finding this and working on a fix

Phillip

> +	)
> +'
> +
>   test_expect_success 'tabs and spaces are accepted in the todolist' '
>   	rebase_setup_and_clean indented-comment &&
>   	write_script add-indent.sh <<-\EOF &&
