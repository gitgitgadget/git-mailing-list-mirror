Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B99C433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 01:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345178AbiA1Bxg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 20:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244433AbiA1Bxe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 20:53:34 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26FBC061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 17:53:33 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id d10so10692847eje.10
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 17:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kGr8rbZA5B7NK3twE9uGI872cq0lSGwAxUY9ifn8pwc=;
        b=KvkosPFuj6xZgaAshIAbiDJg2k4Q2u1+3ztAilZUOQSuOf9qI39kxRgPmBmkHLD5tQ
         25NdjmsA+vAiolQc90wcxINMfv8ywe3YV4vMwmnRAxxNhTcoV7++5yQC1ss/0SMTWp3T
         qu+nGfRFG+Xewg1uMJik5AJrfZVDi0qWL6U32MrvFLgt1r3St2rJ3k0LijHsE9p8in6Y
         OljMvHWrVDopxdh1HbUJLx/Ebe2pjFubO4LaufMO83qDWKoXDnx9jFzTjgSysymGvBnM
         b07ceO1/dAHPWPMZ5amklSeDQCemuzBkGE5P20oHnJ+F3MEdVRsckYWfRGxNhM5MOoPd
         jVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kGr8rbZA5B7NK3twE9uGI872cq0lSGwAxUY9ifn8pwc=;
        b=uqXh9xjI+79z/wtVHLR+T6d3WLfPvqv3scMGa6FRBdHgHOUpcdsbipJvivrdhrmYCS
         ytnkwaSKKGGusMffMw/0efIXB6N6oAeLE/QExNEQlCt0Q1WH0VtlIkzoFyfXlqnfLRMS
         +5mzQlYn5qyV9l+N1XyLjASXaCm6NX9Q2vvBZ1bKp1cDnWgf/e5f4t4DwalVgU0VyVcw
         BJ8xeVANA4eSelFNSYYAmMBMLYG3W+Ze1syzR8kjleWd/LzGxvMwz5HW826sw7bHE6+a
         cXQDCxh02a9W5oEo9MmJGMsseRXbAYmIy4KEKRJ5K3S6Kzu03Tfyq4w8kB1GhgwOOijH
         qKDw==
X-Gm-Message-State: AOAM5315mRcEhMM2d6Y4H1PkBIGXmdbqbyXQmZhUeS0QBf5Pyga170eZ
        8cjDs1Mi+Bi1BC1S0CvOI4i1SAIc1asv4fmMs3U=
X-Google-Smtp-Source: ABdhPJyGZ17DwIYCTpMx9vbQE5kECEo24JV5UID5JK+HXK3rfNEztpX+Jzfoo7ggJqX+WdUhjvBLaPqngY1XkrLAev4=
X-Received: by 2002:a17:907:7d88:: with SMTP id oz8mr5209372ejc.328.1643334812159;
 Thu, 27 Jan 2022 17:53:32 -0800 (PST)
MIME-Version: 1.0
References: <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
 <pull.1108.v4.git.1643318514.gitgitgadget@gmail.com> <760cae85bd4163d9cbef1585186cda60c8c3b35b.1643318514.git.gitgitgadget@gmail.com>
In-Reply-To: <760cae85bd4163d9cbef1585186cda60c8c3b35b.1643318514.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 27 Jan 2022 17:53:20 -0800
Message-ID: <CABPp-BEq9pTqsy_R_SR1DSgUK58ubNR1Gk4G1RoL8wkadyo6zw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] completion: ensure cone mode completion with
 multiple <TAB>s
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

On Thu, Jan 27, 2022 at 1:21 PM Lessley Dennington via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Lessley Dennington <lessleydennington@gmail.com>
>
> Ensure users in a cone mode sparse checkout can tab-complete to
> directories at multiple levels with multiple <TAB>s. For example, if path
> a/b/c/ exists in the current directory, running a<TAB>b<TAB> will result
> in:
>
>         a/b/c/

Um, didn't that already happen before this commit (other than the
trailing slash)?

In my mind, the reasons to switch from __git_complete_index_file to
__gitcomp_directories are:

  * __git_complete_index_file() completes on files, and we want only direct=
ories
  * __git_complete_index_file() can only complete on paths stored in
the index.  With --sparse-index mode, the directory (and all files
under it) we want to complete on may not exist in the index.

Both of these things make __git_complete_index_file() unsuitable.

> The 'sparse-checkout completes directory names' test has also been
> updated with trailing slashes according to these changes.
>
> Co-authored-by: Elijah Newren <newren@gmail.com>
> Co-authored-by: Lessley Dennington <lessleydennington@gmail.com>
> Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 33 ++++++++++++++++++++++++--
>  t/t9902-completion.sh                  | 12 +++++-----
>  2 files changed, 37 insertions(+), 8 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index a920cdab201..defcc8560c1 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2986,11 +2986,40 @@ _git_show_branch ()
>         __git_complete_revlist
>  }
>
> +__gitcomp_directories ()
> +{
> +     local _tmp_dir _tmp_completions
> +
> +     # Get the directory of the current token; this differs from dirname
> +     # in that it keeps up to the final trailing slash.  If no slash fou=
nd
> +     # that's fine too.
> +     [[ "$cur" =3D~ .*/ ]]
> +     _tmp_dir=3D$BASH_REMATCH
> +
> +     # Find possible directory completions, adding trailing '/' characte=
rs
> +     _tmp_completions=3D"$(git ls-tree -d --name-only HEAD $_tmp_dir |
> +         sed -e s%$%/%)"
> +
> +     if [[ -n "$_tmp_completions" ]]; then
> +         # There were some directory completions, so find ones that
> +         # start with "$cur", the current token, and put those in COMPRE=
PLY
> +         local i=3D0 c IFS=3D$' \t\n'
> +         for c in $_tmp_completions; do
> +             if [[ $c =3D=3D "$cur"* ]]; then
> +                 COMPREPLY+=3D("$c")
> +             fi
> +         done
> +     elif [[ "$cur" =3D~ /$ ]]; then
> +         # No possible further completions any deeper, so assume we're a=
t
> +         # a leaf directory and just consider it complete
> +         __gitcomp_direct_append "$cur "
> +     fi
> +}

As noted at [1], this is going to have problems with special
characters.  In the testcase setup in t9902, modify the repository as
follows:

   mkdir "spaces are evil"
   mkdir "$(printf "tabs\tare\tworse")"
   >"spaces are evil/randomfile"
   >"$(printf "tabs\tare\tworse")/randomfile"
   git add .
   git commit -m "Add directories containing unusual characters"

and then try to complete any of these:

  git sparse-checkout set --cone spa<TAB>
  git sparse-checkout set --cone tab<TAB>
  git sparse-checkout set --cone ev<TAB>
  git sparse-checkout set --cone "tab<TAB>

You'll see it either gets the wrong thing, or doesn't get nothing (and
when it should get nothing, it gets something instead).

We do definitely want to use some form of __gitcomp_directories as I
noted above, but we'll have to lift some of the intelligent quoting
logic out of __git_complete_index_file.  It may be a little easier
since we don't have to worry about "full file path needs to be quoted
even though leading directory does not need to be".

(Also, if it makes it easier to deal with the testcases, you can just
use non-ascii characters instead of the tab character -- just run `git
shortlog -sn origin/master` in git.git, find someone's name with such
a character and copy and paste it into the directory name.  For
example, you could use the =C3=A1 from G=C3=A1bor)

[1] https://lore.kernel.org/git/20220115095725.GA1738@szeder.dev/




> +
>  _git_sparse_checkout ()
>  {
>         local subcommands=3D"list init set disable add reapply"
>         local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
> -
>         if [ -z "$subcommand" ]; then
>                 __gitcomp "$subcommands"
>                 return
> @@ -3002,7 +3031,7 @@ _git_sparse_checkout ()
>                 ;;
>                 set,*|add,*)
>                         if [ $(__git config core.sparseCheckoutCone) ]; t=
hen
> -                               __git_complete_index_file "--directory"
> +                               __gitcomp_directories
>                         fi
>                 ;;
>         esac
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index f56ba3f64c9..c04fc25fa32 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -1478,30 +1478,30 @@ test_expect_success 'cone mode sparse-checkout co=
mpletes directory names' '
>         (
>                 cd sparse-checkout &&
>                 test_completion "git sparse-checkout set f" <<-\EOF
> -               folder1
> -               folder2
> -               folder3
> +               folder1/
> +               folder2/
> +               folder3/
>                 EOF
>         ) &&
>
>         (
>                 cd sparse-checkout &&
>                 test_completion "git sparse-checkout set folder1/" <<-\EO=
F
> -               folder1/0
> +               folder1/0/
>                 EOF
>         ) &&
>
>         (
>                 cd sparse-checkout &&
>                 test_completion "git sparse-checkout set folder1/0/" <<-\=
EOF
> -               folder1/0/1
> +               folder1/0/1/
>                 EOF
>         ) &&
>
>         (
>                 cd sparse-checkout/folder1 &&
>                 test_completion "git sparse-checkout add 0" <<-\EOF
> -               0
> +               0/
>                 EOF
>         )
>  '
> --
> gitgitgadget
