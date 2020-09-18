Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC716C43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 16:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BFEB21534
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 16:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgIRQ5j (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 12:57:39 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34823 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgIRQ5j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 12:57:39 -0400
Received: by mail-ed1-f67.google.com with SMTP id i1so6807363edv.2
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 09:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3yWzgXk6xGlVtvMMYsrwhAHd5nm8kQwzv0C5OTdN3FE=;
        b=M0t6m4cG+bcTTBWfO+AinZlF6hNFj4xtFuGwvksGKBnDbAPC5UVkgAKuzQfN/yeQG3
         /YxXTh6eaQkTWtzvuAsGL+klHTQUi95keku4NHFer0FjhJNODEozwewjUL2zYiubHVcH
         MwEjBk7tWrACDJsGxILccm/IYOePG86baYWbc+0dLmbQphj1plMALkfM1bkzTOp9mi3Y
         57rklD3u3JS3agpnjMeCP5QMZ/Ck53XXY+ZMvDnzSIrRotGFQazF0qTnPIfMLFpCsMRv
         1pKGrDrWuRlOUisdGrMhiJp6X7+aH2T1DzyyeIWjtKfJmPeZVtp8oOFTB1RwZBIY+ru1
         TRNA==
X-Gm-Message-State: AOAM532HQsRKxlcTetRKtTtFbjsHhjRTXKryRXU2JmAA50c4KX/aQmRz
        kB8chiDFm4lM/ctBWXfvEJTzU5ThNOu4XZF/dNajAajO
X-Google-Smtp-Source: ABdhPJwwQWL5v/CGFGhaVMMG7L/1GhewEwhgP8ARrwrNoVIaQy/AX2WNefIMCGz1/YxIhuANPkshbREEcdyS+fBCNcA=
X-Received: by 2002:aa7:ca4f:: with SMTP id j15mr36006537edt.233.1600448257737;
 Fri, 18 Sep 2020 09:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600427894.git.liu.denton@gmail.com> <ed1ade73281bb78ab3a1d4fd1291a951ca52f0b4.1600427894.git.liu.denton@gmail.com>
In-Reply-To: <ed1ade73281bb78ab3a1d4fd1291a951ca52f0b4.1600427894.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 18 Sep 2020 12:57:26 -0400
Message-ID: <CAPig+cSCqU2SDVNZB8_eTiV6j3La=ik-JeWp4dSma77mcv1Ccg@mail.gmail.com>
Subject: Re: [PATCH 1/4] hooks--pre-push.sample: prefer $() for command substitution
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 18, 2020 at 7:19 AM Denton Liu <liu.denton@gmail.com> wrote:
> The preferred form for a command substitution is $() over ``. Use this
> form for the command substitution in the sample hook.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/templates/hooks--pre-push.sample b/templates/hooks--pre-push.sample
> @@ -41,7 +41,7 @@ do
> -               commit=`git rev-list -n 1 --grep '^WIP' "$range"`
> +               commit="$(git rev-list -n 1 --grep '^WIP' "$range")"

The double quotes around $(...) are unnecessary and just add noise.

>                 if [ -n "$commit" ]

If you're looking for style fixes, then this would be another
candidate (using 'test' instead of '[').
