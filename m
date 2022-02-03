Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD81C433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 23:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356085AbiBCX60 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 18:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiBCX6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 18:58:25 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25BFC061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 15:58:24 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id d10so13731465eje.10
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 15:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dzJbbWzW6/C0cNdCNfvtANXa8sXyJhmmcgegcZE0wX8=;
        b=I3eqdenniJiDSszO4L3xX2oz68/gZH2XtWs5H+mpmf+EZrAP86UHzLIrehk39Vad2s
         77iKYxfCgYdH6xXUyelezBqWVEDm0zSurEmx3FcP+CnJtnXlvtTtYfIeu/CNQBV+OivK
         bzyb9+CZg86DzFofogMpTvcvS6wg6is6qaa5LuftA+nY5ZLIgOdMr+/59EyImDiElvR9
         yhEDaGBtMDae9qptSCmZ+Sk3L+/OPgtTE4cwmssj93ki75zZEDPUKzMWQTEciyu1Cfh/
         PbXCEyCx2wyNtPThj9Abyn5WHSwU/8mB4KamBb22/0rmOZzbMBj2EtI28HYsrkF7ZOqO
         mYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dzJbbWzW6/C0cNdCNfvtANXa8sXyJhmmcgegcZE0wX8=;
        b=jXf9nW75feTQjRUYCJAksvzrN7P/PM2jhpJVxex32hFaBsfhrzErr/Aa1gbu1KsIeg
         hMFRRcOitFf06cql5fx4nn/n8QCepDyMN2evSc+hMYTvAG0puNBmu4Th7uQ57Bm4Kcj5
         u/EfOvtpLHj6fdjcgKC3m5cmVT36bz/5DwhSJYy5cD9JJVcl+iaEsCxsMs2YZYKvM5QG
         rChAbvimig+iWD089dbH/RcmmpBn2/v3U1Op/2vNqY+k5hLrDysDBJNeRijdrd2geI1S
         AZnKQvKKuaqKdUQg4OMLM8ZuyqSUC0DayLqjI5IXb26MkHk7ZxeERy538OplQfIpUE7n
         b2zA==
X-Gm-Message-State: AOAM532MZylL/iMViZ4R4vSkkDp41tijl7dELMKEPuq3vR6ZqgxULM8Q
        bXBXyG/LikXJvElUKTS5e8EjwC4VsNGAPHTzUFw=
X-Google-Smtp-Source: ABdhPJzsg9RolJIO0q7kdgFHIWA3do1kMtPvWuQocs7WdOC7nOD5kLO0q4vzgoUifAMbEt7f1ODtea20nPpHIt06ICM=
X-Received: by 2002:a17:907:1b0f:: with SMTP id mp15mr245918ejc.493.1643932703116;
 Thu, 03 Feb 2022 15:58:23 -0800 (PST)
MIME-Version: 1.0
References: <pull.1108.v4.git.1643318514.gitgitgadget@gmail.com>
 <pull.1108.v5.git.1643921091.gitgitgadget@gmail.com> <ddf5e583dd71a729d6fb0513aed9fc4eb6ebbdd7.1643921091.git.gitgitgadget@gmail.com>
In-Reply-To: <ddf5e583dd71a729d6fb0513aed9fc4eb6ebbdd7.1643921091.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 3 Feb 2022 15:58:12 -0800
Message-ID: <CABPp-BFD51BTsG7gQFD4BuqVLLBV2iJOKnrnya89otoGonzVvA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] completion: handle unusual characters for sparse-checkout
To:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        johannes.schindelin@gmail.com, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 3, 2022 at 12:44 PM Lessley Dennington via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Lessley Dennington <lessleydennington@gmail.com>
>
> Update the __gitcomp_directories method to de-quote and handle unusual
> characters in directory names. Although this initially involved an attemp=
t
> to re-use the logic in __git_index_files, this method removed
> subdirectories (e.g. folder1/0/ became folder1/), so instead new custom
> logic was placed directly in the __gitcomp_directories method.
>
> Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Co-authored-by: Lessley Dennington <lessleydennington@gmail.com>
> Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 50 +++++++++++++-------------
>  t/t9902-completion.sh                  | 28 +++++++++++++++
>  2 files changed, 52 insertions(+), 26 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index c5c8df6b6e5..c47e9ce09b2 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2988,32 +2988,30 @@ _git_show_branch ()
>
>  __gitcomp_directories ()
>  {
> -     local _tmp_dir _tmp_completions
> -
> -     # Get the directory of the current token; this differs from dirname
> -     # in that it keeps up to the final trailing slash.  If no slash fou=
nd
> -     # that's fine too.
> -     [[ "$cur" =3D~ .*/ ]]
> -     _tmp_dir=3D$BASH_REMATCH
> -
> -     # Find possible directory completions, adding trailing '/' characte=
rs
> -     _tmp_completions=3D"$(git ls-tree -d --name-only HEAD $_tmp_dir |
> -         sed -e s%$%/%)"
> -
> -     if [[ -n "$_tmp_completions" ]]; then
> -         # There were some directory completions, so find ones that
> -         # start with "$cur", the current token, and put those in COMPRE=
PLY
> -         local i=3D0 c IFS=3D$' \t\n'
> -         for c in $_tmp_completions; do
> -             if [[ $c =3D=3D "$cur"* ]]; then
> -                 COMPREPLY+=3D("$c")
> -             fi
> -         done
> -     elif [[ "$cur" =3D~ /$ ]]; then
> -         # No possible further completions any deeper, so assume we're a=
t
> -         # a leaf directory and just consider it complete
> -         __gitcomp_direct_append "$cur "
> -     fi
> +       local _tmp_dir _tmp_completions _found=3D0
> +
> +       # Get the directory of the current token; this differs from dirna=
me
> +       # in that it keeps up to the final trailing slash.  If no slash f=
ound
> +       # that's fine too.
> +       [[ "$cur" =3D~ .*/ ]]
> +       _tmp_dir=3D$BASH_REMATCH
> +
> +       # Find possible directory completions, adding trailing '/' charac=
ters,
> +       # de-quoting, and handling unusual characters.
> +       while IFS=3D read -r -d $'\0' c ; do
> +               # If there are directory completions, find ones that star=
t
> +               # with "$cur", the current token, and put those in COMPRE=
PLY
> +               if [[ $c =3D=3D "$cur"* ]]; then
> +                       COMPREPLY+=3D("$c/")
> +                       _found=3D1
> +               fi
> +       done < <(git ls-tree -z -d --name-only HEAD $_tmp_dir)
> +
> +       if [[ $_found =3D=3D 0 ]] && [[ "$cur" =3D~ /$ ]]; then
> +               # No possible further completions any deeper, so assume w=
e're at
> +               # a leaf directory and just consider it complete
> +               __gitcomp_direct_append "$cur "
> +       fi

The indentation changes are distracting and make the patch harder to
review.  Could you either remove those, or apply the indentation
changes to patch 2 so that it starts with the right indentation?

I'm slightly surprised that __gitcomp_direct_append handles the
quoting for us, but the testcases below seem to cover it, so that's
cool.

Anyway, looks pretty clever to me; I was worried this was going to
require a much bigger change.

>  }
>
>  _git_sparse_checkout ()
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index b38a7302249..7f63d6057be 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -1508,6 +1508,34 @@ test_expect_success 'cone mode sparse-checkout com=
pletes directory names' '
>         )
>  '
>
> +# use FUNNYNAMES to avoid running on Windows, which doesn't permit backs=
lashes in paths
> +test_expect_success FUNNYNAMES 'cone mode sparse-checkout completes dire=
ctory names with special characters' '
> +       # reset sparse-checkout
> +       git -C sparse-checkout sparse-checkout disable &&
> +       (
> +               cd sparse-checkout &&
> +               mkdir "directory with spaces" &&
> +               mkdir "$(printf "directory\twith\ttabs")" &&
> +               mkdir "directory\with\backslashes" &&
> +               mkdir "directory-with-=C3=A1ccent" &&
> +               >"directory with spaces/randomfile" &&
> +               >"$(printf "directory\twith\ttabs")/randomfile" &&
> +               >"directory\with\backslashes/randomfile" &&
> +               >"directory-with-=C3=A1ccent/randomfile" &&
> +               git add . &&
> +               git commit -m "Add directories containing unusual charact=
ers" &&
> +               git sparse-checkout set --cone "directory with spaces" \
> +                       "$(printf "directory\twith\ttabs")" "directory\wi=
th\backslashes" \
> +                       "directory-with-=C3=A1ccent" &&
> +               test_completion "git sparse-checkout add dir" <<-\EOF
> +               directory with spaces/
> +               directory       with    tabs/
> +               directory\with\backslashes/
> +               directory-with-=C3=A1ccent/
> +               EOF
> +       )
> +'

I'm glad you tested with lots of special characters -- spaces, tabs,
backslashes, and accents.  Newlines might also be nice, but probably
makes the test hard.  Anyway, looks good to me, other than the
indentation change.

> +
>  test_expect_success 'non-cone mode sparse-checkout uses bash completion'=
 '
>         # reset sparse-checkout repo to non-cone mode
>         git -C sparse-checkout sparse-checkout disable &&
> --
> gitgitgadget
