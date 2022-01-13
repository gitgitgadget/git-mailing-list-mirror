Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEC6C433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 14:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbiAMO1p (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 09:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiAMO1p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 09:27:45 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3168C06173F
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 06:27:44 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id p1so11355797uap.9
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 06:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7c/O+/mm74JC0DEHceN/264xSdbGXZVxJYQVnvBZOR8=;
        b=HVe3MvDQbkJQuEWQcQcALRnXoFIKOuHvcHog8BPwTiHLP9+JpjRL6YNo0KS6DclHJN
         JCOttdEXOgN8rfa6VEeiZAyXb2KSrTycCiy9DtjF6y8SXEQvQzWQ4ooLbt812Ml1X05A
         ydGzEPgrzWo4nTX22GRuejuHT/BkMGKL02KvJAdHuK4awTaf62jW08YsE/BwCbSs2o/1
         3c5Z4IhbCeRGDSCYC/6HkWIvi7McoG3Hl2kbQYiTXXGjT4ZHsmwV7kfVsXpz4TPbq4jG
         D2bmigqAQ0VVhwbzawydVIqVnAMSvXVekEZ8PAmQ4vmSMx0G/3MrA+XGpPLpRVvp09v0
         rW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7c/O+/mm74JC0DEHceN/264xSdbGXZVxJYQVnvBZOR8=;
        b=xwbf7Lr0gfLAOrrVuC3GET+D+LysG7/oN7OpNXLgFzaNZDkcQ258G+3eE2epOp6nD1
         2ZkAdfedNESHOaELHH1bCsa9Ihen4sdlH7xY97ikk7Bomq0tcaXJnhseNhtucwdcyXDs
         F49flolLJv63yw+1kNb1XAyRCWQwY9t/inPFTxxAWJrK+k+6OoFhM5mxmtcM72W+b+bW
         xN8jBzKp6gxHmpW54UB3GLD4qpZto4YonFanzHY4pPAhXr8HtGev3VqWAVYaSTyxzISu
         1zvywJhPF7ZWIpmZFoC3lIxjWDkfVPAGJnlZGOYabsjfoUDXVDDwOgr1jaZimCj5Pr6J
         ScrQ==
X-Gm-Message-State: AOAM532CwcM6+xRjQK4mIlS6GT8BFBPjrfe+XItOu+PSecYAxFPucrQz
        57K0RLfKTDd42Aw9S5tJlSDAKzR5YZUxTxxPXwBMbA==
X-Google-Smtp-Source: ABdhPJzJ0AcVJguy3kZBKvnkl+MquSBYZ268GrpptWzP/fFaK9D4SN35vtgk1tFl8KxNulUYF8EMfTAnhwC8BcTNFZs=
X-Received: by 2002:a05:6102:2451:: with SMTP id g17mr2339040vss.8.1642084063885;
 Thu, 13 Jan 2022 06:27:43 -0800 (PST)
MIME-Version: 1.0
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
 <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com> <9ab631a3b29addaa54415139e7f60a79a19a6edb.1640199396.git.gitgitgadget@gmail.com>
 <xmqqtuf0fe3r.fsf@gitster.g> <CAFQ2z_OLCzOYXgXCTXyLOwwk7EBkPzwH=KASDmuJbur=q7L1Jg@mail.gmail.com>
 <xmqq4k6y63j7.fsf@gitster.g> <CAFQ2z_OFK77TC605GqM2Lw1Lf21fyF2cVKkGVrXO6TP6zcp+mw@mail.gmail.com>
 <220113.86bl0gvtq3.gmgdl@evledraar.gmail.com>
In-Reply-To: <220113.86bl0gvtq3.gmgdl@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 13 Jan 2022 15:27:32 +0100
Message-ID: <CAFQ2z_NpK3Yr=vHScnJV=1uDnh4P0PceuCXK+CVLvVJ4GtVh3A@mail.gmail.com>
Subject: Re: [PATCH v5 02/16] reftable: fix resource leak in block.c error path
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 13, 2022 at 11:02 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Aside from what Ren=C3=A9 said in his follow-up, I think what Junio's
> pointing out here has to do with the use of this pattern in general, not
> the specific code being discussed here.
>
> I.e. if you get into the habit of needless initialization it may not
> matter right now, but once the function grows an if/else branch, or
> someone copies the pattern to such a function it may hide a logic error.
>
> So it's not about analyzing the control specific flow here, but that
> your upthread patch is separating a variable and its actual
> internalization by ~20 lines.

I know this is the Git project's preferred style, so I'm OK with
adapting to that, but I'm also sad about it.

Sure, you can introduce logic errors by refactoring things, but with
initialized data, you get a reproducible logic error, rather than
something whose failure mode depends on platform, compiler and
surrounding function calls. This makes debugging problems across
platforms easier. In particular, I don't have a functioning Windows
environment, so anything that helps minimize differences across
platforms is welcome to me.

--
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
