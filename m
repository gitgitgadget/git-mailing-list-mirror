Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30477C2D0E4
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 01:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9B2D221FB
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 01:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aahqBtk5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgKUBSz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 20:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgKUBSy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 20:18:54 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2C5C0613CF
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 17:18:53 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id c17so12680752wrc.11
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 17:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pkMXZu2UJ2zdVtiLd/TGHeIQIJLFk6TTacFoSM2nYwc=;
        b=aahqBtk52Q2v0dFMIuniOtV/EQlcLuHws5x9syw4cnndpf3PXZeQdwxFusqIcgGWfP
         1ORe58HqsUDa8rmmLemenpn46vQYG8JWyRMroIy8KjCyZ3nWv8Pl4UF3s5/R1ze17l9W
         eRLR5IxlXBEVMymA/ImUTqg5UzEBjON3x1EvJOolsb87LpCQ37hXt8VZNXVuDoRobHP2
         MalpIWXXFNRsZsxwT0sf66r6kSPWvE0PnCL/4+zvlMlOsRx/nEXhwjTNtyBo8bZC/EZ2
         XFJ2QhU2UMQR86IBBYWF0n0iAcFBIcNQxT5Kfvjfz132egzsQYXn6enkLvhSp/7t68js
         TMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pkMXZu2UJ2zdVtiLd/TGHeIQIJLFk6TTacFoSM2nYwc=;
        b=uiHmiDS5CRfOLLlKTGiZbHMTxxS4edQ0ZG9X3S7hCQ6BvPtqQT+CjGv893aw5I/Zae
         H4+qNsjl9ruqH62ydA6uZWScdGuM6E29lAaoPXyXVa0aaZzNeRLzXnyUNLm+ZBiyDGDo
         3q0N144/h7CT2b2xxX5Fg5x09P7iSZ7x1LE+TTveyfDWt8ANi8Y2ByFj8buYd2PPAbxD
         0gbcjfCVvUp1DV0FpeXmTSeZgr4Uh3nGBvQcRoiKHuZ8AqDAYDMQodparmPJIsezNYS0
         ooY8jUI023Z5+A9lqPZNQGPseOr7rKOSO5anBSLcoHFIoH6fPz4u7yOjR6atZFFlUAgs
         Tcrg==
X-Gm-Message-State: AOAM533hQGuqTh+OHlDrNoI9QD2A9F5zV8cIC7NFHuigBbjMfHi/PCTW
        n88dnKpF8d5gIB6K7qflRYiL0zp90nFawDDnI3Q=
X-Google-Smtp-Source: ABdhPJwxJ0UmTn2T+7lJN6YpqvKGBOES8RAWqjf072OyvG01crRW9WN/NkDMyooNuxOJtcfyJuU9T0EMALJAKVDAeN0=
X-Received: by 2002:a5d:4349:: with SMTP id u9mr18590577wrr.319.1605921532606;
 Fri, 20 Nov 2020 17:18:52 -0800 (PST)
MIME-Version: 1.0
References: <20201118091219.3341585-1-felipe.contreras@gmail.com>
 <20201120235203.GA353076@coredump.intra.peff.net> <xmqq3613tuwy.fsf@gitster.c.googlers.com>
 <20201121004033.GD353076@coredump.intra.peff.net>
In-Reply-To: <20201121004033.GD353076@coredump.intra.peff.net>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 20 Nov 2020 19:18:39 -0600
Message-ID: <CAMP44s0E+e11jGFDa1zLK5Tv+2Zuv-_wXNF0NysoqEjtMgv0Pw@mail.gmail.com>
Subject: Re: [RFC/PATCH] Add fetch.updateHead option
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Dominik Salvet <dominik.salvet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 20, 2020 at 6:40 PM Jeff King <peff@peff.net> wrote:

> I don't think we do advertise the symref in such a case. In v2, the
> symref information is attached to individual lines in the ref
> advertisement. And we don't advertise the unborn line (we could, but I
> think we might need a special syntax for the oid field).

This may be worth considering changing.

If a hosting provider (e.g. GitHub) decides to configure an initial
branch (e.g. main) it would be nice for "git clone" to have
information about that initial branch so the user doesn't have to
change it manually to please the provider's aesthetics.

So the instructions could be:

  git clone $url .
  echo "# myproject" >> README.md
  git add README.md
  git commit -m "first commit"
  # git branch -M main # this step would not be necessary
  git push -u origin HEAD

Personally I don't care about this. But others might find it useful.

Cheers.

-- 
Felipe Contreras
