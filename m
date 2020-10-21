Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC30C4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 18:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79D042237B
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 18:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpW4IqpA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503882AbgJUSEu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 14:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503879AbgJUSEu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 14:04:50 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94642C0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 11:04:48 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id m128so3023164oig.7
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 11:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RpMtKPZnk15XRc8jFblvCRoEAis5F0ySOADERg/hAfw=;
        b=MpW4IqpA9HlR/RaOKgNY5vE5pdB4KOK7gfDGgW7z0lLmbqsfSTI8Z6Q9blihkp3x10
         aLtApwMVesq5QjwMwZyBbKaX8yPbWirPJQwbiafGsib3cSwXypAIlRuH5JQW19gsZ/3m
         /TMREzSnIhAnrOBZ7DIrKZh+ayuUqAvD23B5SXXttwJHfMxcpkN4bMWrWBwhh4z1GHDP
         Jy/6WCrCOy4tNKMt9kzUUj2Hc6RbFD7czfRL4kW0wzGJTeHto+K5SYac1PFwMfRu4Q2Q
         tis39crSTkCx7Drbo2qhuI6/WIxkTE7vcUQW4ENB3+pjqvekbYvv4pSr4lGCx74BHBqe
         pEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RpMtKPZnk15XRc8jFblvCRoEAis5F0ySOADERg/hAfw=;
        b=Lbxsx7PPOOX1/ELj9/3A1YVt3Zqvjzg1EbFuEBivPEcRNI17p9NJHCZd87vIqQ1xnt
         F9iqWeJwQ7wnEKvk3xSaSKWmZ/5z7nEzxVbhZ0LoaVsXGKWpw4VPYAKGZPclTmGkSbS3
         YiYrkRL6ugFAEL+wcMKlZgJlHsVxjA/EIV3MLOWkPAnT4hQx0I+15m44NapQuYtlKC7S
         V2hdQNJMjMH8wDxPt65rEaEpN6UDzxJQNDPQo0cNy43UJO+dZBPwyJ0Az+EY35KTv68g
         QFTxajqkJAnKpK20JdfoY8AeKK6NWO3TSqjWz8TK5SM2qX7XaXTK6zWWmj7G2TvQXeu3
         XPsA==
X-Gm-Message-State: AOAM532wP8IGh9h79GN1ByDoMY5YUiImxvylek1w9VLUpnvnDFj5X2x6
        h4OWuup0BaR9k9qD4Z1BjlZ30p07loYUeYGuyBI=
X-Google-Smtp-Source: ABdhPJwCeG+QciR52s4uyDCdQOI0bHW/oiCQXR1phTc3RayoEoDd86zJbZYAZBoaPQK0WWDpR1V5+Az9ez6F+03KTMg=
X-Received: by 2002:aca:3b0a:: with SMTP id i10mr3237682oia.167.1603303487778;
 Wed, 21 Oct 2020 11:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqy2k2t77l.fsf@gitster.c.googlers.com> <CABPp-BG+uP2-t62AfgBauvoRtXfF4pU-xXKq3+YEEhjDdiHR_w@mail.gmail.com>
 <nycvar.QRO.7.76.6.2010211630010.56@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2010211630010.56@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 21 Oct 2020 11:04:36 -0700
Message-ID: <CABPp-BFLAVV-pgMrsbjeQejf=yyvMi9CcQzd=CANj=EsePLnrw@mail.gmail.com>
Subject: Re: git-filter-repo v2.29.0, was Re: [ANNOUNCE] Git v2.29.0
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Wed, Oct 21, 2020 at 7:46 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Mon, 19 Oct 2020, Elijah Newren wrote:
>
> > git-filter-repo can also be installed via a variety of package managers
> > across Windows, Mac OS, or Linux (and maybe others)[1].
>
> In the few attempts I ran to verify that this indeed works on Windows, I
> always stumbled over the tests that require "funny" characters in the file
> names. However, it seems that at least a couple later test cases rely on
> side effects of those test cases that require those characters, so I never
> managed to get this to work. Here is my work-that-is-not-even-in-progress:
>
> -- snip --
> diff --git a/git-filter-repo b/git-filter-repo
> index ac039ec..7e2a534 100755
> --- a/git-filter-repo
> +++ b/git-filter-repo
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env python3
> +#!/usr/bin/env python
>
>  """
>  git-filter-repo filters git repositories, similar to git filter-branch, BFG
> diff --git a/t/t9390-filter-repo.sh b/t/t9390-filter-repo.sh
> index 14bdeaa..d7f9f1f 100755
> --- a/t/t9390-filter-repo.sh
> +++ b/t/t9390-filter-repo.sh
> @@ -298,7 +298,7 @@ setup_metasyntactic_repo() {
>         )
>  }
>
> -test_expect_success '--tag-rename' '
> +test_expect_success FUNNYNAMES '--tag-rename' '
>         setup_metasyntactic_repo &&
>         (
>                 git clone file://"$(pwd)"/metasyntactic tag_rename &&
> @@ -317,7 +317,7 @@ test_expect_success '--tag-rename' '
>         )
>  '
>
> -test_expect_success '--subdirectory-filter' '
> +test_expect_success FUNNYNAMES '--subdirectory-filter' '
>         setup_metasyntactic_repo &&
>         (
>                 git clone file://"$(pwd)"/metasyntactic subdir_filter &&
> @@ -336,7 +336,7 @@ test_expect_success '--subdirectory-filter' '
>         )
>  '
>
> -test_expect_success '--subdirectory-filter with trailing slash' '
> +test_expect_success FUNNYNAMES '--subdirectory-filter with trailing slash' '
>         setup_metasyntactic_repo &&
>         (
>                 git clone file://"$(pwd)"/metasyntactic subdir_filter_2 &&
> @@ -355,7 +355,7 @@ test_expect_success '--subdirectory-filter with trailing slash' '
>         )
>  '
>
> -test_expect_success '--to-subdirectory-filter' '
> +test_expect_success FUNNYNAMES '--to-subdirectory-filter' '
>         setup_metasyntactic_repo &&
>         (
>                 git clone file://"$(pwd)"/metasyntactic to_subdir_filter &&
> @@ -375,7 +375,7 @@ test_expect_success '--to-subdirectory-filter' '
>         )
>  '
>
> -test_expect_success '--use-base-name' '
> +test_expect_success FUNNYNAMES '--use-base-name' '
>         setup_metasyntactic_repo &&
>         (
>                 git clone file://"$(pwd)"/metasyntactic use_base_name &&
> @@ -394,7 +394,7 @@ test_expect_success '--use-base-name' '
>         )
>  '
>
> -test_expect_success 'refs/replace/ to skip a parent' '
> +test_expect_success FUNNYNAMES 'refs/replace/ to skip a parent' '
>         setup_metasyntactic_repo &&
>         (
>                 git clone file://"$(pwd)"/metasyntactic replace_skip_ref &&
> @@ -416,7 +416,7 @@ test_expect_success 'refs/replace/ to skip a parent' '
>         )
>  '
>
> -test_expect_success 'refs/replace/ to add more initial history' '
> +test_expect_success FUNNYNAMES 'refs/replace/ to add more initial history' '
>         setup_metasyntactic_repo &&
>         (
>                 git clone file://"$(pwd)"/metasyntactic replace_add_refs &&
> @@ -451,7 +451,7 @@ test_expect_success 'refs/replace/ to add more initial history' '
>         )
>  '
>
> -test_expect_success 'creation/deletion/updating of replace refs' '
> +test_expect_success FUNNYNAMES 'creation/deletion/updating of replace refs' '
>         setup_metasyntactic_repo &&
>         (
>                 git clone file://"$(pwd)"/metasyntactic replace_handling &&
> @@ -510,7 +510,7 @@ test_expect_success 'creation/deletion/updating of replace refs' '
>         )
>  '
>
> -test_expect_success '--debug' '
> +test_expect_success FUNNYNAMES '--debug' '
>         setup_metasyntactic_repo &&
>         (
>                 git clone file://"$(pwd)"/metasyntactic debug &&
> @@ -533,7 +533,7 @@ test_expect_success '--debug' '
>         )
>  '
>
> -test_expect_success '--dry-run' '
> +test_expect_success FUNNYNAMES '--dry-run' '
>         setup_metasyntactic_repo &&
>         (
>                 git clone file://"$(pwd)"/metasyntactic dry_run &&
> @@ -561,7 +561,7 @@ test_expect_success '--dry-run' '
>         )
>  '
>
> -test_expect_success '--dry-run --debug' '
> +test_expect_success FUNNYNAMES '--dry-run --debug' '
>         setup_metasyntactic_repo &&
>         (
>                 git clone file://"$(pwd)"/metasyntactic dry_run_debug &&
> @@ -589,7 +589,7 @@ test_expect_success '--dry-run --debug' '
>         )
>  '
>
> -test_expect_success '--dry-run --stdin' '
> +test_expect_success FUNNYNAMES '--dry-run --stdin' '
>         setup_metasyntactic_repo &&
>         (
>                 git clone file://"$(pwd)"/metasyntactic dry_run_stdin &&
> @@ -892,7 +892,8 @@ test_expect_success '--strip-blobs-with-ids' '
>                 grep fake_submodule ../filenames &&
>
>                 # Strip "a certain file" files
> -               git filter-repo --strip-blobs-with-ids <(echo deadbeefdeadbeefdeadbeefdeadbeefdeadbeef) &&
> +               echo deadbeefdeadbeefdeadbeefdeadbeefdeadbeef >../input &&
> +               git filter-repo --strip-blobs-with-ids ../input &&
>
>                 git log --format=%n --name-only | sort | uniq >../filenames &&
>                 test_line_count = 10 ../filenames &&
> @@ -917,7 +918,7 @@ test_expect_success '--strip-blobs-with-ids' '
>                 ! grep words/to ../filenames &&
>                 ! grep capricious ../filenames &&
>                 ! grep fickle ../filenames &&
> -               ! grep mercurial ../filenames
> +               ! grep mercurial ../filenames &&
>
>                 # Remove the temporary auxiliary files
>                 rm ../bad-ids &&
> -- snap --
>
> (There are two unrelated fixes in there, to be sure.)
>
> I wonder whether there would be a chance that you and I could combine
> efforts so that git-filter-repo is MEAOW (Most Enjoyable Also On Windows)?
> Maybe starting with the addition of a GitHub workflow that uses Git for
> Windows' SDK via something along the lines of Git's `windows-build` steps:
> https://github.com/git/git/blob/v2.29.0/.github/workflows/main.yml#L81-L95
> (although it would need the full `git-sdk-64` artifact of
> https://dev.azure.com/git-for-windows/git/_build?definitionId=29&_a=summary
> because it requires Python, which git-sdk-64-minimal excludes)?

Sounds great!  Thanks for kicking it off (over at
https://github.com/newren/git-filter-repo/pull/167, for those
following along).

Elijah
