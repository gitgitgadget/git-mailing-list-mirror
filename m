Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D51C433EF
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 03:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFE2A61354
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 03:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237251AbhKHDpl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Nov 2021 22:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbhKHDpk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Nov 2021 22:45:40 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E33EC061570
        for <git@vger.kernel.org>; Sun,  7 Nov 2021 19:42:56 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id bm28so14341105qkb.9
        for <git@vger.kernel.org>; Sun, 07 Nov 2021 19:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FjhpkWk3n8nP5S7IkFrvSN+xh+/3C3CH3PIns7RLBSs=;
        b=Lesstf9qi5mWz0PdIDtE+ZSabC8LggISlaf/1B0Yjj2XOUjRDgoHTlOMWs9OpOyrkj
         qRLdfN6mafqpV39eoVTzZU0qkGMBPAKhhpi5ft/V7ngm+oTMmjNXJomZtHRmabS3aRO1
         CJktf0nJ0B7TdHptlKzXsoUcnfzFus9rnGILM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FjhpkWk3n8nP5S7IkFrvSN+xh+/3C3CH3PIns7RLBSs=;
        b=T5H7LMaIAF09EHVA3uoifXji05OZ0TAKqpolwsn1qhZqo9Vj4LcSKER25z+izHUPKZ
         z2UasIHfpeg3kpP5TZiCO/IixpRctY9qC1Hk6/ikcOvv5O2+SN2M6yAMprfQn3ouw+Of
         Plpigle2S4E7jEVWFITY0ImP9dPsZ3LqMbWaysGVrpO3jZFUpRXv2+UAnntQj1cPI3zR
         qSBerGeghKI8KHe6RXCJjxEOeOCkIOl0BMa+q2hKw4+x7QT7XS7fcAQRs/6pDvYOwTmM
         zE5vdt8I/Q/oZ4csnlnDQOctRrTfancrh5fdEm/8rTTqmpfTLSQB5tHPZuhgXMoVC9Nm
         BwNQ==
X-Gm-Message-State: AOAM531PERqya+1Hh3yIKekFmOgSgZaS0IpXjIep1o3rXKWaWMYei38x
        ozDkgAN05cGsL9UPrroDzgQTUw==
X-Google-Smtp-Source: ABdhPJyhnlOAh/70pXpPcCN6+ifYhf8cGuIBRSZ9G9aFzPjOqurrzfRIbjvJHxhii6EVnz9LJK/3Ow==
X-Received: by 2002:a05:620a:461f:: with SMTP id br31mr45552112qkb.436.1636342975539;
        Sun, 07 Nov 2021 19:42:55 -0800 (PST)
Received: from localhost (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id y14sm6882400qta.86.2021.11.07.19.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 19:42:55 -0800 (PST)
Date:   Sun, 7 Nov 2021 22:42:54 -0500
From:   John Cai <jcai@gitlab.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/2] cat-file: force flush of stdout on empty string
Message-ID: <20211108034254.ycdhvkdng63abput@Johns-MacBook-Pro-3.local>
References: <pull.1124.git.git.1636149400.gitgitgadget@gmail.com>
 <2d687baeed82e7b90d383bad8e209f50e0ce8c87.1636149400.git.gitgitgadget@gmail.com>
 <xmqqsfwaumlc.fsf@gitster.g>
 <211106.86k0hmgc8q.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211106.86k0hmgc8q.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

O Sat, Nov 06, 2021 at 05:01:10AM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Nov 05 2021, Junio C Hamano wrote:
> 
> > "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> >> @@ -405,6 +405,11 @@ static void batch_one_object(const char *obj_name,
> >>  	int flags = opt->follow_symlinks ? GET_OID_FOLLOW_SYMLINKS : 0;
> >>  	enum get_oid_result result;
> >>  
> >> +	if (opt->buffer_output && obj_name[0] == '\0') {
> >> +		fflush(stdout);
> >> +		return;
> >> +	}
> >> +
> >
> > This might work in practice, but it a bad design taste to add this
> > change here.  The function is designed to take an object name
> > string, and it even prepares a flag variable needed to make a call
> > to turn that object name into object data.  We do not need to
> > contaminate the interface with "usually this takes an object name,
> > but there are these other special cases ...".  The higher in the
> > callchain we place special cases, the better the lower level
> > functions become, as that allows them to concentrate on doing one
> > single thing well.
> >
> >>  	result = get_oid_with_context(the_repository, obj_name,
> >>  				      flags, &data->oid, &ctx);
> >>  	if (result != FOUND) {
> >> @@ -609,7 +614,11 @@ static int batch_objects(struct batch_options *opt)
> >>  			data.rest = p;
> >>  		}
> >>  
> >> -		batch_one_object(input.buf, &output, opt, &data);
> >> +		 /*
> >> +		  * When in buffer mode and input.buf is an empty string,
> >> +		  * flush to stdout.
> >> +		  */
> >
> > Checking "do we have the flush instruction (in which case we'd do
> > the flush here), or do we have textual name of an object (in which
> > case we'd call batch_one_object())?" here would be far cleaner and
> > results in an easier-to-explain code.  With a cleanly written code
> > to do so, it probably does not even need a new comment here.
> >
> > This brings up another issue.  Is "flushing" the *ONLY* special
> > thing we would ever do in this codepath in the future?  I doubt so.
> > Squatting on an "empty string" is a selfish design that hurts those
> > who will come after you in the future, as they need to find other
> > ways to ask for a "special thing".
> >
> > If we are inventing a special syntax that allows us to spell
> > commands that are distinguishable from a validly-spelled object name
> > to cause something special (like "flushing the output stream"),
> > perhaps we want to use a bit more extensible and explicit syntax and
> > use it from day one?
> >
> > For example, if no string that begins with three dots can ever be a
> > valid way to spell an object name, perhaps "...flush" might be a
> > better "please do this special thing" syntax than an empty string.
> > It is easily extensible (the next special thing can follow suit to
> > say "...$verb" to tell the machinery to $verb the input).  When we
> > compare between an empty string and "...flush", the latter clearly
> > is more descriptive, too.
> >
> > Note that I offhand do not know if "a valid string that name an
> > object would never begin with three-dot" is true.  Please check
> > if that is true if you choose to use it, or you can find and use
> > another convention that allows us to clearly distinguish the
> > "special" instruction and object names.
> 
> I had much the same thought, this is a useful feature, but let's not
> squat on the one bit of open syntax we have.
> 
> John: I think a better direction here is to add a mode to cat-file to
> emulate what "git update-ref --stdin" supports. Here's a demo of that
> (also quoted below):
> https://github.com/git/git/commit/7794f6cfdbdca0dd6bab0dea16193ebf018b86a9
> 
> That's on top of some general UI improvements to cat-file I've got
> locally:
> https://github.com/git/git/compare/master...avar:avar/cat-file-usage-and-options-handling
> 
> That WIP patch on top follows below, of course it's a *lot* more initial
> scaffolding, but I think once we get past that initial step it's a much
> better path forward. As noted the code is also almost entirely
> copy/pasted from update-ref.c, and perhaps some of the shared parts
> could be moved to some library both could use.
> 
> I couldn't think of a better name than --stdin-cmd, suggestions most
> welcome.
> 
> From 7794f6cfdbdca0dd6bab0dea16193ebf018b86a9 Mon Sep 17 00:00:00 2001
> Message-Id: <patch-1.1-7794f6cfdbd-20211106T040307Z-avarab@gmail.com>
> From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
>  <avarab@gmail.com>
> Date: Sat, 6 Nov 2021 04:54:04 +0100
> Subject: [PATCH] WIP cat-file: add a --stdin-cmd mode
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> This WIP patch is mostly stealing code from builtin/update-ref.c and
> implementing the same sort of prefixed command-mode that it
> supports. I.e. in addition to --batch now supporting:
> 
>     <object> LF
> 
> It'll support with --stdin-cmd, with and without -z, respectively:
> 
>     object <object> NL
>     object <object> NUL
> 
> The plus being that we can now implement additional commands. Let's
> start that by scratching the itch John Cai wanted to address in [1]
> and implement a (with and without -z):
> 
>     fflush NL
>     fflush NUL
> 
> That command simply calls fflush(stdout), which could be done as an
> emergent effect before by feeding the input a "NL".
> 
> I think this will be useful for other things, e.g. I've observed in
> the past that a not-trivial part of "cat-file --batch" time is spent
> on parsing its <object> argument and seeing if it's a revision, ref
> etc.
> 
> So we could e.g. add a command that only accepts a full-length 40
> character SHA-1, or switch the --format output mid-request etc.
> 
> 1. https://lore.kernel.org/git/pull.1124.git.git.1636149400.gitgitgadget@gmail.com/
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  builtin/cat-file.c | 116 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 115 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index b76f2a00046..afdb976c6e7 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -26,7 +26,10 @@ struct batch_options {
>  	int unordered;
>  	int cmdmode; /* may be 'w' or 'c' for --filters or --textconv */
>  	const char *format;
> +	int stdin_cmd;
> +	int end_null;
>  };
> +static char line_termination = '\n';
>  
>  static const char *force_path;
>  
> @@ -507,6 +510,106 @@ static int batch_unordered_packed(const struct object_id *oid,
>  				      data);
>  }
>  
> +enum batch_state {
> +	/* Non-transactional state open for commands. */
> +	BATCH_STATE_OPEN,
> +};
> +
> +static void parse_cmd_object(struct batch_options *opt,
> +			     const char *next, const char *end,
> +			     struct strbuf *output,
> +			     struct expand_data *data)
> +{
> +	size_t len = end - next - 1;
> +	char *p = (char *)next;
> +	char old = p[len];
> +
> +	p[len] = '\0';
> +	batch_one_object(next, output, opt, data);
> +	p[len] = old;
> +}
> +
> +static void parse_cmd_fflush(struct batch_options *opt,
> +			     const char *next, const char *end,
> +			     struct strbuf *output,
> +			     struct expand_data *data)
> +{
> +	if (*next != line_termination)
> +		die("fflush: extra input: %s", next);
> +	fflush(stdout);
> +}
> +
> +static const struct parse_cmd {
> +	const char *prefix;
> +	void (*fn)(struct batch_options *, const char *, const char *, struct strbuf *, struct expand_data *);
> +	unsigned args;
> +	enum batch_state state;
> +} command[] = {
> +	{ "object", parse_cmd_object, 1, BATCH_STATE_OPEN },
> +	{ "fflush", parse_cmd_fflush, 0, BATCH_STATE_OPEN },
> +};
I think overall this approach is cleaner and makes sense. My only
question is, are there more commands in the future that will need some
special command syntax? Just wondering whether YAGNI applies here.
> +
> +static void batch_objects_stdin_cmd(struct batch_options *opt,
> +				    struct strbuf *output,
> +				    struct expand_data *data)
> +{
> +	struct strbuf input = STRBUF_INIT;
> +	enum batch_state state = BATCH_STATE_OPEN;
> +
> +	/* Read each line dispatch its command */
> +	while (!strbuf_getwholeline(&input, stdin, line_termination)) {
> +		size_t i, j;
> +		const struct parse_cmd *cmd = NULL;
> +
> +		if (*input.buf == line_termination)
> +			die("empty command in input");
> +		else if (isspace(*input.buf))
> +			die("whitespace before command: %s", input.buf);
> +
> +		for (i = 0; i < ARRAY_SIZE(command); i++) {
> +			const char *prefix = command[i].prefix;
> +			char c;
> +
> +			if (!starts_with(input.buf, prefix))
> +				continue;
> +
> +			/*
> +			 * If the command has arguments, verify that it's
> +			 * followed by a space. Otherwise, it shall be followed
> +			 * by a line terminator.
> +			 */
> +			c = command[i].args ? ' ' : line_termination;
> +			if (input.buf[strlen(prefix)] != c)
> +				continue;
> +
> +			cmd = &command[i];
> +			break;
> +		}
> +		if (!cmd)
> +			die("unknown command: %s", input.buf);
> +
> +		/*
> +		 * Read additional arguments if NUL-terminated. Do not raise an
> +		 * error in case there is an early EOF to let the command
> +		 * handle missing arguments with a proper error message.
> +		 */
> +		for (j = 1; line_termination == '\0' && j < cmd->args; j++)
> +			if (strbuf_appendwholeline(&input, stdin, line_termination))
> +				break;
> +
> +		switch (state) {
> +		case BATCH_STATE_OPEN:
> +			/* TODO: command state management */
> +			break;
> +		}
> +
> +		cmd->fn(opt, input.buf + strlen(cmd->prefix) + !!cmd->args,
> +			input.buf + input.len, output, data);
> +	}
> +
> +	strbuf_release(&input);
> +}
> +
>  static int batch_objects(struct batch_options *opt)
>  {
>  	struct strbuf input = STRBUF_INIT;
> @@ -514,6 +617,7 @@ static int batch_objects(struct batch_options *opt)
>  	struct expand_data data;
>  	int save_warning;
>  	int retval = 0;
> +	const int stdin_cmd = opt->stdin_cmd;
>  
>  	if (!opt->format)
>  		opt->format = "%(objectname) %(objecttype) %(objectsize)";
> @@ -589,7 +693,8 @@ static int batch_objects(struct batch_options *opt)
>  	save_warning = warn_on_object_refname_ambiguity;
>  	warn_on_object_refname_ambiguity = 0;
>  
> -	while (strbuf_getline(&input, stdin) != EOF) {
> +	while (!stdin_cmd &&
> +	       strbuf_getline(&input, stdin) != EOF) {
>  		if (data.split_on_whitespace) {
>  			/*
>  			 * Split at first whitespace, tying off the beginning
> @@ -607,6 +712,9 @@ static int batch_objects(struct batch_options *opt)
>  		batch_one_object(input.buf, &output, opt, &data);
>  	}
>  
> +	if (stdin_cmd)
> +		batch_objects_stdin_cmd(opt, &output, &data);
> +
>  	strbuf_release(&input);
>  	strbuf_release(&output);
>  	warn_on_object_refname_ambiguity = save_warning;
> @@ -684,6 +792,10 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>  			batch_option_callback),
>  		OPT_CMDMODE(0, "batch-all-objects", &opt,
>  			    N_("with --batch[-check]: ignores stdin, batches all known objects"), 'b'),
> +		OPT_BOOL(0, "stdin-cmd", &batch.stdin_cmd,
> +			 N_("with --batch[-check]: enters stdin 'command mode")),
> +		OPT_BOOL('z', NULL, &batch.end_null, N_("with --stdin-cmd, use NUL termination")),
> +
>  		/* Batch-specific options */
>  		OPT_GROUP(N_("Change or optimize batch output")),
>  		OPT_BOOL(0, "buffer", &batch.buffer_output, N_("buffer --batch output")),
> @@ -737,6 +849,8 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>  	/* Batch defaults */
>  	if (batch.buffer_output < 0)
>  		batch.buffer_output = batch.all_objects;
> +	if (batch.end_null)
> +		line_termination = '\0';
>  
>  	/* Return early if we're in batch mode? */
>  	if (batch.enabled) {
> -- 
> 2.34.0.rc1.741.gab7bfd97031
> 
