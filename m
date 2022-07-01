Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA0AC433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 20:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbiGAUY5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 16:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiGAUYw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 16:24:52 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26C63526D
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 13:24:49 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id z13so5590470lfj.13
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 13:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zkMhs2J80RK6MJJ1b2ZTxVlnhq6uqb2RXXNCJwepjk8=;
        b=GVX1F5OR+djQYc6NJQ4uuSYZzFmxTj8k7ALP2yBkW7nG3Z7LtRXp/bHbzCJ0oy3h/y
         1S8NJDit04HEDWTJw5gqdIj4ioXjtlxO/2FKUYPaUSRoATG365rHHk2dAelOHWI/9Qnu
         0wzpku2DayhA7+84sDcKzH9c5IDA1iB/qttIWbAvhjnTx7/KAD0vOaQJuIo6r3lwHgTu
         8KruT5SnZusWuTD+y2kDTGvATGQQzGNyxQ5dZ5axVbeKIxDnVLsHE4y1QLhC6oeuRWhS
         DkIS43wRf01FfoILPScjtMEjcj0bGp6JZ1IHNqQyQAxaLvWfXlIKRmj4vnJgTvRFqCDz
         82Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zkMhs2J80RK6MJJ1b2ZTxVlnhq6uqb2RXXNCJwepjk8=;
        b=ZL95qVCdZM2nxlx5RW4yaLeqYjJIsNC2ir9tC1LRN44wb1EeYbY4S/6h2OyQtCu5qW
         0p0Y+6qkhl4uWZkU9+FAjCKJ7COVNymFrJp/SbLivAS9p2jC/2mhKBjrjtnuN4dlVPzN
         HY2jHGbTPlI8Ui7XcxxtFBQPYpC4pmd9FzWuxiTSBn4/BdIRO0FDCALgOkqTTOBbbQEz
         LtCCUUOdMJKj1b9n8klzqoItmP5PDWuVr7qqAyfKczDBXFQd14PVEDSQ8OFWS/JkOOS7
         VixPcjO8XHMLme83wsZZguFjeIQSvMmKFj1Y1HyUwWEpO/oKmfn06x5/30QNhD3FPDzQ
         RLQg==
X-Gm-Message-State: AJIora+teCkfd06kjZa78W/nHWlOOiz2OgLxOmfZ4C81nO3LPXjLCd41
        +J3ri0uV91wN797/9wNVCxxbJbZ2fG4dXBhrRmaNZDBy
X-Google-Smtp-Source: AGRyM1sZfiROlqzw1hl0aR9UTodYq/A0XuoGX+QX3z9bydCrRKoLkViLlx7cJKxGBoMhnBdWA7sQCeXZEnu6qMjl+8o=
X-Received: by 2002:ac2:514c:0:b0:481:286f:52b5 with SMTP id
 q12-20020ac2514c000000b00481286f52b5mr11165402lfd.536.1656707087908; Fri, 01
 Jul 2022 13:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAKSRnEzMaQEv=3mkNWRpy6+-c0rz=R191iqheCQ2ptXFs1CQgw@mail.gmail.com>
 <96034b3f-9811-38c1-7afe-c1c9dd243f0e@github.com> <CABPp-BHv3TSJhnWSF8AjF_nr72vMnOFXZJKoG0juGwjz13TZ=w@mail.gmail.com>
 <c5662c60-4a21-be94-8fe0-13c6730292dd@github.com> <CABPp-BFRHjF7+9T8dGG=ixsezksZUNU7pm29MG2kcLEYwE06Og@mail.gmail.com>
In-Reply-To: <CABPp-BFRHjF7+9T8dGG=ixsezksZUNU7pm29MG2kcLEYwE06Og@mail.gmail.com>
From:   Dian Xu <dianxudev@gmail.com>
Date:   Fri, 1 Jul 2022 16:24:36 -0400
Message-ID: <CAKSRnEx2seC41QCe8sQOPf0=VNqHB6GkZ3M_CpGmOZRS0FS1gA@mail.gmail.com>
Subject: Re: git bug report: 'git add' hangs in a large repo which has
 sparse-checkout file with large number of patterns in it
To:     Elijah Newren <newren@gmail.com>
Cc:     Victoria Dye <vdye@github.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria, Elijah, Derrick,

Thanks a lot for the detailed insight.

(Btw our company=E2=80=99s email mathworks.com is blocked by
mailto:git@vger.kernel.org, hope someone can help take a look)

1. We use a no-cone version of sparse-checkout to control the 'shape'
(set of scm files) of our source code. In this case, the local sandbox
is not necessarily 'sparse' (2m files), but it's very convenient that
we can use git to check out the exact amount (shape) of files. To
Victoria's question, all these 2m files are "H".

2. Below is the detail steps to create the local repo (sparse-checkout
was defined 'before' git checkout)
      % git init
      % git remote add origin <url>
      % git config core.sparsecheckout true
      % vi .git/info/sparse-checkout
      % git fetch
      % git checkout -b <SHA>
    Do I still need to 'git sparse-checkout reapply' after checkout?
(Thanks for pointing out to run reapply once .git/info/sparse-checkout
changed)

3. Unfortunately, after executing reapply (btw it is very slow on this
2m files * 16k patterns scenario: 30 mins), 'git add', and 'git add
--sparse' still hangs.

4. --cone is a big topic for us now, since 2.37.0 deprecates
--no-cone. We do have our own challenges to move away from --no-cone
(E.g. we use lots of file specifiers and/or exclusion patterns to
define our source code shape), which will be a huge amount of work, if
feasible. We've established a set of workflows based on --no-cone,
because of its merit of being capable of defining a fine-grained scm
shape.

5. Back to this case, what we've experimented on are:
      - Remove all files/*/! patterns from our shape definition, which
leave us with 14k directories (Obviously the scm shape no longe
matches, but just to proof of concept here)
      - 'git sparse-checkout set <14k directories>' finishes fast
      - 'git add' finishes fast
    As Victoria mentioned, I hope this --no-cone 'git add' performance
can be addressed because 'those performance gains can also be realized
in cone mode', as we saw here.

Again thank you for your help and looking forward to your thoughts.

Thanks,

Dian Xu
Mathworks, Inc
1 Lakeside Campus Drive, Natick, MA 01760
508-647-3583

On Thu, Jun 30, 2022 at 11:42 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Wed, Jun 29, 2022 at 10:06 PM Victoria Dye <vdye@github.com> wrote:
> >
> > Elijah Newren wrote:
> > > On Wed, Jun 29, 2022 at 3:04 PM Victoria Dye <vdye@github.com> wrote:
> > >>
> > >> Dian Xu wrote:
> > >>> Dear Git developers,
> > >>>
> > >>> Reporting Issue:
> > >>>               'git add' hangs in a large repo which has
> > >>> sparse-checkout file with large number of patterns in it
> > >>>
> > >>> Found in:
> > >>>               Git 2.34.3. Issue occurs after 'audit for interaction
> > >>> with sparse-index' was introduced in add.c
> > >>>
> > >>> Reproduction steps:
> > >>>               1. Clone a repo which has e.g. 2 million plus files
> > >>>               2. Enable sparse checkout by: git config core.sparsec=
heckout true
> > >>>               3. Create a .git/info/sparse-checkout file with a lar=
ge
> > >>> number of patterns, e.g. 16k plus lines
> > >>>               4. Run 'git add', which will hang>
> > >>> Investigations:
> > >>>               1. Stack trace:
> > >>>                        add.c: cmd_add
> > >>>                   -> add.c: prune_directory
> > >>>                   -> pathspec.c: add_pathspec_matches_against_index
> > >>>                   -> dir.c: path_in_sparse_checkout_1
> > >>>               2. In Git 2.33.3, the loop at pathspec.c line 42 runs
> > >>> fast, even when istate->cache_nr is at 2 million
> > >>>               3. Since Git 2.34.3, the newly introduced 'audit for
> > >>> interaction with sparse-index' (dir.c line 1459:
> > >>> path_in_sparse_checkout_1) decides to loop through 2 million files =
and
> > >>> match each one of them against the sparse-checkout patterns
> > >>>               4. This hits the O(n^2) problem thus causes 'git add'=
 to
> > >>> hang (or ~1.5 hours to finish)
> > >>
> > >> Thanks for the explanation, it helped me narrow down the source to a=
n exact
> > >> commit (49fdd51a23 (add: skip tracked paths outside sparse-checkout =
cone,
> > >> 2021-09-24)).
> > >>
> > >> You're correct that the `path_in_sparse_checkout()` check is slow [1=
].
> > >> However, it only runs on files that are not "hidden" with the
> > >> `SKIP_WORKTREE` flag. Ideally, if you're using sparse-checkout, this=
 will
> > >> only be a small subset of your 2 million files.
> > >>
> > >> In your repro steps, you're adding patterns to a file then immediate=
ly
> > >> running `git add`. If that reflects how you're usually working with
> > >> sparse-checkout, `SKIP_WORKTREE` likely isn't being applied properly=
 before
> > >> the `add`. You can check to see whether file(s) have the flag proper=
ly
> > >> applied with `git ls-files -t <file or dir names>` - each `SKIP_WORK=
TREE`
> > >> file should have an "S" next to it. "H" indicates that the flag is *=
not*
> > >> applied.
> > >>
> > >> If you see that most of the files that *should* be sparse don't have
> > >> `SKIP_WORKTREE` applied, you can run `git sparse-checkout reapply` (=
make
> > >> sure you don't have any modified files outside the patterns you're
> > >> applying!). The downside is that it'll be as slow as what you're rep=
orting
> > >> for `git add`, but any subsequent `add` (or reset, status, etc.) sho=
uld be
> > >> much faster.
> > >>
> > >> If you do all of that but things are still slow, then the way we che=
ck
> > >> pathspecs in `git add` would need to change (not trivial, but probab=
ly not
> > >> impossible either). At a cursory glance, I can think of a few option=
s for
> > >> that:
> > >>
> > >> 1. Remove the `path_in_sparse_checkout()` check. It's the simplest s=
olution,
> > >>    but it means you'd be able to stage files for commit outside the
> > >>    sparse-checkout patterns without using the '--sparse' option. I d=
on't
> > >>    personally think that's a huge issue, but given that the implemen=
tation
> > >>    was intentionally changed *away* from this approach, I'd defer to=
 other
> > >>    contributors to see if that's an okay change to make.
> > >
> > > I'm strongly against this.  This just restores the original bug we
> > > were trying to fix, attempts to paper over the fact that non-cone mod=
e
> > > is fundamentally O(N*M) in one small instance, and sets the precedent
> > > that we can't fix further sparse-checkout-based usability bugs becaus=
e
> > > it might add performance bottlenecks in additional places given
> > > non-cone-mode's fundamental performance design problem.  We should
> > > instead (in rough priority order)
> >
> > I'm not sure what the bug was - although I can (and should) read throug=
h the
> > list archive to find out - but the rest of your point is convincing eno=
ugh
> > on its own. Even if we sacrificed correctness for performance in this o=
ne
> > case, there are countless other places in the code like it, and changin=
g all
> > of them could seriously hurt user experience in other ways.
> >
> > Thanks for your perspective!
>
> :-)
>
> > >
> > > * encourage people to adopt cone mode
> > > * discourage people still using non-cone mode from having lots of pat=
terns
> >
> > While I know these are the recommended best practice, I do want to
> > acknowledge that switching to cone mode in some repositories is a huge =
lift
> > or otherwise infeasible [1]. While people make that transition (if they=
 even
> > can), I don't think it's unreasonable to look for ways to improve
> > performance in non-cone sparse checkout, especially if those performanc=
e
> > gains can also be realized in cone mode.
> >
> > [1] https://lore.kernel.org/git/nycvar.QRO.7.76.6.2205212347060.352@tvg=
sbejvaqbjf.bet/
>
> Yep, very good point.  These dovetail with why I used "encourage" and
> "discourage", and with why I had several more things that should be
> done in my list, including performance work.  I know that non-cone
> mode is important to still support.
>
> But I would also like to point out that folks sometimes aren't
> adopting cone mode out of inertia or bad assumptions about how cone
> mode operates, rather than having sound reasons.  In fact, I've even
> seen them describe conditions that sound like a perfect fit for cone
> mode and yet use their described usecase as rationale to _not_ use
> cone mode simply because they assume cone mode does something other
> than what it really does.  (See
> https://lore.kernel.org/git/CABPp-BEwMAPHGt5xD9jDU58grbrAqCdqNY9Nh8UJGLKu=
LbArXQ@mail.gmail.com/
> and the previous email in that thread for an example).  If even other
> Git developers do that, that suggests we do need to probe a bit and
> see if people can switch instead of just accepting they are one of the
> cases that can't.  We still have some education work to do.
>
> > > * make sure people aren't misusing things (the lack of a `git
> > > read-tree -mu HEAD` or `git sparse-checkout reapply` seemed very
> > > suspicious)
> >
> > A warning if a particular git operation sees a lot of out-of-cone
> > non-`SKIP_WORKTREE` files might help with this (and would be especially
> > impactful for someone working with a sparse index). I'm not sure how to
> > quantify "a lot", though.
>
> Yeah, this kind of reminds me of the present-despite-skipped check we
> added.  Adding something like that which always runs is probably a
> no-go, though, since this additional check would be much more
> expensive than the present-despite-skipped one.  And, like you, I'm
> also a little unsure how to quantify "a lot".
>
> However, perhaps there's a way to tackle this problem from a different
> angle.  I just noticed that the only place outside of the "git
> sparse-checkout" command that sparse checkouts are documented, in
> git-read-tree(1), that it didn't bother to give a list of steps for
> employing sparse-checkouts and that people have to figure it out by
> trial and error.  (Or read a random mailing list post or commit
> message like 94c0956b60 (sparse-checkout: create builtin with 'list'
> subcommand, 2019-11-21)).  So perhaps it's not surprising that users
> miss one of the crucial steps.  Perhaps if we fix that documentation
> to mention the necessary steps ("git config core.sparseCheckout true",
> populate $GIT_DIR/info/sparse-checkout, then either run "git read-tree
> -mu HEAD" or "git sparse-checkout reapply"), then users can discover
> and make sure to do all the steps instead of just a subset?
>
> > > * educate people that non-cone mode is just fundamentally slow, among
> > > other problems, and that the slowness might appear in additional
> > > places in the future as we fix various usability issues.
> > > * provide workarounds users can adopt if they really want to persist
> > > with non-cone mode with lots of patterns (e.g. add "--sparse" to thei=
r
> > > "git add" commands), though warn them about the possible side effects
> > > they'll face (the added files can seemingly randomly disappear in the
> > > working tree with future checkout/pull/merge/rebase/reset/etc command=
s
> > > if the added files don't match the sparsity patterns).
> > > * investigate ways to optimize the code to lower the constant in the
> > > O(N*M) behavior on a case-by-case basis
> > >
> > > We deprecated non-cone mode in v2.37 in part because of this type of
> > > issue, and I really don't want the see the deprecated side of things
> > > dictating how commands work for the now-default mode.
> > >
> > >> 2. After every call to `ce_path_match()`, check if all pathspecs are=
 marked
> > >>    as `seen` and, if so, return early. This would slow down each ind=
ividual
> > >>    file check and wouldn't help you if a pathspec matches nothing, b=
ut
> > >>    prevents checking more files once all pathspecs are matched.
> > >
> > > Might be interesting.  Would need some careful measurements and
> > > attempts to validate how often all pathspecs are matched early in som=
e
> > > kind of way, because this would definitely slow down some cases and
> > > speed others up, but I don't have a good feel for which side happens
> > > more frequently in practice.
> > >
> > >> 3. Do some heuristic checks on the pathspecs before checking index e=
ntries.
> > >>    For example, exact file or directory matches could be searched in=
 the
> > >>    index. This would still require falling back on the per-file chec=
ks if
> > >>    not all pathspecs are matched, but makes some typical use-cases m=
uch
> > >>    faster.
> > >
> > > I'm confused.  "before checking index entries", you're checking thing=
s
> > > (namely, exact file or directory matches) "in the index"?
> >
> > Sorry, I definitely wasn't clear. I mean "perform heuristic checks *per
> > pathspec item* before iterating *per index entry*." Pathspecs used in `=
git
> > add` are (at least in my experience) pretty small, so there could be
> > performance gains if all the items can be marked `seen` without iterati=
ng
> > over every entry of the index. I was thinking something like
> > `pathspec_needs_expanded_index()` in `reset` (4d1cfc1351 (reset: make
> > --mixed sparse-aware, 2021-11-29)), but tailored to this particular cas=
e.
>
> Ah, okay makes sense now.
>
>
>
>
>
> >
> > >
> > >> There are almost certainly other options, and I can dig around `add.=
c` more
> > >> to see if there's anything I'm missing (although I'd love to hear ot=
her
> > >> ideas too!).
> > >>
> > >> Hopefully this helps!
> > >> - Victoria
> > >>
> > >> [1] `path_in_sparse_checkout()` is significantly faster in cone mode=
, but
> > >> with 16k patterns I'm assuming you're not using cone patterns ;)
> > >>
> > >>>
> > >>> Please help us take a look at this issue and let us know if you nee=
d
> > >>> more information.
> > >>>
> > >>> Thanks,
> > >>>
> > >>> Dian Xu
> > >>> Mathworks, Inc
> > >>> 1 Lakeside Campus Drive, Natick, MA 01760
> > >>> 508-647-3583
> > >>
> >
