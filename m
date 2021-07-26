Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375BDC4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 02:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 120D060698
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 02:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhGZCSs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jul 2021 22:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbhGZCSs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jul 2021 22:18:48 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698F2C061757
        for <git@vger.kernel.org>; Sun, 25 Jul 2021 19:59:16 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id r26so12916956lfp.5
        for <git@vger.kernel.org>; Sun, 25 Jul 2021 19:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o2nAuSgQlX/CBUJEyLwYDU8MsDgYG9NgtyZjTjjh8Rc=;
        b=q7Ad8Go1ARow9fnHdIxEh5zGOCyPg/LtA5PL0CRua0UHOmqbF8rEtvVCkTv7Zv2UUT
         97eeZeDZOGJ9lrttZaSncavZsYicDFrGLQ97piIHn6d3ZN3B3kfJ95k3WvIT0PbGP2Oj
         TNk0eQrk51UD3/IYsipPzP3scnw5hVpHevNlkzy6hJefT03gny1eag3TBeEsL7E2Td29
         m6CmvLIzDE4VMm/TbYfP3cTewV9tMH/umgqI3q/5KRfEbTXIGBGNuq6szUK81xlhfXyK
         r93k5/AxE6oGknzUgtXleJMhNbpwf0wJxPSOTz8XarAnO5v3+Q886oOoKIzMseAArgpm
         jN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o2nAuSgQlX/CBUJEyLwYDU8MsDgYG9NgtyZjTjjh8Rc=;
        b=WNy4BFvH43L/eQdZymx0Zx9lVf91jgTkMvEu3glhIrc3YQ0KSCq44oEAqXReFkNAk5
         /7nPYvHCkBALEOpI93Yy9WqW6pqM2MRydCUJt9Z1tk3xcquyvYNjHh5fRJnwpjazSbrA
         uJ8hOJJtN5cizPNPYeVg2NTceBw70p4Xbm1Zyb0YPjU26ExWeAKafz+aUAJa7/XsZqZP
         BSdbBX4ePpELB4pWQLGJLVOLuHSkVYVy8nzPIoCx3SO9RCIxDlLx9Uks37sbcwGIWM1P
         Hi6qu9pvHXMcipK3zIlbTJyqtpAP8kQaq/1CGtSwL7QDG7vkhVxccM7f1Y0F6K4EcgbW
         b7Xw==
X-Gm-Message-State: AOAM531fb6ZbfDTgoYotT+qtuPNPrgmI2Rkkbvhqz8FKtHMfqW4NaXVn
        PzBKftfI9bxSkL5JhCq8uhSin0bYSh32aqlh4Gk=
X-Google-Smtp-Source: ABdhPJxRUTsbAnVkZORvWbHR6AYmlCBjPkuuMFFqz5BOe1+dgZ75anpf78GNnsXB/cRztLxTxy7YEvsAh0AjonLRtoM=
X-Received: by 2002:a05:6512:4017:: with SMTP id br23mr11575975lfb.113.1627268354736;
 Sun, 25 Jul 2021 19:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <dd4aca2c-9ca2-e489-d78f-9d2a5580f1a5@mfriebe.de>
 <4e9b54b4-8e40-7fd3-ae65-d33390f3af43@mfriebe.de> <04f3b300-3ccf-c91b-6406-6a998b473a24@mfriebe.de>
 <bfc257c7-bf74-06be-ac62-9a6d27f565c9@mfriebe.de> <CAPx1GvcHiaGsuOybOijRYpmivO0dLvUFacAeOrM4DfY-uuXB2Q@mail.gmail.com>
 <070f7f5e-0e6c-2edc-1403-9265c810df17@mfriebe.de>
In-Reply-To: <070f7f5e-0e6c-2edc-1403-9265c810df17@mfriebe.de>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Sun, 25 Jul 2021 19:59:03 -0700
Message-ID: <CAPx1GvdM7CzsbT1SWW9+OPcG9FL7WXQ7YD6aM7P0krujp_OrkQ@mail.gmail.com>
Subject: Re: Files modified, even after: git reset --hard
To:     Martin <git@mfriebe.de>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 25, 2021 at 6:34 PM Martin <git@mfriebe.de> wrote:
> Actually there is something else.
>
> If a file has line-endings that will change, then
>     git add --renormalize .
>     git commit -m foo
> will commit those files.
>
> But I am now also getting files, that show modified, but that can not be
> committed renormalized (0 lines changed).

I believe (but can't demonstrate) that this is a temporary condition.

Git has a number of cheats to make `git status` and other ops fast.
These cheats *assume* that the committed files, the index copies
of files, and the working tree copies of files all agree in terms of
line endings as coordinated through `core.autocrlf` and `.gitattributes`
settings.

When they *don't* agree, you get phantom differences.  Running
commands like `git diff` show no differences because of these
phantom states.  Eventually this clears up on its own when the
cheats really *do* agree with the settings.  Changing the settings
is what disturbs the cheats.

Git can't do much with `core.autocrlf`, but if it noticed that a
`.gitattributes` file was very recent, and turned off the shortcuts
and did the slower full status checks, updates via `.gitattributes`
would not show phantom changes.  The drawback is that updates
to `.gitattributes` could make `git status` very slow.

Overall this isn't normally a big problem.  It only affects one person
at a time, when they change these settings, and then it clears up
over time...

Chris
