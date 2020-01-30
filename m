Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3560C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 13:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630CA2063A
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 13:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="RXT0wMox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbgA3NgD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 08:36:03 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43282 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgA3NgD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 08:36:03 -0500
Received: by mail-wr1-f65.google.com with SMTP id d16so4026373wre.10
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 05:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HePXrGAo5CwkLczDnTLP+MUUARRcZT6rCcp/PnsiPQg=;
        b=RXT0wMoxBy/GclDcJLEVyh5Or6jgyg38iU1cC8yLHsaJVVkM2p9XVPaiCLrEymvvdY
         gje8Z5HrCVgbfRk7BuTZNTgBNBtggW0EEFAk/HXI+drJaTHplI4rVK77kXGyNp6gyxv4
         W1zSj6YMm6+g8sto7h7YhhkkAywr4aOEKCZMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HePXrGAo5CwkLczDnTLP+MUUARRcZT6rCcp/PnsiPQg=;
        b=hTsuj5HM0gPi7s3MCvMAr1AhpwEk3gMTEcar7bYrGbafjlAoB6Wgjoul52sDV7wTsr
         1rWr4oq3/2IBLH6YUaiWw6/LFE2lqbX6K84upjmVhne1yQZUrOTovPVJ3n6fRfxWFh7z
         5rcY9BGR0j5hfUGSqBOqinM4RqSNEYTFTQb7fAHS3POFwWjApaDAbcuhXWlQm3ikgr8z
         InVFTZVh+gavlWUhRIalPUV1zCdJjvEuR9a7RQacHKP9Uno4Q6qZuOvMVSe5PPdkoweQ
         v2EM/gSQZ02IaaIxUd4LetBEZ9+sWicFmqpz4bSU29Kpg12VG4C44sQ74M/mzx7OLOKq
         GaeQ==
X-Gm-Message-State: APjAAAUylCmbXNB7zc1vYngYz1cscW80KgxTYsd1yQ19tLdGAPbd0DId
        tkczNd2d4lbyRus+SRB5y9mR6rfjchgEOro6OUFk/g==
X-Google-Smtp-Source: APXvYqyeI0O3oeUX+VYyA2MzFMX/xsoRmojeQ3HjINdEIxoxr3gn6pCkEBv9T35ozTC5j7j3W3pgPFQaL/mAXhqx+Z0=
X-Received: by 2002:a5d:410e:: with SMTP id l14mr5456979wrp.238.1580391359929;
 Thu, 30 Jan 2020 05:35:59 -0800 (PST)
MIME-Version: 1.0
References: <20191213235247.23660-1-yang.zhao@skyboxlabs.com>
 <20191213235247.23660-2-yang.zhao@skyboxlabs.com> <CABvFv3LH2tYbobn8xBykyC43FB+z16FFOSAX1XjTLFZ2BUqZ1Q@mail.gmail.com>
 <CAE5ih7-LrK1XZgjhpx3qQqRMQ5MUf-e0q=45VY4cNhHV--nSuQ@mail.gmail.com>
In-Reply-To: <CAE5ih7-LrK1XZgjhpx3qQqRMQ5MUf-e0q=45VY4cNhHV--nSuQ@mail.gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Thu, 30 Jan 2020 13:35:49 +0000
Message-ID: <CAE5ih7-ngXsn1+RYSJ9qk_Ajr9x9zLRWNCyUiBGjg=sx_cOuzA@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] git-p4: python3 compatibility
To:     Yang Zhao <yang.zhao@skyboxlabs.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 24 Jan 2020 at 20:14, Luke Diamand <luke@diamand.org> wrote:
>
> On Fri, 17 Jan 2020 at 22:00, Yang Zhao <yang.zhao@skyboxlabs.com> wrote:
> >
> > On Fri, Dec 13, 2019 at 3:53 PM Yang Zhao <yang.zhao@skyboxlabs.com> wrote:
> > > This patchset adds python3 compatibility to git-p4.
> >
> > Ping?
>
> Hi!
>
> Sorry, I've been a bit busy.
>
> I quickly tried this and it was failing for me with:
>
> > failure accessing depot: could not connect
>
> It works fine with the interpreter set to /usr/bin/python, but
> changing it to python3 caused this problem.
>
> I'm at 050387ce43179f1b0da364dd6eec10ce578d6583.

I'm using it for day-to-day work, so far it's working well, thanks!
