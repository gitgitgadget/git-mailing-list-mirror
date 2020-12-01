Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D60C64E7A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 19:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6D6720870
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 19:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFZ/hWVc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388946AbgLAT6j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 14:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgLAT6d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 14:58:33 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D10CC0613CF
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 11:57:53 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id z16so1612263vsp.5
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 11:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gWFM5akmxX5cOK0KvGFePyX4UJARwye1ikxRmlJiHJQ=;
        b=IFZ/hWVcr7RXHwysj/rIqMvwigTiLeLCHLrn1xxqNHfOcqOKRC44q5giVDB1Tb8b4A
         uIFcQZjKpHv9C4ZATVgosmSv2c6/L12UKrKjSxSCh7pXvum9L+Dodi+KXyEPP8Z2kNmW
         hM99abcTMgobkZRH8JclH82lybAjMN2RtfRnAx4ZmOWh7CdoYj1x3sFPxgw84I33X0Bg
         b/pD48Tu+HTFYy9C5EvwIptXyEQ7ZTotDJxiwDgg654WsxSV2OdrQd/zR6sorfYE48Bi
         dSbOkxqiQPJgZA7AAeuu/pAABuz5VskG2hfOOobf7KpTAar2yBlS2CspQHOt6jxp0JjY
         p8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gWFM5akmxX5cOK0KvGFePyX4UJARwye1ikxRmlJiHJQ=;
        b=ZV8yuR26wYU5JJ+appWpEFIK2L7IllqK1fGSpay6KkLRCUkkwe53URhTkjJn+LxREN
         f4+Ujc0AF7VJadix+wcYPxXy9/Z685WlaHxqXo3hRDNkzoSdiFyB2v8tnRYdyIxsCk6z
         jCleOKoqpFJo10M6r8CyNmdaK8Nc0ZdSA2xaXQKiV6T6UPi2JPmXeDb+qfksBTRzJXWt
         PlqN75An5Vw6NieJ1eVY4/cV1YBV9dGx86gvFouaj1FC4cBX/smHVCpylvHtaVAR7Rk6
         H9CfxnCav6zWUOulxdg3m9VHYNaOGW2Q6803kRdRo9gjtUK+W2JCn9RUvkp7+xy4hmw6
         3Hpg==
X-Gm-Message-State: AOAM532d94Hw8wGrtxsrIerx3Mc2O5sI3NoYQUzXAmMyISzA574e1Fdw
        AkEsg6J9eOHlz4/b8l8PmFjpZnbOnZzbUAmEFGs=
X-Google-Smtp-Source: ABdhPJy9aY74eMfXpRuOlkUMHG79od3RG8iABxeI/LTd4pr4Tn/SMAT+cSX/2UTLWN7GCEQwzHhZ38X2Er8zpiruJpo=
X-Received: by 2002:a67:7742:: with SMTP id s63mr4462009vsc.49.1606852672516;
 Tue, 01 Dec 2020 11:57:52 -0800 (PST)
MIME-Version: 1.0
References: <20201201095037.20715-1-arnout@bzzt.net> <20201201154115.GP748@pobox.com>
 <xmqqpn3tpbsl.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqpn3tpbsl.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 1 Dec 2020 20:57:40 +0100
Message-ID: <CAN0heSo6Cd3cd6iBHbSU7ESKF79Kwk24KEcioiEdQ_=iBZRQ-g@mail.gmail.com>
Subject: Re: [PATCH] doc: make HTML manual reproducible
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Todd Zullinger <tmz@pobox.com>, Arnout Engelen <arnout@bzzt.net>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 1 Dec 2020 at 20:27, Junio C Hamano <gitster@pobox.com> wrote:
>
> Todd Zullinger <tmz@pobox.com> writes:
>
> > Arnout Engelen wrote:
> >> This makes sure the generated id's inside the html version of the
> >> documentation use the same id's when the same version of the
> >> manual is generated twice.

> >>  XSLT = docbook.xsl
> >> -XSLTOPTS = --xinclude --stringparam html.stylesheet docbook-xsl.css
> >> +XSLTOPTS = --xinclude --stringparam html.stylesheet docbook-xsl.css --stringparam generate.consistent.ids 1
> >>
> >>  user-manual.html: user-manual.xml $(XSLT)
> >>      $(QUIET_XSLTPROC)$(RM) $@+ $@ && \
> >

> I think it is in general a good thing to do (can we lose some lines
> from doc-diff, I wonder?) and many of the result of your study shown

This is only about user-manual.html, which is outside the scope of our
doc-diff tool, both by being html not man, and by being user-manual. So
no, no reduction in any doc-diff, unfortunately.

Martin
