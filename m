Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B78CC433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 11:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 623AC22D04
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 11:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qg+k3PW+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbgHELWs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 07:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgHEKsp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 06:48:45 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F1FC0617A5
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 03:48:36 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id y8so16117830vsq.8
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 03:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CV2FiBpwKamKgF+/xAozX/tjAn/5tsp9m2zQ9YFGaFU=;
        b=Qg+k3PW+JLHugz4vA9LaLjl7Kqrpj39yOxnRErWjPb/h26nIRqAJ5gb285p9QBW9va
         0maf+kAA6h+8h17ikpa612CjFFeT0l53Puf2/Re1+qgopJ0L8UaKVS6aQetCZi5byZHD
         oRx+J1F/YJBVChtwxNrR4CgJ5J23Re2jTk43SC2kgfBE7UQoja02R+EJHwfpnozz6Wm0
         x3lJAeYum1OU5bEFYUbSTd5S/W6l4CD+hqCJvBDy5TvTNwo2OHyml36TJyhXexDXmcNN
         Qk/Lew7UzZQa2vC7X3ZMImBY/qYwx11N335e70PAa8u5d0YnCPvin3Icy4NT3LDYwJTV
         XgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CV2FiBpwKamKgF+/xAozX/tjAn/5tsp9m2zQ9YFGaFU=;
        b=bcxofU5KMVMTxDpPieYG25M3+WgCbBuzWJTN+yYYh2A6NXbfSXosCLgC2YtDR1CTz8
         gQONnr+mgAqABiD2fbv44IF5J2s0T3O273kOnw/qqv5qyVjKFsAlig5SBFoqKGOTRc3/
         lzLgB8udibqFa/caUb2Tuc53e1dZdWY3doubccmZTdfM15l+JlqFMTVh7itMtchEAMgZ
         JxJiGAIqWkizZq6iOpsbSIwKBiIVbXJm3j+1osQ1zHssVAhX0IEa8cxEqBKOrvuaxns5
         Y447IB8dxdzhddqZZB0wbxOWrY43tC5y1IY1qGTaHPikd7aVIVCq1qxk+RB1JLJYqxOs
         bMfg==
X-Gm-Message-State: AOAM533z6x3M4dI+BAtgL/Krdi0BoIBnntwzfuG6Gq4ZhwKAT76WlViG
        /adeWULE3d3if91qgUrsMp5QVCUeDv1waUmSDSR7+A==
X-Google-Smtp-Source: ABdhPJz7HD/iw+ejzuXkBU13dHvsXsbGjPKk22fU9hTqxJGjns56YSo0uiF4gvXMAnsPxXKTJd5wwhkz5JQXpjVbqeM=
X-Received: by 2002:a67:bc1:: with SMTP id 184mr1272482vsl.104.1596624512715;
 Wed, 05 Aug 2020 03:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.673.v2.git.1594329108.gitgitgadget@gmail.com>
 <pull.673.v3.git.1594925141.gitgitgadget@gmail.com> <xmqqwo33f6xb.fsf@gitster.c.googlers.com>
 <CAFQ2z_P+L5ystTA8MjSjnUJQyEoH5Q3QtnMd0ezJpKPv_ntrgA@mail.gmail.com>
 <xmqqpn8hgca7.fsf@gitster.c.googlers.com> <CAFQ2z_O1sRm-_SNP=-GvgNLqB+qgf6k9YVfbF1XCAmFWdeX6Ew@mail.gmail.com>
 <xmqqh7tjv6hb.fsf@gitster.c.googlers.com> <xmqq1rklrhle.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq1rklrhle.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 5 Aug 2020 12:48:21 +0200
Message-ID: <CAFQ2z_NU4=WcUDvVY9PNs+p-WU4u5=QY+=DHonGyK29numhWoQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Remove special casing for PSEUDOREF updates
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 5, 2020 at 3:45 AM Junio C Hamano <gitster@pobox.com> wrote:
> > I'd think all .git/${SOMETHING}_HEAD are of transitory nature that
> > can be left as simple on-disk files that are read (and preferrably
> > written---except for FETCH_HEAD for obvious reasons) as if they are
> > loose refs handled by files backend.
>
> Sorry for flipping and flopping.  The above goes directly against
> the spirit of 09743417 (Modify pseudo refs through ref backend
> storage, 2020-07-27).  I still think .git/${SOMETHING}_HEAD except
> for FETCH_HEAD should be written and read via the ref subsystem, but
> I was wrong to say that it should always be done via the files
> backend.  There is no reason to insist on the use of files backend
> here.

Yes, that confused me. Thanks for setting that straight.

> > If the octopus merge does not finish correctly (e.g. due to
> > conflicts), with "git reset --hard", we can recover to the original
> > state and re-attempt the opeation with "git merge FETCH_HEAD".  Such
> > a merge using FETCH_HEAD will produce an octopus merge.
> >
> > Which means that at least "git merge", FETCH_HEAD is not just a
> > regular ref where you can ask what object it points at and it gives
> > you a single object name back.
> >
> > But to other commands like "git log master..FETCH_HEAD", it acts as
> > if there is only one object recorded.
>
> All of which means FETCH_HEAD is special and we may not want to
> burden the special casing of it to newer backends.

Can you confirm that FETCH_HEAD is the only thing that can store more
than just a symref / SHA1 ? Based on the name, and a comment in the
JGit source, I thought that MERGE_HEAD might contain more than one
SHA1 at a time.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
