Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B74C2D0DB
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 19:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C8BB206D4
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 19:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xv9WS2Qz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgA2Tu2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 14:50:28 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34852 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbgA2Tu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 14:50:28 -0500
Received: by mail-wr1-f65.google.com with SMTP id g17so984232wro.2
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 11:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aASxexP9Q0JZcTW/xsrzolqpUOp0m++GtVC1uS/MH9Y=;
        b=Xv9WS2QzgwCorzo0dJais3PWnlFeheuubftgaKIj1sJD227YFXDp20TTGpUMC//6uV
         R7nvAVZdtQUAASpNK60G2LDLp5iqwTLTWEQvP7IXMlC/H2VA3J/UAlWYc4mEDjQqDFuu
         knJI04kiFtcnLx0fbG0uhtYGvdWAvsmRsqp71b1bGrBpXXnCJUmlgv1iqo0NwPKQypX8
         Rc82Vk8IerIO/dWnkRUJOYQDAj5EqlhkdhsgbJhTeNZX6BpvHZ+7UvyFobl5a//cBdOa
         PlLY6Q+9vfoEomeVR3/zvfh2xfsldFjcvkXyLJW16F8TbYixQp1OcoKYwtID0JVpv7yH
         n4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aASxexP9Q0JZcTW/xsrzolqpUOp0m++GtVC1uS/MH9Y=;
        b=GsuyO0/uJ6nblGHdWjmq6vkrOq58BMfEcR4ozMveoSTMBViNntL+Eq6rxwVQeFUS/v
         zmlEXFpU99lbvJLJcv+b0O2sT3U09XfduciBB0r+ZIzE7ubXN8+0q7+bSg345JBHIwKt
         D+nlFJkABh64q6xm2lDxH+0hwvPgTW3a/9Jv6jWQNoJTyMN1raIZX03Y8v1djrWsHO/5
         qgNsVKhXhmIi7iilbUjMzQHDIXmUA5EFQeddcaIPW/M2xN0daK60puK+rX48vRiOr3ma
         pD4hH8eqIzF34XeVeseZT9bQ6vJudwlmv3zqujLWez55ROTahkGFwGjbESxlyhOdmm6h
         mOrw==
X-Gm-Message-State: APjAAAWdx0OAei66CONPciPyuBh7a8LnK1IbEiPikXibSBMD8RAQRBc7
        03on8mDabRodFY1Mzxr+/MBythZpF5nJTzxiBdqvxA==
X-Google-Smtp-Source: APXvYqy8fuvcQ2fixtcjtMCxhK4IcznpHDgWW6NP1oHx4CbK9LOnDFPkvQcekne4dZfIiiy23dkYiHZbNxbpW91RfPI=
X-Received: by 2002:a5d:4d8d:: with SMTP id b13mr526202wru.6.1580327425751;
 Wed, 29 Jan 2020 11:50:25 -0800 (PST)
MIME-Version: 1.0
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
 <9138554.c73hJVQVja@mfick-lnx> <CAFQ2z_NkU6ekZkMqZpcFSEr8M3kfw0tiVCB2doHp3QTZtQ8UNg@mail.gmail.com>
 <2165647.H0RpPiDeFZ@mfick-lnx>
In-Reply-To: <2165647.H0RpPiDeFZ@mfick-lnx>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 29 Jan 2020 20:50:13 +0100
Message-ID: <CAFQ2z_OgGvX3mFLeWSvEqdfxupRuHN_eFgqENaCRHHpO364_xA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] Reftable support for git-core
To:     Martin Fick <mfick@codeaurora.org>
Cc:     Jeff King <peff@peff.net>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 29, 2020 at 8:47 PM Martin Fick <mfick@codeaurora.org> wrote:
>
> On Wednesday, January 29, 2020 7:40:50 PM MST Han-Wen Nienhuys wrote:
> > > Today, some of these sound like shortcuts that are very likely taken =
quite
> > > a bit by cleanup and other maintenance scripts (not necessarily forma=
l
> > > git tools), and the impact of these shortcuts is likely low with the
> > > current model. However, I suspect these tools/scripts could be seriou=
sly
> > > disruptive if we leave the refs dir around when using reftable,
> >
> > Maybe we can leave the refs dir, but have no heads/ directory inside,
> > and make the whole thing read-only?
>
> That might be a good enough safety. I guess the next question would be,  =
would
> it be OK for reftable to ignore and entries under the refs/ dir if they h=
appen
> to appear there somehow?

I propose to ignore refs/ if it is read-only, and fail if it is r/w.
We're not going to look over the files under refs/ . If people
actively try to shoot themselves in the foot, why would we stop them?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
