Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BBEEB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 13:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjF0NOI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 09:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjF0NOF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 09:14:05 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DDF2D6A
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 06:13:41 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f8775126d3so6207647e87.1
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 06:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687871618; x=1690463618;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6IEjss20wL554bR5oXYFukejVv5/6q7pY2OxKYBvtQ=;
        b=rNmd+Tw+2VmVq2ZA8VrzsD4xtZgEkJQl8nsn0UU4mMHQX4z9T7kOGeVX9b+XKmjZOF
         X6qTaJ7N/yDFXmcMEuhwvuQGkN72gGLsMnfwnIuVoX5CLneMrAFuEnLa5fle92vHsRIx
         ysULRnJW1g0XLkVCIuX+n5KlmEwABvp4LtAJ8vfU4YUdrsulhXx+BNPUOg7U7rMVLcQt
         MQgRDhqJPHO3sggXB7EFJYL/kR5O4INVBOhIcDq5TXOTpXJSOKsFWbXFeGR+qcKdqIOY
         vJnZr2TUTzLQyZKzyO6FUQp9AZYrqmsTyTOwVfPcvcnB5zNejyeiP3OCo/1svm42U6JX
         0Ghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687871618; x=1690463618;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q6IEjss20wL554bR5oXYFukejVv5/6q7pY2OxKYBvtQ=;
        b=WEefrrOG5bl7TmBYjNPRv6YT5aFvU7iUeCUeqFPfH3wfyDUeomp8F6oOjLIvua9ABF
         cddEWrjlr7RimpdInhzncSiiwKHg2rmQEgz51wF6z4+WMCxsdiHWuGk/JuyHvmLGRD+k
         pWbQbz8weGAIAJ7xS78mfXNs17YnDhs00ImLsFjHb/M4DmI8mroQosYosa+8JPHcVI+f
         QehRSPocmhsCtfXg8DCtE7jzgcFwxf7h66ckK5undcWhJ/h9NuUjtBUX8lw36DBM61I3
         oWhsuLsjzHy8SRuTnP9PVOYEkyQkW+vDlB3/crXFMpwLPRQ2/bi3Nsev3tvu28dbnt1D
         IUGg==
X-Gm-Message-State: AC+VfDyV0nZpllN56kW38i8xmFvjFGkYw6xidQ1Yh7pv80P5Rnpbn/fa
        T5PGYqHhljyjQ1a8kmGwz/M=
X-Google-Smtp-Source: ACHHUZ5DFgT3cHC0NC8EXWWgXTUr/JqH9zK5qSp3uvXKN6LzCRqCupWTOFjd5Xwo7zAUEvnYa2qg9w==
X-Received: by 2002:ac2:4f13:0:b0:4f9:6b06:129e with SMTP id k19-20020ac24f13000000b004f96b06129emr10154637lfr.65.1687871618233;
        Tue, 27 Jun 2023 06:13:38 -0700 (PDT)
Received: from [192.168.1.195] ([90.242.235.211])
        by smtp.googlemail.com with ESMTPSA id p9-20020a05600c204900b003f93c450657sm10720188wmg.38.2023.06.27.06.13.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 06:13:37 -0700 (PDT)
Message-ID: <adbeb217-a30b-8193-4dad-b3efa0b4da05@gmail.com>
Date:   Tue, 27 Jun 2023 14:13:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] fix cherry-pick/revert status when doing multiple commits
Content-Language: en-US
To:     Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Jacob Keller <jacob.keller@gmail.com>
References: <20230621220754.126704-1-jacob.e.keller@intel.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230621220754.126704-1-jacob.e.keller@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jacob

On 21/06/2023 23:07, Jacob Keller wrote:
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

Thanks for the detailed explanation, I agree with your diagnosis and 
fix. The test case you mention seems to be missing though. I've left one 
small comment below

> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
>   wt-status.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/wt-status.c b/wt-status.c
> index 068b76ef6d96..1e2daca73024 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1790,10 +1790,11 @@ void wt_status_get_state(struct repository *r,
>   		oidcpy(&state->revert_head_oid, &oid);
>   	}
>   	if (!sequencer_get_last_command(r, &action)) {
> -		if (action == REPLAY_PICK) {
> +		if (action == REPLAY_PICK && !state->cherry_pick_in_progress) {
>   			state->cherry_pick_in_progress = 1;
>   			oidcpy(&state->cherry_pick_head_oid, null_oid());
> -		} else {
> +		}
> +		if (action == REPLAY_REVERT && !state->revert_in_progress) {

I think this would be clearer as

-		} else {
+		} else if ((action == REPLAY_PICK && !state->cherry_pick_in_progress) {

not worth a re-roll on its own, but I think it is worth considering when 
you re-roll with the missing test.

Thanks for working on this,

Phillip

>   			state->revert_in_progress = 1;
>   			oidcpy(&state->revert_head_oid, null_oid());
>   		}

