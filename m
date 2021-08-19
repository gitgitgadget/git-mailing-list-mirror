Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9496BC4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 09:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72E5560EBD
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 09:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbhHSJCc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 05:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhHSJCb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 05:02:31 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B466C061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 02:01:55 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id a20so3603733vsh.4
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 02:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y+ITmqotUcwZIqjuw3p+lvevEPcU1Paf1/3lkq6vtcc=;
        b=CHpMZ1ZMLpXfTipYqGyeDBcIJUl9ih7+zoAIhangyqAyFC8uO23rrvNWijOoLqVZ+D
         u1pII1F7fGKunBZUDEF0XQJa5aBB8CirozH4V0/Y3dNm5VfPsgUSjg0Ka1Lds+M9qEwI
         /x9Qb5ftAT7KLGbrHyNm154wla1YPKVzIuxkLminnSrYMDIP2ml9tX0mPmoy11536nPb
         UY8mbT7rtLLnmEjrB7QlaavaRi7IYuhJvkz4j7AAmzJwlEPQ8Jdln1EwglGyMsILxq+2
         HPn8/oEplyiuAM9hIUKRHTdnlv4KV4+KViJACQ2AMw0ImQrqCB36CT6xpeP9jmT/6O4w
         oDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y+ITmqotUcwZIqjuw3p+lvevEPcU1Paf1/3lkq6vtcc=;
        b=CMVcs9AWbtonm1rzHgnJLaarMEpTV4lU2kL/NnQ8Azk+ctk3YFjRpj+xVdEd9Ake5B
         2Gx4uaKoOWAHWTbC3IYOxW7BSXuhGzYedktIUkSJwKdFRwFSm1lRhW85WxmGByVQV6pE
         i6D1H9LsQIfCJxTPZ4V5DT79tFOJC7rXo3yQj71bbbTEB3f04WQakPu/7LRegF8XtuIP
         w5PD4wEWQk/vPYT2IZZ1yQRsVbhWpgIrL0pQ4IKz0GkdEq5s6rw1866/bJABD2/K7uaB
         OyeIvaNroTN/1glteWFn/VCzydC9O5djy6YpIJ7dQ6zq513zlX/oqIOFVZzSBJGpbhky
         jIZg==
X-Gm-Message-State: AOAM533wMG5Q9jWaYlpOgAv3AHRia1JSOzMqcoTwUrGwLV+quPu9Wa74
        UcYNheVKlq6xMJLB9DTwA17+GpNqkm0tyl/BD2muKA==
X-Google-Smtp-Source: ABdhPJx46NmpTdVC40V7M5o6CEAkvIzi3MoQ32fWsXwqUAqTGhbkjoVPVSiSyExFceGnC96PVo+KpFO2FyAv9H9Svpo=
X-Received: by 2002:a05:6102:3594:: with SMTP id h20mr11521442vsu.42.1629363714262;
 Thu, 19 Aug 2021 02:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1068.git.git.1629203489546.gitgitgadget@gmail.com>
 <xmqq4kbn7l3l.fsf@gitster.g> <CAFQ2z_Ni1bvj0Skgp_3p9htQfjn_M=3uF06pyZm_hkXgT_L61g@mail.gmail.com>
 <xmqqo89u61ww.fsf@gitster.g>
In-Reply-To: <xmqqo89u61ww.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 19 Aug 2021 11:01:42 +0200
Message-ID: <CAFQ2z_MBQZOgMr8NC6Ju-8H0XZXe+Lr=ueH_r46C5QMmUfDneg@mail.gmail.com>
Subject: Re: [PATCH] fixup! propagate errno from failing read
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 18, 2021 at 8:30 PM Junio C Hamano <gitster@pobox.com> wrote:

> I do not care too much about how exactly the bug was introduced and
> uncovered---it matters more that the end result has one fewer bug
> thanks to the team effort.

agreed. Just wanted to give context on my bungled "fixup!" subject.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
