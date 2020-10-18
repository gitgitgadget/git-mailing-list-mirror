Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9682C433DF
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 05:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84E942080D
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 05:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7XbWWLv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbgJRFkv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 01:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgJRFkv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 01:40:51 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22956C061755
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 22:40:51 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id f19so2011367oot.4
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 22:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tB2BT6tsqxpM6Vur8tERYpCi4cwup7XB3unIEETxz/w=;
        b=U7XbWWLvX/csksHOi14y19z9JlLEvjKbHOeHbRr1tcL1CMsnnjSo+wLV3IjRA3cd+t
         N5kDRpSWysurWTtmQBreq8BbTXNZgU6rhS6EtksrRlISpWz1WGbaiqkz01Q8EdhoNG0Z
         AUqRNM7jGpB7wE4U+T1bTVLa7gYyaPG6M0EW9Q2Prdb6M5pJ1OZ1dA5uVslcMohTyppb
         xb85HVgDhRr5CJJttQt5dMZrb7FiVGVm/CEpszBG4iNFRS2a70ATklbZzQQC/aatPwn9
         sQ8m1AkT8otvUlGvHevtD+a9bYUUXWRjl2ecLoqwqLFnAecTYAov+1pMmtxIBl+0k03J
         emVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tB2BT6tsqxpM6Vur8tERYpCi4cwup7XB3unIEETxz/w=;
        b=QBLxnlu+/A6t3YByqanzw53IS2uabQQW3SLj0Tnva9rDObKzx7P1NafC3JTcj6Gavp
         iL6RBDkhqKX0YbCW1ClWxVfbUIb3u+8ca3DMg7qtMOT6SfSEiLBD2i2+6trfjdAnqW98
         KBODOWDEoq1E4WiRmSNol24lV1GDapkChiO0hUQw/sBi1vvXoUewDUYFSHoOLA+U5d+o
         uGSHKTBs63DzWSffNx80F/E2Mc9pi/a0vxPL6MDyDOm6241qRJ+OsQBJkubGLCpFSHVU
         lPvnbJL3ww61zm2SyeXCHfdJb3CfbgVR+EDwfNTQ2XekNiHDH283bivbIAaI+AQFJqff
         H5Xg==
X-Gm-Message-State: AOAM531/C6nvaXSH7BKn5h6gP+40VW8fi3wecSjg0RuLbjLpCTNezK6o
        H3NK9PdXPnBmhwsIHwH6AOzeSLV4IEgfa81rniQ=
X-Google-Smtp-Source: ABdhPJxhTAXmmgn/u78zQptAmzy8eDtMVSp+sLim1zoYt579rrMvHjDVz9DDlaDC2m1MWOBpdv9x6uRfte+Y96h9qo8=
X-Received: by 2002:a4a:ba10:: with SMTP id b16mr8404284oop.75.1602999650413;
 Sat, 17 Oct 2020 22:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <20201015175709.20121-1-charvi077@gmail.com> <20201017075455.9660-1-charvi077@gmail.com>
 <20201017075455.9660-3-charvi077@gmail.com> <20201017151358.GA2837@danh.dev>
In-Reply-To: <20201017151358.GA2837@danh.dev>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Sun, 18 Oct 2020 11:10:39 +0530
Message-ID: <CAPSFM5cWx0c2CRVXxBO5Xq8AoTPSGmRa9x1hZom=cRqpOO4WkQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5][Outreachy] t7102,t7201: remove unnecessary blank
 spaces in test body
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 17 Oct 2020 at 20:44, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <c=
ongdanhqx@gmail.com> wrote:
>
> On 2020-10-17 13:24:52+0530, Charvi Mendiratta <charvi077@gmail.com> wrot=
e:
>
> Welcome to the list.
>
> > Some tests use a deprecated style in which there are unnecessary blank =
lines after the opening quote of the test body and before the closing quote=
. So we should remove these unnecessary blank lines.
>
> In Git project, we wrap the commit message's body to 72 columns per
> line (for more information, please take a look at
> Documentation/MyFirstContribution.txt).
>

Thanks a lot Danh, I will fix it in my editor's settings and will
update in the next patch series .

> And we rarely say "we should", if the change shouldn't be applied,
> it won't be applied.
> Instead, we ask the code base to fix itself. Perhaps:
>
>         t7102 and t7201 still follow the old style of having blank
>         lines around test body, which is not consistence with our
>         current practice.
>
>         Let's remove those unnecessary blank lines.
>

Noted, will update this as well.

> Thanks,
> --
> Danh

Thanks and Regards,
Charvi
