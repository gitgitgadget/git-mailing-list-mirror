Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36142C433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 10:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DD5A6187F
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 10:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbhKPKKr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 05:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbhKPKKn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 05:10:43 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD5EC061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 02:07:46 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id az33-20020a05600c602100b00333472fef04so1457607wmb.5
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 02:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Il28HCHPFQMxsp51E0ey5GyyvsqrVGq5Weu3J+S3/zk=;
        b=eXKbY4UkshwVA9HSkQQ3fvWBG5sM6MA/OqpACLHf/PzjFxR5NkUH5AO+1wJ4TWvB5w
         lUntMdA99E+hW34dfmdaF6aR/AHllZhxPXqugaZU0SQYO1Bm6qzSle4AP0SsxEsArFdB
         jPFGTxzc8rhcNZ5FvqxjXo4rEJ/oF09fu/Ejoq9lkEC3HrXeLTdqWhZXBLwTVCdwhUmx
         y3LNVwo2KY4oI3IVsIpuBp32Znl8y+0u5b0srbgYJIMt57GkDD49FOi09pQ9WLmr/QHH
         wBxtlJbBMnu0NWhXvLtrdNgWSNUOhcuwIIjpaM9c9cEe6LCvlWhALZnlGeBqzKfBI5rp
         gFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Il28HCHPFQMxsp51E0ey5GyyvsqrVGq5Weu3J+S3/zk=;
        b=JMedgUAbIQ/nnnEz4/C2UKfCSwXANGA0/+VXeimy73dFqe4e5w5162LP5xeXWdFQVB
         Po0uv72wZ/5YEWWXhEp4/DBH1aWyIOrMk3QsHdJA7sWbTruxwdVq9xp4kVz8eDoB4IZE
         qLD8Cy28THuyZKR/et92l8proHfHb32gLRRyCNMGjZHi2mTLjsexbmVDObt9nRGlVBBY
         wAlvPcNFyCue9dBX+ZAqohmoxzNLO+27Pk/mxZzph3tyZh2420u235+Pyt5WDEhamz68
         ebgz5bHaHPJlqk8ooEUaHiAYLDALnWZsjSEsX1qrzPEmecYtzRAqMMVck5Z7GxTinwT7
         5lVA==
X-Gm-Message-State: AOAM530ZyZ3AL0OQ3N2FXTwTYKAWpR4EL1b5ae6PCgaLc9Q2OI8O8eDO
        uz8WpmhhncSXvNi5Lkj3GQFYstAwmI39Kw==
X-Google-Smtp-Source: ABdhPJw5k8VZdHC1QtRaM7bR0rsfnupIUTYVsTD8tvkwAnk0jUMXWP4zg9tubuErFtNWV9rMt+T69w==
X-Received: by 2002:a05:600c:22c7:: with SMTP id 7mr6372393wmg.58.1637057265166;
        Tue, 16 Nov 2021 02:07:45 -0800 (PST)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id s8sm4302354wra.9.2021.11.16.02.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 02:07:44 -0800 (PST)
Message-ID: <23de56a6-5b41-d8be-d59c-5a4e025ccd73@gmail.com>
Date:   Tue, 16 Nov 2021 10:07:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 2/2] am: support --empty-commit option to handle empty
 patches
Content-Language: en-GB-large
To:     Aleen via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?QWxlZW4g5b6Q5rKb?= =?UTF-8?B?5paH?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>, Junio C Hamano <gitster@pobox.com>
References: <pull.1076.v3.git.1636972769.gitgitgadget@gmail.com>
 <pull.1076.v4.git.1637039888.gitgitgadget@gmail.com>
 <b7e30c9b7abecdc871ddc38122ca042e940cb190.1637039888.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <b7e30c9b7abecdc871ddc38122ca042e940cb190.1637039888.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Aleen

Thanks for working on this

On 16/11/2021 05:18, Aleen via GitGitGadget wrote:
> From: Aleen <aleen42@vip.qq.com>
> 
> Signed-off-by: Aleen <aleen42@vip.qq.com>
> ---
>   Documentation/git-am.txt |  9 +++++
>   builtin/am.c             | 48 +++++++++++++++++++++++---
>   t/t4150-am.sh            | 73 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 125 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> index 0a4a984dfde..d8d3bf202d7 100644
> --- a/Documentation/git-am.txt
> +++ b/Documentation/git-am.txt
> @@ -16,6 +16,7 @@ SYNOPSIS
>   	 [--exclude=<path>] [--include=<path>] [--reject] [-q | --quiet]
>   	 [--[no-]scissors] [-S[<keyid>]] [--patch-format=<format>]
>   	 [--quoted-cr=<action>]
> +	 [--empty-commit=(die|skip|asis)]
>   	 [(<mbox> | <Maildir>)...]
>   'git am' (--continue | --skip | --abort | --quit | --show-current-patch[=(diff|raw)])
>   
> @@ -63,6 +64,14 @@ OPTIONS
>   --quoted-cr=<action>::
>   	This flag will be passed down to 'git mailinfo' (see linkgit:git-mailinfo[1]).
>   
> +--empty-commit=(die|skip|asis)::
> +	The command usually errors out when seeing an input e-mail
> +	message that lacks a patch. When this option is set to
> +	'skip', skip such an e-mail message without outputting error.
> +	When this option is set to 'asis', create an empty commit,
> +	recording the contents of the e-mail message as its log.
> +	'die' is specified by default.

This feels sufficiently similar to the case of handling empty commits in 
'git rebase' that it is worth trying to have a similar user interface. 
Otherwise the two commands have two different option names doing more or 
less the same thing. 'git rebase' has --empty=[drop,keep,ask] where drop 
is the default. If am were to accept --empty=[drop,keep,die] it would 
offer a similar user experience.

Best Wishes

Phillip

>   -m::
>   --message-id::
>   	Pass the `-m` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]),
> diff --git a/builtin/am.c b/builtin/am.c
> index 8677ea2348a..e7755c1377e 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -87,6 +87,12 @@ enum show_patch_type {
>   	SHOW_PATCH_DIFF = 1,
>   };
>   
> +enum empty_commit_action {
> +	DIE_EMPTY_COMMIT = 0,  /* output errors */
> +	SKIP_EMPTY_COMMIT,     /* skip without outputting errors */
> +	ASIS_EMPTY_COMMIT      /* keep recording as empty commits */
> +};
> +
>   struct am_state {
>   	/* state directory path */
>   	char *dir;
> @@ -118,6 +124,7 @@ struct am_state {
>   	int message_id;
>   	int scissors; /* enum scissors_type */
>   	int quoted_cr; /* enum quoted_cr_action */
> +	int empty_commit; /* enum empty_commit_action */
>   	struct strvec git_apply_opts;
>   	const char *resolvemsg;
>   	int committer_date_is_author_date;
> @@ -178,6 +185,23 @@ static int am_option_parse_quoted_cr(const struct option *opt,
>   	return 0;
>   }
>   
> +static int am_option_parse_empty_commit(const struct option *opt,
> +				     const char *arg, int unset)
> +{
> +	int *opt_value = opt->value;
> +
> +	if (unset || !strcmp(arg, "die"))
> +		*opt_value = DIE_EMPTY_COMMIT;
> +	else if (!strcmp(arg, "skip"))
> +		*opt_value = SKIP_EMPTY_COMMIT;
> +	else if (!strcmp(arg, "asis"))
> +		*opt_value = ASIS_EMPTY_COMMIT;
> +	else
> +		return error(_("Invalid value for --empty-commit: %s"), arg);
> +
> +	return 0;
> +}
> +
>   /**
>    * Returns path relative to the am_state directory.
>    */
> @@ -1248,11 +1272,6 @@ static int parse_mail(struct am_state *state, const char *mail)
>   		goto finish;
>   	}
>   
> -	if (is_empty_or_missing_file(am_path(state, "patch"))) {
> -		printf_ln(_("Patch is empty."));
> -		die_user_resolve(state);
> -	}
> -
>   	strbuf_addstr(&msg, "\n\n");
>   	strbuf_addbuf(&msg, &mi.log_message);
>   	strbuf_stripspace(&msg, 0);
> @@ -1792,6 +1811,20 @@ static void am_run(struct am_state *state, int resume)
>   		if (state->interactive && do_interactive(state))
>   			goto next;
>   
> +		if (is_empty_or_missing_file(am_path(state, "patch"))) {
> +			if (state->empty_commit == SKIP_EMPTY_COMMIT)
> +				goto next;
> +			else if (state->empty_commit == ASIS_EMPTY_COMMIT) {
> +				if (run_applypatch_msg_hook(state))
> +					exit(1);
> +				else
> +					goto commit;
> +			} else if (state->empty_commit == DIE_EMPTY_COMMIT) {
> +				printf_ln(_("Patch is empty."));
> +				die_user_resolve(state);
> +			}
> +		}
> +
>   		if (run_applypatch_msg_hook(state))
>   			exit(1);
>   
> @@ -1827,6 +1860,7 @@ static void am_run(struct am_state *state, int resume)
>   			die_user_resolve(state);
>   		}
>   
> +commit:
>   		do_commit(state);
>   
>   next:
> @@ -2357,6 +2391,10 @@ int cmd_am(int argc, const char **argv, const char *prefix)
>   		{ OPTION_STRING, 'S', "gpg-sign", &state.sign_commit, N_("key-id"),
>   		  N_("GPG-sign commits"),
>   		  PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
> +		{ OPTION_CALLBACK, 0, "empty-commit", &state.empty_commit,
> +		  "(die|skip|asis)",
> +		  N_("specify how to handle empty patches"),
> +		  PARSE_OPT_OPTARG, am_option_parse_empty_commit },
>   		OPT_HIDDEN_BOOL(0, "rebasing", &state.rebasing,
>   			N_("(internal use for git-rebase)")),
>   		OPT_END()
> diff --git a/t/t4150-am.sh b/t/t4150-am.sh
> index 2aaaa0d7ded..e657180c201 100755
> --- a/t/t4150-am.sh
> +++ b/t/t4150-am.sh
> @@ -196,6 +196,13 @@ test_expect_success setup '
>   
>   	git format-patch -M --stdout lorem^ >rename-add.patch &&
>   
> +	git checkout -b empty-commit &&
> +	git commit -m "empty commit" --allow-empty &&
> +
> +	git format-patch --stdout empty-commit^ >empty.patch &&
> +	git format-patch --stdout --cover-letter empty-commit^ >cover-letter.patch &&
> +	git format-patch --always --stdout empty-commit^ >empty-commit.patch &&
> +
>   	# reset time
>   	sane_unset test_tick &&
>   	test_tick
> @@ -1152,4 +1159,70 @@ test_expect_success 'apply binary blob in partial clone' '
>   	git -C client am ../patch
>   '
>   
> +test_expect_success 'still output error with --empty-commit when meeting empty files' '
> +	test_must_fail git am --empty-commit=skip empty.patch 2>actual &&
> +	echo Patch format detection failed. >expected &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'error when meeting e-mail message that lacks a patch by default' '
> +	git checkout empty-commit^ &&
> +	test_must_fail git am empty-commit.patch >err &&
> +	test_path_is_dir .git/rebase-apply &&
> +	test_i18ngrep "Patch is empty." err &&
> +	rm -fr .git/rebase-apply &&
> +
> +	test_must_fail git am --empty-commit=die empty-commit.patch >err &&
> +	test_path_is_dir .git/rebase-apply &&
> +	test_i18ngrep "Patch is empty." err &&
> +	rm -fr .git/rebase-apply &&
> +
> +	test_must_fail git am --empty-commit=die cover-letter.patch >err &&
> +	test_path_is_dir .git/rebase-apply &&
> +	test_i18ngrep "Patch is empty." err &&
> +	rm -fr .git/rebase-apply
> +'
> +
> +test_expect_success 'skip without error when meeting e-mail message that lacks a patch' '
> +	git am --empty-commit=skip empty-commit.patch >err &&
> +	test_path_is_missing .git/rebase-apply &&
> +	git rev-parse empty-commit^ >expected &&
> +	git rev-parse HEAD >actual &&
> +	test_cmp expected actual &&
> +
> +	git am --empty-commit=skip cover-letter.patch >err &&
> +	test_path_is_missing .git/rebase-apply &&
> +	test_cmp_rev empty-commit^ HEAD
> +'
> +
> +test_expect_success 'record as an empty commit when meeting e-mail message that lacks a patch' '
> +	git am --empty-commit=asis empty-commit.patch &&
> +	test_path_is_missing .git/rebase-apply &&
> +	{
> +		git show empty-commit --format="%B" &&
> +		echo "--" &&
> +		git version | sed -e "s/^git version //" &&
> +		echo
> +	} >expected &&
> +	git show HEAD --format="%B" >actual &&
> +	test_cmp actual expected &&
> +
> +	git am --empty-commit=asis cover-letter.patch &&
> +	test_path_is_missing .git/rebase-apply &&
> +	{
> +		echo "*** SUBJECT HERE ***" &&
> +		echo &&
> +		echo "*** BLURB HERE ***" &&
> +		echo &&
> +		echo "A U Thor (1):" &&
> +		printf "  " &&
> +		git show empty-commit --format="%B" &&
> +		echo "--" &&
> +		git version | sed -e "s/^git version //" &&
> +		echo
> +	} >expected &&
> +	git show HEAD --format="%B" >actual &&
> +	test_cmp actual expected
> +'
> +
>   test_done
> 
