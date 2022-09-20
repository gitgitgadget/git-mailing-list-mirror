Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9469DC54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 08:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiITIyP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 04:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbiITIyM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 04:54:12 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46E26B64D
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 01:54:11 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id v192so1025471vkv.7
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 01:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=pGOL0oY4EteaUBlWBzle+mtIe1w/rRWR426N+rwwpyY=;
        b=l8ty8uksBhXYXhRkkHpP2fdWsFjsCJm7Fe5CWy42W5KQDIU0Nwljnc/Fb0TLFFoeax
         uMtyk4/QlFtRJzuKbRXxULcbNyDFrC5tlMuBpf7M3SeRGa1o2wRxLLv+ZuphwAuj8tvx
         mjZZy7gd1ryqF3K7pO1o7IrCOQkiJ8AtlfyulhnD9lJeHsKZCwul3i7Mq6N023ReAhc8
         G8XArHUiUixqH+u8cvL/8UwCzkGFRri7RQbm9gWmLSOR0Ysis3Ban1bXi8YQiRjeLxj9
         jDj/OVkNPsz2WGaS9Xk1hG8ctY77+ynnZiyL5pAVwhYIYye5LsXYeU8wuTcTdPC7KbZd
         XL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pGOL0oY4EteaUBlWBzle+mtIe1w/rRWR426N+rwwpyY=;
        b=fyS455hjRt1Ig60zvhVump5lKSatG9fT//NG1O580Qy86mzBHWc5morYJB8HqtrEwM
         F1w0AF1pf4xNc7twE8Fm4I/+94z6lKVvn24UIFNZ4jlo/dxSkHPPt+okLgcUeQllA+2/
         Ld4xOps1D9zN1/sEHd0jcjkSVIZ35Q7t1v57FSgIQ8WGQyTvzVsOJvshoIpcnCKZDWBZ
         k2+ybN42alDDJaDNb5k+mK5Hi7Yx8xccu4XgtpS+/dDQEw4W5kqRv9hR8ibnNKrgHSxt
         jFM+nw1Ajmfh7ZeNss5y5WMuqs3DjHGFBZvgT070F4SafsG1SohEIc4A/Z6qqAOENURl
         90fQ==
X-Gm-Message-State: ACrzQf0/5NgVcwgR4BxcjXzZdfRBWuCcwO/owzaK2RWOnPgCydr4AezR
        looZInXZ5E/M6QHF2qKjKoMb31ALVXCtOa9wvjCRSw==
X-Google-Smtp-Source: AMsMyM5gSbV0d8UZ7mvIffumV2P8AiSWL2Es50qD+QlHXyJrNx1xZ8KEc9pEPwXpqybTnMc/na6iCNMOn3I7YrjAu00=
X-Received: by 2002:a1f:a7ca:0:b0:3a2:cb7e:65a1 with SMTP id
 q193-20020a1fa7ca000000b003a2cb7e65a1mr7691891vke.4.1663664050751; Tue, 20
 Sep 2022 01:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1325.git.git.1663002096207.gitgitgadget@gmail.com>
 <xmqq1qsge71x.fsf@gitster.g> <xmqq35cwcpws.fsf@gitster.g> <xmqqillrb7qs.fsf@gitster.g>
 <CAFQ2z_PBWbdKgbaqLO6iXB8WEhG=CTjetrEgm7wHacDi_n8VHw@mail.gmail.com> <xmqqwn9z82hk.fsf@gitster.g>
In-Reply-To: <xmqqwn9z82hk.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 20 Sep 2022 10:53:59 +0200
Message-ID: <CAFQ2z_PQFtq-ph1B0tUFDW7ngVwg9++k2M_5rvozsLVisX2+Qg@mail.gmail.com>
Subject: Re: [PATCH] refs: unify parse_worktree_ref() and ref_type()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 19, 2022 at 11:43 PM Junio C Hamano <gitster@pobox.com> wrote:
> > On Tue, Sep 13, 2022 at 5:43 PM Junio C Hamano <gitster@pobox.com> wrot=
e:
> >> then a better approach would be to have a small helper
> >> parse_local_worktree_ref() and make the primary one into something
> >> like
> >>...
> >
> > Thanks, good idea. I'm sending you a v2.
>
> is that "v2" <pull.1325.v2.git.git.1663605291172.gitgitgadget@gmail.com>
> or is there another version of it?

I think so.

> Hmph,

Did I do something wrong?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
