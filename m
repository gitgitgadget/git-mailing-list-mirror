Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0ECC433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 23:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237828AbhL1Xm1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 18:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237810AbhL1Xm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 18:42:26 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABD6C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 15:42:26 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id w16so79532412edc.11
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 15:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UKeLxlnlM+8VBRnNVzbFg9anjNz1ZoMQnUR5sy6m4Vs=;
        b=OgdJDJaOrVDuYLp4ObWAC4FTfmrqhtEAketHiNhLqFMSMeDQADVuYPVhhqteYzZ6FM
         /aW1pWoQJxDOfgLpH5gOSiqm5He4Ka3PG95XcV6RfiLFHr4lMhWqKR1XQcsYdcbTbr/u
         yCw+ToB7e0tPTodqE6wO/WpgnjvGP9acpdUzytIATRFViuTRD0x2xHslHFLKnDa376SB
         PZawIRDCqV/+kODyi3NIRsBaz7QrvLKi2LBptf/Yqlr4YIO82P9ttBp4YQ6q/IL4mqt2
         B4AW62JaspGnotgtScVHRtgAIVjbxhQ8dTQSfkBb91vYmDtEEBs+Z/hnBPFh39qN5Wws
         1mbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UKeLxlnlM+8VBRnNVzbFg9anjNz1ZoMQnUR5sy6m4Vs=;
        b=AHBCa2JNO3Of9z5kFtOMNXfYDpu3BFDmvhR5vA7wHruk7phcTriJXODlPGBwFvXKev
         oGuln92v4xcrgx/YY4a/4n66O5t5gQ2bxThKAd3kUVK5oe20E6LFK8pHlNqXVrFU8AkQ
         rC3MZN1INYH4w9lpW8LNJqnVRHITGFGRT+3oidudq+Sl8KC+7BPd0laUbLhiZgVhNsQ5
         UjfJCOuCITIkDiwakTluCOdGiXMSyrYPt5t3x2gzB5NQBLfkRGp9JUbkYT+h1d0geLlq
         FomHTsjISNuZJ4yPgZ2EBA+YKC9YDpdRlngONjOKvyiBq28p61b/c+H1jjQzKJNG/cp1
         dLYQ==
X-Gm-Message-State: AOAM5336FxMj89pGR36uEMhDpTGycn0Ibf+bqJb16MULwu+SWSfrmUFe
        Jk1o7jsYK96k6BhHeyLr3oJr5/E7RpSK0vV8hM4=
X-Google-Smtp-Source: ABdhPJwIysgXb+86+T+TVcmfNTf0i6BcSEc6vV7w1SO8u6lR5Gd74uqIjMeJVvQnW7NigLl/vlT9U6ZSETRNfQR3WhQ=
X-Received: by 2002:a05:6402:5202:: with SMTP id s2mr16134419edd.206.1640734944705;
 Tue, 28 Dec 2021 15:42:24 -0800 (PST)
MIME-Version: 1.0
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
 <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com> <4cc53c55a6ea1531342b23bc9343890a576d9f1c.1640419160.git.gitgitgadget@gmail.com>
 <20211228105755.zgahkoxn6ewjpdol@gmail.com>
In-Reply-To: <20211228105755.zgahkoxn6ewjpdol@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 28 Dec 2021 15:42:13 -0800
Message-ID: <CABPp-BFP5Oc3vDQVJYZ4L=4ivSYuZBNk+Y9RHioJuSZKVzW0Dg@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] show, log: include conflict/warning messages in
 --remerge-diff headers
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 28, 2021 at 2:57 AM Johannes Altmanninger <aclopte@gmail.com> wrote:
>
> On Sat, Dec 25, 2021 at 07:59:19AM +0000, Elijah Newren via GitGitGadget wrote:
...
> > +test_expect_success 'remerge-diff with non-content conflicts' '
> > +     git log -1 --oneline resolution >tmp &&
> > +     cat <<-EOF >>tmp &&
> > +     diff --git a/file_or_directory~HASH (side1) b/wanted_content
>
> the "~HASH (side1)" suffix will probably mess with some programs that extract
> the filename from the diff.

"~HASH (side1)" is part of the filename, so this won't mess those
programs up at all (unless those programs can't deal with filenames
containing spaces or parentheses or something).

> I don't know what programs are supposed to expect.  I can see arguments for
> either dropping the suffix or including only "~HASH" since that's part of
> the actual filename that's left in the worktree.

When there are conflicts that prevent the file from being recorded in
the tree, such as file/directory conflicts, we have to rename the file
elsewhere.  We want the new name to be something that the user can
find and reason about.  So, both merge-recursive and merge-ort use
${filename}~${branchname}, where ${branchname} is defined in the
struct merge_options (opt->branch1 or opt->branch2) that were passed
in to the function.

For a regular `git merge` we just use opt->branch1 = "HEAD" and
opt->branch2 = <name of branch/commit typed on command line to merge>.

Neither of those strings make sense for remerge-diff.  We could just
use hashes, but why are users going to be familiar with the hashes of
the parents of a merge commit when looking at --remerge-diff output?
Parents are not part of the output by default.  So, log-tree.c uses
this bit of logic

    format_commit_message(parent1, "%h (%s)", &parent1_desc, &ctx);
    format_commit_message(parent2, "%h (%s)", &parent2_desc, &ctx);
    o.branch1 = parent1_desc.buf;
    o.branch2 = parent2_desc.buf;

which means that the branch name is of the form "$HASH
($EXTRA_DESCRIPTION)", and thus that files in file/directory conflicts
(or add/add + file/symlink conflicts or file/submodule conflicts) will
get renamed to a file of the form "$FILENAME~$HASH
($EXTRA_DESCRIPTION)"

Note that these branch names also appear in CONFLICT messages, in
conflict markers, etc., and in fact are used much more frequently in
those locations.  In those places it's perhaps even more important to
attempt to provide meaningful names, so dropping the extra description
doesn't make sense.

> The file/link typechange conflict test I'll add below exposes what looks
> like an accidental interaction with the trailing tab characters that we emit
> on --- and +++ lines if the "filename" contains a space (since 1a9eb3b9d5
> (git-diff/git-apply: make diff output a bit friendlier to GNU patch (part
> 2), 2006-09-22)).
>
>         index 70885e4..0000000
>         --- a/typechange~738109f (side1)        <-- git diff adds a trailing tab!
>         +++ /dev/null
>
> I haven't formed an opinion yet, but since Tig uses the --- and +++ lines
> to extract file names, I'd drop the " (side1)" suffix from at least the ---
> and +++ lines. Maybe also the ^diff lines, I'm not sure

As above, " (side1)" is part of the filename and thus belongs here.

> > +     similarity index 100%
> > +     rename from file_or_directory~HASH (side1)
> > +     rename to wanted_content
> > +     CONFLICT (file/directory): directory in the way of file_or_directory from HASH (side1); moving it to file_or_directory~HASH (side1) instead.
>
> I wonder if it's better to have this line further up, before the "rename"
> resolution, to correct the temporal order.

Yeah, I've gone back and forth about where these would best be placed.
You make a good point, even if the code is slightly uglier to move
earlier.  However, I do really like having the CONFLICT notices being
close to the file text being shown, which makes me conflicted (no pun
intended) about moving it earlier.  Hmm....

> > +     diff --git a/letters b/letters
> > +     CONFLICT (rename/rename): letters renamed to letters_side1 in HASH (side1) and to letters_side2 in HASH (side2).
> > +     diff --git a/letters_side2 b/letters_side2
> > +     deleted file mode 100644
> > +     index b236ae5..0000000
> > +     --- a/letters_side2
> > +     +++ /dev/null
> > +     @@ -1,9 +0,0 @@
> > +     -a
> > +     -b
> > +     -c
> > +     -d
> > +     -e
> > +     -f
> > +     -g
> > +     -h
> > +     -i
> > +     diff --git a/numbers b/numbers
> > +     CONFLICT (modify/delete): numbers deleted in HASH (side2) and modified in HASH (side1).  Version HASH (side1) of numbers left in tree.
> > +     EOF
>
> Took me some time to grok these but the output makes sense (it's loud and
> ugly but that's okay since these are serious conflicts).
>
> > +     # We still have some sha1 hashes above; rip them out so test works
> > +     # with sha256
> > +     sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >expect &&
> > +
> > +     git show --oneline --remerge-diff resolution >tmp &&
> > +     sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >actual &&
> > +     test_cmp expect actual
> > +'
> > +
> >  test_done
> > --
> > gitgitgadget
>
> We're missing a test case for typechange.

<grin>
...and a testcase for an add/add conflict, and a file/submodule
conflict, and file/symlink, and symlink/submodule, and
submodule/submodule (different submodules both added at same path),
and binary merge conflict, and a variety of
failure-to-merge-submodule-updates, and at least half a dozen regular
rename-based conflict types, and several directory-rename-based
conflict types...and that's just beginning to scratch the surface once
you start dreaming of combinations of the different conflict types
occurring for the same path (in particular, I'm thinking of examples
from the testcases found in t6416, t6422, t6423 -- or at least
sections 7, 9, & 12 of t6423).

I don't think providing a comprehensive set of possible conflicts is
useful here; we just need a representative sample.  I was curious
whether that was best served with just two examples or three, but
ultimately decided on 3.  I would have been more likely to pick 2 than
4, though.

However, while I fail to see how typechange stresses --remerge-diff in
ways the other conflict types don't, or how it might help clarify the
output for users, I might be overlooking something.  Is there a
particular reason you wanted to see the typechange conflict included?

>  Here's is a quick draft I've been
> playing around with. Seems ugly that the "diff --git a/typechange b/typechange"
> is doubled but okay.
>
> Maybe a rename/delete conflict is interesting as well, I'm not sure.  (Also I
> wonder if switching the order of parents will give any interesting difference,
> I guess not)
>
> test_expect_success 'remerge-diff with file/link conflict' '
>         git branch -d base side1 side2 &&
>         git switch --orphan base &&

I'd rather have subdirectories with git repositories (much like t6416,
t6422, and t6423) if we're going to be adding many more tests here.


>         echo base >typechange &&
>         git add typechange &&
>         git commit -m base &&
>
>         git branch side1 &&
>         git branch side2 &&
>
>         git checkout side1 &&
>         echo orig-file-contents >typechange &&
>         git commit -a -m side1 &&
>
>         git checkout side2 &&
>         ln -sf . typechange &&
>         git add typechange &&
>         git commit -m side2 &&
>
>         git checkout -b resolution2 side1 &&
>         test_must_fail git merge side2 &&
>         rm typechange &&
>         mv typechange~HEAD typechange &&
>         echo resolved >>typechange &&
>         git add typechange~HEAD typechange &&
>         git merge --continue &&
>
>         git show --oneline --remerge-diff resolution2 >tmp &&
>         sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >actual &&
>
>         cat <<-EOF >tmp &&
>         7759b27 Merge branch ${SQ}side2${SQ} into resolution2
>         diff --git a/typechange b/typechange
>         deleted file mode 120000
>         CONFLICT (distinct types): typechange had different types on each side; renamed one of them so each can be recorded somewhere.
>         index 945c9b4..0000000
>         --- a/typechange
>         +++ /dev/null
>         @@ -1 +0,0 @@
>         -.
>         \ No newline at end of file
>         diff --git a/typechange b/typechange
>         new file mode 100644
>         CONFLICT (distinct types): typechange had different types on each side; renamed one of them so each can be recorded somewhere.
>         index 0000000..70885e4
>         --- /dev/null
>         +++ b/typechange
>         @@ -0,0 +1,2 @@
>         +orig-file-contents
>         +resolved
>         diff --git a/typechange~738109f (side1) b/typechange~738109f (side1)
>         deleted file mode 100644
>         index 70885e4..0000000
>         --- a/typechange~738109f (side1)
>         +++ /dev/null
>         @@ -1 +0,0 @@
>         -orig-file-contents
>         EOF
>         # We still have some sha1 hashes above; rip them out so test works
>         # with sha256
>         sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >expect &&
>
>         test_cmp expect actual
> '

but otherwise the testcase looks good, if we want it.
