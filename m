Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D642C433E6
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 09:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D296321D42
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 09:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbhANJq1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 04:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbhANJq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 04:46:26 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EBCC061575
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 01:45:54 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id s2so5326062oij.2
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 01:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cvPSOd1oftTWU7580UkIw/OLzniuOU2UGdSECLSCEDA=;
        b=nigga2zvF8AAusZWiUFbE2CqEB9gb27rKndliAwTwjD2eYZHKNWaz71N/Lgx1JioaY
         KgLz57tgdB8OFiqo16ubOiBMtN6wJQh00ZfYKF419kdUYU6D1n9Z8fTWH37z86TF1Ojq
         /5TyN9XXf9DsFxUHz0yhwFWrY+44h0VAGy8r/5Wxzdf4OTA/mJ/RQZYEDnDPikM5eDJz
         cfaUeed7bx+SpMtWAhurxWlAT37TNalAjYKNYRiDQ2qu2j3/h+BLVCzknEDpedBbUxP3
         SCYoplBbYRfTEje24ZJlyiTiM1Jmu1MHVYlfF403wjpy5sISgwrfGAhEx4t+Xkv5/gwI
         jLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cvPSOd1oftTWU7580UkIw/OLzniuOU2UGdSECLSCEDA=;
        b=cb7WU+SmCejo4ruvzIAi9snmfDmMBbGnfLzusGjlQIQS0HxD6MsqSbAGxRCQ9/XgZ7
         zPUdhRaPElCZguHwgCTw+UqNpbUjL6LAh0tE/NwSlExZMrhsplBjklIHAuinN5roAqFX
         VBNDdWHJT23Q5h/a8cQIlTKcRg9HxjmOMm6kHcjpsBbU35qXbYLt4qsq0AfQOCV5l1Gr
         WqHf1pLE7RFgFlSRELbw5qxH2QE8RQe87jr3awbCPNNV5H3QYg+y0vlFBhLHVclMyjID
         Zc86/NzVafFHaZN/EtLVZZI0jDHJTFUcS001ypKFPTuUx6HBCeWU1AH0xRgY2pZ4JF0a
         CCfQ==
X-Gm-Message-State: AOAM5330ZPfYjOuJ+IAqVZgzdtC7WsHxekJTwM7Y+L2R/nXH9KmTvqAx
        Js/oY5dmvMVJceSwYFjIcyQd+XMm3Nd8oCopm8E=
X-Google-Smtp-Source: ABdhPJxFcBEyIbzpmgr9zT7bu6Q+55w0dJ+dH3CBx1heQouZJ1IMXLydOMd//y4fnQ0k0R3Tjdw1RBo/9v58KUTzUJk=
X-Received: by 2002:aca:5253:: with SMTP id g80mr2050802oib.98.1610617554008;
 Thu, 14 Jan 2021 01:45:54 -0800 (PST)
MIME-Version: 1.0
References: <20210108092345.2178-1-charvi077@gmail.com> <20210108092345.2178-7-charvi077@gmail.com>
 <CAP8UFD2G-2kEbajYpi7kGn=E2HriTuhKJRgs-vEDvHC7WYCGQQ@mail.gmail.com>
In-Reply-To: <CAP8UFD2G-2kEbajYpi7kGn=E2HriTuhKJRgs-vEDvHC7WYCGQQ@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Thu, 14 Jan 2021 15:15:42 +0530
Message-ID: <CAPSFM5edZP90kYCf0fynpx+5oQ4pRuGBcrm2AmE5JKsXsS3fAQ@mail.gmail.com>
Subject: Re: [RFC PATCH 6/9] rebase -i: add fixup [-C | -c] command
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On Thu, 14 Jan 2021 at 14:54, Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Fri, Jan 8, 2021 at 10:26 AM Charvi Mendiratta <charvi077@gmail.com> wrote:
>
> > @@ -1740,34 +1746,177 @@ static const char first_commit_msg_str[] =
> >  N_("This is the 1st commit message:");
> >  static const char nth_commit_msg_fmt[] =
> >  N_("This is the commit message #%d:");
> > +static const char skip_first_commit_msg_str[] =
> > +N_("The 1st commit message will be skipped:");
> >  static const char skip_nth_commit_msg_fmt[] =
> >  N_("The commit message #%d will be skipped:");
> >  static const char combined_commit_msg_str[] =
> >  N_("This is a combination of %d commits.");
>
> [...]
>
> > +static void update_comment_bufs(struct strbuf *buf1, struct strbuf *buf2, int n)
> > +{
> > +       strbuf_setlen(buf1, 2);
> > +       strbuf_addf(buf1, nth_commit_msg_fmt, n);
>
> Should "_(...)" be used around "nth_commit_msg_fmt" here...

>
> > +       strbuf_addch(buf1, '\n');
> > +       strbuf_setlen(buf2, 2);
> > +       strbuf_addf(buf2, skip_nth_commit_msg_fmt, n);
>
> ...and around "skip_nth_commit_msg_fmt" here?
>

Yes, I forgot to put  "_(...)" here for translation. I will add it, thanks.

Thanks and Regards,
Charvi

> > +       strbuf_addch(buf2, '\n');
> > +}
