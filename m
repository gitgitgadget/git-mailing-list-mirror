Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01D5C433E0
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 19:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C35564E11
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 19:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhA3TQI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 14:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhA3TQH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 14:16:07 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30955C061573
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 11:15:27 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id v1so12141462ott.10
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 11:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tid0vIjve6cySVa11DBwAUvtDThyEhO5uZBheDhesws=;
        b=HAw69bR/gKk7MgkxyVN2Dmtkgh4kKzh6OrZ7Ygea03UH7ZeraQUtN4v1+H/A6PmX7p
         Qwb2fZ6AYwMo0eOKuo3XEAzHbzRYA22530sILSzJzATfTGDIeZFAg/YbaWnGD8oUp+R/
         yQ7eFkquDfu0dzAaiFCwh0zFL+OIZEZLICmFu0thTabZFZ5fkl4VM8M/zrs3uCDiKmwf
         mN6+mZeIPPiOCAATSffMw74MjYG5Rqr95yovTqBuMwHbblN+GEiBGzUx/QSr143Cia0L
         kyUIdXJ0RktK107AokNdHg3G0KEb8fx1xeqNaPmkPXaNwIsS7Lteh2DLEx/lomHCYxID
         /P1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tid0vIjve6cySVa11DBwAUvtDThyEhO5uZBheDhesws=;
        b=uCoMGokY+8dVrmeBfDpkPj17wi721bhFMAzscZlRR52Gde3wQ8eqm/2qz/+wP+P5DF
         zkflnq46CNyKnRNwpdPYTKmJiTlfi9pfGdsSHzf6EfO4CX/109wYhoAhAf5NYc8QKEHi
         n+rv6UJVvCj6jxh2GzF6aCRugPBF8J3VQvbGSNO0H2abRBvcA/6PoJfXYEq7Y7RBWGVM
         LLgqQtlrnaLeRU0lfUv4h+/4nCzrVWV6VPNBb79grxSzInqFhQzOZ6nezErCZtdjA3IA
         42+gIBVm1mJEnqR6p+NGhfMtI6qdti0OsXFs3XQGy3Ri//XFuywt6+a1wM1lhh/Y/EFp
         QL2A==
X-Gm-Message-State: AOAM532FGjpm5Gsz0wAHuYT7LrJafmDPQbppmmOYSuN4pGkissOZgnt1
        7C/K5p1mW3WVLBcGBdWSs0QmfsgGcnckfeo64iA=
X-Google-Smtp-Source: ABdhPJz1kgjsafU0BpJONVTRpd7QKxBnBBjKXY1uj3kgqNsOvp+hmeIdPqRgq6BMbVkD0sR+WlDArHVcAryxEbswNCs=
X-Received: by 2002:a05:6830:543:: with SMTP id l3mr6962331otb.241.1612034126276;
 Sat, 30 Jan 2021 11:15:26 -0800 (PST)
MIME-Version: 1.0
References: <pull.726.git.1599335291.gitgitgadget@gmail.com>
 <pull.726.v2.git.1611954543.gitgitgadget@gmail.com> <xmqqft2jqkli.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqft2jqkli.fsf@gitster.c.googlers.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Sun, 31 Jan 2021 00:45:15 +0530
Message-ID: <CA+CkUQ93OOd0PTu0N4dgwvm1kb7WP8GLFvGTXZvh=4=1KuE6=g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Unify trailers formatting logic for pretty.c and ref-filter.c
To:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Cc:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, Jan 30, 2021 at 6:58 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> With this queued directly on top of master, I am getting these
> failures.
>
> t6300-for-each-ref.sh                            (Wstat: 256 Tests: 301 Failed: 6)
>   Failed tests:  277-280, 285, 287
>   Non-zero exit status: 1
>

That's strange!

All 301 tests seem to work fine in my system.

I'm clueless about these failures and can't think of any possible reason too.

Is there any way I can re-generate this or can trace the part of code
which caused these failures?

Thanks,
Hariom.
