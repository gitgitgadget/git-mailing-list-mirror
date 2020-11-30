Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC35C64E8A
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 11:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC12220679
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 11:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BfU+fy/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgK3L2S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 06:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgK3L2S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 06:28:18 -0500
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D4DC0613D2
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 03:27:38 -0800 (PST)
Received: by mail-ua1-x943.google.com with SMTP id q4so3622141ual.8
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 03:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5zqqVBARXZrC4gM7hC1mSv+oaNMKyHyfHVjidDqRPXI=;
        b=BfU+fy/RzsN+8dDISW/YLbp2N8M4HSrhJghUCA2AwkSDFnXEl+0l6Sj7WvoM4jsMSS
         Fx/ffGXxfpn43m7QKUXSHEoz+oki4dZS/3sNgL5+JXw+bdRrq5Haifn8pRCAeAuHth1L
         4RmjUxf+85Q+CdmftAd/GrtA5jqKqDisGDLkRWsMof/XdC64vNLXk4Ud9C/3KpFeMhwT
         ZlSRTp6500l6V+FSDD+k+er3KyLmVp/B0MwwuyPF8Fk9G+KWSD+gi32Gqbu0QaSi+/vw
         +puzJQzBS3BxatJmOjtntdm70dxQq3qnBMb/QeHzHq3Kdfjr8sBWtkDrkb/cVHxjcYdi
         J0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5zqqVBARXZrC4gM7hC1mSv+oaNMKyHyfHVjidDqRPXI=;
        b=s8+yFR0bdzUBE0ANDddDIDzSZOQMpQTEoygYwaIRrKQFpz3kh+OcUNclSkWMixBHB5
         atxD1sqhhNi7GdA6nWaUeGfX/22/RNztF6fDg6MyXPh+H8DJguOgbRmrhLJ8sL7zyt6g
         8isra0+GCZqNbY1Y2vwYlHkvwxFskCWPH0Sxa7P4up1L8g6lmoCSTgDs9NZLLZpyVdxP
         wqXFesOBDAJ3qJrFQLxV1rxxRFZ4KJX56PSouVQHyDrazzoYN6CDWFAsEwt1Ai7M14ng
         9b7+5ShLxPimsKNXVgu+/xNkJ9casI/hWbSiPkYiE32KmmABrOKKaRidGfcMtVeggWks
         Pfxg==
X-Gm-Message-State: AOAM5325o1tdHDaR6gUaMksoncOxerbOwyHVFZrazt8eiias79CwyS8x
        nlD+K2CVSH3S2lL3l0YGUNWYXvkP1qn4/9EDMF2nJw==
X-Google-Smtp-Source: ABdhPJy7AMpw/65P22VDtymMEjW5ocFwTMbATGRlpmJzH4LDlKbTL3HQ2jKrqBJ/5B2KnvPkvEocTB7wuAxS6CU9oD8=
X-Received: by 2002:ab0:76c6:: with SMTP id w6mr12866480uaq.85.1606735657015;
 Mon, 30 Nov 2020 03:27:37 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
 <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com> <2aa30f536fb7ce5501d1ecf0315cbcb1c1c5ce38.1606419752.git.gitgitgadget@gmail.com>
 <87im9rnlji.fsf@evledraar.gmail.com>
In-Reply-To: <87im9rnlji.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 30 Nov 2020 12:27:25 +0100
Message-ID: <CAFQ2z_PWM3zTYEQ9r-Ky_NwFk_KdtZMvx2s-kLyzuos==A7iMw@mail.gmail.com>
Subject: Re: [PATCH v3 04/16] reftable: add error related functionality
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 27, 2020 at 11:25 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Not for this series, but I wonder if the eventual integration into the
> i18n framework in git needs some thought, seems all the (including
> presumably stuff show to users) UI strings are hardcoded English at the
> moment.

AFAIK, these are the only strings that potentially show up in the UI.

If these strings need to be i18n'd.  It is probably easier for
git-core to provide its own version of reftable_error_str() ?  Or we
could remove reftable_error_str from the official API?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
