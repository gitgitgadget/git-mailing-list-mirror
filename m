Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78638C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 15:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B36720707
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 15:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqUzuF/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgA3P0o (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 10:26:44 -0500
Received: from mail-io1-f48.google.com ([209.85.166.48]:38688 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbgA3P0n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 10:26:43 -0500
Received: by mail-io1-f48.google.com with SMTP id s24so4448675iog.5
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 07:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=hoPc0AIsLRiQBJ4+9F0u7OZxAg1G+QYq3fporFT1/38=;
        b=QqUzuF/Osj/J+pOCSUWuBLL8lO+u0CjxJjcAr8zzlc4OaxVmQbRn64ObepUq6/Dy++
         fB+o32riNiteclArsHU0VGAaA2CkXEJlCWR1TVUg2VRmGBj2UAgfdeLybwZNlTkDVhiV
         qHpy3WLNQ79aaoDasRs9j89pJGBNWQEfwmKyNeHbrbboS6WwPqnhKl3+fOE0gVG55DX4
         jPkA3eUvPT78jj3T4HK6MFVAzJatf46PjC8lh9D6UULpl2/i35GsKl8M6p7G7adttqPC
         YaAnl1sVYEph267OSnlsySFkpE1K6/8d9OEQZOu2XDWwA526kRBRenRKT83yw3dbz1CY
         I7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=hoPc0AIsLRiQBJ4+9F0u7OZxAg1G+QYq3fporFT1/38=;
        b=FiXBS5t46RrI3xhd5rqtQUEhYl6zxVDCdfJDeEkZKBVCYwqD5lpPEIRvN+nsn6M2JJ
         HuHLKjSXz3A4nJJ1dvR4JycQTDvxQeJpLysDpP4l30CjG/5B0cO5XFvMl+vBlHSs4/8C
         7V1iXuNdCSwNxS1JzbvcGEMxDRmlvHxZ4Ry5O0H4k4YM/xzpYAmhzEX/5Tq7NndK57X2
         /3NUrcY2YyW6fi12c535OZeg5P9OINEuwNKwB8Q1cCtyQ3hTiwQ4ykq8EemaM+Xaxb7K
         T5zDnFWqpL8CIUSXVVAeHekhys8yalR8CQVY6A7GIdcKHYDcwl+ZKG+ntoJBBjJET6rq
         F1Ig==
X-Gm-Message-State: APjAAAVkTvR8QTAVNBUbZTgcRgN8fnG/uLFdnnEy+s1ZwXBq03AHFX5D
        K+3V6Fe3egN8U71UXXed4OblJbkEHHnbvQDxW7A=
X-Google-Smtp-Source: APXvYqxlyVyB5PJlf5vPJ6/iQa8YV28ND2SCDhwBEbSeCdWfYCO5Ns4LtYbNg5RCBOhVshpr8AgRvhW919KVwYgRdE8=
X-Received: by 2002:a6b:6311:: with SMTP id p17mr4283939iog.127.1580398003122;
 Thu, 30 Jan 2020 07:26:43 -0800 (PST)
MIME-Version: 1.0
References: <20200128144026.53128-1-mirucam@gmail.com> <20200128144026.53128-10-mirucam@gmail.com>
 <nycvar.QRO.7.76.6.2001301341100.46@tvgsbejvaqbjf.bet> <CAN7CjDCiP_KVC5Ey6cMuPN17vRNp_s4vy94qsaAKRPG=k3Rj3g@mail.gmail.com>
 <nycvar.QRO.7.76.6.2001301557300.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2001301557300.46@tvgsbejvaqbjf.bet>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Thu, 30 Jan 2020 16:26:32 +0100
Message-ID: <CAN7CjDBrWUFiY+mh3n0xBMQMsJ1YejRb1+N5caG+Of==uxQR8w@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] bisect: libify `check_good_are_ancestors_of_bad`
 and its dependents
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

El jue., 30 ene. 2020 a las 16:01, Johannes Schindelin
(<Johannes.Schindelin@gmx.de>) escribi=C3=B3:
>
> Hi Miriam,
>
> On Thu, 30 Jan 2020, Miriam R. wrote:
>
> > El jue., 30 ene. 2020 a las 14:46, Johannes Schindelin
> > (<Johannes.Schindelin@gmx.de>) escribi=C3=B3:
> > >
> > > On Tue, 28 Jan 2020, Miriam Rubio wrote:
> > >
> > > > +
> > > > +     return res < 0 ? -res : res;
> > >
> > > This is a change in behavior, though: previously we guaranteed that t=
he
> > > exit code is either 0 on success or 1 upon failure. I am not quite su=
re
> > > that we want to change that behavior.
> >
> > I think this is because different error codes might enable a bisecting
> > script calling the bisect command that uses this function to do
> > different things depending on the exit status of the bisect command.
>
> Oops. I am _totally_ wrong on this.
>
> As you are changing a lot of `exit(<n>)` to `return -<n>` with the
> intention to turn the value into an exit code only at the
> `cmd_bisect__helper()` level, this is actually required a change.
>
> I am a bit uneasy about this, but I could not see any return values in
> `bisect.c` other than 0 and -1, prior to this patch series.
>
> However, I would love to see this refactored into its own commit, more
> toward the beginning of the patch series, with a very clean commit messag=
e
> that describes that intention of being _the_ exit point from `bisect.c`.

Ok. Noted
>
> Without this change, you simply cannot change the `exit(<n>);` calls in
> `bisect.c` for any `<n>` other than 0 or 1.
>
> Sorry that it took me so long to wrap my head around this rather trivial
> idea.

Please, don't worry :)
Thank you again!

Best,
Miriam.

>
> Ciao,
> Dscho
