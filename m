Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0CDC2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 03:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1B0A2085B
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 03:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uRpFJnK0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgKXDp1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 22:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgKXDp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 22:45:27 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43F9C0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 19:45:25 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id g14so5656132wrm.13
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 19:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ONpmvK4P+AjyJw4MQY+BwRAdr45Muhse8eA57+zE5mQ=;
        b=uRpFJnK0fbKmNdIUMfywm6Uwok8QXvTVja524xz5q351qpKgDl4pEjwuYNf4QjLi0j
         tZkK1SBVD00UjGix9pXKPXCZA2W9gUPoLixvnkbOhlaIfHj8ZNT+mluPENSeEOPsFrAW
         KiWj8hesSec7Lbg6pUgj05uKTaqVtkGzhYX6cLAetBrQz2Rub4BhP1+CmSQZnLRwYSDn
         agntvmnJossZ9gUHuyNoyM16zQSPrP2rPrraEBQziSrLLYKePfoiedc337PgSgLm5yyZ
         kun6Xx5eUq6VjSngD9oXouKQLqgQqdi8QiNUh93yNr0g9vHm7RUert8eHbpZ1gbwPsgW
         EY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ONpmvK4P+AjyJw4MQY+BwRAdr45Muhse8eA57+zE5mQ=;
        b=fnpwFKbxYQ82aqA4BGU2lpwo1r41VLanLBibIV3rwXtx8T+bIqO2J7e7WiY/yptiqq
         UJtAGaNDlsUuHL1BvYDqdM08gy1bU/DKX9PUfAmGvYQdi6iYyCKz+3h8J3TOOmXqZK8i
         r1d2haBGSgM8Fvf4z/iY09dRTyT70niZpnmThNeXfiJuhCf9tEtEKky3eUxqMpVOrLDP
         MueFI8wVs2pxpOV53oE7V8QQdDPnurV6hbYqFnZKQ/E44Qk43WsdJHZTYWrkst5Jgyvy
         EsGqGDl+taSSvBLfIpiMzDplAEGtcsBOGfF9vJJydcWa3Rbyw96cFEpU85bGNNZWsb34
         W1EA==
X-Gm-Message-State: AOAM530GOCNujniJpnUT+eV8NzRzheIBR8ePZrO6FKoongoQ2t9vr3ms
        0WYud6UzPMIomYsolK9d+dEW4UKEkmC6a0VzWaI=
X-Google-Smtp-Source: ABdhPJzgFv6Y5PPtvWPS0KMutzSeX5Oo4dyF3E2IJ0szeoFX3g7r4y+dJZ689rzvuW4rKfPY22FvqjsSUQPQXUgZvg4=
X-Received: by 2002:a5d:474f:: with SMTP id o15mr2823592wrs.100.1606189524584;
 Mon, 23 Nov 2020 19:45:24 -0800 (PST)
MIME-Version: 1.0
References: <CAMP44s0r1vf7x-wHP-b6KQRU7mcPSZzcMRK2VqqxU_SJRDs+kg@mail.gmail.com>
 <C7B2K1BLPDIO.1D6XVJIWIG3UZ@ziyou.local> <CAMMLpeQmJ7TjMKvtjdczyRX+Kebc9DDDyOJthpA6AwxQqy022Q@mail.gmail.com>
In-Reply-To: <CAMMLpeQmJ7TjMKvtjdczyRX+Kebc9DDDyOJthpA6AwxQqy022Q@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 23 Nov 2020 21:45:13 -0600
Message-ID: <CAMP44s1QjgOAq6trBmw5Bxt8aXRqVkOStztFOpJr+ooMEG7K0A@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] pull: add ff-only option
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     "Raymond E. Pasco" <ray@ameretat.dev>, Git <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>, Jeff King <peff@peff.net>,
        Andreas Krey <a.krey@gmx.de>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        Philip Oakley <philipoakley@iee.email>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 7:51 PM Alex Henrie <alexhenrie24@gmail.com> wrote:
>
> On Mon, Nov 23, 2020 at 5:52 PM Raymond E. Pasco <ray@ameretat.dev> wrote:
> >
> > I feel like the parsimonious change to make is simply defaulting the
> > existing "pull.ff" to "only". I think someone who has set "pull.rebase"
> > expects pull --rebase behavior just as much as someone who passes
> > --rebase on the command line. The issue in question is what someone who
> > has not made any changes to the settings expects to happen with a plain
> > "git pull", and I certainly agree that people who are not power users
> > expect a fast-forward (I try not to force my opinions on workflow or
> > style when onboarding people to Git, but I do always recommend
> > "pull.ff=only" because I know this is a perennial pitfall).
> >
> > The problem is that, as it stands now, this would just leave the user
> > with a cryptic error message ("Not possible to fast-forward, aborting")
> > when they wanted to see remote changes. I think this might warrant an
> > even more expanded message than the short one in this patch, but I'm
> > not sure exactly what it should say - there are a few things the user
> > might expect, but an error message isn't the best place for a crash
> > course.
>
> Another problem is that when pull.ff=only but you really do want to
> allow merging if fast-forwarding is impossible, having to type `git
> pull --ff` to get that behavior is *very* counterintuitive :-(

Indeed.

It would be much more intuitive to type "git pull --merge" which would
override some default (e.g. do not merge unless it's a fast-forward).

-- 
Felipe Contreras
