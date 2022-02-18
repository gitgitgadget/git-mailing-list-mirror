Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB8CC433EF
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 16:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238083AbiBRQyS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 11:54:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbiBRQyR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 11:54:17 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32652CF389
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 08:53:59 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id d7so15864769qvk.2
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 08:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=24LbbWQnn1OHjTib/zTFvysYzfajaCDw5moRVQ2ZHsk=;
        b=EXLCilZLynvnzXbwLWlJw2Z/mQTrqmzPZyxmQGHePjDAEKn7ar4Xo87vTOj+CQGveA
         BLShtLC6QsnAAf0PBGEJJ4kgzEp+BPvKHsADIFCtpZKy9dIH/HcaIV9JHupprbXmBe7S
         Le+nAOlDEhgOpUNJ+/kFxP6gQ1gijrJHGb1JQIcw09G0/+Dx9PKixc4D4GHc5oJlZe9m
         wx4/1rfSW6NWmbTVWWll0UagwXeSh9qUhXdF8iGKJ/IaR8kzss/h5i5VCou9aHIToxbE
         3lSa8BPMFBnCWPF1sIlRvMu5yIL5GZN1Rs2XZjQIG7aGTmoWl2s6wwWItL69Ux6HlSmA
         +EHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=24LbbWQnn1OHjTib/zTFvysYzfajaCDw5moRVQ2ZHsk=;
        b=VoMjIjKNq2XuUnJwnAoJt1jOirn3GD69QYtwvN52fm8KEvWPV8olmUrOBzaVgE6oDV
         96cIEMOEtxzHHkMQcdRYjhNl3maAAcLd5PMmb82bP4qXicX/jYGJXYwwAs3fBqH9K8md
         N9JuLU4Qr8EQi+Z5vjZHXW5/mzAoxZWJUA9619V3LdL/Bxua97tSgVvKIBorG7RX2Fyk
         vT4FrEeyA/2dx7bHleyxcDvqDrdp4bpf2UTymfTfdLGkKla1DRKcyHgVtJ5F1FWnjQ/E
         Elz07EV5OzO/vepuMJWaDDPw+FZ/rdEH+g436c7wQZefF3bEs5A0RCAXnSHOXN1+q0BJ
         M6Bg==
X-Gm-Message-State: AOAM532tMy+M2YZ/6pG1uxoiJWiuF1FzOITvmd3zlbEaIS6FSj176R4L
        MeYsCqTM9CgNOZDHSdbamIQ=
X-Google-Smtp-Source: ABdhPJyiYXvp4zNMwBNQKPUm35+uwTZ/CcGGE3QeX/Fudd128tc00FLIqOzqD4vS+bsW8tT4mTAmHw==
X-Received: by 2002:ac8:598f:0:b0:2d2:2e55:d914 with SMTP id e15-20020ac8598f000000b002d22e55d914mr7489694qte.204.1645203238184;
        Fri, 18 Feb 2022 08:53:58 -0800 (PST)
Received: from [10.37.129.2] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id v22sm26431229qtc.96.2022.02.18.08.53.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Feb 2022 08:53:57 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, avarab@gmail.com,
        e@80x24.org, bagasdotme@gmail.com, gitster@pobox.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v9 4/4] cat-file: add --batch-command mode
Date:   Fri, 18 Feb 2022 11:53:56 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <ECBE48BF-156B-4D8A-9CDE-30AE84BF3630@gmail.com>
In-Reply-To: <095278d4-217b-7d97-5364-9cd491b34ed0@gmail.com>
References: <pull.1212.v8.git.git.1645023740.gitgitgadget@gmail.com>
 <pull.1212.v9.git.git.1645045157.gitgitgadget@gmail.com>
 <dbe194f8a8592dd67d6ba3a11cb7b1c81b789cec.1645045157.git.gitgitgadget@gmail.com>
 <095278d4-217b-7d97-5364-9cd491b34ed0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On 18 Feb 2022, at 6:26, Phillip Wood wrote:

> Hi John
>
> This is looking good. I think the only thing that is missing (and which=
 I should have realized earlier) is that there are no tests for valid or =
invalid format arguments to --batch-command. I haven't checked but there =
must be some other tests in the t1006 that we can piggy back on to add th=
at. I've left some stylistic comments below but I don't fell strongly abo=
ut them apart from the README comment so please don't feel obliged to act=
 on them, it's looking pretty good as is.
>
> Best Wishes
>
> Phillip
>
> On 16/02/2022 20:59, John Cai via GitGitGadget wrote:
>> From: John Cai <johncai86@gmail.com>
>>
>> Add a new flag --batch-command that accepts commands and arguments
>> from stdin, similar to git-update-ref --stdin.
>>
>> At GitLab, we use a pair of long running cat-file processes when
>> accessing object content. One for iterating over object metadata with
>> --batch-check, and the other to grab object contents with --batch.
>>
>> However, if we had --batch-command, we wouldn't need to keep both
>> processes around, and instead just have one --batch-command process
>> where we can flip between getting object info, and getting object
>> contents. Since we have a pair of cat-file processes per repository,
>> this means we can get rid of roughly half of long lived git cat-file
>> processes. Given there are many repositories being accessed at any giv=
en
>> time, this can lead to huge savings.
>>
>> git cat-file --batch-command
>>
>> will enter an interactive command mode whereby the user can enter in
>> commands and their arguments that get queued in memory:
>>
>> <command1> [arg1] [arg2] LF
>> <command2> [arg1] [arg2] LF
>>
>> When --buffer mode is used, commands will be queued in memory until a
>> flush command is issued that execute them:
>>
>> flush LF
>>
>> The reason for a flush command is that when a consumer process (A)
>> talks to a git cat-file process (B) and interactively writes to and
>> reads from it in --buffer mode, (A) needs to be able to control when
>> the buffer is flushed to stdout.
>>
>> Currently, from (A)'s perspective, the only way is to either
>>
>> 1. kill (B)'s process
>> 2. send an invalid object to stdin.
>>
>> 1. is not ideal from a performance perspective as it will require
>> spawning a new cat-file process each time, and 2. is hacky and not a
>> good long term solution.
>>
>> With this mechanism of queueing up commands and letting (A) issue a
>> flush command, process (A) can control when the buffer is flushed and
>> can guarantee it will receive all of the output when in --buffer mode.=

>> --batch-command also will not allow (B) to flush to stdout until a flu=
sh
>> is received.
>>
>> This patch adds the basic structure for adding command which can be
>> extended in the future to add more commands. It also adds the followin=
g
>> two commands (on top of the flush command):
>>
>> contents <object> LF
>> info <object> LF
>>
>> The contents command takes an <object> argument and prints out the obj=
ect
>> contents.
>>
>> The info command takes an <object> argument and prints out the object
>> metadata.
>>
>> These can be used in the following way with --buffer:
>>
>> info <object> LF
>> contents <object> LF
>> contents <object> LF
>> info <object> LF
>> flush LF
>> info <object> LF
>> flush LF
>>
>> When used without --buffer:
>>
>> info <object> LF
>> contents <object> LF
>> contents <object> LF
>> info <object> LF
>> info <object> LF
>>
>> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> Signed-off-by: John Cai <johncai86@gmail.com>
>> ---
>>   Documentation/git-cat-file.txt |  42 +++++++++-
>>   builtin/cat-file.c             | 147 +++++++++++++++++++++++++++++++=
+-
>>   t/README                       |   3 +
>>   t/t1006-cat-file.sh            | 107 +++++++++++++++++++++++-
>>   4 files changed, 293 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-fi=
le.txt
>> index bef76f4dd06..70c5b4f12d1 100644
>> --- a/Documentation/git-cat-file.txt
>> +++ b/Documentation/git-cat-file.txt
>> @@ -96,6 +96,33 @@ OPTIONS
>>   	need to specify the path, separated by whitespace.  See the
>>   	section `BATCH OUTPUT` below for details.
>>  +--batch-command::
>> +--batch-command=3D<format>::
>> +	Enter a command mode that reads commands and arguments from stdin. M=
ay
>> +	only be combined with `--buffer`, `--textconv` or `--filters`. In th=
e
>> +	case of `--textconv` or `--filters`, the input lines also need to sp=
ecify
>> +	the path, separated by whitespace. See the section `BATCH OUTPUT` be=
low
>> +	for details.
>> ++
>> +`--batch-command` recognizes the following commands:
>> ++
>> +--
>> +contents <object>::
>> +	Print object contents for object reference `<object>`. This correspo=
nds to
>> +	the output of `--batch`.
>> +
>> +info <object>::
>> +	Print object info for object reference `<object>`. This corresponds =
to the
>> +	output of `--batch-check`.
>> +
>> +flush::
>> +	Used with `--buffer` to execute all preceding commands that were iss=
ued
>> +	since the beginning or since the last flush was issued. When `--buff=
er`
>> +	is used, no output will come until a `flush` is issued. When `--buff=
er`
>> +	is not used, commands are flushed each time without issuing `flush`.=

>> +--
>> ++
>> +
>>   --batch-all-objects::
>>   	Instead of reading a list of objects on stdin, perform the
>>   	requested batch operation on all objects in the repository and
>> @@ -110,7 +137,7 @@ OPTIONS
>>   	that a process can interactively read and write from
>>   	`cat-file`. With this option, the output uses normal stdio
>>   	buffering; this is much more efficient when invoking
>> -	`--batch-check` on a large number of objects.
>> +	`--batch-check` or `--batch-command` on a large number of objects.
>>    --unordered::
>>   	When `--batch-all-objects` is in use, visit objects in an
>> @@ -202,6 +229,13 @@ from stdin, one per line, and print information a=
bout them. By default,
>>   the whole line is considered as an object, as if it were fed to
>>   linkgit:git-rev-parse[1].
>>  +When `--batch-command` is given, `cat-file` will read commands from =
stdin,
>> +one per line, and print information based on the command given. With
>> +`--batch-command`, the `info` command followed by an object will prin=
t
>> +information about the object the same way `--batch-check` would, and =
the
>> +`contents` command followed by an object prints contents in the same =
way
>> +`--batch` would.
>> +
>>   You can specify the information shown for each object by using a cus=
tom
>>   `<format>`. The `<format>` is copied literally to stdout for each
>>   object, with placeholders of the form `%(atom)` expanded, followed b=
y a
>> @@ -237,9 +271,9 @@ newline. The available atoms are:
>>   If no format is specified, the default format is `%(objectname)
>>   %(objecttype) %(objectsize)`.
>>  -If `--batch` is specified, the object information is followed by the=

>> -object contents (consisting of `%(objectsize)` bytes), followed by a
>> -newline.
>> +If `--batch` is specified, or if `--batch-command` is used with the `=
contents`
>> +command, the object information is followed by the object contents (c=
onsisting
>> +of `%(objectsize)` bytes), followed by a newline.
>>    For example, `--batch` without a custom format would produce:
>>  diff --git a/builtin/cat-file.c b/builtin/cat-file.c
>> index 5e38af82af1..3dc960e9f85 100644
>> --- a/builtin/cat-file.c
>> +++ b/builtin/cat-file.c
>> @@ -20,6 +20,7 @@
>>   enum batch_mode {
>>   	BATCH_MODE_CONTENTS,
>>   	BATCH_MODE_INFO,
>> +	BATCH_MODE_QUEUE_AND_DISPATCH,
>>   };
>>    struct batch_options {
>> @@ -513,6 +514,138 @@ static int batch_unordered_packed(const struct o=
bject_id *oid,
>>   				      data);
>>   }
>>  +typedef void (*parse_cmd_fn_t)(struct batch_options *, const char *,=

>> +			       struct strbuf *, struct expand_data *);
>> +
>> +struct queued_cmd {
>> +	parse_cmd_fn_t fn;
>> +	char *line;
>> +};
>> +
>> +static void parse_cmd_contents(struct batch_options *opt,
>> +			     const char *line,
>> +			     struct strbuf *output,
>> +			     struct expand_data *data)
>> +{
>> +	opt->batch_mode =3D BATCH_MODE_CONTENTS;
>> +	batch_one_object(line, output, opt, data);
>> +}
>> +
>> +static void parse_cmd_info(struct batch_options *opt,
>> +			   const char *line,
>> +			   struct strbuf *output,
>> +			   struct expand_data *data)
>> +{
>> +	opt->batch_mode =3D BATCH_MODE_INFO;
>> +	batch_one_object(line, output, opt, data);
>> +}
>> +
>> +static void dispatch_calls(struct batch_options *opt,
>> +		struct strbuf *output,
>> +		struct expand_data *data,
>> +		struct queued_cmd *cmd,
>> +		int nr)
>> +{
>> +	int i;
>> +
>> +	if (!opt->buffer_output)
>> +		die(_("flush is only for --buffer mode"));
>> +
>> +	for (i =3D 0; i < nr; i++)
>> +		cmd[i].fn(opt, cmd[i].line, output, data);
>> +
>> +	fflush(stdout);
>> +}
>> +
>> +static void free_cmds(struct queued_cmd *cmd, int nr)
>> +{
>> +	int i;
>> +
>> +	for (i =3D 0; i < nr; i++)
>> +		FREE_AND_NULL(cmd[i].line);
>> +}
>> +
>> +
>> +static const struct parse_cmd {
>> +	const char *name;
>> +	parse_cmd_fn_t fn;
>> +	unsigned takes_args;
>> +} commands[] =3D {
>> +	{ "contents", parse_cmd_contents, 1},
>> +	{ "info", parse_cmd_info, 1},
>> +	{ "flush", NULL, 0},
>> +};
>> +
>> +static void batch_objects_command(struct batch_options *opt,
>> +				    struct strbuf *output,
>> +				    struct expand_data *data)
>> +{
>> +	struct strbuf input =3D STRBUF_INIT;
>> +	struct queued_cmd *queued_cmd =3D NULL;
>> +	size_t alloc =3D 0, nr =3D 0;
>> +
>> +	while (!strbuf_getline(&input, stdin)) {
>> +		int i;
>> +		const struct parse_cmd *cmd =3D NULL;
>> +		const char *p =3D NULL, *cmd_end;
>> +		struct queued_cmd call =3D {0};
>> +
>> +		if (!input.len)
>> +			die(_("empty command in input"));
>> +		if (isspace(*input.buf))
>> +			die(_("whitespace before command: '%s'"), input.buf);
>> +
>> +		for (i =3D 0; i < ARRAY_SIZE(commands); i++) {
>> +			if (!skip_prefix(input.buf, commands[i].name, &cmd_end))
>> +				continue;
>> +
>> +			cmd =3D &commands[i];
>> +			if (cmd->takes_args) {
>> +				if (*cmd_end !=3D ' ')
>> +					die(_("%s requires arguments"),
>> +					    commands[i].name);
>> +
>> +				p =3D cmd_end + 1;
>> +			} else if (*cmd_end) {
>> +				die(_("%s takes no arguments"),
>> +				    commands[i].name);
>> +			}
>> +
>> +			break;
>> +		}
>> +
>> +		if (!cmd)
>> +			die(_("unknown command: '%s'"), input.buf);
>> +
>> +		if (!strcmp(cmd->name, "flush")) {
>> +			dispatch_calls(opt, output, data, queued_cmd, nr);
>> +			free_cmds(queued_cmd, nr);
>> +			nr =3D 0;
>
> It'd be nice if free_cmds() zeroed nr for us rather than having to reme=
mber to do it separately as the two are intimately linked.

This does feel cleaner. Before there was a version where I did this insid=
e of
dispatch_calls and there was feedback that this wasn't clean. But now tha=
t
free_cmds prepares the queued_cmd array for reuse, then it may make sense=
 to do
it inside. Though honestly from the back and forth around this, I'm not t=
oo sure
what the best thing to do stylistically would be.

>
>> +			continue;
>> +		}
>> +
>> +		if (!opt->buffer_output) {
>> +			cmd->fn(opt, p, output, data);
>> +			continue;
>> +		}
>> +
>> +		ALLOC_GROW(queued_cmd, nr + 1, alloc);
>> +		call.fn =3D cmd->fn;
>> +		call.line =3D xstrdup_or_null(p);
>> +		queued_cmd[nr++] =3D call;
>
> I found this a bit confusing to follow with all the "continue"s for me =
it would be easier to follow if this was written as
>     if (!strcmp(cmd->name, "flush") {
>     	...
>     } else if (!opt->buffer_output) {
>     	...
>     } else {
>     	ALLOC_GROW ...
>     }

Good point. I think this would be easier to follow.
>
>> +	}
>> +
>> +	if (opt->buffer_output &&
>> +	    nr &&
>> +	    !git_env_bool("GIT_TEST_CAT_FILE_NO_FLUSH_ON_EXIT", 0)) {
>> +		dispatch_calls(opt, output, data, queued_cmd, nr);
>> +		free_cmds(queued_cmd, nr);
>> +	}
>> +
>> +	free(queued_cmd);
>> +	strbuf_release(&input);
>> +}
>> +
>>   static int batch_objects(struct batch_options *opt)
>>   {
>>   	struct strbuf input =3D STRBUF_INIT;
>> @@ -595,6 +728,11 @@ static int batch_objects(struct batch_options *op=
t)
>>   	save_warning =3D warn_on_object_refname_ambiguity;
>>   	warn_on_object_refname_ambiguity =3D 0;
>>  +	if (opt->batch_mode =3D=3D BATCH_MODE_QUEUE_AND_DISPATCH) {
>> +		batch_objects_command(opt, &output, &data);
>> +		goto cleanup;
>> +	}
>> +
>>   	while (strbuf_getline(&input, stdin) !=3D EOF) {
>>   		if (data.split_on_whitespace) {
>>   			/*
>> @@ -613,6 +751,7 @@ static int batch_objects(struct batch_options *opt=
)
>>   		batch_one_object(input.buf, &output, opt, &data);
>>   	}
>>  + cleanup:
>>   	strbuf_release(&input);
>>   	strbuf_release(&output);
>>   	warn_on_object_refname_ambiguity =3D save_warning;
>> @@ -645,6 +784,8 @@ static int batch_option_callback(const struct opti=
on *opt,
>>   		bo->batch_mode =3D BATCH_MODE_CONTENTS;
>>   	else if (!strcmp(opt->long_name, "batch-check"))
>>   		bo->batch_mode =3D BATCH_MODE_INFO;
>> +	else if (!strcmp(opt->long_name, "batch-command"))
>> +		bo->batch_mode =3D BATCH_MODE_QUEUE_AND_DISPATCH;
>>   	else
>>   		BUG("%s given to batch-option-callback", opt->long_name);
>>  @@ -666,7 +807,7 @@ int cmd_cat_file(int argc, const char **argv, con=
st char *prefix)
>>   		N_("git cat-file <type> <object>"),
>>   		N_("git cat-file (-e | -p) <object>"),
>>   		N_("git cat-file (-t | -s) [--allow-unknown-type] <object>"),
>> -		N_("git cat-file (--batch | --batch-check) [--batch-all-objects]\n"=

>> +		N_("git cat-file (--batch | --batch-check | --batch-command) [--bat=
ch-all-objects]\n"
>>   		   "             [--buffer] [--follow-symlinks] [--unordered]\n"
>>   		   "             [--textconv | --filters]"),
>>   		N_("git cat-file (--textconv | --filters)\n"
>> @@ -695,6 +836,10 @@ int cmd_cat_file(int argc, const char **argv, con=
st char *prefix)
>>   			N_("like --batch, but don't emit <contents>"),
>>   			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
>>   			batch_option_callback),
>> +		OPT_CALLBACK_F(0, "batch-command", &batch, N_("format"),
>> +			N_("read commands from stdin"),
>> +			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
>> +			batch_option_callback),
>>   		OPT_CMDMODE(0, "batch-all-objects", &opt,
>>   			    N_("with --batch[-check]: ignores stdin, batches all known ob=
jects"), 'b'),
>>   		/* Batch-specific options */
>> diff --git a/t/README b/t/README
>> index f48e0542cdc..bcd813b0c59 100644
>> --- a/t/README
>> +++ b/t/README
>> @@ -472,6 +472,9 @@ a test and then fails then the whole test run will=
 abort. This can help to make
>>   sure the expected tests are executed and not silently skipped when t=
heir
>>   dependency breaks or is simply not present in a new environment.
>>  +GIT_TEST_CAT_FILE_NO_FLUSH_ON_EXIT=3D<boolean>, when true will preve=
nt cat-file
>> +--batch-command from flushing to output on exit.
>
> I don't think you need to document this here. Looking at the other vari=
ables this is a list of things one can set to change the behavior of the =
tests when they are run. GIT_TEST_CAT_FILE_NO_FLUSH is not in that catego=
ry - we don't want anyone setting it when they run the tests, it's just a=
n implementation detail.

okay sounds good.

>
>> +
>>   Naming Tests
>>   ------------
>>  diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
>> index 2d52851dadc..74f0e36b69e 100755
>> --- a/t/t1006-cat-file.sh
>> +++ b/t/t1006-cat-file.sh
>> @@ -182,6 +182,24 @@ $content"
>>   	test_cmp expect actual
>>       '
>>  +    for opt in --buffer --no-buffer
>> +    do
>> +	test -z "$content" ||
>> +		test_expect_success "--batch-command $opt output of $type content i=
s correct" '
>> +		maybe_remove_timestamp "$batch_output" $no_ts >expect &&
>> +		maybe_remove_timestamp "$(test_write_lines "contents $sha1" \
>> +		| git cat-file --batch-command $opt)" $no_ts >actual &&
>> +		test_cmp expect actual
>> +	'
>> +
>> +	test_expect_success "--batch-command $opt output of $type info is co=
rrect" '
>> +		echo "$sha1 $type $size" >expect &&
>> +		test_write_lines "info $sha1" \
>> +		| git cat-file --batch-command $opt >actual &&
>> +		test_cmp expect actual
>> +	'
>> +    done
>> +
>>       test_expect_success "custom --batch-check format" '
>>   	echo "$type $sha1" >expect &&
>>   	echo $sha1 | git cat-file --batch-check=3D"%(objecttype) %(objectna=
me)" >actual &&
>> @@ -229,6 +247,22 @@ test_expect_success "setup" '
>>    run_tests 'blob' $hello_sha1 $hello_size "$hello_content" "$hello_c=
ontent"
>>  +test_expect_success '--batch-command --buffer with flush for blob in=
fo' '
>> +	echo "$hello_sha1 blob $hello_size" >expect &&
>> +	test_write_lines "info $hello_sha1" "flush" | \
>
> You don't need a '\' after a '|', however it might be better to use the=
 style from the tests above where the '|' is on the beginning of the next=
 line.

good to know. I'll adjust this.
>
>> +	GIT_TEST_CAT_FILE_NO_FLUSH_ON_EXIT=3D1 \
>> +	git cat-file --batch-command --buffer >actual &&
>> +	test_cmp expect actual
>> +'
>> +
>> +test_expect_success '--batch-command --buffer without flush for blob =
info' '
>> +	touch output &&
>> +	test_write_lines "info $hello_sha1" | \
>> +	GIT_TEST_CAT_FILE_NO_FLUSH_ON_EXIT=3D1 \
>> +	git cat-file --batch-command --buffer >>output &&
>> +	test_must_be_empty output
>> +'
>> +
>>   test_expect_success '--batch-check without %(rest) considers whole l=
ine' '
>>   	echo "$hello_sha1 blob $hello_size" >expect &&
>>   	git update-index --add --cacheinfo 100644 $hello_sha1 "white space"=
 &&
>> @@ -272,7 +306,7 @@ test_expect_success \
>>       "Reach a blob from a tag pointing to it" \
>>       "test '$hello_content' =3D \"\$(git cat-file blob $tag_sha1)\""
>>  -for batch in batch batch-check
>> +for batch in batch batch-check batch-command
>>   do
>>       for opt in t s e p
>>       do
>> @@ -378,6 +412,42 @@ test_expect_success "--batch-check with multiple =
sha1s gives correct format" '
>>       "$(echo_without_newline "$batch_check_input" | git cat-file --ba=
tch-check)"
>>   '
>>  +test_expect_success '--batch-command with multiple info calls gives =
correct format' '
>> +	cat >expect <<-EOF &&
>> +	$hello_sha1 blob $hello_size
>> +	$tree_sha1 tree $tree_size
>> +	$commit_sha1 commit $commit_size
>> +	$tag_sha1 tag $tag_size
>> +	deadbeef missing
>> +	EOF
>> +
>> +	test_write_lines "info $hello_sha1"\
>> +	"info $tree_sha1"\
>> +	"info $commit_sha1"\
>> +	"info $tag_sha1"\
>> +	"info deadbeef" | git cat-file --batch-command --buffer >actual &&
>
> This is quite noisy with all the " and \, using a here document instead=
 would match our usual style.

That's a good suggestion. I can change this into a here doc

>
>> +	test_cmp expect actual
>> +'
>> +
>> +test_expect_success '--batch-command with multiple command calls give=
s correct format' '
>> +	remove_timestamp >expect <<-EOF &&
>> +	$hello_sha1 blob $hello_size
>> +	$hello_content
>> +	$commit_sha1 commit $commit_size
>> +	$commit_content
>> +	$tag_sha1 tag $tag_size
>> +	$tag_content
>> +	deadbeef missing
>> +	EOF
>> +
>> +	test_write_lines "contents $hello_sha1"\
>> +	"contents $commit_sha1"\
>> +	"contents $tag_sha1"\
>> +	"contents deadbeef"\
>> +	"flush" | git cat-file --batch-command --buffer | remove_timestamp >=
actual &&
>
> This loses the exit code of the command we're trying to test, it would =
be better to have
>     git cat-file ... >actual-raw &&
>     remove_timestamp <actual-raw >actual
>

I hadn't considered this effect. Thanks for pointing that out!

>> +	test_cmp expect actual
>> +'
>> +
>>   test_expect_success 'setup blobs which are likely to delta' '
>>   	test-tool genrandom foo 10240 >foo &&
>>   	{ cat foo && echo plus; } >foo-plus &&
>> @@ -968,5 +1038,40 @@ test_expect_success 'cat-file --batch-all-object=
s --batch-check ignores replace'
>>   	echo "$orig commit $orig_size" >expect &&
>>   	test_cmp expect actual
>>   '
>> +test_expect_success 'batch-command empty command' '
>> +	echo "" >cmd &&
>> +	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
>> +	grep "^fatal:.*empty command in input.*" err
>> +'
>> +
>> +test_expect_success 'batch-command whitespace before command' '
>> +	echo " info deadbeef" >cmd &&
>> +	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
>> +	grep "^fatal:.*whitespace before command.*" err
>> +'
>> +
>> +test_expect_success 'batch-command unknown command' '
>> +	echo unknown_command >cmd &&
>> +	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
>> +	grep "^fatal:.*unknown command.*" err
>> +'
>> +
>> +test_expect_success 'batch-command missing arguments' '
>> +	echo "info" >cmd &&
>> +	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
>> +	grep "^fatal:.*info requires arguments.*" err
>> +'
>> +
>> +test_expect_success 'batch-command flush with arguments' '
>> +	echo "flush arg" >cmd &&
>> +	test_expect_code 128 git cat-file --batch-command --buffer <cmd 2>er=
r &&
>> +	grep "^fatal:.*flush takes no arguments.*" err
>> +'
>> +
>> +test_expect_success 'batch-command flush without --buffer' '
>> +	echo "flush" >cmd &&
>> +	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
>> +	grep "^fatal:.*flush is only for --buffer mode.*" err
>> +'
>>    test_done
