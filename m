Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCCAC433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 22:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2308264E40
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 22:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbhBIW4t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 17:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbhBIWRb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 17:17:31 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0754C08EC2B
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 13:57:21 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id u25so30735193lfc.2
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 13:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ef/sEOajeiYe/Wper94uxS3r7y72+9zDLr+VCZTFcSs=;
        b=vDj2pVg4xTjakId4SbCLXSkGj3sBB0vVH4fH+y2XrHui8/lyggw8koKBf8j9PMbkx8
         mTMbIeKFNHt0ZxgleoITbx5dIyXv2XDveJeaw2q6X2ddYZP4nPjQ/flyYBaQCGBdEB2h
         COXgO9sigy78fiATRtJj3Ig0YR2cUWxTh4sqG4fIAxTzybEyj85hx+4WinyO9G7l5Rz0
         fKwFoH88NquzlDAZGtvj7VNLFH1WS81EbBTXqboFPg01t+daUGFDrqpvX8+eEhbnMoes
         NZZP830O0W1F5PWJGxhROdVsM4QYiOLZMzdxvAHWCanimLqSq6+mkppdTPyDTFbAQfvk
         M9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ef/sEOajeiYe/Wper94uxS3r7y72+9zDLr+VCZTFcSs=;
        b=dSQPJhsn9xW8NTEVU4iWHHalLdr1o37b8kzic3miSsoOqp3YUbrhUiiRPICJuFsFyN
         6XmoCrg3UmZNOg5o2/s/I5Wt9OrfRkiHktTjDvyfE1K/EBRRhjcAcpZSjtjPuXG9I7M7
         13EIEtnYDduyS+l9BbtmeUqkmFFYr9pCxZ2EGokzsP7i3n/j+G8wvmFOg39E2cvCtLzh
         36hSpQ5G1Wkz1xoVJk807Hw/33hBbMYLfw4iLQ+LE9RzXcLI4jB/OPfrphOrMBO4JN+X
         sAxa7yr7dhy9xVFbt37p89OPXSbEfDlIcN/48WEwE+0A/vAYLsUpl3xPmto6aje5V5a8
         rK9g==
X-Gm-Message-State: AOAM533/ciQWgj6oxBMUq175Wtmn3EzKKQMX0Lt8/S2VD7XioTw/1WbR
        O1DN0Z282JUUACL+yIRtipBbKiCEVvhGOIQw56gyWg==
X-Google-Smtp-Source: ABdhPJx+JfarkaFjokKFaddVafKVc1MPJEt3CR9uaZvdr/yCelxjDNXiiR1UrCu0tbyHBONMAws+rwI7HAfnLwTJDp4=
X-Received: by 2002:a05:6512:1042:: with SMTP id c2mr14959264lfb.359.1612907840135;
 Tue, 09 Feb 2021 13:57:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1612812581.git.matheus.bernardino@usp.br>
 <1275701345b7e198ec83ad4fdcc2dda6d9775ef3.1612812581.git.matheus.bernardino@usp.br>
 <xmqqmtwczzyv.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqmtwczzyv.fsf@gitster.c.googlers.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 9 Feb 2021 18:57:09 -0300
Message-ID: <CAHd-oW4ddei-bRZkQUSpMevyZYgOBi2T6uQPzJ_XscTmfxhWtw@mail.gmail.com>
Subject: Re: [PATCH 2/2] checkout-index: omit entries with no tempname from
 --temp output
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 9, 2021 at 6:35 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matheus Tavares <matheus.bernardino@usp.br> writes:
>
> >       if (CHECKOUT_ALL == checkout_stage) {
> > -             for (i = 1; i < 4; i++) {
> > -                     if (i > 1)
> > -                             putchar(' ');
> > -                     if (topath[i][0])
> > -                             fputs(topath[i], stdout);
> > -                     else
> > -                             putchar('.');
> > +             for (i = 1; i < 4; i++)
> > +                     if (topath[i][0]) {
> > +                             have_tempname = 1;
> > +                             break;
> > +                     }
> > +
> > +             if (have_tempname) {
> > +                     for (i = 1; i < 4; i++) {
> > +                             if (i > 1)
> > +                                     putchar(' ');
> > +                             if (topath[i][0])
> > +                                     fputs(topath[i], stdout);
> > +                             else
> > +                                     putchar('.');
> > +                     }
> >               }
> > -     } else
> > +     } else if (topath[checkout_stage][0]) {
> > +             have_tempname = 1;
> >               fputs(topath[checkout_stage], stdout);
> > +     }
> >
> > -     putchar('\t');
> > -     write_name_quoted_relative(name, prefix, stdout,
> > -                                nul_term_line ? '\0' : '\n');
> > +     if (have_tempname) {
> > +             putchar('\t');
> > +             write_name_quoted_relative(name, prefix, stdout,
> > +                                        nul_term_line ? '\0' : '\n');
> >
> > -     for (i = 0; i < 4; i++) {
> > -             topath[i][0] = 0;
> > +             for (i = 0; i < 4; i++) {
> > +                     topath[i][0] = 0;
> > +             }
> >       }
>
> Hmph, is topath[][] array used after this function gets called and
> in what way?  Whether have_tempname is true or not, wouldn't we want
> to clear it?

Yeah, topath[][] can be reused in the next checkout_entry() call. But
if have_tempname is false, the positions that are going to be used
again (either checkout_stage or 1, 2, and 3, if checkout_stage ==
CHECKOUT_ALL) will be already empty. So I think we only need to clear
topath[][] when have_tempname is false.
