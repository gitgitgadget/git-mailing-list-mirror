Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58C3C55185
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 19:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DC3420767
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 19:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oB6H1A2f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgDVTGK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 15:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgDVTGK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 15:06:10 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11898C03C1A9
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 12:06:10 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id o127so3675261iof.0
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 12:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AKaSZBHs1BYOAsfCfJulFJ7CC6L5WQibj7X5LU9rDEY=;
        b=oB6H1A2fOpi2TzLXgNBtHmlx7ncQbGuSUlCPOTzOudsZLaoszWWhoiRi9e5zpvEVef
         klSRymzh3y62vi7gHjkQvfISXU3UoE9ImYCoQQyEJlEZnCd1tw1XFClQ3Xyq9xJnzTOB
         GoZ2JQAEFfOk6/RoPctCXFXR3+PCfCn/GiOlYtNHs6d4dGWs8k6B36uo6KkOhjTE32DY
         FIgtcJZuOP+1YaCUEuwP8Wv9Xied89s607/18bRQl2mvuNa+pnGsKXfTpeHJKrWdBaXV
         nFceQm3gxJn263S2W7BskOJ1/BydcB3QlOEP2nhZibV8Bj8YFSPQ5gZN/J8rfDqGe3d8
         Ba6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AKaSZBHs1BYOAsfCfJulFJ7CC6L5WQibj7X5LU9rDEY=;
        b=W4tUmWcyN4WuOWh/Jjdz06TsD+7yKOFTnp0jGDFI8NsdHyiuwWbe96qc1UaUNJ0Yko
         /G0ag1kBhdJuwSkFM1sRqAHk6HyHOL62LBzbl++R7vYX2+m+D/kT49ePtG0cCTPHoO1/
         x2lQ85iEjhRJRVscGWhoh/WdApg3NFyUpswHvZjIUJwa6mPwivZe+cNZ/W0YbxZsTz/U
         XAsbbGiYQdhEbdgN79M9Bp95U4toRKV0Oh63ahgh1CAMRjIor1B8fYnI1bfZrhtLNeUz
         5qzkNc/JfXA/4IPLc6xaIG83ZGOctB5zlUbcx/wePGf2NH2zrn/quhI+AfhVNsgF2yEq
         hTrw==
X-Gm-Message-State: AGi0PuZJLaggHOKre+kiEcXwPogs+J4qJ02sj4Gby5U4pnFHz7EUN4pR
        WEbsq7gbj5F/15ee81OGZZzvft1Mw9KDD23rp+c=
X-Google-Smtp-Source: APiQypLzOrI/yWD/9wprq8tw6rxCiUKLQ1ezatnpjFr8thw3EGOXOfmNFebgm4kQtxe++DswQ5Mc9G3CmA5R0cy5vr8=
X-Received: by 2002:a6b:7319:: with SMTP id e25mr155874ioh.193.1587582369332;
 Wed, 22 Apr 2020 12:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200422153347.40018-1-jrtc27@jrtc27.com> <20200422164150.GA140314@google.com>
 <CA+sFfMfre6W5GcPh1pWcroFD9S9OPj_uLp5CK11yh-UhqgDs2w@mail.gmail.com> <452EC7D1-BE96-4172-8F70-3E7384C87280@jrtc27.com>
In-Reply-To: <452EC7D1-BE96-4172-8F70-3E7384C87280@jrtc27.com>
From:   Brandon Casey <drafnel@gmail.com>
Date:   Wed, 22 Apr 2020 12:05:57 -0700
Message-ID: <CA+sFfMdudQ-cWbXajQ_92LZLOOOnTxmQmmsUo3dY1eKCL5-Y6Q@mail.gmail.com>
Subject: Re: [PATCH] config.mak.uname: Define FREAD_READS_DIRECTORIES for GNU/Hurd
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 22, 2020 at 11:50 AM Jessica Clarke <jrtc27@jrtc27.com> wrote:
>
> On 22 Apr 2020, at 19:48, Brandon Casey <drafnel@gmail.com> wrote:

> > introduced
> > this feature that would make fopen() fail when opening a directory for
> > use on the platforms where fread() of a directory did not fail,
> > instead of trying to wrap fread().
>
> Then the current autoconf test is wrong and likely causing confusion:
>
> > AC_RUN_IFELSE(
> >         [AC_LANG_PROGRAM([AC_INCLUDES_DEFAULT],
> >                 [[
> >                 FILE *f = fopen(".", "r");
> >                 return f != NULL;]])],
> >         [ac_cv_fread_reads_directories=no],
> >         [ac_cv_fread_reads_directories=yes])
> > ])

Yes, we should attempt to call fread() there. If either the fopen()
fails or the fread() fails, then that should mean that
FREAD_READS_DIRECTORIES is not necessary.

-Brandon
