Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3800AC433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 23:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14B8360551
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 23:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243305AbhI1XzI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 19:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242094AbhI1XzH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 19:55:07 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429BCC06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 16:53:26 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id t10so3025553lfd.8
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 16:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dLwHMNWKnuxU8wlrJEPeNq5kY95XrMyNfwMlXJ1egb0=;
        b=LrYjY4o50iBD/AhWOePWNr/pRa+g4ECicQ/Dk+MlL6zVdtkFzwgkgrzA+2ygwdRiGo
         qp8ovUZQ5jKvPSDCZVsHW26SXlI8TjPx6cO7GzlUkVS0d06/TluSpwAb3a+0Jq+FvK+o
         /q4J/bx+7LD2tq1ScgpMQbTOXSlT/B8efVq99q9RpEBkCIYAW02L6bSGdvNelw43ti0s
         qaVxolFVVGfSJFsqt1j01sb4kh3uETRCitY1xIzbs/2IyHlRXmg3rCTO1WPOaST7iN17
         H6lRi5U2Ys36KijE7WHZgHJXGW1Lp/95OAL90RaZCnMcTI+lVR1iLKTorLv2Y3tbqmZU
         m/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dLwHMNWKnuxU8wlrJEPeNq5kY95XrMyNfwMlXJ1egb0=;
        b=MU6s7NcDcKkCGCm7RS344vPhswZjaoNIa8tZVwIPtg5F3bKIXOaLoD/7EX36W0u7gJ
         6FOUCGIYsp+lcl59o0VFMVdij1uQcq0Jug1Mswlyq4uVZ5//jSY/wbT5PPr82pcVVz3p
         RLT3UGQGpBYC3YxUitmzds9Eo2kkp42tVVAiBBW5cQZklPyW5DAoRwMXKOXpdhMEKHG3
         rSfhCuZ2gN+VhsHxjH4pIfSsNwXhGSdclos/dn5h5Xb5VDr6yFE3GxdqRmLxBl/0iFzD
         t64qnKebB3B51KbvIKwTbOgkeI8G05MflIdcnahT0WvXLs/P/WbGc/f2krOSXQlRRae5
         4Tfw==
X-Gm-Message-State: AOAM533cJyuAv5rSJ3N6jHJh/WXLA1YxV8oEcQAttmT22A0Ba70ljD/R
        LyigmbOTbyPnowTLdyksua4bBlRD4RaI/NszhIo=
X-Google-Smtp-Source: ABdhPJx5YQ/1QGbXkxQdcEz7ak3JvLfy6BCMaZf06o94ZMNsZgeA5/y3qbnSFKUwA/m+7d1MQJnLwXQ1PGWZuuZlS00=
X-Received: by 2002:ac2:5e24:: with SMTP id o4mr8019203lfg.522.1632873204467;
 Tue, 28 Sep 2021 16:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq8rzhmsi7.fsf@gitster.g> <CABPp-BGuzd_TH57-1RvwJQD5r3S3ZkJcuiPnU8aWee8pgzUBEw@mail.gmail.com>
 <87v92lxhh4.fsf@evledraar.gmail.com> <xmqqilykliiz.fsf@gitster.g>
 <20210928210059.vy5isvmcj75vufdu@neerajsi-x1.localdomain> <xmqq8rzgi8a7.fsf@gitster.g>
In-Reply-To: <xmqq8rzgi8a7.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Tue, 28 Sep 2021 16:53:13 -0700
Message-ID: <CANQDOddZ-KYTB4q0nYNDinis8aKktm6Ek6F+mJouTV-yRtTpUw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2021, #08; Mon, 27)
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 28, 2021 at 4:34 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Neeraj Singh <nksingh85@gmail.com> writes:
>
> > Both Elijah and I needed the same functionality of having a writable
> > ODB in the current process, which wasn't previously provided by tmp-objdir.
> >
> > I'm making a new patch which is an amalgamation of Elijah's version and mine.
> > I'll rebase and resend my patch series with that version and I'll also make
> > a modified version of Elijah's branch available on github.
>
> Sounds good.  Thanks.

I just posted the new series to the list.

Elijah,

Here's a branch of your changes based on the amalgamated tmp-objdir code:
https://github.com/neerajsi-msft/git/commits/neerajsi/remerge-diff

This commit adapts your code to use the amalgamated API:
https://github.com/neerajsi-msft/git/commit/725328fe1d8be8326d2ddef78e164ca21450b100

Thanks,
Neeraj
