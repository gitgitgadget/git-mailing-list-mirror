Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60C7C4332F
	for <git@archiver.kernel.org>; Sun,  6 Feb 2022 09:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbiBFJXt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Feb 2022 04:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbiBFJSH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 04:18:07 -0500
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC70C06173B
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 01:18:06 -0800 (PST)
Received: by mail-pg1-f171.google.com with SMTP id f8so8969261pgf.8
        for <git@vger.kernel.org>; Sun, 06 Feb 2022 01:18:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EIfEjDqcEy/PZEgDBsoLJD6NAvFWOYstvZYYMiBvAZY=;
        b=VFNGNO8rTocyZuYlHIOLsmweRpOEfF5c9GbKWYNdubJ30v92rbAnvXv/CTuHOuMAmy
         cPUwmHw3klzJQJyJJh152p1tGe3DRdoI5C/WM9dDLKfxz9vhrwSIycFQuOtnZ6qU1afm
         HEWBdGPf2pic6yiDL2YjAIxrUsnLM+yCbDLyDmAKBtClDMlyS5No7YjSczqIPXnxJH8O
         G5WYseGCZEwvxmhWAhybr+8xHKr9qmwxyuO7jD2SVJbPLEMPFRSnttUXexeagz6qUNa6
         gOE+d4uOqQj6jIexDCOmQhNq3QNxo7KsIsw21+YIOhYOJdCgXcddxFXy7BL4eX4X39IK
         1aew==
X-Gm-Message-State: AOAM533mpb9Dd5Lhq/lLV5p8dJItEhsghhYUJOsIeiYJzxyNVkJmy6zF
        ggRKPZMTUkky9vjCfXp/Z4Nv5tG/miY4Oz/N3EI=
X-Google-Smtp-Source: ABdhPJzbkeAav82gW0FcOhV4mPAE+h6n9rG6diJsRhQEjaQXJBe6SFz6fbWWJnZuOg3r+jq0Rj51nCe/RKh/l4mfWGg=
X-Received: by 2002:a63:a10a:: with SMTP id b10mr5414819pgf.227.1644139086161;
 Sun, 06 Feb 2022 01:18:06 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.v4.git.1643136134.gitgitgadget@gmail.com>
 <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com> <1bd5f26271c9b1cff6c920bb91738ae903dccc61.1643641259.git.gitgitgadget@gmail.com>
In-Reply-To: <1bd5f26271c9b1cff6c920bb91738ae903dccc61.1643641259.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 6 Feb 2022 04:17:55 -0500
Message-ID: <CAPig+cS-3CxxyPGcy_vkeN_WYTRo1b-ZhJNdPy8ARZSNKkF1Xg@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] Documentation: add extensions.worktreeConfig details
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 31, 2022 at 10:01 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> [...]
> Expand the documentation to help users discover the complexities of
> extensions.worktreeConfig by adding details and cross links in these
> locations (relative to Documentation/):
> [...]
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

A few minor comments, which can be addressed later or not at all, and
likely are not worth holding up the series...

> diff --git a/Documentation/config/extensions.txt b/Documentation/config/extensions.txt
> @@ -6,3 +6,34 @@ extensions.objectFormat::
> +extensions.worktreeConfig::
> +       If enabled, then worktrees will load config settings from the
> +       `$GIT_DIR/config.worktree` file in addition to the
> +       `$GIT_COMMON_DIR/config` file. Note that `$GIT_COMMON_DIR` and
> +       `$GIT_DIR` are the same for the main worktree, while other
> +       worktrees have `$GIT_DIR` equal to
> +       `$GIT_COMMON_DIR/worktrees/<worktree-name>/`. The settings in the
> +       `config.worktree` file will override settings from any other
> +       config files.

There have been some efforts[1][2] in the past to settle upon the term
"working tree" instead of "worktree" when talking about worktrees in
prose. (The term "worktree" is perfectly fine in paths, such as
`.git/worktrees/`, and in the command name `git worktree`, of course.)

Documentation/git-worktree.txt calls it "<id>" rather than
"<worktree-name>" since it is a unique identifier for the worktree
which may or may not match the worktree's basename.

Documentation/git-worktree.txt talks simply about the path
`.git/worktrees/` under the assumption that people will understand
that `.git/` is the repository's common directory (which may not even
be named `.git/` for a bare repository). Although saying
$GIT_COMMON_DIR is certainly technically accurate, the simpler `.git/`
doesn't seem to have caused any consternation. (Not a big deal. I
mention it only to highlight the inconsistency between the existing
and new documentation added here.)

The same comments apply to the rest of the patch.

[1]: bc483285b7 (Documentation/git-worktree: consistently use term
"linked working tree", 2015-07-20)
[2]: 4f375b2678 (git-worktree.txt: consistently use term "working
tree", 2020-08-03)
