Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4607DEB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 20:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjFUUf1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 16:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjFUUf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 16:35:26 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818EE19A2
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 13:35:25 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57059e6f9c7so124719347b3.0
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 13:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687379724; x=1689971724;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ny85Qk+4f9IJpeKs58oY2J/urYzxNx2Wgx8KTlGsUo=;
        b=zEeXZCawdF1K9bKjdvwaTTGoOMmiB2eUNM0048A2vCgcRd9I+TcJSHmBXLehYEoWO2
         5wNQNm4y8MHrq6LI2b9op3TV4l0VsOIeeGic9Ee8qkF/H3/e4Cp1ArwY+brcTjgBHMwJ
         ZktPIWrfeeXMkYlTI6qts3GUH0KrzxoVc7XPAPhzwaEf/kd2roQCE902tg7//0gHeSGB
         WjLWyfVtO8ElRGIs0jWFSQH4wFTlG7ILr/+ygoC5+ZjKhTzcjaIPEp4Uw0evr+7P1TBL
         8ZKJLnG5mNBOWoJzzhqpIe+IZachPOxoO1X+aDVf1uB6YeLnIcCtKgp4P7o5NpJ8aNbX
         UjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687379724; x=1689971724;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ny85Qk+4f9IJpeKs58oY2J/urYzxNx2Wgx8KTlGsUo=;
        b=aUg2ivqZNqrpkF9MTauKN52zPE838U+iGdfgbmXBBuV5rzXkeDs3mgi9wZrJbPCSYo
         Rwrz7fCDP/AcvyQglvh7omXIWaupxax9e7pzdAuEJSlYMAzNu3i5qBEcAaTQ3B2DArGM
         n0sWqN9tLDSf0pmhAc3qSR4oAGFd6art8FcMi6l2zmlkeoPttzV5q1DIgd/fwlpV1Psn
         26SCCOBJqFmzz/S2z3RSJESwlfLtTRoZSCE+7MNHWY5Or+lwVOl6Istn/w1xVJ/RpO6r
         /aS+998zpS5MsErUmxD9EiIs/yrGvH+n9XPRWsnbdxFv+oE7t0K/GDG8GrVz5l5rnm5b
         bmLg==
X-Gm-Message-State: AC+VfDzk+Z80UoNwYIHPxw50lGAFeQm0Gu2nQ7Z3zB9v5kdWl1MKbmFt
        oK2iUIj7ctmVRPvxu0fNz9++Abpn3bi4kQ==
X-Google-Smtp-Source: ACHHUZ55T0G+yyfZHiC6QD1UynDJqltHnTr9FSCUo2mu9/SYjktPM/DmsQqA1OcCjuNvcqUZGhBF3mycP8GUAw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a81:4313:0:b0:56c:ed45:442c with SMTP id
 q19-20020a814313000000b0056ced45442cmr7610606ywa.5.1687379724808; Wed, 21 Jun
 2023 13:35:24 -0700 (PDT)
Date:   Wed, 21 Jun 2023 13:35:23 -0700
In-Reply-To: <9356d14b09a468d8ef2884cd7d76e59ec5c16691.1682089075.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
 <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com> <9356d14b09a468d8ef2884cd7d76e59ec5c16691.1682089075.git.gitgitgadget@gmail.com>
Message-ID: <kl6lpm5or1tg.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 4/6] rebase --continue: refuse to commit after failed command
From:   Glen Choo <chooglen@google.com>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> If a commit cannot be picked because it would overwrite an untracked
> file then "git rebase --continue" should refuse to commit any staged
> changes as the commit was not picked. Do this by using the existing
> check for a missing author script in run_git_commit() which prevents
> "rebase --continue" from committing staged changes after failed exec
> commands.

For someone unfamiliar with "git rebase" code, I think it is easy enough
to gather that "rebase --continue" will refuse to accept staged changes
if the author script is missing, so we are reusing that mechanism to
achieve our desired effect. It's not obvious whether this might have
unintended consequences (Are we reusing something unrelated for an
unintended purpose?) or what alternatives exist (Is sequencer.c so
complex that there isn't another way to do this?). It would have been
helpful for me to see how these considerations factored into your
decision.

> When fast-forwarding it is not necessary to write the author script as
> we're reusing an existing commit, not creating a new one. If a
> fast-forwarded commit is modified by an "edit" or "reword" command then
> the modification is committed with "git commit --amend" which reuses the
> author of the commit being amended so the author script is not needed.
> baf8ec8d3a (rebase -r: don't write .git/MERGE_MSG when fast-forwarding,
> 2021-08-20) changed run_git_commit() to allow a missing author script
> when rewording a commit. This changes extends that to allow a missing
> author script whenever the commit is being amended.

As I understand it, the author script can now be missing in other
circumstances, so we have to adjust the rest of the machinery to handle
that case? If so, this seems to suggest that there are some unintended
consequences.

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index ff0afad63e2..c1fe55dc2c1 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1288,6 +1288,12 @@ test_expect_success 'rebase -i commits that overwrite untracked files (pick)' '
>  	test_must_fail git rebase --continue &&
>  	test_cmp_rev HEAD F &&
>  	rm file6 &&
> +	test_path_is_missing .git/rebase-merge/author-script &&

Checking that the path is missing seems like testing implementation
details. If so, I would prefer to remove this assertion here and
elsewhere.

> +	echo changed >file1 &&
> +	git add file1 &&
> +	test_must_fail git rebase --continue 2>err &&
> +	grep "error: you have staged changes in your working tree" err &&
> +	git reset --hard HEAD &&

This seems reasonable.
