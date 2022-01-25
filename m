Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60030C433EF
	for <git@archiver.kernel.org>; Tue, 25 Jan 2022 14:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385583AbiAYN7p (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 08:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386617AbiAYN5X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 08:57:23 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E933C06173E
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 05:57:23 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id r7so336343wmq.5
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 05:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2nQeyVMGSlfygJawd3i2xjpKZBrkGB26phpEO5zhwyQ=;
        b=EBelUvSoC0RSOCeig2S2J31YF55PVvRJ6mte5I+FhIYXZINpHj2D8lEsGZ2lYlRCLj
         HNGJ37c0/feg01gPnn9LrahsnPy61bX7pZAIvBzv83O7ygyG1ItXGwewXMxhJJ+GNpAz
         3OMWq+7Ni3ANLUlRgNpcrSS296bsljwl5G6Ip5a5QplpGvnyku4LciXdunwfEqV+cWAQ
         Kvf3Wx8O1uoKFlSqOwFbvCPYnC/ZrLCVBMpC4Dn9+Nshy+Ud5gxnokRxY9mKgsKd05Ht
         83QLqt8T+1V4RDYvEt86X7sX8BQlYKKg1S/drhArUiRV0+kg0jUymCipNVaZumQoDRxj
         vdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2nQeyVMGSlfygJawd3i2xjpKZBrkGB26phpEO5zhwyQ=;
        b=lt2eS5TyA0pQ0z+0Vqt2bEntxAt4wkW9u8ReeFY+xEgkO4g7swZsNDH4whGyiYgYsL
         hxuyEo1Hd/VKUxgQ/VdhDfxDQyaHcVwJ6t3IgVV0nBF9M5AOdpUMtUNDVX3tgyay0hWw
         no4DNEJrf26DgHKqIEza6lYk5tjEAsF9ww+eDD3zBDpvHN/nNLvfjbK77Hx1p+ASVgGj
         3Msm3DxjccZ6wj5LY9Lhkx46UNryocV3RH4xWz/h7WShbp6+zuMBgY8fTeyTROQoTC8/
         26lJWsX2NGPdgEfhTXeUQG3HXwbwCIzh/uhZuTn1gFVSgNY4zlyulAZGtXC5diJswTs9
         +3jg==
X-Gm-Message-State: AOAM533qtFJDUNvaor86yqrY7endPHkkg+Sm+mDVJUdtpjfO3fhtu6UH
        S83vt9JVN8NY7MhzZ7d1eOtGDS2fjmc=
X-Google-Smtp-Source: ABdhPJw8gY7pi3vqbvFcKYqocq5LGuRZp7LA3ytBjE3QUMehY4nzSajqbJ+Mzq5aBPiCYf4qWAW+DA==
X-Received: by 2002:a7b:cb58:: with SMTP id v24mr3136754wmj.135.1643119041470;
        Tue, 25 Jan 2022 05:57:21 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id i94sm17032251wri.21.2022.01.25.05.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 05:57:21 -0800 (PST)
Message-ID: <7bb67a30-3f51-bf40-604b-12d96ad65737@gmail.com>
Date:   Tue, 25 Jan 2022 13:57:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC] cat-file: add a --stdin-cmd mode
Content-Language: en-US
To:     John Cai <johncai86@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, avarab@gmail.com, me@ttaylorr.com
References: <20220121175405.45753-1-johncai86@gmail.com>
 <289ffedd-3cf1-408a-88f5-8461842cb6be@gmail.com>
 <55726CC9-7734-40A0-88B4-9D24F41C01B6@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <55726CC9-7734-40A0-88B4-9D24F41C01B6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John

On 24/01/2022 14:29, John Cai wrote:
> On 23 Jan 2022, at 10:11, Phillip Wood wrote:
> 
>> Hi John
>>
>> On 21/01/2022 17:54, John Cai wrote:
>>> This RFC patch proposes a new flag --stdin-cmd that works with
>>> git-cat-file --batch. Similar to git-update-ref --stdin, it will accept
>>> commands and arguments from stdin.
>>
>> Lets start by bike shedding about the name! I think all the other cat-file options that read from stdin are called --batch[-something] so perhaps this could follow the existing pattern.
> 
> Yeah perhaps it would be more clear for this to have its own name. Maybe --batch-cmd? --batch-stdin-cmd seems too long and clunky.

I agree --batch-stdin-cmd is a bit clunky, --batch-command might work

>>> The start of this idea was discussed in [1], where the original
>>> motivation was to be able to control when the buffer was flushed to
>>> stdout in --buffer mode.
>>
>> That's useful background, thanks
>>
>>> However, this can actually be much more useful in situations when
>>> git-cat-file --batch is being used as a long lived backend query
>>> process. At GitLab, we use a pair of cat-file processes. One for
>>> iterating over object metadata with --batch-check, and the other to grab
>>> object contents with --batch. However, if we had --stdin-cmd, we could
>>> get rid of the second --batch-check process, and just have one progress
>>> where we can flip between getting object info, and getting object contents.
>>> This can lead to huge savings.
>>
>> It is just getting rid of a single extra process so are the huge savings coming because there are lots of these pairs of cat-file processes?
> 
> Right, I left out that detail. So we have many such processes at any given time that grab all sorts of objects from the odb. So this would allow us to cut our number of git processes by about half.

Thanks for explaining, that make sense

>>> git cat-file --batch --stdin-cmd
>>>
>>> $ <command> [arg1] [arg2] NL
>>>
>>> We can also add a -z mode to allow for NUL-terminated lines
>>
>> The -z flag is a very welcome addition and will help address some existing problems with cat-file --batch[1]. This should be an uncontroversial change and could be submitted separately from the rest of the changes in this patch.
> 
> Sounds good to me. That can be a later iteration.

Or an earlier separate series if you want

Best Wishes

Phillip

>>> $ <command> [arg1] [arg2] NUL
>>>
>>> This patch adds three commands: object, info, fflush
>>>
>>> $ object <sha1> NL
>>> $ info <sha1> NL
>>> $ fflush NL
>>>
>>> These three would be immediately useful in GitLab's context, but one can
>>> imagine this mode to be further extended for other things.
>>
>> I think it would be good to define what input format we want to support. The code in this patch does not handle input like "object HEAD:name with spaces" which is a shame. It would be good to retain the ability to add commands that take arguments with spaces in them in the future, for example one might want to pass a format string as an argument to some future command. Making each command responsible for parsing its own arguments would help fix this rather than just splitting on input on each space and passing that list to the commands.
> 
> This is good feedback. I can see the value of a more flexible interface for the handler functions.
> 
>>
>> The basic premise of adding a new command line option that reads a command and arguments seems like a sensible way to extend the functionality of cat-file.
>>
>> [For future reference I think the command name parsing could be cleaner if it used skip_prefix() rather than starts_with()]
>>
>>> For instance, a non-trivial part of "cat-file --batch" time is spent
>>> on parsing its argument and seeing if it's a revision, ref etc. So we
>>> could add a command that only accepts a full-length 40
>>> character SHA-1.
>>
>> It would be good to get a better understanding of what fraction of the time git spends parsing the argument and what it is doing in that time. If we can speed up the existing code then everyone will benefit from the change, not just those who switch to the new command.
> 
> Good question. I would need to do some investigation. This is still only a possible future enhancement so it wouldn’t be included in the first iteration.
> 
> Thanks for the thoughtful review!
> 
>>
>>
>> Best Wishes
>>
>> Phillip
>>
>> [1] https://lore.kernel.org/git/20191008200050.GA26453@sigill.intra.peff.net/
>>
>>> This would be the first step in adding such an interface to
>>> git-cat-file.
>>>
>>> [1] https://lore.kernel.org/git/pull.1124.git.git.1636149400.gitgitgadget@gmail.com/
>>>
>>> Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>>> Signed-off-by: John Cai <johncai86@gmail.com>
>>> ---
>>>    builtin/cat-file.c  | 137 +++++++++++++++++++++++++++++++++++++++++++-
>>>    strvec.c            |  23 ++++++++
>>>    strvec.h            |   8 +++
>>>    t/t1006-cat-file.sh |  72 +++++++++++++++++++++++
>>>    4 files changed, 239 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
>>> index 7b3f42950e..2679b34b43 100644
>>> --- a/builtin/cat-file.c
>>> +++ b/builtin/cat-file.c
>>> @@ -16,6 +16,7 @@
>>>    #include "packfile.h"
>>>    #include "object-store.h"
>>>    #include "promisor-remote.h"
>>> +#include "strvec.h"
>>>     struct batch_options {
>>>    	int enabled;
>>> @@ -26,7 +27,10 @@ struct batch_options {
>>>    	int unordered;
>>>    	int cmdmode; /* may be 'w' or 'c' for --filters or --textconv */
>>>    	const char *format;
>>> +	int stdin_cmd;
>>> +	int end_null;
>>>    };
>>> +static char line_termination = '\n';
>>>     static const char *force_path;
>>>   @@ -508,6 +512,126 @@ static int batch_unordered_packed(const struct object_id *oid,
>>>    				      data);
>>>    }
>>>   +enum batch_state {
>>> +	/* Non-transactional state open for commands. */
>>> +	BATCH_STATE_OPEN,
>>> +};
>>> +
>>> +static void parse_cmd_object(struct batch_options *opt,
>>> +			     const int argc, const char **argv,
>>> +			     struct strbuf *output,
>>> +			     struct expand_data *data)
>>> +{
>>> +	batch_one_object(argv[0], output, opt, data);
>>> +}
>>> +
>>> +static void parse_cmd_info(struct batch_options *opt,
>>> +			     const int argc, const char **argv,
>>> +			     struct strbuf *output,
>>> +			     struct expand_data *data)
>>> +{
>>> +	opt->print_contents = 0;
>>> +	batch_one_object(argv[0], output, opt, data);
>>> +}
>>> +
>>> +static void parse_cmd_fflush(struct batch_options *opt,
>>> +			     const int argc, const char **argv,
>>> +			     struct strbuf *output,
>>> +			     struct expand_data *data)
>>> +{
>>> +	fflush(stdout);
>>> +}
>>> +
>>> +typedef void (*parse_cmd_fn_t)(struct batch_options *, const int,
>>> +			       const char **, struct strbuf *,
>>> +			       struct expand_data *);
>>> +
>>> +static const struct parse_cmd {
>>> +	const char *prefix;
>>> +	parse_cmd_fn_t fn;
>>> +	unsigned args;
>>> +	enum batch_state state;
>>> +} command[] = {
>>> +	{ "object", parse_cmd_object, 1, BATCH_STATE_OPEN },
>>> +	{ "info", parse_cmd_info, 1, BATCH_STATE_OPEN },
>>> +	{ "fflush", parse_cmd_fflush, 0, BATCH_STATE_OPEN },
>>> +};
>>> +
>>> +static void batch_objects_stdin_cmd(struct batch_options *opt,
>>> +				    struct strbuf *output,
>>> +				    struct expand_data *data)
>>> +{
>>> +	struct strbuf input = STRBUF_INIT;
>>> +	enum batch_state state = BATCH_STATE_OPEN;
>>> +
>>> +	/* Read each line dispatch its command */
>>> +	while (!strbuf_getwholeline(&input, stdin, line_termination)) {
>>> +		int i;
>>> +		const struct parse_cmd *cmd = NULL;
>>> +		struct strvec args = STRVEC_INIT;
>>> +		size_t n;
>>> +		const char *p;
>>> +
>>> +		if (*input.buf == line_termination)
>>> +			die("empty command in input");
>>> +		else if (isspace(*input.buf))
>>> +			die("whitespace before command: %s", input.buf);
>>> +
>>> +		for (i = 0; i < ARRAY_SIZE(command); i++) {
>>> +			const char *prefix = command[i].prefix;
>>> +			char c;
>>> +
>>> +			if (!starts_with(input.buf, prefix))
>>> +				continue;
>>> +
>>> +			/*
>>> +			 * If the command has arguments, verify that it's
>>> +			 * followed by a space. Otherwise, it shall be followed
>>> +			 * by a line terminator.
>>> +			 */
>>> +			c = command[i].args ? ' ' : line_termination;
>>> +			if (input.buf[strlen(prefix)] != c)
>>> +				continue;
>>> +
>>> +			cmd = &command[i];
>>> +			break;
>>> +		}
>>> +		if (!cmd)
>>> +			die("unknown command: %s", input.buf);
>>> +
>>> +		/*
>>> +		 * Read additional arguments. Do not raise an error in
>>> +		 * case there is an early EOF to let the command
>>> +		 * handle missing arguments with a proper error message
>>> +		 */
>>> +		p = input.buf + strlen(cmd->prefix) + 1;
>>> +		if (*p == line_termination || !*p) {
>>> +			n = 0;
>>> +		} else {
>>> +			const char *pos = strstr(p, "\n");
>>> +			char *str = xstrndup(p, pos - p);
>>> +
>>> +			n = strvec_split_delim(&args, str, ' ', - 1);
>>> +			free(str);
>>> +		}
>>> +
>>> +		if (n < cmd->args)
>>> +			die("%s: too few arguments", cmd->prefix);
>>> +		if (n > cmd->args)
>>> +			die("%s: too many arguments", cmd->prefix);
>>> +
>>> +		switch (state) {
>>> +		case BATCH_STATE_OPEN:
>>> +			/* TODO: command state management */
>>> +			break;
>>> +		}
>>> +		cmd->fn(opt, args.nr, args.v, output, data);
>>> +		strvec_clear(&args);
>>> +	}
>>> +
>>> +	strbuf_release(&input);
>>> +}
>>> +
>>>    static int batch_objects(struct batch_options *opt)
>>>    {
>>>    	struct strbuf input = STRBUF_INIT;
>>> @@ -515,6 +639,7 @@ static int batch_objects(struct batch_options *opt)
>>>    	struct expand_data data;
>>>    	int save_warning;
>>>    	int retval = 0;
>>> +	const int stdin_cmd = opt->stdin_cmd;
>>>     	if (!opt->format)
>>>    		opt->format = "%(objectname) %(objecttype) %(objectsize)";
>>> @@ -590,7 +715,8 @@ static int batch_objects(struct batch_options *opt)
>>>    	save_warning = warn_on_object_refname_ambiguity;
>>>    	warn_on_object_refname_ambiguity = 0;
>>>   -	while (strbuf_getline(&input, stdin) != EOF) {
>>> +	while (!stdin_cmd &&
>>> +	       strbuf_getline(&input, stdin) != EOF) {
>>>    		if (data.split_on_whitespace) {
>>>    			/*
>>>    			 * Split at first whitespace, tying off the beginning
>>> @@ -608,6 +734,9 @@ static int batch_objects(struct batch_options *opt)
>>>    		batch_one_object(input.buf, &output, opt, &data);
>>>    	}
>>>   +	if (stdin_cmd)
>>> +		batch_objects_stdin_cmd(opt, &output, &data);
>>> +
>>>    	strbuf_release(&input);
>>>    	strbuf_release(&output);
>>>    	warn_on_object_refname_ambiguity = save_warning;
>>> @@ -685,6 +814,10 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>>>    			batch_option_callback),
>>>    		OPT_CMDMODE(0, "batch-all-objects", &opt,
>>>    			    N_("with --batch[-check]: ignores stdin, batches all known objects"), 'b'),
>>> +		OPT_BOOL(0, "stdin-cmd", &batch.stdin_cmd,
>>> +			 N_("with --batch[-check]: enters stdin 'command mode")),
>>> +		OPT_BOOL('z', NULL, &batch.end_null, N_("with --stdin-cmd, use NUL termination")),
>>> +
>>>    		/* Batch-specific options */
>>>    		OPT_GROUP(N_("Change or optimize batch output")),
>>>    		OPT_BOOL(0, "buffer", &batch.buffer_output, N_("buffer --batch output")),
>>> @@ -738,6 +871,8 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>>>    	/* Batch defaults */
>>>    	if (batch.buffer_output < 0)
>>>    		batch.buffer_output = batch.all_objects;
>>> +	if (batch.end_null)
>>> +		line_termination = '\0';
>>>     	/* Return early if we're in batch mode? */
>>>    	if (batch.enabled) {
>>> diff --git a/strvec.c b/strvec.c
>>> index 61a76ce6cb..7dca04bf7a 100644
>>> --- a/strvec.c
>>> +++ b/strvec.c
>>> @@ -85,6 +85,29 @@ void strvec_split(struct strvec *array, const char *to_split)
>>>    	}
>>>    }
>>>   +size_t strvec_split_delim(struct strvec *array, const char *string,
>>> +			  int delim, int maxsplit)
>>> +{
>>> +	size_t count = 0;
>>> +	const char *p = string, *end;
>>> +
>>> +	for (;;) {
>>> +		count++;
>>> +		if (maxsplit >= 0 && count > maxsplit) {
>>> +			strvec_push(array, p);
>>> +			return count;
>>> +		}
>>> +		end = strchr(p, delim);
>>> +		if (end) {
>>> +			strvec_push_nodup(array, xmemdupz(p, end - p));
>>> +			p = end + 1;
>>> +		} else {
>>> +			strvec_push(array, p);
>>> +			return count;
>>> +		}
>>> +	}
>>> +}
>>> +
>>>    void strvec_clear(struct strvec *array)
>>>    {
>>>    	if (array->v != empty_strvec) {
>>> diff --git a/strvec.h b/strvec.h
>>> index 9f55c8766b..c474918b91 100644
>>> --- a/strvec.h
>>> +++ b/strvec.h
>>> @@ -73,6 +73,14 @@ void strvec_pop(struct strvec *);
>>>    /* Splits by whitespace; does not handle quoted arguments! */
>>>    void strvec_split(struct strvec *, const char *);
>>>   +/**
>>> + * strvec_split_delim() is a split function that behaves more like its
>>> + * string_list_split() cousin than the whitespace-splitting
>>> + * strvec_split().
>>> + */
>>> +size_t strvec_split_delim(struct strvec *array, const char *string,
>>> +			  int delim, int maxsplit);
>>> +
>>>    /**
>>>     * Free all memory associated with the array and return it to the
>>>     * initial, empty state.
>>> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
>>> index 145eee11df..8f339746ec 100755
>>> --- a/t/t1006-cat-file.sh
>>> +++ b/t/t1006-cat-file.sh
>>> @@ -964,4 +964,76 @@ test_expect_success 'cat-file --batch-all-objects --batch-check ignores replace'
>>>    	test_cmp expect actual
>>>    '
>>>   +F='%s\0'
>>> +
>>> +test_expect_success 'stdin-cmd not enough arguments' '
>>> +	echo "object " >cmd &&
>>> +	test_expect_code 128 git cat-file --batch --stdin-cmd < cmd 2>err &&
>>> +	grep -E "^fatal:.*too few arguments" err
>>> +'
>>> +
>>> +test_expect_success 'stdin-cmd too many arguments' '
>>> +	echo "object foo bar" >cmd &&
>>> +	test_expect_code 128 git cat-file --batch --stdin-cmd < cmd 2>err &&
>>> +	grep -E "^fatal:.*too many arguments" err
>>> +'
>>> +
>>> +test_expect_success 'stdin-cmd unknown command' '
>>> +	echo unknown_command >cmd &&
>>> +	test_expect_code 128 git cat-file --batch --stdin-cmd < cmd 2>err &&
>>> +	grep -E "^fatal:.*unknown command.*" err &&
>>> +	test_expect_code 128 git cat-file --batch --stdin-cmd -z < cmd 2>err &&
>>> +	grep -E "^fatal:.*unknown command.*" err
>>> +'
>>> +
>>> +test_expect_success 'setup object data' '
>>> +	content="Object Data" &&
>>> +	size=$(strlen "$content") &&
>>> +	sha1=$(echo_without_newline "$content" | git hash-object -w --stdin)
>>> +'
>>> +
>>> +test_expect_success 'stdin-cmd calling object works' '
>>> +	echo "object $sha1" | git cat-file --batch --stdin-cmd >actual &&
>>> +	echo "$sha1 blob $size" >expect &&
>>> +	echo `git cat-file -p "$sha1"` >>expect &&
>>> +	test_cmp expect actual
>>> +'
>>> +
>>> +test_expect_success 'stdin-cmd -z calling object works' '
>>> +	printf $F "object $sha1" | git cat-file --batch --stdin-cmd -z >actual &&
>>> +	echo "$sha1 blob $size" >expect &&
>>> +	echo `git cat-file -p "$sha1"` >>expect &&
>>> +	test_cmp expect actual
>>> +'
>>> +
>>> +test_expect_success 'setup object data' '
>>> +	content="Object Data" &&
>>> +	size=$(strlen "$content") &&
>>> +	sha1=$(echo_without_newline "$content" | git hash-object -w --stdin)
>>> +'
>>> +
>>> +test_expect_success 'stdin-cmd calling object works' '
>>> +	echo "object $sha1" | git cat-file --batch --stdin-cmd >actual &&
>>> +	echo "$sha1 blob $size" >expect &&
>>> +	echo `git cat-file -p "$sha1"` >>expect &&
>>> +	test_cmp expect actual
>>> +'
>>> +
>>> +test_expect_success 'stdin-cmd -z calling object works' '
>>> +	printf $F "object $sha1" | git cat-file --batch --stdin-cmd -z >actual &&
>>> +	echo "$sha1 blob $size" >expect &&
>>> +	echo `git cat-file -p "$sha1"` >>expect &&
>>> +	test_cmp expect actual
>>> +'
>>> +
>>> +test_expect_success 'stdin-cmd fflush works' '
>>> +	printf "fflush\n" > cmd &&
>>> +	test_expect_code 0 git cat-file --batch --stdin-cmd < cmd 2>err
>>> +'
>>> +
>>> +test_expect_success 'stdin-cmd -z fflush works' '
>>> +	printf $F 'fflush' > cmd &&
>>> +	test_expect_code 0 git cat-file --batch --stdin-cmd -z < cmd 2>err
>>> +'
>>> +
>>>    test_done

