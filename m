Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1948CC433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 16:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E127F2067B
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 16:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HPmEdPMc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbgFJQ5f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 12:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgFJQ5e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 12:57:34 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2FDC03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 09:57:34 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id p187so762800vkf.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 09:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nOpiF6VYVjZnMsutRUC4SAkWgB3D67dmZFxjw6NMj1g=;
        b=HPmEdPMc57GzIW/kvg52Ew2/KHgEa6JCmKtV2znE/ULnZjx7RFn4HHQnYjMN4b74oq
         N1GRya1zS+IOcutdiyvhdx9iM2Ho+YZI/9VOVQW2D3OiqeuwziFslhnTjNmpRJvD2LC1
         8/g4bxjdFrG/ItlhDexmCecKwVfnZIdjkzIr6owQiA+hHsdSXv3hPsP6O5UtSr58og4d
         OKC2cUO6p/pBReh79/jK20bXdUu97ns/JBLj7VK6yuo8JR/3POngQHHmyz5lpPVYaJqb
         TMkpmP29RezH9W98wPL98yHX1URgbIf7CJd2KVM9LblVXR27TFov3DW92TsoQxmFrmho
         bmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nOpiF6VYVjZnMsutRUC4SAkWgB3D67dmZFxjw6NMj1g=;
        b=FPNNoQcLUK4EZuIaGhl5g1bVA1LbLsNW5h78xqB56Kqi/F+ipP5zXDFB9NBf6mpNmq
         whA/TAsDctk7Hj0jK0rw+VfK3/0AWydBbVuzEU9hsbixLt0rP4AldzuCaVw+z157qoiF
         kF4X2EvlTFLL07NLbiwKV5qhjT/X39CzN1s7vhwrWEeKjmfvdlibP0DCLZ3U/gNtue/Q
         FsHjq8sn8IbsNNACnj6BPM0IqRZiGL/WsFOjP80t4Asx91bWa6Xno9LYV/12SLWRmCzX
         cLLoqPsHrqrM8ix/uk4U0OIJLcCCAwPtKbC6WFd8krZaB1U6Mbiszt/t8nFVPqnMG+ZY
         /5AQ==
X-Gm-Message-State: AOAM5307r6Tvk3/etyGlthGK0K1qrdJJrWWGzwf1PXJa1toRq5J2nvup
        tTUQM59WX3YUCEJwn0uWunIKrnly6L4Qtj2qlwcbM39xWto=
X-Google-Smtp-Source: ABdhPJwMZyKLlh8+BDW8ZcQfQd8rv64bvq9C91j5KliDTIJejG1ln3D8QFOyx0ZSn7clT3mtn15BVzxnTpUB1sGOp9U=
X-Received: by 2002:a1f:60d5:: with SMTP id u204mr3047510vkb.91.1591808253684;
 Wed, 10 Jun 2020 09:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
 <pull.539.v16.git.1591380199.gitgitgadget@gmail.com> <xmqq7dwfhlwt.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq7dwfhlwt.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 10 Jun 2020 18:57:22 +0200
Message-ID: <CAFQ2z_OqE0Hh8nqjCxzKYh6sC2G48z=49_njee_Z2219SiQf3A@mail.gmail.com>
Subject: Re: [PATCH v16 00/14] Reftable support git-core
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 10, 2020 at 1:14 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> he patches (with the fix-up I saw today) applied on top of your
> refs clean-up topic seems to pass the tests (without setting
> GIT_TEST_REFTABLE) as the whole, but when merged at the tip of 'pu',
> many tests fail (please see [*1*], for examples).  I suspect that

they all say

  warning: unable to upgrade repository format from 0 to 1:
  fatal: unable to upgrade repository format to support XXX

maybe a mismerge in the code in init-db.c that deals with the
repository format version?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
