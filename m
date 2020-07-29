Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAD1C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 21:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55AD5207F5
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 21:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SP7Gi+LB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgG2VDV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 17:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2VDV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 17:03:21 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287ACC061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 14:03:21 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g10so2939329wmc.1
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 14:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pRUgfSDfbWMFC6woT0PjLgZ6OtI5JIsEx0pOudLy4kY=;
        b=SP7Gi+LBOOQGzKgK6ZN0Rgnyfd4Ha27Yrx20Ol+cL3Oeh9rIsiaX2kar+EHxA5YIoz
         BqrrXfzi6rxHF8RWrOjUbZW3U1bHQ2xKPacwK5gXF4jarvW9INYcXXET/EfJeGHEDbwQ
         dPCJXdW1tDIipLS0sf0DhxshMi/Zxft7rvFOCpyNzW0gR2YPLT5AbV0ofVRvVc3BLeo5
         pAcqr+gR7LElJbtc4CRTHzNXbnzcY+fJ/A3DYuiu19WXQfphcnIq4GAtlQ8fFAIapu+b
         cuW8+uUZE0pAc8tqHSvwDC7VSX5bU7/EQBOXInlMg9Jz+HcjfpijBLX9DyQTdqdjPO1h
         gHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pRUgfSDfbWMFC6woT0PjLgZ6OtI5JIsEx0pOudLy4kY=;
        b=JNXn6Vx2f9kc3XJ+zxQkDwzNIP7L5S6EST7rYEnydzfAxfR6xHK9UT4iJiEnJdbYb1
         qdu8zak2MvX6zih60djuUwfZnzhE5XJFWBHSFdKbBR0NFALxQU1cdG/ymJiZaa+OvK1K
         Ox6PE8sLE4CN97DcMGSjjDlWKPQQfoEI8nON81h7pg3PTM2o4xJ5OAinKSoYJIlRCvsz
         WxbeXOWHQJAMf5oMaJ/5yXrpUhXsbMZRyL70p+MN5gC4MddZkLyd/Ruz3vkUAcQuzi+D
         Nbf9vQA40CpPAdi9LFn84Ek6We1NmlO9iYIq/oKg2jbOCQbW0JKAVaQhWSAE+jZBkCHr
         tqyg==
X-Gm-Message-State: AOAM5331yWTbZBWOBdOkODWavrvwkZlR/MUn4CM83kilT2S4jkhyMsDT
        QzQqiwzUzsyNI46Cmbwy1SOrqJy5oZNNprA8T08=
X-Google-Smtp-Source: ABdhPJzPZMvxfOSdgNc0KnUdqVXJWA48ATy+/FfahMDF5oopq0/GL2YcxAMdDewWWcQK0hMLJqsgdnq1RBcakBac/lo=
X-Received: by 2002:a1c:e90d:: with SMTP id q13mr10700952wmc.187.1596056599845;
 Wed, 29 Jul 2020 14:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200728163617.GA2649887@coredump.intra.peff.net> <20200729201002.GA2989059@coredump.intra.peff.net>
In-Reply-To: <20200729201002.GA2989059@coredump.intra.peff.net>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Wed, 29 Jul 2020 14:03:08 -0700
Message-ID: <CAPx1GvesMkZfgVDNQcHHOWHmVTOrEnpbJB5WOqZwG14m2RCEiA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 29, 2020 at 1:10 PM Jeff King <peff@peff.net> wrote:
> Here's a re-roll taking into account the discussion so far:
>
>   - the escape hatch option name is flipped to "--no-diff-merges" (with
>     "--diff-merges" matching "-m")
>
>   - the documentation now discusses the change as well as the existing
>     handling of merges; this involved a few extra cleanups. Try
>     "doc-diff" for a better view of the actual rendered changes.
>
>     I do think longer term we'd be better off to stop having this maze
>     of ifdef'd inclusions, and just have gitdiff(7) which covers all of
>     the possibilities in human-readable text (so yes, you might see a
>     mention of diff-files while you're looking for info on git-log, but
>     that would also broaden your mind about how the different commands
>     work). But that's clearly outside the scope of this series. I think
>     what's here is a strict improvement.

I agree.  The new series looks good.

Chris
