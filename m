Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7EAEB64DA
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 11:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjF1LLN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 07:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjF1LLK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 07:11:10 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EE41FF0
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 04:11:09 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-313f3a6db22so3208038f8f.3
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 04:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687950667; x=1690542667;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T+Jbghx0NapUU1kOhJfMV9xrNgxahymTvlPbPR+TQ3Q=;
        b=qUSjAvOKoB8GAyYvCiFct8ox4H5/fxDkw9mC2+WrCZtugWLLxHCsMg0mraxEPDTxHY
         TWUemqwNZNBBoP1J+3I2TBjtz1EV3blKkDCcZ7EXO/QbhyKSFlQk1eJRM93Osem961ES
         W7NtiXCbIacb0a2HFbhHwYnUam7MZ8taYEkKUJsfcqCaAI+PBPXebukt10rcBNGP1X0J
         AVWCfIHwb3svLdcmbVlTU29DKzS3XVsJT+2smnpwOQ0d72L4jRc06h3/sCstPIrS3q/1
         EU8fqExQirCn5nvfEbYL4DjGHQoUd8GkRLSvGuMjFSwHhWPxy/FnQsP1T6QmzwdmFYzk
         Qd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687950667; x=1690542667;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+Jbghx0NapUU1kOhJfMV9xrNgxahymTvlPbPR+TQ3Q=;
        b=C7R/yPVq5WlGV3RVMyS7rtWtOuMFsazu+N+wAOay1lTlCb7o/Mo+I3iQzeu9Vr5Uc5
         qOFqAEti8aUKDq7Whg4DIXztHY50CpN700nluXw6pfVlT7S+Zp/9Y4+qd9UCcwutEnaw
         dmleBPSZpavdzSmer0KRyCtgAS9CTwd7sAdpdAltem9WyQnf6Xj9HBhLL881GN+ut50c
         s9XTVXpwte1ij/lpkMoM3pnn9Fwj1ttEXRMQyjx53AbOCa77L8ou2EU4hywZ5jYGmoI1
         nz5zAlsvedkJXgZWeZzkVs1gEr4myhE7WmtaFkwc5aSRB1zSLMwgayr9NFZ3WdW9PeQ2
         rNeA==
X-Gm-Message-State: AC+VfDxMiMzJ7BPn/ix7K9VkNB6g4Lh5XZEFyBQNDnMCtdTK+N0rob0t
        74zPnHmC7J8o88AWyrXYoY9Nf/HAmes=
X-Google-Smtp-Source: ACHHUZ7aSwrsTij7FbTKJyMZnet34AZrLHHJ/kCLMBsQoIEya/e/ax0+GLTmeTlZBu/d4KXWFbqZjw==
X-Received: by 2002:adf:d092:0:b0:30e:3da5:46e5 with SMTP id y18-20020adfd092000000b0030e3da546e5mr26063795wrh.59.1687950667252;
        Wed, 28 Jun 2023 04:11:07 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.235.211])
        by smtp.gmail.com with ESMTPSA id d13-20020a5d4f8d000000b003063db8f45bsm13032577wru.23.2023.06.28.04.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 04:11:06 -0700 (PDT)
Message-ID: <743b17ee-2c5b-be7e-70f3-76d0f9d0ff5e@gmail.com>
Date:   Wed, 28 Jun 2023 12:11:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] fix cherry-pick/revert status when doing multiple
 commits
Content-Language: en-US
To:     Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Jacob Keller <jacob.keller@gmail.com>
References: <20230627224230.1951135-1-jacob.e.keller@intel.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230627224230.1951135-1-jacob.e.keller@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jacob

This version looks good to me

Thanks for re-rolling

Phillip

On 27/06/2023 23:41, Jacob Keller wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
> 
> The status report for an in-progress cherry-pick does not show the
> current commit if the cherry-pick happens as part of a series of
> multiple commits:
> 
>   $ git cherry-pick <commit1> <commit2>
>   < one of the cherry-picks fails to merge clean >
>   Cherry-pick currently in progress.
>    (run "git cherry-pick --continue" to continue)
>    (use "git cherry-pick --skip" to skip this patch)
>    (use "git cherry-pick --abort" to cancel the cherry-pick operation)
> 
>   $ git status
>   On branch <branch>
>   Your branch is ahead of '<upstream>' by 1 commit.
>     (use "git push" to publish your local commits)
> 
>   Cherry-pick currently in progress.
>     (run "git cherry-pick --continue" to continue)
>     (use "git cherry-pick --skip" to skip this patch)
>     (use "git cherry-pick --abort" to cancel the cherry-pick operation)
> 
> The show_cherry_pick_in_progress() function prints "Cherry-pick
> currently in progress". That function does have a more verbose print
> based on whether the cherry_pick_head_oid is null or not. If it is not
> null, then a more helpful message including which commit is actually
> being picked is displayed.
> 
> The introduction of the "Cherry-pick currently in progress" message
> comes from 4a72486de97b ("fix cherry-pick/revert status after commit",
> 2019-04-17). This commit modified wt_status_get_state() in order to
> detect that a cherry-pick was in progress even if the user has used `git
> commit` in the middle of the sequence.
> 
> The check used to detect this is the call to sequencer_get_last_command.
> If the sequencer indicates that the lass command was a REPLAY_PICK, then
> the state->cherry_pick_in_progress is set to 1 and the
> cherry_pick_head_oid is initialized to the null_oid. Similar behavior is
> done for the case of REPLAY_REVERT.
> 
> It happens that this call of sequencer_get_last_command will always
> report the action even if the user hasn't interrupted anything. Thus,
> during a range of cherry-picks or reverts, the cherry_pick_head_oid and
> revert_head_oid will always be overwritten and initialized to the null
> oid.
> 
> This results in status always displaying the terse message which does
> not include commit information.
> 
> Fix this by adding an additional check so that we do not re-initialize
> the cherry_pick_head_oid or revert_head_oid if we have already set the
> cherry_pick_in_progress or revert_in_progress bits. This ensures that
> git status will display the more helpful information when its available.
> Add a test case covering this behavior.
> 
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> 
> Changes since v1:
> * add the missing test case that I had locally but forgot to squash in
> * use else if as suggested by Phillip
> 
>   t/t7512-status-help.sh | 22 ++++++++++++++++++++++
>   wt-status.c            |  4 ++--
>   2 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
> index 2f16d5787edf..c2ab8a444a83 100755
> --- a/t/t7512-status-help.sh
> +++ b/t/t7512-status-help.sh
> @@ -774,6 +774,28 @@ EOF
>   	test_cmp expected actual
>   '
>   
> +test_expect_success 'status when cherry-picking multiple commits' '
> +	git reset --hard cherry_branch &&
> +	test_when_finished "git cherry-pick --abort" &&
> +	test_must_fail git cherry-pick cherry_branch_second one_cherry &&
> +	TO_CHERRY_PICK=$(git rev-parse --short CHERRY_PICK_HEAD) &&
> +	cat >expected <<EOF &&
> +On branch cherry_branch
> +You are currently cherry-picking commit $TO_CHERRY_PICK.
> +  (fix conflicts and run "git cherry-pick --continue")
> +  (use "git cherry-pick --skip" to skip this patch)
> +  (use "git cherry-pick --abort" to cancel the cherry-pick operation)
> +
> +Unmerged paths:
> +  (use "git add <file>..." to mark resolution)
> +	both modified:   main.txt
> +
> +no changes added to commit (use "git add" and/or "git commit -a")
> +EOF
> +	git status --untracked-files=no >actual &&
> +	test_cmp expected actual
> +'
> +
>   test_expect_success 'status when cherry-picking after committing conflict resolution' '
>   	git reset --hard cherry_branch &&
>   	test_when_finished "git cherry-pick --abort" &&
> diff --git a/wt-status.c b/wt-status.c
> index 068b76ef6d96..8d23ff8ced23 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1790,10 +1790,10 @@ void wt_status_get_state(struct repository *r,
>   		oidcpy(&state->revert_head_oid, &oid);
>   	}
>   	if (!sequencer_get_last_command(r, &action)) {
> -		if (action == REPLAY_PICK) {
> +		if (action == REPLAY_PICK && !state->cherry_pick_in_progress) {
>   			state->cherry_pick_in_progress = 1;
>   			oidcpy(&state->cherry_pick_head_oid, null_oid());
> -		} else {
> +		} else if (action == REPLAY_REVERT && !state->revert_in_progress) {
>   			state->revert_in_progress = 1;
>   			oidcpy(&state->revert_head_oid, null_oid());
>   		}
