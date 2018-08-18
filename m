Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA4DB1F954
	for <e@80x24.org>; Sat, 18 Aug 2018 22:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbeHSBP6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 21:15:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41893 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeHSBP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 21:15:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id z96-v6so1247776wrb.8
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 15:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KhRucr4VSTmBjiIRJtetLoXlgacevZ4fE762vomD+YM=;
        b=LerRDL5ckCagLsOl5r+iApu43PdASX3YXHrjyJ9zBqKdnDQNMyOC19VPkEpjq2qD02
         N2FihzEpCS0qGiyrHHzbizb0nb84gFcMeORjZv4wNnJ3PsXZ9NnXz73RKpRk9EPgIK8s
         GKw0z5j9BMDk0MhE3isVKUL0u//XIQDljW62H9XoQPdJYZzBKMtTaNTXXEp8wNQYI1Ud
         SAI3xKpjf40o4dVM3Gp/q8Oy4b9/I240B5ioGM/LaIofN7TObB5i/LBCA9fANzk9LHVd
         AmBWVla643n3MwQMObLBQzl2K8nXVG9zECL/Po4w6AhOX87ypEKSnvjJUr7FaApmulbY
         NL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KhRucr4VSTmBjiIRJtetLoXlgacevZ4fE762vomD+YM=;
        b=UgOlsu3k7yPFLwtHK09BhmNYUAY8vT8TEGqym4J0AVddUrEwVH9UOQ/Z+fUoYqXdM1
         0vWXusqrESCb137ILLS1V3wrf2EXXcRmrOw6v/nddNUklCo9uJSPfdgvII4OBbDi2E7b
         ionRTF1vyfJnvzKQBnFuAzMwTXG9RZIZZucj4yFYW5fK1rC+HS9UdqTk6t9vjNbSKUoK
         tabg2sQiqJSwaRYGJrBVp3Y88c5UTZ5ELvFw5N/nMVe7iNpH20a8XoQa+kSdOJT2ccvx
         2fLyjS0bT1U+8oTK1+OhNovL0EWSGUuHscDD3nwA1axQw+Phm/BHbHkoOKZPSJ6dzEEV
         47LA==
X-Gm-Message-State: AOUpUlGvk14doiCyqvAf1wV+dPwrkCTXHRsNX7NqThABbq1A7icLkJuU
        AAxkp919IeRxc7uLq0i0H5QWZ+Wp
X-Google-Smtp-Source: AA+uWPzJlmhboKucsFnYjrGNt7Hr7MWW8TQ/ETHdsTciYpqyyXshHV8gPzV4N0dNwgyJU98GgkL78w==
X-Received: by 2002:adf:f410:: with SMTP id g16-v6mr25248541wro.256.1534630006256;
        Sat, 18 Aug 2018 15:06:46 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id z1-v6sm5007564wmf.5.2018.08.18.15.06.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 15:06:45 -0700 (PDT)
Date:   Sat, 18 Aug 2018 23:06:44 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v7 17/26] stash: avoid spawning a "diff-index"
 process
Message-ID: <20180818220644.GH11326@hank.intra.tgummerer.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
 <ec5b2c9ac9e0e58710bdc385e03a01e2a7fd10bd.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec5b2c9ac9e0e58710bdc385e03a01e2a7fd10bd.1533753605.git.ungureanupaulsebastian@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/08, Paul-Sebastian Ungureanu wrote:
> This commits replaces spawning `diff-index` child process by using
> the already existing `diff` API

I think this should be squashed into the previous commit.  It's easier
to review a commit that replaces all the 'run_command'/'pipe_command'
calls in one function, rather than doing it call by call, especially
if they interact with eachother.

E.g. I was going to suggest replacing the 'write_tree' call as well,
but reading ahead in the series I see that that's already being done :)  

While replacing all the calls of one type with the internal API call
is probably easiest for writing the patches, at least I would find it
easier to review replacing the run-command API calls in one codepath
at a time.

> ---
>  builtin/stash--helper.c | 56 ++++++++++++++++++++++++++++++-----------
>  1 file changed, 42 insertions(+), 14 deletions(-)
> 
> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> index 887b78d05..f905d3908 100644
> --- a/builtin/stash--helper.c
> +++ b/builtin/stash--helper.c
> @@ -12,6 +12,7 @@
>  #include "rerere.h"
>  #include "revision.h"
>  #include "log-tree.h"
> +#include "diffcore.h"
>  
>  static const char * const git_stash_helper_usage[] = {
>  	N_("git stash--helper list [<options>]"),
> @@ -297,6 +298,18 @@ static int reset_head(const char *prefix)
>  	return run_command(&cp);
>  }
>  
> +static void add_diff_to_buf(struct diff_queue_struct *q,
> +			    struct diff_options *options,
> +			    void *data)
> +{
> +	int i;
> +	for (i = 0; i < q->nr; i++) {
> +		struct diff_filepair *p = q->queue[i];
> +		strbuf_addstr(data, p->one->path);
> +		strbuf_addch(data, '\n');

What about filenames that include a '\n'?  I think this in combination
with removing the '-z' flag from the 'update-index' call will break
with filenames that have a LF in them.  This should be a '\0' instead
of a '\n', and we should still be using the '-z' flag in
'update-index'.

> +	}
> +}
> +
>  static int get_newly_staged(struct strbuf *out, struct object_id *c_tree)
>  {
>  	struct child_process cp = CHILD_PROCESS_INIT;
> @@ -981,14 +994,16 @@ static int stash_patch(struct stash_info *info, const char **argv)
>  	return ret;
>  }
>  
> -static int stash_working_tree(struct stash_info *info, const char **argv)
> +static int stash_working_tree(struct stash_info *info,
> +			      const char **argv, const char *prefix)
>  {
>  	int ret = 0;
> -	struct child_process cp1 = CHILD_PROCESS_INIT;
>  	struct child_process cp2 = CHILD_PROCESS_INIT;
>  	struct child_process cp3 = CHILD_PROCESS_INIT;
> -	struct strbuf out1 = STRBUF_INIT;
>  	struct strbuf out3 = STRBUF_INIT;

We're left with cp{2,3} and out3 here, which is a bit weird.  Then
again renaming them in this patch adds more churn, making it harder to
review.  Maybe instead of numbering them it would be better to name
them after the child process they are calling?  e.g. 'cp1' could
become 'cp_di', and so on?

> +	struct argv_array args = ARGV_ARRAY_INIT;
> +	struct strbuf diff_output = STRBUF_INIT;
> +	struct rev_info rev;
>  
>  	set_alternate_index_output(stash_index_path.buf);
>  	if (reset_tree(&info->i_tree, 0, 0)) {
> @@ -997,26 +1012,36 @@ static int stash_working_tree(struct stash_info *info, const char **argv)
>  	}
>  	set_alternate_index_output(".git/index");
>  
> -	cp1.git_cmd = 1;
> -	argv_array_pushl(&cp1.args, "diff-index", "--name-only", "-z",
> -			"HEAD", "--", NULL);
> +	argv_array_push(&args, "dummy");

Not being familiar with the setup_revisions code, I had to dig a bit
to figure out why this makes sense.  This is a dummy replacement for
argv[0] in normal operation.  In retrospect it's kind of obvious, but
maybe call "dummy" "fake_argv0" instead, to help nudge future readers
in the right direction?

>  	if (argv)
> -		argv_array_pushv(&cp1.args, argv);
> -	argv_array_pushf(&cp1.env_array, "GIT_INDEX_FILE=%s",
> -			 stash_index_path.buf);
> +		argv_array_pushv(&args, argv);
> +	git_config(git_diff_basic_config, NULL);
> +	init_revisions(&rev, prefix);
> +	args.argc = setup_revisions(args.argc, args.argv, &rev, NULL);
> +
> +	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
> +	rev.diffopt.format_callback = add_diff_to_buf;
> +	rev.diffopt.format_callback_data = &diff_output;
> +
> +	if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
> +		ret = -1;
> +		goto done;
> +	}
>  
> -	if (pipe_command(&cp1, NULL, 0, &out1, 0, NULL, 0)) {
> +	add_pending_object(&rev, parse_object(the_repository, &info->b_commit), "");
> +	if (run_diff_index(&rev, 0)) {
>  		ret = -1;
>  		goto done;
>  	}
>  
>  	cp2.git_cmd = 1;
> -	argv_array_pushl(&cp2.args, "update-index", "-z", "--add",
> +	argv_array_pushl(&cp2.args, "update-index", "--add",
>  			 "--remove", "--stdin", NULL);
>  	argv_array_pushf(&cp2.env_array, "GIT_INDEX_FILE=%s",
>  			 stash_index_path.buf);
>  
> -	if (pipe_command(&cp2, out1.buf, out1.len, NULL, 0, NULL, 0)) {
> +	if (pipe_command(&cp2, diff_output.buf, diff_output.len,
> +			 NULL, 0, NULL, 0)) {
>  		ret = -1;
>  		goto done;
>  	}
> @@ -1033,8 +1058,11 @@ static int stash_working_tree(struct stash_info *info, const char **argv)
>  	get_oid_hex(out3.buf, &info->w_tree);
>  
>  done:
> -	strbuf_release(&out1);
> +	UNLEAK(rev);
>  	strbuf_release(&out3);
> +	argv_array_clear(&args);
> +	object_array_clear(&rev.pending);
> +	strbuf_release(&diff_output);
>  	remove_path(stash_index_path.buf);
>  	return ret;
>  }
> @@ -1112,7 +1140,7 @@ static int do_create_stash(int argc, const char **argv, const char *prefix,
>  			goto done;
>  		}
>  	} else {
> -		if (stash_working_tree(info, argv)) {
> +		if (stash_working_tree(info, argv, prefix)) {
>  			printf_ln("Cannot save the current worktree state");
>  			ret = -1;
>  			goto done;
> -- 
> 2.18.0.573.g56500d98f
> 
