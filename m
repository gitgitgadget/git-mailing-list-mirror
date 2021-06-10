Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC09C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 11:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C841613F1
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 11:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFJL3b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 07:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhFJL3b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 07:29:31 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE4CC061574
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 04:27:21 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id 68so1655515vsu.6
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 04:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aY0G67nWsxZkD1Cs8O5VVlBJFODs7CMVo2T6Mn32NPY=;
        b=grkP+Kt3tXtVlO6cy2JSYHHKImD8c2VaIY4Y7E4hKOm0obVY/SN2fcGRQlMOrMyWSw
         E++TEtmYBMoFhiuXR84fnINBUAs3+RBL6mRpRG4AF8IsEX9sWjWVBjJgA/RHjQhM388G
         ZY1EKUJNhouR0uwHma7cu4EJkByOZ4/y/8A5CfhNYmObnQxSfgGjuC8MUsB70qrvRuJg
         sY7xYVm4y5vFpZJj8615DyrCwq91nMSN3Ae+22LrecJ6XcSQM2v1dYQXlnY3XYJ5wJuV
         PkAFDKcdzCGyOnlvJD5zma2PrlPk/laSBlhprOMHw9nC3fDNMdMJa+qHzNgesgR1pRsl
         rUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aY0G67nWsxZkD1Cs8O5VVlBJFODs7CMVo2T6Mn32NPY=;
        b=cK14y3opFDSz0sbu8BsLO2TJvU7NYMdIbwVEu2XOgEtwxAqzXi+AoOiOmTT9GOsNcb
         B/a+kgLnddXdn0iVzWBpc/ZOUg/nx41uxTdAV11exArYwwOccJDVvEmDYtrF+HB3kQ14
         /h77rajaVXXXNdKVwCAZFi/MQpjhLjJm0BdWWAJ+7soW1BjLOrBdb02tO5Mb9HRWssoE
         D+4A+c3L9plwg6He4WzVPK802ZCEbLmxx5V5Wc+SXVo8B4GBTCS3R8faGpPANi9X45LN
         DcHQ97OEMeDDuCqMnVUpFk/OskMFiI01bafO58CFEHhvsC8H52YoIARGLefvdx44aP+C
         eNvw==
X-Gm-Message-State: AOAM530wHgwivogBfuz/xojbEiqbytH4+8z2bcbYCn4Pjd6a8pHux9mL
        IJXfvYh7DTYkfhDcagMVVJWc5yorn6JhfUvCPtdpRw==
X-Google-Smtp-Source: ABdhPJx2TN3Oyo/uE17+AHwj/5XFbDgnLPeiDiePPAn5LngBEO4lknOqY+WBT1rdG1gE5enfGytVjYzivbNJSTuMzBo=
X-Received: by 2002:a05:6102:2378:: with SMTP id o24mr3967583vsa.12.1623324438614;
 Thu, 10 Jun 2021 04:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <dd3eceade4fcf09a679fdf20dddae247b4e0e879.1619710329.git.gitgitgadget@gmail.com>
 <20210603025120.348393-1-jonathantanmy@google.com>
In-Reply-To: <20210603025120.348393-1-jonathantanmy@google.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 10 Jun 2021 13:27:07 +0200
Message-ID: <CAFQ2z_OH=HGThdHZV+=K3uctfj-DRZ0GeCrCb7thsF91igJR_g@mail.gmail.com>
Subject: Re: [PATCH 4/8] refs: make errno output explicit for refs_resolve_ref_unsafe
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 3, 2021 at 4:51 AM Jonathan Tan <jonathantanmy@google.com> wrot=
e:
> > This introduces refs_resolve_ref_unsafe_with_errno(), which makes the A=
PI
> > contract for the errno output explicit. The implementation still relies=
 on
> > the global errno variable to ensure no side effects.
>
> Looking at the next few patches, I think the plan is:
>
>  - Introduce a new function refs_resolve_ref_unsafe_with_errno() which
>    returns the error information in an out param instead of errno. Right
>    now, it wraps refs_resolve_ref_unsafe().
>  - Migrate all callers that require the error information to
>    refs_resolve_ref_unsafe_with_errno(), and leave all callers that do
>    not require the error information alone (that is, using
>    refs_resolve_ref_unsafe()).
>  - To ensure that all callers using refs_resolve_ref_unsafe() really do
>    not use errno, set it to 0. (This is allowed by the errno contract -
>    successes can set errno to whatever they want.)
>
> If this is the plan, it should be written in the commit message.

I added more description to the commit message.

> As it is, this patch handles the first and maybe part of the second
> step, and patch 5 handles the rest of the second step? I think the
> patches should be more clearly divided.

Done.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
