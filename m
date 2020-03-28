Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903E7C43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 21:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B33120716
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 21:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uF+uR+Qf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgC1VDs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 17:03:48 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44873 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgC1VDs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 17:03:48 -0400
Received: by mail-oi1-f193.google.com with SMTP id v134so12170756oie.11
        for <git@vger.kernel.org>; Sat, 28 Mar 2020 14:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=re/yfyIET6rAjqDB9XMCUO08W3EO7huInvEgwUgAddo=;
        b=uF+uR+QfAuFIvK8Uk5VZA51KZJ9dlEgVTOt+J9/J45Yk/+KqLAl+2s/ZoPidLPfLK3
         sy2vfg8rqU5iISnooP48x1dWI4pWBy+o03bmdZqQU8wZLfmTS48seOSzPeBWB3amQQJ7
         fZz/eMUVjg+FwuD4NncQUKsGyfPCF5UOsZ9gw4qXczobriA2oVV4dF8DLOEWQB2kG7xM
         36IFiduKhdSNhU4XPh4/2k4UuxpcmMdbP55YQQ31EFVXYkG4eGvnu22ZCeHx5L+Cr9Ny
         i5JpwXzSWAsFqKkAjCy1CZHQni2VQQpNTaOEEg2afJSOYUYydfn78AHDyppZX6qpfSdo
         O/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=re/yfyIET6rAjqDB9XMCUO08W3EO7huInvEgwUgAddo=;
        b=Tf2/gbw0e70wFb93nxrKouN8vRtiggJN7D/QFp3vifSufgnn6DSiqWk1LDtl3fqrE8
         7r7wOVGTGZszn7oP47EMeNL+ImwnpmVUsjAWo+LHRM/DVhThqYIWADIHMvkAsHEoKuSC
         mKGAVykf1AEu0xDvsY9X7DDkzyr4aondfZOeylWNtCF3UfUau/8+AY2Aox0eXLvHSTZd
         ZfxCio/XJjShk+N+B3GAZzOrLvGJ/DUGLHDh9AfOP+5IJiMa16MYur+Fe72lczbDgb+O
         9fDjLmMUwPMyURT6GUoUtgr8GcbHqm7KYCclXytJcPZ+pGQWp7RqnttrWemPhlz9rvUx
         y9dg==
X-Gm-Message-State: ANhLgQ1Rpgfwwwa0ET3im/SYaJqFe7zEiE+6KRaRejpHNvItCCNeo1Af
        EdohMLzXOLe8aIyX3pX8lvJlfuNRZZ/vlNQKRX0=
X-Google-Smtp-Source: ADFU+vtFuN0zPrZWkIatlm+7hCOLuA4uRy1SfOXf1z+woxaXKJ5VlgRkL1gG74hP/bAOeJ+IymReb3bl7KcVXi725Q0=
X-Received: by 2002:aca:dc45:: with SMTP id t66mr3390394oig.39.1585429427254;
 Sat, 28 Mar 2020 14:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <pull.740.git.git.1585422720838.gitgitgadget@gmail.com>
In-Reply-To: <pull.740.git.git.1585422720838.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 28 Mar 2020 14:03:36 -0700
Message-ID: <CABPp-BE=5U6J12Wq0+JXRRWP3FX5g51jCCr+K19xnB0=tDVw-A@mail.gmail.com>
Subject: Re: [PATCH] git-rebase.txt: fix typo
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 28, 2020 at 12:44 PM Philippe Blain via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>     git-rebase.txt: fix typo
>
>     CC: Junio C Hamano gitster@pobox.com [gitster@pobox.com], Elijah Newren
>     newren@gmail.com [newren@gmail.com]
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-740%2Fphil-blain%2Fdoc-rebase-typo-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-740/phil-blain/doc-rebase-typo-v1
> Pull-Request: https://github.com/git/git/pull/740
>
>  Documentation/git-rebase.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index f7a6033607f..46ddf172d9c 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -605,7 +605,7 @@ BEHAVIORAL DIFFERENCES
>  -----------------------
>
>  git rebase has two primary backends: apply and merge.  (The apply
> -backend used to known as the 'am' backend, but the name led to
> +backend used to be known as the 'am' backend, but the name led to
>  confusion as it looks like a verb instead of a noun.  Also, the merge
>  backend used to be known as the interactive backend, but it is now
>  used for non-interactive cases as well.  Both were renamed based on
>
> base-commit: 3bab5d56259722843359702bc27111475437ad2a

Thanks for catching my missing 'be'.
