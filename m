Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95A511F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 10:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392432AbfJXKPS (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 06:15:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54573 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392115AbfJXKPS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 06:15:18 -0400
Received: by mail-wm1-f65.google.com with SMTP id g7so2138598wmk.4
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 03:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dp0UZw4v5C1lU1jkBgl88vpA5JJgGlT9if8g4TBxqfs=;
        b=Uvv2rpMPBp8Im0tOSRWgniPHVmAORc1g7wglMcpXiBCJBEggFxfevdD/IA9H/AR5fp
         cOp6bg1Azu4rZ7rutg/1XpxGq6LmzjEClUFZMq4BtcKP2wwQwVHr5Ty6hWUH44lGdOdZ
         wnQBn+eOiEil6JsF4lP92kluTPve9ih49QWl0Sk5BPc82uSUHPT8QVumrxA+CbpLM3Dg
         e/4JchNtrrzzK2bzPeAgozkg4vQT5tnP9vfyIB70sjm2roCFliagKxwrG2seWrDtCIGi
         yzsSnWI8/vYm9zyZpBOrMiUwpuCORseMy4SO8Qoz84PFlb9YOhtIVhmBcrWCoUHmJmmH
         MA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dp0UZw4v5C1lU1jkBgl88vpA5JJgGlT9if8g4TBxqfs=;
        b=lIHI3YvjdUluYa6RTmRKulQPaS8zg4/s53OkplMzS/zs32XsLfZjqnEi3sqGLnxijN
         T/2CoT870++Akg38p14JSOVFwdRSUfXPpYReLliOU40tS8r0U7I/Q6ppUUwbCeO00US4
         0reelT/debCKSfw5sDpSZ8ozkmBtsdtXxMsWtKwumFFwOAX97/RHJM/BwuhRAd8Js/WY
         2J05sPwV3HnwpFlB6YRNu3m5hVn1fllq02VJwtgPGsxVwHtzBmXzhEz/08tWKENLZMBA
         xDdolR+dBQeZQyzh2RmBkwz56fKdtsWPecBUqaR3oFBf/JbG2VIbhy1yS7KH/21+AuTY
         Vg7A==
X-Gm-Message-State: APjAAAVmKao2734d8K2adqWTuGKS6spwb7pE5B5uxqj/Q5GVwvcbGIL/
        GW283hGZcGuRznxhyEsSdGA=
X-Google-Smtp-Source: APXvYqz+2jsy7CSzLn27kZ9vpHQe53at9qI7fIQaquSqwCYSzHcXFLIdvBcxusDqicBY9vSoH/rqzQ==
X-Received: by 2002:a1c:453:: with SMTP id 80mr4205892wme.5.1571912115000;
        Thu, 24 Oct 2019 03:15:15 -0700 (PDT)
Received: from [192.168.2.201] (host-92-22-20-250.as13285.net. [92.22.20.250])
        by smtp.googlemail.com with ESMTPSA id 62sm9692781wre.38.2019.10.24.03.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2019 03:15:14 -0700 (PDT)
Subject: Re: [PATCH 3/3] commit: give correct advice for empty commit during a
 rebase
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.417.git.1571787022.gitgitgadget@gmail.com>
 <0d168b4a75c65e786f4b14f5da723957c32fa390.1571787022.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <9d550cd9-08a2-eee5-7d7f-63678285accc@gmail.com>
Date:   Thu, 24 Oct 2019 11:15:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <0d168b4a75c65e786f4b14f5da723957c32fa390.1571787022.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 23/10/2019 00:30, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> In dcb500dc16c (cherry-pick/revert: advise using --skip, 2019-07-02),
> `git commit` learned to suggest to run `git cherry-pick --skip` when
> trying to cherry-pick an empty patch.
> 
> However, it was overlooked that there are more conditions than just a
> `git cherry-pick` when this advice is printed (which originally
> suggested the neutral `git reset`): the same can happen during a rebase.
> 
> Let's suggest the correct command, even during a rebase.
> 
> While at it, we adjust more places in `builtin/commit.c` that
> incorrectly assumed that the presence of a `CHERRY_PICK_HEAD` meant that
> surely this must be a `cherry-pick` in progress.
> 
> Note: we take pains to handle the situation when a user runs a `git
> cherry-pick` _during_ a rebase. This is quite valid (e.g. in an `exec`
> line in an interactive rebase). On the other hand, it is not possible to
> run a rebase during a cherry-pick, meaning: if both `rebase-merge/` and
> `sequencer/` exist, we still want to advise to use `git cherry-pick
> --skip`.

Thanks for working on this. It's unfortunate that rebase does not remove
CHERRY_PICK_HEAD for empty commits as it does if the commit is not
empty. I think this is because 'rebase --continue' will skip an empty
commit so the user _has_ to run 'git commit' manually to keep it. If it
had been designed so that 'rebase --continue' kept the empty commit and
'rebase --skip' skipped it then we would not have this problem but it's
a bit late to worry about that now.

I don't this patch can distinguish between an empty cherry-pick
performed by the user while a rebase is in progress and an empty pick
performed by rebase as both create CHERRY_PICK_HEAD while
.git/rebase-merge exists. It seems to assume that CHERRY_PICK_HEAD was
created by rebase and prints advise based on that which may or may not
be the correct. I think we could distinguish the two by checking if
CHERRY_PICK_HEAD matches .git/rebase-merge/stopped-sha or REBASE_HEAD.

Best Wishes


Phillip

> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/commit.c       | 33 ++++++++++++++++++++++++---------
>  t/t3403-rebase-skip.sh |  9 +++++++++
>  2 files changed, 33 insertions(+), 9 deletions(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index e588bc6ad3..2beae13620 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -59,6 +59,9 @@ N_("The previous cherry-pick is now empty, possibly due to conflict resolution.\
>  "    git commit --allow-empty\n"
>  "\n");
>  
> +static const char empty_rebase_advice[] =
> +N_("Otherwise, please use 'git rebase --skip'\n");
> +
>  static const char empty_cherry_pick_advice_single[] =
>  N_("Otherwise, please use 'git cherry-pick --skip'\n");
>  
> @@ -122,7 +125,7 @@ static enum commit_msg_cleanup_mode cleanup_mode;
>  static const char *cleanup_arg;
>  
>  static enum commit_whence whence;
> -static int sequencer_in_use;
> +static int sequencer_in_use, rebase_in_progress;
>  static int use_editor = 1, include_status = 1;
>  static int have_option_m;
>  static struct strbuf message = STRBUF_INIT;
> @@ -183,6 +186,8 @@ static void determine_whence(struct wt_status *s)
>  		whence = FROM_CHERRY_PICK;
>  		if (file_exists(git_path_seq_dir()))
>  			sequencer_in_use = 1;
> +		if (file_exists(git_path_rebase_merge_dir()))
> +			rebase_in_progress = 1;
>  	}
>  	else
>  		whence = FROM_COMMIT;
> @@ -453,8 +458,11 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
>  	if (whence != FROM_COMMIT) {
>  		if (whence == FROM_MERGE)
>  			die(_("cannot do a partial commit during a merge."));
> -		else if (whence == FROM_CHERRY_PICK)
> +		else if (whence == FROM_CHERRY_PICK) {
> +			if (rebase_in_progress && !sequencer_in_use)
> +				die(_("cannot do a partial commit during a rebase."));
>  			die(_("cannot do a partial commit during a cherry-pick."));
> +		}
>  	}
>  
>  	if (list_paths(&partial, !current_head ? NULL : "HEAD", &pathspec))
> @@ -950,10 +958,12 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  			fputs(_(empty_amend_advice), stderr);
>  		else if (whence == FROM_CHERRY_PICK) {
>  			fputs(_(empty_cherry_pick_advice), stderr);
> -			if (!sequencer_in_use)
> -				fputs(_(empty_cherry_pick_advice_single), stderr);
> -			else
> +			if (sequencer_in_use)
>  				fputs(_(empty_cherry_pick_advice_multi), stderr);
> +			else if (rebase_in_progress)
> +				fputs(_(empty_rebase_advice), stderr);
> +			else
> +				fputs(_(empty_cherry_pick_advice_single), stderr);
>  		}
>  		return 0;
>  	}
> @@ -1156,8 +1166,11 @@ static int parse_and_validate_options(int argc, const char *argv[],
>  	if (amend && whence != FROM_COMMIT) {
>  		if (whence == FROM_MERGE)
>  			die(_("You are in the middle of a merge -- cannot amend."));
> -		else if (whence == FROM_CHERRY_PICK)
> +		else if (whence == FROM_CHERRY_PICK) {
> +			if (rebase_in_progress && !sequencer_in_use)
> +				die(_("You are in the middle of a rebase -- cannot amend."));
>  			die(_("You are in the middle of a cherry-pick -- cannot amend."));
> +		}
>  	}
>  	if (fixup_message && squash_message)
>  		die(_("Options --squash and --fixup cannot be used together"));
> @@ -1628,9 +1641,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  			reduce_heads_replace(&parents);
>  	} else {
>  		if (!reflog_msg)
> -			reflog_msg = (whence == FROM_CHERRY_PICK)
> -					? "commit (cherry-pick)"
> -					: "commit";
> +			reflog_msg = (whence != FROM_CHERRY_PICK)
> +					? "commit"
> +					: rebase_in_progress && !sequencer_in_use
> +					? "commit (rebase)"
> +					: "commit (cherry-pick)";
>  		commit_list_insert(current_head, &parents);
>  	}
>  
> diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
> index 1f5122b632..77b03ac49f 100755
> --- a/t/t3403-rebase-skip.sh
> +++ b/t/t3403-rebase-skip.sh
> @@ -76,4 +76,13 @@ test_expect_success 'moved back to branch correctly' '
>  
>  test_debug 'gitk --all & sleep 1'
>  
> +test_expect_success 'correct advice upon empty commit' '
> +	git checkout -b rebase-skip &&
> +	test_commit a1 &&
> +	test_tick &&
> +	git commit --amend -m amended --no-edit &&
> +	test_must_fail git rebase -m --onto a1 HEAD^ 2>err &&
> +	test_i18ngrep "git rebase --skip" err
> +'
> +
>  test_done
> 

