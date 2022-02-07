Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3D7C433F5
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 16:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245055AbiBGQpD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 11:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390300AbiBGQdh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 11:33:37 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2751FC0401D3
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 08:33:35 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o1-20020a1c4d01000000b0034d95625e1fso14712255wmh.4
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 08:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=7j9NZYkCL3JnzKd0m8kzwjWGh6JmYnE9AW9t3GF/Pt0=;
        b=Q1DW00e6sPzBp4NTD/cxS104Qe+Ack4oVvT8CyAEjf3dwHInnWt9XYCE2oX+64l2La
         kPXegnUrRysXlpsVDvGLyVweTXT5rXwksFYdQBmfyZQUsQnNwQd3axJVNOCrYsU2yvHU
         X2xHLJC9UnluXZnpMXjWew8RszHTGLhojSQIjP4ljXiAU/nbGCSZ/ngpvn3l8gpAubbq
         ZblslNng5fK9Le4l7TY+qlfwZsL2dTbSZyB9UeP4LBh3Qa7k1m4WeJfFl7kBKgYjBsvl
         gSkov1w3yEMBy3nEO6m1LR8EzMDR2hns7j8NO5QDyWndvPz1op88D1c+OPcmfkAC+snq
         BwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=7j9NZYkCL3JnzKd0m8kzwjWGh6JmYnE9AW9t3GF/Pt0=;
        b=PBFSsXWiNaz0wWoWm9+MQhqyvxcxnkkK0xS++x3XQlfRbiRjrqdqJPo/VAQP5n+81j
         FH1MORi6qhYTqsON/7WcYtBnVT7n4PC2+uHUCCKPyPqviClS4zv7hVd3Jwm80wMEsZux
         0gFirMtZOd7R3/3VQ35qBnst/r+7mGj6nxDR9D9XmA46eMq427McyXQ1X19XxroP2KOH
         CiOTSSF+wCx0IJ3Cmds297YzC+1cKRFb9q9oBIq1oQpQf994RMHGWRfS1KCWbUQI6Z9C
         YfXms4qjd9vjYALa0pWdKimBV4S7Ucnr9f0rBjbNp6sWcFHsQ9gXjT7qiqS/BoC0IVMg
         PPwg==
X-Gm-Message-State: AOAM530VGWZmnnxPkmXMSjavMjw8UCGtKHYk828bAJtdAjR0YWtoGBQ7
        /rbMMcq6bEBogMjwu5XSw5ujB+Ap9w0=
X-Google-Smtp-Source: ABdhPJxXM5Wytujmdq+A/575M0AE9djqYH72Sipnhqu8R9z8/x6NWS94mR6+L4o/4ps1Vwlo3y0USQ==
X-Received: by 2002:a7b:cf06:: with SMTP id l6mr9225467wmg.13.1644251613094;
        Mon, 07 Feb 2022 08:33:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t14sm18383015wmq.43.2022.02.07.08.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 08:33:32 -0800 (PST)
Message-Id: <pull.1212.v2.git.git.1644251611.gitgitgadget@gmail.com>
In-Reply-To: <pull.1212.git.git.1643915286.gitgitgadget@gmail.com>
References: <pull.1212.git.git.1643915286.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Feb 2022 16:33:29 +0000
Subject: [PATCH v2 0/2] Add cat-file --batch-command flag
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, phillip.wood123@gmail.com, avarab@gmail.com,
        e@80x24.org, bagasdotme@gmail.com, gitster@pobox.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The feature proposal of adding a command interface to cat-file was first
discussed in [A]. In [B], Taylor expressed the need for a fuller proposal
before moving forward with a new flag. An RFC was created [C] and the idea
was discussed more thoroughly, and overall it seemed like it was headed in
the right direction.

This patch series consolidates the feedback from these different threads.

This patch series has two parts:

 1. preparation patch to rename a variable
 2. logic to handle --batch-command flag, adding contents, info, flush
    commands

Changes since v1:

 * simplified "session" mechanism. "flush" will execute all commands that
   were entered in since the last "flush" when in --buffer mode
 * when not in --buffer mode, each command is executed and flushed each time
 * rename cmdmode to transform_mode instead of just mode
 * simplified command parsing logic
 * changed rename of cmdmode to transform_mode
 * clarified verbiage in commit messages

A. https://lore.kernel.org/git/xmqqk0hitnkc.fsf@gitster.g/ B.
https://lore.kernel.org/git/YehomwNiIs0l83W7@nand.local/ C.
https://lore.kernel.org/git/e75ba9ea-fdda-6e9f-4dd6-24190117d93b@gmail.com/

John Cai (2):
  cat-file: rename cmdmode to transform_mode
  cat-file: add --batch-command mode

 Documentation/git-cat-file.txt |  19 ++++
 builtin/cat-file.c             | 138 +++++++++++++++++++++--
 t/t1006-cat-file.sh            | 197 ++++++++++++++++++++++++++++++++-
 3 files changed, 346 insertions(+), 8 deletions(-)


base-commit: 38062e73e009f27ea192d50481fcb5e7b0e9d6eb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1212%2Fjohn-cai%2Fjc-cat-file-batch-command-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1212/john-cai/jc-cat-file-batch-command-v2
Pull-Request: https://github.com/git/git/pull/1212

Range-diff vs v1:

 1:  86df0c9e4df ! 1:  2d9a0b06ce5 cat-file.c: rename cmdmode to mode
     @@ Metadata
      Author: John Cai <johncai86@gmail.com>
      
       ## Commit message ##
     -    cat-file.c: rename cmdmode to mode
     +    cat-file: rename cmdmode to transform_mode
      
     -    To prepare for a new flag --batch-command, we will add a flag that
     -    indicates whether or not an interactive command mode will be used
     -    that reads commands and arguments off of stdin.
     +    When introducing a new flag --batch-command, we will add a flag on the
     +    batch_options struct that indicates whether or not an interactive
     +    command mode will be used that reads commands and arguments off of
     +    stdin.
      
          An intuitive name for this flag would be "command", which can get
          confusing with the already existing cmdmode.
      
     -    Rename cmdmode->mode to prepare for this change.
     +    cmdmode refers to how the result output of the blob will be transformed,
     +    either according to --filter or --textconv. So transform_mode is a more
     +    descriptive name for the flag, and will not get confused with the new
     +    command flag to be added in the next commit.
     +
     +    Rename cmdmode to transform_mode in cat-file.c
      
          Signed-off-by: John Cai <johncai86@gmail.com>
      
     @@ builtin/cat-file.c: struct batch_options {
       	int all_objects;
       	int unordered;
      -	int cmdmode; /* may be 'w' or 'c' for --filters or --textconv */
     -+	int mode; /* may be 'w' or 'c' for --filters or --textconv */
     ++	int transform_mode; /* may be 'w' or 'c' for --filters or --textconv */
       	const char *format;
       };
       
     @@ builtin/cat-file.c: static void print_object_or_die(struct batch_options *opt, s
       		if (opt->buffer_output)
       			fflush(stdout);
      -		if (opt->cmdmode) {
     -+		if (opt->mode) {
     ++		if (opt->transform_mode) {
       			char *contents;
       			unsigned long size;
       
     @@ builtin/cat-file.c: static void print_object_or_die(struct batch_options *opt, s
       				die("missing path for '%s'", oid_to_hex(oid));
       
      -			if (opt->cmdmode == 'w') {
     -+			if (opt->mode == 'w') {
     ++			if (opt->transform_mode == 'w') {
       				if (filter_object(data->rest, 0100644, oid,
       						  &contents, &size))
       					die("could not convert '%s' %s",
       					    oid_to_hex(oid), data->rest);
      -			} else if (opt->cmdmode == 'c') {
     -+			} else if (opt->mode == 'c') {
     ++			} else if (opt->transform_mode == 'c') {
       				enum object_type type;
       				if (!textconv_object(the_repository,
       						     data->rest, 0100644, oid,
     @@ builtin/cat-file.c: static void print_object_or_die(struct batch_options *opt, s
       					    oid_to_hex(oid), data->rest);
       			} else
      -				BUG("invalid cmdmode: %c", opt->cmdmode);
     -+				BUG("invalid mode: %c", opt->mode);
     ++				BUG("invalid transform_mode: %c", opt->transform_mode);
       			batch_write(opt, contents, size);
       			free(contents);
       		} else {
     @@ builtin/cat-file.c: static int batch_objects(struct batch_options *opt)
       	data.mark_query = 0;
       	strbuf_release(&output);
      -	if (opt->cmdmode)
     -+	if (opt->mode)
     ++	if (opt->transform_mode)
       		data.split_on_whitespace = 1;
       
       	/*
      @@ builtin/cat-file.c: int cmd_cat_file(int argc, const char **argv, const char *prefix)
     - 
     - 	batch.buffer_output = -1;
     - 	argc = parse_options(argc, argv, prefix, options, cat_file_usage, 0);
     --
     - 	if (opt) {
     - 		if (batch.enabled && (opt == 'c' || opt == 'w'))
     --			batch.cmdmode = opt;
     -+			batch.mode = opt;
     - 		else if (argc == 1)
     - 			obj_name = argv[0];
     - 		else
     -@@ builtin/cat-file.c: int cmd_cat_file(int argc, const char **argv, const char *prefix)
     - 			usage_with_options(cat_file_usage, options);
     - 	}
     + 	/* Return early if we're in batch mode? */
       	if (batch.enabled) {
     --		if (batch.cmdmode != opt || argc)
     -+		if (batch.mode != opt || argc)
     - 			usage_with_options(cat_file_usage, options);
     --		if (batch.cmdmode && batch.all_objects)
     -+		if (batch.mode && batch.all_objects)
     - 			die("--batch-all-objects cannot be combined with "
     - 			    "--textconv nor with --filters");
     - 	}
     + 		if (opt_cw)
     +-			batch.cmdmode = opt;
     ++			batch.transform_mode = opt;
     + 		else if (opt && opt != 'b')
     + 			usage_msg_optf(_("'-%c' is incompatible with batch mode"),
     + 				       usage, options, opt);
 2:  ebd2a135601 ! 2:  1b63164ad4d catfile.c: add --batch-command mode
     @@ Metadata
      Author: John Cai <johncai86@gmail.com>
      
       ## Commit message ##
     -    catfile.c: add --batch-command mode
     +    cat-file: add --batch-command mode
      
     -    Add new flag --batch-command that will accept commands and arguments
     +    Add a new flag --batch-command that accepts commands and arguments
          from stdin, similar to git-update-ref --stdin.
      
          At GitLab, we use a pair of long running cat-file processes when
          accessing object content. One for iterating over object metadata with
          --batch-check, and the other to grab object contents with --batch.
      
     -    However, if we had --batch-command, we wouldnt need to keep both
     -    processes around, and instead just have one process where we can flip
     -    between getting object info, and getting object contents. This means we
     -    can get rid of roughly half of long lived git cat-file processes. This
     -    can lead to huge savings since on a given server there could be hundreds
     -    of git cat-file processes running.
     +    However, if we had --batch-command, we wouldn't need to keep both
     +    processes around, and instead just have one --batch-command process
     +    where we can flip between getting object info, and getting object
     +    contents. Since we have a pair of cat-file processes per repository,
     +    this means we can get rid of roughly half of long lived git cat-file
     +    processes. Given there are many repositories being accessed at any given
     +    time, this can lead to huge savings since on a given server.
      
          git cat-file --batch-command
      
     -    would enter an interactive command mode whereby the user can enter in
     -    commands and their arguments:
     +    will enter an interactive command mode whereby the user can enter in
     +    commands and their arguments that get queued in memory:
      
     -    <command> [arg1] [arg2] NL
     +    <command1> [arg1] [arg2] NL
     +    <command2> [arg1] [arg2] NL
      
     -    This patch adds the basic structure for add command which can be
     -    extended in the future to add more commands.
     +    When --buffer mode is used, commands will be queued in memory until a
     +    flush command is issued that execute them:
      
     -    This patch also adds the following commands:
     +    flush NL
     +
     +    The reason for a flush command is that when a consumer process (A)
     +    talks to a git cat-file process (B) and interactively writes to and
     +    reads from it in --buffer mode, (A) needs to be able to control when
     +    the buffer is flushed to stdout.
     +
     +    Currently, from (A)'s perspective, the only way is to either
     +
     +    1. kill (B)'s process
     +    2. send an invalid object to stdin.
     +
     +    1. is not ideal from a performance perspective as it will require
     +    spawning a new cat-file process each time, and 2. is hacky and not a
     +    good long term solution.
     +
     +    With this mechanism of queueing up commands and letting (A) issue a
     +    flush command, process (A) can control when the buffer is flushed and
     +    can guarantee it will receive all of the output when in --buffer mode.
     +
     +    This patch adds the basic structure for adding command which can be
     +    extended in the future to add more commands. It also adds the following
     +    two commands (on top of the flush command):
      
          contents <object> NL
          info <object> NL
     @@ Commit message
          The info command takes a <object> argument and prints out the object
          metadata.
      
     -    In addition, we need a set of commands that enable a "read session".
     -
     -    When a separate process (A) is connected to a git cat-file process (B)
     -    and is interactively writing to and reading from it in --buffer mode,
     -    (A) needs to be able to know when the buffer is flushed to stdout.
     -    Currently, from (A)'s perspective, the only way is to either 1. exit
     -    (B)'s process or 2. send an invalid object to stdin. 1. is not ideal
     -    from a performance perspective as it will require spawning a new cat-file
     -    process each time, and 2. is hacky and not a good long term solution.
     +    These can be used in the following way with --buffer:
      
     -    With the following commands, process (A) can begin a "session" and
     -    send a list of object names over stdin. When "get contents" or "get info"
     -    is issued, this list of object names will be fed into batch_one_object()
     -    to retrieve either info or contents. Finally an fflush() will be called
     -    to end the session.
     +    contents <sha1> NL
     +    object <sha1> NL
     +    object <sha1> NL
     +    contents <sha1> NL
     +    flush
     +    contents <sha1> NL
     +    flush
      
     -    begin NL
     -    get contents NL
     -    get info NL
     +    When used without --buffer:
      
     -    These can be used in the following way:
     -
     -    begin
     -    <sha1>
     -    <sha1>
     -    <sha1>
     -    <sha1>
     -    get info
     -
     -    begin
     -    <sha1>
     -    <sha1>
     -    <sha1>
     -    <sha1>
     -    get contents
     -
     -    With this mechanism, process (A) can be guaranteed to receive all of the
     -    output even in --buffer mode.
     +    contents <sha1> NL
     +    object <sha1> NL
     +    object <sha1> NL
     +    contents <sha1> NL
     +    contents <sha1> NL
      
          Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Signed-off-by: John Cai <johncai86@gmail.com>
     @@ Documentation/git-cat-file.txt: OPTIONS
      +info <object>::
      +	Print object info for object reference <object>
      +
     -+begin::
     -+	Begins a session to read object names off of stdin. A session can be
     -+	terminated with `get contents` or `get info`.
     -+
     -+get contents::
     -+	After a read session is begun with the `begin` command, and object
     -+	names have been fed into stdin, end the session and retrieve contents of
     -+	all the objects requested.
     -+
     -+get info::
     -+	After a read session is begun with the `begin` command, and object
     -+	names have been fed into stdin, end the session and retrieve info of
     -+	all the objects requested.
     ++flush::
     ++	Execute all preceding commands that were issued since the beginning or
     ++	since the last flush command was issued. Only used with --buffer. When
     ++	--buffer is not used, commands are flushed each time without issuing
     ++	`flush`.
      +
       --batch-all-objects::
       	Instead of reading a list of objects on stdin, perform the
     @@ Documentation/git-cat-file.txt: OPTIONS
       ## builtin/cat-file.c ##
      @@ builtin/cat-file.c: struct batch_options {
       	int unordered;
     - 	int mode; /* may be 'w' or 'c' for --filters or --textconv */
     + 	int transform_mode; /* may be 'w' or 'c' for --filters or --textconv */
       	const char *format;
      +	int command;
       };
     @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oi
       				      data);
       }
       
     -+static void parse_cmd_object(struct batch_options *opt,
     ++typedef void (*parse_cmd_fn_t)(struct batch_options *, const char *,
     ++			       struct strbuf *, struct expand_data *);
     ++
     ++struct queued_cmd {
     ++	parse_cmd_fn_t fn;
     ++	const char *line;
     ++};
     ++
     ++static void parse_cmd_contents(struct batch_options *opt,
      +			     const char *line,
      +			     struct strbuf *output,
     -+			     struct expand_data *data,
     -+			     struct string_list revs)
     ++			     struct expand_data *data)
      +{
      +	opt->print_contents = 1;
      +	batch_one_object(line, output, opt, data);
     @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oi
      +static void parse_cmd_info(struct batch_options *opt,
      +			   const char *line,
      +			   struct strbuf *output,
     -+			   struct expand_data *data,
     -+			   struct string_list revs)
     ++			   struct expand_data *data)
      +{
      +	opt->print_contents = 0;
      +	batch_one_object(line, output, opt, data);
      +}
      +
     -+static void parse_cmd_begin(struct batch_options *opt,
     -+			   const char *line,
     -+			   struct strbuf *output,
     -+			   struct expand_data *data,
     -+			   struct string_list revs)
     ++static void flush_batch_calls(struct batch_options *opt,
     ++		struct strbuf *output,
     ++		struct expand_data *data,
     ++		struct queued_cmd *cmds,
     ++		int queued)
      +{
     -+	/* nothing needs to be done here */
     -+}
     -+
     -+static void parse_cmd_get(struct batch_options *opt,
     -+			   const char *line,
     -+			   struct strbuf *output,
     -+			   struct expand_data *data,
     -+			   struct string_list revs)
     -+{
     -+	struct string_list_item *item;
     -+	for_each_string_list_item(item, &revs) {
     -+		batch_one_object(item->string, output, opt, data);
     ++	int i;
     ++	for(i = 0; i < queued; i++){
     ++		cmds[i].fn(opt, cmds[i].line, output, data);
      +	}
     -+	if (opt->buffer_output)
     -+		fflush(stdout);
     -+}
     -+static void parse_cmd_get_info(struct batch_options *opt,
     -+			   const char *line,
     -+			   struct strbuf *output,
     -+			   struct expand_data *data,
     -+			   struct string_list revs)
     -+{
     -+	opt->print_contents = 0;
     -+	parse_cmd_get(opt, line, output, data, revs);
     -+}
     -+
     -+static void parse_cmd_get_objects(struct batch_options *opt,
     -+			   const char *line,
     -+			   struct strbuf *output,
     -+			   struct expand_data *data,
     -+			   struct string_list revs)
     -+{
     -+	opt->print_contents = 1;
     -+	parse_cmd_get(opt, line, output, data, revs);
     -+	if (opt->buffer_output)
     -+		fflush(stdout);
     ++	fflush(stdout);
      +}
      +
     -+enum batch_state {
     -+	BATCH_STATE_COMMAND,
     -+	BATCH_STATE_INPUT,
     -+};
     -+
     -+typedef void (*parse_cmd_fn_t)(struct batch_options *, const char *,
     -+			       struct strbuf *, struct expand_data *,
     -+			       struct string_list revs);
     -+
      +static const struct parse_cmd {
      +	const char *prefix;
      +	parse_cmd_fn_t fn;
      +	unsigned takes_args;
     -+	enum batch_state next_state;
      +} commands[] = {
     -+	{ "contents", parse_cmd_object, 1, BATCH_STATE_COMMAND},
     -+	{ "info", parse_cmd_info, 1, BATCH_STATE_COMMAND},
     -+	{ "begin", parse_cmd_begin, 0, BATCH_STATE_INPUT},
     -+	{ "get info", parse_cmd_get_info, 0, BATCH_STATE_COMMAND},
     -+	{ "get contents", parse_cmd_get_objects, 0, BATCH_STATE_COMMAND},
     ++	{ "contents", parse_cmd_contents, 1},
     ++	{ "info", parse_cmd_info, 1},
      +};
      +
      +static void batch_objects_command(struct batch_options *opt,
     @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oi
      +				    struct expand_data *data)
      +{
      +	struct strbuf input = STRBUF_INIT;
     -+	enum batch_state state = BATCH_STATE_COMMAND;
     -+	struct string_list revs = STRING_LIST_INIT_DUP;
     ++	struct queued_cmd *cmds = NULL;
     ++	size_t alloc = 0, nr = 0;
     ++	int queued = 0;
      +
     -+	/* Read each line dispatch its command */
      +	while (!strbuf_getline(&input, stdin)) {
      +		int i;
      +		const struct parse_cmd *cmd = NULL;
      +		const char *p, *cmd_end;
     ++		struct queued_cmd call = {0};
     ++
     ++		if (!input.len)
     ++			die(_("empty command in input"));
     ++		if (isspace(*input.buf))
     ++			die(_("whitespace before command: '%s'"), input.buf);
      +
     -+		if (state == BATCH_STATE_COMMAND) {
     -+			if (*input.buf == '\n')
     -+				die("empty command in input");
     -+			else if (isspace(*input.buf))
     -+				die("whitespace before command: %s", input.buf);
     ++		if (skip_prefix(input.buf, "flush", &cmd_end)) {
     ++			if (!opt->buffer_output)
     ++				die(_("flush is only for --buffer mode"));
     ++			if (*cmd_end)
     ++				die(_("flush takes no arguments"));
     ++			if (!queued)
     ++				die(_("nothing to flush"));
     ++			flush_batch_calls(opt, output, data, cmds, queued);
     ++			queued = 0;
     ++			continue;
      +		}
      +
      +		for (i = 0; i < ARRAY_SIZE(commands); i++) {
     -+			const char *prefix = commands[i].prefix;
     -+			char c;
     -+			if (!skip_prefix(input.buf, prefix, &cmd_end))
     ++			if (!skip_prefix(input.buf, commands[i].prefix, &cmd_end))
      +				continue;
     -+			/*
     -+			 * If the command has arguments, verify that it's
     -+			 * followed by a space. Otherwise, it shall be followed
     -+			 * by a line terminator.
     -+			 */
     -+			c = commands[i].takes_args ? ' ' : '\n';
     -+			if (*cmd_end && *cmd_end != c)
     -+				die("arguments invalid for command: %s", commands[i].prefix);
      +
      +			cmd = &commands[i];
      +			if (cmd->takes_args)
     @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oi
      +			break;
      +		}
      +
     -+		if (input.buf[input.len - 1] == '\n')
     -+			input.buf[--input.len] = '\0';
     ++		if (!cmd)
     ++			die(_("unknown command: '%s'"), input.buf);
      +
     -+		if (state == BATCH_STATE_INPUT && !cmd){
     -+			string_list_append(&revs, input.buf);
     ++		if (!opt->buffer_output) {
     ++			cmd->fn(opt, p, output, data);
      +			continue;
      +		}
      +
     -+		if (!cmd)
     -+			die("unknown command: %s", input.buf);
     ++		queued++;
     ++		if (queued > nr) {
     ++			ALLOC_GROW(cmds, nr+1, alloc);
     ++			nr++;
     ++		}
      +
     -+		state = cmd->next_state;
     -+		cmd->fn(opt, p, output, data, revs);
     ++		call.fn = cmd->fn;
     ++		call.line = xstrdup(p);
     ++		cmds[queued-1] = call;
      +	}
     ++	free(cmds);
      +	strbuf_release(&input);
     -+	string_list_clear(&revs, 0);
      +}
      +
       static int batch_objects(struct batch_options *opt)
     @@ builtin/cat-file.c: static int batch_objects(struct batch_options *opt)
       	save_warning = warn_on_object_refname_ambiguity;
       	warn_on_object_refname_ambiguity = 0;
       
     --	while (strbuf_getline(&input, stdin) != EOF) {
     --		if (data.split_on_whitespace) {
     --			/*
     --			 * Split at first whitespace, tying off the beginning
     --			 * of the string and saving the remainder (or NULL) in
     --			 * data.rest.
     --			 */
     --			char *p = strpbrk(input.buf, " \t");
     --			if (p) {
     --				while (*p && strchr(" \t", *p))
     --					*p++ = '\0';
     -+	if (command)
     ++	if (command) {
      +		batch_objects_command(opt, &output, &data);
     -+	else {
     -+		while (strbuf_getline(&input, stdin) != EOF) {
     -+			if (data.split_on_whitespace) {
     -+				/*
     -+				 * Split at first whitespace, tying off the beginning
     -+				 * of the string and saving the remainder (or NULL) in
     -+				 * data.rest.
     -+				 */
     -+				char *p = strpbrk(input.buf, " \t");
     -+				if (p) {
     -+					while (*p && strchr(" \t", *p))
     -+						*p++ = '\0';
     -+				}
     -+				data.rest = p;
     - 			}
     --			data.rest = p;
     -+			batch_one_object(input.buf, &output, opt, &data);
     - 		}
     --
     --		batch_one_object(input.buf, &output, opt, &data);
     ++		goto cleanup;
     ++	}
     + 	while (strbuf_getline(&input, stdin) != EOF) {
     + 		if (data.split_on_whitespace) {
     + 			/*
     +@@ builtin/cat-file.c: static int batch_objects(struct batch_options *opt)
     + 		batch_one_object(input.buf, &output, opt, &data);
       	}
       
     ++ cleanup:
       	strbuf_release(&input);
     + 	strbuf_release(&output);
     + 	warn_on_object_refname_ambiguity = save_warning;
      @@ builtin/cat-file.c: static int batch_option_callback(const struct option *opt,
       
       	bo->enabled = 1;
     @@ builtin/cat-file.c: static int batch_option_callback(const struct option *opt,
       
       	return 0;
      @@ builtin/cat-file.c: int cmd_cat_file(int argc, const char **argv, const char *prefix)
     - 			N_("show info about objects fed from the standard input"),
     + 			N_("like --batch, but don't emit <contents>"),
       			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
       			batch_option_callback),
     -+		OPT_CALLBACK_F(0, "batch-command", &batch, N_(""),
     -+			 N_("enters batch mode that accepts commands"),
     -+			 PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
     -+			 batch_option_callback),
     -+
     - 		OPT_BOOL(0, "follow-symlinks", &batch.follow_symlinks,
     - 			 N_("follow in-tree symlinks (used with --batch or --batch-check)")),
     - 		OPT_BOOL(0, "batch-all-objects", &batch.all_objects,
     ++		OPT_CALLBACK_F(0, "batch-command", &batch, N_("format"),
     ++			N_("read commands from stdin"),
     ++			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
     ++			batch_option_callback),
     + 		OPT_CMDMODE(0, "batch-all-objects", &opt,
     + 			    N_("with --batch[-check]: ignores stdin, batches all known objects"), 'b'),
     + 		/* Batch-specific options */
      
       ## t/t1006-cat-file.sh ##
      @@ t/t1006-cat-file.sh: $content"
     @@ t/t1006-cat-file.sh: $content"
      +    test -z "$content" ||
      +    test_expect_success "--batch-command output of $type content is correct" '
      +	maybe_remove_timestamp "$batch_output" $no_ts >expect &&
     -+	maybe_remove_timestamp "$(echo contents $sha1 | git cat-file --batch-command)" $no_ts >actual &&
     -+	test_cmp expect actual
     -+    '
     -+
     -+    test -z "$content" ||
     -+    test_expect_success "--batch-command session for $type content is correct" '
     -+	maybe_remove_timestamp "$batch_output" $no_ts >expect &&
     -+	maybe_remove_timestamp \
     -+		"$(test_write_lines "begin" "$sha1" "get contents" | git cat-file --batch-command)" \
     -+		$no_ts >actual &&
     ++	maybe_remove_timestamp "$(test_write_lines "contents $sha1" \
     ++	| git cat-file --batch-command)" $no_ts >actual &&
      +	test_cmp expect actual
      +    '
      +
      +    test_expect_success "--batch-command output of $type info is correct" '
      +	echo "$sha1 $type $size" >expect &&
     -+	echo "info $sha1" | git cat-file --batch-command >actual &&
     -+	test_cmp expect actual
     -+    '
     -+
     -+    test_expect_success "--batch-command session for $type info is correct" '
     -+	echo "$sha1 $type $size" >expect &&
     -+	test_write_lines "begin" "$sha1" "get info" | git cat-file --batch-command >actual &&
     ++	test_write_lines "info $sha1" | git cat-file --batch-command >actual &&
      +	test_cmp expect actual
      +    '
      +
           test_expect_success "custom --batch-check format" '
       	echo "$type $sha1" >expect &&
       	echo $sha1 | git cat-file --batch-check="%(objecttype) %(objectname)" >actual &&
     -@@ t/t1006-cat-file.sh: test_expect_success '--batch-check without %(rest) considers whole line' '
     - '
     +@@ t/t1006-cat-file.sh: $content"
     +     '
     + }
       
     - tree_sha1=$(git write-tree)
     ++run_buffer_test_flush () {
     ++	type=$1
     ++	sha1=$2
     ++	size=$3
     ++
     ++	mkfifo input &&
     ++	test_when_finished 'rm input; exec 8<&-' &&
     ++	mkfifo output &&
     ++	exec 9<>output &&
     ++	test_when_finished 'rm output; exec 9<&-'
     ++	(
     ++		git cat-file --buffer --batch-command <input 2>err &
     ++		echo $! &&
     ++		wait $!
     ++	) >&9 &
     ++	sh_pid=$! &&
     ++	read cat_file_pid <&9 &&
     ++	test_when_finished "kill $cat_file_pid
     ++			    kill $sh_pid; wait $sh_pid; :" &&
     ++	echo "$sha1 $type $size" >expect &&
     ++	test_write_lines "info $sha1" flush "info $sha1" >input
     ++	# TODO - consume all available input, not just one
     ++	# line (see above).
     ++	# check output is flushed on exit
     ++	read actual <&9 &&
     ++	echo "$actual" >actual &&
     ++	test_cmp expect actual &&
     ++	test_must_be_empty err
     ++}
     ++
     ++run_buffer_test_no_flush () {
     ++	type=$1
     ++	sha1=$2
     ++	size=$3
     ++
     ++	touch output &&
     ++	test_when_finished 'rm output' &&
     ++	mkfifo input &&
     ++	test_when_finished 'rm input' &&
     ++	mkfifo pid &&
     ++	exec 9<>pid &&
     ++	test_when_finished 'rm pid; exec 9<&-'
     ++	(
     ++		git cat-file --buffer --batch-command <input >output &
     ++		echo $! &&
     ++		wait $!
     ++		echo $?
     ++	) >&9 &
     ++	sh_pid=$! &&
     ++	read cat_file_pid <&9 &&
     ++	test_when_finished "kill $cat_file_pid
     ++			    kill $sh_pid; wait $sh_pid; :" &&
     ++	test_write_lines "info $sha1" "info $sha1" &&
     ++	kill $cat_file_pid &&
     ++	read status <&9 &&
     ++	test_must_be_empty output
     ++}
      +
     - tree_size=$(($(test_oid rawsz) + 13))
     - tree_pretty_content="100644 blob $hello_sha1	hello"
     + hello_content="Hello World"
     + hello_size=$(strlen "$hello_content")
     + hello_sha1=$(echo_without_newline "$hello_content" | git hash-object --stdin)
     +@@ t/t1006-cat-file.sh: test_expect_success "setup" '
       
     -@@ t/t1006-cat-file.sh: test_expect_success \
     + run_tests 'blob' $hello_sha1 $hello_size "$hello_content" "$hello_content"
     + 
     ++test_expect_success PIPE '--batch-command --buffer with flush for blob info' '
     ++       run_buffer_test_flush blob $hello_sha1 $hello_size
     ++'
     ++
     ++test_expect_success PIPE '--batch-command --buffer without flush for blob info' '
     ++       run_buffer_test_no_flush blob $hello_sha1 $hello_size false
     ++'
     ++
     + test_expect_success '--batch-check without %(rest) considers whole line' '
     + 	echo "$hello_sha1 blob $hello_size" >expect &&
     + 	git update-index --add --cacheinfo 100644 $hello_sha1 "white space" &&
     +@@ t/t1006-cat-file.sh: tree_pretty_content="100644 blob $hello_sha1	hello"
     + 
     + run_tests 'tree' $tree_sha1 $tree_size "" "$tree_pretty_content"
     + 
     ++test_expect_success PIPE '--batch-command --buffer with flush for tree info' '
     ++       run_buffer_test_flush tree $tree_sha1 $tree_size
     ++'
     ++
     ++test_expect_success PIPE '--batch-command --buffer without flush for tree info' '
     ++       run_buffer_test_no_flush tree $tree_sha1 $tree_size false
     ++'
     ++
     + commit_message="Initial commit"
     + commit_sha1=$(echo_without_newline "$commit_message" | git commit-tree $tree_sha1)
     + commit_size=$(($(test_oid hexsz) + 137))
     +@@ t/t1006-cat-file.sh: $commit_message"
     + 
     + run_tests 'commit' $commit_sha1 $commit_size "$commit_content" "$commit_content" 1
     + 
     ++test_expect_success PIPE '--batch-command --buffer with flush for commit info' '
     ++       run_buffer_test_flush commit $commit_sha1 $commit_size
     ++'
     ++
     ++test_expect_success PIPE '--batch-command --buffer without flush for commit info' '
     ++       run_buffer_test_no_flush commit $commit_sha1 $commit_size false
     ++'
     ++
     + tag_header_without_timestamp="object $hello_sha1
     + type blob
     + tag hellotag
     +@@ t/t1006-cat-file.sh: tag_size=$(strlen "$tag_content")
     + 
     + run_tests 'tag' $tag_sha1 $tag_size "$tag_content" "$tag_content" 1
     + 
     ++test_expect_success PIPE '--batch-command --buffer with flush for tag info' '
     ++       run_buffer_test_flush tag $tag_sha1 $tag_size
     ++'
     ++
     ++test_expect_success PIPE '--batch-command --buffer without flush for tag info' '
     ++       run_buffer_test_no_flush tag $tag_sha1 $tag_size false
     ++'
     ++
     + test_expect_success \
           "Reach a blob from a tag pointing to it" \
           "test '$hello_content' = \"\$(git cat-file blob $tag_sha1)\""
       
     @@ t/t1006-cat-file.sh: test_expect_success "--batch-check with multiple sha1s give
           "$(echo_without_newline "$batch_check_input" | git cat-file --batch-check)"
       '
       
     -+test_expect_success "--batch-command with multiple sha1s gives correct format" '
     -+    echo "$batch_check_output" >expect &&
     -+    echo begin >input &&
     -+    echo_without_newline "$batch_check_input" >>input &&
     -+    echo "get info" >>input &&
     -+    git cat-file --batch-command <input >actual &&
     -+    test_cmp expect actual
     ++batch_command_info_input="info $hello_sha1
     ++info $tree_sha1
     ++info $commit_sha1
     ++info $tag_sha1
     ++info deadbeef
     ++info 
     ++flush
     ++"
     ++
     ++test_expect_success "--batch-command with multiple info calls gives correct format" '
     ++	test "$batch_check_output" = "$(echo_without_newline \
     ++	"$batch_command_info_input" | git cat-file --batch-command --buffer)"
     ++'
     ++
     ++batch_command_contents_input="contents $hello_sha1
     ++contents $commit_sha1
     ++contents $tag_sha1
     ++contents deadbeef
     ++contents 
     ++flush
     ++"
     ++
     ++test_expect_success "--batch-command with multiple contents calls gives correct format" '
     ++	test "$(maybe_remove_timestamp "$batch_output" 1)" = \
     ++	"$(maybe_remove_timestamp "$(echo_without_newline "$batch_command_contents_input" | git cat-file --batch-command)" 1)"
     ++'
     ++
     ++batch_command_mixed_input="info $hello_sha1
     ++contents $hello_sha1
     ++info $commit_sha1
     ++contents $commit_sha1
     ++info $tag_sha1
     ++contents $tag_sha1
     ++contents deadbeef
     ++info 
     ++flush
     ++"
     ++
     ++batch_command_mixed_output="$hello_sha1 blob $hello_size
     ++$hello_sha1 blob $hello_size
     ++$hello_content
     ++$commit_sha1 commit $commit_size
     ++$commit_sha1 commit $commit_size
     ++$commit_content
     ++$tag_sha1 tag $tag_size
     ++$tag_sha1 tag $tag_size
     ++$tag_content
     ++deadbeef missing
     ++ missing"
     ++
     ++test_expect_success "--batch-command with mixed calls gives correct format" '
     ++	test "$(maybe_remove_timestamp "$batch_command_mixed_output" 1)" = \
     ++	"$(maybe_remove_timestamp "$(echo_without_newline \
     ++	"$batch_command_mixed_input" | git cat-file --batch-command --buffer)" 1)"
      +'
      +
       test_expect_success 'setup blobs which are likely to delta' '
       	test-tool genrandom foo 10240 >foo &&
       	{ cat foo && echo plus; } >foo-plus &&
      @@ t/t1006-cat-file.sh: test_expect_success 'cat-file --batch-all-objects --batch-check ignores replace'
     + 	echo "$orig commit $orig_size" >expect &&
       	test_cmp expect actual
       '
     - 
     ++test_expect_success 'batch-command empty command' '
     ++	echo "" >cmd &&
     ++	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
     ++	grep -E "^fatal:.*empty command in input.*" err
     ++'
     ++
     ++test_expect_success 'batch-command whitespace before command' '
     ++	echo " info deadbeef" >cmd &&
     ++	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
     ++	grep -E "^fatal:.*whitespace before command.*" err
     ++'
     ++
      +test_expect_success 'batch-command unknown command' '
      +	echo unknown_command >cmd &&
     -+	test_expect_code 128 git cat-file --batch-command < cmd 2>err &&
     ++	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
      +	grep -E "^fatal:.*unknown command.*" err
      +'
      +
     ++test_expect_success 'batch-command flush with arguments' '
     ++	echo "flush arg" >cmd &&
     ++	test_expect_code 128 git cat-file --batch-command --buffer <cmd 2>err &&
     ++	grep -E "^fatal:.*flush takes no arguments.*" err
     ++'
     ++
     ++test_expect_success 'batch-command flush without --buffer' '
     ++	echo "flush arg" >cmd &&
     ++	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
     ++	grep -E "^fatal:.*flush is only for --buffer mode.*" err
     ++'
     ++
     ++test_expect_success 'batch-command flush empty queue' '
     ++	echo flush >cmd &&
     ++	test_expect_code 128 git cat-file --batch-command --buffer <cmd 2>err &&
     ++	grep -E "^fatal:.*nothing to flush.*" err
     ++'
     + 
       test_done

-- 
gitgitgadget
