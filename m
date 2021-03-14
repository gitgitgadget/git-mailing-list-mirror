Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342E2C433DB
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 02:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E87EA64EB0
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 02:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhCNCmO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 21:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbhCNCl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 21:41:56 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD688C061574
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 18:41:56 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id u62so15273892oib.6
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 18:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y4NtQVtWchRmWmwokCNv2p5rAr7PWsgq3UKez90Mlvw=;
        b=O6oHn5FT7CO7J+KV1q/j756RcrJMeRSlW88+sSQIJIS23KTpQMeMryv4Ibm/8lcT3H
         zKz5ijMs30hVZD7hUxgbiZqpaalvsdTraoo/37rx7zUclajLmR5X2a79U0UIPsbpoZMZ
         z+xWsAVCH8KHeLcBaqhC7tJBiw/eg31YC4Lf/9EmeueRj7ZrAbHQm+z/NZRCxkVZnFm8
         lb+kkaabfJ6CamF6pKdwWo8oWjbofYsNcLfc5FTDRdrmoSPFae2SlV7+VEYg/pqtVeFw
         iHXsZC8EiKIRKdy1CZrMLh4hNBPMjz6IeZZ/zeaTqyGviszqe5NNYUfvGYKswJ9wfDLD
         nArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y4NtQVtWchRmWmwokCNv2p5rAr7PWsgq3UKez90Mlvw=;
        b=SbcF2+Ondg469JaSF/hBnLcfG34xITejKYG7HMq9n+hl0vpIRpLlIbnFZRwHpUPrtp
         Y28wsM9yf4Tf6xNfy5jV/BJgZP5yG2XrX6nCn4i/l9wMngkJqX8e4eHIw8PH/pk7Klgu
         RargfPwdUmKNsDw2geNbXlZwaX2kTebMng188TQBPTM6IWRfICWyAQ1RQrayEpfVnLqT
         qQtr5QeAkt62vVWciPSnOi4QtJcVHnEkFqy6AUT4Co/X2Aj9Y/am9BpIt18+EIE30MGK
         NSlihpKt1C9zhGiOoi0IhNVmKN3QpNKekiFQiArIMRBDa56i1/MPsjcP7UIqV/qUIB8o
         C0Qw==
X-Gm-Message-State: AOAM533nkqaWurtheHwwD6ffHfWC3IgG8yEJAfTkJijYhtk5owvyHKOk
        HfDc6P64mlasjjmEFZds7CZMtifgXDapHXvXL4s=
X-Google-Smtp-Source: ABdhPJx1OOsYIfrXcFWAPD8FoYnhJYIhoGmhxStpt7O6slGi3hg7EroBzWeKA0ueEGZ+DgBt0aeJb5UwbgV5o5vvkpk=
X-Received: by 2002:aca:4c0f:: with SMTP id z15mr14744834oia.44.1615689716185;
 Sat, 13 Mar 2021 18:41:56 -0800 (PST)
MIME-Version: 1.0
References: <pull.898.v2.git.1615278830804.gitgitgadget@gmail.com>
 <pull.898.v3.git.1615285726482.gitgitgadget@gmail.com> <xmqqpn0456lr.fsf@gitster.g>
 <CAOLTT8QhgeGim6ujqqyXwQ=bmQtJ43T5i3CPmNMPmBr0amR-HQ@mail.gmail.com>
 <xmqqwnua4ozy.fsf@gitster.g> <CAOLTT8TT6rKdF-quS-t3X31PfQcrHPom4Rk5LcrMUBKha78MGg@mail.gmail.com>
 <CAOLTT8RS_FDGEJZ-ogfMf-QJAUEkycju3757uTcQ+Tczub+gqQ@mail.gmail.com>
In-Reply-To: <CAOLTT8RS_FDGEJZ-ogfMf-QJAUEkycju3757uTcQ+Tczub+gqQ@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 14 Mar 2021 10:41:44 +0800
Message-ID: <CAOLTT8TG-NP=W4G5R2GTO+QPdHQ5dL0eLYV7Fof_co4XaCjTxg@mail.gmail.com>
Subject: Re: [PATCH v3] [GSOC][RFC] format-patch: pass --left-only to range-diff
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Taylor Blau <ttaylorr@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Let me refute my own point just now :`--right-only` can not show "B2..T2",
> but "B1..T1", and it may be useful only when user want an inverted "T2...T1".

sorry,
s/B1..T1/B1..T2/
