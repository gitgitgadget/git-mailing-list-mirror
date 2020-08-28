Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C28C433E2
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 22:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72EAF2080C
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 22:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgH1WVG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 18:21:06 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41317 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgH1WVF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 18:21:05 -0400
Received: by mail-ed1-f68.google.com with SMTP id ay8so430009edb.8
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 15:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kATRIZqRYr7gunlUkue0LzPt1gIA8sq3aM8KeSqq8/Q=;
        b=M/BLWljxtOk9heDZPfdoyXLzlbV2fBtRLXEjz4fdfiEy5ieZJSVp7cUxxt2UqCX4AN
         k0hzWbAulyLyguuCg8V409JWx308PbeJZhNPjfbR0iUWAM2do7P9FwyKIQIpdX+tXI9m
         laEFxYDMuyFbY59NVPUFTbG+xVAxz52B/AsmaimarVh7FsAcvOoEAip3NsbsrEB+vAA9
         zQeyadCEVbRkxQMPtxpua7mnjgDhZchNd7lN0WA6N6OAzTzYDaCPg3CEexVSHlE/bBg/
         EF+iJNjZT6/zP5X/rD4VeTaZr/rMViChbhk//4wnOEsOXoKM5v6KeYRcv7GF1UcuEGmG
         /OZg==
X-Gm-Message-State: AOAM531z4ZqyW5qJGt04UO0K+zHHCvBVeuR6q7iRGSMbmfplB80lL6r1
        NY1K8Z8cdoC1q7ZB1xO5icP0B1E31cM6gvrwYcm8a1e7
X-Google-Smtp-Source: ABdhPJwnNGS4kDIt3UPTCQUqpLbsxcjpVsfFTunSFvXk6vqD6a4qUpQDi2t07cWYARrlyTxX1JNuUQc2tcrKJdAXRJ4=
X-Received: by 2002:aa7:da9a:: with SMTP id q26mr928179eds.163.1598653264221;
 Fri, 28 Aug 2020 15:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <8d4b4011-b8a2-c0e0-a3f2-28c7bbec040b@ramsayjones.plus.com>
In-Reply-To: <8d4b4011-b8a2-c0e0-a3f2-28c7bbec040b@ramsayjones.plus.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 28 Aug 2020 18:20:53 -0400
Message-ID: <CAPig+cQxjYA_LdbaGYOCACPSn=DhpFA-+5tb76BxnveT66w45A@mail.gmail.com>
Subject: Re: [PATCH] builtin/init-db.c: fix a sparse warning
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 28, 2020 at 4:47 PM Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
> If you need to re-roll your 'es/worktree-repair' branch, could you
> please squash this into the relevant patch (commit 44a466ca7f (init:
> make --separate-git-dir work from within linked worktree, 27-08-2020)).
>
> -                       git_dir = strbuf_detach(&sb, 0);
> +                       git_dir = strbuf_detach(&sb, NULL);

Thanks. I misremembered the purpose of the second argument, thinking
that it was a size hint which would be passed along to strbuf_init().
