Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75F601F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 19:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeKNF6k (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 00:58:40 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:2190 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeKNF6k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 00:58:40 -0500
Received: from [192.168.2.240] ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id MeprgwYLzoI6LMepsgsqaZ; Tue, 13 Nov 2018 19:58:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1542139137;
        bh=TIG8qomPor9/EPoUZIKiF1cqcBsRaIH7nDBfFBxmXnE=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jpeEUH9FSFyj23qz3nepraWwxfsHuy8GUvyi2/V+D5hfNaji5bHSOvpU25Eiqc0+p
         uSxo37BeFTZ1VWNqvR/n16mq/Q5HKpRLmvidS0ubzSNkwTAhO+f1vaz2zeN7GKT0yN
         WByklHsJJX2FB44mpstJ/3Kwl7Nh9WdSVANw2dAk=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=IkcTkHD0fZMA:10 a=BNd5QaslsyWw3RUYg7cA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/1] rebase: really just passthru the `git am` options
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.76.git.gitgitgadget@gmail.com>
 <dc36a450680b1854abbb9bb06180001ce68c3f3b.1542112703.git.gitgitgadget@gmail.com>
 <00d9b0e4-dde5-c96d-76d7-42fb9ac393f8@talktalk.net>
 <nycvar.QRO.7.76.6.1811132019440.39@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <1b8461d1-6cb7-6622-94d2-44c27623236d@talktalk.net>
Date:   Tue, 13 Nov 2018 19:58:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1811132019440.39@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfO63qN1I4kOi9eOcQpTkrZ6wItit84sPrfGmgPGNwwgwaor+0lUwQwHy9qlz/ULLiZX/EvQ1z/8caiTCuID7FlyE39Oaw/RzSmYrRdP6MnGe81MVqkev
 0MVjSbP8pjkZelVE9Ib6FB264BEZ2I+xq/mHMZUMfjtA04k1NWg1f32tweipV9p63ESR6VWaiI5GQCIjaU48uGAqUe11VrJ4G2PaJV6zw/UwYArs32N5Qfc+
 0HjjyLeQn+WNojhB33ozYBoiOp+syes7KeNno7mXgknOwKH9KUa3XTrfg1KO3la9ZgWqlZhoc9p7HMqOmVWaaA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes

On 13/11/2018 19:21, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Tue, 13 Nov 2018, Phillip Wood wrote:
> 
>> Thanks for looking at this. Unfortunately using OPT_PASSTHRU_ARGV seems to
>> break the error reporting
>>
>> Running
>>    bin/wrappers/git rebase --onto @^^^^ @^^ -Cbad
>>
>> Gives
>>    git encountered an error while preparing the patches to replay
>>    these revisions:
>>
>>
>> 67f673aa4a580b9e407b1ca505abf1f50510ec47...7c3e01a708856885e60bf4051586970e65dd326c
>>
>>    As a result, git cannot rebase them.
>>

git 2.19.1 gives

First, rewinding head to replay your work on top of it...
Applying: Ninth batch for 2.20
error: switch `C' expects a numerical value

So it has a clear message as to what the error is, this patch regresses 
that. It would be better if rebase detected the error before starting 
though.

>> If I do
>>
>>    bin/wrappers/git rebase @^^ -Cbad
>>
>> I get no error, it just tells me that it does not need to rebase (which is
>> true)
> 
> Hmm. Isn't this the same behavior as with the scripted version?

Ah you're right the script does not check if the option argument is valid.

> Also: are
> we sure that we want to allow options to come *after* the `<upstream>`
> argument?

Maybe not but the scripted version does. I'm not sure if that is a good 
idea or not.

Best Wishes

Phillip

> Ciao,
> Dscho
> 
>> Best Wishes
>>
>> Phillip
>>
>>
>> On 13/11/2018 12:38, Johannes Schindelin via GitGitGadget wrote:
>>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>>
>>> Currently, we parse the options intended for `git am` as if we wanted to
>>> handle them in `git rebase`, and then reconstruct them painstakingly to
>>> define the `git_am_opt` variable.
>>>
>>> However, there is a much better way (that I was unaware of, at the time
>>> when I mentored Pratik to implement these options): OPT_PASSTHRU_ARGV.
>>> It is intended for exactly this use case, where command-line options
>>> want to be parsed into a separate `argv_array`.
>>>
>>> Let's use this feature.
>>>
>>> Incidentally, this also allows us to address a bug discovered by Phillip
>>> Wood, where the built-in rebase failed to understand that the `-C`
>>> option takes an optional argument.
>>>
>>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>>> ---
>>>    builtin/rebase.c | 98 +++++++++++++++++-------------------------------
>>>    1 file changed, 35 insertions(+), 63 deletions(-)
>>>
>>> diff --git a/builtin/rebase.c b/builtin/rebase.c
>>> index 0ee06aa363..96ffa80b71 100644
>>> --- a/builtin/rebase.c
>>> +++ b/builtin/rebase.c
>>> @@ -87,7 +87,7 @@ struct rebase_options {
>>>      REBASE_FORCE = 1<<3,
>>>      REBASE_INTERACTIVE_EXPLICIT = 1<<4,
>>>    	} flags;
>>> -	struct strbuf git_am_opt;
>>> +	struct argv_array git_am_opts;
>>>     const char *action;
>>>     int signoff;
>>>     int allow_rerere_autoupdate;
>>> @@ -339,7 +339,7 @@ N_("Resolve all conflicts manually, mark them as
>>> resolved with\n"
>>>    static int run_specific_rebase(struct rebase_options *opts)
>>>    {
>>>    	const char *argv[] = { NULL, NULL };
>>> -	struct strbuf script_snippet = STRBUF_INIT;
>>> +	struct strbuf script_snippet = STRBUF_INIT, buf = STRBUF_INIT;
>>>     int status;
>>>     const char *backend, *backend_func;
>>>    @@ -433,7 +433,9 @@ static int run_specific_rebase(struct rebase_options
>>> *opts)
>>>     	oid_to_hex(&opts->restrict_revision->object.oid) : NULL);
>>>     add_var(&script_snippet, "GIT_QUIET",
>>>    		opts->flags & REBASE_NO_QUIET ? "" : "t");
>>> -	add_var(&script_snippet, "git_am_opt", opts->git_am_opt.buf);
>>> +	sq_quote_argv_pretty(&buf, opts->git_am_opts.argv);
>>> +	add_var(&script_snippet, "git_am_opt", buf.buf);
>>> +	strbuf_release(&buf);
>>>     add_var(&script_snippet, "verbose",
>>>     	opts->flags & REBASE_VERBOSE ? "t" : "");
>>>    	add_var(&script_snippet, "diffstat",
>>> @@ -756,7 +758,7 @@ int cmd_rebase(int argc, const char **argv, const char
>>> *prefix)
>>>     struct rebase_options options = {
>>>      .type = REBASE_UNSPECIFIED,
>>>      .flags = REBASE_NO_QUIET,
>>> -		.git_am_opt = STRBUF_INIT,
>>> +		.git_am_opts = ARGV_ARRAY_INIT,
>>>      .allow_rerere_autoupdate  = -1,
>>>      .allow_empty_message = 1,
>>>      .git_format_patch_opt = STRBUF_INIT,
>>> @@ -777,12 +779,7 @@ int cmd_rebase(int argc, const char **argv, const
>>> char *prefix)
>>>      ACTION_EDIT_TODO,
>>>      ACTION_SHOW_CURRENT_PATCH,
>>>    	} action = NO_ACTION;
>>> -	int committer_date_is_author_date = 0;
>>> -	int ignore_date = 0;
>>> -	int ignore_whitespace = 0;
>>>    	const char *gpg_sign = NULL;
>>> -	int opt_c = -1;
>>> -	struct string_list whitespace = STRING_LIST_INIT_NODUP;
>>>     struct string_list exec = STRING_LIST_INIT_NODUP;
>>>     const char *rebase_merges = NULL;
>>>     int fork_point = -1;
>>> @@ -804,15 +801,20 @@ int cmd_rebase(int argc, const char **argv, const
>>> char *prefix)
>>>      {OPTION_NEGBIT, 'n', "no-stat", &options.flags, NULL,
>>>       N_("do not show diffstat of what changed upstream"),
>>>       PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
>>> -		OPT_BOOL(0, "ignore-whitespace", &ignore_whitespace,
>>> -			 N_("passed to 'git apply'")),
>>>      OPT_BOOL(0, "signoff", &options.signoff,
>>>    			 N_("add a Signed-off-by: line to each commit")),
>>> -		OPT_BOOL(0, "committer-date-is-author-date",
>>> -			 &committer_date_is_author_date,
>>> -			 N_("passed to 'git am'")),
>>> -		OPT_BOOL(0, "ignore-date", &ignore_date,
>>> -			 N_("passed to 'git am'")),
>>> +		OPT_PASSTHRU_ARGV(0, "ignore-whitespace",
>>> &options.git_am_opts,
>>> +				  NULL, N_("passed to 'git am'"),
>>> +				  PARSE_OPT_NOARG),
>>> +		OPT_PASSTHRU_ARGV(0, "committer-date-is-author-date",
>>> +				  &options.git_am_opts, NULL,
>>> +				  N_("passed to 'git am'"),
>>> PARSE_OPT_NOARG),
>>> +		OPT_PASSTHRU_ARGV(0, "ignore-date", &options.git_am_opts,
>>> NULL,
>>> +				  N_("passed to 'git am'"),
>>> PARSE_OPT_NOARG),
>>> +		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
>>> +				  N_("passed to 'git apply'"), 0),
>>> +		OPT_PASSTHRU_ARGV(0, "whitespace", &options.git_am_opts,
>>> +				  N_("action"), N_("passed to 'git apply'"),
>>> 0),
>>>      OPT_BIT('f', "force-rebase", &options.flags,
>>>       N_("cherry-pick all commits, even if unchanged"),
>>>       REBASE_FORCE),
>>> @@ -856,10 +858,6 @@ int cmd_rebase(int argc, const char **argv, const
>>> char *prefix)
>>>      { OPTION_STRING, 'S', "gpg-sign", &gpg_sign, N_("key-id"),
>>>       N_("GPG-sign commits"),
>>>       PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
>>> -		OPT_STRING_LIST(0, "whitespace", &whitespace,
>>> -				N_("whitespace"), N_("passed to 'git
>>> apply'")),
>>> -		OPT_SET_INT('C', NULL, &opt_c, N_("passed to 'git apply'"),
>>> -			    REBASE_AM),
>>>      OPT_BOOL(0, "autostash", &options.autostash,
>>>      	 N_("automatically stash/stash pop before and after")),
>>>    		OPT_STRING_LIST('x', "exec", &exec, N_("exec"),
>>> @@ -884,6 +882,7 @@ int cmd_rebase(int argc, const char **argv, const char
>>> *prefix)
>>>      	 N_("rebase all reachable commits up to the root(s)")),
>>>     	OPT_END(),
>>>    	};
>>> +	int i;
>>>    
>>>     /*
>>>    	 * NEEDSWORK: Once the builtin rebase has been tested enough
>>> @@ -1064,22 +1063,17 @@ int cmd_rebase(int argc, const char **argv, const
>>> char *prefix)
>>>     	    state_dir_base, cmd_live_rebase, buf.buf);
>>>     }
>>>    -	if (!(options.flags & REBASE_NO_QUIET))
>>> -		strbuf_addstr(&options.git_am_opt, " -q");
>>> -
>>> -	if (committer_date_is_author_date) {
>>> -		strbuf_addstr(&options.git_am_opt,
>>> -			      " --committer-date-is-author-date");
>>> -		options.flags |= REBASE_FORCE;
>>> +	for (i = 0; i < options.git_am_opts.argc; i++) {
>>> +		const char *option = options.git_am_opts.argv[i];
>>> +		if (!strcmp(option, "--committer-date-is-author-date") ||
>>> +		    !strcmp(option, "--ignore-date") ||
>>> +		    !strcmp(option, "--whitespace=fix") ||
>>> +		    !strcmp(option, "--whitespace=strip"))
>>> +			options.flags |= REBASE_FORCE;
>>>     }
>>>    -	if (ignore_whitespace)
>>> -		strbuf_addstr(&options.git_am_opt, " --ignore-whitespace");
>>> -
>>> -	if (ignore_date) {
>>> -		strbuf_addstr(&options.git_am_opt, " --ignore-date");
>>> -		options.flags |= REBASE_FORCE;
>>> -	}
>>> +	if (!(options.flags & REBASE_NO_QUIET))
>>> +		argv_array_push(&options.git_am_opts, "-q");
>>>    
>>>     if (options.keep_empty)
>>>    		imply_interactive(&options, "--keep-empty");
>>> @@ -1089,23 +1083,6 @@ int cmd_rebase(int argc, const char **argv, const
>>> char *prefix)
>>>     	options.gpg_sign_opt = xstrfmt("-S%s", gpg_sign);
>>>     }
>>>    -	if (opt_c >= 0)
>>> -		strbuf_addf(&options.git_am_opt, " -C%d", opt_c);
>>> -
>>> -	if (whitespace.nr) {
>>> -		int i;
>>> -
>>> -		for (i = 0; i < whitespace.nr; i++) {
>>> -			const char *item = whitespace.items[i].string;
>>> -
>>> -			strbuf_addf(&options.git_am_opt, " --whitespace=%s",
>>> -				    item);
>>> -
>>> -			if ((!strcmp(item, "fix")) || (!strcmp(item,
>>> "strip")))
>>> -				options.flags |= REBASE_FORCE;
>>> -		}
>>> -	}
>>> -
>>>     if (exec.nr) {
>>>      int i;
>>>    @@ -1181,23 +1158,18 @@ int cmd_rebase(int argc, const char **argv,
>>> const char *prefix)
>>>     	break;
>>>     }
>>>    -	if (options.git_am_opt.len) {
>>> -		const char *p;
>>> -
>>> +	if (options.git_am_opts.argc) {
>>>    		/* all am options except -q are compatible only with --am */
>>> -		strbuf_reset(&buf);
>>> -		strbuf_addbuf(&buf, &options.git_am_opt);
>>> -		strbuf_addch(&buf, ' ');
>>> -		while ((p = strstr(buf.buf, " -q ")))
>>> -			strbuf_splice(&buf, p - buf.buf, 4, " ", 1);
>>> -		strbuf_trim(&buf);
>>> +		for (i = options.git_am_opts.argc - 1; i >= 0; i--)
>>> +			if (strcmp(options.git_am_opts.argv[i], "-q"))
>>> +				break;
>>>    -		if (is_interactive(&options) && buf.len)
>>> +		if (is_interactive(&options) && i >= 0)
>>>       die(_("error: cannot combine interactive options "
>>>             "(--interactive, --exec, --rebase-merges, "
>>>             "--preserve-merges, --keep-empty, --root + "
>>>             "--onto) with am options (%s)"), buf.buf);
>>> -		if (options.type == REBASE_MERGE && buf.len)
>>> +		if (options.type == REBASE_MERGE && i >= 0)
>>>       die(_("error: cannot combine merge options (--merge, "
>>>             "--strategy, --strategy-option) with am options "
>>>             "(%s)"), buf.buf);
>>> @@ -1207,7 +1179,7 @@ int cmd_rebase(int argc, const char **argv, const
>>> char *prefix)
>>>      if (options.type == REBASE_PRESERVE_MERGES)
>>>       die("cannot combine '--signoff' with "
>>>    			    "'--preserve-merges'");
>>> -		strbuf_addstr(&options.git_am_opt, " --signoff");
>>> +		argv_array_push(&options.git_am_opts, "--signoff");
>>>     	options.flags |= REBASE_FORCE;
>>>     }
>>>    
>>>
>>
>>

