Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259DFC433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 12:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7CEC64FFB
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 12:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhCLMBV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 07:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbhCLMBO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 07:01:14 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06C3C061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 04:01:13 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id c12-20020a4ae24c0000b02901bad05f40e4so1469136oot.4
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 04:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7VKVvHShiX4yuxYbTWHFMyGa8UjdnovES/LK3+d9xO8=;
        b=d6bUqfDaTAdbxzRpXk8LdmFWbS/q9lDlea4vpXWoiQ9lHo8YE/hnIrQrGknqcGimu9
         stzEs53M9OqrkKE2zZdcgSWORP0AP/iM4uchIddyPdhWzwo6+hh0EWOTdZahXvY2sYsX
         7eyukevsqnJ/NjPtLUOBfTt2JK3euDeUFJUmuf+JknIY/M9vA7F7FAG9c6Aw1rRR0EDV
         RUASCcsyFE5Jfi+nOLjN4Cvw3eljff2PaGqaVtesmO/4Af/3mg79LWzxDRgj98FtQRJT
         cq5TJkHdNocEST1INBl7pthgxSBMrtLYlVTEaTWk6MP87kZu/9fMTiqzITwUflqR4Cat
         H8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7VKVvHShiX4yuxYbTWHFMyGa8UjdnovES/LK3+d9xO8=;
        b=lk69EHqFr+07InKvsdDlWSoX3m22DS3num5+fIQXkgWJRk+qhG48CrwDQB36QGPfbs
         2knHeSkEs4AYiDVVaQgxFF1+xOFPh+QXPaOcOgXvrGgZmwunaIlueDgg/it2ExCtiHrU
         Y8tRBE1g71R91iIZC8v0TvOi+vKtLVi74B7Vtuvqk9EgzxYs5bfrDcpUPtbn6WmZw7so
         zTuyrigWzrN2B7ZXNKbPU9BLBfWCw2lfl3l/atlL19q+dauw7Mzho4TjJJjedJCtxqQJ
         ZD/2Ihp9FFDBQxwDQ8lTSk4+al1AA79aBHe7GLkvV5RUGpOTLBNRifzrOLiDOzunkiOY
         S5nQ==
X-Gm-Message-State: AOAM5317dtSlY04XZJLZqTgi/AvJ9V3KH7v9HVHtbgTT5PubMMi5Nt+z
        pnyjJrRiH1nxrGTloKU1elgG2dTcfr0d5inOZf8=
X-Google-Smtp-Source: ABdhPJz3tkmEHhpZmlvl/UJIGDp8MwORSG5Av1y9+P5WIzJW2PUMhHlWApEl+bjM8jCjyHn41RNqbzf9LCtB8FbYWKU=
X-Received: by 2002:a4a:4958:: with SMTP id z85mr2950194ooa.3.1615550473301;
 Fri, 12 Mar 2021 04:01:13 -0800 (PST)
MIME-Version: 1.0
References: <pull.901.git.1615446968597.gitgitgadget@gmail.com> <xmqq1rclfvl0.fsf@gitster.g>
In-Reply-To: <xmqq1rclfvl0.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 12 Mar 2021 20:01:01 +0800
Message-ID: <CAOLTT8RWCnaWLbVKdbVtVMSPAgvvCpv_PG3uaOi2gb3_=xwz9w@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] commit: provides multiple common signatures
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8812=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=881:29=E5=86=99=E9=81=93=EF=BC=9A

> Firm NAK.
>
> Especially, not in this form that squats on short-and-sweet single
> letter option names only to support the convention of this single
> project (namely, Git).
>
> cf. https://lore.kernel.org/git/20200824061156.1929850-1-espeer@gmail.com=
/
>
> Thanks.

Well, Junio, you point is It's also worth thinking about, This
"trailer =3D<trailer>:<argtrailer>" is probably the more general
version of the tailer I want to provide to commit, Then I may
need to know how Christian Couder `trailer.c` work first,or can
you give a little directionality guidance?

Thanks.
