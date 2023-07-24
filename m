Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CA2C001B0
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 10:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbjGXKKh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 06:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbjGXKKL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 06:10:11 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C1E6EBF
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 03:03:06 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fba8e2aa52so39550885e9.1
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 03:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690192959; x=1690797759;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Bn8XmSZCZq0Bo5IW7S+tOGlCXHW8DSCJU17dzB3jU1U=;
        b=f8cpMi9Zw3bsrph4dYr88wCNCb7jacrboYRm9Q5jnqoqs+cwpY+xMSH+pJoYHVojzY
         qftBHWmlpdvM355Z3nz6+YDUHKcaSUfM0hl1hlJG+sy3T9pPyKBqE8O4htvURDqDJCwL
         y+Qyl/qcwRwpyWPAdSrxP99qt58Z1SVl6DWvrARdZXlKjuYTFQ3f2nZKmeRu0Pz3wuGI
         HJ3rjVkp+iJIDB0w6WZiTr7XNAZdhiR3DGwTK+6PMshek+rOr0Igo7roNuZSBDfzcJ8z
         zoCKEi7EPe6ijfNAH0p6WLNYJT6ce81iZnM2uZ9vThrSsl8GK3y6P+95VHvs0pw3Oxoq
         d5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690192959; x=1690797759;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bn8XmSZCZq0Bo5IW7S+tOGlCXHW8DSCJU17dzB3jU1U=;
        b=GZ8RDnZoeMW8WrmhkvNCmhMImvqI5799VNG1ySWhfcRKN53AE6SE3W080WdQbNaz0v
         7eG7NcfkUHHFXARCde6s+YgLqeUrjWIYe4Qdlg8g+AAnZ2LP4M1pWeweQhPgiSNUJ3Zu
         RdXhRHZ6PfM9t2A226J2iymRzRmWryClhvTyTtzU5+Ab73PqL9aS//SU3Ws042rmshw2
         bY73VSEd/wUgI1MarqoybSA92ZOZTl5V6A32MzpkVnnUO1O4BcgSAJqwjeDLhwtD9mz1
         XgAPZVlwA+j36g+G8NgJeCtItoMHWrQPUwv8XIH6aFeEkrT7JJ0EEfCzGHcv3lEU40pF
         Mh8g==
X-Gm-Message-State: ABy/qLaRnQQ/3ouhTDOtFfsfDHPcIZZZLtXhg5w6MWtz1P+QQsmI/fIw
        klDfLAnvTThT5HrLxdi1PMI=
X-Google-Smtp-Source: APBJJlHLhqSLEfZmGFU5lpPTDxT5B/RDs5SW1MVHPJnUZ+d6DjcCpxKRWQvC23Kz5dYjIVMTWeMKJw==
X-Received: by 2002:a1c:ed01:0:b0:3fd:2d33:6a9c with SMTP id l1-20020a1ced01000000b003fd2d336a9cmr5429117wmh.27.1690192958914;
        Mon, 24 Jul 2023 03:02:38 -0700 (PDT)
Received: from [192.168.1.195] ([90.242.235.211])
        by smtp.googlemail.com with ESMTPSA id z8-20020adff748000000b00314374145e0sm12316624wrp.67.2023.07.24.03.02.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 03:02:38 -0700 (PDT)
Message-ID: <0d1c5bfd-3ae5-83f0-a333-bbb8510a973a@gmail.com>
Date:   Mon, 24 Jul 2023 11:02:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 1/1] sequencer: finish parsing the todo list despite an
 invalid first line
Content-Language: en-US
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        alban.gruin@gmail.com, gitster@pobox.com,
        phillip.wood@dunelm.org.uk
References: <20230721060848.35641-1-alexhenrie24@gmail.com>
 <20230722212830.132135-1-alexhenrie24@gmail.com>
 <20230722212830.132135-2-alexhenrie24@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230722212830.132135-2-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

On 22/07/2023 22:28, Alex Henrie wrote:
> Before the todo list is edited it is rewritten to shorten the OIDs of
> the commits being picked and to append advice about editing the list.
> The exact advice depends on whether the todo list is being edited for
> the first time or not. After the todo list has been edited it is
> rewritten to lengthen the OIDs of the commits being picked and to remove
> the advice. If the edited list cannot be parsed then this last step is
> skipped.
> 
> Prior to db81e50724 (rebase-interactive: use todo_list_write_to_file()
> in edit_todo_list(), 2019-03-05) if the existing todo list could not be
> parsed then the initial rewrite was skipped as well. This had the
> unfortunate consequence that if the list could not be parsed after the
> initial edit the advice given to the user was wrong when they re-edited
> the list. This change relied on todo_list_parse_insn_buffer() returning
> the whole todo list even when it cannot be parsed. Unfortunately if the
> list starts with a "fixup" command then it will be truncated and the
> remaining lines are lost. Fix this by continuing to parse after an
> initial "fixup" commit as we do when we see any other invalid line.

This version looks great apart from the test being run in an unnecessary 
subshell which looks like it got left in from the last version. Junio 
might be able to correct that when he applies the patch.

Thanks for updating the test and commit message

Best Wishes

Phillip

> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>   sequencer.c                   |  2 +-
>   t/t3404-rebase-interactive.sh | 27 +++++++++++++++++++++++++++
>   2 files changed, 28 insertions(+), 1 deletion(-)
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
> index ff0afad63e..c734983da0 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1596,6 +1596,33 @@ test_expect_success 'static check of bad command' '
>   	test C = $(git cat-file commit HEAD^ | sed -ne \$p)
>   '
>   
> +test_expect_success 'the first command cannot be a fixup' '
> +	rebase_setup_and_clean fixup-first &&
> +	(
> +		cat >orig <<-EOF &&
> +		fixup $(git log -1 --format="%h %s" B)
> +		pick $(git log -1 --format="%h %s" C)
> +		EOF
> +
> +		(
> +			set_replace_editor orig &&
> +			test_must_fail git rebase -i A 2>actual
> +		) &&
> +		grep "cannot .fixup. without a previous commit" actual &&
> +		grep "You can fix this with .git rebase --edit-todo.." actual &&
> +		# verify that the todo list has not been truncated
> +		grep -v "^#" .git/rebase-merge/git-rebase-todo >actual &&
> +		test_cmp orig actual &&
> +
> +		test_must_fail git rebase --edit-todo 2>actual &&
> +		grep "cannot .fixup. without a previous commit" actual &&
> +		grep "You can fix this with .git rebase --edit-todo.." actual &&
> +		# verify that the todo list has not been truncated
> +		grep -v "^#" .git/rebase-merge/git-rebase-todo >actual &&
> +		test_cmp orig actual
> +	)
> +'
> +
>   test_expect_success 'tabs and spaces are accepted in the todolist' '
>   	rebase_setup_and_clean indented-comment &&
>   	write_script add-indent.sh <<-\EOF &&

