Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74AEC4BA18
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 17:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D7524680
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 17:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="egnrrk+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgBZRQP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:16:15 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37405 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgBZRQP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 12:16:15 -0500
Received: by mail-wm1-f67.google.com with SMTP id a141so56650wme.2
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 09:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h4JbI5sMRjuMSWuBOBobNkLDXHkI2FZ9qWZDc+ay1ts=;
        b=egnrrk+3ZLXfjyaQsc5hM1S1x9L84SniG1uVVsLDcjlDfcgQgXxNdGUeyZhKXfeGe3
         LxPvQqRA7G89xa3UBCvBKCFGgyzXrgd6aq/nvfkYB9k4fVOT3ICZDPiSw1fT9ROM7C7Q
         rv0ms9JryAO91hZkyXhEvg1ZAnAvnO+usW5LVvd1SIzdQYtA5lER4FO+toBSb8mKyJ+2
         gHc2vwZEsw7biwgOuAE+MrrCh88ue2+u7LsIy910tinhDEUh+aOBFpI4/Ug6pvZfD8Fu
         lL+/Ds6kP31CIatmuUsk4YjGNMDgItBWTJEYzcpUmpjNVMZW0s2+yWu2s9DV5BPxDuSO
         FSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h4JbI5sMRjuMSWuBOBobNkLDXHkI2FZ9qWZDc+ay1ts=;
        b=gMOKGUWL/nlV67ziDKLY9E7c7UkQgP28VTaZkSqUITS69YuQhsK2N9LEoGXByDfnRX
         1pC1eN6fNaAkJbZcCp2qrCmagZ/8UVW5SsCg366PcC8Tu5mLA/LlFjEcu33gEq1Clhst
         ulJpi160g7wQPG+eollQV6BscPraYnw3D2OiiGRkl6rRZ6hiIUE5AryFjxyWGdRF+HWr
         xlSUms0lZEeHH1NR55WtW3fiJuBT4fmXHUy9Cr7pWUBcGaulDSKjaOWEFJwABRY6UwZc
         ZU4jMJLp1bV5PTZRGWwbseaFtiOSH5KeuxqbcZkgEsunnOHDaqi+AaDlKk1evGpSDCF7
         zVxQ==
X-Gm-Message-State: APjAAAW2KzfqStES8NedsjDdWdRPiJgbiNZz/xcKxG5Lya1rxDljpCtR
        mB8mz7BCMPvQiEbiqI0m0K1xGmqAeI8+Hz5s/wwDzg==
X-Google-Smtp-Source: APXvYqzmrSxmtTbnnoF5ELJR6JzVZe4mZwSJC/3X4dhRF3dJ1S5OSzwhNJGwKmGsimxD4gIZdiMWtyZ0X3cjB4eJvyA=
X-Received: by 2002:a1c:670a:: with SMTP id b10mr6452748wmc.2.1582737373432;
 Wed, 26 Feb 2020 09:16:13 -0800 (PST)
MIME-Version: 1.0
References: <pull.539.v5.git.1581344060.gitgitgadget@gmail.com>
 <pull.539.v6.git.1582015420.gitgitgadget@gmail.com> <20200221064026.GA11129@google.com>
In-Reply-To: <20200221064026.GA11129@google.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 26 Feb 2020 18:16:01 +0100
Message-ID: <CAFQ2z_P8Ph_f0CbYHYZm0XVyk+ax+Dv_-FrSSyLBkB-xn-uupA@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] Reftable support git-core
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 21, 2020 at 7:40 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
> > This adds the reftable library, and hooks it up as a ref backend.
>
> As promised, here's a patch to include the reftable spec in git.git.
> Please include this in the next iteration of this patch series (or if
> you prefer for it to land separately, that's also fine with me).

I did.

> [...]
> >  * support SHA256 as version 2 of the format.
>
> I'd prefer if we error out for now when someone tries to use reftable
> when the_hash_algo !=3D sha1.  That would buy a bit more time to pin
> down the details of version 2 (e.g., should it only add an object
> format field, or object format and oid size?).

You have convinced me that we should go with the 4-byte identifier.

How about setting version=3D2 and extending the header by 4 bytes (which
hold the 4-byte identifier). The footer would also be increased in
size equivalently. There are no further changes.

BTW, could we document that a reftable consisting of just a footer is
a valid table too?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
