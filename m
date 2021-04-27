Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4AAC433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 09:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B05C613B3
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 09:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbhD0JXF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 05:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhD0JXD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 05:23:03 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00BCC061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 02:22:19 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id w24so5760704vsq.5
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 02:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gaaMDz958Oai/61p9sPOkyI1eTFiMUlYl5gcrw9coH0=;
        b=EPJdLtKN0/tltABOfDZT6cSpnnrjMkd355iB8LA9OyjUouEXD5ilm6L9I+qBq3D1eE
         /PsfuSAtRyxX68fHid+vCLCbZ/g73xcefBZeTWdYAPRMxEiNIxbXlrgznq1dO+wIwjbu
         zRVGchNGqrSqzSgAjDzWLbe5hJ8dz5omwHop2dtF25tJEHQ3ERT/pn5sewU2SjvZzHNe
         pTJmLKmDTdHnefuwuJq7e/AV1UjMTmR+eKKd5+gWu1RMeqD/TI+waJ5HWK1Jpzt3Cb/4
         94DkFN8SYHEHJ4IBv9PB5MkPvcZk45bRoNPk7s5vbqa9oqKYzU+p+sgQkKInQjew8aks
         MUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gaaMDz958Oai/61p9sPOkyI1eTFiMUlYl5gcrw9coH0=;
        b=qNMDFIAC7UuaofT4ok3BIXg45hLWOTe1ZuDBhdkf1i6ACWWyOMDv9c6//0rySRswg5
         /2aeSUIpzw0rzW3Yc5xT9F2bMvegf5TSCoKI9RCtTbGIKvUQs2lWiadEZKzUt15WI97r
         NqCkbm/pueawHoktdYRgaDymqT28n2hyajmQLKBjSy02ReTwbz5n25ONVRz/lllqEjBm
         hbvZMQEKvxyooz4T5J4Ae09WmqiCvtCLh6eDCVz+FNpVoB6UHcrMgR804Y2agjvrWRQ7
         st6DWxF1L6MHe01duhwW5I0Er23m6KsE+OQ70OcrUeMxZNvUO9tqIe3p8q8aZgea2FH5
         XJww==
X-Gm-Message-State: AOAM532URkC5f+H6kgZ1eUww5rrXAvdGVNiuDg0bpxPvrqFmjOsHLlwb
        bWgX8iXkuuHLT15hMQyRH3858A5LIctiOPsR2ZnVWg==
X-Google-Smtp-Source: ABdhPJwTUSmz2AAjzYUrXdLO1VJnpRRuOZCNiq1GVuDsYtOz66H9BxJ42HKRFJWvMc7yIXkpO5vd1lfakfd7v6G3UCo=
X-Received: by 2002:a67:bd01:: with SMTP id y1mr16406536vsq.50.1619515338678;
 Tue, 27 Apr 2021 02:22:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <79843c0d572765a3004968235391b5ae17365d56.1618829583.git.gitgitgadget@gmail.com>
 <87y2dc4164.fsf@evledraar.gmail.com>
In-Reply-To: <87y2dc4164.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 27 Apr 2021 11:22:07 +0200
Message-ID: <CAFQ2z_O4ybpnnzDhRzbXfdfB6LoEEaFLhAURspZqZn0DDeh4fQ@mail.gmail.com>
Subject: Re: [PATCH 07/18] t5000: inspect HEAD using git-rev-parse
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 8:11 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> If we're doing a "re-style while we're at it" s/<spaces>/<tabs>/ let's
> just go all the way and convert it to a more modern style of:
>
> test_expect_success 'git get-tar-commit-id' '

> But maybe such re-styling would be best left alone, and just a narrow
> change of the needed code. There's various surrounding tests in the file
> that use the same style, unless we're going to re-style all of them....

The file wasn't style-consistent to begin with, but I've added a
commit that restyles the rest of the file.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
