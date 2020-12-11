Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D038AC433FE
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 00:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A9AC23CD0
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 00:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394555AbgLKAZ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 19:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394556AbgLKAZC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 19:25:02 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B24BC0613CF
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 16:24:22 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id t4so7275743wrr.12
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 16:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lqdrDpArYZsejqzME/nN5UGoqlspTqWkw4bsQl8ysLw=;
        b=YFwTXIfTsSeUJxo/UrJWRGNQL1AXR9XAXkxMsg0CYF9+1oAW/TwlArNHQrwAg4UliN
         R1w9UXacsaYuK5v6HEM169klT+/i0E3IRq79MIcYo87IQxRHp5cJ5skTStUMxU2duHle
         Q21VzwJQNILrgZPGQeBXuitL3W4wpom32UUcE68mU/qtp74Uu7gEqHnY1mRzqp7N7udm
         mNU4bOPfgUyymg9cmiBM3zRHqUl3/FpnA14rBKeIz0GaqM2qUC7rJLwSpgFl0lSi9nFr
         YLJjN4HRsbocKE9ooL9J7bMBKBYSr2/WPBDatQ9cNQdzTm6Wc9Z3BSqUxyW0DcglO5+o
         XuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lqdrDpArYZsejqzME/nN5UGoqlspTqWkw4bsQl8ysLw=;
        b=CbRD03BEaIZ4VepRSnOa5oLwrYTbWiGQ8nx3V7kzW4O/LjqaA+gK8CPj93MTCJTw3x
         4AVk8XgOZ5sAjCxsvt0+lzSdaWKtSMYrveJTvfULejM5SQgDpjndlIDMB9lq10Emb2Sa
         k3EabxT4Uw9ByA53obipmftgSfH/+W1Af6z+cylVqiP8Pg6Rp435jWpXk0dvuUjjmRiq
         Dt0pHhN8BO1H7mpgmui/lBFS6fLCUzIZZ4B0p211MtOlz8S5oVIHm7CwejOClh2JZnva
         TwoU4I+13SNmMD1XrRyCRs36oQGmB2DJGrhpPMo+Q6EChH+8cJmqhP/HI6f58vX69BA6
         5RFg==
X-Gm-Message-State: AOAM532tPr5sG67Z0G3BbqkaXd/BF8CKT+s9/aqsBQJqSV5Fz+JH2+GY
        ZwlS4uHG1LNffTMdz4lrGIvVwIn1uUjRTkAHRQc=
X-Google-Smtp-Source: ABdhPJwKS4+MNySyMaMQUm+etyTcoVkjOO48IF/UTIb5oM2ifcFFuXc+mtr93B9Q6P60QBK0z8aLc9b06BKn+MfRLNg=
X-Received: by 2002:a5d:68c9:: with SMTP id p9mr10907947wrw.139.1607646260938;
 Thu, 10 Dec 2020 16:24:20 -0800 (PST)
MIME-Version: 1.0
References: <pull.921.v3.git.git.1606230450.gitgitgadget@gmail.com>
 <pull.921.v4.git.git.1607637517.gitgitgadget@gmail.com> <483e490349165223a80a0bdf7716c5189560c977.1607637517.git.gitgitgadget@gmail.com>
In-Reply-To: <483e490349165223a80a0bdf7716c5189560c977.1607637517.git.gitgitgadget@gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 10 Dec 2020 18:24:09 -0600
Message-ID: <CAMP44s3mtCd9RnZdW7-HLcKVG13UW8u_1VNC0_7jByQRv61+vw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] init: document `init.defaultBranch` better
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 10, 2020 at 3:58 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Our documentation does not mention any future plan to change 'master' to
> other value. It is a good idea to document this, though.
>
> Initial-patch-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Documentation/git-init.txt | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
> index 59ecda6c17d..2b399cb73d7 100644
> --- a/Documentation/git-init.txt
> +++ b/Documentation/git-init.txt
> @@ -20,8 +20,9 @@ DESCRIPTION
>
>  This command creates an empty Git repository - basically a `.git`
>  directory with subdirectories for `objects`, `refs/heads`,
> -`refs/tags`, and template files.  An initial `HEAD` file that
> -references the HEAD of the master branch is also created.

The current sentence: "An initial `HEAD` file that references the HEAD
of the master branch is also created." is still true. There's no need
to change that (yet).

> +`refs/tags`, and template files.  An initial branch without any
> +commits will be created (see the `--initial-branch` option below
> +for its name).

Perhaps: (see the `--initial-branch` option below to choose another name).

>  If the `$GIT_DIR` environment variable is set then it specifies a path
>  to use instead of `./.git` for the base of the repository.
> @@ -73,8 +74,10 @@ If this is reinitialization, the repository will be moved to the specified path.
>  -b <branch-name>::
>  --initial-branch=<branch-name>::
>
> -Use the specified name for the initial branch in the newly created repository.
> -If not specified, fall back to the default name: `master`.
> +Use the specified name for the initial branch in the newly created

Again; the default name has not changed.

> +repository.  If not specified, fall back to the default name (currently
> +`master`, but that will be changed in the future; the name can be customized
> +via the `init.defaultBranch` configuration variable).

Wait a second. The advice warning said "this is subject to change",
and the documentation says "that will be changed in the future". Which
is it?

"I might give you a fine", and "I will give you a fine" are most
definitely not the same thing.

Either say "this is subject to change" in both the documentation and
the warning. Or say "that will be changed in the future".

Don't say one thing in one and another thing in the other.

Cheers.

-- 
Felipe Contreras
