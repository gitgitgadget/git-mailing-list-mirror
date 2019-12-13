Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307E4C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 22:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB05D20706
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 22:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkyIrbSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfLMWWK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 17:22:10 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:40891 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfLMWWK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 17:22:10 -0500
Received: by mail-wm1-f53.google.com with SMTP id t14so343071wmi.5
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 14:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=KzcMXRgrDpVEP95PyuYh12iJsKz2NhJnfxM57XGU8Dk=;
        b=BkyIrbSS2vK4DUTihxLq4LLFLLSOCLrosvP1pLbyXX7BRbI8NcmGapFMdnA+sm9kt1
         zBnGep3V3iuGG0llNWouNoPRBlHG67RtwBRbqfgtYvMi96S0u2LbPVNTpA9DenX9wvvL
         QFDrfVuYRrHH3kKOG+X7/T0A5NjRAIV0QKTfGxoLwroKA+mz9EoEf/Mj7+qw0sPOdiJE
         NeaSzt9jRuJJ1LMfNbjTt4hOgo+Wp97zbN6PsZ5wVsuamPBu5bPyB1fXDeeuSF0p2PwW
         FabCI9+HUP2TSQJKSpHFN8i104Xs5XV1t43/Wqp1hR9JcvlrZmlhkg85o8CUjhp1Ap6c
         liZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=KzcMXRgrDpVEP95PyuYh12iJsKz2NhJnfxM57XGU8Dk=;
        b=BjJRP9+q1R6Xt2OFmVjH28PDk7cN7263mPlGyaMXGsf/kYKd+s896PQy/VpV+5qPj9
         D7tqMpW9vtdDsuy6ElhMFsXPXxAxTxoACcX8rL7G1jrW9IlzVfLX9QXsGNSX3ytYqdPQ
         U4f2ZPc5NZyUB7FzpytQpekx/D3nn10m9257VXJoC6vdG7rEO+ACy/170dihyZTiZAI9
         0RY69r/CW/ylDJ2fQwrPkQAxMV5Rqgkz6poFEiurolbp52It8d7uLkYcosaseBWHAMaG
         k+40oNZPMzxMLUgVbCx2X6UtcCPj2zGyKJ8ESP0SIXhU3dFThgNY01RKe4f/l5cJJ4IT
         eK3A==
X-Gm-Message-State: APjAAAUsd7sJhfF6D0bUH9jhvOWO8Sx7PrMQalj7UHCsOySHPH73Gorb
        RK5sJtxWhAyf1u+7h73f9WBT6yHnaDnN0m3+ST8ktw==
X-Google-Smtp-Source: APXvYqwk0wSEWISR/3er8Yyh1Ukzhq2xaz7jp5N/1kgDNP4Tv8Vi4A6VIK/FI0xUI3iwc8bfH0h8FoHRkOac0I3NnBw=
X-Received: by 2002:a05:600c:2549:: with SMTP id e9mr3249153wma.6.1576275727587;
 Fri, 13 Dec 2019 14:22:07 -0800 (PST)
MIME-Version: 1.0
References: <20191213172835.GA2315@349209-PHI-GMNO-CLAHS> <20191213173858.GA117158@coredump.intra.peff.net>
In-Reply-To: <20191213173858.GA117158@coredump.intra.peff.net>
From:   Charles Diza <chdiza@gmail.com>
Date:   Fri, 13 Dec 2019 17:21:56 -0500
Message-ID: <CADv8sCUDSu7deSP4Wqry_S0TXM90QQu3EO_X_5ZONkXPocUiZA@mail.gmail.com>
Subject: Re: Regression in 2.24.1 wrt progress indication
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 13, 2019 at 12:38:58PM -0500, Jeff King wrote:
> On Fri, Dec 13, 2019 at 12:28:35PM -0500, Charles Diza wrote:
>
> > I reported a bug in progress display in git 2.23.0 earlier this year
> > in August.  This bug got fixed:
> > https://public-inbox.org/git/20191002154734.GC6116@sigill.intra.peff.net/
> >
> > (See the earlier parts of that thread for the bug report.)
> >
> > I am sorry to report that this bug has returned in 2.24.1.
>
> The bug in question typically showed due to the server side of the
> connection. Do you see it during a fetch (or pull) or push? If so, what
> server are you using? Is it possible that that server upgraded recently,
> and it has nothing to do with what version you're running on the client?

It happens during pull.  I've seen this when pulling from gitlab.
Reverting to 2.24.0 fixes the problem.

-Charles
>
> -Peff
