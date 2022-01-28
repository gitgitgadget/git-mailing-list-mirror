Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A742EC433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 04:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345959AbiA1EQ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 23:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236875AbiA1EQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 23:16:25 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FD5C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 20:16:25 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id t7so4849050qvj.0
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 20:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9s1Yy8mx5l2BDSjwI83u9lG+e3bQORvayF8V6SmiGdM=;
        b=bT1Zw6dTzI+3jPC4NZZQY9Dlc24JjzGvasYew68371Oe9soikcRX4vZt5R3EHzrQi4
         3C0eY6PTqcB+oaMiwXiSu7ja8FQ804vOKxRWZIFhaRR1/TsGTdAmSUbbcUtAkSt+7xAC
         e2t2zcvpwMOxu19oU9xe6//yYW2PQxZgRPISYmmhxRNceJtg5wcY7YOe19CQiw4/3uHs
         6qtPW/jBVfm2TlIYuKMlF/S/aYOTojklRXz9frKijAV3fCVD5nUYwDzq/b8Q6AaY0kDp
         z4Bw3AlCYKXBw35ud+FqMYexryBrRAleC6ddS0Wo9C9jaLIcZwAY97QgpsXDDcjkfKHs
         DeLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9s1Yy8mx5l2BDSjwI83u9lG+e3bQORvayF8V6SmiGdM=;
        b=BcYDyAVYRKEGsdbjkvPGSoKkmomMexAaozzmmeXzXI4bFedAqNtW+M/o2iX88uCmBU
         JGP3Py2L0I6ovC9ENwVsUVcjndc+8iPir4OPFqszQJijqLZPQr2DccwTkEEhHwqo4Vgg
         KzZoE2P7tUPkZ+he0Nk5XFle6CABjB6P721ZBHJ7qvkinNr/kESg6Xv0PbX555zMitqV
         yenqNA1L6g8KbK1SoNpwKvankEYFlXA08/QT3CuOWfM6fGlN+ZnSqUKlAaBOlzZqESa3
         SKe66qBVU0GCI5GPEtQ3pohHiCtAEy8zjy+mv3d5jQFqZwQFxsbbP9JjnFKod3icYz56
         xT+g==
X-Gm-Message-State: AOAM531eIhYZH2IJb5ZjJfAjYaKvY0RoE90p/4YuJGfj3/AdBBEu5nos
        IubY70YTSjpLddZyIxP5csWRXo71MVdUDA==
X-Google-Smtp-Source: ABdhPJwrC7a9Gpqvu2fEq4Tzmpb/EtclJU8KV/C+kNcmCzfV/4j39pwLAB0mUGTEGYIdK0av4tp8dw==
X-Received: by 2002:a05:6214:21e2:: with SMTP id p2mr6122067qvj.88.1643343384079;
        Thu, 27 Jan 2022 20:16:24 -0800 (PST)
Received: from [192.168.1.211] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id e66sm2430282qkc.6.2022.01.27.20.16.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jan 2022 20:16:23 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, avarab@gmail.com, me@ttaylorr.com
Subject: Re: [RFC v2] cat-file: add a --stdin-cmd mode
Date:   Thu, 27 Jan 2022 23:16:22 -0500
X-Mailer: MailMate Trial (1.14r5852)
Message-ID: <1D711BE5-9B84-43C7-A8A4-E047430D7A01@gmail.com>
In-Reply-To: <1C2DA310-452B-4846-9183-0D3CDB05620B@gmail.com>
References: <20220125225008.45944-1-johncai86@gmail.com>
 <1540ee6b-d7ef-428e-d2f8-74bc4847c34f@gmail.com>
 <1C2DA310-452B-4846-9183-0D3CDB05620B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Resending this as my last message accidentally included some html and got=
 rejected by the listserv


On 27 Jan 2022, at 16:04, John Cai wrote:

> Hey Phillip,
>
> First of all thank you for the thorough review=E2=80=94it really helps =
someone who=E2=80=99s learning how to contribute!
>
> On 27 Jan 2022, at 6:25, Phillip Wood wrote:
>
>> Hi John
>>
>> On 25/01/2022 22:50, John Cai wrote:
>>> This RFC patch proposes a new flag --stdin-cmd that works with
>>> git-cat-file --batch. Similar to git-update-ref --stdin, it will acce=
pt
>>> commands and arguments from stdin.
>>>
>>> The start of this idea was discussed in [1], where the original
>>> motivation was to be able to control when the buffer was flushed to
>>> stdout in --buffer mode.
>>>
>>> However, this can actually be much more useful in situations when
>>> git-cat-file --batch is being used as a long lived backend query
>>> process. At GitLab, we use a pair of cat-file processes. One for
>>> iterating over object metadata with --batch-check, and the other to g=
rab
>>> object contents with --batch. However, if we had --stdin-cmd, we coul=
d
>>> get rid of the second --batch-check process, and just have one progre=
ss
>>> where we can flip between getting object info, and getting object con=
tents.
>>> This can lead to huge savings.
>>>
>>> git cat-file --batch --stdin-cmd
>>>
>>> $ <command> [arg1] [arg2] NL
>>>
>>> We can also add a -z mode to allow for NUL-terminated lines
>>>
>>> $ <command> [arg1] [arg2] NUL
>>>
>>> This patch adds three commands: object, info, fflush
>>>
>>> $ object <sha1> NL
>>> $ info <sha1> NL
>>> $ fflush NL
>>>
>>> These three would be immediately useful in GitLab's context, but one =
can
>>> imagine this mode to be further extended for other things.
>>>
>>> For instance, a non-trivial part of "cat-file --batch" time is spent
>>> on parsing its argument and seeing if it's a revision, ref etc. So we=

>>> could add a command that only accepts a full-length 40
>>> character SHA-1.
>>>
>>> This would be the first step in adding such an interface to
>>> git-cat-file.
>>>
>>> [1] https://lore.kernel.org/git/pull.1124.git.git.1636149400.gitgitga=
dget@gmail.com/
>>>
>>> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>>> Signed-off-by: John Cai <johncai86@gmail.com>
>>> ---
>>> Changes from v1:
>>>
>>> - changed option name to batch-command.
>>> - changed command function interface to receive the whole line after =
the command
>>>    name to put the onus of parsing arguments to each individual comma=
nd function.
>>> - pass in whole line to batch_one_object in both parse_cmd_object and=

>>>    parse_cmd_info to support spaces in the object reference.
>>> - removed addition of -z to include in a separate patch series
>>> - added documentation.
>>
>> I've left some comments below, they're mostly small details, I like th=
e new option name and the changes you've made to the command parsing.
>>
>>> ---
>>>   Documentation/git-cat-file.txt |  15 +++++
>>>   builtin/cat-file.c             | 114 ++++++++++++++++++++++++++++++=
++-
>>>   strvec.c                       |  23 +++++++
>>>   strvec.h                       |   8 +++
>>>   t/t1006-cat-file.sh            |  32 +++++++++
>>>   5 files changed, 191 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-f=
ile.txt
>>> index bef76f4dd0..8aefa45e4c 100644
>>> --- a/Documentation/git-cat-file.txt
>>> +++ b/Documentation/git-cat-file.txt
>>> @@ -96,6 +96,21 @@ OPTIONS
>>>   	need to specify the path, separated by whitespace.  See the
>>>   	section `BATCH OUTPUT` below for details.
>>>  +-batch-command::
>>
>> is this missing a '-'?
>>
>>> +	Enter a command mode that reads from stdin. May not be combined wit=
h any
>>> +	other options or arguments except `--textconv` or `--filters`, in w=
hich
>>> +	case the input lines also need to specify the path, separated by
>>> +	whitespace.  See the section `BATCH OUTPUT` below for details.
>>> +
>>> +object <object>::
>>> +	Print object contents for object reference <object>
>>> +
>>> +info <object>::
>>> +	Print object info for object reference <object>
>>> +
>>> +flush::
>>> +	Flush to stdout immediately when used with --buffer
>>> +
>>>   --batch-all-objects::
>>>   	Instead of reading a list of objects on stdin, perform the
>>>   	requested batch operation on all objects in the repository and
>>> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
>>> index 7b3f42950e..30794284d5 100644
>>> --- a/builtin/cat-file.c
>>> +++ b/builtin/cat-file.c
>>> @@ -16,6 +16,7 @@
>>>   #include "packfile.h"
>>>   #include "object-store.h"
>>>   #include "promisor-remote.h"
>>> +#include "strvec.h"
>>>    struct batch_options {
>>>   	int enabled;
>>> @@ -26,7 +27,10 @@ struct batch_options {
>>>   	int unordered;
>>>   	int cmdmode; /* may be 'w' or 'c' for --filters or --textconv */
>>>   	const char *format;
>>> +	int stdin_cmd;
>>
>> Now that the option has been renamed it would be nice to rename the co=
rresponding variable to match
>
> I was trying to find a good name. There is already a cmdmode variable. =
I=E2=80=99m thinking stdin_cmd is not such a
> bad name since we are receiving commands from stdin. suggestions welcom=
e!
>
>>
>>> +	int end_null;
>>
>> If you're not adding '-z' here then you don't need this or the additio=
n below.
>>
>>>   };
>>> +static char line_termination =3D '\n';
>>>    static const char *force_path;
>>>  @@ -508,6 +512,102 @@ static int batch_unordered_packed(const struct=
 object_id *oid,
>>>   				      data);
>>>   }
>>>  +enum batch_state {
>>> +	/* Non-transactional state open for commands. */
>>> +	BATCH_STATE_OPEN,
>>> +};
>>
>> I forgot to ask what the idea behind the batch state is last time - wh=
at's it for?
>
> This is to support transactional semantics for commands we want to supp=
ort in the future, but
> since this is already a biggish change, we can leave this out of this s=
eries.
>
>>
>>> +static void parse_cmd_object(struct batch_options *opt,
>>> +			     const char *line,
>>> +			     struct strbuf *output,
>>> +			     struct expand_data *data)
>>> +{
>>> +	opt->print_contents =3D 1;
>>> +	batch_one_object(line, output, opt, data);
>>> +}
>>> +
>>> +static void parse_cmd_info(struct batch_options *opt,
>>> +			   const char *line,
>>> +			   struct strbuf *output,
>>> +			   struct expand_data *data)
>>> +{
>>> +	opt->print_contents =3D 0;
>>> +	batch_one_object(line, output, opt, data);
>>> +}
>>> +
>>> +static void parse_cmd_fflush(struct batch_options *opt,
>>> +			     const char *line,
>>> +			     struct strbuf *output,
>>> +			     struct expand_data *data)
>>> +{
>>> +	fflush(stdout);
>>> +}
>>> +
>>> +typedef void (*parse_cmd_fn_t)(struct batch_options *, const char *,=

>>> +			       struct strbuf *, struct expand_data *);
>>> +
>>> +static const struct parse_cmd {
>>> +	const char *prefix;
>>> +	parse_cmd_fn_t fn;
>>> +	unsigned args;
>>
>> This is now a flag so maybe 'takes_args' would better describe its pur=
pose.
>>
>>> +	enum batch_state state;
>>> +} commands[] =3D {
>>> +	{ "object", parse_cmd_object, 1, BATCH_STATE_OPEN },
>>> +	{ "info", parse_cmd_info, 1, BATCH_STATE_OPEN },
>>> +	{ "fflush", parse_cmd_fflush, 0, BATCH_STATE_OPEN },
>>> +};
>>> +
>>> +static void batch_objects_stdin_cmd(struct batch_options *opt,
>>> +				    struct strbuf *output,
>>> +				    struct expand_data *data)
>>> +{
>>> +	struct strbuf input =3D STRBUF_INIT;
>>> +	enum batch_state state =3D BATCH_STATE_OPEN;
>>> +
>>> +	/* Read each line dispatch its command */
>>> +	while (!strbuf_getwholeline(&input, stdin, line_termination)) {
>>> +		int i;
>>> +		const struct parse_cmd *cmd =3D NULL;
>>> +		const char *p;
>>> +
>>> +		if (*input.buf =3D=3D line_termination)
>>> +			die("empty command in input");
>>> +		else if (isspace(*input.buf))
>>> +			die("whitespace before command: %s", input.buf);
>>> +
>>> +		for (i =3D 0; i < ARRAY_SIZE(commands); i++) {
>>> +			const char *prefix =3D commands[i].prefix;
>>> +			char c;
>>> +			const char *cmd_name;
>>
>> skip_prefix() sets this to the end of the name so maybe 'cmd_end' woul=
d be clearer?
>>
>>> +			if (!skip_prefix(input.buf, prefix, &cmd_name))
>>> +				continue;
>>> +			/*
>>> +			 * If the command has arguments, verify that it's
>>> +			 * followed by a space. Otherwise, it shall be followed
>>> +			 * by a line terminator.
>>> +			 */
>>> +			c =3D commands[i].args ? ' ' : line_termination;
>>> +			if (input.buf[strlen(prefix)] !=3D c)
>>
>> Now that you're using skip_prefix() you can write this as
>>     		if (*cmd_end !=3D c)
>>
>>> +				continue;
>>> +
>>> +			cmd =3D &commands[i];
>>> +			break;
>>> +		}
>>> +		if (!cmd)
>>> +			die("unknown command: %s", input.buf);
>>> +
>>> +		p =3D input.buf + strlen(cmd->prefix) + 1;
>>
>> This can be simplified to
>>     	p =3D cmd_end + 1;
>>
>>> +		const char *pos =3D strstr(p, &line_termination);
>>
>> This isn't needed without '-z'. If it were required then using strchrn=
ul() would prevent a NULL pointer dereference when the last input line do=
es not end with a terminator. I think we typically call a pointer to the =
end of the line 'eol' or 'end'. Also variables should be declared at the =
top of the function.
>>
>>> +		switch (state) {
>>> +		case BATCH_STATE_OPEN:
>>> +			break;
>>> +		}
>>> +		cmd->fn(opt, xstrndup(p, pos-p), output, data);
>>
>> Is there a reason this is passing a copy of the string?
>>
>>> +	}
>>> +	strbuf_release(&input);
>>> +}
>>> +
>>>   static int batch_objects(struct batch_options *opt)
>>>   {
>>>   	struct strbuf input =3D STRBUF_INIT;
>>> @@ -515,6 +615,7 @@ static int batch_objects(struct batch_options *op=
t)
>>>   	struct expand_data data;
>>>   	int save_warning;
>>>   	int retval =3D 0;
>>> +	const int stdin_cmd =3D opt->stdin_cmd;
>>>    	if (!opt->format)
>>>   		opt->format =3D "%(objectname) %(objecttype) %(objectsize)";
>>> @@ -590,7 +691,8 @@ static int batch_objects(struct batch_options *op=
t)
>>>   	save_warning =3D warn_on_object_refname_ambiguity;
>>>   	warn_on_object_refname_ambiguity =3D 0;
>>>  -	while (strbuf_getline(&input, stdin) !=3D EOF) {
>>> +	while (!stdin_cmd &&
>>
>> If you moved the 'if (stdin_cmd)' block above this block we could loos=
e this change. I'm not sure if that is possible without looking at the wh=
ole function though.
>>
>>> +	       strbuf_getline(&input, stdin) !=3D EOF) {
>>>   		if (data.split_on_whitespace) {
>>>   			/*
>>>   			 * Split at first whitespace, tying off the beginning
>>> @@ -608,6 +710,9 @@ static int batch_objects(struct batch_options *op=
t)
>>>   		batch_one_object(input.buf, &output, opt, &data);
>>>   	}
>>>  +	if (stdin_cmd)
>>> +		batch_objects_stdin_cmd(opt, &output, &data);
>>> +
>>>   	strbuf_release(&input);
>>>   	strbuf_release(&output);
>>>   	warn_on_object_refname_ambiguity =3D save_warning;
>>> @@ -636,6 +741,7 @@ static int batch_option_callback(const struct opt=
ion *opt,
>>>    	bo->enabled =3D 1;
>>>   	bo->print_contents =3D !strcmp(opt->long_name, "batch");
>>> +	bo->stdin_cmd =3D !strcmp(opt->long_name, "batch-command");
>>>   	bo->format =3D arg;
>>>    	return 0;
>>> @@ -683,6 +789,10 @@ int cmd_cat_file(int argc, const char **argv, co=
nst char *prefix)
>>>   			N_("like --batch, but don't emit <contents>"),
>>>   			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
>>>   			batch_option_callback),
>>> +		OPT_CALLBACK_F(0, "batch-command", &batch, N_(""),
>>> +			 N_("enters batch mode that accepts commands"),
>>> +			 PARSE_OPT_NOARG | PARSE_OPT_NONEG,
>>> +			 batch_option_callback),
>>>   		OPT_CMDMODE(0, "batch-all-objects", &opt,
>>>   			    N_("with --batch[-check]: ignores stdin, batches all known o=
bjects"), 'b'),
>>>   		/* Batch-specific options */
>>> @@ -738,6 +848,8 @@ int cmd_cat_file(int argc, const char **argv, con=
st char *prefix)
>>>   	/* Batch defaults */
>>>   	if (batch.buffer_output < 0)
>>>   		batch.buffer_output =3D batch.all_objects;
>>> +	if (batch.end_null)
>>> +		line_termination =3D '\0';
>>>    	/* Return early if we're in batch mode? */
>>>   	if (batch.enabled) {
>>> diff --git a/strvec.c b/strvec.c
>>> index 61a76ce6cb..7dca04bf7a 100644
>>> --- a/strvec.c
>>> +++ b/strvec.c
>>> [...]
>>
>> We don't need any strvec changes now that we don't split the input lin=
es to --bactch-command
>>
>>> +F=3D'%s\0'
>>
>> This isn't used now
>>
>>> +test_expect_success 'batch-command unknown command' '
>>> +	echo unknown_command >cmd &&
>>> +	test_expect_code 128 git cat-file --batch-command < cmd 2>err &&
>>> +	grep -E "^fatal:.*unknown command.*" err
>>> +'
>>> +
>>> +test_expect_success 'setup object data' '
>>> +	content=3D"Object Data" &&
>>> +	size=3D$(strlen "$content") &&
>>> +	sha1=3D$(echo_without_newline "$content" | git hash-object -w --std=
in)
>>> +'
>>> +
>>> +test_expect_success 'batch-command calling object works' '
>>> +	echo "object $sha1" | git cat-file --batch-command >actual &&
>>> +	echo "$sha1 blob $size" >expect &&
>>> +	echo `git cat-file -p "$sha1"` >>expect &&
>>> +	test_cmp expect actual
>>> +'
>>> +
>>> +test_expect_success 'batch-command calling info works' '
>>> +	echo "info $sha1" | git cat-file --batch-command >actual &&
>>> +	echo "$sha1 blob $size" >expect &&
>>> +	test_cmp expect actual
>>> +'
>>
>> I had a quick look at this test file and there is a loop at the top th=
at runs some --batch tests on various inputs, I wonder if these two tests=
 could go in there.
>>
>>> +test_expect_success 'batch-command fflush works' '
>>> +	printf "fflush\n" > cmd &&
>>> +	test_expect_code 0 git cat-file --batch-command < cmd 2>err
>>> +'
>>
>> It'd be nice to check this actually flushes the output.
>
> could you give me some ideas on how to do this?

Ok, after filling around I think it can be something like this (copied ov=
er from an example in t9300-fast-import.sh

run_buffer_test () {
	type=3D$1
	sha1=3D$2
	size=3D$3

	mkfifo V.input
	exec 8<>V.input
	rm V.input

	mkfifo V.output
	exec 9<>V.output
	rm V.output
	=

	(
		git cat-file --buffer --batch-command <&8 >&9 &
		echo $! >&9 &&
		wait $!
	) &
	sh_pid=3D$!
	read fi_pid <&9
	test_when_finished "
		exec 8>&-; exec 9>&-;
		kill $sh_pid && wait $sh_pid
		kill $fi_pid && wait $fi_pid
		true"
	expect=3D$(echo "$sha1 $type $size")
	echo "info $sha1" >&8
	echo "fflush" >&8
	read actual <&9
	test "$actual" =3D "$expect"
}

Not sure if there's a simpler way since we need to simulate writing to an=
d reading from the process.

Thanks

>
>>
>> Best Wishes
>>
>> Phillip
>>
>>>   test_done
