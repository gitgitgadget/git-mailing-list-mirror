Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DE8C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 15:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD882082E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 15:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgibg32M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbgA3Pps (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 10:45:48 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40526 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbgA3Ppr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 10:45:47 -0500
Received: by mail-ot1-f67.google.com with SMTP id i6so3538606otr.7
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 07:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DFpZYt3YTdKa9qDj3Wgr47+zi4h9+7xUKXNWk4K7l7g=;
        b=bgibg32MYQD7g20F6O7TMoTSUxajAx72ql8sefXNioq5yWQD0kng51tlJ4wlsvepeq
         vDTaFozDqUi6YznHoL7xdubnBl3I7ecJf4iIMMPl3XORP4oIol+agyDBNJvV6jOyukyv
         JLiJ7bsR/nCfb3RdD+YefTtvEIdNIm/2TDKLKrrLd7yJB8J1X2bx0NUUaZf5WRek1qts
         IS2H97C9DkRJF+Eq8k0L9kSDCjxbuJ6iU8iEvcE4ImMIgp6fUW4wmIMqGL+P8Vzs8rYY
         BJJPYjnvcUHMi2Blx95jg1WcZ/NvM4obfvpEdLguibFIb2E+izwdpdoIuAzwbdg0TaWQ
         lI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DFpZYt3YTdKa9qDj3Wgr47+zi4h9+7xUKXNWk4K7l7g=;
        b=OWIM796E0w/NlNCYrhSsVpEBP+7qjDq2Ry0J0Am8E4YSgY8Nb2TmWRWhrRK3pUqQBz
         /vDEkQaicuSu+1t6UUxnrndcRMQ3BPRsLUwlimDPU0BiPTiqVrGxkp6ilWbsXmlCMEJe
         sjQW+Q0g6cP0gIgi+VF/gEpb+VSgHtAQzCeBq6wuNvbo070H8/9WFUv9dNH3L4lVyYoJ
         w6Sa2eqjLkLnRYIFMRUT+5uulfwuFDQmN81OVYQE5OKtEpgJTdQEsWYd9C8MGc+rhOrh
         bDSRgLf2h/eyc3swMFQ5zU3ZpcpBZEaAbmsUZiLOt38WXs09Tqe+sYmOC7cKqAoQDIwf
         85jg==
X-Gm-Message-State: APjAAAVcr/5uvWrXHxoyPBHdksmTutSNso754WCRslEkiCQqeN2ZlGxF
        CV2uAj2levba38ovwBakpE6pIqaAKtqCrzlPHaI=
X-Google-Smtp-Source: APXvYqwg5smBq1VYLjDkzunTd/MA6DHyAkM7gRJ+qVqKB3lYPF3mFPvPPlcbsMSB4VrF9KPvtAT2+CTcp2+CGbeikJA=
X-Received: by 2002:a05:6830:158:: with SMTP id j24mr4175633otp.316.1580399146734;
 Thu, 30 Jan 2020 07:45:46 -0800 (PST)
MIME-Version: 1.0
References: <pull.700.git.git.1580335424.gitgitgadget@gmail.com>
 <3b2ec5eaf65c9fe44c4337a4cc2fc3dae6203d54.1580335424.git.gitgitgadget@gmail.com>
 <8d9a6047-26be-ff78-cf1a-9f2b35f927e0@gmail.com>
In-Reply-To: <8d9a6047-26be-ff78-cf1a-9f2b35f927e0@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 Jan 2020 07:45:35 -0800
Message-ID: <CABPp-BFbXJRW38CeGy78b22MfZ8cNizexCM-+n-ODqy+fOo2uw@mail.gmail.com>
Subject: Re: [PATCH 4/6] dir: move setting of nested_repo next to its actual usage
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Martin Melka <martin.melka@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 30, 2020 at 7:33 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 1/29/2020 5:03 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  dir.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/dir.c b/dir.c
> > index 225f0bc082..ef3307718a 100644
> > --- a/dir.c
> > +++ b/dir.c
> > @@ -1659,7 +1659,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
> >       const char *dirname, int len, int baselen, int excluded,
> >       const struct pathspec *pathspec)
> >  {
> > -     int nested_repo = 0;
> > +     int nested_repo;
> >
> >       /* The "len-1" is to strip the final '/' */
> >       switch (directory_exists_in_index(istate, dirname, len-1)) {
> > @@ -1670,6 +1670,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
> >               return path_none;
> >
> >       case index_nonexistent:
> > +             nested_repo = 0;
>
> I had to look at this code in-full from en/fill-directory-fixes-more to
> be sure that this case was the only use of nested_repo. However, I found
> that this switch statement is unnecessarily complicated. By converting
> the switch to multiple "if" statements, I noticed that the third case
> actually has a "break" statement that can lead to the final "fourth case"
> outside the switch statement.
>
> Hopefully the patch below is a worthy replacement for this one:
>
> -->8--
>
> From b5c04e6e028cb6c7f9e78fbdd2182383d928fe6d Mon Sep 17 00:00:00 2001
> From: Derrick Stolee <dstolee@microsoft.com>
> Date: Thu, 30 Jan 2020 15:28:39 +0000
> Subject: [PATCH] dir: refactor treat_directory to clarify variable scope
>
> The nested_repo variable in treat_directory() is created and
> initialized before a multi-case switch statement, but is only
> used by one case. In fact, this switch is very asymmetrical,
> as the first two cases are simple but the third is more
> complicated than the rest of the method.
>
> Extract the switch statement into a series of "if" statements.
> This simplifies the trivial cases, while highlighting the fact
> that a "break" statement in a condition of the third case
> actually leads to jumping to the fourth case (after the switch).
> This assists a reader who provides an initial scan to notice
> there is a second way to approach the "show_other_directories"
> case than simply the response from directory_exists_in_index().

Wait, I'm lost.  Wasn't that break statement the only way to get to
the "show_other_directories" block of code after the switch statement?
 I can't see where the second way is; am I missing something?

That is, unless directory_exists_in_index() suddenly starts returning
some value other than the three current possibilities.  Perhaps we
should throw a BUG() if we get anything other than index_directory,
index_gitdir, or index_nonexistent.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  dir.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index b460211e61..e48812efe6 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1659,17 +1659,16 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>         const char *dirname, int len, int baselen, int exclude,
>         const struct pathspec *pathspec)
>  {
> -       int nested_repo = 0;
> -
>         /* The "len-1" is to strip the final '/' */
> -       switch (directory_exists_in_index(istate, dirname, len-1)) {
> -       case index_directory:
> -               return path_recurse;
> +       enum exist_status status = directory_exists_in_index(istate, dirname, len-1);
>
> -       case index_gitdir:
> +       if (status == index_directory)
> +               return path_recurse;
> +       if (status == index_gitdir)
>                 return path_none;
>
> -       case index_nonexistent:
> +       if (status == index_nonexistent) {
> +               int nested_repo = 0;
>                 if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
>                     !(dir->flags & DIR_NO_GITLINKS)) {
>                         struct strbuf sb = STRBUF_INIT;
> @@ -1682,7 +1681,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>                                 (exclude ? path_excluded : path_untracked));
>
>                 if (dir->flags & DIR_SHOW_OTHER_DIRECTORIES)
> -                       break;
> +                       goto show_other_directories;
>                 if (exclude &&
>                         (dir->flags & DIR_SHOW_IGNORED_TOO) &&
>                         (dir->flags & DIR_SHOW_IGNORED_TOO_MODE_MATCHING)) {
> @@ -1711,7 +1710,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>         }

I'd say we'd want to add a BUG("Unhandled value for
directory_exists_in_index: %d\n", status); right here.

>
>         /* This is the "show_other_directories" case */
> -
> +show_other_directories:
>         if (!(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
>                 return exclude ? path_excluded : path_untracked;
>
> --
> 2.25.0.vfs.1.1

Otherwise, the patch looks good to me and I'll be happy to replace my
patch with this one.
