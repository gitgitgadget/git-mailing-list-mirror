Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3154FC433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 12:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345152AbiBDMWq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 07:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237442AbiBDMWp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 07:22:45 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D48BC061714
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 04:22:45 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id m4so18921290ejb.9
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 04:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=8xOsVlU9GR41iVA568lsnRtZWcIVZQP5YpBQf+pYdLs=;
        b=cvDUj5nPN/lqWqW+Gz7ob9w3Z7NQpMxIRPY61DxmS3mdJqSKMfCR+lT53pJgvgpfdh
         Qchqg/ITfkXSAAym7r/diZlrJjI9Hp7vDBKAtepDxg324L3E44OU/329kT7EMvf7evgf
         uHM1CSQ14rXiKW80klmFUk19bezKSYc4okuwRnNb0O61qASYld9mn/HgpaR1e9PGR67f
         FZAvW9/Yrv+5/CezrE0rOXu5xee5mQBjHeRE0FEUfv+vacySe6he+9ZCiWz5hS1FbAoG
         Coov4n69jGCkK28/nxsoEF4c6aYlUQQ22Hv3DqITLDxjKR7rNq/hQKKUFnoxccg99tch
         76+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=8xOsVlU9GR41iVA568lsnRtZWcIVZQP5YpBQf+pYdLs=;
        b=78veKsr++uJRW1imsfsbY/YdZ4/rd9d+ryK6yqQGOsj7c0T1SqGEY7+cs6goeaBb8n
         iqTxx+OAhFFAmg/YK+XwRjeEaGVtT9FjOYYy9HcL+S1TfihPmKNmG0yqlI87sIHMA5ys
         VcBskobyXyVIMZ+Cf/UAM++zNfyHPt+6Ra6ugWO2LspejHm2DfhHbXMoxh8rNUYaRpyI
         VcDo0/HqIPxWKOPhjfTVjqyveqBz2/IjECAlUTe58Uen7xAkUxSaDif5wtwNT/w5UmeV
         M/0/2AClpQqsB4YFgmMOtteoTnFJnDPTbUsMjPzAgqKVIcONF++fwGXdfcDjRC9LYdij
         Pj4w==
X-Gm-Message-State: AOAM533hbcY36vnJQFjDjx/4H/wNx2LE4lDqlLhcPuDP95QWI1QkIqkZ
        wRK9yDQrnxlpfAszmhBVihhMZRsW3F59sw==
X-Google-Smtp-Source: ABdhPJzHRaaUX5Fscdz/JHrgTZbJxq+Rz/0aSBs81zh7TdP8/gMN3lOAhzcXtAc5HSCraH4ftCqYrg==
X-Received: by 2002:a17:907:2162:: with SMTP id rl2mr2269048ejb.467.1643977363453;
        Fri, 04 Feb 2022 04:22:43 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id lu44sm608810ejb.145.2022.02.04.04.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 04:22:42 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFxbu-0063z3-0i;
        Fri, 04 Feb 2022 13:22:42 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, phillip.wood123@gmail.com,
        e@80x24.org, bagasdotme@gmail.com, gitster@pobox.com,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 2/2] catfile.c: add --batch-command mode
Date:   Fri, 04 Feb 2022 13:11:34 +0100
References: <pull.1212.git.git.1643915286.gitgitgadget@gmail.com>
 <ebd2a1356017905245744babf32c5b78a0af1639.1643915286.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <ebd2a1356017905245744babf32c5b78a0af1639.1643915286.git.gitgitgadget@gmail.com>
Message-ID: <220204.86v8xu3jou.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 03 2022, John Cai via GitGitGadget wrote:

> From: John Cai <johncai86@gmail.com>

[Trying not to pile on and mentioning some things others haven't, but
maybe there'll be duplications]

>  	requested batch operation on all objects in the repository and
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 858bca208ff..29d5cd6857b 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -26,6 +26,7 @@ struct batch_options {
>  	int unordered;
>  	int mode; /* may be 'w' or 'c' for --filters or --textconv */
>  	const char *format;
> +	int command;
>  };

Not sure why it's not added to "int mode", but in any case
post-ab/cat-file that might be clearer...

> +	/* Read each line dispatch its command */
> +	while (!strbuf_getline(&input, stdin)) {

I think comments that are obvious from the code are probably best
dropped. We're just doing a fairly obvious consume stdin pattern here.

> +		int i;
> +		const struct parse_cmd *cmd = NULL;
> +		const char *p, *cmd_end;
> +
> +		if (state == BATCH_STATE_COMMAND) {
> +			if (*input.buf == '\n')
> +				die("empty command in input");
> +			else if (isspace(*input.buf))
> +				die("whitespace before command: %s", input.buf);

These should use _() to mark strings for translation, and let's quote %s
like '%s'

> +		}
> +
> +		for (i = 0; i < ARRAY_SIZE(commands); i++) {
> +			const char *prefix = commands[i].prefix;
> +			char c;

nit: add a \n between variable decls and code.

> +			if (!skip_prefix(input.buf, prefix, &cmd_end))
> +				continue;
> +			/*
> +			 * If the command has arguments, verify that it's
> +			 * followed by a space. Otherwise, it shall be followed
> +			 * by a line terminator.
> +			 */

I'd say ditto on the "the code says that" comments...

> +			c = commands[i].takes_args ? ' ' : '\n';
> +			if (*cmd_end && *cmd_end != c)
> +				die("arguments invalid for command: %s", commands[i].prefix);
> +
> +			cmd = &commands[i];
> +			if (cmd->takes_args)
> +				p = cmd_end + 1;
> +			break;
> +		}
> +
> +		if (input.buf[input.len - 1] == '\n')
> +			input.buf[--input.len] = '\0';

Don't we mean strbuf_trim_trailing_newline() here, or do we not want
Windows newlines to be accepted?

But more generally doesn't one of the strbuf_getline_*() functions do
the right thing here already?

> +
> +		if (state == BATCH_STATE_INPUT && !cmd){
> +			string_list_append(&revs, input.buf);

Nit: You can save yourself some malloc() churn here with:

    string_list_append_nodup(..., strbuf_detach(&input, NULL));

I.e. we're looping over the input, here we're done, so we might as well
steal the already alloc'd string....

> +			continue;
> +		}
> +
> +		if (!cmd)
> +			die("unknown command: %s", input.buf);
> +
> +		state = cmd->next_state;
> +		cmd->fn(opt, p, output, data, revs);
> +	}
> +	strbuf_release(&input);
> +	string_list_clear(&revs, 0);

...and these will do the right thing, as strbuf will notice the string
is stolen (it'll be the slopbuf again), and due to the combination of
*_DUP and *_nodup() we'll properly free it here too.

> +}
> +
>  static int batch_objects(struct batch_options *opt)
>  {
>  	struct strbuf input = STRBUF_INIT;
> @@ -519,6 +665,7 @@ static int batch_objects(struct batch_options *opt)
>  	struct expand_data data;
>  	int save_warning;
>  	int retval = 0;
> +	const int command = opt->command;
>  
>  	if (!opt->format)
>  		opt->format = "%(objectname) %(objecttype) %(objectsize)";
> @@ -594,22 +741,25 @@ static int batch_objects(struct batch_options *opt)
>  	save_warning = warn_on_object_refname_ambiguity;
>  	warn_on_object_refname_ambiguity = 0;
>  
> -	while (strbuf_getline(&input, stdin) != EOF) {
> -		if (data.split_on_whitespace) {
> -			/*
> -			 * Split at first whitespace, tying off the beginning
> -			 * of the string and saving the remainder (or NULL) in
> -			 * data.rest.
> -			 */
> -			char *p = strpbrk(input.buf, " \t");
> -			if (p) {
> -				while (*p && strchr(" \t", *p))
> -					*p++ = '\0';
> +	if (command)
> +		batch_objects_command(opt, &output, &data);
> +	else {

Style: {} braces for all arms if one requires it.

> +		while (strbuf_getline(&input, stdin) != EOF) {
> +			if (data.split_on_whitespace) {

diff nit: maybe we can find some way to not require re-indenting the existing code. E.g.:
	
	if (command) {
		batch_objects_command(...);
	        goto cleanup;
	}

...

> +				/*
> +				 * Split at first whitespace, tying off the beginning
> +				 * of the string and saving the remainder (or NULL) in
> +				 * data.rest.
> +				 */
> +				char *p = strpbrk(input.buf, " \t");
> +				if (p) {
> +					while (*p && strchr(" \t", *p))
> +						*p++ = '\0';
> +				}
> +				data.rest = p;
>  			}
> -			data.rest = p;
> +			batch_one_object(input.buf, &output, opt, &data);
>  		}
> -
> -		batch_one_object(input.buf, &output, opt, &data);
>  	}
>  

...and then just add a "cleanup:" label here.

>  	strbuf_release(&input);
> @@ -646,6 +796,7 @@ static int batch_option_callback(const struct option *opt,
>  
>  	bo->enabled = 1;
>  	bo->print_contents = !strcmp(opt->long_name, "batch");
> +	bo->command = !strcmp(opt->long_name, "batch-command");
>  	bo->format = arg;
>  
>  	return 0;
> @@ -682,6 +833,11 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>  			N_("show info about objects fed from the standard input"),
>  			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
>  			batch_option_callback),
> +		OPT_CALLBACK_F(0, "batch-command", &batch, N_(""),

You're either missing a string here in "", or we don't need N_() to mark
it for translation.

> +			 N_("enters batch mode that accepts commands"),
> +			 PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
> +			 batch_option_callback),
> +
>  		OPT_BOOL(0, "follow-symlinks", &batch.follow_symlinks,
>  			 N_("follow in-tree symlinks (used with --batch or --batch-check)")),
>  		OPT_BOOL(0, "batch-all-objects", &batch.all_objects,
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index 39382fa1958..7360d049113 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -85,6 +85,34 @@ $content"
>  	test_cmp expect actual
>      '
>  
> +    test -z "$content" ||
> +    test_expect_success "--batch-command output of $type content is correct" '
> +	maybe_remove_timestamp "$batch_output" $no_ts >expect &&
> +	maybe_remove_timestamp "$(echo contents $sha1 | git cat-file --batch-command)" $no_ts >actual &&
> +	test_cmp expect actual
> +    '
> +
> +    test -z "$content" ||
> +    test_expect_success "--batch-command session for $type content is correct" '
> +	maybe_remove_timestamp "$batch_output" $no_ts >expect &&
> +	maybe_remove_timestamp \
> +		"$(test_write_lines "begin" "$sha1" "get contents" | git cat-file --batch-command)" \
> +		$no_ts >actual &&
> +	test_cmp expect actual
> +    '
> +
> +    test_expect_success "--batch-command output of $type info is correct" '
> +	echo "$sha1 $type $size" >expect &&
> +	echo "info $sha1" | git cat-file --batch-command >actual &&
> +	test_cmp expect actual
> +    '
> +
> +    test_expect_success "--batch-command session for $type info is correct" '
> +	echo "$sha1 $type $size" >expect &&
> +	test_write_lines "begin" "$sha1" "get info" | git cat-file --batch-command >actual &&
> +	test_cmp expect actual
> +    '
> +
>      test_expect_success "custom --batch-check format" '
>  	echo "$type $sha1" >expect &&
>  	echo $sha1 | git cat-file --batch-check="%(objecttype) %(objectname)" >actual &&
> @@ -141,6 +169,7 @@ test_expect_success '--batch-check without %(rest) considers whole line' '
>  '
>  
>  tree_sha1=$(git write-tree)
> +

stray newline addition.

>  tree_size=$(($(test_oid rawsz) + 13))
>  tree_pretty_content="100644 blob $hello_sha1	hello"
>  
> @@ -175,7 +204,7 @@ test_expect_success \
>      "Reach a blob from a tag pointing to it" \
>      "test '$hello_content' = \"\$(git cat-file blob $tag_sha1)\""
>  
> -for batch in batch batch-check
> +for batch in batch batch-check batch-command
>  do
>      for opt in t s e p
>      do
> @@ -281,6 +310,15 @@ test_expect_success "--batch-check with multiple sha1s gives correct format" '
>      "$(echo_without_newline "$batch_check_input" | git cat-file --batch-check)"
>  '
>  
> +test_expect_success "--batch-command with multiple sha1s gives correct format" '
> +    echo "$batch_check_output" >expect &&
> +    echo begin >input &&
> +    echo_without_newline "$batch_check_input" >>input &&
> +    echo "get info" >>input &&
> +    git cat-file --batch-command <input >actual &&
> +    test_cmp expect actual
> +'

indentation with spaces, \t correctly used for the rest.
