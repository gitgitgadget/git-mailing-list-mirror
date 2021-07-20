Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418E2C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 21:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B9D560E0B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 21:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhGTUtI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 16:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbhGTUsg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 16:48:36 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943D1C061766
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 14:29:11 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id p22so458565yba.7
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 14:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XWHydfXO2qGxTiAWpITT/sEGm5NWyhPvI52GKjZk1jw=;
        b=h4PncDat49gcpTJKJJJ3mAktU2BqcXO9J1A62iC1n3NmIQwjX0o/uUz37MxUR3lRfM
         wRTCioCRubnq9APvAOD/oKjN1gilm0FYWE7C6r/tueuh61e1j2oLNV5Yy/fjo+1brFsv
         Gn9L3bZYdx8wyqSC/T0a5W3389TLgx0oUZU/2+03F8TwTkQqzS3n3R0CmavmrMEr6/h1
         wU7VGDQCriDj9qXTCbdh7Huc1LsxMstWEoT84gXgQxabHupF7suymvw8/G1kKWGdPiBA
         jdqOm5/Hq0ujQDGli6NMTa7trhJe+FXVFmY5neO7/i2ej7vr6HU34tl9xnkkOwxiTeUW
         a4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XWHydfXO2qGxTiAWpITT/sEGm5NWyhPvI52GKjZk1jw=;
        b=sCEc61mCg2hsZmfq7La/LV6OcJQDUXGG4PVHhE7s6uQWONwq332F6rtdv/qBYC57th
         ydVGujdNs0fPbP8PfQ22pA9D+5JagQzVqX09x/MkH4SRD1sMUBR6LR0y1EdemDjrYeuD
         P/IjkwyFI3Qr/jwW6AOTmMeKMcM6j+Qp6XyDwfKBUhQAdxInvbTXFuo1ak3H4Hag6VjF
         WzYZHTSqWAG7yxQVpzJ+tc7LJCSJFsHvaQXuPlh0HN08nclCBgzZ6VbgMmko18A/x58h
         ZumAGnQW6HO8cCr+1ji3pZhYITtr5tdgX99462GfWcCSCnSbLdY3+FKOCmdDTvPjNAUj
         0f7g==
X-Gm-Message-State: AOAM533OMtTgn40EDyNbsakTCrA6DsR/d6dIiltpjdkMv/qQvYyW2Imj
        RACIncQL0QkM9XuQLcZR683+eObHMCp3rzpqqs8=
X-Google-Smtp-Source: ABdhPJwEJeKFOYS+jw9JFMu6MNxh9f1pk/dyDSbP6Iw9tN2f7+q9+TL26VPdUxwJHsDrnwMnwJxMaZ6RBsZdQRFYS04=
X-Received: by 2002:a5b:403:: with SMTP id m3mr4578680ybp.62.1626816550853;
 Tue, 20 Jul 2021 14:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqzguij8nq.fsf@gitster.g> <20210720211139.3592182-1-jonathantanmy@google.com>
In-Reply-To: <20210720211139.3592182-1-jonathantanmy@google.com>
From:   Phil Hord <phil.hord@gmail.com>
Date:   Tue, 20 Jul 2021 14:28:58 -0700
Message-ID: <CABURp0q=t+4KM8ET57gZavHCAJSZQoVTmPS=n9rdapDczepdsg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] hook: remote-suggested hooks
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
        iankaz@google.com, sandals@crustytoothpaste.net,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 20, 2021 at 2:17 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> Overall, thanks for taking a look. If you have time, I would also
> appreciate comments on the overall idea of this series (the concept of
> remote-suggested hooks in general, the way that the user finds out about
> them, and how the user can make use of them).

I'm curious what happens if we have multiple remotes.  Do we only take
suggestions from `origin`?  If not, what happens when there are
conflicting suggestions from different remotes?
