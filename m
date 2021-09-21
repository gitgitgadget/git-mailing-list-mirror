Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0865C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 10:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8D1861131
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 10:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbhIUKts (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 06:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbhIUKts (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 06:49:48 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CA4C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 03:48:19 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id 42so6043119uar.5
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 03:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8u84R77xjLbHVhX5CnW9Fmk4x7MKQ1b2tChLDRSIXvQ=;
        b=UuSo+yQMgNcoUl3EjZuNhPGd/2Dh/2ebccQddV+HMKkhYZY7b8rvIEEPPpkXQuZrUl
         KyHz/rGyxr0rq+ZLl5n4y6OoyEa/PnR6fIY9id5K1r7kDHklwleXs7eyOioi4YMs0NF6
         avJ91Kcojevi5ScXJut+wQuZeUOCxqP+Ap2GNUsNf0LE4eF1P5sQJsYmkMsLHlS4Lxuf
         ZRfwCF3sWuWcvNv7yg0KebXfXd12k8nrKU8i9gTH34ev1K78SKu/IZXyALz3tk6JChgI
         zOCHBqsp36eYRUsp3CSFiDltduJWFj6hBbRqMSukVFgmgjnHFfYIjAWqzUnnC1lWbp5O
         GAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8u84R77xjLbHVhX5CnW9Fmk4x7MKQ1b2tChLDRSIXvQ=;
        b=qr0/4ZGAi6dHQZKHdWDdkvWZr81YvSL0pyVpMdR5lF9Wp03ifOnKr0+xr1sDCub6f+
         kouFN20EmFdYXKcoI1dNhzkp/kxJ+DHpA6ACEG+PPsh4imoCVzRgweqLD+fNx0M9yIiY
         x6m4wCqQV+LLxxxQft/HYZmeq7oGbYIeFxxRvzn7NRPzMP4+1+RrlxlwpiQ3t2ZrNuCt
         u2vp/Un9GoXNsui0wyVVDdpiWRE9jQkUYX663xGduXyoOe0l6z9uoOq+X7EwJFd0B5T6
         KG3Ef3Cw+jnB6Ln6XrfLgCu3zOr0NPRheWXY/SPYQCbyQCg8ZYDTaWG+PZbzN8lxaCAz
         SQzg==
X-Gm-Message-State: AOAM532+JBXMSZg55fBgNXxQAeoYmRyfeNCmGdcV1TbEAjpHPvTWFM7p
        ufbdB7BKDcNKrqCOGdRqEz9f6EgZBBzFrx1oKgM=
X-Google-Smtp-Source: ABdhPJwuELV7MdFFPHYhjcgoKcxU5z5lM9i3wAfjbTzvcDqKDuHKWqWa9gr0KYO7xfY15nAnRCt0ManrZ25iftFgNZ4=
X-Received: by 2002:ab0:7e85:: with SMTP id j5mr15213271uax.2.1632221299031;
 Tue, 21 Sep 2021 03:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq1r5iaj9j.fsf@gitster.g> <87lf3q9u6b.fsf@evledraar.gmail.com>
 <CAPUEspiBP+4Ac4O5ZRTK0N+8PhHeewksrhL=x8TcswrvnS1JOw@mail.gmail.com> <b0eba1c6-5468-df31-db6f-701bcd24adff@web.de>
In-Reply-To: <b0eba1c6-5468-df31-db6f-701bcd24adff@web.de>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 21 Sep 2021 03:48:08 -0700
Message-ID: <CAPUEsphVKAVvcNvRPBM+8LWRdKq-hmPPSCPx+sAaF1Po7kvxRg@mail.gmail.com>
Subject: Re: cb/pedantic-build-for-developers, POSIX-but-not-C99 and -Wno-pedantic-ms-format
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Wong <e@80x24.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Right, Microsoft doesn't mention it in its printf format documentation
> [1].  The gettext documentation [3] claims that such platforms get
> replacement functions automatically via libintl.h.

Interesting; Microsoft do provide[1] replacement functions (ending in
_p), but a plain printf won't work.

Carlo

[1] https://docs.microsoft.com/en-us/cpp/c-runtime-library/printf-p-positional-parameters?view=msvc-160
