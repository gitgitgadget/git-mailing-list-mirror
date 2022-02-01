Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54282C433EF
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 10:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbiBAKne (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 05:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiBAKne (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 05:43:34 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372D6C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 02:43:33 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id w11so31075641wra.4
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 02:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1sVSMrTsx0fKuKgIFfCQoGxJ4S+aWhWxkNwkaZ+W9H0=;
        b=h6HCCwBOQ+6YS1Gv9GHXap1jk5T5LrCNk0w8+S1sb1X1p/Y4svrO4Qdv0b4txEVTXw
         rK5mOy5ehaS6GavJlzkgcfeEfb6j/RSVUyU/zk4sykPZBSorRTigOXmqYDTKaobc9JFc
         1FvqbbOTB0DXUnaA4A9Lws5XFgYYKXDgmyBH9NS3LJoqONA9Jdgq5phG4aPqLZI2GcWd
         jdN079syL740kLAP0t65JISlks3cILTII22HELspinoeLFdSz6jCf6sVsSDUG9hVyNa9
         Z5Esmw+RlDKjXj5Ie0tagjRQg5cC91cjtkZF3pTHN1DzCaLZ3UDdGmCg0HeahhvHXH0c
         8buw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1sVSMrTsx0fKuKgIFfCQoGxJ4S+aWhWxkNwkaZ+W9H0=;
        b=dDVvQ4IaPmE5fzyzsY6cE2CBdUMLCuvOD9c5RyZjW5E3O1dWMipmdbBB0tV82Ff4oi
         9QmMcpjA7Nzy4KobiTNpTpiLBZBRt/N+yM02Y/oF2ffUU9onUvonh4Q6rxiOvA4TRyfB
         GVdRdNSJwERcc3NhSRyLP20F/LxxzNiv0UsdPRr9e4BxdCy3TlTFm7u9E+6LM/94Yk4t
         oYlkOEanEwu3l0D/joo4C7SuqiFvK8hsU7BBiyxhr871nS7Db/mDqmE5J//0w9WDHfE/
         7KZW2bJj1o/nh3BTXpauB2TuJ1u70a7fdhH0/W6uDYvIBJdY2QY3QQN+dlu43qTTjPh1
         yaZA==
X-Gm-Message-State: AOAM530pqcDeDL0KcxWatdMY6PAqtRZvEOXuifnRKgdnA6mUR7InJpgI
        hM34ZmcFFymRfDbTcbJ5l3E=
X-Google-Smtp-Source: ABdhPJxRXv594z3Zd/u5CFHBF57iuMGHnjP7uXCI0s+ZlWarDIt4Je2NB7ZTjaxoj6NseyC65kPv2A==
X-Received: by 2002:a5d:4390:: with SMTP id i16mr11703485wrq.516.1643712211630;
        Tue, 01 Feb 2022 02:43:31 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id m11sm1594261wmi.16.2022.02.01.02.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 02:43:31 -0800 (PST)
Message-ID: <e75ba9ea-fdda-6e9f-4dd6-24190117d93b@gmail.com>
Date:   Tue, 1 Feb 2022 10:43:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC v3] cat-file: add a --stdin-cmd mode
Content-Language: en-US
To:     John Cai <johncai86@gmail.com>, git@vger.kernel.org
Cc:     avarab@gmail.com, me@ttaylorr.com, e@80x24.org
References: <20220128183319.43496-1-johncai86@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20220128183319.43496-1-johncai86@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John

On 28/01/2022 18:33, John Cai wrote:
> This RFC patch proposes a new flag --batch-command that works with
> git-cat-file --batch. Similar to git-update-ref --stdin, it will accept
> commands and arguments from stdin.
> 
> The start of this idea was discussed in [1], where the original
> motivation was to be able to control when the buffer was flushed to
> stdout in --buffer mode.
> 
> However, this can actually be much more useful in situations when
> git-cat-file --batch is being used as a long lived backend query
> process. At GitLab, we use a pair of cat-file processes. One for
> iterating over object metadata with --batch-check, and the other to grab
> object contents with --batch. However, if we had --batch-command, we could
> get rid of the second --batch-check process, and just have one process
> where we can flip between getting object info, and getting object contents.
> This can lead to huge savings since on a given server there could be hundreds to
> thousands of git cat-file processes at a time.
> 
> git cat-file --batch-command
> 
> $ <command> [arg1] [arg2] NL
> 
> This patch adds three commands: object, info, fflush
> 
> $ object <sha1> NL
> $ info <sha1> NL
> $ fflush NL
> 
> These three would be immediately useful in GitLab's context, but one can
> imagine this mode to be further extended for other things.

I think this is moving in the right direction, I've left some comments 
below.

> Future improvements:
> - a non-trivial part of "cat-file --batch" time is spent
> on parsing its argument and seeing if it's a revision, ref etc. So we
> could add a command that only accepts a full-length 40
> character SHA-1.
> 
> This would be the first step in adding such an interface to
> git-cat-file.
> 
> [1] https://lore.kernel.org/git/pull.1124.git.git.1636149400.gitgitgadget@gmail.com/
> 
> Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
> 
> Taylor, I'd be interested in your thoughts on this proposal since you helped
> review the previous patch that turned into this RFC. Thanks!
> 
> Changes from v2:
> 
> - refactored tests to be within run_tests()
> - added a test to test --buffer behavior with fflush
> - cleaned up cat-file.c: clarified var names, removed unnecessary code
>    based on suggestions from Phillip Wood
> - removed strvec changes
> 
> Changes from v1:
> 
> - changed option name to batch-command.
> - changed command function interface to receive the whole line after the command
>    name to put the onus of parsing arguments to each individual command function.
> - pass in whole line to batch_one_object in both parse_cmd_object and
>    parse_cmd_info to support spaces in the object reference.
> - removed addition of -z to include in a separate patch series
> - added documentation.
> ---
>   Documentation/git-cat-file.txt |  15 +++++
>   builtin/cat-file.c             | 114 +++++++++++++++++++++++++++++++--
>   t/t1006-cat-file.sh            |  83 ++++++++++++++++++++++++
>   3 files changed, 205 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
> index bef76f4dd0..254e546c79 100644
> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -96,6 +96,21 @@ OPTIONS
>   	need to specify the path, separated by whitespace.  See the
>   	section `BATCH OUTPUT` below for details.
>   
> +--batch-command::
> +	Enter a command mode that reads from stdin. May not be combined with any
> +	other options or arguments except `--textconv` or `--filters`, in which
> +	case the input lines also need to specify the path, separated by
> +	whitespace.  See the section `BATCH OUTPUT` below for details.
> +
> +object <object>::
> +	Print object contents for object reference <object>
> +
> +info <object>::
> +	Print object info for object reference <object>
> +
> +flush::

I think this is a better name than fflush as calling fflush is just an 
implementation detail. I've been thinking about this and have some 
concerns with the current implementation as it allows the caller to 
force a flush but the output may be flushed at other times and so it 
does not allow for deadlock free reading and writing to cat-file from a 
single process. If instead we buffered the input lines and only 
processed then when we received a flush command it would be easy to read 
and write to cat-file from a single process without deadlocks. This 
would mean that callers would have to add flush commands to get any 
output before they closed the pipe writing to cat-file.

> +	Flush to stdout immediately when used with --buffer
> +
>   --batch-all-objects::
>   	Instead of reading a list of objects on stdin, perform the
>   	requested batch operation on all objects in the repository and
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 7b3f42950e..cc9e47943b 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -24,9 +24,11 @@ struct batch_options {
>   	int buffer_output;
>   	int all_objects;
>   	int unordered;
> -	int cmdmode; /* may be 'w' or 'c' for --filters or --textconv */
> +	int mode; /* may be 'w' or 'c' for --filters or --textconv */

If you really need to rename  this variable then doing that in a 
separate preparatory patch would make this easier to review as it 
separates out two separate sets of changes.

>   	const char *format;
> +	int command;

Can't we just call this batch_command and leave cmdmode alone? I don't 
know maybe cmdmode would be confused with having something to do with 
batch_command then.

>   };
> +static char line_termination = '\n';

This seems unnecessary as it is the only permitted line ending

>   static const char *force_path;
>   
> @@ -302,19 +304,19 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
>   	if (data->type == OBJ_BLOB) {
>   		if (opt->buffer_output)
>   			fflush(stdout);
> -		if (opt->cmdmode) {
> +		if (opt->mode) {
>   			char *contents;
>   			unsigned long size;
>   
>   			if (!data->rest)
>   				die("missing path for '%s'", oid_to_hex(oid));
>   
> -			if (opt->cmdmode == 'w') {
> +			if (opt->mode == 'w') {
>   				if (filter_object(data->rest, 0100644, oid,
>   						  &contents, &size))
>   					die("could not convert '%s' %s",
>   					    oid_to_hex(oid), data->rest);
> -			} else if (opt->cmdmode == 'c') {
> +			} else if (opt->mode == 'c') {
>   				enum object_type type;
>   				if (!textconv_object(the_repository,
>   						     data->rest, 0100644, oid,
> @@ -326,7 +328,7 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
>   					die("could not convert '%s' %s",
>   					    oid_to_hex(oid), data->rest);
>   			} else
> -				BUG("invalid cmdmode: %c", opt->cmdmode);
> +				BUG("invalid mode: %c", opt->mode);
>   			batch_write(opt, contents, size);
>   			free(contents);
>   		} else {
> @@ -508,6 +510,95 @@ static int batch_unordered_packed(const struct object_id *oid,
>   				      data);
>   }
>   
> +static void parse_cmd_object(struct batch_options *opt,
> +			     const char *line,
> +			     struct strbuf *output,
> +			     struct expand_data *data)
> +{
> +	opt->print_contents = 1;
> +	batch_one_object(line, output, opt, data);
> +}
> +
> +static void parse_cmd_info(struct batch_options *opt,
> +			   const char *line,
> +			   struct strbuf *output,
> +			   struct expand_data *data)
> +{
> +	opt->print_contents = 0;
> +	batch_one_object(line, output, opt, data);
> +}
> +
> +static void parse_cmd_fflush(struct batch_options *opt,
> +			     const char *line,
> +			     struct strbuf *output,
> +			     struct expand_data *data)
> +{
> +	fflush(stdout);
> +}
> +
> +typedef void (*parse_cmd_fn_t)(struct batch_options *, const char *,
> +			       struct strbuf *, struct expand_data *);
> +
> +static const struct parse_cmd {
> +	const char *prefix;
> +	parse_cmd_fn_t fn;
> +	unsigned takes_args;
> +} commands[] = {
> +	{ "object", parse_cmd_object, 1},
> +	{ "info", parse_cmd_info, 1},
> +	{ "fflush", parse_cmd_fflush, 0},
> +};
> +
> +static void batch_objects_command(struct batch_options *opt,
> +				    struct strbuf *output,
> +				    struct expand_data *data)
> +{
> +	struct strbuf input = STRBUF_INIT;
> +
> +	/* Read each line dispatch its command */
> +	while (!strbuf_getwholeline(&input, stdin, line_termination)) {
> +		int i;
> +		const struct parse_cmd *cmd = NULL;
> +		const char *p, *cmd_end;
> +
> +		if (*input.buf == line_termination)
> +			die("empty command in input");
> +		else if (isspace(*input.buf))
> +			die("whitespace before command: %s", input.buf);
> +
> +		for (i = 0; i < ARRAY_SIZE(commands); i++) {
> +			const char *prefix = commands[i].prefix;
> +			char c;
> +			if (!skip_prefix(input.buf, prefix, &cmd_end))
> +				continue;
> +			/*
> +			 * If the command has arguments, verify that it's
> +			 * followed by a space. Otherwise, it shall be followed
> +			 * by a line terminator.
> +			 */
> +			c = commands[i].takes_args ? ' ' : line_termination;
> +			if (input.buf[strlen(prefix)] != c)

As I pointed out in the last round you can use cmd_end here rather than 
calling strlen. I've just noticed that this will fail for a command that 
does not take arguments when the last input line does not end with '\n'. 
I think
	if (*cmd_end && *cmd_end != c)
would be safer

> +				die("arguments invalid for command: %s", commands[i].prefix);
> +
> +			cmd = &commands[i];
> +			if (cmd->takes_args) {
> +				p = cmd_end + 1;
> +				// strip newline before handing it to the
> +				// handling function
> +				input.buf[strcspn(input.buf, "\n")] = '\0';

When I suggested replacing strstr() last time I failed to notice that we 
  know that if there is a newline character it is at input.buf[len - 1] 
so we don't need to scan the whole string to find it.

	if (input.buf[input.len - 1] == '\n')
		input.buf[--buf.len] = '\0';

(feel free to change it to avoid the prefix operator)

> +			}
> +
> +			break;
> +		}
> +
> +		if (!cmd)
> +			die("unknown command: %s", input.buf);
> +
> +		cmd->fn(opt, p, output, data);
> +	}
> +	strbuf_release(&input);
> +}
> +
>   static int batch_objects(struct batch_options *opt)
>   {
>   	struct strbuf input = STRBUF_INIT;
> @@ -515,6 +606,7 @@ static int batch_objects(struct batch_options *opt)
>   	struct expand_data data;
>   	int save_warning;
>   	int retval = 0;
> +	const int command = opt->command;
>   
>   	if (!opt->format)
>   		opt->format = "%(objectname) %(objecttype) %(objectsize)";
> @@ -529,7 +621,7 @@ static int batch_objects(struct batch_options *opt)
>   	strbuf_expand(&output, opt->format, expand_format, &data);
>   	data.mark_query = 0;
>   	strbuf_release(&output);
> -	if (opt->cmdmode)
> +	if (opt->mode)
>   		data.split_on_whitespace = 1;
>   
>   	/*
> @@ -590,6 +682,9 @@ static int batch_objects(struct batch_options *opt)
>   	save_warning = warn_on_object_refname_ambiguity;
>   	warn_on_object_refname_ambiguity = 0;
>   
> +	if (command)
> +		batch_objects_command(opt, &output, &data);
> +

Moving this is good as we no longer need to touch the line below

>   	while (strbuf_getline(&input, stdin) != EOF) {
>   		if (data.split_on_whitespace) {
>   			/*
> @@ -636,6 +731,7 @@ static int batch_option_callback(const struct option *opt,
>   
>   	bo->enabled = 1;
>   	bo->print_contents = !strcmp(opt->long_name, "batch");
> +	bo->command = !strcmp(opt->long_name, "batch-command");
>   	bo->format = arg;
>   
>   	return 0;
> @@ -683,6 +779,10 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>   			N_("like --batch, but don't emit <contents>"),
>   			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
>   			batch_option_callback),
> +		OPT_CALLBACK_F(0, "batch-command", &batch, N_(""),
> +			 N_("enters batch mode that accepts commands"),
> +			 PARSE_OPT_NOARG | PARSE_OPT_NONEG,
> +			 batch_option_callback),
>   		OPT_CMDMODE(0, "batch-all-objects", &opt,
>   			    N_("with --batch[-check]: ignores stdin, batches all known objects"), 'b'),
>   		/* Batch-specific options */
> @@ -742,7 +842,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>   	/* Return early if we're in batch mode? */
>   	if (batch.enabled) {
>   		if (opt_cw)
> -			batch.cmdmode = opt;
> +			batch.mode = opt;
>   		else if (opt && opt != 'b')
>   			usage_msg_optf(_("'-%c' is incompatible with batch mode"),
>   				       usage, options, opt);
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index 145eee11df..92f0b14a95 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -112,6 +112,46 @@ maybe_remove_timestamp () {
>       fi
>   }

It's really good that you've found a way to test fflush

> +run_buffer_test () {
> +	type=$1
> +	sha1=$2
> +	size=$3
> +	flush=$4
> +
> +	mkfifo V.input
> +	exec 8<>V.input
> +	rm V.input
> +
> +	mkfifo V.output
> +	exec 9<>V.output
> +	rm V.output
> +	
> +	(
> +		git cat-file --buffer --batch-command <&8 >&9 &
> +		echo $! >&9 &&
> +		wait $!
> +		echo >&9 EARLY_EXIT
> +	) &
> +	sh_pid=$!
> +	read fi_pid <&9 > +	test_when_finished "
> +		exec 8>&-; exec 9>&-;
> +		kill $sh_pid && wait $sh_pid
> +		kill $fi_pid && wait $fi_pid
> +		true"
> +	expect=$(echo "$sha1 $type $size")
> +	echo "info $sha1" >&8
> +	if test "$flush" = "true"
> +	then
> +		echo "fflush" >&8

If I change "fflush" to "bad-command" then this test still passes. This 
is because die() flushes stdout and the read below will get the output 
it was expecting and not 'EARLY_EXIT'. I have a suggested change below 
to get around that also checks the exit code of "git cat-file" (This 
test effectively puts a git command upstream of a pipe which we try to 
avoid in order to pick up any crashes)

> +	else
> +		expect="EARLY_EXIT"
> +		kill $fi_pid && wait $fi_pid
> +	fi
> +	read actual <&9
> +	test "$actual" = "$expect"
> +}
> +
>   run_tests () {
>       type=$1
>       sha1=$2
> @@ -177,6 +217,18 @@ $content"
>   	test_cmp expect actual
>       '

Here is my suggestion based on your test - I ended up splitting the 
fflush and no-fflush cases

run_buffer_test_flush () {
	type=$1
	sha1=$2
	size=$3

	mkfifo input &&
	test_when_finished 'rm input'
	mkfifo output &&
	exec 9<>output &&
	test_when_finished 'rm output; exec 9<&-'
	(
	    	# TODO - Ideally we'd pipe the output of cat-file
	    	# through "sed s'/$/\\/'" to make sure that that read
	    	# would consume all the available
	    	# output. Unfortunately we cannot do this as we cannot
	    	# control when sed flushes its output. We could write
	    	# a test helper in C that appended a '\' to the end of
		# each line and flushes its output after every line.
		git cat-file --buffer --batch-command <input 2>err &
		echo $! &&
		wait $!
		echo $?
	) >&9 &
	sh_pid=$! &&
	read cat_file_pid <&9 &&
	test_when_finished "kill $cat_file_pid
			    kill $sh_pid; wait $sh_pid; :" &&
	(
		test_write_lines "info $sha1" fflush "info $sha1" &&
		# TODO - consume all available input, not just one
		# line (see above).
		read actual <&9 &&
		echo "$actual" >actual &&
		echo "$sha1 $type $size" >expect &&
		test_cmp expect actual
	) >input &&
	# check output is flushed on exit
	read actual <&9 &&
	echo "$actual" >actual &&
	test_cmp expect actual &&
	test_must_be_empty err &&
	read status <&9 &&
	test "$status" -eq 0
}

run_buffer_test_no_flush () {
	type=$1
	sha1=$2
	size=$3

	mkfifo input &&
	test_when_finished 'rm input'
	mkfifo pid &&
	exec 9<>pid &&
	test_when_finished 'rm pid; exec 9<&-'
	(
		git cat-file --buffer --batch-command <input >output &
		echo $! &&
		wait $!
		echo $?
	) >&9 &
	sh_pid=$! &&
	read cat_file_pid <&9 &&
	test_when_finished "kill $cat_file_pid
			    kill $sh_pid; wait $sh_pid; :" &&
	(
		test_write_lines "info $sha1" "info $sha1" &&
		kill $cat_file_pid &&
		read status <&9 &&
		test "$status" -ne 0 &&
		test_must_be_empty output
	) >input
}

Best Wishes

Phillip

> +    test -z "$content" ||
> +    test_expect_success "--batch-command output of $type content is correct" '
> +	maybe_remove_timestamp "$batch_output" $no_ts >expect &&
> +	maybe_remove_timestamp "$(echo object $sha1 | git cat-file --batch-command)" $no_ts >actual &&
> +	test_cmp expect actual
> +    '
> +
> +    test_expect_success "batch-command output of $type info is correct" '
> +	echo "$sha1 $type $size" >expect &&
> +	echo "info $sha1" | git cat-file --batch-command >actual &&
> +	test_cmp expect actual
> +'
>       test_expect_success "custom --batch-check format" '
>   	echo "$type $sha1" >expect &&
>   	echo $sha1 | git cat-file --batch-check="%(objecttype) %(objectname)" >actual &&
> @@ -232,12 +284,29 @@ test_expect_success '--batch-check without %(rest) considers whole line' '
>   	test_cmp expect actual
>   '
>   
> +test_expect_success '--batch-command --buffer with flush is correct for blob' '
> +	run_buffer_test 'blob' $hello_sha1 $hello_size true
> +'
> +
> +test_expect_success '--batch-command --buffer without flush is correct for blob' '
> +	run_buffer_test 'blob' $hello_sha1 $hello_size false
> +'
> +
>   tree_sha1=$(git write-tree)
> +
>   tree_size=$(($(test_oid rawsz) + 13))
>   tree_pretty_content="100644 blob $hello_sha1	hello"
>   
>   run_tests 'tree' $tree_sha1 $tree_size "" "$tree_pretty_content"
>   
> +test_expect_success '--batch-command --buffer with flush is correct for tree' '
> +	run_buffer_test 'tree' $tree_sha1 $tree_size true
> +'
> +
> +test_expect_success '--batch-command --buffer without flush is correct for tree' '
> +	run_buffer_test 'tree' $tree_sha1 $tree_size false
> +'
> +
>   commit_message="Initial commit"
>   commit_sha1=$(echo_without_newline "$commit_message" | git commit-tree $tree_sha1)
>   commit_size=$(($(test_oid hexsz) + 137))
> @@ -263,6 +332,14 @@ tag_size=$(strlen "$tag_content")
>   
>   run_tests 'tag' $tag_sha1 $tag_size "$tag_content" "$tag_content" 1
>   
> +test_expect_success '--batch-command --buffer with flush is correct for tag' '
> +	run_buffer_test 'tag' $tag_sha1 $tag_size true
> +'
> +
> +test_expect_success '--batch-command --buffer without flush is correct for tag' '
> +	run_buffer_test 'tag' $tag_sha1 $tag_size false
> +'
> +
>   test_expect_success \
>       "Reach a blob from a tag pointing to it" \
>       "test '$hello_content' = \"\$(git cat-file blob $tag_sha1)\""
> @@ -964,4 +1041,10 @@ test_expect_success 'cat-file --batch-all-objects --batch-check ignores replace'
>   	test_cmp expect actual
>   '
>   
> +test_expect_success 'batch-command unknown command' '
> +	echo unknown_command >cmd &&
> +	test_expect_code 128 git cat-file --batch-command < cmd 2>err &&
> +	grep -E "^fatal:.*unknown command.*" err
> +'
> +
>   test_done

