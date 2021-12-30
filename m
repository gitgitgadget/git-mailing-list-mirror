Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABDEC433F5
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 18:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240204AbhL3SiU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 13:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbhL3SiT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 13:38:19 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E6DC061574
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 10:38:19 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id z29so101129391edl.7
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 10:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NT7+UT15kq6Or8BExPifeHwJejcxYs06mQiM7xA20rU=;
        b=cIEibz3r9sZ94PEg47LaegUsEUW0ZbiIrjkz6tS9Ztd2lHkrczS6EYQ3K0NvlFWF29
         UOdheJc4STPdKj0IVI+4nnGMDfgRR6smXMUNYuOkBWWsPOF1HEEKGivoqinA5p51Or6F
         1zjuv5oEoOTAGNPuZkz3NVEYvYwnC80djaGGk5xFp3+GCoVwT+ZrbAvtgISnfOeEgeiG
         CakRHA64IJspILaSJ02Hwe1iOc9n14yRv1QJoaOt7rwK7kGQN+bDjuqBsgf/ZAAqGj6o
         QsBnCZuQauBXfr3FnoGzqlyq/w3DEvtGdF94yQx8JPVj5b9hIjKQUA0SuhYyIXixLBMc
         RX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NT7+UT15kq6Or8BExPifeHwJejcxYs06mQiM7xA20rU=;
        b=N+mi//2/bqkAu5HxaIMBf58MlXH78lc6VzSWFlSL2IjPYGL50eK5ZUrrm22cYrOwWn
         u/ztzQEt0a9Em3B5wRJnIjYtQm6W8Ri2j4chAghHtBp8OeX7HcYiBDJ/IAQu8GQ9T583
         6hu2Hiskfa5sdjSaeB8+6fkdQ4D3rFTpRFpA8hye5TzaYmS/LWNG1iRYGA3mZyhLo7vJ
         jltxrZE0/0VzIfbzcuJKzrtT+qQnSjkxsKPaCIs4J+mOHtGIH04I6LKPBWY4Mt8lown9
         rXyDiHpNaOkeWNDuflER4VHgjo1Aez/j7WdjnWs+h9IpabbdVFz0M+C2D4ynFcjqXDbM
         6XcA==
X-Gm-Message-State: AOAM530FpnIqMV5UGtma25uoqsL3xIq8Rxtf+FtB6MtB7+K5z0bwYIxA
        HtagEOIPwAv3h4xBo/GCbBT1/QlRfDuoK8n/RI8=
X-Google-Smtp-Source: ABdhPJzwH4PnFeqNrMt+gDq/UC+Se2CgQ/LPib4FhqV7pJuYDJe2WJmhR+BGWbMRNtfEOESbKfK3AgeS3kyUWyn+9jc=
X-Received: by 2002:a17:907:9808:: with SMTP id ji8mr26636644ejc.476.1640889497769;
 Thu, 30 Dec 2021 10:38:17 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
 <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com> <CABPp-BG7nwsdEYrnfqhAbWU4ndJHcqGf6RS_6DzJittuNVLvoA@mail.gmail.com>
 <CAPig+cRDDGU=9BB6kd1tMJR8DmWKSSJwpTD8JeszrY685Fc3-Q@mail.gmail.com>
 <CABPp-BFxz5B_wUubzaYeGEaztALqDMxxVTrcT4d1kKjpX8pRDQ@mail.gmail.com>
 <CAPig+cRYKKGA1af4hV0fz_nZWNG=zMgAziuAimDxWTz6L8u3Tg@mail.gmail.com>
 <CABPp-BGKyDJV9DP+igmCC_Ad0jgvb4aOAYpXWCbx9hW8ShhDQg@mail.gmail.com> <CAPig+cRJj4Aa9Nm_yWD0=WGdn9tRmT2PpTwo5yeGZHg2Qz2rgA@mail.gmail.com>
In-Reply-To: <CAPig+cRJj4Aa9Nm_yWD0=WGdn9tRmT2PpTwo5yeGZHg2Qz2rgA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 Dec 2021 10:38:06 -0800
Message-ID: <CABPp-BH-oOUhTzcXMFWRfG=zjUw6C5h-oHSU=-juPTjpW92_vA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Sparse checkout: fix bug with worktree of bare repo
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 29, 2021 at 10:41 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Tue, Dec 28, 2021 at 1:16 PM Elijah Newren <newren@gmail.com> wrote:
> > On Mon, Dec 27, 2021 at 11:33 PM Eric Sunshine <sunshine@sunshineco.com> wrote:

> > > A more general approach might be for the new worktree to copy all the
> > > per-worktree configuration from the worktree in which the command was
> > > invoked, thus sparsity would be inherited "for free" along with other
> > > settings. This has the benefits of not requiring sparse-checkout
> > > special-cases in the code and it's easy to document ("the new worktree
> > > inherits/copies configuration settings from the worktree in which `git
> > > worktree add` was invoked") and easy to understand.
> >
> > Ooh, this is a good point and I *really* like this simple solution.
> > Thanks for pointing it out.
>
> I do wonder, though, if there are traps waiting for us with this
> all-inclusive approach. I don't know what sort of worktree-specific
> configuration people use, so I do worry a bit that this could be
> casting a too-wide net, and that it might in fact be better to only
> copy the sparse-checkout settings (as ugly as it is to special-case
> that -- but we need to special-case `core.bare` and `core.worktree`
> anyhow[1]).
>
> [1]: https://lore.kernel.org/git/CAPig+cSUOknNC9GMyPvAqdBU0r1MVgvSpvgpSpXUmBm67HO7PQ@mail.gmail.com/

I could probably be persuaded either way (do users want to copy
something and tweak it, or start with a clean slate?), and it might
even make sense to have a flag for users to specify.

My hunch, at least with the developers I work with, is that they're
more likely to think in terms of "I want another worktree like this
one, except that I'm going to change..."

Also, another reason to prefer copying all of core.worktree (minus the
always worktree-specific value of core.worktree, and core.bare), is
because it's easy to explain in the documentation, and I think we'd be
much less likely to obsolete user's knowledge over time.  (I think
additional sparse-checkout things, or new other features that also
want to be copied over, are much more likely than the addition of keys
that are always worktree-specific like core.worktree).

...
> > An increasingly unworkable alternative is the current behavior of
> > defaulting to a full checkout in all cases (and forcing users to
> > sparsify afterwards).  A full checkout is fine if the user came from
> > one (and probably preferable in such a case), but it's increasingly
> > problematic for us even with our repo being nowhere near the size of
> > the microsoft repos.
>
> It feels unfortunate and a bit dirty to spread around this
> special-case knowledge about sparse-checkout to various parts of the
> system,

This might makes things worse, but it's far too late to avoid that:

$ git grep -il -e sparse-checkout -e skip_worktree
.gitignore
Documentation/RelNotes/2.19.0.txt
Documentation/RelNotes/2.25.0.txt
Documentation/RelNotes/2.26.0.txt
Documentation/RelNotes/2.27.0.txt
Documentation/RelNotes/2.28.0.txt
Documentation/RelNotes/2.34.0.txt
Documentation/RelNotes/2.6.0.txt
Documentation/config/checkout.txt
Documentation/config/core.txt
Documentation/git-add.txt
Documentation/git-checkout.txt
Documentation/git-clone.txt
Documentation/git-read-tree.txt
Documentation/git-restore.txt
Documentation/git-rm.txt
Documentation/git-sparse-checkout.txt
Documentation/git-worktree.txt
Documentation/gitrepository-layout.txt
Documentation/rev-list-options.txt
Documentation/technical/index-format.txt
Documentation/technical/parallel-checkout.txt
Documentation/technical/sparse-index.txt
Makefile
advice.c
apply.c
attr.c
builtin/add.c
builtin/check-ignore.c
builtin/checkout.c
builtin/clone.c
builtin/commit.c
builtin/grep.c
builtin/ls-files.c
builtin/mv.c
builtin/read-tree.c
builtin/rm.c
builtin/sparse-checkout.c
builtin/stash.c
builtin/update-index.c
cache-tree.c
cache.h
command-list.txt
contrib/completion/git-prompt.sh
diff-lib.c
diff.c
dir.c
dir.h
entry.c
git.c
list-objects-filter.c
list-objects-filter.h
merge-ort.c
merge-recursive.c
path.c
pathspec.c
pathspec.h
po/bg.po
po/ca.po
po/de.po
po/el.po
po/es.po
po/fr.po
po/git.pot
po/id.po
po/it.po
po/ko.po
po/pl.po
po/pt_PT.po
po/ru.po
po/sv.po
po/tr.po
po/vi.po
po/zh_CN.po
po/zh_TW.po
preload-index.c
read-cache.c
sparse-index.c
sparse-index.h
t/perf/p0005-status.sh
t/perf/p0006-read-tree-checkout.sh
t/perf/p0007-write-cache.sh
t/perf/p2000-sparse-operations.sh
t/perf/repos/inflate-repo.sh
t/perf/repos/many-files.sh
t/t0060-path-utils.sh
t/t1011-read-tree-sparse-checkout.sh
t/t1090-sparse-checkout-scope.sh
t/t1091-sparse-checkout-builtin.sh
t/t1092-sparse-checkout-compatibility.sh
t/t2018-checkout-branch.sh
t/t3507-cherry-pick-conflict.sh
t/t3602-rm-sparse-checkout.sh
t/t3705-add-sparse-checkout.sh
t/t5317-pack-objects-filter-objects.sh
t/t6112-rev-list-filters-objects.sh
t/t6428-merge-conflicts-sparse.sh
t/t6435-merge-sparse.sh
t/t7002-mv-sparse-checkout.sh
t/t7012-skip-worktree-writing.sh
t/t7063-status-untracked-cache.sh
t/t7418-submodule-sparse-gitmodules.sh
t/t7519-status-fsmonitor.sh
t/t7817-grep-sparse-checkout.sh
unpack-trees.c
wt-status.c

>  but based upon the pain-points you describe, having a new
> worktree inherit the sparsity from the originating worktree does sound
> (given my limited knowledge of the topic) like it would ease the pain
> for users.

:-)
