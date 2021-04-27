Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B29C433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 09:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB077613B2
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 09:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbhD0JQP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 05:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbhD0JQN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 05:16:13 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705AEC061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 02:15:28 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id z4so1477366vsp.10
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 02:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g/xK56lh0JF0ETaIElpl1bahqLSs8bcEAFnM5RFswD8=;
        b=UtN2p1K5OpTZ/SFo/tDmkzZBp+95Z6W7LOejZYWIkPzLpfGzykG1pMmp5GoWumsRdw
         7kpr+Dz2+xvW6WGMudV5i1t8KXfHDYakuygtuWmnw+x7cFAzLtFovZWjlHdMPbjoN+uC
         fRf3diF3EXi0DjTtxpyFlmBSL0bS73GSyWT7qTO7w6a6ouSyNAtfPjaCF8GyTp/A5D7G
         XPvuUL9ogxMj6m/iChOdvIbo4G+pm9rk/05ySE0MHwhjUBgaQeF00BgPlnHJoyfEkNy+
         2IG/XLrxFAqiZmsv0RE5qG8sN4LihyZzGsqwvyW4OLUL4Umq9H6eQlo/XXwKxD5qO0lq
         JOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g/xK56lh0JF0ETaIElpl1bahqLSs8bcEAFnM5RFswD8=;
        b=qTPE9zfizkDX/4BYUhDwU3bS3z1iDEqq9oVWmadSz18TqrvYVuigtT8tJrGhkqTcNX
         1tiZ2brMzPNO/3BSBOilRCCRQexptidg9+O2Ch+YhqV3bCD5iAHSDaxKXeYjKP3yLkSY
         Djs9snhTPISR0orsx1e8u1+KpbzH1Ev/tc446FcPf65K69fmsGVmM8Io/EiUK2TB4fyL
         SXhi2TPTtIUrQtxxkZ0kYpH1jHeGAe+Bz+hh63VDLZ7BvV8nb/JMIawPbiJowrg7xXJa
         c6MtpZHWOWKET1hTd8pikbybeMsPIpeqCWNpDCJ7xMSpoWowmDy8zufW+MAgytcZ86Ym
         HUEA==
X-Gm-Message-State: AOAM5300Qs3W7HBFfkn/lslR2PLPBqEiN5AXeRn95JUGgtxHW6qAPlH+
        c4VfvyflUm2NwvlIdgs1NFoe9jeSOGQw2+GnZanlzg==
X-Google-Smtp-Source: ABdhPJwsBztD9jB8UFgW3fu9X8JZKTtIISj+JACwCJVsLqvAArmgF39HR4P72sKiiG6zRhVHRz61f5JOl/F1y/qwYKs=
X-Received: by 2002:a67:7d42:: with SMTP id y63mr17373476vsc.5.1619514927521;
 Tue, 27 Apr 2021 02:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <223583594c0089ef259e83f2f10c08fd94f55959.1618829583.git.gitgitgadget@gmail.com>
 <xmqqfszk36z8.fsf@gitster.g>
In-Reply-To: <xmqqfszk36z8.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 27 Apr 2021 11:15:16 +0200
Message-ID: <CAFQ2z_MugeKxFbbLAoV1Ax3sQZRpkesvUk4zUYwivbcrE2od6g@mail.gmail.com>
Subject: Re: [PATCH 05/18] t1413: use tar to save and restore entire .git directory
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 12:51 AM Junio C Hamano <gitster@pobox.com> wrote:

> > +     rm -rf .git && tar -xf .git-saved.tar
>
> Unlike GNUism longer option names like "tar --extract", you do not
> need a single dash when you ask "tar xf" (see our Makefile).
>
> Looking at t/t5000-tar-tree.sh, we seem to be supposed to use "$TAR"
> (with double quotes) to name the tar utility, so that people can say
> TAR=3Dgtar on certain platforms.  I suspect that there already are a
> few existing violations but let's not make it worse.

Done.



--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
