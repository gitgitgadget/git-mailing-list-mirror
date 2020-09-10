Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A79C43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 21:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95ED2221E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 21:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRUbK9It"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgIJVOK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731103AbgIJO2b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 10:28:31 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57401C06179F
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 07:16:37 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e16so6926704wrm.2
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 07:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PAMVhQCroxt7sJ7DQ+qBNHp1TYcjee4TbqKBa47yv5U=;
        b=eRUbK9ItbJDs47qRGZHVX1heGK3xfyRtkb4qIWKwV08xGn1eUCU0LihXgNE/g/MWhr
         BWidSBIygKvUNF7K6a2ICq2oaJJc0MGDgU8FJdhCM882Ljm2eO0dOqTCHWsKR1pn2gGH
         jzaC9B89bmQuba9DRspfnHuS5/br3yDNvlY7h+TMQuWtXYshT6ZXzUzIxKx3MqFMZ80K
         3/S0+2zPLalP7lG0mp9Phh7Xt6NGU3aznHoN6cuhe0bGn6D6JvXQHOHdJysgRtO+6DAr
         G3apGkQaoMkFh/AYy7iX+m8eRgb3nhH5CsRvRaNqcnzWrSorThKWphytzWqGj2enN121
         I+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PAMVhQCroxt7sJ7DQ+qBNHp1TYcjee4TbqKBa47yv5U=;
        b=h8VrkKSMLBxDIolnUPkr/o3uqdRLmyHod5lXg4PD2Y60u55/kZGwkOYwIrVUcBZ4yj
         dJ4TpwlmZPUyHcBZRlse2QJQZjh7eaT3uGhGEIGMkpBWf4LKzP4UAEQyUTTuB8i6kucv
         ELEbv9NKZ1sWhqcxyt939q+a6huXHKafmIRXJAMpKkbJfsUr+ZQAKv1YvSV9c100bMD0
         PE5uWzub8RPs4VxYbpCgVXk/4rRc73szPWXe2YQv59zP48mtV+n+xm3cbImS/Xe95Sr3
         wUIzLIp8HzD0IBWvvpnlXBHPzy3c+ezW+lns/z+2SOTmEA3Il/jaSgoCPg2RPIILT4HD
         dYvA==
X-Gm-Message-State: AOAM530XZsBbdj2npfUx4fy+8ByBw2VmXiNlRCyVBzKtj6K1AJJkuj8/
        SumhfDUaO8R/ESBmVGp8uUVkiGFfBEQ=
X-Google-Smtp-Source: ABdhPJzLpAoVkbuLmgCfIv5+d95V+7bNuoh4QzGeuQv8/Mm0kL1AoDH0cAnln1ADMrrYBfwY6Tir9Q==
X-Received: by 2002:a5d:6305:: with SMTP id i5mr8763027wru.337.1599747393933;
        Thu, 10 Sep 2020 07:16:33 -0700 (PDT)
Received: from [192.168.1.240] (151.252.189.80.dyn.plus.net. [80.189.252.151])
        by smtp.gmail.com with ESMTPSA id 70sm4039009wme.15.2020.09.10.07.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 07:16:33 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 9/9] run_commit_hook: take strvec instead of varargs
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20200909004939.1942347-1-emilyshaffer@google.com>
 <20200909004939.1942347-10-emilyshaffer@google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <6ed77ee3-4d75-9ef9-0621-13a056e8ca14@gmail.com>
Date:   Thu, 10 Sep 2020 15:16:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200909004939.1942347-10-emilyshaffer@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily

On 09/09/2020 01:49, Emily Shaffer wrote:
> Taking varargs in run_commit_hook() led to some bizarre patterns, like
> callers using two string variables (which may or may not be filled) to
> express different argument lists for the commit hooks. Because
> run_commit_hook() no longer needs to call a variadic function for the
> hook run itself, we can use strvec to make the calling code more
> conventional.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>   builtin/commit.c | 46 +++++++++++++++++++++++-----------------------
>   builtin/merge.c  | 20 ++++++++++++++++----
>   commit.c         | 13 ++-----------
>   commit.h         |  5 +++--
>   sequencer.c      | 15 ++++++++-------
>   5 files changed, 52 insertions(+), 47 deletions(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index a19c6478eb..f029d4f5ac 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -691,8 +691,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>   	struct strbuf committer_ident = STRBUF_INIT;
>   	int committable;
>   	struct strbuf sb = STRBUF_INIT;
> -	const char *hook_arg1 = NULL;
> -	const char *hook_arg2 = NULL;
> +	struct strvec hook_args = STRVEC_INIT;
>   	int clean_message_contents = (cleanup_mode != COMMIT_MSG_CLEANUP_NONE);
>   	int old_display_comment_prefix;
>   	int merge_contains_scissors = 0;
> @@ -700,7 +699,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>   	/* This checks and barfs if author is badly specified */
>   	determine_author_info(author_ident);
>   
> -	if (!no_verify && run_commit_hook(use_editor, index_file, "pre-commit", NULL))
> +	if (!no_verify && run_commit_hook(use_editor, index_file, "pre-commit",
> +					  &hook_args))
>   		return 0;
>   
>   	if (squash_message) {
> @@ -722,27 +722,28 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>   		}
>   	}
>   
> +	strvec_push(&hook_args, git_path_commit_editmsg());

This is a long way from the call where we use hook_args. With the 
variadic interface it is clear by looking at the call to 
run_commit_hook() what the first argument is and that is always the same.

>   	if (have_option_m && !fixup_message) {
>   		strbuf_addbuf(&sb, &message);
> -		hook_arg1 = "message";
> +		strvec_push(&hook_args, "message");
>   	} else if (logfile && !strcmp(logfile, "-")) {
>   		if (isatty(0))
>   			fprintf(stderr, _("(reading log message from standard input)\n"));
>   		if (strbuf_read(&sb, 0, 0) < 0)
>   			die_errno(_("could not read log from standard input"));
> -		hook_arg1 = "message";
> +		strvec_push(&hook_args, "message");
>   	} else if (logfile) {
>   		if (strbuf_read_file(&sb, logfile, 0) < 0)
>   			die_errno(_("could not read log file '%s'"),
>   				  logfile);
> -		hook_arg1 = "message";
> +		strvec_push(&hook_args, "message");
>   	} else if (use_message) {
>   		char *buffer;
>   		buffer = strstr(use_message_buffer, "\n\n");
>   		if (buffer)
>   			strbuf_addstr(&sb, skip_blank_lines(buffer + 2));
> -		hook_arg1 = "commit";
> -		hook_arg2 = use_message;
> +		strvec_pushl(&hook_args, "commit", use_message, NULL);
>   	} else if (fixup_message) {
>   		struct pretty_print_context ctx = {0};
>   		struct commit *commit;
> @@ -754,7 +755,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>   				      &sb, &ctx);
>   		if (have_option_m)
>   			strbuf_addbuf(&sb, &message);
> -		hook_arg1 = "message";
> +		strvec_push(&hook_args, "message");
>   	} else if (!stat(git_path_merge_msg(the_repository), &statbuf)) {
>   		size_t merge_msg_start;
>   
> @@ -765,9 +766,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>   		if (!stat(git_path_squash_msg(the_repository), &statbuf)) {
>   			if (strbuf_read_file(&sb, git_path_squash_msg(the_repository), 0) < 0)
>   				die_errno(_("could not read SQUASH_MSG"));
> -			hook_arg1 = "squash";
> +			strvec_push(&hook_args, "squash");
>   		} else
> -			hook_arg1 = "merge";
> +			strvec_push(&hook_args, "merge");
>   
>   		merge_msg_start = sb.len;
>   		if (strbuf_read_file(&sb, git_path_merge_msg(the_repository), 0) < 0)
> @@ -781,11 +782,11 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>   	} else if (!stat(git_path_squash_msg(the_repository), &statbuf)) {
>   		if (strbuf_read_file(&sb, git_path_squash_msg(the_repository), 0) < 0)
>   			die_errno(_("could not read SQUASH_MSG"));
> -		hook_arg1 = "squash";
> +		strvec_push(&hook_args, "squash");
>   	} else if (template_file) {
>   		if (strbuf_read_file(&sb, template_file, 0) < 0)
>   			die_errno(_("could not read '%s'"), template_file);
> -		hook_arg1 = "template";
> +		strvec_push(&hook_args, "template");
>   		clean_message_contents = 0;
>   	}
>   
> @@ -794,11 +795,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>   	 * just set the argument(s) to the prepare-commit-msg hook.
>   	 */
>   	else if (whence == FROM_MERGE)
> -		hook_arg1 = "merge";
> -	else if (is_from_cherry_pick(whence) || whence == FROM_REBASE_PICK) {
> -		hook_arg1 = "commit";
> -		hook_arg2 = "CHERRY_PICK_HEAD";
> -	}
> +		strvec_push(&hook_args, "merge");
> +	else if (is_from_cherry_pick(whence) || whence == FROM_REBASE_PICK)
> +		strvec_pushl(&hook_args, "commit", "CHERRY_PICK_HEAD", NULL);
>   
>   	if (squash_message) {
>   		/*
> @@ -806,8 +805,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>   		 * then we're possibly hijacking other commit log options.
>   		 * Reset the hook args to tell the real story.
>   		 */
> -		hook_arg1 = "message";
> -		hook_arg2 = "";
> +		strvec_clear(&hook_args);
> +		strvec_pushl(&hook_args, git_path_commit_editmsg(), "message", NULL);

It's a shame we have to clear the strvec and remember to re-add 
git_path_commit_editmsg() here.

>   	}
>   
>   	s->fp = fopen_for_writing(git_path_commit_editmsg());
> @@ -1001,8 +1000,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>   		return 0;
>   	}
>   
> -	if (run_commit_hook(use_editor, index_file, "prepare-commit-msg",
> -			    git_path_commit_editmsg(), hook_arg1, hook_arg2, NULL))
> +	if (run_commit_hook(use_editor, index_file, "prepare-commit-msg", &hook_args))
>   		return 0;
>   
>   	if (use_editor) {
> @@ -1017,8 +1015,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>   		strvec_clear(&env);
>   	}
>   
> +	strvec_clear(&hook_args);
> +	strvec_push(&hook_args, git_path_commit_editmsg());
>   	if (!no_verify &&
> -	    run_commit_hook(use_editor, index_file, "commit-msg", git_path_commit_editmsg(), NULL)) {
> +	    run_commit_hook(use_editor, index_file, "commit-msg", &hook_args)) {
>   		return 0;
>   	}
>   
> diff --git a/builtin/merge.c b/builtin/merge.c
> index c1a9d0083d..863c9039a3 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -821,10 +821,14 @@ static void write_merge_heads(struct commit_list *);
>   static void prepare_to_commit(struct commit_list *remoteheads)
>   {
>   	struct strbuf msg = STRBUF_INIT;
> +	struct strvec hook_args = STRVEC_INIT;
> +	struct strbuf hook_name = STRBUF_INIT;

As far as I can see hook_name is never used except to free it at the end.

>   	const char *index_file = get_index_file();
>   
> -	if (!no_verify && run_commit_hook(0 < option_edit, index_file, "pre-merge-commit", NULL))
> +	if (!no_verify && run_commit_hook(0 < option_edit, index_file,
> +					  "pre-merge-commit", &hook_args))
>   		abort_commit(remoteheads, NULL);
> +
>   	/*
>   	 * Re-read the index as pre-merge-commit hook could have updated it,
>   	 * and write it out as a tree.  We must do this before we invoke
> @@ -832,6 +836,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
>   	 */
>   	if (hook_exists("pre-merge-commit"))
>   		discard_cache();
> +
>   	read_cache_from(index_file);
>   	strbuf_addbuf(&msg, &merge_msg);
>   	if (squash)
> @@ -851,17 +856,22 @@ static void prepare_to_commit(struct commit_list *remoteheads)
>   		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
>   	write_merge_heads(remoteheads);
>   	write_file_buf(git_path_merge_msg(the_repository), msg.buf, msg.len);
> +
> +	strvec_clear(&hook_args);
> +	strvec_pushl(&hook_args, git_path_merge_msg(the_repository), "merge", NULL);
>   	if (run_commit_hook(0 < option_edit, get_index_file(), "prepare-commit-msg",
> -			    git_path_merge_msg(the_repository), "merge", NULL))
> +			    &hook_args))
>   		abort_commit(remoteheads, NULL);
> +
>   	if (0 < option_edit) {
>   		if (launch_editor(git_path_merge_msg(the_repository), NULL, NULL))
>   			abort_commit(remoteheads, NULL);
>   	}
>   
> +	strvec_clear(&hook_args);
> +	strvec_push(&hook_args, git_path_merge_msg(the_repository));
>   	if (!no_verify && run_commit_hook(0 < option_edit, get_index_file(),
> -					  "commit-msg",
> -					  git_path_merge_msg(the_repository), NULL))
> +					  "commit-msg", &hook_args))
>   		abort_commit(remoteheads, NULL);
>   
>   	read_merge_msg(&msg);
> @@ -871,6 +881,8 @@ static void prepare_to_commit(struct commit_list *remoteheads)
>   	strbuf_release(&merge_msg);
>   	strbuf_addbuf(&merge_msg, &msg);
>   	strbuf_release(&msg);
> +	strbuf_release(&hook_name);
> +	strvec_clear(&hook_args);
>   }
>   
>   static int merge_trivial(struct commit *head, struct commit_list *remoteheads)
> diff --git a/commit.c b/commit.c
> index c7a243e848..726407152c 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1629,12 +1629,9 @@ size_t ignore_non_trailer(const char *buf, size_t len)
>   }
>   
>   int run_commit_hook(int editor_is_used, const char *index_file,
> -		    const char *name, ...)
> +		    const char *name, struct strvec *args)
>   {
>   	struct strvec hook_env = STRVEC_INIT;
> -	va_list args;
> -	const char *arg;
> -	struct strvec hook_args = STRVEC_INIT;
>   	struct strbuf hook_name = STRBUF_INIT;
>   	int ret;
>   
> @@ -1648,14 +1645,8 @@ int run_commit_hook(int editor_is_used, const char *index_file,
>   	if (!editor_is_used)
>   		strvec_push(&hook_env, "GIT_EDITOR=:");
>   
> -	va_start(args, name);
> -	while ((arg = va_arg(args, const char *)))
> -		strvec_push(&hook_args, arg);
> -	va_end(args);
> -
> -	ret = run_hooks(hook_env.v, &hook_name, &hook_args);
> +	ret = run_hooks(hook_env.v, &hook_name, args);
>   	strvec_clear(&hook_env);
> -	strvec_clear(&hook_args);
>   	strbuf_release(&hook_name);
>   
>   	return ret;
> diff --git a/commit.h b/commit.h
> index e901538909..978da3c3e0 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -9,6 +9,7 @@
>   #include "string-list.h"
>   #include "pretty.h"
>   #include "commit-slab.h"
> +#include "strvec.h"
>   
>   #define COMMIT_NOT_FROM_GRAPH 0xFFFFFFFF
>   #define GENERATION_NUMBER_INFINITY 0xFFFFFFFF
> @@ -353,7 +354,7 @@ void verify_merge_signature(struct commit *commit, int verbose,
>   int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused);
>   int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void *unused);
>   
> -LAST_ARG_MUST_BE_NULL
> -int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...);
> +int run_commit_hook(int editor_is_used, const char *index_file,
> +		    const char *name, struct strvec *args);
>   
>   #endif /* COMMIT_H */
> diff --git a/sequencer.c b/sequencer.c
> index cc3f8fa88e..5dd4b134d6 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1124,22 +1124,23 @@ static int run_prepare_commit_msg_hook(struct repository *r,
>   				       const char *commit)
>   {
>   	int ret = 0;
> -	const char *name, *arg1 = NULL, *arg2 = NULL;
> +	struct strvec args = STRVEC_INIT;
> +	const char *name = git_path_commit_editmsg();
>   
> -	name = git_path_commit_editmsg();
> +	strvec_push(&args, name);

I think you could drop name altogether and just pass 
git_path_commit_editmsg() instead.

>   	if (write_message(msg->buf, msg->len, name, 0))
>   		return -1;
>   
>   	if (commit) {
> -		arg1 = "commit";
> -		arg2 = commit;
> +		strvec_push(&args, "commit");
> +		strvec_push(&args, commit);

Complete nit pick but the other conversions all used strvec_pushl() 
rather than two strvec_push() calls.

I don't have a strong opinion about these changes (though I'm not 
particularly enthusiastic). Having to push the arguments in order is not 
particularly convenient and the use of strvec_pushl() means we are 
replacing a small number of variadic calls to run_commit_hook() with a 
larger number of calls to a different variadic interface.

Best Wishes

Phillip

>   	} else {
> -		arg1 = "message";
> +		strvec_push(&args, "message");
>   	}
> -	if (run_commit_hook(0, r->index_file, "prepare-commit-msg", name,
> -			    arg1, arg2, NULL))
> +	if (run_commit_hook(0, r->index_file, "prepare-commit-msg", &args))
>   		ret = error(_("'prepare-commit-msg' hook failed"));
>   
> +	strvec_clear(&args);
>   	return ret;
>   }
>   
> 
