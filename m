Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1E9C4361B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 13:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ED7123442
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 13:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgLGNxX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 08:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgLGNxX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 08:53:23 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A8FC0613D0
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 05:52:42 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id a9so18186898lfh.2
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 05:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZhLRAW/jxImq8eUyIznDQc+L1XFwJLs4YBqvCfiJhAs=;
        b=MEX+h49u/mCIX7KhXjLk6+VIdqGVRC2PUAgXa/aJHhmWfKY2jkJ32SfJcSVgWKMirp
         TZ9A9hRgxKQ0BkkJfbRR1eqP2NModtIjHFYoq1Tp1LeZqPcyoI+PXSWLOzfBh7BGBw/u
         RDdKwHSrnOY5dYZkwal61MqUQXRLPDhi+87CDMwfLg5t2p5OuT3O0PUNk/J3KadAajxD
         cfY+q+/i3K59oOoAchywB2ZBTdIg4ydEE+zvIRJAlC7hCILGCV+y1DlIvEuOVIPZSsmg
         qb4lGCku2dG76VcwNYXl6zLYZPjFdpt2Lm4l3i28EqfjqKogbgRSf3CZwlUTDUu4MPWs
         Foag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZhLRAW/jxImq8eUyIznDQc+L1XFwJLs4YBqvCfiJhAs=;
        b=o5cJn1MtOhnBJ8UEIbc9qlSKdqMvZjKUTJ7X3CBJHHg8kugtIGggtbgXuGhoNSBgIG
         PssOg18S4QzddQCb4b77e10GomYG9RQYvRe5rNFzHHSP+pBPANBuDeKf2222fkKtuPWO
         H/+dP5+QZIKNZhyorQt/1R5q38l5GdKEBRCj+DciMfuUUjhgrRTi5OkjWppuwrrs4duS
         EUmOABsHXZrQlrp6yLIQ5Ab3yNr4WTZyKLC0+DJBH4xdFtCP0LsgyVIr8WPicfq5yHlS
         o1C6SnUFL2eZ8HDDGusohT3zcgWgaQflf+R2w8lhbx5H2Yi3VGeQj9gViEBBzbmT8agX
         GPoA==
X-Gm-Message-State: AOAM531Z3wZgS00U8BUKqRxEjNnhAElFiDRmVM7foNsro7y4uRfTnmve
        kW4OvAnBNTAVuViz22SAeGe+Uhh37I7amSFESw+L6w==
X-Google-Smtp-Source: ABdhPJwlHuIuOUcQSxOWZHxPYAKBemJQ7xsAvtpK+petlMJZwqR1XI+eMQfm3YsavuFeIAOefcjliVTL38zgwPES8Jk=
X-Received: by 2002:a19:ac07:: with SMTP id g7mr8417684lfc.125.1607349160881;
 Mon, 07 Dec 2020 05:52:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604521275.git.matheus.bernardino@usp.br>
 <5c993cc27f67109828390c7856d6c03d4a2cbb32.1604521275.git.matheus.bernardino@usp.br>
 <CAP8UFD1-3YxT42K77Rd-XSRsoXYr_RM8Dj_r8-2GQ0noQw58iQ@mail.gmail.com>
In-Reply-To: <CAP8UFD1-3YxT42K77Rd-XSRsoXYr_RM8Dj_r8-2GQ0noQw58iQ@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 7 Dec 2020 10:52:29 -0300
Message-ID: <CAHd-oW5Mj13_4rgHrQ-Awtzg0i0Wkbeb78z466FO=_d72New=A@mail.gmail.com>
Subject: Re: [PATCH v4 08/19] entry: move conv_attrs lookup up to checkout_entry()
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 6, 2020 at 6:36 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Wed, Nov 4, 2020 at 9:34 PM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
>
> > +       if (topath) {
> > +               if (S_ISREG(ce->ce_mode)) {
> > +                       convert_attrs(state->istate, &ca_buf, ce->name);
> > +                       ca = &ca_buf;
> > +               }
> > +               return write_entry(ce, topath, ca, state, 1);
>
> We pass `ca` here instead of `&ca_buf` because ca is NULL if we are
> not dealing with a regular file. Ok, I think it's indeed better to
> pass NULL in this case.
>
> > @@ -517,9 +526,16 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state,
> >                 return 0;
> >
> >         create_directories(path.buf, path.len, state);
> > +
> >         if (nr_checkouts)
> >                 (*nr_checkouts)++;
> > -       return write_entry(ce, path.buf, state, 0);
> > +
> > +       if (S_ISREG(ce->ce_mode)) {
> > +               convert_attrs(state->istate, &ca_buf, ce->name);
> > +               ca = &ca_buf;
> > +       }
> > +
> > +       return write_entry(ce, path.buf, NULL, state, 0);
>
> I am not sure why NULL is passed here though instead of `ca`.

Oops, this is indeed wrong. I think I forgot to modify this line while
applying the changes from the last review round. Thanks for catching
it!
