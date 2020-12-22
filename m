Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD233C433E0
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 10:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6489E23105
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 10:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgLVKXZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 05:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgLVKXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 05:23:25 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC3AC0613D3
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 02:22:44 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id q10so6724018vsr.13
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 02:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mKZN+km1LXZ5EBFlGfSeiyvEHOZtgcJtpUqdB5ZN+9s=;
        b=Vozj9D94Hek9YrEDbPIuKtGWKWui7TfoD8axFYgKZFikvGPNnQJ+rFhUdtrWU4jSIs
         3Tog/Bh2b184jx0EpXcYqSleXMAT/78C/HZ7IvG+suTBT4Z1yWgj1PrkuQdX9RcaNlTE
         GEmOcVdZ8afCytswdLvzEHWBiLfIifCBO652TCI0qam7n8a5gED39sTY2UVIbUg+SIrk
         VTrKPZoa8/6op8KM7NjsztlwsW88uoZ1vL+zhxlpmYk6ea8WpO+bHbWjCBuUXvGz6tBP
         DijwELcQZ4Z+wg+/YisdZKtooEQ+2XrSebXndGK1HSoLBFygEqIHn1QAo+GwOoNLZ02W
         MeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mKZN+km1LXZ5EBFlGfSeiyvEHOZtgcJtpUqdB5ZN+9s=;
        b=hrwfoELOy4WEAvbLDBjpdyiheCt0ffU3ZGL36fFCibMSMpwCsL8E1cn/MICFrgz2Lm
         p/QqA+HoHUCGrxfFNS9f8n9ptg1cGBE9TCUaB6QQ/h2sLMqueFdKWG5PaZSkbYlplpfn
         bB/FpPvWTJBBj3jFjEZYogfoPuYsQKkQVvBB429W79aLpPwjJRe5GbHIfWP+4W9anyRK
         BDPBUYTA8xCXl2T6JPMCcc/BWeAzGT+EwK/jDEiPoo+ow+oXHFR9x+4RocMFNrmHIrpJ
         jnTa65GVBJpieDPNCoyAili3hvGDxaxMwChJFe6zN6ulMUDJ0ngk0e7K8/lVSEUOoVSy
         Rssw==
X-Gm-Message-State: AOAM531AZNyKFVdnd502oW600R+a/bb/PZk+//E0akiglCIv3EYRuSmJ
        Q7D3lZxrBtFQgWs9Dz92FXh+WxAj6/cY1wLi18k3Jw==
X-Google-Smtp-Source: ABdhPJzQ5QYIhqOpvERr1myvJurp845zTwfOAnelOkuN8whUeZh+HMZAKphCIVeRCm1fCvEW25m/pSSutSQDBrs21Ko=
X-Received: by 2002:a67:fb83:: with SMTP id n3mr14818691vsr.5.1608632563688;
 Tue, 22 Dec 2020 02:22:43 -0800 (PST)
MIME-Version: 1.0
References: <xmqq7dpeqrz4.fsf@gitster.c.googlers.com> <CAFQ2z_MtpPNSpL9=OoyPfDRfkFxnCO19qBDnY9bnZiEEGtuMsQ@mail.gmail.com>
 <xmqqim8vm41g.fsf@gitster.c.googlers.com> <xmqqsg7zkk75.fsf_-_@gitster.c.googlers.com>
In-Reply-To: <xmqqsg7zkk75.fsf_-_@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 22 Dec 2020 11:22:32 +0100
Message-ID: <CAFQ2z_PuPcpuX6OQ3r7yYuOwaGEiT0xNaCnVNq4xE-mW-5sezA@mail.gmail.com>
Subject: Re: [PATCH] SQUASH??? allow t0031 to run with any default branch name
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 21, 2020 at 8:55 PM Junio C Hamano <gitster@pobox.com> wrote:
> I'll queue the following on tip to force the test pass, but please
> squash it into an appropriate step in the patch series; fixing it in
> a different way may also be acceptable and welcome, if you or others
> can come up with a cleaner way to do so.

thanks, I've folded this patch in.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
