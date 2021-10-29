Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18605C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0B7060D43
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhJ2VxW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 17:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbhJ2VxU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 17:53:20 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36774C061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 14:50:51 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id o26so20650101uab.5
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 14:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7QN6NPsdpi5edF2/0o5oSFB/mTkzSfA/43c+kd8VwxE=;
        b=fYrp4l8GFi1BWMwJbu/ENS/FzewwHaOAtDmxFAqKGgpTaYpWUsrYfMPmqNHfNU9UsP
         zTquujsgK+AV2fk/ymQ0rSVMgHLyasHVKnZgU5KY+pSCys7UrPsT62P1WOVbKllDJjn0
         pZQiYBWHd261z+9fHPUIUhx5kzX2iT7DQMEjccM1xIlSCeFCDr3/HG5dvh/eqZQH+8ld
         NszxDwQzsynoKn595eTtlwDpcykSopsEYrbOg83lVAOx/GFefcbeCHjq5+Wx/t8w2epP
         xVZDXVPvd91R8W6Qn+8YWHwlcpxbTcpnrDXTy47hlHEpHIq7vHZs472V22TUGfuSbzMZ
         ZOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7QN6NPsdpi5edF2/0o5oSFB/mTkzSfA/43c+kd8VwxE=;
        b=7Eb46CDKJlxhSTW29os454dZNdjLOGP8VClVPzlJ0Eue3MWSetNsbDO0A/9xHGmu53
         zWi4NJKx6Frt+ccOc6K8+eIsvhQKCvMFJZ9s9KxwT9L6ouRIDtsdtJ9I/A0N0xeLjNRE
         VQ/VLMz2sdoJjngjoJ6KVOUbtwRmW29V9EwE2q6uKWbolVHtqKk4ISCcA9SXKE/Kul/X
         TowaVmBYUkLx4Wd7bFI4n2TCwmR4l9GHx/iPDu/eBauXXrARugeZqtx1E9+IiMGSvXOr
         PJFC754sQAZnRNfSegsZomUAtmWpzfYqKKPIgZeTnYJ7eok2gmDUovvCLZ/yVBeu5ZVp
         M23w==
X-Gm-Message-State: AOAM533SOXwY6ou5hQdybgbC8aLe+5bIKI3mvUK3IWIut5HZuFBA+Qoc
        VN0NOjEm1Rp0C/bj2PT5PzKorAiLNVNhGRufpws=
X-Google-Smtp-Source: ABdhPJzUbO/c6pqhiA0BhgQ06eTCTrQpFf/4LBituujNJwVKpDSeZSUqeZT8TbvnCjJ0byapYaYif2ciVbZXDMvACGY=
X-Received: by 2002:ab0:7049:: with SMTP id v9mr15087693ual.138.1635544250413;
 Fri, 29 Oct 2021 14:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211029212705.31721-1-carenas@gmail.com> <YXxpjLhiguq4HY6g@coredump.intra.peff.net>
 <014901d7cd0e$042a3470$0c7e9d50$@nexbridge.com>
In-Reply-To: <014901d7cd0e$042a3470$0c7e9d50$@nexbridge.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 29 Oct 2021 14:50:39 -0700
Message-ID: <CAPUEsphuqsxUmaH6wRWi_+HT+ukyRxfuPe6hKoJt9kc-GRxBjA@mail.gmail.com>
Subject: Re: [PATCH] wrapper: remove xunsetenv()
To:     rsbecker@nexbridge.com
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 29, 2021 at 2:43 PM <rsbecker@nexbridge.com> wrote:
>
> On October 29, 2021 5:37 PM, Jeff King wrote:
> > On Fri, Oct 29, 2021 at 02:27:05PM -0700, Carlo Marcelo Arenas Bel=C3=
=B3n wrote:
> >
> > > Remove the unused wrapper function.
> >
> > I don't mind removing this if nobody is using it, but doesn't your firs=
t paragraph
> > argue that our definition of gitunsetenv() is just wrong?
> > I.e., it should return an int, even if it is always "0"?

I couldn't figure the intent Jason had when this code was added in
2006, but considering how Junio suggested using void for the wrapper,
my guess is that we really wanted to make sure nobody will consider
errors for that function as actionable.

> > Or is it a portability question? I.e., are there platforms where
> > unsetenv() also returns void, in which case we must make sure nobody ev=
er
> > looks at its return value (and xunsetenv() is therefore a wrong directi=
on)?
>
> At least on NonStop x86, it is
>
>        int unsetenv(const char *name);

I don't think there is any platform that had anything but int, and so
I agree with you that it would be much better if the compatibility
layer returns 0, but as you pointed out, this was the safest approach
considering we are 1 day after rc0 ;)

Carlo
