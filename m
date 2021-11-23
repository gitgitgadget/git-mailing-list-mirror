Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0298BC433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 16:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238822AbhKWQsu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 11:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239878AbhKWQsa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 11:48:30 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEE8C061395
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 08:44:55 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id az37so44967601uab.13
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 08:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4zz/WlOMfI+l1lTzhMJK3Pj2GTa7YjH8It2y5xz7oZ4=;
        b=KKq94cyja9LAysmNLNBe2Yl981AKx2SPjaAhRuUHdFuEEIt+LVikjA5+f1E9f5Y2D8
         xuNCXZH0qhbRduHSEowMcMuf4e5yvfRp7UOsa82wHPgRHfPpAIMN1bqtPbEkNOG5uGto
         StoNtHlaOpVLNhqem8aff/NduiDYJSitagdOly2AR4PbTHdwT8iJKCtjJwND1vAMG7Oa
         4ydB2HJ/ARJRk6+hswXDZwQogKdGocckieLyE7/mHcAWnTW0q4KMjZn8EapSyprAceCZ
         bOqOs3vVlMkmwvnB2MZpl7MHa/kblg9fkbDzcTUJAmEY2VV3eIDDTfhQpttAG+/Vuea5
         RHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4zz/WlOMfI+l1lTzhMJK3Pj2GTa7YjH8It2y5xz7oZ4=;
        b=7HDVsvg3h1isIeccH5eld8HvDchGeHomzgvNU8iCE+DyJZfrGsNcfSXeuF6TtImBrg
         EPjneXRYu7aUVoFvhFTCdcN+ZiuVeSYBBlPBi++fbq3gsBDK4soJoVwj5qgp7maAFvgw
         7jFMNFLRUJ3X1+IzFyo4fD24QTetMHf2/d3WrEFespmlxvXpr++szJ4HcrADI2Tl3t79
         Jdeit7vZxv8Tm2qfIauLzgfJap+csBdbElQnR5TQRuPP4KBEmbX1dipAcXfQ9xvioUJx
         eNeyVVx+5CqeDpb3k7/q98lV04KuB+whUjK38DK38qJ11/0L2hOaEbi0PmE7Pv8vimhg
         zllQ==
X-Gm-Message-State: AOAM532X2xe3sVX+gHiX3vNKesQOKZdLPBzX8nQfO1+K2Cy7qVAP8Lzz
        X1kLV2GUOXSm3QRdSC/dZ1xx2VUXlf19kwGaZz5SEQ==
X-Google-Smtp-Source: ABdhPJz0CF1VnwVrlZVB+NLHCk325AvDWhC6YQTCSM42GEmqtKpHBecuWM6p5LUMad9RCPfUy3xD41dwsCJzt0yiECk=
X-Received: by 2002:a05:6102:3e8d:: with SMTP id m13mr11949668vsv.6.1637685894655;
 Tue, 23 Nov 2021 08:44:54 -0800 (PST)
MIME-Version: 1.0
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
 <dfb639373234a6b8d5f9110380a66ffccbe0b1d6.1637590855.git.gitgitgadget@gmail.com>
 <211123.864k83w3y4.gmgdl@evledraar.gmail.com>
In-Reply-To: <211123.864k83w3y4.gmgdl@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 23 Nov 2021 17:44:43 +0100
Message-ID: <CAFQ2z_PSS9zOzR6nGYZ8DBK+6oOQzkJsEy_7y+NprwJ1OHNs7w@mail.gmail.com>
Subject: Re: [PATCH 2/4] refs: trim newline from reflog message
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 23, 2021 at 11:40 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> I think your cleanup works, but wouldn't a better thing be to move this
> to callbacks rather than tweaking the fprintf formats?

sure. In the reftable glue, I have

        if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
                /* XXX - skip writing records that were not changed. */
                err =3D reftable_addition_commit(add);
        } else {
                /* XXX - print something */
        }

letting the callbacks do the printing means less work for reftable.

> The refs/files-backend.c shouldn't need to have one function calll the
> "should_prune_fn" *and* write out the data. Instead some code common to
> all backends should call the "should prune?", and then call the
> backend's "here's an entry for you to write" callback.

not sure if that will work. For reftable, you have to write something
(a tombstone) if you _do_ want to prune the entry.

> But maybe I'm overthinking this whole thing. I'm just wondering if we
> have say a sqlite reflog backend as opposed to the file/reftable backend
> that wants to store this data in a schema. Such a a backend would need

reftable also stores this in a schema: there are separate fields for
e-mail, timezone, timestamp etc.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
