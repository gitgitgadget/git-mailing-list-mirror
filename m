Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A88CC3B186
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 16:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB4C20708
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 16:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aRiAX+9N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbgBKQqU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 11:46:20 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38830 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbgBKQqU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 11:46:20 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so13232982wrh.5
        for <git@vger.kernel.org>; Tue, 11 Feb 2020 08:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gBrTaPx8gfy3MuOa8q5hAytslwI9ZgRrObILcs8HjDM=;
        b=aRiAX+9NVhY8bbZFksnoLnXIWvpJPtl+OnGwAUIFeB3dIqB+cmN0T58zlogdOm3kOk
         Cfs8CXkXbAgpy+7hefm7Wam6u+j6x57f3hPupSQteW5JVfBifAEFYWgSbJN3kwsqDxLA
         NlyS8LcRySaSCnUHO/4IcCJiDwX7UbJr14kcp8lE/lb071Zzk9oHF/UE6+S7tqfcnMnU
         I/V+bAqKVwJlYSdD1Zbx28V4XCx+0XfaftTTqjOcjXPMzeWoc+nhEyk6oY3NHZaga9fF
         r5VpKahHaA/OoYxaung0OpQLCR4kJQUKuuLfDqTdhz9S5nVL1Sjt9Ooh0Hk+uZzV99Pw
         8qlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gBrTaPx8gfy3MuOa8q5hAytslwI9ZgRrObILcs8HjDM=;
        b=lSDAEX7VRE+zZn7EusGHAROBGbQm5nor9Kbwe9J0GKETKTtt8gQCJC8JUdoqaaQKjt
         JrRcjZUFrxBNWH3Ztm+Ta94GbzJTLy0j8ViQ58507uFx8KzPFhKm4RcQHaPv4LN8iqmq
         tXmY5rX1KLjgfivllWwMmNYmqjFPrrEOuow1fGZaWZdCBg5hiQOJzRtNDgp/lxF9YKaH
         uSU+coNjgrQfe9qfHpP3j39Gr/P4po9qum5c9VAFXvdWHDVY9sCU8wKaJImdFX3XJdgU
         Q0qW6Vmi7eYi9HDBhrssSgsS2R9H/OVqZHuSBtv4/n419hmHmx1oGyIsny4VM/kDoU4M
         YjLg==
X-Gm-Message-State: APjAAAWaO/DftSCmX5BCgGyLO3ZLCCrt9400I6NXL/HPJVlNhTwZ6Z16
        enBeTVPNvnkrQuCrxXjEZEkxRPiCObXkXbwSVOr2UdlK
X-Google-Smtp-Source: APXvYqxC4Mh2fJfjBoK4ED+khakaOWCYdJH1zTHftP+BI91s0i2XUBXFLEd6ZQiTNAK6qsDNFk/E0MOfardQpEVgJbY=
X-Received: by 2002:adf:e746:: with SMTP id c6mr8885641wrn.323.1581439577672;
 Tue, 11 Feb 2020 08:46:17 -0800 (PST)
MIME-Version: 1.0
References: <pull.539.v3.git.1580848060.gitgitgadget@gmail.com>
 <pull.539.v4.git.1581029756.gitgitgadget@gmail.com> <02d2ca8b878a67a3334b222725645dd035b4289c.1581029756.git.gitgitgadget@gmail.com>
 <20200207001612.GF6573@camp.crustytoothpaste.net> <CAFQ2z_P+sdd5+46Ov_CO8ae4j_3aA4ahdVR5D_K1qKSQ-q+OcQ@mail.gmail.com>
 <20200211000520.GA6454@camp.crustytoothpaste.net> <CAFQ2z_N1sYh1TBzKue5y0039xQ+F6BBEUcFYCXS_OKjoxJ7v_g@mail.gmail.com>
 <xmqqwo8tw0ec.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwo8tw0ec.fsf@gitster-ct.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 11 Feb 2020 17:46:05 +0100
Message-ID: <CAFQ2z_OF=P6YYuFkB5=4w0-nX+g59bagZGvcUBg_kSh-gOdAbQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] Add reftable library
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 11, 2020 at 5:32 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Han-Wen Nienhuys <hanwen@google.com> writes:
>
> > I've uploaded https://git.eclipse.org/r/c/157501/ that proposes a way
> > to encode the hash size. I  look forward to feedback.
>
> Development and design discussion happens here.  Please do not
> require people to go click at an external website---once people
> start doing so, we'd have to go around 47 different places to piece
> one discussion together, which is just crazy.

The ground truth for the format is the spec. The spec is part of the
JGit repository, so it seems reasonable for it to be reviewed there.
Do you want to move it somewhere else?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
