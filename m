Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE79C54EBE
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 16:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjAMQy3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 11:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjAMQx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 11:53:57 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C8E718B8
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 08:50:54 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-4d19b2686a9so165500267b3.6
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 08:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTesR8ifYMtYhHHachM2Eivv2h0J+4fOrlh5RPp7R4o=;
        b=OeshiEV6qyx+T7ITnz2jQS84m52VoHTQuUEX7i+Nm83rEfDOabrJW8JcyHZIq/ByuH
         voCYHJySOj+FtpbbFLPLVGxuIA+VP47L3AaRujUiCtxAtnEL6zYAqrCseZsNWA0P/aUw
         TU6KXc7Q5CmUSa9TnebeOxlFwJiq1TLwBPmFeed6aMruCVQW078Sw4cWCmNZXe548AKi
         7f/6aCeVJ6t8FQwgkgBmN53vD6VTn3kSZdge8nuOFMEZW3ESwOafsbNNkVRaoJhm3tbA
         DRtMt6imcIQ3QEr6fnHDvxL1VA96b2x0mRELTgiUXEqMnCBz9V2bCvXiLAvvBs7NGFoi
         vwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTesR8ifYMtYhHHachM2Eivv2h0J+4fOrlh5RPp7R4o=;
        b=y7az81Lruu0wLRuYu60m/jLxtxFhJz+a2RDeXFYMnEj1asugHQYd4zzGVXy+SeYZlB
         Et8RbK5gJFn0cpanzRJZdZ0yTObiLGG0K+wtzk/Bd4tgUUs1yKyl8Na24kPQfOehZzBJ
         DTqDc0ndABecFppdlqJ/sDkJ62g9DVIsue4JP1tIuGjqaOf0QwZFQN340WljGqmMih7C
         AJdcmfL1pjrRiMvU4Vi/lfBcge2OBPOMALvQ+TaVj8hKv8lqDZbvNOvbggvvDZjJveaR
         9XZu0gNd28RXHDHMZVyWU1uT/lse0qAGiRZe5R0y7YsAQFWYyJwAPfuwOae2LLAYZw+p
         e9XQ==
X-Gm-Message-State: AFqh2kod4OOnjbz3Bk1q5HzY920Cq4BQsRV0d4u/SVmUpFMb4ugmlAco
        g02eEc7zpxnhohkI5IqtAcENF5H9uVpZ2loXSnTO9V9i88qcDg==
X-Google-Smtp-Source: AMrXdXsiwRlyIb5epDZ/xkS9kqnLYSQYYCXNiCfWy7QYHxWU+3y0fMnDStJiG/SkREQHFYwl+rYVRtQQ3+iUSwfbMak=
X-Received: by 2002:a0d:f685:0:b0:4df:96d1:f67a with SMTP id
 g127-20020a0df685000000b004df96d1f67amr246602ywf.246.1673628653542; Fri, 13
 Jan 2023 08:50:53 -0800 (PST)
MIME-Version: 1.0
References: <pull.1458.git.1673451741587.gitgitgadget@gmail.com> <CABPp-BGsD=6PiJtnsuYPsiZJ1rm2X8yTeu-YeP4q5uu5UDw2og@mail.gmail.com>
In-Reply-To: <CABPp-BGsD=6PiJtnsuYPsiZJ1rm2X8yTeu-YeP4q5uu5UDw2og@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 14 Jan 2023 00:50:42 +0800
Message-ID: <CAOLTT8RNWJLA_UvoMA_MktkEmLSjJrx7E6Khy97cHhVFXPQD2A@mail.gmail.com>
Subject: Re: [PATCH] ls-files: add %(skipworktree) atom to format option
To:     Elijah Newren <newren@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> =E4=BA=8E2023=E5=B9=B41=E6=9C=8812=E6=97=
=A5=E5=91=A8=E5=9B=9B 18:00=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Jan 11, 2023 at 7:42 AM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Because sometimes we want to check if the files in the
> > index match the sparse specification by using
> > `git ls-files -t`, but `-t` option have semi-deprecated,
>
> Where `semi-deprecated` was explicitly "suggest other functionality in
> preference, but do not ever remove"[1].  The "suggest other
> functionality in preference" for "ls-files -t" came about because
> people got confused about staged files which have (a) no unstaged
> changes, vs. (b) unstaged content changes, vs. (c) unstaged deletion
> of the file.  Such users accidentally presumed that "H" (defined
> simply as "cached") should only refer to class (a) when it refers to
> the fact that the file is tracked (and not conflicted) and thus refers
> to any of (a), (b), and (c)[2].  (I wonder if changing the definition
> of "H" in the manual from "cached" to "tracked-and-not-conflicted"
> would fix this confusion.)  In contrast, comparing tracked vs.
> not-tracked-because-skip-worktree files, the distinction between "H"
> and "S" makes lots of sense and naturally you want "H" to represent
> all 3 of (a), (b), and (c).  So, for the skip-worktree bit usecase,
> "ls-files -t" doesn't cause the same confusion.  (Perhaps the fact
> that we have a tri-state of "M" (unmerged) vs "S" (skip-worktree) vs.
> "H" (all other tracked files) could cause minor confusion, but in
> practice the possibility of "M" just hasn't seemed to have caused
> issues for sparse-checkout users or scripts.)
>

OK, I probably understand that the '-t' "semi-deprecated" was caused
by the confusion of the 'H' semantics.

> Further, since sparse-checkouts and monorepos really started taking
> off 4-5 years ago, "git ls-files -t" has been used *heavily* (but
> mostly by low-level script things rather than user-facing UI).  If we
> wanted to come up with a better place to report on the skip-worktree
> bit and have scripts rely on that, we probably should have made such a
> change back then...if not another 8-9 years earlier.  At this point,
> "ls-files -t" simply cannot be removed, even if we wanted to.
>

Ah, It seems we can't go back so far :)

> [1] As per this quote from 5bc0e247c4 ("Document ls-files -t as
> semi-obsolete.", 2010-07-28):
>     "git ls-files -t" is [...] badly documented, hence we point the
>     users to superior alternatives.
>     The feature is marked as "semi-obsolete" but not "scheduled for remov=
al"
>     since it's a plumbing command, scripts might use it, and Git testsuit=
e
>     already uses it to test the state of the index.
> [2] https://lore.kernel.org/git/fcaeb9bf0908190204h31bc839ai39972a251040d=
449@mail.gmail.com/
> (a.k.a. gmane:126516 from the commit message referenced above)
>

It was good to discover that I had misunderstood the point:
"semi-obsolete" is not git want to remove `-t`.

> > So introduce "%(skipworktree)" atom to git ls-files
> > `--format` option.
>
> Given my above comments, I personally don't buy this as justification
> for adding a new way of reporting on the skip-worktree bit.  It may
> still make sense to add this feature or something like it, but I
> personally think it deserves separate justification from "`ls-files
> -t` is semi-deprecated".
>

Agree now.

> (Others, of course, may disagree with me, but if this is the only
> justification for this change, then I'm more likely to want to fix the
> ls-files manual to remove the "semi-deprecated" notice and fix the
> definition of "H" to be less misleading than to make a change like
> this.)
>
> > When we use this option, if the file
> > match the sparse specification and removed from working
> > tree...
>
> The "and removed from working tree" portion of this sentence is
> superfluous.  (And actually makes it harder to understand, I had to
> try to think through a bunch of cases to try to figure out why you
> might be trying to add some extra qualifier.)
>

I just quoted the definition of SKIP_WORKTREE from
Documentation/technical/sparse-checkout.txt:

    SKIP_WORKTREE: When tracked files do not match the sparse specification=
 and
      are removed from the working tree, the file in the index is marked
      with a SKIP_WORKTREE bit.

> > ...it will output "yes", othewise, output "no".
>
> typo in "otherwise".
>
> Also, your commit message claims output different from what your code
> below implements and what your testcase shows.  ("yes"/"no" vs.
> "true"/"false")
>

Yeah, I would have said "true"/"false".

> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> [...]
> > diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-file=
s.txt
> > index 440043cdb8e..0e50307121d 100644
> > --- a/Documentation/git-ls-files.txt
> > +++ b/Documentation/git-ls-files.txt
> > @@ -260,6 +260,12 @@ eolattr::
> >         that applies to the path.
> >  path::
> >         The pathname of the file which is recorded in the index.
> > +skipworktree::
> > +       If the file in the index marked with SKIP_WORKTREE bit.
> > +       It means the file do not match the sparse specification
> > +       and removed from working tree.
> > +       See link:technical/sparse-checkout.txt[sparse-checkout]
> > +       for more information.
>
> Should the actual wording be included here? (i.e. "yes"/"no",
> "true"/"false", or whatever you end up using)?
>

Yes, it will be better to mention its output.

> >  EXCLUDE PATTERNS
> >  ----------------
> > diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> > index a03b559ecaa..d1a27f28f01 100644
> > --- a/builtin/ls-files.c
> > +++ b/builtin/ls-files.c
> > @@ -280,6 +280,9 @@ static size_t expand_show_index(struct strbuf *sb, =
const char *start,
> >                               data->pathname));
> >         else if (skip_prefix(start, "(path)", &p))
> >                 write_name_to_buf(sb, data->pathname);
> > +       else if (skip_prefix(start, "(skipworktree)", &p))
> > +               strbuf_addstr(sb, ce_skip_worktree(data->ce) ?
> > +                             "true" : "false");
> >         else
> >                 die(_("bad ls-files format: %%%.*s"), (int)len, start);
> >
> > diff --git a/t/t3013-ls-files-format.sh b/t/t3013-ls-files-format.sh
> > index efb7450bf1e..ac8b865c275 100755
> > --- a/t/t3013-ls-files-format.sh
> > +++ b/t/t3013-ls-files-format.sh
> > @@ -92,4 +92,26 @@ test_expect_success 'git ls-files --format with --de=
bug' '
> >         test_cmp expect actual
> >  '
> >
> > +test_expect_success 'git ls-files --format with skipworktree' '
>
> Should probably add a
>     test_when_finished "git sparse-checkout disable" &&
> at the beginning of this test, otherwise you are potentially causing
> confusion to future developers who try to add additional testcases to
> this file.
>

Agree.

> > +       mkdir dir1 dir2 &&
> > +       echo "file1" >dir1/file1.txt &&
> > +       echo "file2" >dir2/file2.txt &&
> > +       git add dir1 dir2 &&
> > +       git commit -m skipworktree &&
> > +       git sparse-checkout set dir1 &&
> > +       git ls-files --format=3D"%(path) %(skipworktree)" >actual &&
> > +       cat >expect <<-\EOF &&
> > +       dir1/file1.txt false
> > +       dir2/file2.txt true
> > +       o1.txt false
> > +       o2.txt false
> > +       o3.txt false
> > +       o4.txt false
> > +       o5.txt false
> > +       o6.txt false
> > +       o7.txt false
> > +       EOF
> > +       test_cmp expect actual
> > +'
>
> To be honest, I don't yet see any compelling reason to use this new
> option.  Even if this patch is accepted, I'd just continue using "git
> ls-files -t" (both directly and in scripts) in preference to this.
> However, you have inspired me to try to fix up the ls-files
> documentation and remove the "semi-deprecated" label for the -t
> option.  Patches over here:
> https://github.com/gitgitgadget/git/pull/1463 ; I'll submit them in
> the next few days.

To be honest, right now I think %(skipworktree) just refines the
--format option's ability to read the index entry SKIP_WORKTREE
flag bits. It is probably still worth keeping.

Thanks,
ZheNing Hu
