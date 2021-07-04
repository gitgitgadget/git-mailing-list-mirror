Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC6AC07E95
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 14:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB97A613DD
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 14:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhGDOpL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jul 2021 10:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhGDOpL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jul 2021 10:45:11 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB16AC061574
        for <git@vger.kernel.org>; Sun,  4 Jul 2021 07:42:34 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id a11so14854959ilf.2
        for <git@vger.kernel.org>; Sun, 04 Jul 2021 07:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=o0f7A/bOMmDflzG2XHlcFc5Z8kI8JzY4GkNUnjIBxNo=;
        b=YExWRXFEUPdQOVzQtRLCa1V9Y+QWWWuSy8yBboOWXt6xsa10k+jSSKK/pNXe9RvoUZ
         vdKKEzQDrE+uJ+aR6gnG5FQJMVCIdxH+xIR/+MI8NCktFGfGvjTaw1deA+2NbpipjpNR
         b1pcHE81bQw1w6m/kM/LTfJwGl/6pD0hmV0Hh+s9SnC9jz0SI7SejsydSs0HPy+Jt9+X
         GuGOWaEeLBkONBY6YmKK11Pi3x5hsPOtqqxen+jZJYX4y210F4JVrBmcvfRPaIgwTG/I
         TrR0VGPIp0URKX97RK6g/kWerCfyKbAKwRdAeyEcu40HoawMm0qSaTrPrsF9l5ne2A7j
         1ipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=o0f7A/bOMmDflzG2XHlcFc5Z8kI8JzY4GkNUnjIBxNo=;
        b=sON9WCqyin0NCXBrbQumYzRGvoLt7Ktm90X62d3+T3uVeOWQn6gD8lPmbPomXnhUDf
         ncHByqBr+M93liUEGizNNkhUhRsNKZZFcICLqd0pbAVCqn/Iuvf3mj/mHAyczE9RAjq8
         dzB5SGZdAULo8FnNI49eZcnnc5QS4/Fjf7MPJNbsFwYvqM7XB/cESZNAN1Fs5iweWKKU
         TiN10/wMHfEqbEA+Vg9Clil2NMl+91WsWmMofQAOwXn7pLMpFaXoV1oV7xt4kPCG+DJE
         5kiYc4sFfGy6BeWRPaAe4ZOWl/IOF6nyav2xsL9zcS++cKi//Ss73MGJQE1V5ki9VNe/
         CBuw==
X-Gm-Message-State: AOAM531P78QhVrmpFr1YvyoNPzXIWqtnHKtxajB+3e51lC5z3RzIiPmr
        Ul+7cnNiCYO9dsQl28OXGbBQjpSIMslLUcIACannFwrKQRuhd1t3
X-Google-Smtp-Source: ABdhPJyBWL7tPOIGEyy0ONTA1j0wOUvCdnQXUjtSXajaE0k047D2T2E3Jx+r5ORH57hIx6UDNDxtGrAHfls+NkoZrYk=
X-Received: by 2002:a05:6e02:bed:: with SMTP id d13mr6695731ilu.259.1625409754228;
 Sun, 04 Jul 2021 07:42:34 -0700 (PDT)
MIME-Version: 1.0
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 4 Jul 2021 22:42:31 +0800
Message-ID: <CAOLTT8R_=8Md3vk5yBK4dggq1RKof_6c1tOEtfchbSmYf+gwtA@mail.gmail.com>
Subject: [GSoC] Git Blog 7
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My seventh week blog finished:
The web version is here:
https://adlternative.github.io/GSOC-Git-Blog-7/

## Week7 Performance Testing 2

This week I used performance flame graph at the suggestion of
my mentor `Christian` to find out where my patch affected the
performance of `cat-file --batch`. `oid_object_info_extended()`
takes the largest proportion of time, accounting for `90.28%`
and `41.60%` in `cat-file --batch` and `cat-file --batch-check`
respectively. Part of the reason is that `oid_object_info_extended()`
is called twice in `get_object()` with my patch. I tried to revise its
logic (`WIP`), the performance is improved when without using
`--textconv` and `--filters`.

`=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason` gave me a good suggestion on
performance regression: When we use the default format of
`git cat-file --batch-check` or `git cat-file --batch`, we can
directly print the meta-data of the object without going through
the logic of `ref-filter`; When we use other format, use the
logic in ref-filter.

In addition, `=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason` also suggests adding =
a
performance test for `git cat-file --batch`, this can help us analyze
and compare performance changes later.

There are intensive exams in these two weeks, and sometimes the
response may be delayed.

Thanks.
--
ZheNing Hu
