Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8084EC433DB
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 08:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40EAD21BE5
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 08:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgL3IV0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 03:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgL3IV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 03:21:26 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD05C061799
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 00:20:45 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id g20so21059881ejb.1
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 00:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xPFu3nhJzpvZHN19SF4Esmtpl0DFK/EgWotL6uas3uo=;
        b=uWe0Gl1VKx3IL8nV7tFjNx/WHPet58YeqhAv4iM2qPp/ttjlB5nDG7XC1AFKGoyKKI
         IP/7Y9PixPRwgVjQDSySl6uDSK5G+cSG/OJ8kpgF4LqhrrqvbFmcQ77DyS2oeL6gI2rv
         49Sys0SIKt7MLnlvDR0qsCHWMhcciKXj6fWXkvt7qE9gXQgnCsPKPVeT5bXBYtoh8VXb
         FZC8UAfiX+IJsbO79mpmQM6B020Sc6CBJh6dxpdDTTZUvapyJVGjjKxWq294wB0SOiR/
         AomGWaAZWWgadNW9+dFprxuvagw6YYgVBjoFBQY2QmJMFQibnZn6yF7yrO8xpvYcy9rK
         ICFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xPFu3nhJzpvZHN19SF4Esmtpl0DFK/EgWotL6uas3uo=;
        b=UyjxVHXXehRDsEb+KEV+WIUtEVx813uAbAGFcz1nieefvQhP2piTgsTHZbgO90J5BI
         boR44TWEt6+Fb1Z/mcN0vDn5rXgK0FpZvWBa0cS+ZAL9x3ECjfJiyXtfBsV9yBfnpiiN
         iMEIvqEBWZcg5MPccpPN68hobOAuT1nKG002YvvtJHJHrFiZcbPjYUn5TWNz54O8Rp7y
         sPRTxOROVo9PmUuk2LrwgCgVS5RYWqYqks0WLXnRa5dhHJCxBje/dZF0AUcmCGCcJaxp
         DsKCXf1MNm9gRC9FOzdf0CJvtt+2kF3dcNeZvkaYn8Y5qAq39Z74HidxflGQqemKZqNF
         DLIg==
X-Gm-Message-State: AOAM530tbuHawzp6hrbJ2lrbCNJ79G2BsWPs8n8JYm7/dVMh87zi3Ui7
        AU5GtrGfiJo70nH5QFMdcHoT1phI2ffHFBQ2ScIlG8koak/NjQ==
X-Google-Smtp-Source: ABdhPJywPLwqXM2VUlcY8q2b39xrEhg3jhy4eoMwqjTAgvohA6RrRM/UT1VxK051QZSqui8OszKyDv7F7C2hSb27Eqg=
X-Received: by 2002:a17:906:e212:: with SMTP id gf18mr49489787ejb.551.1609316444571;
 Wed, 30 Dec 2020 00:20:44 -0800 (PST)
MIME-Version: 1.0
References: <xmqq5z4mjdbq.fsf@gitster.c.googlers.com> <20201228171734.30038-3-avarab@gmail.com>
 <xmqqmtxxedwd.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqmtxxedwd.fsf@gitster.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 30 Dec 2020 09:20:33 +0100
Message-ID: <CAP8UFD18jKOfK1EscCEj7Gfxpfo4s+zNYDFofoyGYM4eTedn5g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] CoC: update to version 2.0 + local changes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 29, 2020 at 2:33 AM Junio C Hamano <gitster@pobox.com> wrote:

> Sign-off plus acks need to be collected here.

Acked-by: Christian Couder <chriscool@tuxfamily.org>

(with or without Junio's suggested changes).

Thanks!
