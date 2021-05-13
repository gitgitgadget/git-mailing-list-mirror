Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB509C433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 09:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8288C6143B
	for <git@archiver.kernel.org>; Thu, 13 May 2021 09:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbhEMJbQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 05:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbhEMJbP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 05:31:15 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE141C061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 02:30:05 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id n10so24338248ion.8
        for <git@vger.kernel.org>; Thu, 13 May 2021 02:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Uc+IpijcAPMnJJ/JerCjUKYHWL5NdxIMQlNXsegaDUY=;
        b=jqCALLepZPVgJfjKGfiYDte/C9NgCPkaVujH6iVDbhpHVLB5/sq7Q9P9cD4os+AA4+
         dxI3Cm9DR+fipEiMIc+/BtM1nXPxmSnZRfFlkp2S/TPmzlp7m6izr9M9RAXkfdxLGcux
         ZTER/bkni63Rv/liVxdYIRlWafksdy3u0QuqqAoTX3HXTvNg/WYJ8QmZ+gyaOmahS6c6
         ppvndQFRojfKcK55Ld+48bIKWrAvxReUpTnXZYFj1LSXARntnBU1QdyVChEU2isJwSiP
         hFcIl4eGWMs4MTwx5gryRjtsjMTIiCWK46aBDqpKSHJbWpJHlP4/PacDLTSjLiQjAUPR
         2xrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Uc+IpijcAPMnJJ/JerCjUKYHWL5NdxIMQlNXsegaDUY=;
        b=uWDCtGGUVFqCHY0I/IS7iZ6x/5Dm7ZVMTG+uUD9VTSKyTasUnEd3LUp8kGHzKpGsXq
         8crvKwmMQWSEKNYCoBxlPDzdExjY30IZVYN/GS/ZRk3+YYxK7xYxPi+4X2KWG5qGoMVE
         R4rjghOsC6OazvOqCZfw06ky0CquWjs2NiwI8rE5OhTBKYe/jHqAD+q5IENtUNLVXpfN
         3m3ZPK1/Wi55vGFFNrbSRhqHRbwHXboBhOTAZO9ePxLc3D+EDQWbvi2/vRKKfp9/hEii
         HwePJOKpHVt98zJfdXi8irwVI7EIVS/HaXfDhcGTGmoFyQ9jkRO4otxPnSO6iyXTaIfa
         AVjw==
X-Gm-Message-State: AOAM532X2+xHD172vuru7ACI0JKsTMJ33usgiy3652VwRSwPb8t/1urI
        HHUaVa8T5vtqiUTR7TsDf1P8x0UMtrZVl/IUiYE=
X-Google-Smtp-Source: ABdhPJwskKQUDMNj70cWtmjp+smNF4eqimbGthS2Focht7TmO/V0rK5I4/j4QRONBC7kxB7hSvPsBt4ek5fNh/t6Bqs=
X-Received: by 2002:a5e:8a08:: with SMTP id d8mr30532496iok.192.1620898205348;
 Thu, 13 May 2021 02:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <pull.949.v5.git.1620747320947.gitgitgadget@gmail.com>
 <pull.949.v6.git.1620821572126.gitgitgadget@gmail.com> <xmqqfsyredsr.fsf@gitster.g>
In-Reply-To: <xmqqfsyredsr.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 13 May 2021 17:29:54 +0800
Message-ID: <CAOLTT8R0sXRLB5=ePGi9dSpKR+YFSYLtDPvoD8PhNzneF0=NrQ@mail.gmail.com>
Subject: Re: [PATCH v6] [GSOC] ref-filter: fix read invalid union member bug
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=8813=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=887:24=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +test_expect_success '%(color:#aa22ac) must succeed' '
> > +     mkdir test &&
>
> You do not need "mkdir test" here, as "git init test" would take
> care of it.
>

Make sence.

> On the other hand, you'd want to get 'test' directory removed after
> this passes, so
>
>         test_when_finished rm -fr test &&
>
> would be useful.
>

Well, deleting or not deleting the directory "test" is not a big problem he=
re.
Delete it is ok.

> Other than that, looks good to me.
>
> Thanks.
>

Thanks.
--
ZheNing Hu
