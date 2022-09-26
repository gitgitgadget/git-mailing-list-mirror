Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FDAC07E9D
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 08:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbiIZIff (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 04:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234432AbiIZIfb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 04:35:31 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B55275E9
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 01:35:29 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id sd10so12498793ejc.2
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 01:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=LNtBM4pbgVqpMa+mESyeuLQkJeV7pzr8m4arXFyeVc0=;
        b=mMhIolsPrpRNq6Y1UTLOiozPl0BE0iUiyzx/VKcsO+sz4JIY7Yh2BVSL179hNkMNn5
         NtJim7AN1Ag1EE9w+ULVaXHcZa8+gj60rgRKZsAR0FHIoyQsXehIPAthRh9JP/f2w/Ta
         ncEItJxlIwR2ZW4b8qb+pBHinMP+jBVcbSKkoSUOV3fXSPAOydi5YDpGB4qlOmfefhMX
         xSRGRzwFP0Dt8sg51KUTGxTvsNmICaQkj53wmv2uPdC7xVCWKudQ3UkZcAokYMuGovKF
         Hp7T4HLINYxkaaUaYMudAYqOibTS8DIWo4Nsa4rLIZ+c9INfaHvhBjBTjXxLDA6b9dG8
         4neg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=LNtBM4pbgVqpMa+mESyeuLQkJeV7pzr8m4arXFyeVc0=;
        b=WGd74HqU/LONCJArMWqZms1g+bV1mkJ4d5IKiMiTw+RmV2IkxVazR2q5cn/TPeyQBR
         aPFH9LVV6vZ1H5SGB5G9ZVta1o2rLsJ8Eif1yhAQHLx28RjlNVjAhjgNwpJEQePINteN
         g02BkauLJ3IwWAMrslAZMqw8c2/iYW+EtaHEAhSIiKEB0JnK1xs/+mW7PF3PTqa+D5nt
         VfpqcNpp6LorS8f9G+xOYr6I8+q8SxHNeaKw0eIrEfa7mrtnEodF1UbFcVUmX3IZ4OOO
         rpdO/OBDkBkykuRby2ubkBEarW+ZrBg2xKHkJhunjdapuJ8+I+FTkZJvQJycCj/TUh9g
         hwbg==
X-Gm-Message-State: ACrzQf1auGSEwqLRbNpPM1x56cWUkrgHnYXImMRSMqEL2zSj25kSTXb2
        QOkJLGraJSlHajeqGm9vyWLD/cd1rc8=
X-Google-Smtp-Source: AMsMyM43UNRSVPKswFtSPZv2UYjWNIOBKCFBwK1yxPFU3drUn5UpVV2QHSQj3YaNE8MpjhaseKdQPg==
X-Received: by 2002:a17:907:a47:b0:780:6883:2a37 with SMTP id be7-20020a1709070a4700b0078068832a37mr17227906ejc.219.1664181327376;
        Mon, 26 Sep 2022 01:35:27 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id kz10-20020a17090777ca00b00730979f568fsm7964265ejc.150.2022.09.26.01.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 01:35:26 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ocjaI-003mWK-1a;
        Mon, 26 Sep 2022 10:35:26 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stefan Xenos via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Christophe Poucet <christophe.poucet@gmail.com>,
        Stefan Xenos <sxenos@google.com>
Subject: Re: [PATCH 07/10] evolve: implement the git change command
Date:   Mon, 26 Sep 2022 10:25:50 +0200
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
 <914028341842a4d57e02ec42a7426d3aa83640f9.1663959325.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <914028341842a4d57e02ec42a7426d3aa83640f9.1663959325.git.gitgitgadget@gmail.com>
Message-ID: <220926.8635ce4jox.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 23 2022, Stefan Xenos via GitGitGadget wrote:

> From: Stefan Xenos <sxenos@google.com>

> +static const char * const builtin_change_usage[] = {
> +	N_("git change update [--force] [--replace <treeish>...] [--origin <treesih>...] [--content <newtreeish>]"),
> +	NULL
> +};
> +
> +static const char * const builtin_update_usage[] = {
> +	N_("git change update [--force] [--replace <treeish>...] [--origin <treesih>...] [--content <newtreeish>]"),
> +	NULL
> +};

This (and the corresponding later *.txt version) should indent the
overly long -h line, probably after "[--replace <treeish>...]".

> +struct update_state {
> +	int options;

I think this should be an enum in your earlier 06/10. Makes things more

> +		die(_("Failed to resolve '%s' as a valid revision."), committish);

This and other error should start with a lower-case letter, see
CodingGuidelines on errors.

> [...]
> +		die(_("Could not parse object '%s'."), committish);

Ditto etc.

> +	int i;
> +	for (i = 0; i < commitsish_list->nr; i++) {

A string_list uses a size_t for a nr, not int, so lets make that "size_t
i".

This both makes things more obvious, and helps some compilers spot
unsigned v.s. signed issues.


> +	int i;

ditto size_t above...

> +	for (i = 0; i < changes.nr; i++) {

...for this iteration...

> +		struct string_list_item *it = &changes.items[i];

...but actually don't you just want for_each_string_list_item() instead?

> +		if (it->util)
> +			fprintf(stdout, N_("Updated change %s\n"), name);
> +		else
> +			fprintf(stdout, N_("Created change %s\n"), name);

The use of N_() here is wrong, you should use _(), N_() just marks
things for translation, but doesn't use it.

We also tend to try to avoid adding \n in translations needlessly. And
since you're printing to stdout this can be:


	if (...)
		printf(_("Updated change %s"), name);
	...
	putchar('\n')      



> +	}
> +
> +	string_list_clear(&changes, 0);
> +	change_table_clear(&chtable);
> +	clear_metacommit_data(&metacommit);
> +
> +	return ret;
> +}
> +
> +static int change_update(int argc, const char **argv, const char* prefix)
> +{
> +	int result;
> +	int force = 0;
> +	int newchange = 0;
> +	struct strbuf err = STRBUF_INIT;
> +	struct update_state state;
> +	struct option options[] = {
> +		{ OPTION_CALLBACK, 'r', "replace", &state, N_("commit"),
> +			N_("marks the given commit as being obsolete"),
> +			0, update_option_parse_replace },
> +		{ OPTION_CALLBACK, 'o', "origin", &state, N_("commit"),
> +			N_("marks the given commit as being the origin of this commit"),
> +			0, update_option_parse_origin },
> +		OPT_BOOL('F', "force", &force,
> +			N_("overwrite an existing change of the same name")),
> +		OPT_STRING('c', "content", &state.content, N_("commit"),
> +				 N_("identifies the new content commit for the change")),
> +		OPT_STRING('g', "change", &state.change, N_("commit"),
> +				 N_("name of the change to update")),
> +		OPT_BOOL('n', "new", &newchange,
> +			N_("create a new change - do not append to any existing change")),
> +		OPT_END()
> +	};
> +
> +	init_update_state(&state);
> +
> +	argc = parse_options(argc, argv, prefix, options, builtin_update_usage, 0);
> +
> +	if (force) state.options |= UPDATE_OPTION_FORCE;
> +	if (newchange) state.options |= UPDATE_OPTION_NOAPPEND;

Just use OPT_SET_INT_F() and skip the indirection thorugh OPT_BOOL(),
that macro itself is a thin wrapper for OPT_SET_INT_F().

I.e. you can drop these "force" and "newchange" variables, andjust set
your state.options directly.

> +int cmd_change(int argc, const char **argv, const char *prefix)
> +{
> +	/* No options permitted before subcommand currently */
> +	struct option options[] = {
> +		OPT_END()
> +	};
> +	int result = 1;
> +
> +	argc = parse_options(argc, argv, prefix, options, builtin_change_usage,
> +		PARSE_OPT_STOP_AT_NON_OPTION);
> +
> +	if (argc < 1)
> +		usage_with_options(builtin_change_usage, options);
> +	else if (!strcmp(argv[0], "update"))
> +		result = change_update(argc, argv, prefix);
> +	else {
> +		error(_("Unknown subcommand: %s"), argv[0]);
> +		usage_with_options(builtin_change_usage, options);
> +	}

This was presumably written before the recent OPT_SUBCOMMAND(), and
should instead use that API.
