Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE54DC433F5
	for <git@archiver.kernel.org>; Sat,  7 May 2022 19:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358146AbiEGTP1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 May 2022 15:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiEGTPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 May 2022 15:15:25 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22C127B2C
        for <git@vger.kernel.org>; Sat,  7 May 2022 12:11:37 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id n135so5109732vkn.7
        for <git@vger.kernel.org>; Sat, 07 May 2022 12:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ctO6GksSKB4+iGr27F6ozcn/j2UdT2InrIJtPf8feQw=;
        b=R5zphbiZrgi15LimwrgsLf7Vd2gBLK/mqM7pMFVCQ4tCC8LKKNDZ8V14lt061zpR67
         cNDinUQtiG1WjVko7KaK7rcvKVHM9h1NjwxPt5ynGMpQ5wPcir9xCd6zqXWuKt/p19PF
         ABW3HMQ7eDlGqHG2sLv7niRSpfQ8YMQV/SkW4NroKXcaHKmoA6FenkwHZrnAjbI0KBd+
         SrDNEZ5mK4DL/sz9eDv/DLmPzIE9vbobJx5fWnyjW/gy3MOTHbzdgPwsPNnzA8Y8VYNL
         bbG6TDvQr9p9ku72FDtQne57/7rrM6eHDUBROeQyKKafsCP/hqxVJOZB3FMgX4e+tRRV
         GBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ctO6GksSKB4+iGr27F6ozcn/j2UdT2InrIJtPf8feQw=;
        b=J1FrTfn2EPjuB19LhIrTWpUJIjKb6K/YZcoOBi2aSIzYcAkIt/Fw/7SPndmsL74YTW
         N6950GjRrJNaYO1b5x3wyv/BCl4FZGykriyALLvqdtRDOuB4IUF/7LuZYRX5LgTWcAJo
         GvAnAQMizEXGYL7J8jAI03cYveCs6Wz4pAl0ZGqyE4WelIFY52cXPcAr2u2tXPNHsne/
         27ijfDvxYCFWM1lKctIo5FC8CD8S4Cpff59l1a69DL65zIvNYjMg5nevzxudYUq3uD7B
         fqoCPr5b0g0eUITZL2a8UO5xPBw6klVG021nlNcXbAH8k+6l8m+UYThrZB+v3OTwoDE0
         Dw2Q==
X-Gm-Message-State: AOAM532By8vLAXlxaF3AivXuxAUWfv76QywWtX+G7qWBTJ17H9aA0HuE
        gLxdjyq+mCo2fEn3B2khGFZsvhWEE/B4rN681Ho=
X-Google-Smtp-Source: ABdhPJxI69kXVRtQWYJPeUP1ho6b1XPKrc4R4tCCpMpMJUkb1cvY8RX15ZRBD49Z7fcrS5Pj0DRrTGpaKIASj/MutBQ=
X-Received: by 2002:ac5:c856:0:b0:34e:d0b4:7a10 with SMTP id
 g22-20020ac5c856000000b0034ed0b47a10mr5523403vkm.39.1651950697018; Sat, 07
 May 2022 12:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1651859773.git.git@grubix.eu> <3f0e462e86625a3c253653e4a4eefabcd8590bf9.1651859773.git.git@grubix.eu>
 <xmqqtua2jtr0.fsf@gitster.g> <xmqqczgqjr8y.fsf_-_@gitster.g>
 <20220507054017.fnvb6xisr6s7m2l5@carlos-mbp.lan> <xmqq4k21gp6g.fsf@gitster.g>
In-Reply-To: <xmqq4k21gp6g.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sat, 7 May 2022 12:11:26 -0700
Message-ID: <CAPUEspjm2_6Omk1_VanXZJnRREnLS08H4t9tbxx=dnoqA+P43g@mail.gmail.com>
Subject: Re: [PATCH] http.c: clear the 'finished' member once we are done with it
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Michael J Gruber <git@grubix.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 7, 2022 at 11:42 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:
>
> > On Fri, May 06, 2022 at 02:17:01PM -0700, Junio C Hamano wrote:
> >> diff --git a/http.c b/http.c
> >> index 229da4d148..85437b1980 100644
> >> --- a/http.c
> >> +++ b/http.c
> >> @@ -1367,6 +1367,9 @@ void run_active_slot(struct active_request_slot =
*slot)
> >>                      select(max_fd+1, &readfds, &writefds, &excfds, &s=
elect_timeout);
> >>              }
> >>      }
> >> +
> >> +    if (slot->finished =3D=3D &finished)
> >> +            slot->finished =3D NULL;
> >
> > I am not completely sure yet (since I looked at it long ago and got
> > sidetracked) but I think this might be optimized out (at least by gcc12=
)
> > since it is technically UB, which is why it never "fixed" the warning.
>
> UB meaning "undefined behaviour"?  Which part is?  Taking the
> address of an on-stack variable "finished"?
> Comparing it with a
> pointer that may or may not have been assigned/overwritten elsewhere
> in a structure?

it is not very intuitive, but using a pointer to a variable that is
out of scope is UB, and in this case the value of slot->finished might
point to an address that is not in our own stack (because it came from
a different thread), hence undefined

Carlo
