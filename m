Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59450C48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 21:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43DC7611CA
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 21:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhFOVYT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 17:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFOVYS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 17:24:18 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB22BC06175F
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 14:22:12 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id x196so57391oif.10
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 14:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7cJNS6J6UaqTAY8AK9Ps7p887rR3i5hBigWgA6Bg4iw=;
        b=ex+ijzpfRIK7sdITrVgqsCPhhM1efyxYpQH0BUAhyKUVqjUzDa06GOdGlT45di0jiB
         VMxl36QTW0+78l+yTRp1SXp7cV8WNUZnItehPCNZXG3KfHYj/q47vKPAw+KeC2KPV5B9
         JFMvuY4vwbqKlnn0aNAZcgTG7bbauxlfz8GxoTuZWb4tdoysSnZ5WHQMJQyyNzCL4MWn
         bMl7Oy98BAquDEbtd3DUFTNsTjNj9OOtwGA3t9ihj3TT42jidUqf3xZ8vN0amZB8m94i
         5cVvXb0a3Cbt1j3yYJLUXL3E4Z3iPNUIPEZv5XsFIFWHITts+aWT1PTzku9zEmVYakLl
         gTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7cJNS6J6UaqTAY8AK9Ps7p887rR3i5hBigWgA6Bg4iw=;
        b=LA+f3dkDlWcfnw8zOZcTWLQPm2yrfd7NYE2sjlkDfHBV5gA1dK9B7HTOEjDGPg/dMC
         gD/Uo86tq/9Pt/hvWUt2HISd3/wAqz3/sF/CGHRMcfwci7MJlZY7GQQuqCluF1Ns6ZEf
         H/8d+wXgcMn27lb8y7oMsBdWVjSmjla5itm4JbDn/rWNvP43pzR8j4+JlaQwnj5nFb3G
         rqoNz8s62OexXWHkwcCAmQsUuqo4N5BGnB7MiXZkaPReg9U+SHD1u4quvZZym37s50C7
         uD5iNRAvROZPyfUVDBEysbD+ys5DPZsTpQ+nmYC8nC6Ac75QDU62ZIxIA2Zlp7/rruAb
         1b9w==
X-Gm-Message-State: AOAM531w0W+FCSdGUxZlDg2syk1DOKZ9z93cErjA2nT8pYBPMjlT7zMJ
        cJh0fxsZYk/S+dEUcw3dRFUnDlgSfXYGu8EWfow=
X-Google-Smtp-Source: ABdhPJzWFzKOeM1TCi19IwrtIQIZFmgfK7OYRgnU62iGkfugyWq4vf5wUFJbtAL0RyNAbM+lZA5P5B1W5FoMaxlVio4=
X-Received: by 2002:aca:330a:: with SMTP id z10mr780410oiz.31.1623792132116;
 Tue, 15 Jun 2021 14:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1622580781.git.jonathantanmy@google.com>
 <cover.1623345496.git.jonathantanmy@google.com> <CABPp-BEEiPP7AEk4Wexw4_MDHcin2n8xkMowO=OXTn9pNPaG0A@mail.gmail.com>
In-Reply-To: <CABPp-BEEiPP7AEk4Wexw4_MDHcin2n8xkMowO=OXTn9pNPaG0A@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 15 Jun 2021 14:22:00 -0700
Message-ID: <CABPp-BFD5=98C0+WnfK=+s7twZ960ORiZzUSP94GD2A4bXJ69Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] First steps towards partial clone submodules
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Saw this series mentioned in "What's cooking" and remembered I didn't
give an update.

On Thu, Jun 10, 2021 at 2:29 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, Jun 10, 2021 at 10:35 AM Jonathan Tan <jonathantanmy@google.com> wrote:
> >
> > I think I've addressed all review comments. As for Junio's suggestion
> > about also printing the type in the former patch 4 (now patch 5) [1], I
> > decided to just leave the code as-is and not also print the type.
> >
> > The main changes are that patch 1 is somewhat rewritten - we still
> > remove the global variable, but we no longer read the
> > extensions.partialClone config directly from promisor-remote.c. Instead,
> > we store it in struct repository when the format of a repository is
> > being verified, and promisor-remote.c merely reads it from there. Patch
> > 3 is a new patch that updates the environment variable preparation
> > before it is moved in patch 4 (formerly patch 3).
>
> I've read through all the patches.  2 & 5 look good to me, I had small
> nitpicks on 1 & 4, and I'm totally lost on patch 3.  Patch 3 is just a
> one-liner and it might be fine, but for some reason I can't figure out
> the code before or after the patch even after digging around into
> other commits and other files to try to get my bearings.  Hopefully
> someone else can comment on that one.

I'm happy with Jonathan and Peff's responses on patch 3; as I
mentioned above I just didn't understand the original code before
Jonathan's changes.  (Perhaps some comments could be added to clarify
that code area, but again that's clarifying the code that existed
before Jonathan's patch so it doesn't need to be part of his series.)
So that only leaves my nitpicks on patches 1 & 4; otherwise the series
looks good to me.
