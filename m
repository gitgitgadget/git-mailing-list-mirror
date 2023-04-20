Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5AEC77B73
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 04:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjDTEuR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 00:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbjDTEuQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 00:50:16 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1FD4225
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 21:50:14 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-2f40b891420so291689f8f.0
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 21:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681966213; x=1684558213;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WR+CX1vH97hK5cicjGMeqtOqaz6sI8VLve/5xPZj8LM=;
        b=Oarj6BylmqgZSYTMJRhDKvOLSdzX0lDQJ5MiHHjwOvy/Fkaj7dNvkZBcb8jl+g6NuY
         nPpoFG+LKNUtjK55jqk9hAaMKdy/QrYTnuyUuV2iU/BFFZvbhN587D5s7GgjkxtQ6O4l
         AzRDJdxRKLiTchTSkIvQswZztHdOKTzH40RhHXrZyxfswLId7VmRLHx79m+MRRz8zvSD
         rgIf3YH7UggSQh0Ao0jP82uJrionMV+FVY/74Unq1jRVFTrp39NxfTX/+SGalFe/dNF3
         iIsXJNALQbwrEPrKiQlkpeD1i3TukirnVgn9SE4SaQtIn6dAFKJDs/+ziIzmZj4eRU8w
         7FZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681966213; x=1684558213;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WR+CX1vH97hK5cicjGMeqtOqaz6sI8VLve/5xPZj8LM=;
        b=SbPsNS7/soUxbHWKxu3CE+4ZxeAbeOV5LEDiUSw4weL/VX3D6rMj8ncrIb+1TM0JtV
         JZaAvkjQ0y9kss1Dm+UCIftKkQf1X521QFEX8EoGrAjW2iLCHfm2+Cmf/P3rGJ6ngKuj
         R9hY7BxqyVHuy0VIqIS1SI6mXUtmmfMk8jlJC1Pzmj4BldLaLvKiG/ddwgKzfYSroVSv
         J4+ekk3sWELgR+leDqh1TnrcqLo9BYQv94/KKF4y7WiJvy3sw6Wu4G6cVmS4pcB6zRl/
         tQM0/tCujTiAkwtinxweQ6sl2daAcW65tMor+XDXbn1vrFrWmd1Okpks58OBWZb5OSzA
         VYag==
X-Gm-Message-State: AAQBX9f4qiWfUXl58ljfx8w/2m+HbQfG5TIZoifcO9U1FwpoYIL3gUx3
        e2XbqFzgkX4ul+k/fhLsdQ3vHC+vHpOPxKksW1fY/uIkXSZhjw==
X-Google-Smtp-Source: AKy350alf1ageLtjaeYeFBapl71jrPxWRsEJ1LnYp1ybtRUxXCRlk7c/A7oMZ/8PI5n6idrtbkMAZqbik0U6cLC2ejg=
X-Received: by 2002:a5d:5742:0:b0:2d0:bba8:3901 with SMTP id
 q2-20020a5d5742000000b002d0bba83901mr125526wrw.62.1681966213083; Wed, 19 Apr
 2023 21:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230320205241.105476-1-cheskaqiqi@gmail.com> <20230322161820.3609-1-cheskaqiqi@gmail.com>
 <20230322161820.3609-3-cheskaqiqi@gmail.com> <c382017a-8c65-24ba-5092-6b46428d8b9b@github.com>
In-Reply-To: <c382017a-8c65-24ba-5092-6b46428d8b9b@github.com>
From:   Shuqi Liang <cheskaqiqi@gmail.com>
Date:   Thu, 20 Apr 2023 00:50:00 -0400
Message-ID: <CAMO4yUF1P1Sv1aVJ1aw9US-QeNYD-GfaS7ndr=bwp-dgvOyexA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] diff-files: integrate with sparse index
To:     Victoria Dye <vdye@github.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria,

Sorry for the late reply. I'm still in the middle of my final exams period.

On Thu, Apr 13, 2023 at 5:55=E2=80=AFPM Victoria Dye <vdye@github.com> wrot=
e:
>
> Shuqi Liang wrote:
> > diff --git a/builtin/diff-files.c b/builtin/diff-files.c
> > index dc991f753b..db90592090 100644
> > --- a/builtin/diff-files.c
> > +++ b/builtin/diff-files.c
> > @@ -27,6 +27,10 @@ int cmd_diff_files(int argc, const char **argv, cons=
t char *prefix)
> >               usage(diff_files_usage);
> >
> >       git_config(git_diff_basic_config, NULL); /* no "diff" UI options =
*/
> > +
> > +     prepare_repo_settings(the_repository);
> > +     the_repository->settings.command_requires_full_index =3D 0;
> > +
> >       repo_init_revisions(the_repository, &rev, prefix);
> >       rev.abbrev =3D 0;
> >
> > @@ -80,6 +84,10 @@ int cmd_diff_files(int argc, const char **argv, cons=
t char *prefix)
> >               result =3D -1;
> >               goto cleanup;
> >       }
> > +
> > +     if (pathspec_needs_expanded_index(the_repository->index, &rev.dif=
fopt.pathspec))
> > +             ensure_full_index(the_repository->index);
>
> After reviewing the 'diff-index' integration [1], I'm wondering whether w=
e
> actually need pathspec expansion at all in this case. 'diff-files' compar=
es
> the working tree and the index, and will output a difference if the file =
on
> disk differs from the index. But, if a file is SKIP_WORKTREE'd, that diff
> will (I think?) always be empty. So, why would we need to expand a sparse
> directory to match a pathspec to its contents if we *know* that the diff
> will be empty?
>
> [1] https://lore.kernel.org/git/20230408112342.404318-1-nanth.raghul@gmai=
l.com/


It's true that in the case of 'diff-files', expanding the sparse directory =
to
match a pathspec to its contents might not be necessary. If we don't use
pathspec expansion in this case. It could optimize for performance better.

However, there could be some edge cases. if a user manually modifies the
contents of a SKIP_WORKTREE file in the working tree, the diff between
the working tree and the index would no longer be empty. So I think, In thi=
s
case, expanding the sparse directory might still be necessary to ensure the
correct behavior of the 'diff-files' command.



> > diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-=
checkout-compatibility.sh
> > index d23041e27a..152f3f752e 100755
> > --- a/t/t1092-sparse-checkout-compatibility.sh
> > +++ b/t/t1092-sparse-checkout-compatibility.sh
> > @@ -1401,6 +1401,30 @@ ensure_not_expanded () {
> >       test_region ! index ensure_full_index trace2.txt
> >  }
> >
> > +ensure_expanded () {
> > +     rm -f trace2.txt &&
> > +     if test -z "$WITHOUT_UNTRACKED_TXT"
> > +     then
> > +             echo >>sparse-index/untracked.txt
> > +     fi &&
> > +
> > +     if test "$1" =3D "!"
> > +     then
> > +             shift &&
> > +             test_must_fail env \
> > +                     GIT_TRACE2_EVENT=3D"$(pwd)/trace2.txt" \
> > +                     git -C sparse-index "$@" \
> > +                     >sparse-index-out \
> > +                     2>sparse-index-error || return 1
> > +     else
> > +             GIT_TRACE2_EVENT=3D"$(pwd)/trace2.txt" \
> > +                     git -C sparse-index "$@" \
> > +                     >sparse-index-out \
> > +                     2>sparse-index-error || return 1
> > +     fi &&
> > +     test_region index ensure_full_index trace2.txt
> > +}
>
> This implementation duplicates a lot of the code from 'ensure_not_expande=
d'.
> Can 'ensure_expanded' and 'ensure_not_expanded' be refactored to call a
> common helper function (which contains the common code) instead?

Will do!

> > +
> >  test_expect_success 'sparse-index is not expanded' '
> >       init_repos &&
> >
> > @@ -2101,4 +2125,32 @@ test_expect_success 'diff-files with pathspec ou=
tside sparse definition' '
> >       test_all_match git diff-files "folder*/a"
> >  '
> >
> > +test_expect_success 'diff-files pathspec expands index when necessary'=
 '
> > +     init_repos &&
> > +
> > +     write_script edit-contents <<-\EOF &&
> > +     echo text >>"$1"
> > +     EOF
> > +
> > +     run_on_all ../edit-contents deep/a &&
> > +
> > +     # pathspec that should expand index
> > +     ensure_expanded diff-files "*/a" &&
> > +     ensure_expanded diff-files "**a"
>
> Similar to the comments in my 'diff-index' review [2]:
>
> - The '**' in the pathspec doesn't do anything special unless using an
>   explicit ':(glob)' pathspec. To make it clear that you're not trying to
>   use a glob pathspec, you can use '*a' instead.

Will do !

> - Why are these pathspecs in quotes, but those in 'sparse index is not
>   expanded: diff-files' are?
>
> [2] https://lore.kernel.org/git/62821012-4fc3-5ad8-695c-70f7ab14a8c9@gith=
ub.com/


I quote around the pathspec  to prevent shell expansion  of the pathspec
patterns by the shell before they are passed to the git command. "*a" and
"*/a"  have special characters ' * '. I use quotes to tell the shell
to treat them
as regular characters.

In 'sparse index is not expanded: diff-files''deep/a'  does not contain any
special characters that the shell would try to expand. So I use it without
double quotes. And  I think I need to add a double quote to 'deep/*'.

Thanks,
Shuqi
