Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E42C4332B
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 08:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14E7064FF5
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 08:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbhCLIyo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 03:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbhCLIyb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 03:54:31 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B5BC061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 00:54:31 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ci14so51718349ejc.7
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 00:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=OPSYpDIvW2eYImx+F11tRXdFFFdHQ6dDf5rotRRXQlc=;
        b=rCAd7EOqXuxUH2VHL2CFRH0jSNoFRDUox1iPguLAuFe7pBI6rN9yMJQrb4iIvyzL+1
         T9kgy1ZkNM6h0Qqljn7wKixKWkaB/X3HbMhPFY+s9+Vm4ZglJ6PyptnBdbG5CcGzkGB2
         ZRD4IeHmCCHguYNlZYC8J9+4JIBjN9O9iuqMXK3u75BQZvyw7SH8fSidK2Rn/D1bRrXk
         7JI2JjGwHqxdPl5S5G4H88k1LR2sPY7oRbiOmjvPe832XXSnYlD0USZqi/6kUJHfOSMp
         Q223WM8O9OTMtIB56uUepFnC2NeMqq+jcigrnhNLlRe9frpidYsnhBCYM4Hohcy7nnAx
         fB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=OPSYpDIvW2eYImx+F11tRXdFFFdHQ6dDf5rotRRXQlc=;
        b=W1dSC0Sqws1wWG4EdoDvtnwWivMSy2rVvwFiIRin4KLLcOjUYYdu1Lyo7NYJ+6Hlty
         xtPhyIboPPIDgnNY0HCNhQJka8dD2AAiREvkX6YSfoqz0xSbyECJ+5qsSwMXtHPMhmiJ
         9FcL6TQqJv4wy5JyHtf/TO1JTA9NgtFxDUIpIS4fzQl7NpXwBbFCyH4APgVYqdhE2Iev
         WtrH+iDe9Z2XRhmQeBuy50ff+ymsW7+cF3xgM5JwAzKECD0F4PpSHAUVMjgkUeMKzUDs
         gFo603dbtJVgJpzqRdLTN6WcQf8VMHxdPc+7ZXm82UAgCrZadx4fSNzewIFw8VLjuxHm
         zJbw==
X-Gm-Message-State: AOAM532G2WGzw2LEIc3+R+erJgUo9esLKZOFWpqwHlOD7LmJEsfbfHNe
        LYHf8gsjFmFUH1ONc/OxHJo=
X-Google-Smtp-Source: ABdhPJzX45iSoZilXe3gJyMzAunrbY4LviAusVwK2oCXmHZS4JIZAXvze/T96ZST7580jXZRuIK75g==
X-Received: by 2002:a17:906:3552:: with SMTP id s18mr7496084eja.497.1615539269648;
        Fri, 12 Mar 2021 00:54:29 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id s11sm2592839edt.27.2021.03.12.00.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 00:54:29 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 08/37] hook: add 'run' subcommand
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210311021037.3001235-9-emilyshaffer@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210311021037.3001235-9-emilyshaffer@google.com>
Date:   Fri, 12 Mar 2021 09:54:28 +0100
Message-ID: <87a6r8hhvf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 11 2021, Emily Shaffer wrote:

>  'git hook' list <hook-name>
> +'git hook' run [(-e|--env)=<var>...] [(-a|--arg)=<arg>...] <hook-name>

[...]

> +	switch (cfg)
> +	{
> +		case HOOKDIR_ERROR:

Overly indented case statements again.

> +			fprintf(stderr, _("Skipping legacy hook at '%s'\n"),
> +				path);
> +			/* FALLTHROUGH */
> +		case HOOKDIR_NO:
> +			return 0;
> +		case HOOKDIR_WARN:
> +			fprintf(stderr, _("Running legacy hook at '%s'\n"),
> +				path);
> +			return 1;
> +		case HOOKDIR_INTERACTIVE:
> +			do {
> +				/*
> +				 * TRANSLATORS: Make sure to include [Y] and [n]
> +				 * in your translation. Only English input is
> +				 * accepted. Default option is "yes".
> +				 */
> +				fprintf(stderr, _("Run '%s'? [Yn] "), path);

Nit: [Y/n]

> +				} else if (starts_with(prompt.buf, "y")) {

So also "Y", "yes" and "yellow"...

> [...]
>  	git hook list pre-commit >actual &&
>  	# the hookdir annotation is translated
> -	test_i18ncmp expected actual
> +	test_i18ncmp expected actual &&
> +
> +	test_write_lines n | git hook run pre-commit 2>actual &&
> +	! grep "Legacy Hook" actual &&
> +
> +	test_write_lines y | git hook run pre-commit 2>actual &&
> +	grep "Legacy Hook" actual
> +'
> +
> +test_expect_success 'inline hook definitions execute oneliners' '
> +	test_config hook.pre-commit.command "echo \"Hello World\"" &&
> +
> +	echo "Hello World" >expected &&
> +
> +	# hooks are run with stdout_to_stderr = 1
> +	git hook run pre-commit 2>actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'inline hook definitions resolve paths' '
> +	write_script sample-hook.sh <<-EOF &&
> +	echo \"Sample Hook\"
> +	EOF
> +
> +	test_when_finished "rm sample-hook.sh" &&
> +
> +	test_config hook.pre-commit.command "\"$(pwd)/sample-hook.sh\"" &&
> +
> +	echo \"Sample Hook\" >expected &&
> +
> +	# hooks are run with stdout_to_stderr = 1
> +	git hook run pre-commit 2>actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'hookdir hook included in git hook run' '
> +	setup_hookdir &&
> +
> +	echo \"Legacy Hook\" >expected &&
> +
> +	# hooks are run with stdout_to_stderr = 1
> +	git hook run pre-commit 2>actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'out-of-repo runs excluded' '
> +	setup_hooks &&
> +
> +	nongit test_must_fail git hook run pre-commit
>  '
>  
>  test_expect_success 'hook.runHookDir is tolerant to unknown values' '

No tests for --env or --arg?
