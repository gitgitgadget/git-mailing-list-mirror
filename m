Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229D5C433EF
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 21:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbhL0VL2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 16:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhL0VL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 16:11:27 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CFEC06173E
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 13:11:27 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id f5so66069710edq.6
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 13:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hqJqp5ONZU1TBYJ8NhWnGqoE7+4THe5f67L7poboIds=;
        b=WrwVbkqNaE5pazT/38KcatlcsDmUjvEEydpNMoJmfga9qxONezNuWPUTVxfw0pli3J
         +mMh8r8Z/1/xUzXqRI4vd+LfCVvDFVh6TxcA9ZyrH/TJITc5IwfeFiJwbzKS9saqxQel
         3ANHlwcJK3du0tvvn9PY9mZgH5llg72kebdFkLYScDHugfZGP631/7KVnIrcLgq+ec8p
         +se2/gGTXxOilGn8RptcQTksU4QuAKcsS3BFSwZuTYIRv1c74mb39gCX6nCbeQpJ27sj
         e2G8L0YINVzmEXzy7M+BQOKs5rgcK363Lp+opjJ33aRNsGJy8gUjP3a+mx8ShnwYyaP7
         Ggzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hqJqp5ONZU1TBYJ8NhWnGqoE7+4THe5f67L7poboIds=;
        b=p7WkDuyUXHRQJHenC4b6jMQTzPQPvbGt3XfLFwzmEp1GiFJ4Hb5rAjG9KuyEVMz9Fc
         RSzYTfpAi+KPM6lrEB/XzF5xDtYMeg+5bevkyxmRyDOBI2MEaGrwBoTD+ysbCB/ogOMk
         q0fzkJftwtIIPMnfNoDdSj04g8TLNZcp1ZJzs/1BdwfvlCrQ7Uso4lLOKFhdqk9WAjE0
         +ruOJ4uovQfDtBaEboMPwLTiPqHXb0uy/3gVbY2PD/f6R50dp41tqGVgOgLkFBHJFwPU
         NXAz+YV7pK2ZrjdXz7x8cP+7CO0NVmE1jBOS43IZelk8LXFwgwNUlC68lYcJw81aSklv
         HrwQ==
X-Gm-Message-State: AOAM531MOpll66IPcB7NOhLqcqnvL11/Q9h/+U0rWF5mdyc8bUS5buQY
        Fp3bAZEbFq08SSgreRosufXGmeGGjdLC+79k2lVD4e71nQ85BQ==
X-Google-Smtp-Source: ABdhPJy32Cx/YMLLnweEHgD1kLuSG4re2WUEPXfgNPsweG3kcOWO28EN3PQ6yXqZM6qWfs3awwanb8+wKtIwXS3uItY=
X-Received: by 2002:a17:907:968a:: with SMTP id hd10mr14713451ejc.269.1640639485594;
 Mon, 27 Dec 2021 13:11:25 -0800 (PST)
MIME-Version: 1.0
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
 <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com> <211226.86lf07f1c5.gmgdl@evledraar.gmail.com>
In-Reply-To: <211226.86lf07f1c5.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 27 Dec 2021 13:11:13 -0800
Message-ID: <CABPp-BFjZUHKq1OxkgompqbaugCN=c5PFiGxLp9U1sdBePpYvA@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Add a new --remerge-diff capability to show & log
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 26, 2021 at 2:28 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Sat, Dec 25 2021, Elijah Newren via GitGitGadget wrote:
>
> > =3D=3D=3D FURTHER BACKGROUND (original cover letter material) =3D=3D
> >
> > Here are some example commits you can try this out on (with git show
> > --remerge-diff $COMMIT):
> >
> >  * git.git conflicted merge: 07601b5b36
> >  * git.git non-conflicted change: bf04590ecd
> >  * linux.git conflicted merge: eab3540562fb
> >  * linux.git non-conflicted change: 223cea6a4f05
> >
> > Many more can be found by just running git log --merges --remerge-diff =
in
> > your repository of choice and searching for diffs (most merges tend to =
be
> > clean and unmodified and thus produce no diff but a search of '^diff' i=
n the
> > log output tends to find the examples nicely).
> >
> > Some basic high level details about this new option:
> >
> >  * This option is most naturally compared to --cc, though the output se=
ems
> >    to be much more understandable to most users than --cc output.
> >  * Since merges are often clean and unmodified, this new option results=
 in
> >    an empty diff for most merges.
> >  * This new option shows things like the removal of conflict markers, w=
hich
> >    hunks users picked from the various conflicted sides to keep or remo=
ve,
> >    and shows changes made outside of conflict markers (which might refl=
ect
> >    changes needed to resolve semantic conflicts or cleanups of e.g.
> >    compilation warnings or other additional changes an integrator felt
> >    belonged in the merged result).
> >  * This new option does not (currently) work for octopus merges, since
> >    merge-ort is specific to two-parent merges[1].
> >  * This option will not work on a read-only or full filesystem[2].
> >  * We discussed this capability at Git Merge 2020, and one of the
> >    suggestions was doing a periodic git gc --auto during the operation =
(due
> >    to potential new blobs and trees created during the operation). I fo=
und a
> >    way to avoid that; see [2].
> >  * This option is faster than you'd probably expect; it handles 33.5 me=
rge
> >    commits per second in linux.git on my computer; see below.
> >
> > In regards to the performance point above, the timing for running the
> > following command:
> >
> > time git log --min-parents=3D2 --max-parents=3D2 $DIFF_FLAG | wc -l
>
> I've been trying to come up with some other useful recipies for this new
> option (which is already very useful, thanks!)

I'm glad you like it.  :-)

> Some of these (if correct) are suggestions for incorporating into the
> (now rather sparse) documentation. I.e. walking users through how to use
> this, and how (if at all) it combines with other options.
>
> I wanted to find all merges between "master".."seen" for which Junio's
> had to resolve a conflict, a na=C3=AFve version is:
>
>     $ git log --oneline --remerge-diff -p --min-parents=3D2 origin/master=
..origin/seen|grep ^diff -B1 | grep Merge
>     [...]

I think the naive version is
  $ git log --remerge-diff --min-parents=3D2 origin/master..origin/seen
  <search for "^diff" using your pager's search functionality>

Where the "--min-parents=3D2 origin/master..origin/seen" comes from your
problem description ("find all merges between master..seen").

You can add --oneline to format it, though it's an orthogonal concern.
Also, adding -p is unnecessary: --remerge-diff, like --cc, implies -p.

> But I found that this new option nicely integrates with --diff-filter,
> i.e. we'll end up showing a diff, and the diff machinery allows you to
> to filter on it.
>
> It seems to me like all the diffs you show fall under "M", so for

Yes, the diffs I happened to pick all fell under "M", but by no means
should you rely on that happening for all merges in history.  For
example, make a new merge commit, then add a completely new file (or
delete a file, or rename a file, or copy a file, or change its
mode/type), stage the new/deleted/renamed/copied/changed file, and run
"git commit --amend".

So, although --diff-filter=3DM can be interesting, I would not rely on it.

> master..seen (2ae0a9cb829..61055c2920d) this is equivalent (and the
> output is the same as the above):
>
>     $ git -P log --oneline --remerge-diff --no-patch --min-parents=3D2 --=
diff-filter=3DM origin/master..origin/seen
>     95daa54b1c3 Merge branch 'hn/reftable-fixes' into seen
>     26c4c09dd34 Merge branch 'gc/fetch-negotiate-only-early-return' into =
seen
>     e3dc8d073f6 Merge branch 'gc/branch-recurse-submodules' into seen
>     aeada898196 Merge branch 'js/branch-track-inherit' into seen
>     4dd30e0da45 Merge branch 'jh/builtin-fsmonitor-part2' into seen
>     337743b17d0 Merge branch 'ab/config-based-hooks-2' into seen
>     261672178c0 Merge branch 'pw/fix-some-issues-in-reset-head' into seen
>     1296d35b041 Merge branch 'ms/customizable-ident-expansion' into seen
>     7a3d7d05126 Merge branch 'ja/i18n-similar-messages' into seen
>     eda714bb8bc Merge branch 'tb/midx-bitmap-corruption-fix' into seen
>     ba02295e3f8 Merge branch 'jh/p4-human-unit-numbers' into jch
>     751773fc38b Merge branch 'es/test-chain-lint' into jch
>     ec17879f495 Merge branch 'tb/cruft-packs' into tb/midx-bitmap-corrupt=
ion-fix
>
> However for "origin/master..origin/next" (next =3D 510f9eba9a2 currently)
> we'll oddly show this with "-p":
>
>     9af51fd1d0d Sync with 'master'
>     diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
>     CONFLICT (content): Merge conflict in t/lib-gpg.sh
>     d6f56f3248e Merge branch 'es/test-chain-lint' into next
>     diff --git a/t/t4126-apply-empty.sh b/t/t4126-apply-empty.sh
>     CONFLICT (content): Merge conflict in t/t4126-apply-empty.sh
>     index 996c93329c6..33860d38290 100755
>     --- a/t/t4126-apply-empty.sh
>     +++ b/t/t4126-apply-empty.sh
>     [...]
>
> The "oddly" applying only to that "9af51fd1d0d Sync with 'master'", not
> the second d6f56f3248e, which shows the sort of conflict I'd expect. The
> two-line "diff" of:
>
>     diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
>     CONFLICT (content): Merge conflict in t/lib-gpg.sh
>
> Shows up with -p --remerge-diff, not a mere -p. I also tried the other
> --diff-merges=3D* options, that behavior is new in
> --diff-merges=3Dremerge. Is this a bug?

Ugh, this is related to my comment elsewhere that conflicts from inner
merges are not nicely differentiated.  If I also apply my other series
(which has not yet been submitted), this instead appears as follows:

$ git show --oneline --remerge-diff 9af51fd1d0d
9af51fd1d0 Sync with 'master'
diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
  From inner merge:  CONFLICT (content): Merge conflict in t/lib-gpg.sh

and the addition of the "From inner merge: " text makes it clearer why
that line appears.  This is an interesting case where a conflict
notice _only_ appears in the inner merge (i.e. the merge of merge
bases), which means that both sides on the outer merge changed the
relevant portion of the file in the same way, so the outer merge had
no conflict.

However, instead of trying to differentiate messages from inner
merges, I think for --remerge-diff's purposes we should just drop all
notices that come from the inner merges.  Those conflict notices might
be helpful when initially resolving a merge, but at the --remerge-diff
level, they're more likely to be distracting than helpful.

> My local build also has a --pickaxe-patch option. It's something I
> submitted on-list before[1] and have been meaning to re-roll.
>
> I'm discussing it here because it skips the stripping of the "+ " and "-
> " prefixes under -G<regex> and allows you to search through the -U<n>
> context. With that I'm able to do:
>
>     git log --oneline --remerge-diff -p --min-parents=3D2 --pickaxe-patch=
 -G'^\+' --diff-filter=3DM origin/master..origin/seen
>
> I.e. on top of the above filter only show those diffs that have
> additions. FAICT the conflicting diffs where the committer of the merge
> conflict picked one side or the other will only have "-" lines".
>
> So those diffs that have additions look to be those where the person
> doing the merge needed to combine the two.
>
> Well, usually. E.g. 26c4c09dd34 (Merge branch
> 'gc/fetch-negotiate-only-early-return' into seen, 2021-12-25) in that
> range shows that isn't strictly true. Most such deletion-only diffs are
> less interesting in picking one side or the other of the conflict, but
> that one combines the two:
>
>     -<<<<<<< d3419aac9f4 (Merge branch 'pw/add-p-hunk-split-fix' into see=
n)
>                             warning(_("protocol does not support --negoti=
ate-only, exiting"));
>     -                       return 1;
>     -=3D=3D=3D=3D=3D=3D=3D
>     -                       warning(_("Protocol does not support --negoti=
ate-only, exiting."));
>                             result =3D 1;
>                             goto cleanup;
>     ->>>>>>> 495e8601f28 (builtin/fetch: die on --negotiate-only and --re=
curse-submodules)
>
> Which I guess is partially commentary and partially a request (either
> for this series, or some follow-up) for something like a
> --remerge-diff-filter option. I.e. it would be very useful to be able to
> filter on some combination of:
>
>  * Which side(s) of the conflict(s) were picked, or a combination?
>  * Is there "new work" in the diff to resolve the conflict?
>    AFIACT this will always mean we'll have "+ " lines.

Do any of the following count as "new work"? :

  * the deletion of a file (perhaps one that had no conflict but was
deleted anyway)
  * mode changes (again, perhaps on files that had no conflict)
  * renames of files/directories?

If so, searching for "^+" lines might be insufficient, but it depends
on what you mean by new work.

> Or maybe that's not useful at all, and just -G<rx> (maybe combined with
> my --pickaxe-patch) will cover it?

I'd rather wait until we have a good idea of the potential range of
usecases before adding a filter.  (And I think for now, the -G and
--pickaxe-patch are probably good enough for this usecase.)  These
particular usecases you point out are interesting; thanks for
detailing them.  Here's some others to consider:

  * Finding out when text was added or removed: `git log
--remerge-diff -S<text>` (note that with only -p instead of
--remerge-diff, that command will annoyingly misses cases where a
merge introduced or removed the text)
  * Finding out how a merge differed from one run with some
non-default options (e.g. `git show --remerge-diff -Xours` or `git
show --remerge-diff -Xno-space-change`; although show doesn't take -X
options so this is just an idea at this point)
  * Finding out how a merge would have differed had it been run with
different options (so instead of comparing a remerge to the merge
recorded in history, compare one remerge with default options with a
different merge that uses e.g. -Xno-space-change)

Also, I've got a follow-up series that also introduces a
--remerge-diff-only flag which:
  * For single parent commits that cannot be identified as a revert or
cherry-pick, do not show a diff.
  * For single parent commits that can be identified as a revert or
cherry-pick, instead of showing a diff against the parent of the
commit, redo the revert or cherry-pick in memory and show a diff
against that.
  * For merge commits, act the same as --remerge-diff
