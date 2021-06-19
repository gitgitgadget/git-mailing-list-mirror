Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B7AC49361
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 20:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B44C2611B0
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 20:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhFSUD1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Jun 2021 16:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhFSUD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jun 2021 16:03:26 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BF1C061574
        for <git@vger.kernel.org>; Sat, 19 Jun 2021 13:01:14 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id s17so6263479oij.11
        for <git@vger.kernel.org>; Sat, 19 Jun 2021 13:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HN1kj3KOdXsFxU04CgeoHs/9MQXd4AKTSPNSmiSpzW4=;
        b=kxUMDZ1VxtposULAPfmhYISCuElQgbCthWpD5lbn0MZYABmE4NaTRwDD+wijh3yCrS
         WSYobhUoA5oLRbAL3poa94qGKfz1hcGTYfUq/fbU23F0Z0Qm/3ochQnjrUjUL++DVjmP
         S7g5lkcN2WUvo5hpdg2J2DT3PFKQBFCfAkvI6z0EE47fLkL5M/Yb1GDWhfM8SyS+n8Dm
         MyUeaaM0KFQzo+lYNrvLlbmZ+DdTpadssFqKmgJbnIb6cLRvwh16UF8iO+MrWoe/Auzx
         omFdAMA6Mvd5yIUcffOM1c3Sl8OSUhH0G6pKRDydvULQHZSwzTUC8o3nIKvUFgb97p6o
         X7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HN1kj3KOdXsFxU04CgeoHs/9MQXd4AKTSPNSmiSpzW4=;
        b=a4+/sJ6Zc+C5nqrIgAAefnVk0r4zdrJgxNzj7p1zHdJeXmYxj6lv+cMWGx945oJ/77
         pm2HRVTfHaaOLwWAt9wBRKglpRN4c9JCHQhNFHTdDz6TDv97DQt9T71WBGx/RUuKY20k
         OrSv55t/57IzE/MmVG6aLdQvVYQ7uKE6s+pd++Q2OPak0//Gu+uuFAoNA3Akvua3B0v3
         +dfm6eDw22z6HDd4M9YnC3XIckidV0YT94THsL/ugbgfPOwc+mvMrfjqCypT+C4Za5wg
         uNCOLJY+oRDXkE7vphN+fGO3liz5yWeEA5Fq4AyQLq+QqWB05dnsVftb7lrB+MoFiKj9
         +x+Q==
X-Gm-Message-State: AOAM530oxen9yOxs7+UVQnIw9CtABVpr6ePcpzW26V0Ny2hkn3bxCmFJ
        eQaRPftKpfEpQVJrc41XTCAudXXBRUiW7tCD2zw=
X-Google-Smtp-Source: ABdhPJxj/RYx7W+4dT+Ojy+2ZYO8QGsk9PBS0mLHvC4KOd9zOErkLIAJ1nN5E6CaWUvJWCap51c2wpV2ahKR3eB7JIs=
X-Received: by 2002:aca:f482:: with SMTP id s124mr18967220oih.167.1624132873447;
 Sat, 19 Jun 2021 13:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1622580781.git.jonathantanmy@google.com> <cover.1623949899.git.jonathantanmy@google.com>
In-Reply-To: <cover.1623949899.git.jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 19 Jun 2021 13:01:02 -0700
Message-ID: <CABPp-BFQhBN-MEGgkyK7gcnuQp01Xfj17TrTcH04yuadXuRu3Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] First steps towards partial clone submodules
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 17, 2021 at 10:13 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> Quoting from [1]:
>
> > I'm happy with Jonathan and Peff's responses on patch 3; as I
> > mentioned above I just didn't understand the original code before
> > Jonathan's changes.  (Perhaps some comments could be added to clarify
> > that code area, but again that's clarifying the code that existed
> > before Jonathan's patch so it doesn't need to be part of his series.)
> > So that only leaves my nitpicks on patches 1 & 4; otherwise the series
> > looks good to me.
>
> I've addressed Elijah's comments on patches 1 and 4.

Yep, patches 1, 2, 4, and 5 are Reviewed-by me.  While I looked over
Patch 3, I made Peff explain it to me, so he's the one who reviewed
that one.  ;-)
