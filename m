Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2F2C6FD1D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 18:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjCTScL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 14:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjCTSbl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 14:31:41 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8092ED7C
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 11:24:16 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id f16so13091524ljq.10
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 11:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679336652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqWf+G1+rm1Ieb8LpxYaOKFtK4r34nV3Ijn9bnMATBU=;
        b=Rk3roGmF2+3YVWPsQfnPMwNoPnOlRRHZMyoVLk9ludYN8T2bIGwPiTTuEukTb8ADAY
         y9HY7K5irO8wIBV1hCC+4SaxiNu6LNFqensBk/6K9Su7r77SZB6xmQ/Ey3XMx7szmf0c
         9Q3tGT2KTWzt4TpvgcqciF0Gr5i0TE+izQGhtTEqeOJPCZmyixAFjZYZ0Y6ROXQoSNrN
         OB0WgNah5x12J487rk5aY4gY/quEvyLwiK9uFVczVEbvjyXUH59OI6/lD46iCu5SHCZX
         3sOPlO3N0xpjZQgbnph/7oqpfZZ7hAbMPyQ/7L1W0vIwTjw4X04uYRJik0arFGsScxPv
         EGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679336652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqWf+G1+rm1Ieb8LpxYaOKFtK4r34nV3Ijn9bnMATBU=;
        b=nLtd/QHWtbr7wXn2cdwqAQErKHZFrbsXabCSSNAP8FfCxlXORwP0HMwdypOu8zIkwW
         e8gb4wA78j8uG/YilmG0N1ddKZnlDrZaTEhDO7c2+eLY+yT0SRlAiusL5bfd39E4xgGl
         07pAQNif7cqaIk6ZBiUF92KD2xuf998Btc9uAAsTbrmr+lXmmE2VcJDL8tYohXeBqIY+
         MgI16LIZ7A8J74snI7paIY25mGsKUkzB46JiDKZUSsyZYCRGdf/Rt218DdnV0z/n/Zv+
         jFLRJMTo3l4wJr9+YU9tp+IucFoQaCoZo3sLQgz2eQlGbA0aC80rjxKAmGXWAE/mZ8H6
         oYWw==
X-Gm-Message-State: AO0yUKUOEjCVLRWH1S5WoIY29yI2Xs2u+yuWRnLD/MXAUI2/gLlyO7MU
        YGARJ9rFWiP8xupkAD2XhBBZu59JCusf6RV8x64=
X-Google-Smtp-Source: AK7set9SPsTkz4WJz9l9Zeuz6qoQaKucZZZBG3Vs5oDo4fOQbwfwnImbz6mvN0GiNAOIRRFvBUeNXv8u7MVjICZwakk=
X-Received: by 2002:a2e:740d:0:b0:299:ac1c:d8b3 with SMTP id
 p13-20020a2e740d000000b00299ac1cd8b3mr43078ljc.9.1679336651710; Mon, 20 Mar
 2023 11:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1474.git.git.1679233875803.gitgitgadget@gmail.com>
 <pull.1474.v2.git.git.1679327330032.gitgitgadget@gmail.com> <xmqqlejrmj4y.fsf@gitster.g>
In-Reply-To: <xmqqlejrmj4y.fsf@gitster.g>
From:   Stanislav M <stanislav.malishevskiy@gmail.com>
Date:   Mon, 20 Mar 2023 21:24:00 +0300
Message-ID: <CAEpdKfnWHtbZDFGhYhz81DRMiG8tbuw1CVWrd7ppSj++pODdYQ@mail.gmail.com>
Subject: Re: [PATCH v2] http: add support for different sslcert and sslkey types.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stanislav Malishevskiy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Stanislav Malishevskiy <s.malishevskiy@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Is this something that can be protected from future breakage with a
> few new tests somewhere in t/t5559 (which may also involve touching
> t/lib-httpd.sh as well)?


I am not sure about that. That required only  for local access to the
cert and key from curl


=D0=BF=D0=BD, 20 =D0=BC=D0=B0=D1=80. 2023=E2=80=AF=D0=B3. =D0=B2 20:23, Jun=
io C Hamano <gitster@pobox.com>:
>
> "Stanislav Malishevskiy via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Stanislav Malishevskiy <s.malishevskiy@auriga.com>
> >
> > Basically git work with default curl ssl type - PEM. But for support
> > eTokens like SafeNet tokens via pksc11 need setup 'ENG' as sslcert type
> > and as sslkey type. So there added additional options for http to make
> > that possible.
> >
> > Signed-off-by: Stanislav Malishevskiy <stanislav.malishevskiy@gmail.com=
>
> > ---
>
> >  http.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
>
> Thanks.
>
> Is this something that can be protected from future breakage with a
> few new tests somewhere in t/t5559 (which may also involve touching
> t/lib-httpd.sh as well)?
