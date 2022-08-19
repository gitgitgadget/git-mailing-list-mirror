Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F06C28D13
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 23:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243404AbiHSXFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 19:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243403AbiHSXFT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 19:05:19 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DE5B6D5C
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 16:05:18 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id w28so4409122qtc.7
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 16:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=eX9+lBKRyRBR4S6pOo1JsvdZFTETnmDgXpLIMJ9TF/E=;
        b=GMwOTqAn3Y7k2Klo3TmaE8LYRYyUX/60pslP4rJov479ZPMWHxqRnzZghsxvxB8WN8
         wGeDd9udzsgUGEk4LfHca20bUSUnN26GL8Cn5CC6PqxVxGp3uCDiL4qmiONiIJsSMFau
         uok684lnZHIcKz0h1qBkzJPWBiwcIOXa8g+QYNrt7+aWF4T8Ti5JtQVBEigSVyBFeTWN
         TN1QuVKUnZEq0wAnPQWwdyyzITDjMzrIJE9YzL7kX20SAg8hN2F+6DEp9/HmPBopLKma
         BpurBSFQD48w9oxAMi9qi2WhFyXhk2y4yIEcEhnOuIssBqicg1kKpASxRjb7JoGlXSh8
         wIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=eX9+lBKRyRBR4S6pOo1JsvdZFTETnmDgXpLIMJ9TF/E=;
        b=R55sBIPNSHMxB83fvKqwc1El8N47YS7ruFXVEIIur67bxe8gpeMlnl60YNZ/BcW/aC
         q8bx3Rt5Ohi9gh79ImEDjyQIf5lkPScgWPMwSIgZCRyvh+OyUcaL/wWaWlO0fEEIkQyF
         MGVETksffyMfuFctkCDJfTGiXp2gypur0f/mmFlODDeyK+09za7MvEOLahE3QZRC3MV4
         naOnZBM2pVTZK6v4PpE+I39xwTSCMnVbGeNwWEgzEDPCAbzq/S1atuot14cjOyQrbLDo
         kQqg7fkgFzZXA4QCf/x5zx3uPD8iJxf2SULmfyHsB0FZHHF3KPb17qRf7h6N+VjrKTa3
         fvMQ==
X-Gm-Message-State: ACgBeo3UjrduQcr3k0K5pJAD3z9yPQIoruE7w739rkGz5WjGs7d9Mox1
        FjvN+ZDx9hLextf9AFO/mmt2tz4H1Pn3o4GkDt00NelD
X-Google-Smtp-Source: AA6agR68+hSMkMQhYTmDD44MgVayhovT/4tnQlXfeZbwnsBacuDSN3ak39MQ0QHEjzusBitlJrCm46WRND8v9drEKvc=
X-Received: by 2002:ac8:5d88:0:b0:344:8185:d28a with SMTP id
 d8-20020ac85d88000000b003448185d28amr8191260qtx.259.1660950317085; Fri, 19
 Aug 2022 16:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <Yv9Oay+tNqhLDqVl@coredump.intra.peff.net> <Yv9O2RK7ahmw5ge7@coredump.intra.peff.net>
In-Reply-To: <Yv9O2RK7ahmw5ge7@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 19 Aug 2022 16:05:06 -0700
Message-ID: <CABPp-BHvscxV+vVL-Tew2H4h8V_3bZpD0Qz9uEMwrV=X3zrYSg@mail.gmail.com>
Subject: Re: [PATCH 2/6] log-tree: drop unused commit param in remerge_diff()
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2022 at 1:50 AM Jeff King <peff@peff.net> wrote:
>
> This function has never used its "commit" parameter since it was added
> in db757e8b8d (show, log: provide a --remerge-diff capability,
> 2022-02-02).
>
> This makes sense; we already have separate parameters for the parents
> (which lets us redo the merge) and the oid of the result tree (which we
> can then diff against the remerge result).
>
> Let's drop the unused parameter in the name of clarity.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  log-tree.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/log-tree.c b/log-tree.c
> index d0ac0a6327..82d9b5f650 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -956,8 +956,7 @@ static void cleanup_additional_headers(struct diff_options *o)
>
>  static int do_remerge_diff(struct rev_info *opt,
>                            struct commit_list *parents,
> -                          struct object_id *oid,
> -                          struct commit *commit)
> +                          struct object_id *oid)
>  {
>         struct merge_options o;
>         struct commit_list *bases;
> @@ -1052,7 +1051,7 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
>                                         "for octopus merges.\n");
>                                 return 1;
>                         }
> -                       return do_remerge_diff(opt, parents, oid, commit);
> +                       return do_remerge_diff(opt, parents, oid);
>                 }
>                 if (opt->combine_merges)
>                         return do_diff_combined(opt, commit);
> --
> 2.37.2.928.g0821088f4a

Yeah, looks like I could have just used commit instead of parents and
oid, but since the calling code had those handy, I added them directly
and forgot to remove commit.

Patch looks good.
