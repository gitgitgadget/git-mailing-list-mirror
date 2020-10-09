Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E38C433E7
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 17:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B37BA22284
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 17:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvNiJhxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387943AbgJIRsH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 13:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730673AbgJIRsG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 13:48:06 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C43C0613D2
        for <git@vger.kernel.org>; Fri,  9 Oct 2020 10:48:06 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id n15so11165755wrq.2
        for <git@vger.kernel.org>; Fri, 09 Oct 2020 10:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WjSRsCTJ8aswV9e9NGqQD8RJD/oysXKVz6c7oTGTkkY=;
        b=AvNiJhxieru/bJl1eI079YQR9JRep+s6Y77Jr+ZqTNLGda4IHBDO6GU+q5fLDlf0rs
         QActSgG6eLLrf/l/zd/U07TkCz07CuR4vWfTismOCsKy2WRvyVG23Vf+ksDerek2kKiv
         P/QXrkOzAA3uqcAGWcRX7XxFa49QGneTGLLiSKUs4ps871zYTZuUuP9c+RdM6iwADb0O
         oSo9Cm7o/yPo4xQLXq2guvt+zh+3T36QdF06voxROForxjgGrKOcnXR4f8f+uSY9uJsF
         bXfZ4Y+DeK3lCSPBG4BM2hl+WZ3zqNntNvLca7uBYAGLtsYpbw7M++6fff3kE4iCk18c
         hwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WjSRsCTJ8aswV9e9NGqQD8RJD/oysXKVz6c7oTGTkkY=;
        b=awVl8hmd+zREseH/miHI7ale9LpybVOjogRov4bIQwJBc1+RkKvZ4ISgLCg29a/QWP
         sGnh5tk512dmaHQwHCWWQKw5SqmrUMwPoAa3iVw8NhlToke9+cv6dAVYNqsMqhrvB3X5
         7sCx3BpmCYXlfv8Iy0n5eq4LXkzAG0ehMiz39+Tbqb9hQ8NNHSU7kOjFA2a+qWLHv/yF
         o+vyvj1aoZy4wMo2qHwEvSJHf6bRYqxkpwbbQIO769ykqKO9B/sZE9O0QZ5eBpRC99uA
         EZBzbIsQ03ccpxXEnn6YWIw/9ACBpXlchKa1jL9hPBkCWt4eW5Gr74lNbZMrqUYErP37
         NYhg==
X-Gm-Message-State: AOAM530zV7Kd7Cs3ST5+wbunMzirBCPTgekpucOGyBQRvf3DGTRtCTaP
        Lkg8GgQYkcGBuffXvMO4H/0GZ6XQJVcHtwQvB3o=
X-Google-Smtp-Source: ABdhPJxICFbxMPoqfpXbx6os62+n1/bipbwL8tRFiT9Zn89a8ckjUGL0ZTQR3XY/t3jHOI/awpmWbrmT6jAPCdWCm8s=
X-Received: by 2002:adf:f548:: with SMTP id j8mr16876934wrp.114.1602265685074;
 Fri, 09 Oct 2020 10:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAGxm6oXSaKoTR3btKRV4bMYUsc3-oKeWSfzrWKkCXgrRorAEAQ@mail.gmail.com>
 <20201009002541.GB2415320@google.com> <20201009014319.GA2429084@google.com>
In-Reply-To: <20201009014319.GA2429084@google.com>
From:   Richard Sharpe <realrichardsharpe@gmail.com>
Date:   Fri, 9 Oct 2020 10:46:30 -0700
Message-ID: <CACyXjPxwmEzJ412CSeQdx=CwXExoZg64nKTkW8AP3rg=OBKEQw@mail.gmail.com>
Subject: Re: [Wireshark-dev] Introduction - An Outreachy 2020 Applicant
To:     Developer support list for Wireshark <wireshark-dev@wireshark.org>
Cc:     Amanda Shafack <shafack.likhene@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 9, 2020 at 8:18 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Jonathan Nieder wrote:
>
> > +wireshark-dev@wireshark.org
> > Hi Amanda,
> >
> > Amanda Shafack wrote:
> >
> >> I am Amanda Shafack, an Outreachy 2020 applicant who wishes to
> >> contribute to the "Add Git protocol support to Wireshark" project.

Perhaps Amanda could resend her introduction on the wireshark-dev
mailing list because this is the list for development type questions
and will get better responses for developer-type questions.

--=20
Regards,
Richard Sharpe
(=E4=BD=95=E4=BB=A5=E8=A7=A3=E6=86=82=EF=BC=9F=E5=94=AF=E6=9C=89=E6=9D=9C=
=E5=BA=B7=E3=80=82--=E6=9B=B9=E6=93=8D)(=E4=BC=A0=E8=AF=B4=E6=9D=9C=E5=BA=
=B7=E6=98=AF=E9=85=92=E7=9A=84=E5=8F=91=E6=98=8E=E8=80=85)
