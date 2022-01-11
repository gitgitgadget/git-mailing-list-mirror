Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9870DC433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 20:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236743AbiAKUQt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 15:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243433AbiAKUQn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 15:16:43 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04290C061759
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 12:15:59 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v66-20020a256145000000b006115377709aso275429ybb.3
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 12:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yt9A0DozjSA9n7FkJxwuRLMlMf/3liIo7+PEB9OhJv4=;
        b=KfqmMpABh9sBmrAoJIDDgczxScMNiVkR6olkGd8CchHwKslN+LaNvNggyUPtGL20Cz
         ho6fybnHlYh9+c6/5k+vIse8lEuS0MhxKHo8WZ+5kqCD3LGvuCFg1S8tfuhFQ7FJoQAA
         WD7OngAd6U7AgAPcmibSpaSRJMbWB3I0hrsLG16tIL4qCnlC5oY+mU5L8sw1Di4C4CDi
         xfbq5li2zNJzRB8MW/j8TJnBpzgZnyDyk7HzbAkIvZ+Yftus74CyBhguSAVkuQsMUdVA
         IZdjqZ6Ml1XtxHCv9Z0KXt+urdxcWPxU1li7ypy40+xkXjH181IgKijVPbZNWqOBndgK
         cByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yt9A0DozjSA9n7FkJxwuRLMlMf/3liIo7+PEB9OhJv4=;
        b=7wAPhYgLZyeb/LZEGGjSNg5HWLKLWfycy8wIo8aIbNLbFTbi2lB8eZbxNAOSBNvcQv
         MVx6wL7YS7RyhKQaAhA+KoOEXdbNDwKD6bdEYRUSQNkrawr0ceXnBo13rjjA9R1L3r5V
         JsY8Sda1FRFbUJELEH4y4Q6gOn702MdevTebNTVT5n7fuSQa88Fv+hg79+UOOEnzm0+g
         ENy5PEaCFEjon8qZBbCiFfqDFI2jFapn2/xz2gK+3cjAR5GYsE4q5EvbESSh6Nz79wss
         7hbvATpwPJHAaMqQWMx1Ql3Fqg7L5vyw0HPv6oBGB5Zqk0Dxfw0Wr9fxizmUCfUrIGuK
         Y7Vg==
X-Gm-Message-State: AOAM531vfPdunRRW5tIz/oG4lYVCPlYlD9zmQ0l+Ji5CiX5I6zEQYRdN
        U6aQT1ZakG+xrAzDJL/J66YH4gUa3xtOOdHSCISb
X-Google-Smtp-Source: ABdhPJxu9x1EVG7smqJW8sLBlLERZ5fC0jYn83BYQUb1HlVleYib5ALPMb9p/4tVyNhgtUDKkg8STF2xutQ5ztRTIrUh
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:cec6:: with SMTP id
 x189mr7912688ybe.134.1641932158279; Tue, 11 Jan 2022 12:15:58 -0800 (PST)
Date:   Tue, 11 Jan 2022 12:15:56 -0800
In-Reply-To: <kl6l4k6akurn.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <20220111201556.26345-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <kl6l4k6akurn.fsf@chooglen-macbookpro.roam.corp.google.com>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
Subject: Re: [PATCH v6 5/5] branch: add --recurse-submodules option for branch creation
From:   Jonathan Tan <jonathantanmy@google.com>
To:     chooglen@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, steadmon@google.com,
        emilyshaffer@google.com, avarab@gmail.com,
        levraiphilippeblain@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> >> +test_expect_success 'should create branches if branch exists and --force is given' '
> >> +	test_when_finished "cleanup_branches super branch-a" &&
> >> +	(
> >> +		cd super &&
> >> +		git -C sub rev-parse HEAD >expected &&
> >> +		test_commit -C sub baz &&
> >> +		git -C sub branch branch-a HEAD~1 &&
> >> +		git branch --recurse-submodules --force branch-a &&
> >> +		git rev-parse branch-a &&
> >> +		# assert that sub:branch-a was moved
> >> +		git -C sub rev-parse branch-a >actual &&
> >> +		test_cmp expected actual
> >> +	)
> >> +'
> >
> > Should we create branch-a at HEAD instead of HEAD~1?
> 
> If we create branch-a at HEAD, we won't be testing that --force moves
> the branch head. 

Walking through the lines of the test:

> >> +		git -C sub rev-parse HEAD >expected &&

So "expected" is sub's HEAD at the start of the test. Let's call this
old-head.

> >> +		test_commit -C sub baz &&

We create a new commit on top, whose parent is old-head. Let's call this
new-head.

> >> +		git -C sub branch branch-a HEAD~1 &&

We create a new branch at HEAD~1, which is new-head's parent, which is
old-head. So this branch points to the same thing as "expected".

> >> +		git branch --recurse-submodules --force branch-a &&

When creating new branches with "--force", any branch information in the
submodule is ignored. So we would expect "branch-a" in sub to be
overridden from "old-head" to "old-head".

> >> +		git rev-parse branch-a &&

Verifying that branch-a exists, although upon second look, this would
work whether or not we recursed, so maybe this line can be deleted.

> >> +		# assert that sub:branch-a was moved
> >> +		git -C sub rev-parse branch-a >actual &&
> >> +		test_cmp expected actual

A check, as expected.

Unless I missed something, branch-a was never moved - it was created at
"old-head" and then the "branch --force" is supposed to create it at
"old-head" anyway. It would make more sense to me if the branch was
created at "new-head", and then "branch --force" moved it to "old-head".

> This means that the test might pass if we simply ignore
> any existing branch-a - which is not the intended behavior of --force,
> but this is behavior that we might want in the future (probably using
> another option).

By "ignore", supposing that there is an existing branch-a, do you mean
overwrite branch-a, or not create any branch at all?
