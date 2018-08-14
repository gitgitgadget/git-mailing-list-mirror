Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6046A1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 20:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbeHNXZP (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 19:25:15 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55912 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbeHNXZP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 19:25:15 -0400
Received: by mail-wm0-f68.google.com with SMTP id f21-v6so13554599wmc.5
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 13:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wipxbL9uZCSaH5KzAXct+oa8Qw9ruEBe/t1BiaP3fo4=;
        b=k/gIuyB4c6dB2jKHuGmYZktq5sMbkpIF7no6vDaroQGkKpEu/BNpIG1eXu8yNdxH6r
         i5mVhiRrasN4/4RLYALHqjzRwIQxH3R0ZZKDydYBUZGLq3EqITDX/1QaoSC3D273rPBz
         Oyj4rbzUfxfqH5xbQaREnSsjyuOMjkdbULKPCBfKlRUzCzWHeoQ2jhUg2qsnFe+HqVsn
         E960YEIYSPTfnVoCDNovehv19VM9FYye3lgyHZw6tplX8YrhxR24L+nbTkcWSh6DO8Ak
         7xferAoAgwPAzHHCw/4DwvZ+vcjnoWP81LoItWUmSuGBWgrY99a4W9LcLikSyfYJb+d4
         q+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wipxbL9uZCSaH5KzAXct+oa8Qw9ruEBe/t1BiaP3fo4=;
        b=DeVuhW0vrOJTwc0Eo8HCX+vp8Qx/ULd4QQnHXrDBt5wTsdYk6P6bNp+yt0OPJCdkji
         sHZNkKUzPjPvT74b4glDdc2u2ZGJAe/Ix4uHynNRCx7TWZG5n2SD9H8wnox0OOXjMqAk
         t7W5iR3BLqOZvbXC7fkTdrbIY1ftyKbafeH1bDFczpYyly7VxQ7gbPqNawYNYh7KfBGu
         5T+BGECUAdZuuc6latMIYJlhb5X4QbyvYIFhCcj5eNo6FvPjEZBOl5dRUtQyCqmCnc78
         atXbCss5BT+8NzGs+s+j5lH2UAvRSwW3b/EkOBzG9Om1/IBGNKvIWhrqbnzB27WQJNzW
         sQFA==
X-Gm-Message-State: AOUpUlFWPi/kyeR25yoGqxTscmRDeMlS2mrpbSqqtJofirSm9fpKeoUb
        ziNfd2KIG/3SUugmWIYFwAo=
X-Google-Smtp-Source: AA+uWPw4vw34SCY9DvlQ9IpvjEExcquyUtCbOkEWe1Sp5WJwdxwY8OwPxEvDeYLKsbj7KmREPWYaLw==
X-Received: by 2002:a1c:bb86:: with SMTP id l128-v6mr11653436wmf.26.1534278978638;
        Tue, 14 Aug 2018 13:36:18 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k6-v6sm20921686wrv.92.2018.08.14.13.36.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 13:36:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Daniel =?utf-8?Q?Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 7/7] submodule: support reading .gitmodules even when it's not checked out
References: <20180814110525.17801-1-ao2@ao2.it>
        <20180814110525.17801-8-ao2@ao2.it>
Date:   Tue, 14 Aug 2018 13:36:17 -0700
In-Reply-To: <20180814110525.17801-8-ao2@ao2.it> (Antonio Ospite's message of
        "Tue, 14 Aug 2018 13:05:25 +0200")
Message-ID: <xmqqmutoznwe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Antonio Ospite <ao2@ao2.it> writes:

>  	/* Equivalent to ACTION_SET in builtin/config.c */
> -	if (argc == 3)
> +	if (argc == 3) {
> +		struct object_id oid;
> +
> +		/*
> +		 * If the .gitmodules file is not in the working tree but it
> +		 * is in the current branch, stop, as writing new values (and
> +		 * staging them) would blindly overwrite ALL the old content.

Hmph, "the file is missing" certainly is a condition we would want
to notice, but wouldn't we in general want to prevent us from
overwriting any local modification, where "missing" is merely a very
special case of local modification?  I am wondering if we would want
to stop if .gitmodules file exists both in the working tree and in
the index, and the contents of them differ, or something like that.

> diff --git a/git-submodule.sh b/git-submodule.sh
> index ff258e2e8c..b1cb187227 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -159,6 +159,13 @@ cmd_add()
>  		shift
>  	done
>  
> +	# For more details about this check, see
> +	# builtin/submodule--helper.c::module_config()
> +	if test ! -e .gitmodules && git cat-file -e HEAD:.gitmodules > /dev/null 2>&1

No SP between redirection '>' and its target '/dev/null'.

More importantly, I think it is better to add a submodule--helper
subcommand that exposes the check in question, as the code is
already written ;-) That approach will guarantee that the logic and
the message stay the same between here and in the C code.  Then you
do not even need these two line comment.

> +	then
> +		 die "$(eval_gettext "please make sure that the .gitmodules file in the current branch is checked out")"
> +	fi
> +

> diff --git a/submodule-config.c b/submodule-config.c
> index b7ef055c63..088dabb56f 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -1,4 +1,5 @@
>  #include "cache.h"
> +#include "dir.h"
>  #include "repository.h"
>  #include "config.h"
>  #include "submodule-config.h"
> @@ -603,8 +604,19 @@ static void submodule_cache_check_init(struct repository *repo)
>  static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void *data)
>  {
>  	if (repo->worktree) {
> -		char *file = repo_worktree_path(repo, GITMODULES_FILE);
> -		git_config_from_file(fn, file, data);
> +		struct git_config_source config_source = { 0 };
> +		const struct config_options opts = { 0 };
> +		struct object_id oid;
> +		char *file;
> +
> +		file = repo_worktree_path(repo, GITMODULES_FILE);
> +		if (file_exists(file))
> +			config_source.file = file;
> +		else if (get_oid(GITMODULES_HEAD, &oid) >= 0)
> +			config_source.blob = GITMODULES_HEAD;

What is the reason why we fall back directly to HEAD when working
tree file does not exist?  I thought that our usual fallback was to
the version in the index for other things like .gitignore/attribute
and this codepath look like an oddball.  Are you trying to handle
the case where we are in a bare repository without any file checked
out (and there is not even the index)?

> diff --git a/t/t7416-submodule-sparse-gitmodules.sh b/t/t7416-submodule-sparse-gitmodules.sh
> new file mode 100755
> index 0000000000..5341e9b012
> --- /dev/null
> +++ b/t/t7416-submodule-sparse-gitmodules.sh
> @@ -0,0 +1,90 @@
> +#!/bin/sh
> +#
> +# Copyright (C) 2018  Antonio Ospite <ao2@ao2.it>
> +#
> +
> +test_description='Test reading/writing .gitmodules when not in the working tree
> +
> +This test verifies that, when .gitmodules is in the current branch but is not
> +in the working tree reading from it still works but writing to it does not.
> +
> +The test setup uses a sparse checkout, however the same scenario can be set up
> +also by committing .gitmodules and then just removing it from the filesystem.
> +'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'sparse checkout setup which hides .gitmodules' '
> +	echo file > file &&

No SP between redirection '>' and its target 'file'.

> +	git add file &&
> +	test_tick &&
> +	git commit -m upstream &&
> +	git clone . super &&
> +	git clone super submodule &&
> +	git clone super new_submodule &&
> +	(cd super &&
> +		git submodule add ../submodule &&
> +		test_tick &&
> +		git commit -m submodule &&
> +		cat >.git/info/sparse-checkout <<\EOF &&
> +/*
> +!/.gitmodules
> +EOF

You can use <<-\EOF and indent the body of the here-doc, which makes
the result easier to read, i.e.

		cat >target <<-\EOF &&
		line 1
		line 2
		EOF

> +		git config core.sparsecheckout true &&
> +		git read-tree -m -u HEAD &&

That's old fashioned---I am curious if this has to be one-way merge
or can just be a usual "git checkout" (I am merely curious; not
suggesting to change anything).

> +		test_path_is_missing .gitmodules
> +	)
> +'
> +
> +test_expect_success 'reading gitmodules config file when it is not checked out' '
> +	(cd super &&
> +		echo "../submodule" >expected &&
> +		git submodule--helper config submodule.submodule.url >actual &&
> +		test_cmp expected actual

A minor style thing, but I thought that it was more common in our
tests to call the expected output 'expect' (which has the same
number of letters as 'actual') than 'expected'.

More importantly, do we want a subshell, or is something like this
sufficient?

	echo "../submodule" >expected &&
	git -C super submodule--helper config ... >actual &&
	test_cmp expect actual

The same comment applies to many tests I see below (omitted).

