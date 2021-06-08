Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0845DC47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 12:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFB2061287
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 12:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbhFHMeb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 08:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbhFHMea (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 08:34:30 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDC4C061574
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 05:32:37 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id k5so12193825iow.12
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 05:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/Is4wfbRgPh0TJeWnzD8ZeLyp+690c/UA9fbb93NZZo=;
        b=FvDmCO4Mx3tnTr5RPjYSaiflIn95ER0/r0w9SJdtaVHifFyeMcUH0Go0q6zbNU3rnc
         uafi2Yi3OkICRtZFsMTnnmKJux0ES4fBFPjA+TwhBUiXZddrkvgvZRJ4S4VcVtEufUXF
         Tx5AENb7YTDwSHBdUJhvq5SKsbo8cZYt7cxmCPPPy38HFiUYNad62mJD1nhVUk7/FiNB
         YeYmPRIX6jzL35G6kTkEsfHEerVIDd6dYuRMbzzSHIOmMTOoXuokl4vH3UNnCTiTNwH+
         mUZcgVpM59+jOU7+cWPBXg95ctCEvGKUwI9jcEwp1uHVcxcj+U0YGcOHHYF2rJZc7HlP
         I0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/Is4wfbRgPh0TJeWnzD8ZeLyp+690c/UA9fbb93NZZo=;
        b=AGMdl7OiIB1y/Im0PWCkU2kDHLPJ04SWeA0IK6EJgEk45TjdNf4Cxq73rbWy6SqzH3
         t6qkyk5ecpk5e5UbknecY6WmjLUxJ4F1v4Qdb4Hk/WMoxnQBcWov+o9dx8ieqiSc2PDZ
         wPwS16wtRipWJkNXO3WRuoVY+AIxo2SNo8QCcso5EXnsB2PZ57BwvqF5KdaAgBt9apVe
         z6NxIM+OP4Hqwci3jNu8z/aBjmgP+C+tlvYjYlssaNxpGv8d0v3dJYD8Q1pMQ2dfeOGt
         IlVLiQR8klUclrFSspH896AyHkd6QHELbYd2hpDxaZwnb37hxPFl3Ukmu/H5KSGQZOFJ
         iy2Q==
X-Gm-Message-State: AOAM530Tdkgszs9cECzwfjSZCWrwUvGKMjczBo+KCpu99EWCgqOcabUC
        ftRhxC8gV4PxRewMpwJ/agih1KEKNcGlEl1CI/WaOfs0pgKUKP80
X-Google-Smtp-Source: ABdhPJxchIcheuKOHxx20ZtGqcYFLRHonVDgRjr4YH+PB6fhGbc9yBiIF3/+2S0vdc3JC4JsGPgHsbR9qVNrHNpdHJE=
X-Received: by 2002:a5d:89c5:: with SMTP id a5mr19083812iot.172.1623155557307;
 Tue, 08 Jun 2021 05:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <pull.972.git.1622884415.gitgitgadget@gmail.com>
 <ccdd18ad508824aa206a02c479229d0ede69522d.1622884415.git.gitgitgadget@gmail.com>
 <xmqq7dj6w7a6.fsf@gitster.g> <CAOLTT8S+5m+-XF-AcQi9t8njTvyDYzHt=BU+4OPcvTT27RP6dw@mail.gmail.com>
 <xmqqo8cgq28e.fsf@gitster.g>
In-Reply-To: <xmqqo8cgq28e.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 8 Jun 2021 20:32:26 +0800
Message-ID: <CAOLTT8SfXq9k1EHOx5a+26Hm5Xk8NerREUb5N6fOcAOv0GOZsQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] [GSOC] ref-filter: add %(rest) atom and --rest option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=888=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=882:50=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> > First of all, although %(rest) is meaningless in ordinary circumstances=
,
> > ref-filter must learn %(rest), it is impossible for us to leave the par=
sing
> > of %(rest) in cat-file.c alone.
>
> Oh, there is no question about that.
>

OK.

>
> I don't understand.  Why do you even need to add --reject?  Why
> would any user would want to use it with for-each-ref?
>
> Without any end-user input, %(rest) for for-each-ref would not make
> sense, and %(refname) for cat-file --batch would not make sense, I
> would imagine, so there is no need to be able to tell --reject=3Drest
> to for-each-ref.  It is not like giving --no-reject=3Drest to for-each-re=
f
> and make it interpolate to an empty string is a useful feature anyway,
> so I do not see a need for such an option.

Yeah... I might have thought it complicated before. We can reject %(rest) i=
n
verify_ref_format() easily. It's like we refused --<lang> before. :)

Thanks.
--
ZheNing Hu
