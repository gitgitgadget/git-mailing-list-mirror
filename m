Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2E1C433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 12:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353305AbiALM71 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 07:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353307AbiALM70 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 07:59:26 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E0BC061748
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 04:59:25 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id v12so4558607uar.7
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 04:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vzTzge2PbpjDdRG2EEksqU8bkEDWWdpY2QabCQBHmqQ=;
        b=m5cN1zJP5T/olxcuOo8cIqYSPoD0UucB5V2xleMpFPWivNFfivxTsnK8vWTt6uLijv
         wHAFOTBaGf/5WDwHiFzaTQ6V7kcZEb0iDeQUkDrhnfiWsGomdwVSsaYcAw4psz8J7EGi
         tf6JSqBBSAmraPp4FLlsL+EZdTh2AJweDCq3MEBx8CNUYt10ZrBnC+lJUA59b0cOOKqo
         Xme080/OtbAWxXLrrJgm4EPsjcYOVwPxmxigkSIBYp/AghXjENw6k7Csk/7qPjiyX/jJ
         TgCsKF1XNTufoe73QLT2Cl219tLksV/lwxPrzRQhmcp2U+ogs+F7ZlGu33UEC8+xQUZ2
         wE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vzTzge2PbpjDdRG2EEksqU8bkEDWWdpY2QabCQBHmqQ=;
        b=BLprdQH+hPD+X4knPwZLxGjJOeS206vmzCIL1gXW363fYJI9umginK6zHUuODe1etc
         S+LPfZsscrg+WJH6dQh1X3Js4ujLGtcmchBIbr7yCyXBCTYfmhve5IJhCMHlcATZm/sm
         o56DQdK9dhTiNpZqPqrDuxEdvrEFCchyETPGfZCtrfkDJ+yFn02QC6L0GJHu5FF+61Pb
         n52+Nf5T4bVvyjlUXhAZGkEFvnFAXMYD63PAEOe96ayU6y6VzVtR6Hy2/GjIArf0az+h
         bJpLwSMbYrVkhMvtKtoLDvSfOqySuAwNHPSxJsad1gIUDt2uHTQkNTM6HPSQ/JFp3xVl
         6AVw==
X-Gm-Message-State: AOAM5338zWrYH49SVGSAsbaNPQvzIcsu9PjkW5+JtPGUK/VvhaVimU/7
        0XgBJ3mKqwEcqXzfCU7IZ0TUSDJVs2Wk7HxI8u/TYQ==
X-Google-Smtp-Source: ABdhPJybrTxsg9LA/Q+we9fYSBXi82FJfEFfQzCIWUen+miekkh3nJ49MI8u77xANa+iYo+I4ynVNcbf+3EH/VKfngI=
X-Received: by 2002:a9f:2a8b:: with SMTP id z11mr319412uai.47.1641992364977;
 Wed, 12 Jan 2022 04:59:24 -0800 (PST)
MIME-Version: 1.0
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
 <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com> <e16bf0c5212ae85daa0d6aa2c78d551824b542bd.1640199396.git.gitgitgadget@gmail.com>
 <xmqq1r24gsph.fsf@gitster.g> <CAFQ2z_OXPw9-hLsaD+E1nGESS7eJH5o5sRrr_R_vW1Oa-vvZoA@mail.gmail.com>
 <xmqqy24a4oyq.fsf@gitster.g> <CAFQ2z_PDfreeGttTbNTbnr7rRJQFHFfLVD_hJu21QQAR1njPpg@mail.gmail.com>
In-Reply-To: <CAFQ2z_PDfreeGttTbNTbnr7rRJQFHFfLVD_hJu21QQAR1njPpg@mail.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 12 Jan 2022 13:59:13 +0100
Message-ID: <CAFQ2z_PH5p3KZoHHQ28ouSK3azy_o_wzEObfyQi=z7Bv5o4BRw@mail.gmail.com>
Subject: Re: [PATCH v5 16/16] reftable: be more paranoid about 0-length memcpy calls
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 12, 2022 at 12:39 PM Han-Wen Nienhuys <hanwen@google.com> wrote=
:
> this series, I'll just take a closer look at the current call-sites to
> see if NULL can really occur or not.

I've dropped this patch from the series. The only suspect callsite is
in obj_record_decode(),
and that is better addressed by other changes to make sure we never
try to do a 0 length copy.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
