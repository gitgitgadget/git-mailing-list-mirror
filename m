Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF97C77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 20:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjDXU2U (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 16:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjDXU2T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 16:28:19 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF33B55A6
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 13:28:16 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1a9253d4551so40474515ad.0
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 13:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682368096; x=1684960096;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GWTtufTFeDy8lYyV8NmHPIyiLmr+5K7C2CJN4P4ofU=;
        b=i7j56oEg4OX/7AcAbcCRpJGgzqSgyC9beOWVG53wm+UL3cQb5c7fQ6M4B/fFpnqjji
         iMmU/XRECikBGYaW/Vr1a4Pse23HWgeupuIpAsgh802V84lk+uho1twBqyu4tkrbRcP0
         CngCpsEc647NQFhSZwfJQ73cvKKle8l62BBRBwaanKTL4VC84f76+dMsFvL9IbHQ7OCS
         /0TzZgNg8luVN0TRJB+yUTvMovhGG2Bzy+55muhzCR/5QGfjkB9/vkWMGy+tjt9Jv6ae
         mu0YIKuWA8RHeprlpkdKiHtyvtf6ul75kZXMFqvl2ThOiG9RPCZuWfj/KDjL6Dqb/psk
         bn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682368096; x=1684960096;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7GWTtufTFeDy8lYyV8NmHPIyiLmr+5K7C2CJN4P4ofU=;
        b=YTY75CVC3fGqDdXOsMeLlD2LCikO6JD2LIqGgXQFbMm6qBojyvpJe5vK3S78Sbg4Bf
         sdUN5XjO2IdG7UT6UsofjDziVdsEEa1AZJFMOfc1XFIKliDtYlgwyfXsxnhqb4HK1q4+
         qtp5wQmI2/5twGP+Fe+TopRyzszWTCK/nbuurE0cy1lBi35iArh0+ORfbhGMIK+AG74q
         zKUgxcWeZiO77e+TWWSKt+284oZBHvgLpUKvmVsvTt0NuLmPysFhzB+iNw8l4K0kI/rB
         YqTqsHHHrWxSVa4XmXLYd6yOy8FC7LKq3iUgtuIwkb43tYf0gcgFWWJ/3X9K1u6gWKEy
         adMg==
X-Gm-Message-State: AAQBX9fU833WkNVuQ7njYQo57rMAmxt167MU5uNUspzPdkjmyNOdiFIA
        f5kGSLJj1vPXIH7fk6xjT13JB2YU5/4=
X-Google-Smtp-Source: AKy350b02wRStNvCL1CFzSA+r031Uj2QXQgjowk/VkNikNnSFW34kotrq2eEQ6uQW2WmFwOmRo8z2w==
X-Received: by 2002:a17:902:cec9:b0:1a6:dba5:2e60 with SMTP id d9-20020a170902cec900b001a6dba52e60mr18766620plg.25.1682368095913;
        Mon, 24 Apr 2023 13:28:15 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id f1-20020a170902ff0100b001a5059861adsm6927336plj.224.2023.04.24.13.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 13:28:15 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] worktree: warn when removing a worktree with orphan
 commits
References: <f702476a-543a-da9b-ccd9-4431c80471e1@gmail.com>
        <1897dff1-bb4d-9715-dd1c-86763c052589@gmail.com>
Date:   Mon, 24 Apr 2023 13:28:14 -0700
In-Reply-To: <1897dff1-bb4d-9715-dd1c-86763c052589@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Sun, 23 Apr 2023 00:19:21 +0200")
Message-ID: <xmqq5y9lc9ep.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rubén Justo <rjusto@gmail.com> writes:

> While working in a detached worktree, the user can create some commits
> which won't be automatically connected to any ref.
>
> Eventually, that worktree can be removed and, if the user has not
> created any ref connected to the HEAD in that worktree (e.g. branch,
> tag), those commits will become unreachable.

The latter half of the first sentence feels a bit awkward, primarily
it sounds as if it almost wants to hint that it is good if we
connected these commits to some ref automatically, and it is far
from obvious why it is a good idea.  Perhaps

    ... the user can create some commits on detached HEAD, that are
    not connected to any ref.  If the user hasn't pointed at these
    commits by refs before removing the worktree, those commits will
    become unreachable.

That would be in line with the comment you moved in 1/3 that
describes why orphaned_commit_warning() helper is there, i.e.

    /*
     * We are about to leave commit that was at the tip of a detached
     * HEAD.  If it is not reachable from any ref, this is the last chance
     * for the user to do so without resorting to reflog.
     */

> Let's issue a warning to remind the user for safety, when deleting a
> worktree whose HEAD is not connected to an existing ref.

Good idea.  "Let's issue" -> "Issue" (or "Give", "Show").

> Let's also add an option to modify the message we show in
> orphaned_commit_warning(): "Previous HEAD position was..."; allowing to
> omit the word "Previous" as it may cause confusion, erroneously
> suggesting that there is a "Current HEAD" while the worktree has been
> removed.

Yes, it is absolutely necessary to adjust the message if you are to
reuse the orphaned_commit_warning() helper so that it matches the
situation as the end-user experiences.

>  	if (!opts->quiet && !old_branch_info.path && old_branch_info.commit && new_branch_info->commit != old_branch_info.commit)
> -		orphaned_commit_warning(old_branch_info.commit, new_branch_info->commit);
> +		orphaned_commit_warning(old_branch_info.commit, new_branch_info->commit, 1);

The magic number "1" looks iffy.

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index a61bc32189..df269bccc8 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -1138,6 +1138,14 @@ static int remove_worktree(int ac, const char **av, const char *prefix)
>  
>  		ret |= delete_git_work_tree(wt);
>  	}
> +
> +	if (!wt->head_ref && !is_null_oid(&wt->head_oid)) {
> +		struct commit* wt_commit = lookup_commit_reference_gently(the_repository,

Asterisk sticks to the variable, not to type, in C.  If you write

	struct commit *pointer, structure;

it is clear only one is the pointer.  It misleads people if you wrote

	struct commit* one, two;

instead.

> +									  &wt->head_oid, 1);

Also, lines around here look overly long.  Would it help to fold the
line after the initialization assignment, i.e.

		struct commit *wt_commit =
			lookup_commit_reference_gently(the_repository, ...);


> +		if (wt_commit)
> +			orphaned_commit_warning(wt_commit, NULL, 0);

Again, the magic number "0" looks iffy.

> diff --git a/checkout.c b/checkout.c
> index 18e7362043..5f7b0b3c49 100644
> --- a/checkout.c
> +++ b/checkout.c
> @@ -171,7 +171,8 @@ static void suggest_reattach(struct commit *commit, struct rev_info *revs)
>   * HEAD.  If it is not reachable from any ref, this is the last chance
>   * for the user to do so without resorting to reflog.
>   */
> -void orphaned_commit_warning(struct commit *old_commit, struct commit *new_commit)
> +void orphaned_commit_warning(struct commit *old_commit, struct commit *new_commit,
> +			     int show_previous_position)
>  {
>  	struct rev_info revs;
>  	struct object *object = &old_commit->object;
> @@ -192,8 +193,10 @@ void orphaned_commit_warning(struct commit *old_commit, struct commit *new_commi
>  		die(_("internal error in revision walk"));
>  	if (!(old_commit->object.flags & UNINTERESTING))
>  		suggest_reattach(old_commit, &revs);
> -	else
> +	else if (show_previous_position)
>  		describe_detached_head(_("Previous HEAD position was"), old_commit);
> +	else
> +		describe_detached_head(_("HEAD position was"), old_commit);

Can we think of a single way to phrase this batter?  It's not like
the reason why the user wants to save the orphaned history is
because it was at the PREVIOUS HEAD, or at the HEAD of a now-lost
working tree.  It is because the history leading to that commit is
now about to be lost.  So perhaps "history leading to commit X has
become unreachable" or something would apply to both situation and
we do not have to pass the mysterious "0"/"1" that are hardcoded?

If the situation were the opposite and there were many ways that
lead to lost history (i.e. not just the original "switch out of the
detached HEAD", we are now adding "discarding a worktree with HEAD
detached", and there may be more cases added in the future) that
need to be described differently, I would have instead suggested to
use an enum and use different phrasing for each case, but it does
not seem that the original "Previous HEAD position was" is so
superbly phrased that we do not want to lose it, and the second one
being added in the above hunk is not all that different.  If we can
get away with just a single universal message, it would make things
simpler.

> diff --git a/checkout.h b/checkout.h
> index c7dc056544..ee400376d5 100644
> --- a/checkout.h
> +++ b/checkout.h
> @@ -18,7 +18,8 @@ const char *unique_tracking_name(const char *name,
>   * HEAD.  If it is not reachable from any ref, this is the last chance
>   * for the user to do so without resorting to reflog.
>   */
> -void orphaned_commit_warning(struct commit *old_commit, struct commit *new_commit);
> +void orphaned_commit_warning(struct commit *old_commit, struct commit *new_commit,
> +			     int show_previous_position);
>  
>  void describe_detached_head(const char *msg, struct commit *commit);
>  #endif /* CHECKOUT_H */
> diff --git a/t/t2403-worktree-move.sh b/t/t2403-worktree-move.sh
> index 230a55e99a..f2756f7137 100755
> --- a/t/t2403-worktree-move.sh
> +++ b/t/t2403-worktree-move.sh
> @@ -247,4 +247,14 @@ test_expect_success 'not remove a repo with initialized submodule' '
>  	)
>  '
>  
> +test_expect_success 'warn when removing a worktree with orphan commits' '
> +	git worktree add --detach foo &&
> +	git -C foo commit -m one --allow-empty &&
> +	git -C foo commit -m two --allow-empty &&
> +	git worktree remove foo 2>err &&
> +	test_i18ngrep "you are leaving 2 commits behind" err &&
> +	test_i18ngrep ! "Previous HEAD position was" err
> +	test_i18ngrep "HEAD position was" err
> +'
> +
>  test_done
