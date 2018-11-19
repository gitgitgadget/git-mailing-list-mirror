Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 387261F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 12:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbeKSXCL (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 18:02:11 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41365 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728530AbeKSXCK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 18:02:10 -0500
Received: by mail-ed1-f67.google.com with SMTP id z28so2121282edi.8
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 04:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=mF3487EtvXoJgktPTXD2IhjxgoOKxc+9I6CUQ1Q7lQk=;
        b=Ld57RkT4HvIJUH4DNGsPmlARgwWqjl4m2lLKqAzrmeVxkc5Sf1lg8ciXttWvUVTv89
         GvZZX3L95f1SUxDb8E2rKpQ96GICgC6P5cYiATgsdIv7blyxZoH8u8ajReUXnpkYZK2X
         kqaxatDLdyN31aKR71a0pZJm8PQPvzaUUc5uojj0Pg2SYHSszteBZDOHKXGvGlieNolo
         OKzGF3dMFjIGDY5Ph8DQQa28Fa3VrVWqC097z7hR3B+dBXL8kFQXe27VsU7I6mrttBsf
         ZVeBnEx9uWi0PW2PsKz+wfWrTbiDhm335ogHX5Y0nbgY6IvMHEadevTrmsjb8GfmahOi
         uV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=mF3487EtvXoJgktPTXD2IhjxgoOKxc+9I6CUQ1Q7lQk=;
        b=lLfZ7sh5IlmV6Jb7GHtX2DZ6bFxWHqjskUkTASIXDuCRJoldZs7gKcclri17nV8dqX
         1aFEgoJAQ8cmBHpG5tY9jnMS7V4V+e5k0AbWgNBb3WPWEQgfNvPCNV8ZKKJYVDU2ulSy
         E+P9ytvf9hVuH3/u5K05brf0+t4pKqiYSPRITamr0irh9YZ51653RX+FMGWl+psjiB2h
         E9LWMaB/2JVGTADY/Wn660yVmChnOjuuvsDA/PUTFjp8E9NCPrVJZXbwnplvF3PWemMm
         a++3H3XxvTc8fabDoTGKl9Jw8zR8sOy8FdD29WdYL1IQBxKiU7OTFZ+SOK1xht2C4mkK
         EOKA==
X-Gm-Message-State: AGRZ1gLXG/xRc5OiAx6tLvNCWnupGYVPa8Wdg9w6BG5bJQhM2xt8LTeZ
        SutX2xMQ3SD4+yAKlEYGdGf+p2qucHY=
X-Google-Smtp-Source: AJdET5dVpIuZCucZkTpPyCc0EB7GAZnIuGebRHVa+bBF1LDlV/MWNWP8KvQhhkhf3G0/x7Fi42qsQw==
X-Received: by 2002:a17:906:49c2:: with SMTP id w2-v6mr16943186ejv.117.1542631118753;
        Mon, 19 Nov 2018 04:38:38 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id e18-v6sm6557311ejm.26.2018.11.19.04.38.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 04:38:37 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/2] rebase: validate -C<n> and --whitespace=<mode> parameters early
References: <pull.76.git.gitgitgadget@gmail.com> <pull.76.v2.git.gitgitgadget@gmail.com> <4c2ba5276636097a1c3bb2207c7537831e9079bc.1542212726.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <4c2ba5276636097a1c3bb2207c7537831e9079bc.1542212726.git.gitgitgadget@gmail.com>
Date:   Mon, 19 Nov 2018 13:38:36 +0100
Message-ID: <874lcd1bub.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 14 2018, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> It is a good idea to error out early upon seeing, say, `-Cbad`, rather
> than starting the rebase only to have the `--am` backend complain later.
>
> Let's do this.
>
> The only options accepting parameters which we pass through to `git am`
> (which may, or may not, forward them to `git apply`) are `-C` and
> `--whitespace`. The other options we pass through do not accept
> parameters, so we do not have to validate them here.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/rebase.c          | 12 +++++++++++-
>  t/t3406-rebase-message.sh |  7 +++++++
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 96ffa80b71..571cf899d5 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1064,12 +1064,22 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	}
>
>  	for (i = 0; i < options.git_am_opts.argc; i++) {
> -		const char *option = options.git_am_opts.argv[i];
> +		const char *option = options.git_am_opts.argv[i], *p;
>  		if (!strcmp(option, "--committer-date-is-author-date") ||
>  		    !strcmp(option, "--ignore-date") ||
>  		    !strcmp(option, "--whitespace=fix") ||
>  		    !strcmp(option, "--whitespace=strip"))
>  			options.flags |= REBASE_FORCE;
> +		else if (skip_prefix(option, "-C", &p)) {
> +			while (*p)
> +				if (!isdigit(*(p++)))
> +					die(_("switch `C' expects a "
> +					      "numerical value"));
> +		} else if (skip_prefix(option, "--whitespace=", &p)) {
> +			if (*p && strcmp(p, "warn") && strcmp(p, "nowarn") &&
> +			    strcmp(p, "error") && strcmp(p, "error-all"))
> +				die("Invalid whitespace option: '%s'", p);
> +		}
>  	}
>
>  	if (!(options.flags & REBASE_NO_QUIET))
> diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
> index 0392e36d23..2c79eed4fe 100755
> --- a/t/t3406-rebase-message.sh
> +++ b/t/t3406-rebase-message.sh
> @@ -84,4 +84,11 @@ test_expect_success 'rebase --onto outputs the invalid ref' '
>  	test_i18ngrep "invalid-ref" err
>  '
>
> +test_expect_success 'error out early upon -C<n> or --whitespace=<bad>' '
> +	test_must_fail git rebase -Cnot-a-number HEAD 2>err &&
> +	test_i18ngrep "numerical value" err &&
> +	test_must_fail git rebase --whitespace=bad HEAD 2>err &&
> +	test_i18ngrep "Invalid whitespace option" err
> +'
> +

The combination of this gitster/js/rebase-am-options and my
gitster/ab/rebase-in-c-escape-hatch breaks tests under
GIT_TEST_REBASE_USE_BUILTIN=false for obvious reasons. The C version is
now more strict.
