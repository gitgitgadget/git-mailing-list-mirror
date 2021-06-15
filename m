Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23931C48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 07:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED734600CD
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 07:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhFOHTc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 03:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhFOHTa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 03:19:30 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81767C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 00:17:25 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id p184so19033563yba.11
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 00:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xI6UKbu7AnK7QDUCnoGyE0NizSi53hHtPlhxi/zl6tc=;
        b=tJVp/HGJ6+NNxdbE93YEM5NDEgd4C4YjDHu/6RmzaKfG6+tx6ySMakC5qC9KWtMDP8
         XcSFUzv/gv1NgKdCASKXz4DK+GNB8R8SEz14VMYIcTyzqhgXNJ2F6tXrYSVd5zbmtctb
         xQ+QgtS8C/FDDRNI2+eYX2KRDRgv0YMSvTEkaGn5W/S7D+RCTsM+pSk85DVQM6cG0F1Z
         /Hl1vAg6O3/B6hUN1nEWA0Fxy/wqQIf1U9lkW5HDbf7sOnwXO+ryYRLf3sPyTXU+riH+
         RzefYIqq7eczLhjwfIS3IxN0eGR5nKEwFMzOoqETCZNNNO0yagI04AQWLuuxIXlkkUkk
         u74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xI6UKbu7AnK7QDUCnoGyE0NizSi53hHtPlhxi/zl6tc=;
        b=suomDkS5Ek5X5oxg2y55X+cdEWJMfFs8JvjZNadb4Xyu0mOzg41ALZVgHPfWiWvDdx
         E8Yl2KccY3yk9NlaXvGIAtd2W+PSc8XEPl77x1eP5czMRGi6ESk0TdySZV+EZtRMPziG
         90HpbGuyssKFJANCxFLRW36P5b1Ae5M4WkU5iyZm7YXntzeHx43um3Pj/oLOMIcqYc4N
         28rRKc0kWoJAzr+HoZmDE9q9j4OhSeoeVqYEpC1rbuWFIXHxnsjdYzHAmtExz96HAW2/
         +2JA2pnbARh/UTx3RPc/wHGEAVFBo1pLK4BrjCeDR7oxfaZZSTO6lcUdBeEs/WmwC2S9
         YLkQ==
X-Gm-Message-State: AOAM532ZX8EQ5/z5Pj9UKav7eQ5iQhPq5CF7UOFZUox0bQs5yazGu2Dq
        F5GohQ5z+lLCjibUixoo3FOJS4yZ7uU0Kv3wqPU=
X-Google-Smtp-Source: ABdhPJw2+HUN0qWm81k4vJAP86oNSbag61Bu83LCBEhsKNna8d/Gy5d3NL9z5tnZDhxLe34L6Nx+yevd1iuxLQcxE34=
X-Received: by 2002:a25:1455:: with SMTP id 82mr29591596ybu.403.1623741444878;
 Tue, 15 Jun 2021 00:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <87im2s5jjm.fsf@evledraar.gmail.com> <20210612050711.4057-4-worldhello.net@gmail.com>
 <xmqqim2hyuj1.fsf@gitster.g> <CANYiYbGtfgZepnfTWGjbmOh2bxa8tZ7bvgtVTo6qTQpCP9MPag@mail.gmail.com>
 <xmqqk0mwylhc.fsf@gitster.g> <CANYiYbG6bKwheThWz2ecHUTh7JFmTsi-F9FtYkcoS0az=f=m6Q@mail.gmail.com>
 <0pqq6s9-n238-95ss-nsqr-42o75sr933r@syhkavp.arg> <CANYiYbFsqj9j_UT9-mF+BSOAHU4=On+BUxCU4w6rXhhMaeo=zg@mail.gmail.com>
 <r8ss67nn-31s4-o429-828p-s787sr2481@syhkavp.arg> <xmqqh7hzwx9f.fsf@gitster.g>
In-Reply-To: <xmqqh7hzwx9f.fsf@gitster.g>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 15 Jun 2021 15:17:13 +0800
Message-ID: <CANYiYbFw3sOj8xbrc6evHu0onw3VT1TMnfEeo=BKtS-qu4Hy+A@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] sideband: append suffix for message whose CR in
 next pktline
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Nicolas Pitre <nico@fluxnic.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=8815=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8812:46=E5=86=99=E9=81=93=EF=BC=9A
>
> Nicolas Pitre <nico@fluxnic.net> writes:
>
> > On Tue, 15 Jun 2021, Jiang Xin wrote:
> >
> >> The issue this patch try to fix is like the following example:
> >>
> >>     PKTLINE(\2 "<progress-1>" CR "<progress-2>")
> >>     PKTLINE(\2 CR "<message-3>" LF)
> >>
> >> The message "<progress-2>" is displayed without a proper clear-to-eol
> >> suffix, because it's eol (CR) is in another pktline.
> >
> > I'd fix this issue with the following logic:
> >
> > bool pending_clear_to_eol;
> >
> > my_putchar(c) {
> >       switch (c) {
> >       case '\r':
> >       case '\n':
> >               pending_clear_to_eol =3D true;
> >               break;
> >       default:
> >               if (pending_clear_to_eol) {
> >                       clear_to_eol();
> >                       pending_clear_to_eol =3D false;
> >               }
> >               break;
> >       }
> >       putchar(c);
> > }
> >
> > In other words, you clear the line after printing "remote:" but only if
> > there is a non \n or \r coming next.
>
> What puzzles me the most in this discussion is why we do this for
> LF.  I do understand why we need it for CR---the line we are going
> to show message on after emitting CR would be full of leftover
> letters we previously have written before emitting CR, so we'd show
> the message (to overwrite the initial part enough to show our own
> message) and then clear to the end with either ANSI sequence of
> sufficient number of whitespaces.  But line feed would take us to a
> fresh and blank line---there is nothing to clear, no?

I guess this may because sideband #2 messages are printed on the
screen in a background process, it never know a line where it starts
to print has characters on the right.  So it is safe to write an
additional clear-to-eol suffix no matter the message ends with CR or
LF.

--
Jiang Xin
