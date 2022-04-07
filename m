Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B55C433EF
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 13:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343775AbiDGNio (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 09:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343735AbiDGNiY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 09:38:24 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3B613F63
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 06:35:59 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id u14so5681459pjj.0
        for <git@vger.kernel.org>; Thu, 07 Apr 2022 06:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E/f9OY2Y2I06/MzPKBxtnD0jPfMScdR2kgEMfOolCr0=;
        b=TmPdlSw1TWM36M83ZwJbFSEofR6YhnuC8XznqGCf3QYb2VBYG/AJLv5ze3Wn+mAo51
         JESiX5VrAI+hQEexiv2DGxUkyJSnJkj89Awhtx+bfMKQVkkknCGq4AOAKxKqt1h8JCg4
         iUsqLkpapyHAsBgqiDInzqI/tIs4u5xhHK0cNe+zqJXKHte5xrdX33BCglY8OxXmBlCp
         mdbFBmPCPdjj8cn3OtNZS4n9c6WOsr8zQqD1GshMwxkRS1EbxL6WKCfs4jAEeU4NcQRI
         V+pzdDbMDfIYBrKNakU+RwV+Ltk+5HftDHQbNV57GbMgX45wqGfvF0I7b7qvCdW4Avef
         C0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E/f9OY2Y2I06/MzPKBxtnD0jPfMScdR2kgEMfOolCr0=;
        b=34vb5toP/vhFcQ4iO31GRYNK2LcbbGYg3TvOUB7JrMnDYLBNlbMPEy3Cl7GVqjEjIc
         9rkPo96dFLnKwKBFK3GPdjr3+khNI/UPqJqAmtWppFoPHbu67Mgwraia4xjJGITG+ayT
         NTmyMOFTc4jISbACrn/EnKWRxhBnPk/Ka+uXd8YMWu8o7OrTTbCqga53yEhs/ME5pHdA
         q46NxTvdKrmVIHgO/oJ8nBFNYLDaS/qafB1XeqalBhTYgn40MBL3Oi+rwNIwmJyoMAQR
         snCqO4eqWGEzCT/UyoIBoJVtE1IqJ8Qfyl7DeT6ihK55AtcsHh2lSJ+IEizSPmpWuujF
         jHAA==
X-Gm-Message-State: AOAM531ZaPI7k80vOQNRtANI1S9xVDi+ViaseOiFjFs+400jWFbhig/o
        zCXoE4mu7S3qfFg5BvZBIE2wKscRYTY19ST6YPI=
X-Google-Smtp-Source: ABdhPJz4wSHhRdQvmEwjIsg94ZB4jwQzdaoGBUxUeaEjQoE6pnSGG5wRfKNxwCn2RkQVRsMiiWXiLBJXwV9nf6umsg8=
X-Received: by 2002:a17:90b:4a92:b0:1c7:5aa4:2a74 with SMTP id
 lp18-20020a17090b4a9200b001c75aa42a74mr15940003pjb.239.1649338559230; Thu, 07
 Apr 2022 06:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com> <243e7b0c372c15cc907c838ee74794433aa79858.1645441854.git.gitgitgadget@gmail.com>
In-Reply-To: <243e7b0c372c15cc907c838ee74794433aa79858.1645441854.git.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 7 Apr 2022 15:35:47 +0200
Message-ID: <CAP8UFD25KjNYuMoVb72N2kGmo3yJ0qGgfJn78axc562Z+YhAGQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] rebase --apply: remove duplicated code
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 22, 2022 at 6:34 AM Phillip Wood via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> When we are reattaching HEAD after a fast-forward we can use
> move_to_original_branch() rather than open coding a copy of that
> code.

Nit: maybe "rebase --apply: reuse move_to_original_branch()" would be
a better subject for this patch, as it's more specific.

> The old code appears to handle the case where the rebase is
> started from a detached HEAD but in fact in that case there is nothing
> to do as we have already updated HEAD.
>
> Note that the removal of "strbuf_release(&msg)" is safe as there is an
> identical call just above this hunk.

It looks like the removed call is using strbuf_reset(), not strbuf_release().

Actually a call to strbuf_release(&msg) is also removed inside the `if
(oideq(&merge_base, &options.orig_head)) { ... }` clause, but it
doesn't look like you are talking about this one.

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/rebase.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index e942c300f8c..4832f16e675 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1782,19 +1782,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>          * If the onto is a proper descendant of the tip of the branch, then
>          * we just fast-forwarded.
>          */
> -       strbuf_reset(&msg);

Yeah, it looks like `msg` isn't used in the function anymore so this
call can be removed.

>         if (oideq(&merge_base, &options.orig_head)) {
>                 printf(_("Fast-forwarded %s to %s.\n"),
>                         branch_name, options.onto_name);
> -               strbuf_addf(&msg, "rebase finished: %s onto %s",
> -                       options.head_name ? options.head_name : "detached HEAD",
> -                       oid_to_hex(&options.onto->object.oid));
> -               memset(&ropts, 0, sizeof(ropts));
> -               ropts.branch = options.head_name;
> -               ropts.flags = RESET_HEAD_REFS_ONLY;
> -               ropts.head_msg = msg.buf;
> -               reset_head(the_repository, &ropts);
> -               strbuf_release(&msg);
> +               move_to_original_branch(&options);
>                 ret = finish_rebase(&options);
>                 goto cleanup;
>         }

Nice cleanup!
