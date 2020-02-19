Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538DDC34047
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 17:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A8B24673
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 17:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Io3hj8j1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgBSRBA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:01:00 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36477 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgBSRBA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 12:01:00 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so1419529wru.3
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 09:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DGrMVCyDGOUNHvxKzsgq3NC9rwAoZyJNqDCXVe2FXzo=;
        b=Io3hj8j1R4maU2N+Qwk0Hpc/FJnkU/m1UxTx9WUv7HLkJUYSTwN2pVaI98DiAt3ziI
         rg72pLusCdqSvftv/gFIpxPbXZwOFpFiehvdO7fjs9tCSIMdWKzOrv55RzPUggVLwFnu
         Z3vMuUzi/nX7MR0gZR9BHxmlJZ473j3H+i4vaEAzBXQH6ffZp2hKagR9C+isLUb7/Xt8
         kqnLGx4x+SEfaioDijk9qKRDbNHfnaSszIJEZt/tGGM/ES63oZ7v1Avdyb6+z4vDUzMv
         qEJcXfpDwVSI2BHfrNTA3BjY4OxKOcsOVQsBIZCdPtHdxe9Ew7rG/PibjcJrSPsHElNN
         B8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DGrMVCyDGOUNHvxKzsgq3NC9rwAoZyJNqDCXVe2FXzo=;
        b=hOsumkaEazgn9OxzO/+jMrXERDpfWx0OKBHr8Fak23ML5oSFtOQfFmVjGbQFUhCb6a
         FFGYo3SGpeyd5fyHeTaWWMFXrwvazY1pkCA2ZlfV337dfNoSsEZ3fPpJwMPxJV7OdvwZ
         H5tqwI6WQ8aDGg/SDH+JFuTzgWK4ezOYhWVG2naUyaQdBLp6iopamnggHIMJCE9wxDiy
         0Ig4evr0O6hm7Tixe6OiJGBb5OQeb9wV8Y/uNffPZLnlZff8gkR2xdXxDCTybnYJZ0oo
         yYsd1GxvjLviT97HrgTZ7sRv0WmXO8cKpQLmvl/kydT8KWCpzyagZ1esCf7DcPXfmBs0
         59tw==
X-Gm-Message-State: APjAAAVV1SMZyA/lq9cWQfzyqQ4YtBZpOSyNPppSC15r/ZhiEf87pE++
        11kQYHUKGLHrs1SsgWJalNOH3B4w3eCdGr3lQXtuA1ddbow=
X-Google-Smtp-Source: APXvYqxRnz++hvWZZsnErdrImWn76EkUWn+OFZX3uW2J9ZyeUQ27Rur4beqw30MBeWAwHmQ/hdts54FXw8H4DoGzM+o=
X-Received: by 2002:adf:edd0:: with SMTP id v16mr36271539wro.310.1582131656539;
 Wed, 19 Feb 2020 09:00:56 -0800 (PST)
MIME-Version: 1.0
References: <pull.539.v5.git.1581344060.gitgitgadget@gmail.com>
 <pull.539.v6.git.1582015420.gitgitgadget@gmail.com> <fe29a9db39922e42929e47a12c816dcb92ba2204.1582015420.git.gitgitgadget@gmail.com>
 <xmqqtv3niosf.fsf@gitster-ct.c.googlers.com> <20200219065533.GA623000@coredump.intra.peff.net>
In-Reply-To: <20200219065533.GA623000@coredump.intra.peff.net>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 19 Feb 2020 18:00:44 +0100
Message-ID: <CAFQ2z_MfZ5_eO3vp4yKH2KBTSg-1ePP8+qvCMRMOjbzpOrHoHw@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] Add reftable library
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 19, 2020 at 7:55 AM Jeff King <peff@peff.net> wrote:
> I wonder how possible it would be to use the Git names for these utility
> functions in the reftable library, and then push the common ones out
> into a compat file within the reftable library. Then we could toss out
> the compat file when importing the library to Git, but it could still
> compile standalone.

I did this for {get,put}_u{64,32} and xstrdup.  For some reason, git
is missing put_u16.

Let me know if there are other functions I should look at.



--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
