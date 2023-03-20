Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2C4C6FD1C
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 20:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjCTUzt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 16:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjCTUzp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 16:55:45 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C0E26855
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 13:55:28 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v1so5609626wrv.1
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 13:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679345726;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bvj0wDLlEFjKhlCJkqgVrUtzNtjPKH+xOL7RmOENF8s=;
        b=iWsx+i2jRZksFR+UFw3VVueUeJC+z6Hp9FIU0UuyAU9bI+fnSHKVNZg85K7TsPA9ox
         IibrXn92OIy7HL6/qLSL2WTTY3NhM01DPCrqIx7AsVPH+k9pN9cBjHoV+AT9V2BI1g+A
         AF5Uh0UPJqK03YH2apjtYfYPFJj+IsBljCVv0NkrcUSNQW5CGc99fvjtAVmyt1RwVOoI
         H6hV7DsbUcuUmcuP/CtpXCKd/zDPEKJLiS/A90lmxMvGNqlzAosdZ+RUFy6Nt8csTvXC
         geY+w5RaSqtzzalwGof9BmlfGh8lvZUv3SbrPiERTkDHhkcRTMfJBEH6iifEdK71rGl3
         +I+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679345726;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bvj0wDLlEFjKhlCJkqgVrUtzNtjPKH+xOL7RmOENF8s=;
        b=inSxhE89jrOXCsApS2vZ7eUVnY4WwRYFDtlVyvu17xeEZa8nquLd9Wc6imXHBfrv72
         FrSjc5zsdJEEVyAeBtA/B884hvb0iygsX4Sn7Aq95PAnNcpz024b99u/kgM8Wa1ZTO1V
         7t12a1HI1ufQIlg2U2hDYch2qaZHIRuBWJmA+FepkeEzodn2TI13OIZAMu9gXokkMcAI
         DSZRnVdX6nVBk4PnVBgBo0GE0sx7UaEhTwpQxIHwMxaP70lDCk6oKr0pZg3iFF2+mIw+
         LYBjTXO9NZrhO8cSQzHG0G1dWPiVvfb2QpVJt8Xi7fTdlYOYWJ5zC1XLxTEoSxlLDfWz
         vN9g==
X-Gm-Message-State: AO0yUKWuFakXk/YJzzNmRR0JR2WHg5vaiQVpaKzY1Mx5fB+x6vYAc4C2
        us/ULBNEEc2FdbeCC0+K6BkntRDeaKTOyG48aAjKqNI7qLQ=
X-Google-Smtp-Source: AK7set+pmuzUeIaZ49tXjNaol7MIoHytu15pQPWe5hPECINvqw8hNirpiDuOCZztse9eGEUVqqq9md650KQq23xLd3M=
X-Received: by 2002:adf:f8cb:0:b0:2c9:a6be:32a2 with SMTP id
 f11-20020adff8cb000000b002c9a6be32a2mr128863wrq.5.1679345726007; Mon, 20 Mar
 2023 13:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230309063952.42362-1-cheskaqiqi@gmail.com> <20230310050021.123769-1-cheskaqiqi@gmail.com>
 <20230310050021.123769-2-cheskaqiqi@gmail.com> <b537d855-edb7-4f67-de08-d651868247a5@github.com>
In-Reply-To: <b537d855-edb7-4f67-de08-d651868247a5@github.com>
From:   Shuqi Liang <cheskaqiqi@gmail.com>
Date:   Mon, 20 Mar 2023 16:55:13 -0400
Message-ID: <CAMO4yUFsGQbeu=wbqG8EuptYFDv9c1tB8Y0RAU_UJ-GdbMAfVg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] t1092: add tests for `git diff-files`
To:     Victoria Dye <vdye@github.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2023 at 1:23=E2=80=AFPM Victoria Dye <vdye@github.com> wrot=
e:

 Hi Victoria!

Sorry for the late reply! I was having midterm exams.

Thank you for the feedback on the patch .
I appreciate your time giving me the advice for improvement.

> > In order to have staged changes outside of
> > the sparse-checkout cone, create a 'newdirectory/testfile' and
> > add it to the index, while leaving it outside of
> > the sparse-checkout definition.Test 'newdirectory/testfile'

> nit: missing space after "definition."

Will do!

> I'd be interested in seeing an additional test case for a pathspec with
> wildcards or other "magic" [1], e.g. 'git diff-files "deep/*"'. In past
> sparse index integrations, there has occasionally been a need for special
> handling of those types of pathspecs [2][3], so it would be good for the
> test to cover cases like that.

Will do!

> From the comment you've added here, it looks like the state you want to t=
est
> is "file outside sparse checkout definition exists on disk". However, sin=
ce
> one of the goals of this test is to verify sparse index behavior once its
> integrated with the 'diff-files' command, whether the "outside of sparse-
> checkout definition" file belongs to a sparse directory entry is an
> important (and fairly nuanced) factor to consider.
>
> The main difference between a "regular" sparse-checkout and a sparse
> index-enabled sparse-checkout is the existence of "sparse directory"
> entries: index entries with 'SKIP_WORKTREE' that represent directories an=
d
> their contents. In the context of these tests, the thing we really want t=
o
> verify is that the sparse index-enabled case produces the same results as
> the full index when an operation needs to get some information out of a
> sparse directory.
>
> Coming back to this test, the 'newdirectory/testfile' you create, while
> outside the sparse-checkout definition, never actually belongs to a spars=
e
> directory because 'newdirectory' is never collapsed - in fact, I don't
> think it even gets the SKIP_WORKTREE bit in the index. To ensure you have=
 a
> sparse directory & SKIP_WORKTREE, you'd need to run 'git sparse-checkout
> reapply' after removing 'newdirectory/testfile' from disk - which doesn't
> help if you want to test what happens when the file exists on disk!

Thanks for the explanation here! I learn a lot.

> In fact, because of built-in safeguards around on-disk files and
> sparse-checkout, there isn't really a way in Git to materialize a file
> without also expanding its sparse directory and removing SKIP_WORKTREE. I=
f
> you want to preserve a sparse directory, you should write the contents of=
 an
> existing file inside that sparse directory to disk manually:
>
>         run_on_sparse mkdir folder1 &&
>         run_on_sparse cp a folder1/a &&  # `folder1/a` is identical to `a=
` in the base commit
>
> Git's index will not be touched by doing this, meaning the next command y=
ou
> invoke (in this case, 'diff-files') will need to reconcile the file on di=
sk
> with what it sees in the index.
>
> > +     test_sparse_match git diff-files &&
> > +     test_must_be_empty sparse-checkout-out &&
> > +     test_must_be_empty sparse-checkout-err &&
> > +     test_sparse_match git diff-files newdirectory/testfile &&
> > +     test_must_be_empty sparse-checkout-out &&
> > +     test_must_be_empty sparse-checkout-err &&
>
> These checks should be 'test_all_match' rather than 'test_sparse_match'.
> Since (through other tests) we're confident that 'git diff-files' on an
> unmodified, non-sparse-checkout repository will give us an empty result, =
you
> wouldn't need the additional 'test_must_be_empty' checks.
>
> A bit of a "spoiler": when I tested this out locally, I found that the di=
ff
> was *not* empty for the sparse-checkout cases, until I ran 'git status'
> (which strips the 'SKIP_WORKTREE' bit from the file and writes it to the
> index). That's not the desired behavior, so there's a bug in the
> sparse-checkout logic used in 'diff-files' that needs to be fixed (my fir=
st
> guess would be that 'clear_skip_worktree_from_present_files()' is not bei=
ng
> applied when the index is read).

Yeah. After I use

 run_on_sparse mkdir folder1 &&
 run_on_sparse cp a folder1/a &&  # `folder1/a` is identical to `a` in
the base commit

 diff was *not* empty for the sparse-checkout cases

 when I look into builtin/diff-files.c
'repo_read_index_preload' call 'repo_read_index' which call
 'clear_skip_worktree_from_present_files()' to apply when the index is read=
.

I got stuck in here and do not have the idea to investigate it. Any
tips would be helpful!


> > +     run_on_sparse ../edit-contents newdirectory/testfile &&
> > +     test_sparse_match git diff-files &&
> > +     test_cmp expect sparse-checkout-out &&
> > +     test_sparse_match git diff-files newdirectory/testfile &&
> > +     test_cmp expect sparse-checkout-out
>
> Similarly, you should use 'run_on_all' to modify the file & 'test_all_mat=
ch'
> to verify that they all match here. It would demonstrate that we don't
> expect any "special" behavior from sparse-checkout, meaning you can proba=
bly
> avoid checking the result verbatim.

> Finally, as with the earlier test, it'd be nice to show that the result i=
s
> the same with a wildcard pathspec, e.g. 'git diff-files "folder*/a"'.

Will do!
---------------------------------------------------------------------------=
-
Thanks
Shuqi
