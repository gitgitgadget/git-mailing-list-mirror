Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51851C433ED
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 11:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D0566101E
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 11:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhD2LcW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 07:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhD2LcV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 07:32:21 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C18BC06138B
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 04:31:35 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id c21so1819651vso.11
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 04:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gKJa1t+Ftz5BiJ8mW/xDhYhJ7Vw/54kAblzzdsbqllk=;
        b=syXetEDxjppOL/Jt8Oo2dkV7JsqDMo6byU5N6IgTGg8OKL9HejcPkGgdPQQUyudVGW
         gZWNEaFqxwvf2G4qvdkFDC7G+wnolo32OVTplhy3ux2ecDY9Z/n2lmo0csvo2B5Q/Z8y
         YVWwiMfzdESewhwYSw86YDZ8Ui8K0Gx9rHzpPfnzwteGsYdEaMn0aUE3mcMa0DIoN49j
         s9SEwMnz7mJ02T4bsCduIezi2g+0WeHboWs3YUu7NbQ4Je+SkZR21KbgvesPBiFvbQWC
         VqMF0E82Xugw9D9N67ol6HxAOEYrUymu4PFSjQzW0ZGX6ZNXnGzJpq5FIhmJ4ZW8QG2f
         WYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gKJa1t+Ftz5BiJ8mW/xDhYhJ7Vw/54kAblzzdsbqllk=;
        b=mDiwhSDw2JM6Tb60ZdmagjeBh64W41ttOi5mcMO7DGWySyV38yzdjSuUPAC/n42WaC
         +GSqskBc0FZTmcPKacJGeGu897bWlz0lZfmh4Blp4md4ivLqUKpFFE1msR7uB9MoJeSi
         uC0/zaHF/s/qhSAiNgZ7Lp1MLINLMhF/41+3VlN0gP6fg9yLHqrWHmtlYGIqi6nFvjwv
         AO9FP1TWsTzl5lo3uw6TngFr9z42jH9E+MUacSILmKzijr8tLg9YV6UA7ubic7ahSm6V
         C/rQhRGNa4ySBj7Tw89gYPa/gGXEug8CJJ2k2wouIbF1hLc3C/lxUYT4eIZltd2dPnGd
         UcXQ==
X-Gm-Message-State: AOAM530jllG8iKI4gd1od9XESet6K9rWBNFHBP/yRRUqIt1kifgL2dbU
        3pXDMAewYUI0TLa7YY3QT741uDe98go3Mkcur3k=
X-Google-Smtp-Source: ABdhPJwpbz+Lr8QHHimZvWRzdql5HpC7LoTWyr1SMZOkPn7j5j90pzS/ekdu/Qr1YIpa1WSx7ehGZhTV7u5zSN3XGjo=
X-Received: by 2002:a67:f9da:: with SMTP id c26mr751156vsq.59.1619695894260;
 Thu, 29 Apr 2021 04:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1013.git.git.1619640416533.gitgitgadget@gmail.com>
 <xmqq5z05akyf.fsf@gitster.g> <CAJGkkrQJFaLPfCBTVn6k1v9cCwF4wEUxr+ZyzebUBQJB8qLaWg@mail.gmail.com>
 <b0befcf3-8d8a-f99f-d4f0-78b2cfe22505@diamand.org>
In-Reply-To: <b0befcf3-8d8a-f99f-d4f0-78b2cfe22505@diamand.org>
From:   Joachim Kuebart <joachim.kuebart@gmail.com>
Date:   Thu, 29 Apr 2021 13:30:57 +0200
Message-ID: <CAJGkkrS1Qg_Se=Bu5oE1K1G+NtWDTq2JErJNtvyRoQrRw74WQA@mail.gmail.com>
Subject: Re: [PATCH] git-p4: speed up search for branch parent
To:     Luke Diamand <luke@diamand.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Joachim Kuebart via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 29 Apr 2021 at 10:22, Luke Diamand <luke@diamand.org> wrote:
>
> There are existing tests for importing branches which should cover this.
> I don't know if they need to be extended or not, you might want to check.

I enhanced t9801-git-p4-branch to check for this functionality, i.e.
that the branches are branched off at the correct commits from their
parents. As far as I could see, there was no test for this before.

Thank you as well for your quick response!

Cheers,

Joachim
