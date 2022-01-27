Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56322C433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 21:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243736AbiA0VEW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 16:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbiA0VEW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 16:04:22 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABC3C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 13:04:21 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id p63so4393404iod.11
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 13:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3NRjEH3AaUfiIcCxpINixUwx3nrVVvJLQXJcoaF1YkQ=;
        b=DhUegqp2mwW8JvD4FmYZ3KQ46NnC5s89lHzwocIj0/Y1QY5gwbDKyvHF2TzvisI1oK
         x8nXvRe+r+6dkuQ2EdckFgJ4N2RcIqAAfzwseBrjVmJgIhgQhwEjWKXkhxoc7UHgum9y
         0C8LcnRRd0pkUfidISJIt8OBDUDVn0TEjQlHcEGOjsxJPKWV5xiT4qvhGH5mjSik52l9
         9vXlej2H503Neykb+j/Zneu1jp7uCCvXEDI7OA9yedjk1n8OvD3GZ7UrcJFzsRHBxL8i
         Nk/OGKQcyFynrFQdxzqd11LORXEQ4C2it55VxKfIJUPcW0qI0j50L5Caj9eCrXCCZcny
         u1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3NRjEH3AaUfiIcCxpINixUwx3nrVVvJLQXJcoaF1YkQ=;
        b=0AVeuyo46h9mezFwQifJDbYqKF68iqV+RcdOxsKQ9CaoWTMUGJnDutQn4TsseGNtNz
         H+NlRBU7KF4TH0L/N2OIgrCyzYWzwz1xa9ABsHMGWv3qUShtOM/OJIzgDCTcM3aoIDfm
         EgmEIp1plkc98iIfWYh5gY3DgJ1Zw+cTfrSa4QSIc/nj9VJ43lDQWZxrIZjBjiEzls70
         6GUWbjcLCutuFfv3Iy3EmpNqhJio39Ycka0nBwwDLXKGEY0f9RmPKBygAJmLdNlxOFfk
         02nxBJFTI2iPYXAlN4fWIaEcJFR5/AednPwEGS7ot2OMf9f1qVqeM2vOpZpiWnb+VU5y
         Y4kA==
X-Gm-Message-State: AOAM531WZCyK79EcPYy5aLej1kuR3pdhjYC34UO4FxtJ2h3pyxvbOs/e
        hW4HcpVo8RR0MMtLo/lRxJU=
X-Google-Smtp-Source: ABdhPJxFTXWatwfJE6lCVKH9ZkW6L0E4s5s5JNXlScPAfiL4NzvUuldsVZ6fPs+OcyHK0UUNunl4Sg==
X-Received: by 2002:a6b:b7cf:: with SMTP id h198mr3280385iof.166.1643317461322;
        Thu, 27 Jan 2022 13:04:21 -0800 (PST)
Received: from [192.168.68.66] (ool-ad03998c.dyn.optonline.net. [173.3.153.140])
        by smtp.gmail.com with ESMTPSA id g14sm12394758ilj.41.2022.01.27.13.04.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jan 2022 13:04:20 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, avarab@gmail.com, me@ttaylorr.com
Subject: Re: [RFC v2] cat-file: add a --stdin-cmd mode
Date:   Thu, 27 Jan 2022 16:04:19 -0500
X-Mailer: MailMate Trial (1.14r5852)
Message-ID: <1C2DA310-452B-4846-9183-0D3CDB05620B@gmail.com>
In-Reply-To: <1540ee6b-d7ef-428e-d2f8-74bc4847c34f@gmail.com>
References: <20220125225008.45944-1-johncai86@gmail.com>
 <1540ee6b-d7ef-428e-d2f8-74bc4847c34f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Phillip,

First of all thank you for the thorough review=E2=80=94it really helps so=
meone who=E2=80=99s learning how to contribute!

On 27 Jan 2022, at 6:25, Phillip Wood wrote:

> Hi John
>
> On 25/01/2022 22:50, John Cai wrote:
>> This RFC patch proposes a new flag --stdin-cmd that works with
>> git-cat-file --batch. Similar to git-update-ref --stdin, it will accep=
t
>> commands and arguments from stdin.
>>
>> The start of this idea was discussed in [1], where the original
>> motivation was to be able to control when the buffer was flushed to
>> stdout in --buffer mode.
>>
>> However, this can actually be much more useful in situations when
>> git-cat-file --batch is being used as a long lived backend query
>> process. At GitLab, we use a pair of cat-file processes. One for
>> iterating over object metadata with --batch-check, and the other to gr=
ab
>> object contents with --batch. However, if we had --stdin-cmd, we could=

>> get rid of the second --batch-check process, and just have one progres=
s
>> where we can flip between getting object info, and getting object cont=
ents.
>> This can lead to huge savings.
>>
>> git cat-file --batch --stdin-cmd
>>
>> $ <command> [arg1] [arg2] NL
>>
>> We can also add a -z mode to allow for NUL-terminated lines
>>
>> $ <command> [arg1] [arg2] NUL
>>
>> This patch adds three commands: object, info, fflush
>>
>> $ object <sha1> NL
>> $ info <sha1> NL
>> $ fflush NL
>>
>> These three would be immediately useful in GitLab's context, but one c=
an
>> imagine this mode to be further extended for other things.
>>
>> For instance, a non-trivial part of "cat-file --batch" time is spent
>> on parsing its argument and seeing if it's a revision, ref etc. So we
>> could add a command that only accepts a full-length 40
>> character SHA-1.
>>
>> This would be the first step in adding such an interface to
>> git-cat-file.
>>
>> [1] https://lore.kernel.org/git/pull.1124.git.git.1636149400.gitgitgad=
get@gmail.com/
>>
>> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> Signed-off-by: John Cai <johncai86@gmail.com>
>> ---
>> Changes from v1:
>>
>> - changed option name to batch-command.
>> - changed command function interface to receive the whole line after t=
he command
>>    name to put the onus of parsing arguments to each individual comman=
d function.
>> - pass in whole line to batch_one_object in both parse_cmd_object and
>>    parse_cmd_info to support spaces in the object reference.
>> - removed addition of -z to include in a separate patch series
>> - added documentation.
>
> I've left some comments below, they're mostly small details, I like the=
 new option name and the changes you've made to the command parsing.
>
>> ---
>>   Documentation/git-cat-file.txt |  15 +++++
>>   builtin/cat-file.c             | 114 +++++++++++++++++++++++++++++++=
+-
>>   strvec.c                       |  23 +++++++
>>   strvec.h                       |   8 +++
>>   t/t1006-cat-file.sh            |  32 +++++++++
>>   5 files changed, 191 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-fi=
le.txt
>> index bef76f4dd0..8aefa45e4c 100644
>> --- a/Documentation/git-cat-file.txt
>> +++ b/Documentation/git-cat-file.txt
>> @@ -96,6 +96,21 @@ OPTIONS
>>   	need to specify the path, separated by whitespace.  See the
>>   	section `BATCH OUTPUT` below for details.
>>  +-batch-command::
>
> is this missing a '-'?
>
>> +	Enter a command mode that reads from stdin. May not be combined with=
 any
>> +	other options or arguments except `--textconv` or `--filters`, in wh=
ich
>> +	case the input lines also need to specify the path, separated by
>> +	whitespace.  See the section `BATCH OUTPUT` below for details.
>> +
>> +object <object>::
>> +	Print object contents for object reference <object>
>> +
>> +info <object>::
>> +	Print object info for object reference <object>
>> +
>> +flush::
>> +	Flush to stdout immediately when used with --buffer
>> +
>>   --batch-all-objects::
>>   	Instead of reading a list of objects on stdin, perform the
>>   	requested batch operation on all objects in the repository and
>> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
>> index 7b3f42950e..30794284d5 100644
>> --- a/builtin/cat-file.c
>> +++ b/builtin/cat-file.c
>> @@ -16,6 +16,7 @@
>>   #include "packfile.h"
>>   #include "object-store.h"
>>   #include "promisor-remote.h"
>> +#include "strvec.h"
>>    struct batch_options {
>>   	int enabled;
>> @@ -26,7 +27,10 @@ struct batch_options {
>>   	int unordered;
>>   	int cmdmode; /* may be 'w' or 'c' for --filters or --textconv */
>>   	const char *format;
>> +	int stdin_cmd;
>
> Now that the option has been renamed it would be nice to rename the cor=
responding variable to match

I was trying to find a good name. There is already a cmdmode variable. I=E2=
=80=99m thinking stdin_cmd is not such a
bad name since we are receiving commands from stdin. suggestions welcome!=


>
>> +	int end_null;
>
> If you're not adding '-z' here then you don't need this or the addition=
 below.
>
>>   };
>> +static char line_termination =3D '\n';
>>    static const char *force_path;
>>  @@ -508,6 +512,102 @@ static int batch_unordered_packed(const struct =
object_id *oid,
>>   				      data);
>>   }
>>  +enum batch_state {
>> +	/* Non-transactional state open for commands. */
>> +	BATCH_STATE_OPEN,
>> +};
>
> I forgot to ask what the idea behind the batch state is last time - wha=
t's it for?

This is to support transactional semantics for commands we want to suppor=
t in the future, but
since this is already a biggish change, we can leave this out of this ser=
ies.

>
>> +static void parse_cmd_object(struct batch_options *opt,
>> +			     const char *line,
>> +			     struct strbuf *output,
>> +			     struct expand_data *data)
>> +{
>> +	opt->print_contents =3D 1;
>> +	batch_one_object(line, output, opt, data);
>> +}
>> +
>> +static void parse_cmd_info(struct batch_options *opt,
>> +			   const char *line,
>> +			   struct strbuf *output,
>> +			   struct expand_data *data)
>> +{
>> +	opt->print_contents =3D 0;
>> +	batch_one_object(line, output, opt, data);
>> +}
>> +
>> +static void parse_cmd_fflush(struct batch_options *opt,
>> +			     const char *line,
>> +			     struct strbuf *output,
>> +			     struct expand_data *data)
>> +{
>> +	fflush(stdout);
>> +}
>> +
>> +typedef void (*parse_cmd_fn_t)(struct batch_options *, const char *,
>> +			       struct strbuf *, struct expand_data *);
>> +
>> +static const struct parse_cmd {
>> +	const char *prefix;
>> +	parse_cmd_fn_t fn;
>> +	unsigned args;
>
> This is now a flag so maybe 'takes_args' would better describe its purp=
ose.
>
>> +	enum batch_state state;
>> +} commands[] =3D {
>> +	{ "object", parse_cmd_object, 1, BATCH_STATE_OPEN },
>> +	{ "info", parse_cmd_info, 1, BATCH_STATE_OPEN },
>> +	{ "fflush", parse_cmd_fflush, 0, BATCH_STATE_OPEN },
>> +};
>> +
>> +static void batch_objects_stdin_cmd(struct batch_options *opt,
>> +				    struct strbuf *output,
>> +				    struct expand_data *data)
>> +{
>> +	struct strbuf input =3D STRBUF_INIT;
>> +	enum batch_state state =3D BATCH_STATE_OPEN;
>> +
>> +	/* Read each line dispatch its command */
>> +	while (!strbuf_getwholeline(&input, stdin, line_termination)) {
>> +		int i;
>> +		const struct parse_cmd *cmd =3D NULL;
>> +		const char *p;
>> +
>> +		if (*input.buf =3D=3D line_termination)
>> +			die("empty command in input");
>> +		else if (isspace(*input.buf))
>> +			die("whitespace before command: %s", input.buf);
>> +
>> +		for (i =3D 0; i < ARRAY_SIZE(commands); i++) {
>> +			const char *prefix =3D commands[i].prefix;
>> +			char c;
>> +			const char *cmd_name;
>
> skip_prefix() sets this to the end of the name so maybe 'cmd_end' would=
 be clearer?
>
>> +			if (!skip_prefix(input.buf, prefix, &cmd_name))
>> +				continue;
>> +			/*
>> +			 * If the command has arguments, verify that it's
>> +			 * followed by a space. Otherwise, it shall be followed
>> +			 * by a line terminator.
>> +			 */
>> +			c =3D commands[i].args ? ' ' : line_termination;
>> +			if (input.buf[strlen(prefix)] !=3D c)
>
> Now that you're using skip_prefix() you can write this as
>     		if (*cmd_end !=3D c)
>
>> +				continue;
>> +
>> +			cmd =3D &commands[i];
>> +			break;
>> +		}
>> +		if (!cmd)
>> +			die("unknown command: %s", input.buf);
>> +
>> +		p =3D input.buf + strlen(cmd->prefix) + 1;
>
> This can be simplified to
>     	p =3D cmd_end + 1;
>
>> +		const char *pos =3D strstr(p, &line_termination);
>
> This isn't needed without '-z'. If it were required then using strchrnu=
l() would prevent a NULL pointer dereference when the last input line doe=
s not end with a terminator. I think we typically call a pointer to the e=
nd of the line 'eol' or 'end'. Also variables should be declared at the t=
op of the function.
>
>> +		switch (state) {
>> +		case BATCH_STATE_OPEN:
>> +			break;
>> +		}
>> +		cmd->fn(opt, xstrndup(p, pos-p), output, data);
>
> Is there a reason this is passing a copy of the string?
>
>> +	}
>> +	strbuf_release(&input);
>> +}
>> +
>>   static int batch_objects(struct batch_options *opt)
>>   {
>>   	struct strbuf input =3D STRBUF_INIT;
>> @@ -515,6 +615,7 @@ static int batch_objects(struct batch_options *opt=
)
>>   	struct expand_data data;
>>   	int save_warning;
>>   	int retval =3D 0;
>> +	const int stdin_cmd =3D opt->stdin_cmd;
>>    	if (!opt->format)
>>   		opt->format =3D "%(objectname) %(objecttype) %(objectsize)";
>> @@ -590,7 +691,8 @@ static int batch_objects(struct batch_options *opt=
)
>>   	save_warning =3D warn_on_object_refname_ambiguity;
>>   	warn_on_object_refname_ambiguity =3D 0;
>>  -	while (strbuf_getline(&input, stdin) !=3D EOF) {
>> +	while (!stdin_cmd &&
>
> If you moved the 'if (stdin_cmd)' block above this block we could loose=
 this change. I'm not sure if that is possible without looking at the who=
le function though.
>
>> +	       strbuf_getline(&input, stdin) !=3D EOF) {
>>   		if (data.split_on_whitespace) {
>>   			/*
>>   			 * Split at first whitespace, tying off the beginning
>> @@ -608,6 +710,9 @@ static int batch_objects(struct batch_options *opt=
)
>>   		batch_one_object(input.buf, &output, opt, &data);
>>   	}
>>  +	if (stdin_cmd)
>> +		batch_objects_stdin_cmd(opt, &output, &data);
>> +
>>   	strbuf_release(&input);
>>   	strbuf_release(&output);
>>   	warn_on_object_refname_ambiguity =3D save_warning;
>> @@ -636,6 +741,7 @@ static int batch_option_callback(const struct opti=
on *opt,
>>    	bo->enabled =3D 1;
>>   	bo->print_contents =3D !strcmp(opt->long_name, "batch");
>> +	bo->stdin_cmd =3D !strcmp(opt->long_name, "batch-command");
>>   	bo->format =3D arg;
>>    	return 0;
>> @@ -683,6 +789,10 @@ int cmd_cat_file(int argc, const char **argv, con=
st char *prefix)
>>   			N_("like --batch, but don't emit <contents>"),
>>   			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
>>   			batch_option_callback),
>> +		OPT_CALLBACK_F(0, "batch-command", &batch, N_(""),
>> +			 N_("enters batch mode that accepts commands"),
>> +			 PARSE_OPT_NOARG | PARSE_OPT_NONEG,
>> +			 batch_option_callback),
>>   		OPT_CMDMODE(0, "batch-all-objects", &opt,
>>   			    N_("with --batch[-check]: ignores stdin, batches all known ob=
jects"), 'b'),
>>   		/* Batch-specific options */
>> @@ -738,6 +848,8 @@ int cmd_cat_file(int argc, const char **argv, cons=
t char *prefix)
>>   	/* Batch defaults */
>>   	if (batch.buffer_output < 0)
>>   		batch.buffer_output =3D batch.all_objects;
>> +	if (batch.end_null)
>> +		line_termination =3D '\0';
>>    	/* Return early if we're in batch mode? */
>>   	if (batch.enabled) {
>> diff --git a/strvec.c b/strvec.c
>> index 61a76ce6cb..7dca04bf7a 100644
>> --- a/strvec.c
>> +++ b/strvec.c
>> [...]
>
> We don't need any strvec changes now that we don't split the input line=
s to --bactch-command
>
>> +F=3D'%s\0'
>
> This isn't used now
>
>> +test_expect_success 'batch-command unknown command' '
>> +	echo unknown_command >cmd &&
>> +	test_expect_code 128 git cat-file --batch-command < cmd 2>err &&
>> +	grep -E "^fatal:.*unknown command.*" err
>> +'
>> +
>> +test_expect_success 'setup object data' '
>> +	content=3D"Object Data" &&
>> +	size=3D$(strlen "$content") &&
>> +	sha1=3D$(echo_without_newline "$content" | git hash-object -w --stdi=
n)
>> +'
>> +
>> +test_expect_success 'batch-command calling object works' '
>> +	echo "object $sha1" | git cat-file --batch-command >actual &&
>> +	echo "$sha1 blob $size" >expect &&
>> +	echo `git cat-file -p "$sha1"` >>expect &&
>> +	test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'batch-command calling info works' '
>> +	echo "info $sha1" | git cat-file --batch-command >actual &&
>> +	echo "$sha1 blob $size" >expect &&
>> +	test_cmp expect actual
>> +'
>
> I had a quick look at this test file and there is a loop at the top tha=
t runs some --batch tests on various inputs, I wonder if these two tests =
could go in there.
>
>> +test_expect_success 'batch-command fflush works' '
>> +	printf "fflush\n" > cmd &&
>> +	test_expect_code 0 git cat-file --batch-command < cmd 2>err
>> +'
>
> It'd be nice to check this actually flushes the output.

could you give me some ideas on how to do this?

>
> Best Wishes
>
> Phillip
>
>>   test_done
