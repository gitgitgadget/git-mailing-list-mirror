Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D860DC47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 11:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCC81613CA
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 11:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFJMBM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 08:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhFJMBM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 08:01:12 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0301C061574
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 04:59:00 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id 126so1736851vsi.0
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 04:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H377yYXyLPkPuABXYYBrMYWscz4cTizeDiru+yKtrvo=;
        b=jKeAKwooH6wlTuiEcy6M3kqMdvKfch8XUs2NbvMFGHRdVd9mdtGpGVj9qB+7+tzGbp
         ZUa2H3HaP5nBnuGGOu7WpClOEQLKNZC4Cdeb0L/u9A//L+pu87Ej9pmzJIcLDaLKH10R
         ZYlTcY500mRK98FLNJ6wh43idYJNCGzlcR5tYTV91Ja7akbSGzGw306R2JV9kxfm+vNV
         twpvOSJpyMujMKa1oz/Bhpe/UJPtI01B0dAwp4nmDl/9HwpR3BvxnE3oKs5r6sCPiZDU
         6tslHH9dx5qUwHxyzfQy5lnfnTmQekk8IA8DRIQ2Up1C6zafKEVtWX6+cmSmjz8BWYZi
         c2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H377yYXyLPkPuABXYYBrMYWscz4cTizeDiru+yKtrvo=;
        b=QKjuFDHVqrU0FIy2XRurimRWzUlYDHJpsJExzGua7B3TE3PnD3ZnC47yvnD6QV0ImX
         TEyHraSCwYcQg+pW3q8Z4KKjiYGdRunmOOVIkN40yDVMsJNCPa4EUXB+USr6ou3ZZwGx
         Igkh9/eLMakBf29D1/ONeuMOFkEctTkq1KkqG7FKs9YO5NFEbZYvixERRLBCuv//ikCF
         jEZD+qZYroC01Q/cy7bdNPolesJraLl7NSnU21IpM+1U08jur8tN2BLcAMMIOP4BO8rr
         gKyrH6FStW7EZ1datkpkNwr/mqvN4/v4smds6g6oWJCKuFt+YhQX0fNJlw++FK2i/YG9
         DNbQ==
X-Gm-Message-State: AOAM531nA5ywXt4ZkFD9ToIHRHQMjBd26DRgaTd5xRTrCCmx4/Dm+/GZ
        KujXF4HWdJF3Nv2+KP1Uir/4n3ueTThQLisknlLSzg==
X-Google-Smtp-Source: ABdhPJy+8LlV2RwgHs/yTh6vMgqbkqgO3hT3+tQ4iMqdA2X2/luc8OeW129dfnBWMtBpsr+OHz6I+9XqBlS3FvVGYzc=
X-Received: by 2002:a67:b24e:: with SMTP id s14mr3554297vsh.28.1623326339971;
 Thu, 10 Jun 2021 04:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <95d64d73353d8689e3928b8c9444490d0cdebfc9.1619710329.git.gitgitgadget@gmail.com>
 <20210603025553.349758-1-jonathantanmy@google.com>
In-Reply-To: <20210603025553.349758-1-jonathantanmy@google.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 10 Jun 2021 13:58:48 +0200
Message-ID: <CAFQ2z_OfRGG5kF2OhYrm5OLMOOmz-dHd+-ocWwC_7Tt+yBYmkg@mail.gmail.com>
Subject: Re: [PATCH 7/8] refs: stop setting EINVAL and ELOOP in symref resolution
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 3, 2021 at 4:55 AM Jonathan Tan <jonathantanmy@google.com> wrot=
e:
> I don't think this is related to avoiding errno and conveying error
> information through an out param. But besides that, as it is, I'm not
> sure that this is correct. Even if EINVAL is not checked by the caller,
> setting errno to EINVAL here means avoiding exposing a potential
> EISDIR/ENOTDIR that a preceding call set. Same comment for the other
> instances.

You are right, but it's probably moot, because the follow-up commit
stops using errno (making it impossible for EISDIR/ENOTDIR to
haphazardly appear), but I dropped this commit from the series.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
