Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FE4C4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 14:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0525322251
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 14:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyRSJOPB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408288AbgJTOn0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 10:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730975AbgJTOnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 10:43:25 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF56DC061755
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 07:43:25 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id e20so1895083otj.11
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 07:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QLSh9Pmgn08HbvIGDpfCUA4HuC/4NzRVxKgH94RxWYs=;
        b=lyRSJOPB4LCcAp3snlLMVNsaY5rJbvz1jgRM4+0GK+kIYOzgzAvxqe/qqGyQdGI5jT
         xqUAG2+xTostb8Moju0UJUIWvJd1LKx/R6AVQTYdrmqahRZSSCbgOeXwW0j/zJj6yZ0N
         fngfsX4J3ipWKr7oU+dLqM+dZcXp9du96cbGpxMlI/5ThzS0Mukse5F+jZgC8KGot5vk
         hLw3ryvkMTqIOn3xQHMbXXyWpOK0lb+c2gDCv1Dj5ZxubkEn0ua1fQJVNLBK3cztmjkR
         L0QCYP0Z1OT8/INKNMBgsCu63rDozbytvaVwsZbaZ0f5LFN/AKj301ZSzjoM4bosg9fa
         GPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QLSh9Pmgn08HbvIGDpfCUA4HuC/4NzRVxKgH94RxWYs=;
        b=p7o/Gz0bnvb/UKHamlF01RzZiLXmwiXbN3P3AxQNJzHnCQtGZpgRG6bqezVsqrfzbB
         VeuTYyuImzqlnEgh8uJ/dLvrbV3Rss24HeOw8CDH1DKEheSBw3aawTSOHAS+rWkigqiE
         fTvX7PWyH7WV8JEcCuty+SHARaUch6Qx/3A8O8pHqKXvV4hFzbinH8ITuaLlgXTzOoqv
         Mi1tYZ7lfNDnuRwwNmJf3bQ4GZgJNd8K1E9Ucgv1OE1lojZTehzLp7SZw5viVskrklab
         0ZuVRp2YNDOJNyebEfr8uDi/vlit0QGi55eRmoET1dgHXOR40mGtZhqMz3bP7YR+yPQh
         0V6w==
X-Gm-Message-State: AOAM530ReldkjL294Dbw9PkU1PUl6zTrYZ17XYWleqCbikRJxwAUOVXj
        smsE/X+GJ933/+ktM45vgRbtWLblJ0oN6+i8Saw=
X-Google-Smtp-Source: ABdhPJzmfqsSq3h5DJvMcyprJC+4DWL7rt2+aiVVNxskmgVYa1+w6ZiVl4lMHAfLMAB5yxRGw8gjs2yA3jAErHDObkA=
X-Received: by 2002:a05:6830:2389:: with SMTP id l9mr2050100ots.316.1603205004947;
 Tue, 20 Oct 2020 07:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <20201020083343.24945-1-chriscool@tuxfamily.org>
In-Reply-To: <20201020083343.24945-1-chriscool@tuxfamily.org>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 20 Oct 2020 07:43:13 -0700
Message-ID: <CABPp-BEVH0gRPbm+_qrnHYCD6AMpcUOjDjM+HvwesV60s_Nc0w@mail.gmail.com>
Subject: Re: [PATCH] filter-branch doc: fix filter-repo typo
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 20, 2020 at 1:33 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> The name of the tool is 'git-filter-repo' not
> 'git-repo-filter'.

Thanks for catching the mistake.

Reviewed-by: Elijah Newren <newren@gmail.com>

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/git-filter-branch.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
> index 40ba4aa3e6..62e482a95e 100644
> --- a/Documentation/git-filter-branch.txt
> +++ b/Documentation/git-filter-branch.txt
> @@ -532,7 +532,7 @@ The https://github.com/newren/git-filter-repo/[git filter-repo] tool is
>  an alternative to git-filter-branch which does not suffer from these
>  performance problems or the safety problems (mentioned below). For those
>  with existing tooling which relies upon git-filter-branch, 'git
> -repo-filter' also provides
> +filter-repo' also provides
>  https://github.com/newren/git-filter-repo/blob/master/contrib/filter-repo-demos/filter-lamely[filter-lamely],
>  a drop-in git-filter-branch replacement (with a few caveats).  While
>  filter-lamely suffers from all the same safety issues as
> --
> 2.29.0.rc1
>
