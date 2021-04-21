Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2D2C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 09:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 976F061440
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 09:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238504AbhDUJoE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 05:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238011AbhDUJoD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 05:44:03 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16B7C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 02:43:30 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id b8so4384870vsu.8
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 02:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=dAgdkez25oWOgmE1EECL9Xtngh9R11pi4ixvUfXZPpw=;
        b=iD0+WNpGtsyDvT8jvslG86vwYC0y3IT1kLpLfdG906qcjzooLG56Ng+A9IAC/qP0VL
         h789DF380zzclKY6KCyk5cX0MaZnuva9MMZa7IiA55ErK+mYRppqjZ8XDX5BUSUPCUUq
         g/fKwbxnKd22n0V42HuJA7+t9ePREwPxQlQUgLyBMd3HdLoLO4ISo0NeXfLuofVMwoCT
         UQuPqED/faiMMeEVOdxxf/C5ygeCshQImzJ9yrJGha8VIQsB54ObbfAVbooYZO+zUq1A
         cXUbTd/7NytwxpTA868UUfySQNPrureUKN6jnCtCOrf5ldXTak1jmJv+7PdeZJcku9on
         jZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=dAgdkez25oWOgmE1EECL9Xtngh9R11pi4ixvUfXZPpw=;
        b=AvJltSpwjGXPlJgO4l6x1MfKy5d+Uhyx3RKg1yzwkG4RHtuz7eh4Q2KXkafoPsk1jb
         9EkhNFNYbgDE/KHTQVNweUv/nxZhyXvmAqNXoQrwtQvp9kR7MpYRQYiOSfSPOSLs4FO+
         yfBTGgSxKVXYXSxpnzBnFlnE0AeuMIxWVupsJATPohD2maXJl5ifAwwh8CZh3xvUwfrk
         SA2RDF10WpEAM8p7qoGi6JLUq3ZIDqkzKlnH3aLGKLP7ZflJXxfvqGccf8AFV6RF1cD0
         Odk2BcI7IOI49YtVwoMYBq9Pvs44Sl0eWS4Bvr3JGkencXpRdEX8oXmcSTylB73pDLKi
         d6vw==
X-Gm-Message-State: AOAM53067/w6ZMuW5bWiaqGm7OpevDHR1c2F0Dw3nG66eT2t6q531rGp
        cws6xrSVTl+zwUUaX9ADoicOXB4deGtOj6/XydonoA==
X-Google-Smtp-Source: ABdhPJxoRfsbE8F+L221nIVTxjcm2Nd6y1KxjmKRswIMpOmPL/6PFdkmhxnTNR0glb3kNJ3iyk88Jh1Cz51xDlglQtU=
X-Received: by 2002:a05:6102:20cc:: with SMTP id i12mr10951546vsr.12.1618998209667;
 Wed, 21 Apr 2021 02:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
 <pull.847.v7.git.git.1618832276.gitgitgadget@gmail.com> <f0216ae20b6988514bdb60d8fff96e18c2ce9f1d.1618832277.git.gitgitgadget@gmail.com>
 <xmqqlf9c68iy.fsf@gitster.g> <YH96CcJhZt4CTPWD@camp.crustytoothpaste.net>
In-Reply-To: <YH96CcJhZt4CTPWD@camp.crustytoothpaste.net>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 21 Apr 2021 11:43:18 +0200
Message-ID: <CAFQ2z_NAQ02y1gaTymzi21aHxh+bswvr6ko_Eg=1uuHds4mGyg@mail.gmail.com>
Subject: Re: [PATCH v7 04/28] hash.h: provide constants for the hash IDs
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 3:04 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> > I agree that it makes sense to have symbolic constants defined in
> > this file.  These are values that fit in the ".format_id" member of
> > "struct git_hash_algo", and it is preferrable to make sure that the
> > names align (if I were designing in void, I would have called the
> > member "algo_id" and made the constants GIT_(SHA1|SHA256)_ALGO_ID).
> >
> > Brian?  What's your preference ("I am fine to store HASH_ID in the
> > '.format_id' member" is perfectly an acceptable answer).
>
> I slightly prefer FORMAT_ID because it's consistent (and for that reason
> only), but if HASH_ID is more convenient, that's fine; I don't have a
> strong opinion at all.  Definitely don't reroll the series because of my
> slight preference.  Either way, I think these are fine things to have as
> constants, and I appreciate you hoisting the comments here.

Either way is fine for me. I can paint the bikeshed in your favorite color =
:)

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
