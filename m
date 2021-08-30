Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE9EC432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 12:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D503B60724
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 12:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbhH3MdS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 08:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbhH3MdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 08:33:16 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D8EC061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 05:32:22 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id k124so4276496vke.5
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 05:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+KlIczEzcK4dkLXhxMi0d4MGXMBQea00vYCQButKerw=;
        b=pMvPulpou9vV79F2s0JJZHq2/x07E7JVeA8oiIGAwm17Cd/+LjySYoIitfiCc0VKJ+
         TneoQhkrfnJ91ezjpO+24Fv6J6dEtCpWCQBIQzZ2RKZ9gT17TP6GXKoHUw6klyeQAwqg
         TQZF1ry+5J3qWY+VyCKvZLEf+fmX6VzRiqRF2UvFUASs56HY4EMOXh98zmzE/Zyqsz1b
         O8uKVmAKulSQgG+d0slUXbhkO5oKvBxk4vz/Mwuz01zi7puElB9g6g4dmfio/m9DJNch
         UwWueyzRfN392ncd3sJ/KQpdk3jyJA9KzBmpR1lE24RlkpkLnrnW00HyG3Bfo0dl7QVi
         c3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+KlIczEzcK4dkLXhxMi0d4MGXMBQea00vYCQButKerw=;
        b=BKQlLKaAqFXw0WQ2WLEqm1ipzcZsOLKIWMsLTUDcy9mh4XZ7eAFoau9jMoua3hyUUE
         nLeotDjTKK92ME6nuwjlKi11Cmna1Ju+qHklKvnaaCZU2E4hJskiNEAhDWSnBoGkh25x
         4kWmxoGgNsgyJG7ki/flb7KieS+eo7rgfoys5S4NAhE0S4995N5UqrKJ3CbYenl0NmoI
         pTohu/9KMvXazRbz90HPo0sz4oVXx7uy7ohcaNb8n3gAhnytkjVGJTbaAW34bg+AZemh
         XpyCmScQPDcMyoNVdZrK2VgEMwrGNK3uPfcWcBQ6Q1ARzgdHA8IcD6zAjM9kAHDBqdxq
         K3Qg==
X-Gm-Message-State: AOAM530qMk+3psYg/1AxemGKC0krt2AwYFeX7C6iyoAslmvlgt5/63N5
        JaRiRf8aiY3lEItTmLkwMmdsFJGgTOcuP5hmZqlgsLfBysQ=
X-Google-Smtp-Source: ABdhPJzLI/nVRbrms6ajNyWgvk0VCi1e0H/1vRh01Y4Jt7tSNKYxLUKrT1gkI3dn46hi+ZTWZbD9WMuPLnctgQO1va0=
X-Received: by 2002:a1f:a2d1:: with SMTP id l200mr13242707vke.1.1630326741471;
 Mon, 30 Aug 2021 05:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
 <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com> <patch-v4-27.28-c4f9fb42d9e-20210823T120208Z-avarab@gmail.com>
In-Reply-To: <patch-v4-27.28-c4f9fb42d9e-20210823T120208Z-avarab@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 30 Aug 2021 14:32:10 +0200
Message-ID: <CAFQ2z_MnJr58Cu970Be7SXE1jFkgOGThQ0Geq2+kNihJE3_BvQ@mail.gmail.com>
Subject: Re: [PATCH v4 27/28] reftable: fixup for new base topic 2/3
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 23, 2021 at 2:13 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Since my "refs API: remove OID argument to reflog_expire()" we don't
> have the "oid" as part of the reflog_expire() signature. Instead the
> reflog_expire() should pass the OID of the tip of the "locked" ref to
> the prepare_fn().
>
> In files_reflog_expire() we do that by getting the OID from
> lock_ref_oid_basic(). I'm assuming (but am not familiar enough with
> reftable...) that by the time we get here we've got a locked ref
> already in some way, so let's just use
> refs_resolve_ref_unsafe_with_errno() to lookup the current OID of that
> presumably-locked ref.

I quickly looked at the files code, but I don't understand why the OID
needs to be passed-in (before your refactoring): in builtin/reflog.c
(before), the current OID is read, with any protection. This means
that its value can't be trusted.

After your refactoring, you lock the ref. I guess in the files backend
this protects against non-atomic update of (ref, reflog) racing with a
concurrent reflog expiry? In reftable, the (ref,reflog) update is
atomic, so there is no need for locking to properly sequence
operations.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
