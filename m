Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC37C07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 14:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ED216102A
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 14:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbhGOO5m (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 10:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbhGOO5l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 10:57:41 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F15C06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 07:54:47 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e13so5240767ilc.1
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 07:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZkPDREckmFYBjZ4zydPCWNVI59RZfoFNgh8g6pZtFcA=;
        b=E17BgW6EJiTlAmn2+Fvsf8P+XvURFIhdU09qLRpPQMnPFJOtSvB2jyVTG49aC1zVP6
         myFLppZkSkl3a9ZnwUa25oper7owISLjb4gCliJdz/EdrkSxpbALhaobFxuwqsiew3wC
         xnH0l1PBPgyt6rYTd1SiCh4xAehIdwXBOefoXm7ujaWPLb+SNtlV+SmpRCGdB+HqnfKX
         ido5MPjVG9WZmBEWOnRYMgZ7QH0bujmocVc7/Vb81v0O86nad0hQrR0dg/b82GK2E3of
         qr5Ug/Yiiaw2PMCm2LJZVx2BULyy1fZ1/s3jgDBLkWw8xodR6HeyKQT6S6SscLQIWXcX
         FwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZkPDREckmFYBjZ4zydPCWNVI59RZfoFNgh8g6pZtFcA=;
        b=Jv2gen/X8j20bExpWpMogSKpR0ZHvyqOU7PtseM+vCFSKGw2LLtjfWlsZbbcumMz9x
         ev3FFIcSj1VxMnKdW4Y8AKJWk8toBY70B20Eeg+wvRhEw6W/vPPJPkQP0aDwqsNRlX0N
         7PTHGdpHBqeY8jN5UyKwQ4Bbyh/Mcx22tPqsI1EKPZYWGpHeqtj4H+TFFnVm7sG5X3j+
         SkyKofjypFNSdJ5Mefa19FWVwMT5Q7wPVIihMH8V5IkWdNgFcx+c6A2bpsspn16hYMrv
         GoCP8o9/IMmBoh9DG5ZiR5LzVgcTNUXFQTYcR6xVEXIXAYTDdjswV479NvaUVKmF0b1N
         hroQ==
X-Gm-Message-State: AOAM531I1m5rSMIFT4TCAmyJMklt+B6ebxibm9tpPJ0R9G1205bRF1ai
        yLEzDK2Z5Un8mBVkGKzGTtsJtDyO1Zk32mjFqlg=
X-Google-Smtp-Source: ABdhPJwmusFcb6a82QzWDMJ4kOut9RClIHEsqyV4wfR2YvQ2I+UuUdU/Qkf5SxxFzEVuAPoMVf2KWwdQ8p83B+K7tTc=
X-Received: by 2002:a92:dd02:: with SMTP id n2mr2731826ilm.259.1626360886971;
 Thu, 15 Jul 2021 07:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
 <70e83e4ba3cc8a55bb8d90cb2c581cd04ac116d4.1626090419.git.gitgitgadget@gmail.com>
 <CAP8UFD0vHw8cK90RbOUcrAcxNKiHVTMX0VEiK8+MNyHH0CNm4A@mail.gmail.com>
In-Reply-To: <CAP8UFD0vHw8cK90RbOUcrAcxNKiHVTMX0VEiK8+MNyHH0CNm4A@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 15 Jul 2021 22:55:01 +0800
Message-ID: <CAOLTT8SLMptcGf1mKtumVTAXdD5_qygeohtXvbCUuj39MOJ0yA@mail.gmail.com>
Subject: Re: [PATCH 14/19] [GSOC] cat-file: reuse ref-filter logic
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=
=8812=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=889:17=E5=86=99=E9=81=93=
=EF=BC=9A
>
> > +test_expect_success 'cat-file --batch equals to --batch-check with ato=
ms' '
> > +       git cat-file --batch-check=3D"%(objectname) %(objecttype) %(obj=
ectsize)
> > +%(raw)" >expected <<-EOF &&
> > +       refs/heads/main
> > +       refs/tags/testtag
> > +       EOF
> > +       git cat-file --batch >actual <<-EOF &&
> > +       refs/heads/main
> > +       refs/tags/testtag
> > +       EOF
> > +       cmp expected actual
> > +'
>
> I also wonder if the above new test belong to this commit or if it
> could be moved to a previous commit.

It's relate to %(raw), but cat-file don't realize %(raw) before. So the loc=
ation
of this test should remain unchanged.

--
ZheNing Hu
