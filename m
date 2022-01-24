Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831ECC433EF
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 14:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240042AbiAXOaH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 09:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235136AbiAXO3v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 09:29:51 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C333C06173B
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 06:29:50 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id g13so18337648qvw.4
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 06:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+1tRP7It8P98fQNT4uDidJJOjTGr/KzQ8WCMWkJPuN4=;
        b=e57AKyI1DNsHMuko9LU0rmx0R67SL19VOebgTUoQ4iXkRwbfJVMuU4eNH0P01TfzgT
         iKCTQ/iXpTZhrda9yX+VEJK/ueYKnjmBickU2M9yWW2cg4RZIjTJO43mU2vUMBEUMd/i
         yYUTpIJkde03YC7Lp5g5gPvcYG2VCkRo+89qBF3mYvKFdy0D0wPjTYWNpD51n4HdI/tZ
         WOTzwp8UQzXQgTA+jY+A0D8D9KHBVX760oMc9SMRx+LurOq2zAvQS/ca6XGUch404jG6
         6fXS/9mTJbBv5xqkpUDJxXVfm+It7c1MvJTB4+JwjndYvwjLzubbVc39mBBWBSy+C75o
         Eu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+1tRP7It8P98fQNT4uDidJJOjTGr/KzQ8WCMWkJPuN4=;
        b=Lj9t0AgUKicquEy05lbVfnhlazNOU2GQxrPiyef9c3B5VMvpYMgA8wFQxckCp3yaWO
         r7q5Qudeujnr7w9mkhKiAmJtMHn+MyYpkkm07/maZlFLB4XRwh1o/9kTOTxoFbuyPw6S
         3Q8T+EHvP+yEOSIveVucPpL+b1Avelvl8XxKP/3oIFZmbmOJLV+wCtg8OMLCj+taQXGV
         zfEiVmbIAPEA0dlxuyaGHadpZ8pJPmKeI3SaPRbBtLFMEA9YiT5+W5iEV/bh4icFuWu0
         NnhemxbPCNADkT0lAktm8rZaAhd07e8SWNuNNiKgX33GKzzqRiAgqD5OnSTjuQJjT41T
         SisQ==
X-Gm-Message-State: AOAM532ww5GlgBlXd9ypVkTifyJ88yQv+J2vKfrXEDHGpYSfETd/H224
        xFr3UVmNJXZ8qGhB2whZL2wYRFZeamdjiw==
X-Google-Smtp-Source: ABdhPJwBkCE+DbxqxSmMwSRE52dSpCbixoGdgBbCIlFJ5vKZE8sA6an1sOdqlevh3Cy6Cvr3jU4D1w==
X-Received: by 2002:a05:6214:21ac:: with SMTP id t12mr6579961qvc.111.1643034589476;
        Mon, 24 Jan 2022 06:29:49 -0800 (PST)
Received: from [192.168.1.211] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id o4sm6003915qtw.53.2022.01.24.06.29.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jan 2022 06:29:48 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, avarab@gmail.com, me@ttaylorr.com
Subject: Re: [RFC] cat-file: add a --stdin-cmd mode
Date:   Mon, 24 Jan 2022 09:29:47 -0500
X-Mailer: MailMate Trial (1.14r5852)
Message-ID: <55726CC9-7734-40A0-88B4-9D24F41C01B6@gmail.com>
In-Reply-To: <289ffedd-3cf1-408a-88f5-8461842cb6be@gmail.com>
References: <20220121175405.45753-1-johncai86@gmail.com>
 <289ffedd-3cf1-408a-88f5-8461842cb6be@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 23 Jan 2022, at 10:11, Phillip Wood wrote:

> Hi John
>
> On 21/01/2022 17:54, John Cai wrote:
>> This RFC patch proposes a new flag --stdin-cmd that works with
>> git-cat-file --batch. Similar to git-update-ref --stdin, it will accep=
t
>> commands and arguments from stdin.
>
> Lets start by bike shedding about the name! I think all the other cat-f=
ile options that read from stdin are called --batch[-something] so perhap=
s this could follow the existing pattern.

Yeah perhaps it would be more clear for this to have its own name. Maybe =
--batch-cmd? --batch-stdin-cmd seems too long and clunky.
>
>> The start of this idea was discussed in [1], where the original
>> motivation was to be able to control when the buffer was flushed to
>> stdout in --buffer mode.
>
> That's useful background, thanks
>
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
>
> It is just getting rid of a single extra process so are the huge saving=
s coming because there are lots of these pairs of cat-file processes?

Right, I left out that detail. So we have many such processes at any give=
n time that grab all sorts of objects from the odb. So this would allow u=
s to cut our number of git processes by about half.
>
>> git cat-file --batch --stdin-cmd
>>
>> $ <command> [arg1] [arg2] NL
>>
>> We can also add a -z mode to allow for NUL-terminated lines
>
> The -z flag is a very welcome addition and will help address some exist=
ing problems with cat-file --batch[1]. This should be an uncontroversial =
change and could be submitted separately from the rest of the changes in =
this patch.

Sounds good to me. That can be a later iteration.
>
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
>
> I think it would be good to define what input format we want to support=
=2E The code in this patch does not handle input like "object HEAD:name w=
ith spaces" which is a shame. It would be good to retain the ability to a=
dd commands that take arguments with spaces in them in the future, for ex=
ample one might want to pass a format string as an argument to some futur=
e command. Making each command responsible for parsing its own arguments =
would help fix this rather than just splitting on input on each space and=
 passing that list to the commands.

This is good feedback. I can see the value of a more flexible interface f=
or the handler functions.

>
> The basic premise of adding a new command line option that reads a comm=
and and arguments seems like a sensible way to extend the functionality o=
f cat-file.
>
> [For future reference I think the command name parsing could be cleaner=
 if it used skip_prefix() rather than starts_with()]
>
>> For instance, a non-trivial part of "cat-file --batch" time is spent
>> on parsing its argument and seeing if it's a revision, ref etc. So we
>> could add a command that only accepts a full-length 40
>> character SHA-1.
>
> It would be good to get a better understanding of what fraction of the =
time git spends parsing the argument and what it is doing in that time. I=
f we can speed up the existing code then everyone will benefit from the c=
hange, not just those who switch to the new command.

Good question. I would need to do some investigation. This is still only =
a possible future enhancement so it wouldn=E2=80=99t be included in the f=
irst iteration.

Thanks for the thoughtful review!

>
>
> Best Wishes
>
> Phillip
>
> [1] https://lore.kernel.org/git/20191008200050.GA26453@sigill.intra.pef=
f.net/
>
>> This would be the first step in adding such an interface to
>> git-cat-file.
>>
>> [1] https://lore.kernel.org/git/pull.1124.git.git.1636149400.gitgitgad=
get@gmail.com/
>>
>> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> Signed-off-by: John Cai <johncai86@gmail.com>
>> ---
>>   builtin/cat-file.c  | 137 ++++++++++++++++++++++++++++++++++++++++++=
+-
>>   strvec.c            |  23 ++++++++
>>   strvec.h            |   8 +++
>>   t/t1006-cat-file.sh |  72 +++++++++++++++++++++++
>>   4 files changed, 239 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
>> index 7b3f42950e..2679b34b43 100644
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
>> +	int end_null;
>>   };
>> +static char line_termination =3D '\n';
>>    static const char *force_path;
>>  @@ -508,6 +512,126 @@ static int batch_unordered_packed(const struct =
object_id *oid,
>>   				      data);
>>   }
>>  +enum batch_state {
>> +	/* Non-transactional state open for commands. */
>> +	BATCH_STATE_OPEN,
>> +};
>> +
>> +static void parse_cmd_object(struct batch_options *opt,
>> +			     const int argc, const char **argv,
>> +			     struct strbuf *output,
>> +			     struct expand_data *data)
>> +{
>> +	batch_one_object(argv[0], output, opt, data);
>> +}
>> +
>> +static void parse_cmd_info(struct batch_options *opt,
>> +			     const int argc, const char **argv,
>> +			     struct strbuf *output,
>> +			     struct expand_data *data)
>> +{
>> +	opt->print_contents =3D 0;
>> +	batch_one_object(argv[0], output, opt, data);
>> +}
>> +
>> +static void parse_cmd_fflush(struct batch_options *opt,
>> +			     const int argc, const char **argv,
>> +			     struct strbuf *output,
>> +			     struct expand_data *data)
>> +{
>> +	fflush(stdout);
>> +}
>> +
>> +typedef void (*parse_cmd_fn_t)(struct batch_options *, const int,
>> +			       const char **, struct strbuf *,
>> +			       struct expand_data *);
>> +
>> +static const struct parse_cmd {
>> +	const char *prefix;
>> +	parse_cmd_fn_t fn;
>> +	unsigned args;
>> +	enum batch_state state;
>> +} command[] =3D {
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
>> +		struct strvec args =3D STRVEC_INIT;
>> +		size_t n;
>> +		const char *p;
>> +
>> +		if (*input.buf =3D=3D line_termination)
>> +			die("empty command in input");
>> +		else if (isspace(*input.buf))
>> +			die("whitespace before command: %s", input.buf);
>> +
>> +		for (i =3D 0; i < ARRAY_SIZE(command); i++) {
>> +			const char *prefix =3D command[i].prefix;
>> +			char c;
>> +
>> +			if (!starts_with(input.buf, prefix))
>> +				continue;
>> +
>> +			/*
>> +			 * If the command has arguments, verify that it's
>> +			 * followed by a space. Otherwise, it shall be followed
>> +			 * by a line terminator.
>> +			 */
>> +			c =3D command[i].args ? ' ' : line_termination;
>> +			if (input.buf[strlen(prefix)] !=3D c)
>> +				continue;
>> +
>> +			cmd =3D &command[i];
>> +			break;
>> +		}
>> +		if (!cmd)
>> +			die("unknown command: %s", input.buf);
>> +
>> +		/*
>> +		 * Read additional arguments. Do not raise an error in
>> +		 * case there is an early EOF to let the command
>> +		 * handle missing arguments with a proper error message
>> +		 */
>> +		p =3D input.buf + strlen(cmd->prefix) + 1;
>> +		if (*p =3D=3D line_termination || !*p) {
>> +			n =3D 0;
>> +		} else {
>> +			const char *pos =3D strstr(p, "\n");
>> +			char *str =3D xstrndup(p, pos - p);
>> +
>> +			n =3D strvec_split_delim(&args, str, ' ', - 1);
>> +			free(str);
>> +		}
>> +
>> +		if (n < cmd->args)
>> +			die("%s: too few arguments", cmd->prefix);
>> +		if (n > cmd->args)
>> +			die("%s: too many arguments", cmd->prefix);
>> +
>> +		switch (state) {
>> +		case BATCH_STATE_OPEN:
>> +			/* TODO: command state management */
>> +			break;
>> +		}
>> +		cmd->fn(opt, args.nr, args.v, output, data);
>> +		strvec_clear(&args);
>> +	}
>> +
>> +	strbuf_release(&input);
>> +}
>> +
>>   static int batch_objects(struct batch_options *opt)
>>   {
>>   	struct strbuf input =3D STRBUF_INIT;
>> @@ -515,6 +639,7 @@ static int batch_objects(struct batch_options *opt=
)
>>   	struct expand_data data;
>>   	int save_warning;
>>   	int retval =3D 0;
>> +	const int stdin_cmd =3D opt->stdin_cmd;
>>    	if (!opt->format)
>>   		opt->format =3D "%(objectname) %(objecttype) %(objectsize)";
>> @@ -590,7 +715,8 @@ static int batch_objects(struct batch_options *opt=
)
>>   	save_warning =3D warn_on_object_refname_ambiguity;
>>   	warn_on_object_refname_ambiguity =3D 0;
>>  -	while (strbuf_getline(&input, stdin) !=3D EOF) {
>> +	while (!stdin_cmd &&
>> +	       strbuf_getline(&input, stdin) !=3D EOF) {
>>   		if (data.split_on_whitespace) {
>>   			/*
>>   			 * Split at first whitespace, tying off the beginning
>> @@ -608,6 +734,9 @@ static int batch_objects(struct batch_options *opt=
)
>>   		batch_one_object(input.buf, &output, opt, &data);
>>   	}
>>  +	if (stdin_cmd)
>> +		batch_objects_stdin_cmd(opt, &output, &data);
>> +
>>   	strbuf_release(&input);
>>   	strbuf_release(&output);
>>   	warn_on_object_refname_ambiguity =3D save_warning;
>> @@ -685,6 +814,10 @@ int cmd_cat_file(int argc, const char **argv, con=
st char *prefix)
>>   			batch_option_callback),
>>   		OPT_CMDMODE(0, "batch-all-objects", &opt,
>>   			    N_("with --batch[-check]: ignores stdin, batches all known ob=
jects"), 'b'),
>> +		OPT_BOOL(0, "stdin-cmd", &batch.stdin_cmd,
>> +			 N_("with --batch[-check]: enters stdin 'command mode")),
>> +		OPT_BOOL('z', NULL, &batch.end_null, N_("with --stdin-cmd, use NUL =
termination")),
>> +
>>   		/* Batch-specific options */
>>   		OPT_GROUP(N_("Change or optimize batch output")),
>>   		OPT_BOOL(0, "buffer", &batch.buffer_output, N_("buffer --batch out=
put")),
>> @@ -738,6 +871,8 @@ int cmd_cat_file(int argc, const char **argv, cons=
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
>> @@ -85,6 +85,29 @@ void strvec_split(struct strvec *array, const char =
*to_split)
>>   	}
>>   }
>>  +size_t strvec_split_delim(struct strvec *array, const char *string,
>> +			  int delim, int maxsplit)
>> +{
>> +	size_t count =3D 0;
>> +	const char *p =3D string, *end;
>> +
>> +	for (;;) {
>> +		count++;
>> +		if (maxsplit >=3D 0 && count > maxsplit) {
>> +			strvec_push(array, p);
>> +			return count;
>> +		}
>> +		end =3D strchr(p, delim);
>> +		if (end) {
>> +			strvec_push_nodup(array, xmemdupz(p, end - p));
>> +			p =3D end + 1;
>> +		} else {
>> +			strvec_push(array, p);
>> +			return count;
>> +		}
>> +	}
>> +}
>> +
>>   void strvec_clear(struct strvec *array)
>>   {
>>   	if (array->v !=3D empty_strvec) {
>> diff --git a/strvec.h b/strvec.h
>> index 9f55c8766b..c474918b91 100644
>> --- a/strvec.h
>> +++ b/strvec.h
>> @@ -73,6 +73,14 @@ void strvec_pop(struct strvec *);
>>   /* Splits by whitespace; does not handle quoted arguments! */
>>   void strvec_split(struct strvec *, const char *);
>>  +/**
>> + * strvec_split_delim() is a split function that behaves more like it=
s
>> + * string_list_split() cousin than the whitespace-splitting
>> + * strvec_split().
>> + */
>> +size_t strvec_split_delim(struct strvec *array, const char *string,
>> +			  int delim, int maxsplit);
>> +
>>   /**
>>    * Free all memory associated with the array and return it to the
>>    * initial, empty state.
>> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
>> index 145eee11df..8f339746ec 100755
>> --- a/t/t1006-cat-file.sh
>> +++ b/t/t1006-cat-file.sh
>> @@ -964,4 +964,76 @@ test_expect_success 'cat-file --batch-all-objects=
 --batch-check ignores replace'
>>   	test_cmp expect actual
>>   '
>>  +F=3D'%s\0'
>> +
>> +test_expect_success 'stdin-cmd not enough arguments' '
>> +	echo "object " >cmd &&
>> +	test_expect_code 128 git cat-file --batch --stdin-cmd < cmd 2>err &&=

>> +	grep -E "^fatal:.*too few arguments" err
>> +'
>> +
>> +test_expect_success 'stdin-cmd too many arguments' '
>> +	echo "object foo bar" >cmd &&
>> +	test_expect_code 128 git cat-file --batch --stdin-cmd < cmd 2>err &&=

>> +	grep -E "^fatal:.*too many arguments" err
>> +'
>> +
>> +test_expect_success 'stdin-cmd unknown command' '
>> +	echo unknown_command >cmd &&
>> +	test_expect_code 128 git cat-file --batch --stdin-cmd < cmd 2>err &&=

>> +	grep -E "^fatal:.*unknown command.*" err &&
>> +	test_expect_code 128 git cat-file --batch --stdin-cmd -z < cmd 2>err=
 &&
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
>> +test_expect_success 'stdin-cmd calling object works' '
>> +	echo "object $sha1" | git cat-file --batch --stdin-cmd >actual &&
>> +	echo "$sha1 blob $size" >expect &&
>> +	echo `git cat-file -p "$sha1"` >>expect &&
>> +	test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'stdin-cmd -z calling object works' '
>> +	printf $F "object $sha1" | git cat-file --batch --stdin-cmd -z >actu=
al &&
>> +	echo "$sha1 blob $size" >expect &&
>> +	echo `git cat-file -p "$sha1"` >>expect &&
>> +	test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'setup object data' '
>> +	content=3D"Object Data" &&
>> +	size=3D$(strlen "$content") &&
>> +	sha1=3D$(echo_without_newline "$content" | git hash-object -w --stdi=
n)
>> +'
>> +
>> +test_expect_success 'stdin-cmd calling object works' '
>> +	echo "object $sha1" | git cat-file --batch --stdin-cmd >actual &&
>> +	echo "$sha1 blob $size" >expect &&
>> +	echo `git cat-file -p "$sha1"` >>expect &&
>> +	test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'stdin-cmd -z calling object works' '
>> +	printf $F "object $sha1" | git cat-file --batch --stdin-cmd -z >actu=
al &&
>> +	echo "$sha1 blob $size" >expect &&
>> +	echo `git cat-file -p "$sha1"` >>expect &&
>> +	test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'stdin-cmd fflush works' '
>> +	printf "fflush\n" > cmd &&
>> +	test_expect_code 0 git cat-file --batch --stdin-cmd < cmd 2>err
>> +'
>> +
>> +test_expect_success 'stdin-cmd -z fflush works' '
>> +	printf $F 'fflush' > cmd &&
>> +	test_expect_code 0 git cat-file --batch --stdin-cmd -z < cmd 2>err
>> +'
>> +
>>   test_done
