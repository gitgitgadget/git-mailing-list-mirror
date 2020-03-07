Return-Path: <SRS0=zTfj=4Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E816C10F00
	for <git@archiver.kernel.org>; Sat,  7 Mar 2020 12:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024A3206D5
	for <git@archiver.kernel.org>; Sat,  7 Mar 2020 12:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLf86UkB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgCGMQ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Mar 2020 07:16:58 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:34196 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgCGMQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Mar 2020 07:16:58 -0500
Received: by mail-vk1-f195.google.com with SMTP id w67so1370319vkf.1
        for <git@vger.kernel.org>; Sat, 07 Mar 2020 04:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B9GRf4A0YL+gN0WX1EjQ7bWp9JwVoqeGccVap1zQn3g=;
        b=dLf86UkBPGK8xkl2koQPriJT07X2te8LmPvj0vUOGEl58ha/XspqUvTmIc0oEc4bQt
         DsdRCVlSbhh8zqRWkyGkhf6qvriQ7reGhb3fbEGNxMfWtomal0kne3d+dm4yYiKxXkij
         hdrq61vntGnIsenf3nXHst8xS/SrKHqOiLO73+/XhVWDuQOU9/FdUMHOWyirNStoy1SG
         4Broxhy6gj09r3iV8r6dKlNyACKlElnLmjHJFctaiCUU9dGzCxBM83f3TpWtlQdYPG7I
         FMP12w5L2AqMMv/gkrDnZ1PCSUv46xIkqpYQXDLzXbpxYg4QTbrdJ3oJ6Ot+3Yf22CQ3
         7hvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B9GRf4A0YL+gN0WX1EjQ7bWp9JwVoqeGccVap1zQn3g=;
        b=LQvV4HYTc21KSofGo4fPGEcWgRyy19ndLcQGwJMKCHX7K91PtJ4nRytdB22F/bMjc/
         OlVPmAlqhdTpUpqROUbLi11B9E0jnu42Vdh7CPVWwdWO28OxVBntIGQ3R5mEi4wzn5Rb
         tFHz9dLLyf50pRsSPBr499mQywPeBNw/Sz042w37EuqMwBgXbnWatOs7gcji9Qp7df7e
         rXlHcMvQ1lYapTLdhxAqCT8s5WGKOPRi5g//Rz9UZK5536A+ZjcDn4ntByFy+mnnLzSQ
         AKuZpV+w5KeidMEbKFtUTVt7nepXootk4FaXDkIjnfRQaorWPufAmGzRfS2Zs8p/kQzo
         AjpA==
X-Gm-Message-State: ANhLgQ0kmA9bNiqkq83fQRTUyVN6+8Ndwk/8VsGMhodUYAhB/Roa3VY8
        KGcH1TKwa3ioUmTLLMUCpJGqRUdZtK+LE0KTGmWd0g==
X-Google-Smtp-Source: ADFU+vtlkGc68K0B6pTIertAijq0Su+q+mE1URJCDDp9Ej+aDulTl80NY/hchvNaSPLX3S7vlQuTe0TO4/SnLUnzuXI=
X-Received: by 2002:a05:6122:1184:: with SMTP id x4mr4094224vkn.62.1583583417243;
 Sat, 07 Mar 2020 04:16:57 -0800 (PST)
MIME-Version: 1.0
References: <xmqqimjl6pvn.fsf@gitster-ct.c.googlers.com> <CACg5j262bzzwifXXC3tGu-bbNtojKQe-j1=byaAbrSNo=WtWgg@mail.gmail.com>
 <xmqqpnds5c1v.fsf@gitster-ct.c.googlers.com> <CACg5j26uLyyHRx0ouVhUbJ8P20uJgvN4WCqunP5OoXhGyxuadA@mail.gmail.com>
 <xmqqzhct2y91.fsf_-_@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqzhct2y91.fsf_-_@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 7 Mar 2020 13:16:46 +0100
Message-ID: <CAN0heSoa3K87P=mnNPtvjVGza4SPZxK2UzWaXdL9xr-nQpJJjg@mail.gmail.com>
Subject: Re: [PATCH] update how-to-maintain-git
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 6 Mar 2020 at 18:26, Junio C Hamano <gitster@pobox.com> wrote:
>     - An unobvious fix meant for 'maint' is applied to a new
> -     topic branch that is forked from the tip of 'maint'.  The
> -     topic is named as ai/maint-topic.
> +     topic branch that is forked from the tip of 'maint' (or the
> +     oldest and still relevant maintenance branch).  The
> +     topic may named as ai/maint-topic.

s/may/may be/, for example.

Interesting read, thanks for updating!

Martin
