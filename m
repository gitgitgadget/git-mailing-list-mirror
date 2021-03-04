Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9524FC433E6
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 09:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6847764F20
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 09:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237088AbhCDJCx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 04:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237090AbhCDJCo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 04:02:44 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F21C061574
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 01:02:04 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id x10so6418255oor.3
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 01:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oR1oNrUjbVdZhjBSaH3iZm7Fb/n6MJtNXvMy7AmvhLQ=;
        b=P3yR072dlS6wbvEuzBR99DOsuFfrrGcpv8Qz5wrLjss+YhEqJQOsoz3bgE8iw00s54
         L7O7EWgBiJMIYzLQS13OlpJqcBrvJfEDtJ45jbp/wquYg+9VbsuMclAdY/3Sz8TvUrQ5
         DE9NYlrjaaly0J4GaEPJIRZqXEUeKP1/tkMq0l60tBboLtSvcUDYeir9HVd70nyE1rVR
         u0QPdKGkmn436C3GXFfQ02TuENjvtzG4X+cD3FNF6bf3CSBJ9EG+KCuUaxVbgazo08pn
         EisWGSV9aGBDEX28z+fc6UuE4bqwtZWVNgTSUAHZ23KG3YA0ry6Zt2iSTWRE/wt2psHd
         gXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oR1oNrUjbVdZhjBSaH3iZm7Fb/n6MJtNXvMy7AmvhLQ=;
        b=merKUkH7XlI4YelhEsgH4uZK3yBM5zH7/ZnQjrTFREBbEIaNc0oGm0j9S1rUidZMuq
         CamE+x1tS0G/0oi/C+e8XK8iOkNpSHBGoMKawfxQROLzRVC+7CRWtKtJwFqrj/fCmkGT
         2LDdlrNR5KRZ7Zyu+kgFSsdkhznb1Q4vuJ8O6PHZPPBPZg25axFSDOJPQmqhNv1V1hXN
         tng6MGAKvAhygKfThUpmAKnnft8XiLuqW2eYyX6JsTP0G3/MBxP/dqPb0hneVfAu195J
         UWyJG8UP8uty2HM/VKOpx/lcWH3Qo7aLlsoue9t4LBg8CjMS8tC6vvOm23ARwdoNVU3/
         f+yQ==
X-Gm-Message-State: AOAM530j3k0EuqCV4lLo0Eoc4WGsw1t27JyFpfNnfQYw5lW91Ow9UT04
        N55m1YGtE/V+kDjeSDLIBnF7Xfu2JxETrAnkqSc=
X-Google-Smtp-Source: ABdhPJx6KgeIbZcR2Q6It3TOddFLfMKtS1CALCSAPU27bMiLGT8/Wnirhb0J2M4gsnE+TMNfigpjXD4Z8QjK4a+0nPI=
X-Received: by 2002:a4a:e70a:: with SMTP id y10mr2558257oou.75.1614848523649;
 Thu, 04 Mar 2021 01:02:03 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210301084512.27170-3-charvi077@gmail.com>
 <CAPig+cQAG3p6rhGHzBNGPUxMXQbbLZgiw-uUpizNiEWY9wm-3A@mail.gmail.com>
 <xmqqlfb6mrnx.fsf@gitster.c.googlers.com> <CAPSFM5fmK_3rFfTbD7o3qCcYYeMXoX7K-HhGorXDPcFseBEDzQ@mail.gmail.com>
 <CAPig+cQcjUzXpW1OBCiEC3Sr13uyeesqK49KWmgnY1iHNnS2Rw@mail.gmail.com> <xmqqh7lrg2g0.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqh7lrg2g0.fsf@gitster.c.googlers.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Thu, 4 Mar 2021 14:31:52 +0530
Message-ID: <CAPSFM5dXDdi9_RF7nK+JTgPUUfvY4j3AMuWVoqaY=3yhCBwyWA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] commit: add amend suboption to --fixup to create
 amend! commit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 4 Mar 2021 at 06:28, Junio C Hamano <gitster@pobox.com> wrote:
>
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
> > Hmm, I see. I didn't follow whatever discussion led to the decision to
> > use this sort of prefix matching, but I have to wonder if it is a good
> > idea.
>
> Meaning --fixup=a:<commit> and --fixup=amend:<commit> do the same
> thing, until somebody invents --fixup=another:<commit> and makes the
> prefix 'a' no longer unique?  I tend to agree that, especially with
> command line completion support with modern shells, such a prefix
> matching would not be necessary.
>

Okay, so for now I think (as suggested), let's remove it and directly
use "!strcmp()" only instead of "starts_with()". I agree that if we
keep prefix matching or not, it will not matter much.

Thanks and Regards,
Charvi
