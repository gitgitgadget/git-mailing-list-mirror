Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B4D1200B9
	for <e@80x24.org>; Sun,  6 May 2018 17:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751777AbeEFRuT (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 13:50:19 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:20086 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751751AbeEFRuS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 13:50:18 -0400
Received: from [192.168.2.201] ([92.22.23.119])
        by smtp.talktalk.net with SMTP
        id FNnbfh1dx51uyFNnbf76j1; Sun, 06 May 2018 18:50:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1525629016;
        bh=2tlT9ca5BEZwY8DsfN9BkZ7MPlHeH6Rr1VHJ8Tp516Y=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=k7dlI8DgGF3+cAuFAbh7lcYLw9d+9rpBPdSxV3G5Fls+aItMSCeHGjhUn+GrfpytS
         rPCNi1xHuy/L/sqTaC+k74tnhJ5Oh8iVPwG/NeH6IjYewmdTVGHy1G5zKW82mKNo+N
         6J09gtVIoDYw9Uygq0nfiioLWcrl8rIbhB2DCqh8=
X-Originating-IP: [92.22.23.119]
X-Spam: 0
X-OAuthority: v=2.3 cv=d9PbNyrE c=1 sm=1 tr=0 a=oWXjcmuSLv9+fGSLdn2kqg==:117
 a=oWXjcmuSLv9+fGSLdn2kqg==:17 a=IkcTkHD0fZMA:10 a=OcQh-2bLDzu3KsP1U74A:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 4/4] rebase --skip: clean up commit message after a
 failed fixup/squash
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com>
 <cover.1524862093.git.johannes.schindelin@gmx.de>
 <08609b5f2d5bc7f3f6d010088db4b58695dfbd64.1524862093.git.johannes.schindelin@gmx.de>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <4bd08893-52b4-3a01-d546-4884e2762670@talktalk.net>
Date:   Sun, 6 May 2018 18:50:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <08609b5f2d5bc7f3f6d010088db4b58695dfbd64.1524862093.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIp/IxNgiWAW2Y7Mw4laqe9+ffiO6R/PV6FaCMeGv6VMutPkv15Uc3PRtfiiv0D0x3RsH95/V4F/iHYHylhTWXy3ylFDHnzZ2K6h1a5iiTLlWIIVtLog
 VtPmBt9sYkPZMmdqhMnGoLXaWCGMiXOxtMxZFMaTMPfaFtu4DXwueLV7B18wDMDi0NF3LFU8My9MfifibX8wJT1Apm0OpneS+4SCn1iuko4HuVFiEjCI8zYK
 Kmu4aTQn+Xf3JP8z4sWx4baTK+tsfv0YE3MAF4UMnenzqKsQ8rMVKNhQ4t+ZbBW4lUEe1czdfIXzXp1CdqyThT9ytAu0tZmOiWvHTyYmjIWMIDo+gvjAPuWx
 6hGF0kqy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes, sorry it's taken me a while to look at this. I think it
mostly makes sense to me, the code is well documented. I've got one
comment below

On 27/04/18 21:48, Johannes Schindelin wrote:
> 
> During a series of fixup/squash commands, the interactive rebase builds
> up a commit message with comments. This will be presented to the user in
> the editor if at least one of those commands was a `squash`.
> 
> In any case, the commit message will be cleaned up eventually, removing
> all those intermediate comments, in the final step of such a
> fixup/squash chain.
> 
> However, if the last fixup/squash command in such a chain fails with
> merge conflicts, and if the user then decides to skip it (or resolve it
> to a clean worktree and then continue the rebase), the current code
> fails to clean up the commit message.
> 
> This commit fixes that behavior.
> 
> The fix is quite a bit more involved than meets the eye because it is
> not only about the question whether we are `git rebase --skip`ing a
> fixup or squash. It is also about removing the skipped fixup/squash's
> commit message from the accumulated commit message. And it is also about
> the question whether we should let the user edit the final commit
> message or not ("Was there a squash in the chain *that was not
> skipped*?").
> 
> For example, in this case we will want to fix the commit message, but
> not open it in an editor:
> 
> 	pick	<- succeeds
> 	fixup	<- succeeds
> 	squash	<- fails, will be skipped
> 
> This is where the newly-introduced `current-fixups` file comes in real
> handy. A quick look and we can determine whether there was a non-skipped
> squash. We only need to make sure to keep it up to date with respect to
> skipped fixup/squash commands. As a bonus, we can even avoid committing
> unnecessarily, e.g. when there was only one fixup, and it failed, and
> was skipped.
> 
> To fix only the bug where the final commit message was not cleaned up
> properly, but without fixing the rest, would have been more complicated
> than fixing it all in one go, hence this commit lumps together more than
> a single concern.
> 
> For the same reason, this commit also adds a bit more to the existing
> test case for the regression we just fixed.
> 
> The diff is best viewed with --color-moved.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c                | 113 ++++++++++++++++++++++++++++++++-----
>  t/t3418-rebase-continue.sh |  35 ++++++++++--
>  2 files changed, 131 insertions(+), 17 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 56166b0d6c7..cec180714ef 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2779,19 +2779,16 @@ static int continue_single_pick(void)
>  	return run_command_v_opt(argv, RUN_GIT_CMD);
>  }
>  
> -static int commit_staged_changes(struct replay_opts *opts)
> +static int commit_staged_changes(struct replay_opts *opts,
> +				 struct todo_list *todo_list)
>  {
>  	unsigned int flags = ALLOW_EMPTY | EDIT_MSG;
> +	unsigned int final_fixup = 0, is_clean;
>  
>  	if (has_unstaged_changes(1))
>  		return error(_("cannot rebase: You have unstaged changes."));
> -	if (!has_uncommitted_changes(0)) {
> -		const char *cherry_pick_head = git_path_cherry_pick_head();
>  
> -		if (file_exists(cherry_pick_head) && unlink(cherry_pick_head))
> -			return error(_("could not remove CHERRY_PICK_HEAD"));
> -		return 0;
> -	}
> +	is_clean = !has_uncommitted_changes(0);
>  
>  	if (file_exists(rebase_path_amend())) {
>  		struct strbuf rev = STRBUF_INIT;
> @@ -2804,19 +2801,107 @@ static int commit_staged_changes(struct replay_opts *opts)
>  		if (get_oid_hex(rev.buf, &to_amend))
>  			return error(_("invalid contents: '%s'"),
>  				rebase_path_amend());
> -		if (oidcmp(&head, &to_amend))
> +		if (!is_clean && oidcmp(&head, &to_amend))
>  			return error(_("\nYou have uncommitted changes in your "
>  				       "working tree. Please, commit them\n"
>  				       "first and then run 'git rebase "
>  				       "--continue' again."));
> +		/*
> +		 * When skipping a failed fixup/squash, we need to edit the
> +		 * commit message, the current fixup list and count, and if it
> +		 * was the last fixup/squash in the chain, we need to clean up
> +		 * the commit message and if there was a squash, let the user
> +		 * edit it.
> +		 */
> +		if (is_clean && !oidcmp(&head, &to_amend) &&
> +		    opts->current_fixup_count > 0 &&
> +		    file_exists(rebase_path_stopped_sha())) {
> +			const char *p = opts->current_fixups.buf;
> +			int len = opts->current_fixups.len;
> +
> +			opts->current_fixup_count--;
> +			if (!len)
> +				BUG("Incorrect current_fixups:\n%s", p);
> +			while (len && p[len - 1] != '\n')
> +				len--;
> +			strbuf_setlen(&opts->current_fixups, len);
> +			if (write_message(p, len, rebase_path_current_fixups(),
> +					  0) < 0)
> +				return error(_("could not write file: '%s'"),
> +					     rebase_path_current_fixups());
> +
> +			/*
> +			 * If a fixup/squash in a fixup/squash chain failed, the
> +			 * commit message is already correct, no need to commit
> +			 * it again.
> +			 *
> +			 * Only if it is the final command in the fixup/squash
> +			 * chain, and only if the chain is longer than a single
> +			 * fixup/squash command (which was just skipped), do we
> +			 * actually need to re-commit with a cleaned up commit
> +			 * message.
> +			 */
> +			if (opts->current_fixup_count > 0 &&
> +			    !is_fixup(peek_command(todo_list, 0))) {
> +				final_fixup = 1;
> +				/*
> +				 * If there was not a single "squash" in the
> +				 * chain, we only need to clean up the commit
> +				 * message, no need to bother the user with
> +				 * opening the commit message in the editor.
> +				 */
> +				if (!starts_with(p, "squash ") &&
> +				    !strstr(p, "\nsquash "))
> +					flags = (flags & ~EDIT_MSG) | CLEANUP_MSG;
> +			} else if (is_fixup(peek_command(todo_list, 0))) {
> +				/*
> +				 * We need to update the squash message to skip
> +				 * the latest commit message.
> +				 */
> +				struct commit *commit;
> +				const char *path = rebase_path_squash_msg();
> +
> +				if (parse_head(&commit) ||
> +				    !(p = get_commit_buffer(commit, NULL)) ||
> +				    write_message(p, strlen(p), path, 0)) {
> +					unuse_commit_buffer(commit, p);
> +					return error(_("could not write file: "
> +						       "'%s'"), path);
> +				}

I think it should probably recreate the fixup message as well. If there
is a sequence

pick commit
fixup a
fixup b
fixup c

and 'fixup b' gets skipped then when 'fixup c' is applied the user will
be prompted to edit the message unless rebase_path_fixup_msg() exists.

Best Wishes

Phillip

> +				unuse_commit_buffer(commit, p);
> +			}
> +		}
>  
>  		strbuf_release(&rev);
>  		flags |= AMEND_MSG;
>  	}
>  
> -	if (run_git_commit(rebase_path_message(), opts, flags))
> +	if (is_clean) {
> +		const char *cherry_pick_head = git_path_cherry_pick_head();
> +
> +		if (file_exists(cherry_pick_head) && unlink(cherry_pick_head))
> +			return error(_("could not remove CHERRY_PICK_HEAD"));
> +		if (!final_fixup)
> +			return 0;
> +	}
> +
> +	if (run_git_commit(final_fixup ? NULL : rebase_path_message(),
> +			   opts, flags))
>  		return error(_("could not commit staged changes."));
>  	unlink(rebase_path_amend());
> +	if (final_fixup) {
> +		unlink(rebase_path_fixup_msg());
> +		unlink(rebase_path_squash_msg());
> +	}
> +	if (opts->current_fixup_count > 0) {
> +		/*
> +		 * Whether final fixup or not, we just cleaned up the commit
> +		 * message...
> +		 */
> +		unlink(rebase_path_current_fixups());
> +		strbuf_reset(&opts->current_fixups);
> +		opts->current_fixup_count = 0;
> +	}
>  	return 0;
>  }
>  
> @@ -2828,14 +2913,16 @@ int sequencer_continue(struct replay_opts *opts)
>  	if (read_and_refresh_cache(opts))
>  		return -1;
>  
> +	if (read_populate_opts(opts))
> +		return -1;
>  	if (is_rebase_i(opts)) {
> -		if (commit_staged_changes(opts))
> +		if ((res = read_populate_todo(&todo_list, opts)))
> +			goto release_todo_list;
> +		if (commit_staged_changes(opts, &todo_list))
>  			return -1;
>  	} else if (!file_exists(get_todo_path(opts)))
>  		return continue_single_pick();
> -	if (read_populate_opts(opts))
> -		return -1;
> -	if ((res = read_populate_todo(&todo_list, opts)))
> +	else if ((res = read_populate_todo(&todo_list, opts)))
>  		goto release_todo_list;
>  
>  	if (!is_rebase_i(opts)) {
> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> index 3874f187246..03bf1b8a3b3 100755
> --- a/t/t3418-rebase-continue.sh
> +++ b/t/t3418-rebase-continue.sh
> @@ -88,14 +88,14 @@ test_expect_success 'rebase passes merge strategy options correctly' '
>  	git rebase --continue
>  '
>  
> -test_expect_failure '--skip after failed fixup cleans commit message' '
> +test_expect_success '--skip after failed fixup cleans commit message' '
>  	test_when_finished "test_might_fail git rebase --abort" &&
>  	git checkout -b with-conflicting-fixup &&
>  	test_commit wants-fixup &&
>  	test_commit "fixup! wants-fixup" wants-fixup.t 1 wants-fixup-1 &&
>  	test_commit "fixup! wants-fixup" wants-fixup.t 2 wants-fixup-2 &&
>  	test_commit "fixup! wants-fixup" wants-fixup.t 3 wants-fixup-3 &&
> -	test_must_fail env FAKE_LINES="1 fixup 2 fixup 4" \
> +	test_must_fail env FAKE_LINES="1 fixup 2 squash 4" \
>  		git rebase -i HEAD~4 &&
>  
>  	: now there is a conflict, and comments in the commit message &&
> @@ -103,11 +103,38 @@ test_expect_failure '--skip after failed fixup cleans commit message' '
>  	grep "fixup! wants-fixup" out &&
>  
>  	: skip and continue &&
> -	git rebase --skip &&
> +	echo "cp \"\$1\" .git/copy.txt" | write_script copy-editor.sh &&
> +	(test_set_editor "$PWD/copy-editor.sh" && git rebase --skip) &&
> +
> +	: the user should not have had to edit the commit message &&
> +	test_path_is_missing .git/copy.txt &&
>  
>  	: now the comments in the commit message should have been cleaned up &&
>  	git show HEAD >out &&
> -	! grep "fixup! wants-fixup" out
> +	! grep "fixup! wants-fixup" out &&
> +
> +	: now, let us ensure that "squash" is handled correctly &&
> +	git reset --hard wants-fixup-3 &&
> +	test_must_fail env FAKE_LINES="1 squash 4 squash 2 squash 4" \
> +		git rebase -i HEAD~4 &&
> +
> +	: the first squash failed, but there are two more in the chain &&
> +	(test_set_editor "$PWD/copy-editor.sh" &&
> +	 test_must_fail git rebase --skip) &&
> +
> +	: not the final squash, no need to edit the commit message &&
> +	test_path_is_missing .git/copy.txt &&
> +
> +	: The first squash was skipped, therefore: &&
> +	git show HEAD >out &&
> +	test_i18ngrep "# This is a combination of 2 commits" out &&
> +
> +	(test_set_editor "$PWD/copy-editor.sh" && git rebase --skip) &&
> +	git show HEAD >out &&
> +	test_i18ngrep ! "# This is a combination" out &&
> +
> +	: Final squash failed, but there was still a squash &&
> +	test_i18ngrep "# This is a combination of 2 commits" .git/copy.txt
>  '
>  
>  test_expect_success 'setup rerere database' '
> 

