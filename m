Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB35CC07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 08:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B383D61CBD
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 08:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhGGIWy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 04:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhGGIWy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 04:22:54 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84145C061574
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 01:20:13 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id u11so1136788vsl.7
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 01:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i0UZPa2r/JUI/Qf9k18jEuxegDLKTw/rxBdgJ66CZCI=;
        b=Ak5WH8fTmAG7iWS8uc7Y0pBEs2wqzEmidSv13WIwDgY4BdLekfpqN9IHvyVsBZD2Os
         xrB8XA6eMj2+nW+XHvM45A8LWQ77+H+I4t0Na1AjpBeaMdhlPSeGOQrcsYy/jlgY0z9w
         xxgnTz6P5GbFfOjPIORENfDJP5EfvHPwf94LlRnDNjnPsZyuyru0BR/Wx5yMrNkqNMZZ
         E1xbbZg7z7WP5Ds4f73h/mYv7IIimKJFmJJZZtbFQzu6kUuhgvbtAOUv6eXWZyphewcy
         ieI4S7EMkCaVjz/U5O/LmjbNoEwSZL9zu/TWqBBFvF8wSzzAqeIdAjwkcfAERxpLnBgm
         JkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i0UZPa2r/JUI/Qf9k18jEuxegDLKTw/rxBdgJ66CZCI=;
        b=ElLG0Ip7y3hcraxNInJVGIaLVmDS9sh+VqixNtDXxV8XDKhAv48RfNtDfNVumL6BYy
         qmZqEc2g786C7pK+a9aFeRLGLM2fd3eZgIeJ9dnWhD+EOipKbcB0e9A4fdPn+krKad7b
         UdoOfKnl7IgtzCkxentfQi8LxevCJEy/ceLypVKTALcWpi1j3MC2rJdmqGO1i/36hV2c
         jIgqsF+z4aF2aFdTaW+3az3eZbL8er9Ny/Dzn8E9ElFnpQLxLyoJLBSf8REyZrBqYHpd
         Gm+hMGxM2r+Sdid/aNf/X1WyElR2rmaKDftM5Wn86WJ+riXyH8SyJLEJvHnhJpwSFLVf
         VO9A==
X-Gm-Message-State: AOAM532iTWc5du5qRiddhHrR8ceFn5D9TBkozF5AceAeiNh5w+bcLV0+
        34MQPRF8aAoKlp+5h6l39A13zIOWIvUd2zpAygloyA==
X-Google-Smtp-Source: ABdhPJxT+PY8d56d65KQxcLFGsuZFNiIBBsvzWVkRbKxDSqw1Q2y8+7PxuXnnVqduSqjS8UuBZ/Vzx3OrsLfcYV+mSY=
X-Received: by 2002:a67:6992:: with SMTP id e140mr20175114vsc.2.1625646012313;
 Wed, 07 Jul 2021 01:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1012.v3.git.git.1625518566.gitgitgadget@gmail.com>
 <pull.1012.v4.git.git.1625597757.gitgitgadget@gmail.com> <ab147afb38d6e74e0e2fc1fbb83346e6ee32cdd5.1625597757.git.gitgitgadget@gmail.com>
 <xmqqfswrjksb.fsf@gitster.g>
In-Reply-To: <xmqqfswrjksb.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 7 Jul 2021 10:20:00 +0200
Message-ID: <CAFQ2z_N+uMCG9ewv-P0GgZQ90m5i6Hk_HYEsRb_WuBvPMZKFFA@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] refs: explicitly return failure_errno from parse_loose_ref_contents
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

On Tue, Jul 6, 2021 at 9:37 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Han-Wen Nienhuys <hanwen@google.com>
> >
> > The EINVAL error from parse_loose_ref_contents is used in files-backend
> > to create a custom error message.
> >
> > Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> > Reviewed-By: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>
> I think a -By in the trailer is spelled with lowercase, i.e. "Reviewed-by=
".

.. All done.

I also addressed your other fixup.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
