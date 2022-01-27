Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6C8C433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 20:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344031AbiA0U3W (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 15:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbiA0U3V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 15:29:21 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC47EC061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 12:29:21 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id mn21-20020a17090b189500b001b4fa60efcbso4921075pjb.2
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 12:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MWlp+RmguBkf/J0uwDW+WtCrzoZjQo+gSO5V7i55A5w=;
        b=PhOqma29r33JgRYpFGOXaI+Z8YvJUzuAsdYKg1i6JAp2A1due/JkBvnwzuOWVvfc6a
         Jlei84PS+SijlttjbBitmNx3vIffFBzxiHw5fK2l4vIJs2mGpw9YpMHP6+zI/LkFRJJQ
         90glLQLBYC1lmaPF007hrx8YvXrkglSIzX1bgB+cGrwY6OUBFTGI00kNqX1qZdW1vaI0
         KGGKjSnl11vRq2QRGv+u3MkDQfZMFXyUJh9szhNcZYM0Zvd5NEKHwbL9CAiT9RbCOkbH
         nGIyRS731Yjp6PjMCMX9mbAvE0lYTQhbTXQLZNRE0qjghjpdIDnYPulm0wGkIQNh6IJ7
         v/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MWlp+RmguBkf/J0uwDW+WtCrzoZjQo+gSO5V7i55A5w=;
        b=cCsmwUk8Wz8dpcDEZP6Opoofxq8yZH3dcNfmUhL3gIszw1UA17zmvAR6GjGvJZNhGx
         4ditnD/AjeaRtADn5lQcBBPL0RylSr2Kst81Vy3fHXKVyQsAH2/XX5qeMBfjgtAF7IGu
         tUjSHUvbhdpNHOjg9n06rDiWC3sxPaK3+99LkwhgexYzKege+iG97hVYIR7SentwXcib
         RZu211iIZZt+7PtYS3S1F8bFLLzCwwIWnpPelCHAbPBVb6ZFZoqkv2mabXLbnLTskSvz
         gwr3TR5oRA9sab9MW/qO1lX7BohUbIeUBQkfV+IKoHwZcbPgFz47bC3xocjM7xOOW+1Q
         V5rQ==
X-Gm-Message-State: AOAM533XhoCBJGhNR7YiKoHGGn+HNIOWzW1zfM3eB+laoWgmbLXB4xNm
        KQZSgmtTQjCObE+MemkAoyrSAwT4egbJvHhkB8rt
X-Google-Smtp-Source: ABdhPJxa+Sz31upQScO9v5qkzrDFkiYncyL4o+afCwjL8D+K36qBRwk3I5lsjpOfFWg6t9wlHw/R4ioDV5OY6cTaaSji
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:4d82:: with SMTP id
 oj2mr1773044pjb.1.1643315360833; Thu, 27 Jan 2022 12:29:20 -0800 (PST)
Date:   Thu, 27 Jan 2022 12:29:18 -0800
In-Reply-To: <20220124204442.39353-6-chooglen@google.com>
Message-Id: <20220127202918.3099460-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20220124204442.39353-6-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: Re: [PATCH v7 5/6] branch: add --recurse-submodules option for branch creation
From:   Jonathan Tan <jonathantanmy@google.com>
To:     chooglen@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, steadmon@google.com,
        emilyshaffer@google.com, avarab@gmail.com,
        levraiphilippeblain@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patches up to this one look good, and the implementation looks good too.
I just have minor comments on some of the text and tests.

Glen Choo <chooglen@google.com> writes:
> Although this commit does not introduce breaking changes, it is
> incompatible with existing --recurse-submodules commands because "git
> branch --recurse-submodules" writes to the submodule ref store, but most
> commands only consider the superproject gitlink and ignore the submodule
> ref store. For example, "git checkout --recurse-submodules" will check
> out the commits in the superproject gitlinks (and put the submodules in
> detached HEAD) instead of checking out the submodule branches.

The usual meaning of "incompatible" is "cannot be used together", I
think, which is not what's happening here - it's just that the user
would expect them to work together in a specific way but they don't do
that.

> To Jonathan: When describing the differences between "git branch" and "git
> checkout", I opted to emphasize the fact that "git checkout" checks out the
> gitlink in detached HEAD and not the branches themselves (vs your suggestion of
> mentioning that checkout would check out the wrong version if the branch is
> subsequently updated).

OK - makes sense.

> +/**
> + * Creates a branch in a submodule by calling
> + * create_branches_recursively() in a child process. The child process
> + * is necessary because install_branch_config_multiple_remotes() (which
> + * is called by setup_tracking()) does not support writing configs to
> + * submodules.

OK, good explanation for why a child process is needed.

> + */
> +static int submodule_create_branch(struct repository *r,
> +				   const struct submodule *submodule,
> +				   const char *name, const char *start_oid,
> +				   const char *start_name, int force,
> +				   int reflog, int quiet,
> +				   enum branch_track track, int dry_run)
> +{
> +	int ret = 0;
> +	struct child_process child = CHILD_PROCESS_INIT;
> +	struct strbuf child_err = STRBUF_INIT;
> +	struct strbuf out_buf = STRBUF_INIT;
> +	char *out_prefix = xstrfmt("submodule '%s': ", submodule->name);
> +	child.git_cmd = 1;
> +	child.err = -1;
> +	child.stdout_to_stderr = 1;
> +
> +	prepare_other_repo_env(&child.env_array, r->gitdir);
> +	/*
> +	 * submodule_create_branch() is indirectly invoked by "git
> +	 * branch", but we cannot invoke "git branch" in the child
> +	 * process because it does not let us set start_name and
> +	 * start_oid separately (see create_branches_recursively()).

Probably clearer to enumerate the 3 different pieces of information
needed: the name of the branch to be created, the OID, and the name of
the branch that would be used for tracking purposes.

An argument could be made that "git branch" should be extended to be
able to take in these 3 different pieces of information, but it also
makes sense to put this functionality in submodule--helper for now,
since the whole thing is marked as experimental.

> +/*
> + * Creates a new branch in repository and its submodules (and its
> + * submodules, recursively). Besides these exceptions, the parameters
> + * function identically to create_branch():
> + *
> + * - start_name is the name of the ref, in repository r, that the new
> + *   branch should start from. In submodules, branches will start from
> + *   the respective gitlink commit ids in start_name's tree.
> + *
> + * - tracking_name is the name used of the ref that will be used to set
> + *   up tracking, e.g. origin/main. This is propagated to submodules so
> + *   that tracking information will appear as if the branch branched off
> + *   tracking_name instead of start_name (which is a plain commit id for
> + *   submodules). If omitted, start_name is used for tracking (just like
> + *   create_branch()).
> + *
> + */
> +void create_branches_recursively(struct repository *r, const char *name,
> +				 const char *start_name,
> +				 const char *tracking_name, int force,
> +				 int reflog, int quiet, enum branch_track track,
> +				 int dry_run);

Instead of taking in "name", "start_name", and "tracking_name", could we
take in "name", "oid", and "tracking_name"? That way, it's clearer what
each parameter is used for.

> +test_expect_success 'should not create branches in inactive submodules' '
> +	test_when_finished "reset_test" &&
> +	test_config -C super submodule.sub.active false &&
> +	(
> +		cd super &&
> +		git branch --recurse-submodules branch-a &&
> +		git rev-parse branch-a &&
> +		test_must_fail git -C sub branch-a
> +	)
> +'

The "test_must_fail" line doesn't make sense - there is no such command
branch-a. To avoid errors like this, maybe make sure that all
test_must_fail invocations are accompanied by assertions on the error
message. (And for "test_must_fail git rev-parse", we could have a helper
function here that asserts the "object not found".)

> +test_expect_success 'should set up tracking of local branches with track=always' '
> +	test_when_finished "reset_test" &&
> +	(
> +		cd super &&
> +		git -c branch.autoSetupMerge=always branch --recurse-submodules branch-a main &&
> +		git -C sub rev-parse main &&
> +		test "$(git -C sub config branch.branch-a.remote)" = . &&
> +		test "$(git -C sub config branch.branch-a.merge)" = refs/heads/main
> +	)
> +'

As described in t/README line 671, this means that the inner command
could silently fail. You can do `REMOTE=$(...) &&` <newline> `test ...`.
Same comment throughout this file.
