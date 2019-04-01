Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC90820248
	for <e@80x24.org>; Mon,  1 Apr 2019 08:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731912AbfDAI2s (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 04:28:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40580 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfDAI2s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 04:28:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id z24so10311545wmi.5
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 01:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ncqVRP19veZ0HgRIX6A4iitDMr4rtJ0BWFTE21nwwDA=;
        b=ajKVFdUjH9zMSuNBtCadAxL+ycnEp5z+FkSQOV/z9yOMPR1rl2U09A7nIBxv3f9KXf
         oF4upCc8PxHVacgXXh4d5q6Pj16T8gDQ9h1vh6Q0x7p0lZAqDobaa/o3EbSuiQebXXCU
         rVaigp9uWnI/i8XHcORQxvtkkKoE5NmnmgRVVziqD+OP7eyLO6bvaGhLl7LlrAWia8GD
         qzDl6DWly/KFJnDJDXQ63q5Uptjs2QEYaSy8yBy1Mt5KJc+ekKOwtpZs+X5Ee1X0dwBE
         c9sXdga6+gnN1Pc3qnlQEfeIcIbcad2AMxsNNRlNh7A8LpQGdmt/z1Q3W8tR+kW5J5SY
         MR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ncqVRP19veZ0HgRIX6A4iitDMr4rtJ0BWFTE21nwwDA=;
        b=TXJllkd2SAfmdIsXk25SnCHOts0BCgILN7dr3YopZwW23yFMFQ8lEZzVK9acnQNfcq
         qk1LtjDkbb7FypMQOGx4XayyaEBjPxJh94La78JAixmmQPEDH5Lwwf6Rj4xXC6jXtEp6
         iPksgIaIRZJj/jmE0MTDxId2iCrNh3JhjZ5Dj3asubC4H/2vEDhjCfb1VzftUeFlVpTE
         XuNEL/o4pXegxU3lGSsXaJ20bVptDAQwBaZZ/D+5iiswPLnD7WjwjwsmQLxdJ/pE2nsj
         cBYSXePNOLwpXwbiYKDbPWnuxfIJWpx9QmyPHjsI0kPH4bmoyVvk0HbNaDtYvgpsCfy5
         q6yw==
X-Gm-Message-State: APjAAAW/S9G8fuR6J7k/RdnyisIAQB+a9zwgwQbL2lysSlEi3oxmTP72
        KND2ie3Ojmj/g7BBtkigEqY=
X-Google-Smtp-Source: APXvYqweBb9doZ8oTaDKSslSsYZ7dKxk9Pi2ZDyHk1HUw4JlqWDlqvMZ54jqsVSIGXEnMW+OaQiM3g==
X-Received: by 2002:a1c:7e10:: with SMTP id z16mr12261023wmc.117.1554107325253;
        Mon, 01 Apr 2019 01:28:45 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id r9sm8495738wmh.38.2019.04.01.01.28.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 01:28:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/2] commit/reset: try to clean up sequencer state
References: <20190329163009.493-1-phillip.wood123@gmail.com>
        <20190329163009.493-2-phillip.wood123@gmail.com>
Date:   Mon, 01 Apr 2019 17:28:43 +0900
In-Reply-To: <20190329163009.493-2-phillip.wood123@gmail.com> (Phillip Wood's
        message of "Fri, 29 Mar 2019 16:30:08 +0000")
Message-ID: <xmqq36n2yvr8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> When cherry-picking or reverting a sequence of commits and if the final
> pick/revert has conflicts and the user uses `git commit` to commit the
> conflict resolution and does not run `git cherry-pick --continue` then
> the sequencer state is left behind. This can cause problems later. In my
> case I cherry-picked a sequence of commits the last one of which I
> committed with `git commit` after resolving some conflicts, then a while
> later, on a different branch I aborted a revert which rewound my HEAD to
> the end of the cherry-pick sequence on the previous branch.

I've certainly seen this myself.  Do you use command line prompt
support to remind you of the operation in progress?  I do, and I
have a suspicion that it did not help me in this situation by
ceasing to tell me that I have leftover state files after a manual
commit of the final step that conflicted and gave control back to
me.

And detecting that we are finishing the last step and making sure
that the state files are removed does sound like the right approach
to fix it.

> diff --git a/branch.c b/branch.c
> index 28b81a7e02..9ed60081c1 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -5,6 +5,7 @@
>  #include "refs.h"
>  #include "refspec.h"
>  #include "remote.h"
> +#include "sequencer.h"
>  #include "commit.h"
>  #include "worktree.h"
>  
> @@ -339,8 +340,10 @@ void create_branch(struct repository *r,
>  
>  void remove_branch_state(struct repository *r)
>  {
> -	unlink(git_path_cherry_pick_head(r));
> -	unlink(git_path_revert_head(r));
> +	if (!unlink(git_path_cherry_pick_head(r)))
> +		sequencer_post_commit_cleanup();
> +	if (!unlink(git_path_revert_head(r)))
> +		sequencer_post_commit_cleanup();

This and the same one in builtin/commit.c feels a bit iffy.  If we
had CHERRY_PICK_HEAD or REVERT_HEAD and attempted to remove one or
the other, whether the removal succeeds or fails (perhaps a virus
scanner on Windows had the file open while we tried to unlink it,
causing the unlink() to fail), don't we want the clean-up to happen?

> @@ -1678,6 +1680,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  	if (amend && !no_post_rewrite) {
>  		commit_post_rewrite(the_repository, current_head, &oid);
>  	}
> +

This is an unrelated change.

>  	if (!quiet) {
>  		unsigned int flags = 0;
>  
> diff --git a/sequencer.c b/sequencer.c
> index 0db410d590..028699209f 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2220,6 +2220,29 @@ static ssize_t strbuf_read_file_or_whine(struct strbuf *sb, const char *path)
>  	return len;
>  }
>  
> +void sequencer_post_commit_cleanup(void)
> +{
> +	struct replay_opts opts = REPLAY_OPTS_INIT;
> +	struct strbuf buf = STRBUF_INIT;
> +	const char *eol;
> +	const char *todo_path = git_path_todo_file();
> +
> +	if (strbuf_read_file(&buf, todo_path, 0) < 0) {
> +		if (errno == ENOENT) {
> +			return;
> +		} else {
> +			error_errno("unable to open '%s'", todo_path);
> +			return;
> +		}
> +	}
> +	/* If there is only one line then we are done */
> +	eol = strchr(buf.buf, '\n');
> +	if (!eol || !eol[1])
> +		sequencer_remove_state(&opts);
> +
> +	strbuf_release(&buf);
> +}

I find this helper doing a bit too much and a bit too little at the
same time.  To reduce the iffiness I mentioned earlier, the callers
would behefit to have a helper that

 - notices the need to remove CHERRY_PICK_HEAD or REVERT_HEAD, and
   returns without doing anything if there is no need;

 - remove the *_HEAD file.

 - detect if we have dealt with the last step, and returns without
   doing any more thing if there are more to do;

 - remove the state files.

IOW, replace the existing series of two unlink() calls with a single
call to the helper.

On the other hand, the bulk of hand-rolled logic to determine if we
have processed the last step is better done in another helper
function that helps this helper, i.e.

	void sequencer_post_commit_cleanup(struct repo *r)
	{
		int need_cleanup = 0;

		if (file_exists(git_path_cherry_pick_head(r)) {
			unlink(git_path_cherry_pick_head(r));
			need_cleanup = 1;
		}
		if (file_exists(git_path_revert_head(r)) {
			unlink(git_path_revert_head(r));
			need_cleanup = 1;
		}
		if (!need_cleanup)
			return;
		if (!have_finished_the_last_pick())
			return;
		sequencer_remove_state(&opts);
	}

as that makes it easier to follow the logic of what is going on at
this level, while at the same time making the logic in the
have_finished_the_last_pick() helper easier to read by giving it a
meaningful name.
