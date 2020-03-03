Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D35C3F2CD
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 07:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DAEC21739
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 07:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian-com.20150623.gappssmtp.com header.i=@atlassian-com.20150623.gappssmtp.com header.b="tHfj+9PT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbgCCHcO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 02:32:14 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:43501 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgCCHcO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 02:32:14 -0500
Received: by mail-io1-f65.google.com with SMTP id n21so2432721ioo.10
        for <git@vger.kernel.org>; Mon, 02 Mar 2020 23:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k7xRHLKgHw0F+FvUWM9H//3/PbR6Jh+J4cfClqt3vxY=;
        b=tHfj+9PT+3LviaY4fBH314fMZRslSbIcpUvMLOyOdWmQVNCNm9GoC4QXmX/PyZe3kl
         tCqx5p6ZRbtW3lc+alIuWv1HdojyrgAlvt2eJwBdeCxOO278EJ2nJ+5Fmhg0QOJz6dm0
         Nd7dAAfyapc8F0tI2w7kf2rbTcQhadZwvgEjyr8lI3AYWDo3IXTmbijnAjyLb6Y5sE0c
         lqeBpruePOfDPBXEQC9ZJj/Jo1sXuq5h0xpmKCJ/TWGRgDMU7ZxWqVL8v4JSToxua5uH
         m/eMgYXsB7R4o7GsUKeHyxZ8oNnE19v7xuL19ZKcCls1fQbFZWS+BfeEw0fYYqiAT+iI
         kCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k7xRHLKgHw0F+FvUWM9H//3/PbR6Jh+J4cfClqt3vxY=;
        b=N4vhcRWR+gqvyxiitjMCfgMtQJlHTbU6SbmdalBJ4zVUzWmcw03zH13RvEGWnUgrGj
         NYiuDaE9sF18mVlojAvZqebmC7YSFUNhOFfpoovSWVIj71Jt3FuolLDP0RqvlEUTjjub
         7LEPoEjtQJRSLh+rxdCE7YCrQaZotodKWeeXFXDVTKam+33lx57gPqTACJIoxoFZ75qO
         rDQIc8llcbmkZAQD1NybmZcFCvEb/GYRSosnYPYIUm6kg8ubBNAaYmr777Wry1C8xKZJ
         IVRuugdqURNs2Ttmpisvwk9IywRtnWsaH9SxKfiWRm5yNreI//jJl5dUezNJmxo/wyAw
         Ri5g==
X-Gm-Message-State: ANhLgQ11C5YPWYD8UcrIpvRQdslo/vfjd/pxc1ui/j9w5WH/AQgvbTaK
        ExAq2AL1B6IOFrluzEOwDkpU1ln6KNSvHvPDplVnYg==
X-Google-Smtp-Source: ADFU+vvtbNKsGZLm6mxeuh8IfS2UfRUuEXWz+Ukv6+ZQLVh1woDoPQdmd0rZSUti+TKNyy0Qq1+qCRTE8qToRWcSepo=
X-Received: by 2002:a02:7089:: with SMTP id f131mr2700461jac.99.1583220733551;
 Mon, 02 Mar 2020 23:32:13 -0800 (PST)
MIME-Version: 1.0
References: <pull.719.git.git.1583220197856.gitgitgadget@gmail.com>
In-Reply-To: <pull.719.git.git.1583220197856.gitgitgadget@gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 3 Mar 2020 00:32:02 -0700
Message-ID: <CAGyf7-Ez1Fx-VUVmDWxRxLaZcU+Tu4kZ+F2+0uNKkx2oftjEJQ@mail.gmail.com>
Subject: Re: [PATCH] doc: use 'ref' instead of 'commit' for merge-base arguments
To:     Takuya N via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Users <git@vger.kernel.org>,
        Takuya Noguchi <takninnovationresearch@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 3, 2020 at 12:23 AM Takuya N via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Takuya Noguchi <takninnovationresearch@gmail.com>
>
> The notation <commit> can be misunderstandable only for commit SHA1,
> but merge-base accepts any commit references. Like reflog, the name of
> arguments should be <ref> instead of <commit>.

To me, this change goes too far in the opposite direction: Now it
sounds like the command only accepts refs, when it actually accepts
any "commit-ish"--i.e., anything that can be coerced to a commit.
("git worktree" uses this term in its usage for "add", for example.)

At the same time, it doesn't seem like this change goes far enough.
"git merge"'s documentation, for example, is still using "<commit>".
Why is it important that "git merge-base" mention refs, but not that
"git merge" do so?

(Pardon the outburst from the peanut gallery)

>
> Signed-off-by: Takuya Noguchi <takninnovationresearch@gmail.com>
> ---
>     doc: use 'ref' instead of 'commit' for merge-base arguments
>
>     The notation <commit> can be misunderstandable only for commit SHA1, but
>     merge-base accepts any commit references. Like reflog, the name of
>     arguments should be <ref> rather than <commit>.
>
>     Signed-off-by: Takuya Noguchi takninnovationresearch@gmail.com
>     [takninnovationresearch@gmail.com]
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-719%2Ftnir%2Fmerge-base-supporting-refs-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-719/tnir/merge-base-supporting-refs-v1
> Pull-Request: https://github.com/git/git/pull/719
>
>  Documentation/git-merge-base.txt | 10 +++++-----
>  builtin/merge-base.c             | 12 ++++++------
>  2 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
> index 2d944e0851f..b87528ef269 100644
> --- a/Documentation/git-merge-base.txt
> +++ b/Documentation/git-merge-base.txt
> @@ -9,11 +9,11 @@ git-merge-base - Find as good common ancestors as possible for a merge
>  SYNOPSIS
>  --------
>  [verse]
> -'git merge-base' [-a|--all] <commit> <commit>...
> -'git merge-base' [-a|--all] --octopus <commit>...
> -'git merge-base' --is-ancestor <commit> <commit>
> -'git merge-base' --independent <commit>...
> -'git merge-base' --fork-point <ref> [<commit>]
> +'git merge-base' [-a|--all] <ref> <ref>...
> +'git merge-base' [-a|--all] --octopus <ref>...
> +'git merge-base' --is-ancestor <ref> <ref>
> +'git merge-base' --independent <ref>...
> +'git merge-base' --fork-point <ref> [<ref>]
>
>  DESCRIPTION
>  -----------
> diff --git a/builtin/merge-base.c b/builtin/merge-base.c
> index e3f8da13b69..910916ae0ec 100644
> --- a/builtin/merge-base.c
> +++ b/builtin/merge-base.c
> @@ -29,11 +29,11 @@ static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
>  }
>
>  static const char * const merge_base_usage[] = {
> -       N_("git merge-base [-a | --all] <commit> <commit>..."),
> -       N_("git merge-base [-a | --all] --octopus <commit>..."),
> -       N_("git merge-base --independent <commit>..."),
> -       N_("git merge-base --is-ancestor <commit> <commit>"),
> -       N_("git merge-base --fork-point <ref> [<commit>]"),
> +       N_("git merge-base [-a | --all] <ref> <ref>..."),
> +       N_("git merge-base [-a | --all] --octopus <ref>..."),
> +       N_("git merge-base --independent <ref>..."),
> +       N_("git merge-base --is-ancestor <ref> <ref>"),
> +       N_("git merge-base --fork-point <ref1> [<ref2>]"),
>         NULL
>  };
>
> @@ -158,7 +158,7 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
>                 OPT_CMDMODE(0, "is-ancestor", &cmdmode,
>                             N_("is the first one ancestor of the other?"), 'a'),
>                 OPT_CMDMODE(0, "fork-point", &cmdmode,
> -                           N_("find where <commit> forked from reflog of <ref>"), 'f'),
> +                           N_("find where <ref2> forked from reflog of <ref1>"), 'f'),
>                 OPT_END()
>         };
>
>
> base-commit: 2d2118b814c11f509e1aa76cb07110f7231668dc
> --
> gitgitgadget
