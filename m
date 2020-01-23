Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC45BC32771
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 02:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704682465B
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 02:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVgdHApE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgAWCgC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jan 2020 21:36:02 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:32895 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAWCgC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jan 2020 21:36:02 -0500
Received: by mail-ed1-f66.google.com with SMTP id r21so1815686edq.0
        for <git@vger.kernel.org>; Wed, 22 Jan 2020 18:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=emBENXZ6/S43mYU0kNHCmNBTAc4LqDJKriEtx4O6BSk=;
        b=nVgdHApEBodhv+sngK+rppTAZEZ0H2XWSQZl1xvON/BP2PuRPm4ZTopR1T/b4osKVh
         3hyvNoIZkjReqA1kBKhM69b7GLH570XGLQ1uUE9/Z6+i8svCuZn6C8W+3xpAPBC+iWWa
         +gj2gLc6WrCgiItaX7nQjcmCsrLpOadrGpi8JHz4VA+An1L3wEoeUnDH2pXEDCEqgJQF
         YLKISsdDuBdcbjpbPPDwNFJ5DjJK5bmYwnAh4+Zpa/6qOWFC6r7WZ3mWcYwKtHg1Fk9H
         o2t7+JUnIKGBi8CUQIH86MaxmgaSnL/FDjy6DWwcuMpCJnMxRatDhrLLp793qQqxWYtH
         GrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=emBENXZ6/S43mYU0kNHCmNBTAc4LqDJKriEtx4O6BSk=;
        b=JE55pghGl9b08Q4gMo9klK2GFO6yit9VAFz55BjXYj8PPtY4B7E/u68Ofap7Ayjgrv
         mmX2WLmx5PUeetH7bhRSwA7UD7H/16X15fVPw/sSuEMvYNLhpe0kK2EEtIIi5fdxAIB+
         QS13S4I83J8zMAy70nJD/8d6PWeLcV3jxVwWffh6f5Lnrh8nxaGMTRYrSwnwHq+EINX+
         K3u9Qu0vBYXVizwfzs5Eqnd3TazRnbs/Rjq2vfpTjEA++BdWhk+nR7Cdm/8fj0/HxZRt
         Gq4PyAgsHtZ+VWXJEtQRAwGi40zW6XFtSKM2v5ImFwvtUN73H8Sint3XFH6/KrXiic32
         FX3A==
X-Gm-Message-State: APjAAAXsnd34hVip8pxDN1H/SE9/9+8ic5FCSSdpLdb14/bFDyTYC45F
        0ZHkRkgwobsmAVX36SHQDNPfxn/Wg8d3aFRIren2Pg==
X-Google-Smtp-Source: APXvYqxoP37YLJtmi6hFObJylIRWPJsBqrUMfYzBBuiruvH1fEq4ejYvXVlh2J2Um1GkCpWQOt4FroRzZmg0WjuBknc=
X-Received: by 2002:a17:906:edc7:: with SMTP id sb7mr4871228ejb.367.1579746960195;
 Wed, 22 Jan 2020 18:36:00 -0800 (PST)
MIME-Version: 1.0
References: <pull.537.git.1579745811615.gitgitgadget@gmail.com>
In-Reply-To: <pull.537.git.1579745811615.gitgitgadget@gmail.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Thu, 23 Jan 2020 15:35:49 +1300
Message-ID: <CACg5j25uCHgaANtVyEHNqKcZoQG=NyrsgZAtdqo8oLcbZFkP4w@mail.gmail.com>
Subject: Re: [PATCH] git: update documentation for --git-dir
To:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 23, 2020 at 3:16 PM Heba Waly via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Heba Waly <heba.waly@gmail.com>
>
> git --git-dir <path> is a bit confusing and sometimes doesn't work as
> the user would expect it to.
>
> For example, if the user runs `git --git-dir=<path> status`, git
> will not be able to figure out the work tree path on its own and
> will assign the work tree to the user's current work directory.
> When this assignment is wrong, then the output will not match the
> user's expectations.
>
> This patch updates the documentation to make it clearer.
>
> Signed-off-by: Heba Waly <heba.waly@gmail.com>
> ---
>     [Outreachy] git: update documentation for --git-dir
>
>     git --git-dir is a bit confusing and sometimes doesn't work as the user
>     would expect it to.
>
>     For example, if the user runs git --git-dir=<path> status, git will not
>     be able to figure out the work tree path on its own and will assign the
>     work tree to the user's current work directory. When this assignment is
>     wrong, then the output will not match the user's expectations.
>
>     This patch updates the documentation to make it clearer.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-537%2FHebaWaly%2Fgit_dir_doc-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-537/HebaWaly/git_dir_doc-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/537
>
>  Documentation/git.txt | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index b1597ac002..3b9402c742 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -110,10 +110,15 @@ foo.bar= ...`) sets `foo.bar` to the empty string which `git config
>         Do not pipe Git output into a pager.
>
>  --git-dir=<path>::
> -       Set the path to the repository. This can also be controlled by
> -       setting the `GIT_DIR` environment variable. It can be an absolute
> -       path or relative path to current working directory.
> -
> +       Set the path to the repository (i.e. the .git folder). This can also be
> +       controlled by setting the `GIT_DIR` environment variable. It can be
> +       an absolute path or relative path to current working directory.
> +
> +       Note that --git-dir=<path> is not the same as -C=<path>.
> +       It's preferrable to set --work-tree=<path> as well when setting
> +       --git-dir to make sure Git will run your command across the correct
> +       work tree.
> +

I just noticed the whitespace on the last line, will wait for the
patch to be reviewed then include its fix.

>  --work-tree=<path>::
>         Set the path to the working tree. It can be an absolute path
>         or a path relative to the current working directory.
>
> base-commit: 232378479ee6c66206d47a9be175e3a39682aea6
> --
> gitgitgadget
