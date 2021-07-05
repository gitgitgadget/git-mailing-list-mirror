Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF27DC07E98
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 09:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B320261357
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 09:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhGEJjD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 05:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhGEJjD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 05:39:03 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867E6C061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 02:36:25 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id t3so22940275edc.7
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 02:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=9uE73pyoyfJqeod1V6vf95kXbFaqVyjITS5Nn1ux1Cg=;
        b=gRD/9eMLVIxTxJ5NhpiKnmSgNnVHqCJ8YaF2xlSYTZSYcQ9wR0yc480GkrafZucZ89
         A6rtkCZoa++fL4pBGM1bCPK+En8/6ynkn5q52RopkmRPeRTIflnX/kiBPI3/QwLTY/7s
         jPo1GR+OImsXxBa+hsEVhtY+Q7Hh0ZxE9kjPfsviA5sJ7biv9bQxzcqn+qiUnu+Qpzvf
         aSInDeQU7QDKZzUBP0wX6LnnMLQQa0vYw4T8EG3p+KulgK64JqOIcOsQqU1YuehwhtT/
         DAhk/ojyVvSErnB7dHZM41i0cwWiRC60k4XC15dLwpdUGP933KoHDuDCIhpjJAHqdivu
         H5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=9uE73pyoyfJqeod1V6vf95kXbFaqVyjITS5Nn1ux1Cg=;
        b=PHfpT2UimmSgv5erWDTba5kYu9+W9MaB3elNhf/7dp8iD/6zqUy0YdKng/W8aUxcyj
         u+gq4kizcJrMC24XnOtH7JOGGKfh4c0tDEjrvccXa7mp1sOVdfs3aLbcYLxrJQxPSVEG
         rw84CWfKAz1pkRZs7uzeH8C5sSca4NFSqLJkiHwiDuzB1UEonxB+0rzShIHYtbpzDIV4
         1qNCCguP6T6iViALXAdDQnj5xSliAohL+6XVShadgNTfBDPKMd4xks4o7n28bN3LG0TY
         0T2Uu1NIkSCY+uHMb6Y1bm1SakGuG7dZY5JMRbmnaNfsAdTvB+XDkWmw0TLZwvs4SPPi
         616A==
X-Gm-Message-State: AOAM5328a70DNVCGPZ8aqKdsIyDqg8wRP9Qzgiz5XXrlSEusPp+XyyDp
        pGiJi3Gy6HonoM/j0V7+EJgVdgfvbIs=
X-Google-Smtp-Source: ABdhPJyvIzL7oTFCZDfTjsuxUnmwdrsHR7ZYtGceSYcAyYl/mHbvM3LuecB27TsgLPUsmPzgDcCKcw==
X-Received: by 2002:aa7:c996:: with SMTP id c22mr15210596edt.374.1625477783869;
        Mon, 05 Jul 2021 02:36:23 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id z21sm5031364edb.23.2021.07.05.02.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 02:36:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com
Subject: Re: [PATCH RFC] rebase: respect --ff-only option
Date:   Mon, 05 Jul 2021 11:27:16 +0200
References: <20210705044505.666977-1-alexhenrie24@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210705044505.666977-1-alexhenrie24@gmail.com>
Message-ID: <87a6n16r1l.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jul 04 2021, Alex Henrie wrote:

> I'm sending this patch as an RFC because I'm sure someone will find at
> least one thing that needs to be changed before it's committed.

FWIW that's true of most non-RFC patches :)

> +int error_ff_impossible(void)
> +{
> +	error(_("Not possible to fast-forward, aborting."));
> +	return -1;
> +}

Here's one, the idiom is just "return error", i.e it itself returns -1.

FWIW I'd consider doing:
	
	/* earlier, static scope */
	static const char error_ff_impossible = N_("Not possible...");
	/* later, function scope */
	    return error(error_ff_impossible);

It's a small difference, but for translators who use the jump-to-source
while translating not having the indirection helps, and in this case
it's just used 3 times...

> [...]
>  	if (parent && parse_commit(parent) < 0)
>  		/* TRANSLATORS: The first %s will be a "todo" command like
> @@ -2764,7 +2769,7 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
>  	else if (!strcmp(key, "options.record-origin"))
>  		opts->record_origin = git_config_bool_or_int(key, value, &error_flag);
>  	else if (!strcmp(key, "options.allow-ff"))
> -		opts->allow_ff = git_config_bool_or_int(key, value, &error_flag);
> +		opts->fast_forward = git_config_bool_or_int(key, value, &error_flag) ? FF_ALLOW : FF_NO;

Since we're on nits, we try to wrap at 80 characters.

> +test_expect_success "rebase: impossible fast-forward rebase" '
> +	test_config rebase.autostash true &&
> +	git reset --hard &&
> +	echo dirty >>file1 &&
> +	(git rebase --ff-only unrelated-onto-branch || true) &&

Never "||" git commands, better as test_might_fail. We don't want to
hide segfaults.

I saw Phillip Wood had some comments on the rest, I didn't test this,
just skimmed it, but generally LGTM from a glance, not getting down to
the nuts of more deeply inspecting the logic.
