Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB8AC2D0E2
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C1BD20719
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=webstech-net.20150623.gappssmtp.com header.i=@webstech-net.20150623.gappssmtp.com header.b="t8HQ7WcL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgIVWRm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 18:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgIVWRl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 18:17:41 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D67C061755
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:17:40 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id n133so20808632qkn.11
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=webstech-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UjLarH7tqtGfDiBM3Gcetg67h28sg+oGTzPVXGYFBCA=;
        b=t8HQ7WcLUDBvdtyyJrMRY0OwHncCc3qF50bS48pelCTa2zpojI+G2qz7qRt1550YHL
         erRgaP8mf6g/kgCm2qQM+/5hy/YkN68O8SQmFj6Q0hbq1LEpLoQtyfFjKR2celKzFxKR
         vWs25rKVOHdaV96kqfH3/I1yHDVNtS3czqtaC7UCIlWYKKPPnElz8uo8zBj2dg7uj/J1
         XnGKVzXamzKwb62a1vkl5zB+yhwLsX5tLjXOfD2Way1lLEUoI7AZS+1ziCpV/kwIEdIH
         ExwyAC2NSS63j7uMYLHHTXcc8qpdOZUkJkpcDOYWK7F7ruUcX8IFTdGHiGKLA2rLWCi3
         f+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UjLarH7tqtGfDiBM3Gcetg67h28sg+oGTzPVXGYFBCA=;
        b=ROEmbhWHDPSnfDGu670DKKDdpjUOCCoRK9+ZH2L2iSwsdbApNumMPhQ8Z8OahDT4eC
         TNPW2KOk/TZPNwyPWjTYCOvhu2qL8Hh9hLOkEu+CMum767GpvBv2oLPie6pWwwZqJJvS
         +gKx12WrmKGm2aQbm681c8ZGNZlrXWPF1xiTjuGFYc00MaqKmtrjSFdkCN1VV1q37Da3
         64k3QRwIRRtr7vHvT1EohWKltr8sZkjQmNWw+sGkLBySBv3fzYXX//VpnxyEa5IYyRnA
         TFFIrTzDCKoSvxzPscclkE2k8uDTYBwySXYkV3/ajORDr5tgiPX8XV9K26Muki3IN45Y
         LSwA==
X-Gm-Message-State: AOAM530WZ0ZI4kJrqSJdNk2tNQJ/hr1x6ErybK0m82wJlFpd9V5wNHxp
        ypoQJ4qyxNBqeVjw2LNukzYB2gtn/2pPJKC1aAeCyA==
X-Google-Smtp-Source: ABdhPJygYBPBiL0K1txuO/w4WUw7D2xePFwWXYnjr5DmNGdmFPVB8WsTnLrXhIfZDcg2zSrT001Y9sFCciX8xCZ6v1o=
X-Received: by 2002:a37:4f47:: with SMTP id d68mr7090717qkb.6.1600813059882;
 Tue, 22 Sep 2020 15:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.709.git.1600759684548.gitgitgadget@gmail.com> <20200922170745.GA541915@coredump.intra.peff.net>
In-Reply-To: <20200922170745.GA541915@coredump.intra.peff.net>
From:   Chris Webster <chris@webstech.net>
Date:   Tue, 22 Sep 2020 15:17:54 -0700
Message-ID: <CAGT1KpVmeT+nT1-Pfwa_M8BptFYwRTL4ofM0k6UOOzkYh0kucw@mail.gmail.com>
Subject: Re: [PATCH] ci: github action - add check for whitespace errors
To:     Jeff King <peff@peff.net>
Cc:     "Chris. Webster via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 22, 2020 at 10:07 AM Jeff King <peff@peff.net> wrote:
>  - for a linear branch on top of master, using the commit count will
>    work reliably. But I suspect it would run into problems if there were
>    ever a merge on a PR (e.g., back-merging from master), where we'd be
>    subject to how `git log` linearizes the commits. That's not really a
>    workflow I'd expect people to use with git.git, but it would probably
>    be easy to make it more robust. Does the PR object provide the "base"
>    oid, so we could do "git log $base..$head"?

GitGitGadget PR linting is going to flag merges in the PR and request
a rebase.  If I understand correctly, that means back-merging is not
part of the workflow.  The checkout is limited to improve performance
and reduce resources.  In the PR object, the base is the branch.  The
github api would need to be used to get more detailed information.
The "base" is not really part of the checkout so it can not be
referenced in the git log command (without doing a larger checkout).

...chris.
