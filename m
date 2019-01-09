Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C30B1F803
	for <e@80x24.org>; Wed,  9 Jan 2019 17:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfAIRm2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 12:42:28 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:44575 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbfAIRm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 12:42:28 -0500
Received: by mail-ed1-f41.google.com with SMTP id y56so7982117edd.11
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 09:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R84XEK8z9zw6NFehcdMz7++ZzM8mPU9QcT8i/jKDK4o=;
        b=Hn/IDQRMw/wdgwsvSgMKm4lN+Yob2TRCpOHa+XocYIHgzi9qCdVemedd8jDxPoqAgY
         NWVucMtZx4/ZwgJW7/pGDhGtvulowOfnzgF8YkjMncknBjGJ5FTqTLS8Rt75SfQqZU4T
         QIGUrivmssi7KRbZzA7GgRPfOuGG93nVZe8OABNhr7eVCsHqEbl2Yhx6pz6yxtRdiwT7
         zObGK+onJCX4cJfIDfPOw0q9uCc2HRYbiVc/CeI/yVZxZYQo4EaBCqx6H0TiXbbvZGQY
         44tgK+gqWkn+owFDoGKzBwzzUN1AZJ4uA3eqFJJIn1Aj3u5Zd95NTjglyI965e0G2F6t
         nmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R84XEK8z9zw6NFehcdMz7++ZzM8mPU9QcT8i/jKDK4o=;
        b=iASDav9gZe1zIpV8ll2TlpfeD1FVWcSzoZ5MZIdJFUyWHjQueKSwIi2jW8r8l8lPDX
         gLpOg11MaDyoZ3acQ2+F22XDE2Wl7nV67LpEVVeL6ZDIpI/EBik2PqPFOQ4mrg2dLX8n
         kcKwLPzixtkF7Dhyye5qEmqRJhKEDJyUEQYeO5I230EFNZUH/uc3KGhHotUvPgQWZMNM
         XCS+2ze2W8jitPMpARyjN0TgcOJbsiiZCzUJet5SBDCc64HYAYg8M7Jahh/euxaBsEdl
         HH//LObx2k5K6vPsHatSzBbUR8hWupwNc0pzP+8tMv3im+pYPHEBiDMRpOyPwyVDtXyG
         Zd2A==
X-Gm-Message-State: AJcUukfR2gs9Pkb5waEFPUYycg5QYu36aM0pCfNWh5Q40XXGM+VSOZXl
        14kGz4BfHtChjCB2Ouz8zpyWdiJFDTQgqS3SLQD27A==
X-Google-Smtp-Source: ALg8bN60vjihgqoiUgUpqaoOjK1wVyVY/faabtRjTp/2MtLHi1GU6DFItyJ6ARl6IZag205xdf01vDuPv1E99WlyVnQ=
X-Received: by 2002:a17:906:681a:: with SMTP id k26-v6mr6092717ejr.62.1547055745924;
 Wed, 09 Jan 2019 09:42:25 -0800 (PST)
MIME-Version: 1.0
References: <CAG0vfyQeA3Hm7AsYgYtP4v-Yg0=rKXW0YYfg_emAwEscZha4VA@mail.gmail.com>
In-Reply-To: <CAG0vfyQeA3Hm7AsYgYtP4v-Yg0=rKXW0YYfg_emAwEscZha4VA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 9 Jan 2019 09:42:14 -0800
Message-ID: <CAGZ79kZBwocC=UzjW+DxodwJkQZ2mNMYNjsk6sL4SCqdhGoQ7w@mail.gmail.com>
Subject: Re: Regression: submodule worktrees can clobber core.worktree config
To:     =?UTF-8?Q?Tomasz_=C5=9Aniatowski?= <tsniatowski@vewd.com>,
        Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 8, 2019 at 2:16 PM Tomasz =C5=9Aniatowski <tsniatowski@vewd.com=
> wrote:
>
> After upgrading to 2.20.1 I noticed in some submodule+worktree scenarios =
git
> will break the submodule configuration. Reproducible with:
>     git init a && (cd a; touch a; git add a; git commit -ma)
>     git init b && (cd b; git submodule add ../a; git commit -mb)
>     git -C b worktree add ../b2
>     git -C b/a worktree add ../../b2/a
>     git -C b status
>     git -C b2 submodule update
>     git -C b status
>
> The submodule update in the _worktree_ puts an invalid core.worktree valu=
e in
> the _original_ repository submodule config (b/.git/modules/a/config), cau=
sing
> the last git status to error out with:
>     fatal: cannot chdir to '../../../../../../b2/a': No such file or dire=
ctory
>     fatal: 'git status --porcelain=3D2' failed in submodule a
>
> Looking at the config file itself, the submodule update operation applies=
 the
> following change (the new path is invalid):
>     -       worktree =3D ../../../a
>     +       worktree =3D ../../../../../../b2/a
>
> This worked fine on 2.19.2 (no config change, no error), and was useful t=
o have
> a worktree with (large) submodules that are also worktrees.

Thanks for reporting the issue!

>
> Bisects down to:
> 74d4731da1 submodule--helper: replace connect-gitdir-workingtree by
> ensure-core-worktree

So this would need to update the worktree config, not the generic config.

We'd need to replace the line
    cfg_file =3D repo_git_path(&subrepo, "config");
in builtin/submodule--helper.c::ensure_core_worktree()
to be a worktree specific call.

Or the other way round we'd want to make repo_git_path to
be worktree specific and introduce repo_common_path for
the main working tree.

Looking at Duys tree,
https://gitlab.com/pclouds/git/commit/94751ada7c32eb6fb2c67dd7723161d1955a5=
683
is pretty much what we need.

Reverting that topic that introduced this (4d6d6e,
Merge branch 'sb/submodule-update-in-c'), might be possible but
that would conflict with another followup that fixes issues in
that series
(see sb/submodule-unset-core-worktree-when-worktree-is-lost
https://github.com/gitster/git/commits/sb/submodule-unset-core-worktree-whe=
n-worktree-is-lost)
so I'd rather just cherry-pick the commit from Duy.

Stefan
