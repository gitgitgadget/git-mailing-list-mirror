Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C00C34031
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 03:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583A7206D5
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 03:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uch3d6C6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgBRDbG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 22:31:06 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42982 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgBRDbG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 22:31:06 -0500
Received: by mail-ot1-f66.google.com with SMTP id 66so18177499otd.9
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 19:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QWBIpBZuh5GMvx9TylJtedaCPS7Wi3hLqZo+PvAGYBA=;
        b=uch3d6C6JW/2f6R2+hM8Mkkmt8FBZ+1MrceNZd5h2WEqU17GgMtuMWBeDq6c1WkLjN
         EjURXCcXui1PSiow5viVpJkClhahje6ZWxgJQCA3foyUsQAhHrWDpDBz13YifDgE092O
         6idsOiOmAmsNmFS2w8UAFg6qCEqdW4B2aWj7idJWHws0cXpWE8A/6mRSSRx4jZAybxOg
         GwYt0LYaH6Z8vKFSNI717Ie928QudiQIKxCiw2I23CBIVHhWBQKLTJVxIVvo5t4PassQ
         m8oTeKXub/wcTKjiBTK+fy6h/om+GAsw+pe6Y2DBHclMUTW0vvs9QuLCJy8TmZgnYpgb
         LHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QWBIpBZuh5GMvx9TylJtedaCPS7Wi3hLqZo+PvAGYBA=;
        b=FBq6i3UGaLPdR0LLgQFFdFcS5uGPQ6s9/yJmGsa+Ug0H3/R5C89Bx7EhxeMwJnNFi3
         jagxO4yMuTLXtmmPZ9pkqzEveNBhN4d7ydXa8JfyGzC/hJarrnzg2aeTczypK+ONOv4o
         HX/ZlG/4abglkxBmQywFljXbfbQ2ppss5Tx+jebqRxPPlCyceOjcb6NFLcNrAwrCP1Vf
         2eTrn+7yqN/03jwPW4xghR4GnfHDE2dtptnIlgJ2V3lubqYW3OM16xS3ud5ALGcrO0up
         O0htqjVkH8rNbWppAMY0iRqf+YDiHc0XCBphP4upa2PzWHIyETH5CHOitNldxURTzmbO
         MBFA==
X-Gm-Message-State: APjAAAWnSpMTukuEcXOlfC6aD/9OaH/mSPsYdHjgCUI78S7wnuGmqCAs
        xuBLDzpps4DOX2FVyJNj7SkcVWa2tFrWZ5VBDO5GqzhP
X-Google-Smtp-Source: APXvYqzrvWeMbkfCpMGo5yX9Nh3CwDURbvlHCE8kivf500uRRlChvAra9dTAKXqAgC09wLuV6tOoUV80MH1NDyieyKM=
X-Received: by 2002:a9d:6457:: with SMTP id m23mr14685636otl.162.1581996664956;
 Mon, 17 Feb 2020 19:31:04 -0800 (PST)
MIME-Version: 1.0
References: <xmqq36b8lvdl.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36b8lvdl.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 17 Feb 2020 19:30:53 -0800
Message-ID: <CABPp-BEFQs4LL0uwkZSpXb_wxo7Wk-gEQSsv-=4B5ja5H1xXTg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2020, #04; Mon, 17)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 17, 2020 at 2:09 PM Junio C Hamano <gitster@pobox.com> wrote:

> * en/fill-directory-exponential (2020-01-31) 6 commits
>  - t7063: blindly accept diffs
>  - dir: replace exponential algorithm with a linear one
>  - dir: refactor treat_directory to clarify control flow
>  - dir: fix confusion based on variable tense
>  - dir: fix broken comment
>  - dir: consolidate treat_path() and treat_one_path()
>
>  The directory traversal code had redundant recursive calls which
>  made its performance characteristics exponential wrt the depth of
>  the tree, which was corrected.
>
>  Still RFC?
>  cf. <pull.700.v2.git.git.1580495486.gitgitgadget@gmail.com>
>  cf. <CABPp-BF0SO92wxY-dM14Vxv6BGA5=T=CicdwbiaZ7c9w6-j2jQ@mail.gmail.com>

Yes, sorry.  I was hoping someone familiar with untracked-cache (or
even just the index format) could comment and provide some pointers,
but it looks like that won't be happening.  I'll try to dig in this
week to figure out what to do there.


> * en/rebase-backend (2020-02-16) 20 commits
>  - rebase: rename the two primary rebase backends
>  - rebase: change the default backend from "am" to "merge"
>  - rebase: make the backend configurable via config setting
>  - rebase tests: repeat some tests using the merge backend instead of am
>  - rebase tests: mark tests specific to the am-backend with --am
>  - rebase: drop '-i' from the reflog for interactive-based rebases
>  - git-prompt: change the prompt for interactive-based rebases
>  - rebase: add an --am option
>  - rebase: move incompatibility checks between backend options a bit earlier
>  - git-rebase.txt: add more details about behavioral differences of backends
>  - rebase: allow more types of rebases to fast-forward
>  - t3432: make these tests work with either am or merge backends
>  - rebase: fix handling of restrict_revision
>  - rebase: make sure to pass along the quiet flag to the sequencer
>  - rebase, sequencer: remove the broken GIT_QUIET handling
>  - t3406: simplify an already simple test
>  - rebase (interactive-backend): fix handling of commits that become empty
>  - rebase (interactive-backend): make --keep-empty the default
>  - t3404: directly test the behavior of interest
>  - git-rebase.txt: update description of --allow-empty-message
>
>  "git rebase" has learned to use the sequencer backend by default,
>  while allowing "--am" option to go back to the traditional "am"
>  backend.
>
>  The last step may be rushing things a bit and may want to be
>  taken separately.
>  cf. <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>

Thanks.  I'm curious, though, what you mean by this last bit -- was it
just a reflection of my request for folks to comment on whether the
last patch was wanted?

In my view, taking the last patch separately does not make sense; it
should either be dropped entirely or taken close to the same time as
the series.  My reasoning for this is as follows: The only place the
current backend names exist is in the documentation.  The cost of
changing the names is thus low.  Once this series lands, the backend
names will be exposed in the user interface.  If we cut a release with
those names, then changing the names will require a bunch of
transition work.  So, if we're going to change the backend names, it'd
be better to do it sooner (while the cost is negligible) rather than
later.

So far, Phillip has voiced an opinion on this (cf.
<e2863381-174c-a55c-bb22-0c7aec9cabf4@gmail.com>) -- "I think it is a
good idea - merge and apply make much more sense that interactive and
am"; haven't heard from anyone else yet.
