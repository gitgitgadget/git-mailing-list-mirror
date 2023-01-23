Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C553C05027
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 15:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjAWPeL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 10:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjAWPeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 10:34:09 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0051421A
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 07:34:07 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-4c131bede4bso176905427b3.5
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 07:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slJo1MOeWQ2R3Yi9Z3z07USG37GCvFhqmzv2jdBNkn4=;
        b=I8E5Qu8NnTlqSEtYvSgdTGW3WYfGEsPUTu6WNqdtMGoXLKIdq0Rb+gqVj/YFrccqcx
         gfU+Zp5g3EblTlFUyzcwulfHJis7nOChZ01SqhZWokc6ZuHjinIcUVI2UxqYU8R00vEd
         trop2HNl4KXdIujPKK7V5i9fouPkVyRBh0yaYnwrffHzvU3FgACheRrevdmAu8KoGtus
         agcb7j7Vk3mGK6FPtjwetmobTZnDfWjNw7tLdSAfTMVWe1lODhQbLFgCDy1mEPqieCtf
         rEGNoQIt8jUR34FbrdS2Pc3LXSLV3AxMN4i3+veHIlu5y6kB51myTS72O3TE3dPW7IpV
         PcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slJo1MOeWQ2R3Yi9Z3z07USG37GCvFhqmzv2jdBNkn4=;
        b=vJyZpvlD22VR91C3Cyga6KK6J4r+0zq24AdfmxLTFp39GN/rvGMwJwQELPVLTwTAki
         2P4H7SEUDXTB/Sc4wEz6tv9UF3q+zvUGiQoQQVj0WuEP7YGYxITI/E53y44L/CwXq5Ih
         TPpdHxa4rxCrk+Pkp2FkPh1Pojd+WfHk667VeRYOtZab9Bt9wOMUU/+yCGFlV5KpnbXa
         11ltbOHDm/VP+UJzjSl6jaLxNY6JkqRhBXIMHQwx0+Z/uxJsh0XCWqOyDeuasj1qqqzd
         D+ln4pVq6QpM5J5R362B+jcDcUsCz1Me651G4clYJg0HQjHOWqw6hrUQSBp6LwRm5nYU
         rjoQ==
X-Gm-Message-State: AFqh2koXKKZCi6FoqhGPRpMtLiCOROd8SrsGLHnKGdmbWGnyHpACbCAG
        DQaJrF+8QFIpS88AoXebgWUoUyS1G9zZL+J8EY4w0BjyPgA5aw==
X-Google-Smtp-Source: AMrXdXuulGYFSmPZnW3gbJYKGyEJDqa0sPbMn07+CsKZu1fODBazV6IjjOWWwDxLCcegUKfIoHVi8gZTyg36f4KkGyE=
X-Received: by 2002:a0d:e582:0:b0:4df:96d1:f67a with SMTP id
 o124-20020a0de582000000b004df96d1f67amr3019539ywe.246.1674488047051; Mon, 23
 Jan 2023 07:34:07 -0800 (PST)
MIME-Version: 1.0
References: <pull.1458.git.1673451741587.gitgitgadget@gmail.com>
 <pull.1458.v2.git.1674149666.gitgitgadget@gmail.com> <9ebd6b77a69be414388a52a482912173f2a4e7d8.1674149666.git.gitgitgadget@gmail.com>
 <CABPp-BGLmhoHAcuLoz_yQ4TmNBvDU6Ehymy_3rh0wguSw0hjGw@mail.gmail.com>
In-Reply-To: <CABPp-BGLmhoHAcuLoz_yQ4TmNBvDU6Ehymy_3rh0wguSw0hjGw@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 23 Jan 2023 23:33:55 +0800
Message-ID: <CAOLTT8TfiCaU2o2HzubRV7zxn86JnUUrGhScrYRKSxNrzpbiBA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ls-files: add %(skipworktree) atom to format option
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

Elijah Newren <newren@gmail.com> =E4=BA=8E2023=E5=B9=B41=E6=9C=8820=E6=97=
=A5=E5=91=A8=E4=BA=94 13:30=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Jan 19, 2023 at 9:34 AM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Because sometimes we want to check if the files in the
> > index match the sparse specification, so introduce
> > "%(skipworktree)" atom to git ls-files `--format` option.
> > When we use this option, if the file match the sparse
> > specification, it will output "1", otherwise, output
> > empty string "".
>
> Why is that output format useful?  It seems like it'll just lead to
> bugs, or someone re-implementing the same field with a different name
> to make it useful in the future.  In particular, if there are multiple
> boolean fields and someone specifies e.g.
>    git ls-files --format=3D"%(path) %(skipworktree) %(intentToAdd)"
> and both boolean fields are displayed the same way (either a "1" or a
> blank string), and we see something like:
>    foo.c 1
>    bar.c 1
> Then how do we know if foo.c and bar.c are SKIP_WORKTREE or
> INTENT_TO_ADD?  The "1" could have come from either field.
>

I understand your confusion here. If we need to combine these
boolean values in --format with %(if) %(else) of ref-filter in the future,
we can only do this strange design. Output like "true"/"false" or "1"/"0"
would be better without considering %(if), %(else).

> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> >  Documentation/git-ls-files.txt |  5 +++++
> >  builtin/ls-files.c             |  3 +++
> >  t/t3013-ls-files-format.sh     | 23 +++++++++++++++++++++++
> >  3 files changed, 31 insertions(+)
> >
> > diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-file=
s.txt
> > index 440043cdb8e..2540b404808 100644
> > --- a/Documentation/git-ls-files.txt
> > +++ b/Documentation/git-ls-files.txt
> > @@ -260,6 +260,11 @@ eolattr::
> >         that applies to the path.
> >  path::
> >         The pathname of the file which is recorded in the index.
> > +skipworktree::
> > +       If the file in the index marked with SKIP_WORKTREE bit.
> > +       It means the file do not match the sparse specification.
> > +       See link:technical/sparse-checkout.txt[sparse-checkout]
> > +       for more information.
>
> minor nits: Missing an "is", and "do" should be "does".
>
> I'm curious whether the second sentence is even necessary; we've
> already got the link to the more technical docs.  Perhaps just:
>
> skipworktree::
>     Whether the file in the index has the SKIP_WORKTREE bit set.
>     See link:technical/sparse-checkout.txt[sparse-checkout]
>     for more information.
>

Agree.

> >  EXCLUDE PATTERNS
> >  ----------------
> > diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> > index a03b559ecaa..bbff868ae6b 100644
> > --- a/builtin/ls-files.c
> > +++ b/builtin/ls-files.c
> > @@ -280,6 +280,9 @@ static size_t expand_show_index(struct strbuf *sb, =
const char *start,
> >                               data->pathname));
> >         else if (skip_prefix(start, "(path)", &p))
> >                 write_name_to_buf(sb, data->pathname);
> > +       else if (skip_prefix(start, "(skipworktree)", &p))
> > +               strbuf_addstr(sb, ce_skip_worktree(data->ce) ?
> > +                             "1" : "");
>
> As I mentioned in response to the commit message, I don't understand
> why having an empty string would be desirable.
>
> >         else
> >                 die(_("bad ls-files format: %%%.*s"), (int)len, start);
> >
> > diff --git a/t/t3013-ls-files-format.sh b/t/t3013-ls-files-format.sh
> > index efb7450bf1e..cd35dba5930 100755
> > --- a/t/t3013-ls-files-format.sh
> > +++ b/t/t3013-ls-files-format.sh
> > @@ -92,4 +92,27 @@ test_expect_success 'git ls-files --format with --de=
bug' '
> >         test_cmp expect actual
> >  '
> >
> > +test_expect_success 'git ls-files --format with skipworktree' '
> > +       test_when_finished "git sparse-checkout disable" &&
> > +       mkdir dir1 dir2 &&
> > +       echo "file1" >dir1/file1.txt &&
> > +       echo "file2" >dir2/file2.txt &&
> > +       git add dir1 dir2 &&
> > +       git commit -m skipworktree &&
> > +       git sparse-checkout set dir1 &&
> > +       git ls-files --format=3D"%(path)%(skipworktree)" >actual &&
> > +       cat >expect <<-\EOF &&
> > +       dir1/file1.txt
> > +       dir2/file2.txt1
> > +       o1.txt
> > +       o2.txt
> > +       o3.txt
> > +       o4.txt
> > +       o5.txt
> > +       o6.txt
> > +       o7.txt
> > +       EOF
> > +       test_cmp expect actual
> > +'
>
> I find this test hard to read; it's just too easy to miss
> "dir2/file2.txt1" vs "dir2/file2.txt".  I'd suggest at least adding a
> space, and likely having the skipworktree attribute come first in the
> format string.  It might also be useful to add "dir*" on the ls-files
> command to limit which paths are shown, just because there's an awful
> lot of files in the root directory and no variance between them, and
> it's easier to notice the binary difference between two items than
> having a full 9 and figuring out which are relevant.

Good idea.

I deliberately removed the space between %(path) and
%(skipworktree) before, because according to the current design,
the "" output by %(skipworktree) is empty, which leads to an extra
space at the end of the output line, which will break github's
 "whitespace" ci tests. Maybe swapping the location of %(path) and
%(skipworktree) will fix this.
