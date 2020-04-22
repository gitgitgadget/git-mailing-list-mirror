Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F14C54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 15:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41AD82074B
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 15:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YThqQw9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgDVPS5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgDVPS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 11:18:56 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A25C03C1A9
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 08:18:55 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u127so2844009wmg.1
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 08:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ppO1guaOA4D+cTIi5hKLut7C37sq9IpXi4YbZW/CMj8=;
        b=YThqQw9rh1mYbTHNcbeV6otS8SHVSpXipuMIMKCerAqjcOZnBdXkzwn013uayq74hb
         UM5NtHrpf2J+Wx3Cq8mTR2yj1cRRKhQkM4M1grxxm/NO/B604xruNXi7Iq+PyJF6vo6C
         ChOJx8CH8oZZQyLttze84zid5ntQXoa2ZFC+BuzaFeF1gWeQAAvTPIdV2aE3PBfV2PuP
         WM25BiGoCsdlF6PtAMaDS74cUkBayUHmkW+26xMoeTxi9bZ7u0s+I2Hc3T5mFZNEeoDp
         bUBzIASUkxLibEsHCKVgadCKsX6tcCZKebwlx27B2xQVHjLAZnZZip9Sa5vf++U7B4xV
         Dyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ppO1guaOA4D+cTIi5hKLut7C37sq9IpXi4YbZW/CMj8=;
        b=SaAqpVdLy/f2FU9PLz2sBT50MH1T45HD0holqZFp/x7O1vJZQJr55ng6lvGT+w2230
         lQtiwfzg/ym0bY+OUHK4i57sJ9oLOeki7UZWwUnKTGZdGZrCiCJQuTyAOQL1sF65/BEr
         8J2YcimeYJIR5ABkCNXWwl1DO98JyAb691FyJyJica1YUVfN1nJiR8/Pd+cegWJj4Zl+
         q6aAHiIl4+SjzL4wunWUHHgJVaTEp8vMpAgBbE0zCCj2ZUH7UQB9YVm12b8ABpu103nz
         Vy9YCgigTccTQO+zmKq7AIVExFEYXyDw719Ya7Cdsw5V5rhqDC/Yb5PwMkio0Kvm4/Ai
         dImQ==
X-Gm-Message-State: AGi0PuaPmZ4311VjYMv578EAOi/OjPtqNKqtIChVTJ8G0XnADWNsk8fX
        tAtYcmx+FAPoiSZkNsnkljliBcVPlToQK6ZPblfUBQ==
X-Google-Smtp-Source: APiQypLCi7D8fB1yRaATJHwXWeunaCiATR6B3wR09TqwAHVKLPQP2M3JvnXRKU9NSW8qNBw3HEEEVcaEAyNN2kNrXmw=
X-Received: by 2002:a1c:7c07:: with SMTP id x7mr10975428wmc.63.1587568732470;
 Wed, 22 Apr 2020 08:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <gitgitgadget/git/pull/539@github.com> <gitgitgadget/git/pull/539/c615547763@github.com>
 <CAOw_e7azo1Wb9RO=7kH8kXp4RxTzD6SW4a9w_2ifiGxUmt2YKw@mail.gmail.com> <nycvar.QRO.7.76.6.2004221327020.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2004221327020.46@tvgsbejvaqbjf.bet>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 22 Apr 2020 17:18:40 +0200
Message-ID: <CAFQ2z_MCG3pD3i3nAJcvQEKytQdHBO8X9ssmeM=pbypghEvwzQ@mail.gmail.com>
Subject: Re: [gitgitgadget/git] Reftable support git-core (#539)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

x

On Wed, Apr 22, 2020 at 1:27 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> > > Here is the message: <nycvar.QRO.7.76.6.2004101604210.46@tvgsbejvaqbj=
f.bet>
> > >
> > >
> > Thanks for the reference. I'll look into it.
> >
> > Johannes, if you have specific comments about the reftable patch, pleas=
e
> > include me (hanwen@google.com) explicitly on your messages.
>
> Sorry, I forgot. Will try to do better next time.

I fixed all the outstanding issues in the last push to GGG. For the
record, the following caused segfaults:

https://github.com/google/reftable/commit/31078a87067ec9c33f496afb6b478eed6=
e9c3d12
https://github.com/google/reftable/commit/9107ddd6ed73844cb9092dc18ba92091a=
1132a9e

The message about "bad replace ref name" was a missing copy of the
prefix filter.

The C reftable library was based on the code I wrote in Go first, and
I keep both versions in sync, hence the null/zero initialization of
data throughout.

By now I'm an expert on reftable, but not so much about Git's test
infrastructure, and unfortunately, I lack the time to become an expert
without your guidance, so please give specific feedback.

The most pressing thing right now is that the windows port on GGG says

 ++ git tag file
 fatal: reftable: transaction failure general error

which suggests that renames don't work like I think they do on windows.

> Ciao,
> Dscho

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
