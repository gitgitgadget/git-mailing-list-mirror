Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B61C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 13:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE00F60E98
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 13:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236900AbhH3NuA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 09:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbhH3Nty (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 09:49:54 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CDEC061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 06:49:01 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id bf15so7292698vsb.0
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 06:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KX8ZU+F1Ex7YTrnVaqunjrfjUXPs0EDCZq5JF9NOSpg=;
        b=g1S9U4IS7BgKWvthhiM9d6Sh+/JO6l7dNv82Kmtp6fcArONXxBT0pNN8TXeWCIB0W9
         Jsb5J0IXIM2cXuBiYrT2YhMNvyVvGSRXbeWna2FHMnlosxSxDDV/YTghCezloSX0qtUa
         ZfcC3/1jjVVaQ/ghr1VvBuIagf584KtYkLZo5l76D5FYJEoldxShY8azfckmXETpSNzQ
         4hP23pjxOHiQRkn3kTejwxrosnmrtbpSEt7U8wGhHNskxaiwOxGmnLcCdaIe1yKwDkKV
         6JYMj839uRiKZXAL8RhVfW8yqASh8jPa5OSOgj7sRBNgL8b2DVIu/f+L1qYPLz3m1d5h
         fG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KX8ZU+F1Ex7YTrnVaqunjrfjUXPs0EDCZq5JF9NOSpg=;
        b=gNvxmZ9zQo6JKNIj+Y3uMQWKAeFL2LvxAPxyhO0Z9OHyiRwhehhf23JzgrDYTk4P8U
         bOmgOB2GFmv3lX+HwUWvBquMEru5o+QSGCx4/lYTvCFvOpJZuHufw/57aZ4XSZugsHR7
         /QuXHuin6EL3Gp7J+0pkCRq/V4eLNBJJMrtSGaUNZrbROu8wSDXGuEnsV7WgeSIBvn4B
         MEwKOXk7tuyihfd1IswNvkWgFBD/+UC4/4lJ10VPRshL1DOyPb89QeA2iGY92SBOJ0bv
         wZA0Kdb8NNhdw5Peoac+mixp/C0Dur7S3DsfDqaVeMgwnaUybcMPzaDbJATGQCzSZPzT
         /hmA==
X-Gm-Message-State: AOAM530Y2eKBBS0BU6AZ/aab94YwqZ917rFQUExd7EhLcAUWeYBDBcO/
        uCjzsBDKWPWIbU0SLycHx+EXTtb5CtdYrc6GPXdN7w==
X-Google-Smtp-Source: ABdhPJwoHtqRocviSY4q23AfzsCzHKw7BnO/O18Ki/F4zUm9k6jyA/0emyCbvo5qz9evPWrIEWaV+PSYWOVSqgEoNF4=
X-Received: by 2002:a67:ea81:: with SMTP id f1mr6951424vso.32.1630331340066;
 Mon, 30 Aug 2021 06:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
 <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
 <patch-v4-27.28-c4f9fb42d9e-20210823T120208Z-avarab@gmail.com>
 <CAFQ2z_MnJr58Cu970Be7SXE1jFkgOGThQ0Geq2+kNihJE3_BvQ@mail.gmail.com> <87r1ebxe2y.fsf@evledraar.gmail.com>
In-Reply-To: <87r1ebxe2y.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 30 Aug 2021 15:48:48 +0200
Message-ID: <CAFQ2z_Pa1fG935rQBQPijE=YHatsHbsLd_f8dT7Zh-grdgwbjg@mail.gmail.com>
Subject: Re: [PATCH v4 27/28] reftable: fixup for new base topic 2/3
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 3:22 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> But we will need at least the optimistic locking of code like
> builtin/reflog.c wanting to do an expiry, and deciding whether to do
> that expiry based on a given state of the ref/reflog. I.e. we don't
> want:
>
>     1. Start reflog expiry
>     2. Code in builtin/reflog.c looks up the OID
>     3. Code in builtin/reflog.c decides whether expire the reflog
>     4. Concurrent with #4, another writer updates the ref/reflog pair
>     5. Code in builtin/reflog.c says "OK, expire it!"
>     6. Reftable queues a delete/prune of the reflog per #5.
>
> This would be a sequente of updates to the ref/reflog, none of whom were
> racy as far as the reftable semantics itself are concerneb, but where
> we'd do the wrong thing because the writer thought we had A when we
> really had B. So we need the equivalent of an "git update-ref" with the
> "<oldvalue>".
>
> Is there a better way to do that in this case that I'm missing?

I spent some more time looking at builtin/reflog.c, but I am still not
100% sure what the locking is used for.

From a quick glance, the OID goes into tip_commit, and tip_commit goes
into a reachable list (?). The reachable list is then for something,
but I can't really tell what.

In your example with 1.-6., it's still not clear to me what the
undesired behavior is precisely. If the reflog is pruned in #6, is the
worry that the update in #4 is pruned immediately after being
effected?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
