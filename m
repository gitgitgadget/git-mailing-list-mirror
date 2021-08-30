Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B95C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 15:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C346B60E98
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 15:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237421AbhH3PXZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 11:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237416AbhH3PXY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 11:23:24 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC4AC061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 08:22:31 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id e9so10812396vst.6
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 08:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e/GICpi+owM2h0eL2SKaXgsIzcoOihPFVQrqvFOES3Q=;
        b=bVVMCJCfvIch15JZVmdOxtqGHzVMbbO3LyYmhajtRVjAPBsGzfZyAleBs55XgOu0bU
         I1ljcOC9SXZ0bhzWwjsI6UILGi8bG8kqi+3TF/by25L+YOmkVAhuc3HORkoBLvZtOpPx
         deYS5Zx1n7k7va/ZFEut4aXXqKONnZOAhiaYEG9mjZ79wdpJsMZzEl5+YcUTsVdgsbrP
         WjWnlseAeT1ZcC5gT+q1h4TLhT0d2PXpY15+WSPHHiMTuhvTCbHF4X49ZESMdWFxj4Vy
         3SC13vAI3cn6YvOF1MA2qOvzJ13DSF+fAF6dKo2mCad2mTHSU9eEfltqYzSH1JzZOtb5
         F2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e/GICpi+owM2h0eL2SKaXgsIzcoOihPFVQrqvFOES3Q=;
        b=d1YoiH5IPVunMBsPYdia8Q6ZiGSqGHf7dPn9USWAoXwNVe8MYiVzC95QWJJjrdcQoA
         ww9ldgd521/Bzpwg/gNmsw1g/1zn3/CF/5ssRau2TeGocoTxEM3chBlCQ+uyFea1GnAp
         XIBKMbQraahcgAN5+aL6Qg7n8Y+IB1fJAlr065/ELemOt6EVGAEHQVV4cCkoa4KTIPYs
         qB08e7kIC8N/pEKjZnOZwsHWCenlUM+e7bBuVbOkw0kg/DO5dLJC9CO9YjPvVtLPGhNw
         N/UuYCpSi+MnMvSsPXNR3jy1RmL1PVWgilmJBX7X/rwyDEZMu4vyv+2UUy5m80Gj44O2
         QU+Q==
X-Gm-Message-State: AOAM531gFhXMiII3Q+LitKsBblzORlL1uXP2i7NPe2nk8P285Y/XsghJ
        ATw8GG4I4SRdd2e85xu16XBaCRl8IxPck0uFQTsBHA==
X-Google-Smtp-Source: ABdhPJx0pZsj2XlADWwC5cAW5ENbbgLqLK640qFhUJyB4hzOCg7OkMCSYpfsCB7M+AcdXl7B3Jr/UsVJX0XTJdOewB0=
X-Received: by 2002:a67:ef51:: with SMTP id k17mr7771500vsr.2.1630336949964;
 Mon, 30 Aug 2021 08:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
In-Reply-To: <pull.1081.git.git.1630335476.gitgitgadget@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 30 Aug 2021 17:22:18 +0200
Message-ID: <CAFQ2z_P-AE9weWbu-p-ivw1OgSk_hU0j8bFWOU-SZX510_n42w@mail.gmail.com>
Subject: Re: [PATCH 00/19] Adds reftable library code from https://github.com/hanwen/reftable.
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 5:05 PM Han-Wen Nienhuys via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> The reftable format is described in Documentation/technical/reftable.txt.
>
> This is a fully reentrant implementation of reading and writing the refta=
ble
> file format, and should be suitable for embedding in libgit2 too. It does
> not hook the code up to git to function as a ref storage backend yet.

Junio, per discussion with AEvar, let's kick out the full reftable
topic from next, and put in this topic. This is unlikely to have
conflicts with any other efforts, and is necessary for the full
reftable support anyway.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
