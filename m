Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42227C5479D
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 11:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjAKLaf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 06:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjAKLa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 06:30:28 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC053101A
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 03:30:23 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso14100881wms.5
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 03:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TgIkQMi93pf4G4Z7JzBmNLU+7392XwPD07crHBU5E4Q=;
        b=UGcSLkflqZkjICEejZr6rfkVsayjeR3nvQVtBwfo5bO7jW3yHZAO16kr7cBre4yB+c
         JLpTmKjE5V8qNxQ1wiQZMduEcLHB1FE5tu64bN7dR7LLMZBgusgsijIQCYbEAkKvYuPc
         ThPJtlR0XNKJJgSOtzZL3viVObSF67VZ7xYpiT3UBMCj4ey6/SlUoqD4N+XTug7f9PMN
         gwKTqsp2jThROHFXSeLXKbUbMOG5hlS0+imTjU4fbBNwGN2+GZX3st5ED9XYbls7R28r
         8X4v1xZAAqznGlhW2RzZ5nfXi/gnR6sdLUwb4hR2rPaDMfIeITGOwZnXb3PmlGNuLnK8
         tdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgIkQMi93pf4G4Z7JzBmNLU+7392XwPD07crHBU5E4Q=;
        b=b0CnqmOqEI31DL22pOczYRk2VN7VELGeVLWZ1Cqpe2M0ifFEXym3R1v2nXhUacBxZq
         A8/uFdCjLo3GM2AxmEiIAbGKth3UdyonSTqmtKaAU2yNh4CGgXFba+cdq3ZjU16GVUdI
         dp/m0dieGROFqyU3dsERFL2Wkix+bORvKH6GOfFonxGn71srRkX7xp/swKnB69k5Y1jt
         +tHlnY84yzALDykd76w3V9oObCZueUOOovfbnGZZlvvOfdE7ucl0uRcLOZVKB5ayLT/X
         R+EpzyCws5EsQ2RYRJG/9lHgUo5g+FTKEgBAkkJq1GFhxOoQTAgcw6g6jJrizoA/NzyJ
         oOLg==
X-Gm-Message-State: AFqh2kqPOpmum3e5UDQ7+iuiglp++Q1TalVgDb4rFQiUlZb9MwwAHgBk
        s0vJhoZdXA1fCVRpZx5qDdQ=
X-Google-Smtp-Source: AMrXdXs9bXItT3zQvk+xjUuL0l4+tSuLfw510Jgf04Vr0K1s+BM2PRP3ghWFsNVZk1nks3pdJj60uA==
X-Received: by 2002:a05:600c:34c2:b0:3cf:7397:c768 with SMTP id d2-20020a05600c34c200b003cf7397c768mr51669228wmq.30.1673436622379;
        Wed, 11 Jan 2023 03:30:22 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c314f00b003d99469ece1sm24172135wmo.24.2023.01.11.03.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 03:30:21 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <4fc57003-3f29-2f1c-fe18-94b5f9f1bf2b@dunelm.org.uk>
Date:   Wed, 11 Jan 2023 11:30:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 2/2] attr: add flag `--source` to work with tree-ish
Content-Language: en-US
To:     Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc:     Toon Claes <toon@iotcl.com>
References: <https://lore.kernel.org/git/cover.1671630304.git.karthik.188@gmail.com/>
 <cover.1671793109.git.karthik.188@gmail.com>
 <23813496fc73b7e5cb9f09b166e05c9a02bac43c.1671793109.git.karthik.188@gmail.com>
In-Reply-To: <23813496fc73b7e5cb9f09b166e05c9a02bac43c.1671793109.git.karthik.188@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Karthik

On 02/01/2023 11:04, Karthik Nayak wrote:
> The contents of the .gitattributes files may evolve over time, but "git
> check-attr" always checks attributes against them in the working tree
> and/or in the index. It may be beneficial to optionally allow the users
> to check attributes taken from a commit other than HEAD against paths.
> 
> Add a new flag `--source` which will allow users to check the
> attributes against a commit (actually any tree-ish would do). When the
> user uses this flag, we go through the stack of .gitattributes files but
> instead of checking the current working tree and/or in the index, we
> check the blobs from the provided tree-ish object. This allows the
> command to also be used in bare repositories.
> 
> Since we use a tree-ish object, the user can pass "--source
> HEAD:subdirectory" and all the attributes will be looked up as if
> subdirectory was the root directory of the repository.

I think changing to --source is a good idea. I've left a few comments 
below - the tests are broken at the moment. I didn't look very closely 
at the implementation beyond scanning the range-diff as it looks like 
there are not any significant changes there.

> We cannot simply use the `<rev>:<path>` syntax without the `--source`
> flag, similar to how it is used in `git show` because any non-flag
> parameter before `--` is treated as an attribute and any parameter after
> `--` is treated as a pathname.
> 
> The change involves creating a new function `read_attr_from_blob`, which
> given the path reads the blob for the path against the provided source and
> parses the attributes line by line. This function is plugged into
> `read_attr()` function wherein we go through the stack of attributes
> files.
> 
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> Co-authored-by: toon@iotcl.com
> ---
> -'git check-attr' [-a | --all | <attr>...] [--] <pathname>...
> -'git check-attr' --stdin [-z] [-a | --all | <attr>...]
> +'git check-attr' [--source <tree>] [-a | --all | <attr>...] [--] <pathname>...
> +'git check-attr' --stdin [-z] [--source <tree>] [-a | --all | <attr>...]

I think "<tree>" would be better as "<tree-ish>" (see my comments on the 
--source option implementation below)
>   
>   DESCRIPTION
>   -----------
> @@ -36,6 +36,12 @@ OPTIONS
>   	If `--stdin` is also given, input paths are separated
>   	with a NUL character instead of a linefeed character.
>   
> +--source=<tree>::
> +	Check attributes against the specified tree-ish. Paths provided as part
> +	of the revision will be treated as the root directory. It is common to
> +	specify the source tree by naming a commit, branch or tag associated
> +	with it.

I think it is confusing to keep the reference to "revision" here, we 
could just drop that sentence.

> -N_("git check-attr [-a | --all | <attr>...] [--] <pathname>..."),
> -N_("git check-attr --stdin [-z] [-a | --all | <attr>...]"),
> +N_("git check-attr [--source <tree>] [-a | --all | <attr>...] [--] <pathname>..."),
> +N_("git check-attr --stdin [-z] [--source <tree>] [-a | --all | <attr>...]"),

I think we should use "<tree-ish>" rather than "<tree>" so it is clear 
one can specify a commit or tag. That's what "git restore" does.

> diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
> index b3aabb8aa3..78e9f47dbf 100755
> --- a/t/t0003-attributes.sh
> +++ b/t/t0003-attributes.sh
> @@ -25,7 +25,15 @@ attr_check_quote () {
>   	git check-attr test -- "$path" >actual &&
>   	echo "\"$quoted_path\": test: $expect" >expect &&
>   	test_cmp expect actual
> +}
> +
> +attr_check_source () {
> +	path="$1" expect="$2" source="$3" git_opts="$4" &&
>   
> +	git $git_opts check-attr --source $source test -- "$path" >actual 2>err &&
> +	echo "$path: test: $expect" >expect &&
> +	test_cmp expect actual

This is missing && which means we miss some test failures later

> +	test_must_be_empty err
>   }
>   

> +test_expect_success 'setup branches' '
> +	mkdir -p foo/bar &&
> +	test_commit --printf "add .gitattributes" foo/bar/.gitattribute \

The file should be foo/bar/.gitattributes (not .gitattribute). We're 
missing failures due to this because of the missing && above

> +		"f test=f\na/i test=n\n" tag-1 &&
> +
> +	mkdir -p foo/bar &&

We don't need to make the directory again here

> +	test_commit --printf "add .gitattributes" foo/bar/.gitattribute \
> +		"g test=g\na/i test=m\n" tag-2

I think it would be worth either removing foo/bar/.gitattributes or 
donig test_write_lines to change it. That way we can be sure all the 
--source tests are actually using the tree-ish we give it and not just 
reading from the filesystem.

Best Wishes

Phillip

> +'
> +
>   test_expect_success 'command line checks' '
>   	test_must_fail git check-attr &&
>   	test_must_fail git check-attr -- &&
>   	test_must_fail git check-attr test &&
>   	test_must_fail git check-attr test -- &&
>   	test_must_fail git check-attr -- f &&
> +	test_must_fail git check-attr --source &&
> +	test_must_fail git check-attr --source not-a-valid-ref &&
>   	echo "f" | test_must_fail git check-attr --stdin &&
>   	echo "f" | test_must_fail git check-attr --stdin -- f &&
>   	echo "f" | test_must_fail git check-attr --stdin test -- f &&
> @@ -287,6 +306,15 @@ test_expect_success 'using --git-dir and --work-tree' '
>   	)
>   '
>   
> +test_expect_success 'using --source' '
> +	attr_check_source foo/bar/f f tag-1 &&
> +	attr_check_source foo/bar/a/i n tag-1 &&
> +	attr_check_source foo/bar/f unspecified tag-2 &&
> +	attr_check_source foo/bar/a/i m tag-2 &&
> +	attr_check_source foo/bar/g g tag-2 &&
> +	attr_check_source foo/bar/g unspecified tag-1
> +'
> +
>   test_expect_success 'setup bare' '
>   	git clone --template= --bare . bare.git
>   '
> @@ -306,6 +334,18 @@ test_expect_success 'bare repository: check that .gitattribute is ignored' '
>   	)
>   '
>   
> +test_expect_success 'bare repository: with --source' '
> +	(
> +		cd bare.git &&
> +		attr_check_source foo/bar/f f tag-1 &&
> +		attr_check_source foo/bar/a/i n tag-1 &&
> +		attr_check_source foo/bar/f unspecified tag-2 &&
> +		attr_check_source foo/bar/a/i m tag-2 &&
> +		attr_check_source foo/bar/g g tag-2 &&
> +		attr_check_source foo/bar/g unspecified tag-1
> +	)
> +'
> +
>   test_expect_success 'bare repository: check that --cached honors index' '
>   	(
>   		cd bare.git &&
> diff --git a/userdiff.c b/userdiff.c
> index 151d9a5278..b66f090a0b 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -412,7 +412,7 @@ struct userdiff_driver *userdiff_find_by_path(struct index_state *istate,
>   		check = attr_check_initl("diff", NULL);
>   	if (!path)
>   		return NULL;
> -	git_check_attr(istate, path, check);
> +	git_check_attr(istate, NULL, path, check);
>   
>   	if (ATTR_TRUE(check->items[0].value))
>   		return &driver_true;
> diff --git a/ws.c b/ws.c
> index 6e69877f25..eadbbe5667 100644
> --- a/ws.c
> +++ b/ws.c
> @@ -78,7 +78,7 @@ unsigned whitespace_rule(struct index_state *istate, const char *pathname)
>   	if (!attr_whitespace_rule)
>   		attr_whitespace_rule = attr_check_initl("whitespace", NULL);
>   
> -	git_check_attr(istate, pathname, attr_whitespace_rule);
> +	git_check_attr(istate, NULL, pathname, attr_whitespace_rule);
>   	value = attr_whitespace_rule->items[0].value;
>   	if (ATTR_TRUE(value)) {
>   		/* true (whitespace) */
