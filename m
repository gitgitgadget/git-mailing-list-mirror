Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF348C10F1E
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 03:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiLSDEB convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 18 Dec 2022 22:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLSDEA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Dec 2022 22:04:00 -0500
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B096576
        for <git@vger.kernel.org>; Sun, 18 Dec 2022 19:03:58 -0800 (PST)
Received: by mail-pf1-f180.google.com with SMTP id a14so5325851pfa.1
        for <git@vger.kernel.org>; Sun, 18 Dec 2022 19:03:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1zFsE9hr7M1sLV+vOL64ir2BKP0AnWcTFWey0rIbHI=;
        b=ljEprWeknnCKsCaeWpzR3DdiaWiQsSfYR6BYJpnzM1nekj7Z9Tto9emaZ5EAF94v7a
         iLLMsCiX1Fezafz1XKj5HVFV3T72D6AdjtOudBNSsWnKRvi43sutbo31qHjSq773Q7sH
         Jr6IeudJpdQly+iKJO9Byq/7Sbd14wnBJmiu2LInmkYA4vl6e8yP8U0aZA8UKXLOoi0s
         y+FxQqv7afLDdbU40/DdiA6a9VMBAkk/sFh8xvE4fZG8uwiJfgKgMZ8pP9KdARjIshjb
         dVKoBocTYD66UhGN1vZ+7/fQa0XK4Q+xoJTHFT/5nG7iNZ++yjKwMqLqJ6xZJtAmDZKo
         tHYw==
X-Gm-Message-State: AFqh2kpR76bPk8RBO/o5Jnin43RXfUv15yu5LR5oQUG6MEGTBRoAWyLC
        REOhPqPPEnrIOUwuTZMAg9G+/aQ281RgzLSh/ro=
X-Google-Smtp-Source: AMrXdXuSLBKADdmcwAk+d7nXc00LpELzHM1irLtNtq9Tqby8mb97Ze3hXxmhYTnEDY4/uNvw8OqTaMs32px50EIgXqI=
X-Received: by 2002:aa7:9a52:0:b0:57f:a7b9:56af with SMTP id
 x18-20020aa79a52000000b0057fa7b956afmr216015pfj.60.1671419037844; Sun, 18 Dec
 2022 19:03:57 -0800 (PST)
MIME-Version: 1.0
References: <xmqqh6yh3nk4.fsf@gitster.g> <20221215124807.12730-1-tenglong.tl@alibaba-inc.com>
In-Reply-To: <20221215124807.12730-1-tenglong.tl@alibaba-inc.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 18 Dec 2022 22:03:46 -0500
Message-ID: <CAPig+cRcezSp4Rqt1Y9bD-FT6+7b0g9qHfbGRx65AOnw2FQXKg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] notes.c: introduce "--no-blank-line" option
To:     Teng Long <dyroneteng@gmail.com>
Cc:     gitster@pobox.com, avarab@gmail.com, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 15, 2022 at 7:58 AM Teng Long <dyroneteng@gmail.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> > but the point is "blank-line" or "newline" does not say which
> > newline in the resulting notes object you are mucking with.  It is
> > not like in this example:
> > [...]
> > you are removving the blank lines embedded in the body of the
> > message, but from the option name, it is hard to guess that.
>
> Fine, I see. Maybe "insert-starting-newline" or "insert-initial-newline". If we
> could not find a suitable naming for this, it's ok for me to hang up [5/5] (a
> little struggle for me to find a better name for this now in fact (⊙ˍ⊙).),
> because except it, the [4/5] still an active bugfix in my opinion.

Taking a step back, perhaps think of this in terms of "separator". The
default behavior is to insert "\n" as a separator between notes. If
you add a --separator option, then users could supply their own
separator, such as "----\n" or, in your case, "" to suppress the blank
line.
