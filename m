Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22481C47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 11:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAC7961287
	for <git@archiver.kernel.org>; Mon, 31 May 2021 11:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhEaLGo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 07:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbhEaLGf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 07:06:35 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFA8C061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 04:04:55 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id v9so11521146ion.11
        for <git@vger.kernel.org>; Mon, 31 May 2021 04:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Fh+zo3ZhOSPvcIE+EgI1t/Blm44SLwW+GBoEr5Yd/QU=;
        b=YPRFoe0Xt+MaqeiusUp9/HXQn09FgEsnQhP2QzIuxcJopR+l4s8d46xQnCjCNBDGG6
         RrknOsia6C/LRiAf1S0vO1K0eZ6Re1P+4qEOpGfLG5O9J7Y4JGKx+r2ZOTz9iIVO37RZ
         4LjDTJ6Nnpve0ENJSBrTzMfl4GJqEU/rRAsI7z69n/HQUqRVctFJFO+/TOIhA7+z19or
         Zzdl0V0394qv6bJ4n2D+Qnq3O+voED5BmXyOX3wjulmB65GIyB40FhVQNilctbAA4Qll
         FVOA4D/kec8c3p7L5F9FxqpU4NsPMQ8RO14dNfjWYIR5oEbnhgg3t+x5p0yRpSevnOoY
         FiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Fh+zo3ZhOSPvcIE+EgI1t/Blm44SLwW+GBoEr5Yd/QU=;
        b=DcmBEx7/FoAvRb/bvd1GVAVFPZxPvv5cxj/m8/ZgW0l8qlFbq/GDwpNmr6kovTLQd1
         XPvAbyZRcQqqGolONtXGcppdsQ9ciHPKlmsFfRYITXcMKXjF5pfS3pRodNGt+em7qE9K
         T/LTqTQFNOmqwjWrrwUoIjUFeQEX7QaCPVmjp94cpNFdfJudby2Wcsh40pxzrFCYQnJi
         VV4r163++TtwzSbhM5HnluhqKeSrPibV/PJyKEoxMy9Oou1aFUCSbztzYf59uZByg5kr
         CvhU+OF8B0FWHMwh51VHolajys/ZA2HGIxCRNSFoTqIpAWahGUn+SC5APfAB3FScujCi
         rJ4g==
X-Gm-Message-State: AOAM532bXx2v4rWeINPG8UD1z0X54xugtbMRl5bYYWFE9A2QaPI7igjy
        oofVaLZi5WeQnRh+vtoFdu/OTRxWR5VaB1mdiq0=
X-Google-Smtp-Source: ABdhPJysMTmUdJep/+BHmbxQFNgkk3gwv2Qxb0YmZMOLkqGUmBGQuKsQOgfifWkZ7rwqu7KAReTdsVgkLvjD4NPdVJk=
X-Received: by 2002:a05:6638:144a:: with SMTP id l10mr4772634jad.50.1622459094720;
 Mon, 31 May 2021 04:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8T0XtmpH3cHDBOfcX5nmCzfyrKby4TrFkHtA9H3dDN63A@mail.gmail.com>
 <60b3b513537ca_b8852081a@natae.notmuch>
In-Reply-To: <60b3b513537ca_b8852081a@natae.notmuch>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 31 May 2021 19:04:42 +0800
Message-ID: <CAOLTT8RWY2AOoXb1DM_dpxQ=Bi26Dj0_W_bZNU9rqeNqDp7ZgA@mail.gmail.com>
Subject: Re: [GSOC] Git Blog 2
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=
=8830=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=8811:53=E5=86=99=E9=81=93=
=EF=BC=9A
>
> Minor nit: some projects are GPLv2+, and those projects are compatible
> with GPLv3, but others (like Linux and Git) are GPLv2-only, those are
> not compatible.
>
> So say GPLv2-only.
>
> (In practice I don't think it matters because at this point probably
> most GPLv2 projects are GPLv2-only)
>

Thanks for your supplement, I will correct it in time.

> Cheers.
>
> --
> Felipe Contreras

--
ZheNing Hu
