Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C60C352A1
	for <git@archiver.kernel.org>; Sat,  3 Dec 2022 05:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiLCFPP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Dec 2022 00:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiLCFPM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2022 00:15:12 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951A4CAF83
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 21:15:11 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id q71so6016537pgq.8
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 21:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7ol847N41DH7yNZ/Z3BIV/TNP3Ii5/a3uSqae8b8/U=;
        b=i8fNc3FCijVaqAaa1CXpqLGQtaufhGtdaXEJn56N9WnOlFy+XFjX/TyjuRzqZJrtEz
         nXynjvykZ1hczj8MnDijUXvFFGkiN7JhXtk5WKCObsRaKEO8LoBXhaihZfWcA9TmudaM
         KpYELJm9Whs7tWAKaslRIFNkOremrhWBsxluLBnJj8OwnVak0jFlA3OmvZUgN+/wltye
         TlCr0iRKv99gnXX5kyr+eO//h3YRTKFYmlgiXeMbuT3Xh4Dw6Sturl5psERiEeur10gH
         R1W74dPZ2Zqns50DHkZ3c5++dA2asmCgCT1tAwhcLQ0/CQe/b07y4gOleh/x+jnvq/OA
         AOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7ol847N41DH7yNZ/Z3BIV/TNP3Ii5/a3uSqae8b8/U=;
        b=dxK7BL1ddOQZaZ73eNks78SzV5OSDeDw1ohaaXL3K9btVnMcFlSU8YAI2P4j6Hffff
         gh6q1wNhfOmWhE24R4SEbDZvkMBwQRS4CCZJlHYLAyN6u25xYMYodkeZIGH6vBbX5OLy
         RnULLML9iJpJ9KhDxrg844wvvp+Hz5FpbfrRz4+LBdtaijMfthO3tx38HF3H+sb8MOY7
         I7jh7c656D/jWxTlSXhbLIrccvbZJB6dFwP/LnLJ275w71Rl7lFkMpERxT6shXksr730
         eQ9XSX1J90ElOdE7WZDYopdmB5MR/Na0q+gb7JqkX1CxZo7/Xan2Y9xKM6ApYuDjwzKb
         3/RA==
X-Gm-Message-State: ANoB5plJ7c8czs5Hqa+eqAjrjBOx2lBk2hkovMZbIf2+1d+Y265MaI6V
        BH8lQS2Mz+seIgN+Xsv7re0U7DA/2uNHz1+6eiY=
X-Google-Smtp-Source: AA0mqf4R+QVZwTHPqt1IbedmHMhDSPe2x0KG2TTQN0Pz6VrAolOSvAlRWv2W/QbKQxZ/S7Pdp1JhC5jwejxlR12oCcg=
X-Received: by 2002:a63:5241:0:b0:478:60d0:7d77 with SMTP id
 s1-20020a635241000000b0047860d07d77mr13258567pgl.514.1670044510964; Fri, 02
 Dec 2022 21:15:10 -0800 (PST)
MIME-Version: 1.0
References: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
 <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com> <patch-v5-02.15-314c5e40cff-20221202T110947Z-avarab@gmail.com>
In-Reply-To: <patch-v5-02.15-314c5e40cff-20221202T110947Z-avarab@gmail.com>
From:   Eric Sunshine <ericsunshine@gmail.com>
Date:   Sat, 3 Dec 2022 00:14:59 -0500
Message-ID: <CAPig+cQRFtFWesYgaBfeqbP4Nax+-335W9at6uPgvCdtX_CPSQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/15] cmake: use "-S" and "-B" to specify source and
 build directories
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 2, 2022 at 6:28 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
> Rather than the multi-line "mkdir/cd/cmake" recipe provide an
> equivalent one-liner using the "-S" and "-B" options, and then suggest bu=
ilding with "make -C <build-dir>".
>
> The rest of these instructions discuss e.g. running tests from our
> top-level "t/" directory, so it's more helpful to avoid changing the
> user's current directory.
>
> The "-S" and "-B" options were added in cmake v3.13.0, which is older
> than the version we have a hard dependency on[1].
>
> As an aside The "-p" flag to "mkdir" in the pre-image wasn't needed,
> as "contrib/buildsystems" is tracked

s/aside The/aside, the/

> 1. 061c2240b1b (Introduce CMake support for configuring Git, 2020-06-12)
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
