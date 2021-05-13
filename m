Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B74C433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 19:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22A4B61406
	for <git@archiver.kernel.org>; Thu, 13 May 2021 19:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhEMTgl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 15:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhEMTgj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 15:36:39 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858C2C061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 12:35:29 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id m124so22354784pgm.13
        for <git@vger.kernel.org>; Thu, 13 May 2021 12:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fVWAJm3mVIszTDct4GJEDb6yogOOmr1B3dAxvCGL3zo=;
        b=ppine/ZyBjJuWMUTaEq9BzLGt297EQxmr5yEyzmK/D4lQr7VAs8jwzBNA4Frqx/XRH
         aACY4IRo3ALHUmHJXViMhNbpbJKv9xX55c0cyRe63s+k8KN/2RGquDX/TzBmJxIcVt8A
         IfHFYb8BhxQL7tLwDoBZz3KnRUrA2K6PApImA2L6Vhq3CTuKOsrLYh/ZtdWONLXVtVxz
         fRARNVGOSq+Bw2Uzn3kBQKJ3bItY+BpxuuwrMKPG6R0dIIJXAXGVgS7YlRdlGfvK7cEH
         nMB5qZbFfTRtztYiYNOQ+96pll3qzzE+6rj8fg6rXLcV6tVlqA/1DNHsypt0RfB8XxUi
         SG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fVWAJm3mVIszTDct4GJEDb6yogOOmr1B3dAxvCGL3zo=;
        b=HwJbq0i2TOpIdvxUWiZI0M6G7W3N+ZQ12s5XKzne+3DjB5aMgtWe5OCQWzQUZvPFic
         2QXPcMGuZo4J3nkTQqwQzu1VzeKbkpfPq1yZhDpfi/8pTxxS0PPktERGxyfO4m78LBTD
         ja+soUEP5P/4qD5OP6Dz10RdaBmW/Uo5CJcj0ITaJVLhK+umhAa5NW6HWRDDzxrhAUdT
         +/HY59txUImf56zWtqBONLBHEtP5zeb2UuuaejKJ7V1TcIZqcFxXJg88IEHyuCvAOqA0
         6ujjXykYR+FC6LyQB32JYw6WW+zBKysJWshAnB5jF8hDDRG8FaxIrm5my0kXul77lsie
         PzsA==
X-Gm-Message-State: AOAM530gRI9UdOsg5nnHcT+mf/EGncqIdGVB1irf/3ToHt6E3PvDt+F8
        oxsuTrC2Kp9M/g7cGslNALrfFRhiDATXck5c+9ix738M
X-Google-Smtp-Source: ABdhPJw78oUE9XYUeOpuWxI3OGJzS+5La4CnO2E8rautf2yrWGZBfvFReSEZu1WI3AGoxinxiWR1zEVhsb61aqWST9g=
X-Received: by 2002:aa7:8ac3:0:b029:28e:df57:991b with SMTP id
 b3-20020aa78ac30000b029028edf57991bmr41744338pfd.38.1620934529063; Thu, 13
 May 2021 12:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1620928059.git.martin.agren@gmail.com> <f2a78267fd0f424c5cfa6969c891597af4d5171f.1620928059.git.martin.agren@gmail.com>
 <CAPig+cSKod_dL7Cm+=T_TPdTxxcV6mz2d+ktm4i1SEUJxQWUqg@mail.gmail.com>
In-Reply-To: <CAPig+cSKod_dL7Cm+=T_TPdTxxcV6mz2d+ktm4i1SEUJxQWUqg@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 13 May 2021 21:35:16 +0200
Message-ID: <CAN0heSo0u9z8yFjWHFQ6rub2xTKy8B5zitjbaQm8o+1-xzaG8g@mail.gmail.com>
Subject: Re: [PATCH 3/6] git-check-ref-format.txt: avoid single quote
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 13 May 2021 at 21:16, Eric Sunshine <sunshine@sunshineco.com> wrote=
:
>
> On Thu, May 13, 2021 at 2:18 PM Martin =C3=85gren <martin.agren@gmail.com=
> wrote:
> > Asciidoctor renders 'git cat-file' with the single quotes. It's somehow
> > tricked by the single quote in "srcref\'s" earler in the paragraph. If
>
> s/earler/earlier/

Oops. Thanks!
