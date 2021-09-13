Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942FCC433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 07:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E7F461004
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 07:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237524AbhIMHPU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 03:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbhIMHPT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 03:15:19 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753BCC061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 00:14:04 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id o124so7505404vsc.6
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 00:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XoPBbTYOgVYpKQZglVefUQwpWB/Vc2+SIe6VlyoVSqw=;
        b=FZ6pUyVh8uVb+/Wx3Pl+efTMjBvI6dtqO+E2KH570pa47rufVSXGmenwZmGWahYTy9
         mjLsP7hmjXgEympHnJG3fI+qcfDFuJWGN5diXrmR9mP5WN0H3itVoRJndN5EAuEa4qPg
         vzwilT7/fzunTDbBSbdcItFLkKP5GrdV08hPFk9A9wS8yMqsuI0aVMQwCXqFFaLkl+8A
         PWVTx6t7gFHjTrHA/34AGlWIi0y/koAmXgTSWgUDeUTM3j7ur4gVep2KW2l6f/ZzzHmK
         k/nyxZNeVM5wbLzewBw6xbeaIli+DOc2VzjW9U+tqvPMdPCN9LhotT09HxEuaxShRZzk
         6aCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XoPBbTYOgVYpKQZglVefUQwpWB/Vc2+SIe6VlyoVSqw=;
        b=npcxyTTb+WtnMP/gGYWKlrQbmWR4vGNhToGZ8GCfUBKdmh67vrRQowc+ZXHC9mblFj
         iVSqdG/uB12k/wYbU3Is4TTFEoPJBgkUSA/FLVM4cCHA5mjyiB3pTBgX6kfA9yzKw9qV
         a6NhVN7/GBaziibFFDXkTFwkUsSgLbK6606xPntEAmfJ9KJeLX4+QkW50fdO5sRBfYDC
         2Vnxyj982xKAM3MlTNdQWRZOCowos+wrsCmHUteZpcCM2R/bIrrFK6AUAK7Zx+YAnLWU
         y9d8qrNRiQDmOfy6O5btpT1dyHVJj7vzAToW7lgpnZujMpI5nQUT/wBY9MipMPfwqpZ3
         nRWg==
X-Gm-Message-State: AOAM532O4nV4sQfoWwF/GyfPWEq+69JYeSrwNbdcQrefcLfVNLh24go4
        ZOGMUfbUSCVNMur4OSaGT/0WHniKlUNqP0HHReqG7iEW
X-Google-Smtp-Source: ABdhPJxiE1v03diNBUkAc5gZp6KyGrtLBaVTppDHznFh72xKws2Do3VhI6C69jtETIGvTiPwaTG4SQnV0ZN/v72oc/4=
X-Received: by 2002:a67:ef48:: with SMTP id k8mr3728984vsr.57.1631517243509;
 Mon, 13 Sep 2021 00:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210912202830.25720-1-carenas@gmail.com> <20210912202830.25720-2-carenas@gmail.com>
 <0606160d-1192-2074-b1ad-9c5d86c953d5@gmail.com>
In-Reply-To: <0606160d-1192-2074-b1ad-9c5d86c953d5@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 13 Sep 2021 00:13:50 -0700
Message-ID: <CAPUEspi1NzM34whXOT8T7NgJ1SCBGTPETcF0MY-UHz+kRqCTZQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] t0301: fixes for windows compatibility
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, lehmacdj@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 12, 2021 at 10:34 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote=
:
> On 13/09/21 03.28, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> > test -S is not able to detect that a file is a socket, so use
> > test -f instead.
>
> Isn't test -f just check for socket as regular file?

and that is exactly how they look; ironically a -f check in Linux
fails for sockets so maybe better to do -e?

an empty file with nothing that indicates in Windows Explorer or a
stat call (from WSL or git bash), that they are anything else.

Carlo
