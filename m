Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA0BC4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 19:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJLTsE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 15:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiJLTsC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 15:48:02 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2B380EBA
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 12:48:01 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id q3-20020a17090a304300b0020aede449d6so1577714pjl.4
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 12:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pWz4WHkSJgpIKEviNSdfGiVmNr2U7f67irTYAbEqk1U=;
        b=KJKMxbYzYYTWurXyn7RE0Vtp+WGmyKP4mQhRE0oCxq2Mzzzx//n34AvtqV5sdPbTXy
         HNVa56AUXJgWqpyw84rvvCCAYFe3BiJ6WCkjY8PB3ifTyBenxFohNXwayIqhWzHBTI1p
         mis5FxBrX8lSIA6pY/uGBYJq74ge7enx2WSnbMFJlRJlCutU1GYhKtteBs/zPO2W5ICL
         y5Qh+CZhMjfFf+x7wWxFqKUUUyY6FjtgPElfp8BFgxaNWvtKH82kRehZXsdxsw+5Olap
         uC7vdHExlvwTR9Vtt6h55tuautszTUXWx14wAaS4C3E69i2QYVUV0Y8E+dCQV4YoFEVt
         hmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWz4WHkSJgpIKEviNSdfGiVmNr2U7f67irTYAbEqk1U=;
        b=sN05pFkQID8tVXFAu5f46ZwKfa0YTvHHlRkVN/fd0GQCSBE9LfnY9eLs/dsfmDWnVR
         Gj7mtFrLMI3txY09kwRZ0Zg+2lmQc93hE3j/S6dfUlJSQM3dSJXXKGGgVxxGpXDut0vo
         GSuGNcbgBR2I6BJkMG7/FDV7DR1n4iy58GbO/hhESu+gb8oOCsJUbzflANlOZyuzcBry
         FEcDH9cs4Rl1xIleL0PZufShBrp/L5wdG4T5MiS8tkJFEsVyAwWkyHsf9PRmLsVySmuX
         1ZDE69J3C1+ur0JZVTadOsZiKcLo2/QG/rN582QP0Li+CSvNF30xIYDHzyhnjeSMymuO
         hsAQ==
X-Gm-Message-State: ACrzQf3TTIYM5utCu38IAyPiIFX7fq7bEDMsaq/qB/lIXevbT5Zhgc3/
        XtTrwdgBFx6VGEX680DYaSUzq1QmMyQkWQ==
X-Google-Smtp-Source: AMsMyM6YM8itiBbHxc+q6t8pLL91iTBsRVlcg6wwjZkLs4APEgV1CJr1RlT9BKHvQaALpzuXl0ss48VoHt7Wew==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:4a09:b0:20d:5b67:1496 with SMTP
 id kk9-20020a17090b4a0900b0020d5b671496mr6832016pjb.67.1665604081329; Wed, 12
 Oct 2022 12:48:01 -0700 (PDT)
Date:   Wed, 12 Oct 2022 12:47:52 -0700
In-Reply-To: <pull.1360.git.git.1665603814.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1360.git.git.1665603814.gitgitgadget@gmail.com>
Message-ID: <kl6l7d142593.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 0/2] [2.38 regression] config: respect includes in
 protected config
From:   Glen Choo <chooglen@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cc-ing folks again. Looks like I made a mistake initially, sorry for the
noise.

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Here's a fix for the regression reported in [1]. I'm quite confident that
> the test suite is extensive enough to catch any unintended behavioral
> changes, but I'd appreciate a second opinion.
>
> Cc: Derrick Stolee derrickstolee@github.com, Taylor Blau me@ttaylorr.com,
> Johannes Schindelin Johannes.Schindelin@gmx.de, Junio C Hamano
> gitster@pobox.com
>
> [1]
> https://lore.kernel.org/git/CAPWNY8W_Tr-WoD-GXBddD5Y8w5Y4w+gDNYQdOAJ1uBwVHuRrsQ@mail.gmail.com
>
> Glen Choo (2):
>   t0033, t0035: test for included config
>   config: respect includes in protected config
>
>  config.c                        | 30 ++++++++----------------------
>  t/t0033-safe-directory.sh       |  9 +++++++++
>  t/t0035-safe-bare-repository.sh |  9 +++++++++
>  3 files changed, 26 insertions(+), 22 deletions(-)
>
>
> base-commit: 3dcec76d9df911ed8321007b1d197c1a206dc164
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1360%2Fchooglen%2Fprotected-config%2Frespect-includes-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1360/chooglen/protected-config/respect-includes-v1
> Pull-Request: https://github.com/git/git/pull/1360
> -- 
> gitgitgadget
