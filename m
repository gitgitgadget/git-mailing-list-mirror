Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED1FC4338F
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 08:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B46760F42
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 08:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237489AbhHNICn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Aug 2021 04:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237447AbhHNICm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Aug 2021 04:02:42 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4536EC06175F;
        Sat, 14 Aug 2021 01:02:03 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id hv22-20020a17090ae416b0290178c579e424so19407466pjb.3;
        Sat, 14 Aug 2021 01:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PYmA/1frNak+/JEKetRqAi453W74LmX6mwHsC/CUI1o=;
        b=Y9jIfM3ejXMOylyMOMJRthUV+gDv7owyzGDBBsBXIF9YeLgwDblvEHYNrU54D1ZMEl
         7CkFDmXAy9YkmIbCLpTbOVbd688+sb4SGu8NoRK/XchJhBfRF5frLut4I2JWdiYLnrqQ
         hGqSDorEMWyHsSLzDUzRTiIZrG3O/xEBR5jE77adD1I3YhOJEtytYUPvBPzI80eXw81z
         2S/5xNon2iLxiAwn5og1Plvgt+NDjP3Tjl5UkBuYwm5MoRDk4Psl0lFuITIEq8lGI9Rw
         bnkWP/Pd3h16G4NyRKczLm3XGTO3oJyu8g4VXwYHx+dIw86pglQyMprUGVTPB8H1jiqv
         uL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PYmA/1frNak+/JEKetRqAi453W74LmX6mwHsC/CUI1o=;
        b=SGaAQBbcGTah4LMlsItK960MSI5gZuFaiZGlKlwu6SEltpxpWNqwLN77J+eWoRlJTz
         06L05ypljohA5juAuO9qxNBuQwmxED51HWyXu8TwPxev5TmE5zKljTxhNBkQyJAksTGZ
         QmoAJBRu0pno2Aam6k+cfvaphRJQSx1hIRJkw/vojE/Rvd3tPp0O5PU+aSnVchxByuJI
         SYOMxd/38TcXYyp84FQUY0dBf47s9OC/YaitvmZzR0espNkVwxhRCBThwGxTol30s6Vi
         3z3aZX82dYyJJn1b6rveMYx+vDkE1ZAGM3ckTa/FTm3xbtcZGfGUT7aJjaRAadYaEcZw
         uFBQ==
X-Gm-Message-State: AOAM532IErqMWeE80DsgICdy/40+eNCNcsVFLUjfoS+jgLNqfOTKsWAL
        ZJhaOBZGOGeIjPyErOs818VlE/BM5nF9ynEaYSU=
X-Google-Smtp-Source: ABdhPJylso2eqrMBsnpZ4X9Ay9Q6gCvZwhzjlijyvf6sqXnS7a0kvqgkcwVEghYUQ8J4G754nEWQZPTJKN+TAwUSyow=
X-Received: by 2002:a17:903:192:b029:12c:bf13:ab28 with SMTP id
 z18-20020a1709030192b029012cbf13ab28mr1545449plg.17.1628928122795; Sat, 14
 Aug 2021 01:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqo8a37eim.fsf@gitster.g>
In-Reply-To: <xmqqo8a37eim.fsf@gitster.g>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 14 Aug 2021 10:01:49 +0200
Message-ID: <CAN0heSrPXdpPXTpY3Cdn-HHcuzLvc--Y_L+SgK-QGt5yS8u54w@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.33.0-rc2
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 12 Aug 2021 at 01:23, Junio C Hamano <gitster@pobox.com> wrote:
>
> Git 2.33 Release Notes (draft)
> ==============================

rc1 had a section "Backward compatibility notes" where the recent work
on "git log -m" was mentioned. That was then dropped because of
6a38e33331 ("Revert 'diff-merges: let "-m" imply "-p"'", 2021-08-05), so
there are no backward compatibility notes in rc2.

> Updates since Git 2.32
> ----------------------
>
> UI, Workflows & Features

>  * The "-m" option in "git log -m" that does not specify which format,
>    if any, of diff is desired did not have any visible effect; it now
>    implies some form of diff (by default "--patch") is produced.

This is basically the same blurb. It was duplicated in rc1, and one of
the copies remains in rc2. I believe it should be dropped.

Martin
