Return-Path: <SRS0=mjbR=3L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEA5C2D0DB
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 10:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C142467B
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 10:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I6QM9OMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbgAVK74 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jan 2020 05:59:56 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:37316 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgAVK7z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jan 2020 05:59:55 -0500
Received: by mail-wm1-f51.google.com with SMTP id f129so6687821wmf.2
        for <git@vger.kernel.org>; Wed, 22 Jan 2020 02:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5K3QB4W6qv3Gwg1gkcD0Mi+nH+jokKX6j7YrjhE3YE4=;
        b=I6QM9OMZcHY2qpxtUfnwtQEpbbwAjOQlPwJhBtaGtIDkl6yWZiiPEym06ffH1fZz54
         HC4nawm3F0xv4fB3a63P6OddpaseUtzmAaLnl0HtppHDoMq+DRNYwO2wVN+wZQc/7gVL
         wgHis1ZVNnZRdN9QlbvV6CLp6tg/Ypxii3RdjonAf7vqwW0x+EUbuIGFyMZ/Qh81ir6V
         XWqbhvd+Zo4jrpd8o76uc+iSUveh2kuTCjcCbki0fcbP4kTwZa+L7xsDKaIr0ritdLdu
         mheRvl84CgJWqI3Bl3OPfJznOT6r+6NRQy/vCBonkPv+1XY8yB6T6KgwaaukKu4+9D/Y
         I/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5K3QB4W6qv3Gwg1gkcD0Mi+nH+jokKX6j7YrjhE3YE4=;
        b=omkOdIpycPb1ShHmdoGdtiK3dnEkSe3nc1RNzimHtUTyDe0173FSh79FKy7Ik4xbh2
         hHqMJDBJTVNsnL9pTBcTURv3tbRaS5o1hGS+IgHxYZ2p3Yn3+lImQJDZLLlh7zUHA45H
         mILYkDuabDuiVhAdDl8ary+1dsWmm8WUyhs4gF8oqYCX+NOJdi+6+rQg7RT0qgPdJA85
         2pXcoZjaU+1GHnNjXcl4SNvgBuz/YtvNAo9HyHSl1hBNKpMvcwwR4G4Bp8/38UW8n3Jv
         OibzAro1NwlkE27V71YWNYHL4lFjiSvrDcSzp07owTvLNsvFYU2JA2nxXQzC80X/ZcfV
         M3fg==
X-Gm-Message-State: APjAAAWhoZZRcMOnqbU9Ku+yOVSpJU9c706c0tXcUR2WhxmYJuyqCAkr
        MDGqBYkYj+GmyRrdm+YovNDxGyTbzAe2ndaZkx3bpg==
X-Google-Smtp-Source: APXvYqz/ORSpabtR7+KlkKjCkKbqz0ygygwxAegQy3yD5ktEGoZM4OYt2AG5vO1Qz0F7PeODKP4hCNqPpEqgz3rUwdo=
X-Received: by 2002:a05:600c:145:: with SMTP id w5mr2258753wmm.157.1579690792765;
 Wed, 22 Jan 2020 02:59:52 -0800 (PST)
MIME-Version: 1.0
References: <CAFQ2z_OhNHauK_W1wL7WcOJnm2vCUGXLfYn_ZmLnt2rez+_TDw@mail.gmail.com>
 <xmqq4kx4z8n3.fsf@gitster-ct.c.googlers.com> <CAFQ2z_PxumPGpgnTERcu3S+zdTj9PcVMKK9SjYxSDe3qW9q3jA@mail.gmail.com>
 <xmqqwo9kacac.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwo9kacac.fsf@gitster-ct.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 22 Jan 2020 11:59:40 +0100
Message-ID: <CAFQ2z_OYF8ogmX-LMxL8LmbfK2C0bXUzGanSmStid9Rr4sf0nQ@mail.gmail.com>
Subject: Re: reftable progress
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 21, 2020 at 7:34 PM Junio C Hamano <gitster@pobox.com> wrote:
> > I asked around, and it looks like we have slight preference for the
> > BSD license (https://developers.google.com/open-source/licenses/bsd).
> > According to the FSF, this is OK to combine with GPL software, so
> > would you be OK with that license?
>
> Sure, I think we are happy with adopting BSD code (and it would keep
> it more avaiable for other reimplementation of Git, which is good).

Yep. I'll go ahead with the license change then. Thanks!


> > The API is a little surprising here, because it means that an iterator
> > should always dereference a symref, regardless of storage format.
>
> I do not think forcing the callers to dereference is clearly better
> (if so, we may want to consider changing the API to do so, but I do
> not see such a strong reason).  Only when the vast majority of
> callers would want just the name of the underlying ref without
> learning the actual object value, such an optimization may make
> sense, but it would make the callers more difficult to write
> correctly (iow, somebody will forget to teach "this is a symref, so
> we need to ignore the incoming oid parameter and call read_ref()
> ourselves to learn the name of the object" to their each_ref_fn
> callback functions, no?

There is an intermediate layer that wraps the refs/*-backend.c
functions where this could be done.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
