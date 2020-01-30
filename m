Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66D3C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 16:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB78420707
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 16:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2yvtKCj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgA3QUr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 11:20:47 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42355 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbgA3QUq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 11:20:46 -0500
Received: by mail-oi1-f194.google.com with SMTP id j132so4022400oih.9
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 08:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V0IX2pCrBEp8Iq29H5GKpQ2IiqQOYoapMRQn8Vadm5E=;
        b=D2yvtKCjlh9He4n9+e0wsH6UN9nZwlybBZyqzM/gLU8soeAAEANlWejV4oWQUsu1pM
         +tmj7olKTBXzD16fz2YZtDFUw03IN+ogJ4+7HPBBKse56ZPYi+ki2FszQ8ix94lYRl17
         ornfKekHOLvsSgWOtlxX12wtAzr5LKaexLvW738yrfJw48ib44Y+yY8HSDsYxmiGP7rO
         BOJCT1ASWWbNLrUtMUrB5cuRXHW1WLTa0a7l24N/fZoEcbezWd4nWNUuYDD+hD5EaMpm
         d2XDQ3jywvyU7yZM/wuAfOsdmuuPalY21TvZy08lm4Q4b+lzBtvlqtL0vpDxVuG+ojk1
         DhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V0IX2pCrBEp8Iq29H5GKpQ2IiqQOYoapMRQn8Vadm5E=;
        b=QyM3b89U5PRNU8z5ubKM2Y5guAqCJv0vQRf7FmR1hiAAmqLQwbRCnnuVQTcDxufmTn
         FEEVXG9wg+9Wg58A0vF0HaafDNJm51rJuQpV0jDej/0fqTJJkf2kTgJfNGPUuuxIoSbi
         NEUL+Mt5NZKCHIXCoaxkpreAgjyWqle+WGfLIaHR7qhrtRjJVv3IwoH4xegGLIp+tMfP
         d6r4PYqcB+d/sHZrlvyBD/4K9GRdqfopJlnKXIp2U0Fn6/KukxqAVA+On5a2F44SvzyS
         LyrIPOAmTwpI0NKpR9Rlx5Pf91se9LC6ZIpbjkNw5kvnn3dBgRSYkeUPHmdKuOjqZEtv
         7duw==
X-Gm-Message-State: APjAAAVZcmQDV1zY5zhxSQBZtuaV7V+/jHJsR1RkShaXEReg6zozyhXr
        frHZrd3SKsxWCfxtucDkag5L8rtd2HJkuESIN/g=
X-Google-Smtp-Source: APXvYqzakkYLqtAYNybJIvdQyz9PwVNfkGZhBxC6Os2Uzuo5ODavHgL76MXCTyT1wuZ4Ul9R0eeydU8AIRgskIxYNIU=
X-Received: by 2002:aca:5588:: with SMTP id j130mr3275711oib.122.1580401244234;
 Thu, 30 Jan 2020 08:20:44 -0800 (PST)
MIME-Version: 1.0
References: <pull.700.git.git.1580335424.gitgitgadget@gmail.com>
 <3b2ec5eaf65c9fe44c4337a4cc2fc3dae6203d54.1580335424.git.gitgitgadget@gmail.com>
 <8d9a6047-26be-ff78-cf1a-9f2b35f927e0@gmail.com> <CABPp-BFbXJRW38CeGy78b22MfZ8cNizexCM-+n-ODqy+fOo2uw@mail.gmail.com>
 <1bc41d94-5d4d-4157-fc00-08b97fb20738@gmail.com> <d67eb395-3b6d-9558-0288-cd3878290c9e@gmail.com>
In-Reply-To: <d67eb395-3b6d-9558-0288-cd3878290c9e@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 Jan 2020 08:20:33 -0800
Message-ID: <CABPp-BGe7ae+pf+HUdLE-xDoXEPDJ=5vWH4cnU9N6pZM2o1Q-g@mail.gmail.com>
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

On Thu, Jan 30, 2020 at 8:10 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 1/30/2020 11:00 AM, Derrick Stolee wrote:
> >
> > Let me send a v2 of this patch now that you've pointed out my error. It
> > is worth making this method clearer before you expand substantially on
> > this final case.
>
> Here we are:
>
> -->8--
>
> From 3fb4fdda25affe9fe6b3e91050e8ad105bcb6fe0 Mon Sep 17 00:00:00 2001
> From: Derrick Stolee <dstolee@microsoft.com>
> Date: Thu, 30 Jan 2020 15:28:39 +0000
> Subject: [PATCH v2] dir: refactor treat_directory to clarify control flow
>
> The logic in treat_directory() is handled by a multi-case
> switch statement, but this switch is very asymmetrical, as
> the first two cases are simple but the third is more
> complicated than the rest of the method. In fact, the third
> case includes a "break" statement that leads to the block
> of code outside the switch statement. That is the only way
> to reach that block, as the switch handles all possible
> values from directory_exists_in_index();
>
> Extract the switch statement into a series of "if" statements.
> This simplifies the trivial cases, while clarifying how to
> reach the "show_other_directories" case. This is particularly
> important as the "show_other_directories" case will expand
> in a later change.
>
> Helped-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  dir.c | 33 +++++++++++++++------------------
>  1 file changed, 15 insertions(+), 18 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index b460211e61..0989558ae6 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1660,29 +1660,26 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>         const struct pathspec *pathspec)
>  {
>         int nested_repo = 0;
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

I think right here we should add:

        if (status != index_nonexistent):
                BUG("Unhandled value for directory_exists_in_index:
%d\n", status);

for future-proofing, since both you and I had to look up what
possibilities existed as a return status from
directory_exists_in_index(), and I'd rather a large warning was thrown
if someone ever adds a fourth option to that function rather than
assume treat_directory() is fine and only needs to special case two
choices.

Or we could add an assert or a code comment, just so long as we
document to future readers that the remainder of the code is assuming
status==index_nonexistent.

> -       case index_nonexistent:
> -               if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
> -                   !(dir->flags & DIR_NO_GITLINKS)) {
> -                       struct strbuf sb = STRBUF_INIT;
> -                       strbuf_addstr(&sb, dirname);
> -                       nested_repo = is_nonbare_repository_dir(&sb);
> -                       strbuf_release(&sb);
> -               }
> -               if (nested_repo)
> -                       return ((dir->flags & DIR_SKIP_NESTED_GIT) ? path_none :
> -                               (exclude ? path_excluded : path_untracked));
> +       if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
> +               !(dir->flags & DIR_NO_GITLINKS)) {
> +               struct strbuf sb = STRBUF_INIT;
> +               strbuf_addstr(&sb, dirname);
> +               nested_repo = is_nonbare_repository_dir(&sb);
> +               strbuf_release(&sb);
> +       }
> +       if (nested_repo)
> +               return ((dir->flags & DIR_SKIP_NESTED_GIT) ? path_none :
> +                       (exclude ? path_excluded : path_untracked));
>
> -               if (dir->flags & DIR_SHOW_OTHER_DIRECTORIES)
> -                       break;
> +       if (!(dir->flags & DIR_SHOW_OTHER_DIRECTORIES)) {
>                 if (exclude &&
>                         (dir->flags & DIR_SHOW_IGNORED_TOO) &&
>                         (dir->flags & DIR_SHOW_IGNORED_TOO_MODE_MATCHING)) {
> --
> 2.25.0.vfs.1.1

Otherwise, I'm quite happy with these changes.
