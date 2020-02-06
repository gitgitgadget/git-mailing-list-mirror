Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6DEC35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 19:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFBAA21741
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 19:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wx32OUz+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgBFTxB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:53:01 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:46386 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbgBFTxA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 14:53:00 -0500
Received: by mail-pf1-f182.google.com with SMTP id k29so3637178pfp.13
        for <git@vger.kernel.org>; Thu, 06 Feb 2020 11:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r7T8ja4dc3w/RYU8CrHB91b6dXe+H6YPS9J3mW1UqfA=;
        b=Wx32OUz+maQ7t4TtrO+7M7CThkVXS1Mx/VicrbxDegnJLEZB/8pcc7D5iI95axNvZP
         Z6AiJYc9CzO8vDdb5jxY73sndd4EQMRBeXZbpQYunTJ7tdR7sLCBbe58PMwN0yfOmQN/
         EPjB4hz7NaXlpGdPV/95YDPTj3Cnhu2kspG2X+NFubrFwNopnqWO8Zo3DCv4A6yxrroK
         ifT6bMBpNKvDu3i8knjspU5cCTIqtSUHjs/V03mlRHp9ROvhSwS4YgYY1PKxwOpF9C0t
         dNkTOn68hlCKYOkETuSQ96EDByCoiw8O4WAa/DjEF2+cVADNz/9WDGukOuF992Rcj4cn
         73+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r7T8ja4dc3w/RYU8CrHB91b6dXe+H6YPS9J3mW1UqfA=;
        b=ll9jtc0DqrCaCzQ/TO1AM9DfUWpDIW3twdP8ze9WaPOUWNSJFMxB0knuWt8yXXeeTw
         M4CMotmW8N6onPavE0SkUcY+bmHXIr93yUcjsH+MANpGEo9wFQZ5fi8dYgKWHQJk7QaY
         Xyo+HAjhgl/A6H3LraywBDXbJrWR90j7WG7amOX8AKsHqc9ubnmaSQLR3GiEBsgxnsLl
         8ocDfgi6JpIm+AtcSQv7iq1s+nhGX9+nFFuWmcUj4gVSQtWt4f681DzM7VWomTLjxXY+
         gglx/P6Lra41mZ3VGuC7MDvqJf2wFd0AdJH0gFRPtwk6c+ty93ac0Ffdu1+Uzd2gNXd6
         0+Lg==
X-Gm-Message-State: APjAAAVVIQST+XvtTh3cBAO8/CEVKoj9lgwJ02Dp78E2PuIgE/s+J7Vj
        OpDPI6SHpw1XQnNiJqd76Rfnv7qqNpTjD1GN7Fg=
X-Google-Smtp-Source: APXvYqyyABcciEqQmcKYnUeU7Ui66DaFc5xpklGCcNIc+X4zc8FcAJfkM20F3mxDL//Ja9sMQueVbzNoWXxakpjD7iQ=
X-Received: by 2002:aa7:848c:: with SMTP id u12mr5470563pfn.12.1581018780236;
 Thu, 06 Feb 2020 11:53:00 -0800 (PST)
MIME-Version: 1.0
References: <CAFQ2z_Pac6yb9Vi782VMtPkssNmdc08WntS7xRt8KCFfM6KVsw@mail.gmail.com>
 <CAN0heSqoU1NxOtwaE_ZBBzghLXAeC4CxVh1x8R-efOVtbHdA5g@mail.gmail.com> <CAFQ2z_Mez4khfvXx6R2K9JPagmoQWD-ZnT7rFiAW9Avjt=4PpQ@mail.gmail.com>
In-Reply-To: <CAFQ2z_Mez4khfvXx6R2K9JPagmoQWD-ZnT7rFiAW9Avjt=4PpQ@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 6 Feb 2020 20:52:48 +0100
Message-ID: <CAN0heSrOvAdXs-8n0Cz4NMHqoxYfpStUOZcPRT1iQnA3R1srbQ@mail.gmail.com>
Subject: Re: Printing a uint64_t portably in Git?
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 6 Feb 2020 at 20:15, Han-Wen Nienhuys <hanwen@google.com> wrote:
>
> On Thu, Feb 6, 2020 at 7:00 PM Martin =C3=85gren <martin.agren@gmail.com>=
 wrote:
> >
> > On Thu, 6 Feb 2020 at 18:54, Han-Wen Nienhuys <hanwen@google.com> wrote=
:
> > > What is the right incantation to do printf of a uint64_t on OSX ?
> > >
> > > Apparently PRIuMAX is to be used for "uintmax_t", and not for "long
> > > long unsigned int".
> >
> > You could cast it? Grepping around, that seems to be how PRIuMAX is
> > used:
> >
> >   printf("%"PRIuMAX"\n", (uintmax_t)var);
>
> Looks like the inttypes.h standard has the defines that I want.

Oh, cool. We handle PRIuMAX and PRId64 in compat/mingw.h, but other than
that, it seems we rely on these being available. There's some discussion
in ebc3278665 ("git-compat-util.h: drop the `PRIuMAX` and other fallback
definitions", 2019-11-24).

Martin
