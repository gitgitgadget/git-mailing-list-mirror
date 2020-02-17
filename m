Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453D9C34022
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 18:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F97C20836
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 18:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwfCVvsC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbgBQSYi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 13:24:38 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38179 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbgBQSYi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 13:24:38 -0500
Received: by mail-pg1-f193.google.com with SMTP id d6so9626130pgn.5
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 10:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a0TTq9nLYTjLUkxrNaYn/xFOa34bEook14Ag/+A7/3A=;
        b=lwfCVvsCzlVD32kmSBd7U41LrPlNpmCzTKSDJ4nMh4Ve2q5rU9npqseu/9HEFsiQTH
         6OJQbNDlRncBW10bLn/6TkD6mKuSaNpP6T5QJkWH8XtOu6VvkQj000idh7FZ1ln9dmql
         iTyrw245WXY9ztoPpPlVXQRgFOzKUG2XSDlRx7UAwy6AOOhaLIEI7mY7M2hD5Po9rfob
         CpgbwVVr5uKuveuPEke7ApVUVA7+tgR5QvM2UvS3NIUMXKJOBDx6PE7koTlSXJzJ9lCq
         lyRQ0kymbdddV1Oybc62vDA1OYbAqDrOUjE9DVz/2oHXxBgDH2pHc3SBor8o48KDYvbR
         J9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a0TTq9nLYTjLUkxrNaYn/xFOa34bEook14Ag/+A7/3A=;
        b=lKuO41fCrGsAWA2/WiwPKanM4NJcUttiUeYQowp4B/UlTCo9Yjs9jsJI2CdRKR23oC
         HplFg53UBGtJKtWF1oftHoMvif/PFzrDYB6hxYo3w/aC4zXLKqOck3ysy/XRwo+GhOx3
         QTdQFKmyeHdAekqDQbMbipy65qlQRQyQ9BPRYUrtCvN0eGCEaOXZ5UnrNvrFX5N2gNdq
         BLF2tqbzjlwA+sngt1icL71He9x2PnA13//a5+9vcw3fd1OGQnBJJEDETZehg0YFfP+J
         FoJAma1gGTqZEU9REgXu2Q+PRVwzh0+8n2N6joparZAARicUpgpo2+HzH0uQhtgLd46l
         6/oA==
X-Gm-Message-State: APjAAAVTE7AG2QaiW4XHb/6rxL/0gwGRoGlcqWTcmHqWBUXkZuepHfhJ
        L1N1v0lyTN8uZeDwD0HD03YEFZNupl57t8482Cs=
X-Google-Smtp-Source: APXvYqwNjETGLTfjunHf3jqm5SXsXjlMtE6Xm7icuniPK7nT/FukkLU6Za2/vZeYrpwNbFMAKnpkU7qD8x6YLOOd950=
X-Received: by 2002:aa7:848c:: with SMTP id u12mr16862225pfn.12.1581963877409;
 Mon, 17 Feb 2020 10:24:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1580430057.git.me@ttaylorr.com> <cover.1581486293.git.me@ttaylorr.com>
In-Reply-To: <cover.1581486293.git.me@ttaylorr.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 17 Feb 2020 19:24:26 +0100
Message-ID: <CAN0heSrAr0i=JQ5ARqCJzsRo2+L2NFAjBwTEEq-fE=ObT4=Ykw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] builtin/commit-graph.c: new split/merge options
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 12 Feb 2020 at 06:47, Taylor Blau <me@ttaylorr.com> wrote:
> I picked up a couple of ASCIIDoc changes along the
> way, and a range-diff is included below.

Yup, this fixes the documentation misrendering from the previous round.

Martin
