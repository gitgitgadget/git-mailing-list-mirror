Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EA8C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 16:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1AE860FD9
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 16:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhHQQjQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 12:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhHQQjP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 12:39:15 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C8BC061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 09:38:42 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id n200so1408743vke.11
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 09:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0+ZbtWGGaehjgrLcXZ1BTwOu6ex/Nj0Jd/7+t6ZxSIA=;
        b=jIclugnX43Y2AOFGPz7/Hgvncy4dPbkqQyvOQcOp87gOwueHOy+hWN93iOF6TG7jOu
         t5fsaNiPZuNP3E3Nwr/oqidqPM7ufEnmTNT3LZTM8oYluRyLkgooAQ4+LVBTT04dds8j
         69RcKvrl1hLhYSAFhuKfDfswQoEfiQtWo5XkwMzqJ+N9zAYtjTEaSalYEP7v+jPjNJUT
         Gf9R8Opa08o9kmkukrQOLEXXa87JAcpMUxUkUK/W9nXByCLRXjFHphUo4F1MlWq+xuma
         jzP4r5UydmCS3wT5rQq4GcNHf/zI3hG2GcNNNTK5PxRMU6Bx0b52ArS+f3Yp7y9PdwyX
         Uj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0+ZbtWGGaehjgrLcXZ1BTwOu6ex/Nj0Jd/7+t6ZxSIA=;
        b=JD+RQytI+dHOk6U4UEc6p8vW3PM1NqesUoLBeV5CUkzhwphg/WsIJQZBsOnhade0bQ
         chU1lGBQjteo1R/mizT0Dqsb4intVlSJ4UKINEa1TbMHdu69+Lu3IXzQAsab5rDomO5E
         p+DfqTTMmnh6bzcVQY3f7HCE0ClpqqR+2A6IU/RTwxC5m0FS4Auhd6GcsTuGIQmvN4vv
         /ogtbnhE25eMFWnGhSv2pOnnVS7Nw13jJmwCbilLnSc9WH1AefoMqiosa9O63kmpJb78
         VN4plAEpAGKPhBt9m2m+Y7M7UMVG4zDHzpQHWIyzyqlc4VYVLOGQ22+JIg87839T3VJY
         f68A==
X-Gm-Message-State: AOAM530y1JPlci8LMqbmKj7gaHWKQdGZc7hK3bsrZhGVsHiaLsI25TYi
        wQiiJgf0aOFmT4RLj756pr7KvGp2DuHDwv5hziqeeA==
X-Google-Smtp-Source: ABdhPJyemtFv5gUYP5lK/cJxLmy99dRclJW/ZWWnvh9sszUShgSye0TVoW+5ITQy/uryupjyfSFQl5/iLu6aCf0SBi8=
X-Received: by 2002:a1f:308d:: with SMTP id w135mr3424300vkw.15.1629218319828;
 Tue, 17 Aug 2021 09:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
 <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com> <xmqqr1etqfnp.fsf@gitster.g>
In-Reply-To: <xmqqr1etqfnp.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 17 Aug 2021 18:38:28 +0200
Message-ID: <CAFQ2z_N0s3-95CxVtj+HQu2AUiZoRK1N3gVAFg0ewOviQWmofA@mail.gmail.com>
Subject: Re: [PATCH v2 00/25] Support reftable ref backend for Git
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 16, 2021 at 10:49 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > This continues the work in https://github.com/git/git/pull/847, which t=
he
> > gitgitgadget erroneously closed.
>
> > Changes relative to last series (version 20 Jul 2021, tip: 4a5891f )
> >
> >  * fix HTTP serving
> >  * fix t1501 (use absolute paths.)
> >  * fix git-new-workdir
> >  * fixes for FreeBSD (thanks, carenas@gmail.com!)
>
> Thanks, will take a look later after the release is done; nice to
> see these fix-up changes already applied in the series.

You're welcome.

Slight tangent: for the series, the bottom-most commit (which
introduces the hash identifiers) could be a separate topic which
graduates sooner.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
