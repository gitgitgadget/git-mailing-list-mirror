Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C86C433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 15:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B3B62076C
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 15:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWphYWwH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgHKPcl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbgHKPck (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 11:32:40 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71572C06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 08:32:40 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f12so11889460wru.13
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 08:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F9/08HFww7dXZpjXuJpktNgtGtjM1kU3DZnA1oYSfAY=;
        b=KWphYWwHFwc090Nu7PYqFg+zgMwx/UQfJkngLAl9N2vb8HBbiEEcyEZUvVoCM/2pxz
         1LjEu2tILtcTqFpRR/wq86FsmQGsPeaX9+IMJL2RiCVZffZPmLcmcsOda398H3XT2KIM
         7crP16BTzAwOlLjbk4/2V8rAJ+vxlz1oEmtVcbgi5zbJppBZLRIDpRZQqw9hL8yOeUzH
         4GYlhUxu9YFC1oB3oLTeabKSoNmBO/KlXM0i4QxjtH/t+7R04mVOW0kT2b2TcHmkTNYd
         Azp6FWsOuPFYXJWXhYVfQn4yFJ9sZwqe/7KBcztvKO3smlsLcwgp5pvgJO9g7uFf9hbe
         4E2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=F9/08HFww7dXZpjXuJpktNgtGtjM1kU3DZnA1oYSfAY=;
        b=iJ/BgnTQmW0T92NYAbXbBLxcxDGofRaKx449iPxp198H0TiDZPWfEPeVO8ARJoUO1i
         YQntOaCyZ7ocRYrYYhSTEkBYoTSTuv7FnpqpviO0UnZQ99wf5iGDY/K0T5iEpaE1snpn
         jyNDebGYdaQoNL7W0Q7nfzlyTWUz2Lk8vgaQlQBLUAUOV8+M7+O5DgcSQEPejOwtxS1G
         BFHgjChEW9fHoiTTXto9i6KwUPG5pcxV7o/yTrfXDUD0m7MpeuZZZAtWwNwqp3Opi0m7
         H9QcLlA0Wd1CtNB4icKVMGJL0Ng4f9TK48jyNMFAUSoK/mecF75Jf8r7tFDy9S+iviaH
         l8Ww==
X-Gm-Message-State: AOAM530fDmcmieAhKdOmkEBdULyNUKT7C6HSEqZcKysUha84Mtqjs2U2
        54aM+F2dERBdKItkC6tqzCQ=
X-Google-Smtp-Source: ABdhPJx8vUWquSVY3gCOvnOpysw54apbhUxBC0BRqxIug7nTvjcCwed6VpOwR6gfNvon11JSmjSRPg==
X-Received: by 2002:a5d:480b:: with SMTP id l11mr28507501wrq.85.1597159959040;
        Tue, 11 Aug 2020 08:32:39 -0700 (PDT)
Received: from [192.168.1.240] (161.252.189.80.dyn.plus.net. [80.189.252.161])
        by smtp.gmail.com with ESMTPSA id q6sm5815399wma.22.2020.08.11.08.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 08:32:38 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase -i: Fix possibly wrong onto hash in todo
To:     =?UTF-8?Q?Antti_Ker=c3=a4nen?= <detegr@rbx.email>,
        git@vger.kernel.org
Cc:     =?UTF-8?Q?Jussi_Ker=c3=a4nen?= <jussike@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20200811131313.3349582-1-detegr@rbx.email>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <ebdc0bc7-f48e-9f38-328d-b1181ac974d7@gmail.com>
Date:   Tue, 11 Aug 2020 16:32:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200811131313.3349582-1-detegr@rbx.email>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Antti

On 11/08/2020 14:13, Antti Keränen wrote:
> 'todo_list_write_to_file' may overwrite the static buffer, originating
> from 'find_unique_abbrev', that was used to store the short commit hash
> 'c' for "# Rebase a..b onto c" message in the todo editor.
> Fix by duplicating the string before usage, so subsequent calls to
> 'find_unique_abbrev' or other functions calling 'hash_to_hex_algop_r'
> can't overwrite the buffer.
> 
> Found-by: Jussi Keränen <jussike@gmail.com>
> Signed-off-by: Antti Keränen <detegr@rbx.email>

Thanks for working on this

> ---
>   sequencer.c                   |  7 ++++---
>   t/t3404-rebase-interactive.sh | 13 +++++++++++++
>   2 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index fd7701c88a..0679adb639 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -5178,13 +5178,12 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>   		    struct string_list *commands, unsigned autosquash,
>   		    struct todo_list *todo_list)
>   {
> -	const char *shortonto, *todo_file = rebase_path_todo();
> +	const char *todo_file = rebase_path_todo();

I'm not sure it's worth rearranging these lines. It probably does not 
matter but we could do

+	char shortonto[GIT_MAX_HEXSZ + 1];

and then later call find_unique_abbrev_r() instead so we don't have to 
worry about freeing shortonto.

>   	struct todo_list new_todo = TODO_LIST_INIT;
>   	struct strbuf *buf = &todo_list->buf, buf2 = STRBUF_INIT;
>   	struct object_id oid = onto->object.oid;
>   	int res;
> -
> -	shortonto = find_unique_abbrev(&oid, DEFAULT_ABBREV);
> +	char *shortonto;
>   
>   	if (buf->len == 0) {
>   		struct todo_item *item = append_new_todo(todo_list);
> @@ -5206,8 +5205,10 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>   		return error(_("nothing to do"));
>   	}
>   
> +	shortonto = xstrdup(find_unique_abbrev(&oid, DEFAULT_ABBREV));
>   	res = edit_todo_list(r, todo_list, &new_todo, shortrevisions,
>   			     shortonto, flags);
> +	free(shortonto);
>   	if (res == -1)
>   		return -1;
>   	else if (res == -2) {
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 4a7d21f898..09af16753c 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1760,6 +1760,19 @@ test_expect_success 'correct error message for commit --amend after empty pick'
>   	test_i18ngrep "middle of a rebase -- cannot amend." err
>   '
>   
> +test_expect_success 'todo has correct onto hash' '
> +	write_script dump-raw.sh <<-\EOF &&
> +		cat "$1"
> +	EOF
> +	git checkout branch1 &&
> +	(
> +		test_set_editor "$(pwd)/dump-raw.sh" &&
> +		git rebase -i HEAD~5 >actual
> +	) &&

Thanks for taking the trouble to add a test, I think all the lines above 
could be simplified to

	GIT_SEQUENCE_EDITOR=cat git rebase -i HEAD~5 branch1 >actual

> +	onto=$(git rev-parse --short HEAD~5) &&
> +	test_i18ngrep "^# Rebase ..* onto $onto .*" actual

we could lose the final .*

Many Thanks and Best Wishes

Phillip

> +'
> +
>   # This must be the last test in this file
>   test_expect_success '$EDITOR and friends are unchanged' '
>   	test_editor_unchanged
> 
