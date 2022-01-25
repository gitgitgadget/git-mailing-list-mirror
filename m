Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B679DC5AC75
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 23:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbiAYXAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 18:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234521AbiAYXAu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 18:00:50 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6257C06161C
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 15:00:49 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id c19so25435166qtx.3
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 15:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mlAHKtq+7iFZtaCN9oKlRcQ/RM4dxHkppQf9auz+1fw=;
        b=SwnBA8xErW0GZOyl7pHVL+n0WC5/OKgIOS9IZ/RTjqf1FJyqdfGO8OtOcSPzYEmZHs
         mBvKs/bAsIUABjUHfJMQjpeaioDARdgjIZlwMBwOEvNOpLSgi3z8gPhRZRteXuyaGbkU
         UIwrQ5AUvKu9Dxuwk2qsolXShyN7z1RC2ViTrWXkTd9pifPDOVo7qVlOM6ufqZpNMuyT
         oETSiWTwgnQvKqLH0aJdQsMBZkOpDAkUJKsGWBYqcWfmn5uSim4HDTL5Cuwy3wpprNq5
         5InaKqsQ/D6HDvXi8zQbtUpjlfHl4Yl8Mj0kH9IY31uxWEzNUwWx2TcZBP5sJzuyMElr
         xtbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mlAHKtq+7iFZtaCN9oKlRcQ/RM4dxHkppQf9auz+1fw=;
        b=CppojH1G/7NavzibbmBHK4YXPGABaYILq+txEDL3H7YQOItnIxlvC7khinmLnCHQ17
         mVNzE8/4b4rF68ioKLl3eyFifYFIkxNa74Ug0J6nYO0xCMUuOFd0abaHaZsza85S+GF9
         LfSmKDZqgJbWWgCwE6x8UX1ZZ0h75KIXlfgV1QETCJOpXX7C0USC6dAl+ZpXjrBv8wEH
         wMk9WVey4pXC3fLk+zebmXTfbPvVx6BHza3YWhM20o9xWKyx57/Rj8+J3mJKPK9p6B/p
         R6bpm7udnxgegEg1getFmg/3oKzpenn96sOOnfN1+YKXl0qR9p9KmAA6vs8vpxMIVS40
         azSQ==
X-Gm-Message-State: AOAM531rq6fKeZoFwqg5pN6f8EshAYxxh4yIHY/yVxm54BMLGyKV8i2U
        Mfc9UlGQ7KvOopcsAQBStsjgU0FkYEPl7w==
X-Google-Smtp-Source: ABdhPJw2OdpoXx1a0RqdmlOLUnM4iMH54j/g86YH7NJVv6w2zNoBwOPSAk5FBIFEboVtal3b1McB4A==
X-Received: by 2002:ac8:5d88:: with SMTP id d8mr18597665qtx.51.1643151648748;
        Tue, 25 Jan 2022 15:00:48 -0800 (PST)
Received: from [192.168.1.211] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id t10sm9321151qtx.12.2022.01.25.15.00.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jan 2022 15:00:48 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, me@ttaylorr.com, phillip.wood123@gmail.com,
        John Cai <johncai86@gmail.com>
Subject: Re: [RFC v2] cat-file: add a --stdin-cmd mode
Date:   Tue, 25 Jan 2022 18:00:47 -0500
X-Mailer: MailMate Trial (1.14r5852)
Message-ID: <96DB3B31-F76C-475F-8556-65FAE78CD25F@gmail.com>
In-Reply-To: <20220125225008.45944-1-johncai86@gmail.com>
References: <20220125225008.45944-1-johncai86@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 25 Jan 2022, at 17:50, John Cai wrote:

> This RFC patch proposes a new flag --stdin-cmd that works with
> git-cat-file --batch. Similar to git-update-ref --stdin, it will accept=

> commands and arguments from stdin.

Sorry I forgot to change this summary. s/--stdin-cmd/--batch-command

>
> The start of this idea was discussed in [1], where the original
> motivation was to be able to control when the buffer was flushed to
> stdout in --buffer mode.
>
> However, this can actually be much more useful in situations when
> git-cat-file --batch is being used as a long lived backend query
> process. At GitLab, we use a pair of cat-file processes. One for
> iterating over object metadata with --batch-check, and the other to gra=
b
> object contents with --batch. However, if we had --stdin-cmd, we could
> get rid of the second --batch-check process, and just have one progress=

> where we can flip between getting object info, and getting object conte=
nts.
> This can lead to huge savings.
>
> git cat-file --batch --stdin-cmd
>
> $ <command> [arg1] [arg2] NL
>
> We can also add a -z mode to allow for NUL-terminated lines
>
> $ <command> [arg1] [arg2] NUL
>
> This patch adds three commands: object, info, fflush
>
> $ object <sha1> NL
> $ info <sha1> NL
> $ fflush NL
>
> These three would be immediately useful in GitLab's context, but one ca=
n
> imagine this mode to be further extended for other things.
>
> For instance, a non-trivial part of "cat-file --batch" time is spent
> on parsing its argument and seeing if it's a revision, ref etc. So we
> could add a command that only accepts a full-length 40
> character SHA-1.
>
> This would be the first step in adding such an interface to
> git-cat-file.
>
> [1] https://lore.kernel.org/git/pull.1124.git.git.1636149400.gitgitgadg=
et@gmail.com/
>
> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
> Changes from v1:
>
> - changed option name to batch-command.
> - changed command function interface to receive the whole line after th=
e command
>   name to put the onus of parsing arguments to each individual command =
function.
> - pass in whole line to batch_one_object in both parse_cmd_object and
>   parse_cmd_info to support spaces in the object reference.
> - removed addition of -z to include in a separate patch series
> - added documentation.
> ---
>  Documentation/git-cat-file.txt |  15 +++++
>  builtin/cat-file.c             | 114 ++++++++++++++++++++++++++++++++-=

>  strvec.c                       |  23 +++++++
>  strvec.h                       |   8 +++
>  t/t1006-cat-file.sh            |  32 +++++++++
>  5 files changed, 191 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-fil=
e.txt
> index bef76f4dd0..8aefa45e4c 100644
> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -96,6 +96,21 @@ OPTIONS
>  	need to specify the path, separated by whitespace.  See the
>  	section `BATCH OUTPUT` below for details.
>
> +-batch-command::
> +	Enter a command mode that reads from stdin. May not be combined with =
any
> +	other options or arguments except `--textconv` or `--filters`, in whi=
ch
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
> +	Flush to stdout immediately when used with --buffer
> +
>  --batch-all-objects::
>  	Instead of reading a list of objects on stdin, perform the
>  	requested batch operation on all objects in the repository and
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 7b3f42950e..30794284d5 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -16,6 +16,7 @@
>  #include "packfile.h"
>  #include "object-store.h"
>  #include "promisor-remote.h"
> +#include "strvec.h"
>
>  struct batch_options {
>  	int enabled;
> @@ -26,7 +27,10 @@ struct batch_options {
>  	int unordered;
>  	int cmdmode; /* may be 'w' or 'c' for --filters or --textconv */
>  	const char *format;
> +	int stdin_cmd;
> +	int end_null;
>  };
> +static char line_termination =3D '\n';
>
>  static const char *force_path;
>
> @@ -508,6 +512,102 @@ static int batch_unordered_packed(const struct ob=
ject_id *oid,
>  				      data);
>  }
>
> +enum batch_state {
> +	/* Non-transactional state open for commands. */
> +	BATCH_STATE_OPEN,
> +};
> +
> +static void parse_cmd_object(struct batch_options *opt,
> +			     const char *line,
> +			     struct strbuf *output,
> +			     struct expand_data *data)
> +{
> +	opt->print_contents =3D 1;
> +	batch_one_object(line, output, opt, data);
> +}
> +
> +static void parse_cmd_info(struct batch_options *opt,
> +			   const char *line,
> +			   struct strbuf *output,
> +			   struct expand_data *data)
> +{
> +	opt->print_contents =3D 0;
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
> +	unsigned args;
> +	enum batch_state state;
> +} commands[] =3D {
> +	{ "object", parse_cmd_object, 1, BATCH_STATE_OPEN },
> +	{ "info", parse_cmd_info, 1, BATCH_STATE_OPEN },
> +	{ "fflush", parse_cmd_fflush, 0, BATCH_STATE_OPEN },
> +};
> +
> +static void batch_objects_stdin_cmd(struct batch_options *opt,
> +				    struct strbuf *output,
> +				    struct expand_data *data)
> +{
> +	struct strbuf input =3D STRBUF_INIT;
> +	enum batch_state state =3D BATCH_STATE_OPEN;
> +
> +	/* Read each line dispatch its command */
> +	while (!strbuf_getwholeline(&input, stdin, line_termination)) {
> +		int i;
> +		const struct parse_cmd *cmd =3D NULL;
> +		const char *p;
> +
> +		if (*input.buf =3D=3D line_termination)
> +			die("empty command in input");
> +		else if (isspace(*input.buf))
> +			die("whitespace before command: %s", input.buf);
> +
> +		for (i =3D 0; i < ARRAY_SIZE(commands); i++) {
> +			const char *prefix =3D commands[i].prefix;
> +			char c;
> +			const char *cmd_name;
> +			if (!skip_prefix(input.buf, prefix, &cmd_name))
> +				continue;
> +			/*
> +			 * If the command has arguments, verify that it's
> +			 * followed by a space. Otherwise, it shall be followed
> +			 * by a line terminator.
> +			 */
> +			c =3D commands[i].args ? ' ' : line_termination;
> +			if (input.buf[strlen(prefix)] !=3D c)
> +				continue;
> +
> +			cmd =3D &commands[i];
> +			break;
> +		}
> +		if (!cmd)
> +			die("unknown command: %s", input.buf);
> +
> +		p =3D input.buf + strlen(cmd->prefix) + 1;
> +		const char *pos =3D strstr(p, &line_termination);
> +
> +		switch (state) {
> +		case BATCH_STATE_OPEN:
> +			break;
> +		}
> +		cmd->fn(opt, xstrndup(p, pos-p), output, data);
> +	}
> +	strbuf_release(&input);
> +}
> +
>  static int batch_objects(struct batch_options *opt)
>  {
>  	struct strbuf input =3D STRBUF_INIT;
> @@ -515,6 +615,7 @@ static int batch_objects(struct batch_options *opt)=

>  	struct expand_data data;
>  	int save_warning;
>  	int retval =3D 0;
> +	const int stdin_cmd =3D opt->stdin_cmd;
>
>  	if (!opt->format)
>  		opt->format =3D "%(objectname) %(objecttype) %(objectsize)";
> @@ -590,7 +691,8 @@ static int batch_objects(struct batch_options *opt)=

>  	save_warning =3D warn_on_object_refname_ambiguity;
>  	warn_on_object_refname_ambiguity =3D 0;
>
> -	while (strbuf_getline(&input, stdin) !=3D EOF) {
> +	while (!stdin_cmd &&
> +	       strbuf_getline(&input, stdin) !=3D EOF) {
>  		if (data.split_on_whitespace) {
>  			/*
>  			 * Split at first whitespace, tying off the beginning
> @@ -608,6 +710,9 @@ static int batch_objects(struct batch_options *opt)=

>  		batch_one_object(input.buf, &output, opt, &data);
>  	}
>
> +	if (stdin_cmd)
> +		batch_objects_stdin_cmd(opt, &output, &data);
> +
>  	strbuf_release(&input);
>  	strbuf_release(&output);
>  	warn_on_object_refname_ambiguity =3D save_warning;
> @@ -636,6 +741,7 @@ static int batch_option_callback(const struct optio=
n *opt,
>
>  	bo->enabled =3D 1;
>  	bo->print_contents =3D !strcmp(opt->long_name, "batch");
> +	bo->stdin_cmd =3D !strcmp(opt->long_name, "batch-command");
>  	bo->format =3D arg;
>
>  	return 0;
> @@ -683,6 +789,10 @@ int cmd_cat_file(int argc, const char **argv, cons=
t char *prefix)
>  			N_("like --batch, but don't emit <contents>"),
>  			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
>  			batch_option_callback),
> +		OPT_CALLBACK_F(0, "batch-command", &batch, N_(""),
> +			 N_("enters batch mode that accepts commands"),
> +			 PARSE_OPT_NOARG | PARSE_OPT_NONEG,
> +			 batch_option_callback),
>  		OPT_CMDMODE(0, "batch-all-objects", &opt,
>  			    N_("with --batch[-check]: ignores stdin, batches all known obje=
cts"), 'b'),
>  		/* Batch-specific options */
> @@ -738,6 +848,8 @@ int cmd_cat_file(int argc, const char **argv, const=
 char *prefix)
>  	/* Batch defaults */
>  	if (batch.buffer_output < 0)
>  		batch.buffer_output =3D batch.all_objects;
> +	if (batch.end_null)
> +		line_termination =3D '\0';
>
>  	/* Return early if we're in batch mode? */
>  	if (batch.enabled) {
> diff --git a/strvec.c b/strvec.c
> index 61a76ce6cb..7dca04bf7a 100644
> --- a/strvec.c
> +++ b/strvec.c
> @@ -85,6 +85,29 @@ void strvec_split(struct strvec *array, const char *=
to_split)
>  	}
>  }
>
> +size_t strvec_split_delim(struct strvec *array, const char *string,
> +			  int delim, int maxsplit)
> +{
> +	size_t count =3D 0;
> +	const char *p =3D string, *end;
> +
> +	for (;;) {
> +		count++;
> +		if (maxsplit >=3D 0 && count > maxsplit) {
> +			strvec_push(array, p);
> +			return count;
> +		}
> +		end =3D strchr(p, delim);
> +		if (end) {
> +			strvec_push_nodup(array, xmemdupz(p, end - p));
> +			p =3D end + 1;
> +		} else {
> +			strvec_push(array, p);
> +			return count;
> +		}
> +	}
> +}
> +
>  void strvec_clear(struct strvec *array)
>  {
>  	if (array->v !=3D empty_strvec) {
> diff --git a/strvec.h b/strvec.h
> index 9f55c8766b..c474918b91 100644
> --- a/strvec.h
> +++ b/strvec.h
> @@ -73,6 +73,14 @@ void strvec_pop(struct strvec *);
>  /* Splits by whitespace; does not handle quoted arguments! */
>  void strvec_split(struct strvec *, const char *);
>
> +/**
> + * strvec_split_delim() is a split function that behaves more like its=

> + * string_list_split() cousin than the whitespace-splitting
> + * strvec_split().
> + */
> +size_t strvec_split_delim(struct strvec *array, const char *string,
> +			  int delim, int maxsplit);
> +
>  /**
>   * Free all memory associated with the array and return it to the
>   * initial, empty state.
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index 145eee11df..935ab1cd34 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -964,4 +964,36 @@ test_expect_success 'cat-file --batch-all-objects =
--batch-check ignores replace'
>  	test_cmp expect actual
>  '
>
> +F=3D'%s\0'
> +
> +test_expect_success 'batch-command unknown command' '
> +	echo unknown_command >cmd &&
> +	test_expect_code 128 git cat-file --batch-command < cmd 2>err &&
> +	grep -E "^fatal:.*unknown command.*" err
> +'
> +
> +test_expect_success 'setup object data' '
> +	content=3D"Object Data" &&
> +	size=3D$(strlen "$content") &&
> +	sha1=3D$(echo_without_newline "$content" | git hash-object -w --stdin=
)
> +'
> +
> +test_expect_success 'batch-command calling object works' '
> +	echo "object $sha1" | git cat-file --batch-command >actual &&
> +	echo "$sha1 blob $size" >expect &&
> +	echo `git cat-file -p "$sha1"` >>expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'batch-command calling info works' '
> +	echo "info $sha1" | git cat-file --batch-command >actual &&
> +	echo "$sha1 blob $size" >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'batch-command fflush works' '
> +	printf "fflush\n" > cmd &&
> +	test_expect_code 0 git cat-file --batch-command < cmd 2>err
> +'
> +
>  test_done
> -- =

> 2.34.1
