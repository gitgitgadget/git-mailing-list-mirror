Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF8FC54FC9
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 18:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E81972076C
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 18:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXVSo01p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgDUSrN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 14:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726575AbgDUSrM (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Apr 2020 14:47:12 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3727AC0610D6
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 11:47:12 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id y185so9141597vsy.8
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 11:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=buLCIySQbkAE17bknJ2tXyF3NJL3nmZrzhxmzg+uWAg=;
        b=EXVSo01pSF8bXXRQkTd9wu9sJK++NFITqmZltJCBN6FvNwrOMXvq4CZkL2q6nPp7DV
         ujtSdPsXq3nyBUKevBFgxSzTWxQx6azjTqU4g+ppxqJk/SxZyUK70hZ0pnnH7boWZNso
         R1gGAUlDRpxP8gWlICTRepO+BGqjODEK1WMSo8spuly8sm+IHfzjpH0okJ4wqxx5xiQZ
         QEKs7L3W4JhNo4nOAC0vbiczk41BjvcuDEt85Xyhf4zgVTxF1uSTNQ8x+MigpmuDlPEZ
         a1pugccgDLD5cmsYzTcxbG8rP0KjvvEipafrF82cvAED7QGo2Z0s5NWqilB0yIzWd5qM
         o32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=buLCIySQbkAE17bknJ2tXyF3NJL3nmZrzhxmzg+uWAg=;
        b=XX7CVV0eQkYuPW5niDxBIhWN9994GDoul9SQHHDmoxGb55VXtg50xuJeTGP+Nfvf1n
         VKO9PklFd2eo0TmgH26jyUxncY0A+NREmFsoDRzHk1mNogR24gIaVzx5L40eJnYna87M
         Hxyl5b/4/Q6qCuW5dbFpI3eiC8pIHIrpZkNMmWwvZ7U6kDh+gyYf0zEFQQcqn6yRZqZc
         TWC3JZTvPNwXKmmSeTLdvxFeT9KTAADohR0R6fzV731WF5kpgW3bo+Soavr7muUggKll
         EiGlpvjzUxg2Ntem9zTc1sOobBp3uNHBQZu2hCVf88aMfprukCkaEWe6mQ4YbdNpg/bJ
         0kLw==
X-Gm-Message-State: AGi0PuYn87Pxtd0G3/QK0+1FLRMcCxKzVLEU0lKGTYjSzxpwUmoxp52o
        2uqIb8o1LDYXOYMPyUYzj0lAf4h0jHlFRgmq/d0=
X-Google-Smtp-Source: APiQypJmmgDx1A8bjV+gvaJwHXidls+fS+vax8ToJEodLtrU8lKDQyctgw/s1tsBWQ1PLbehfl9be1HlM9eBiWhV/x0=
X-Received: by 2002:a67:c592:: with SMTP id h18mr16496327vsk.118.1587494831362;
 Tue, 21 Apr 2020 11:47:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587240635.git.martin.agren@gmail.com> <cover.1587297254.git.martin.agren@gmail.com>
 <c3012f1da361af354a904f821b83d61f2534ccb2.1587297254.git.martin.agren@gmail.com>
 <xmqqzhb6q74r.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqzhb6q74r.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 21 Apr 2020 20:47:00 +0200
Message-ID: <CAN0heSp3KWU8Q8_+-GPUePfQorbyWdwm-eo4eGBRcnTtxOvS4A@mail.gmail.com>
Subject: Re: [PATCH 3/4] strbuf: introduce `strbuf_attachstr()`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 20 Apr 2020 at 21:39, Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
> > +/**
> > + * Attach a string to a buffer similar to `strbuf_attachstr_len()`.
> > + * Useful if you do not know the length of the string.
> > + */
> > +static inline void strbuf_attachstr(struct strbuf *sb, char *str)
> > +{
> > +     size_t len =3D strlen(str);
> > +
> > +     strbuf_attach(sb, str, len, len + 1);
> > +}
>
> This is somewhat worrysome in that the interface is _so_ simple that
> people may fail to see that str must be allocated piece of memory,
> and it is preferrable if string fully fills the allocation.
>
> We should repeat that (instead of just trusting "similar to ..."
> would tell them enough) in the doc, perhaps?

Yeah, that's a good point. I'll expand on this to try to better get
through that there are things to consider here.

> > @@ -1095,7 +1095,7 @@ void trailer_info_get(struct trailer_info *info, =
const char *str,
> >       for (ptr =3D trailer_lines; *ptr; ptr++) {
> >               if (last && isspace((*ptr)->buf[0])) {
> >                       struct strbuf sb =3D STRBUF_INIT;
> > -                     strbuf_attach(&sb, *last, strlen(*last), strlen(*=
last));
> > +                     strbuf_attachstr(&sb, *last);
> >                       strbuf_addbuf(&sb, *ptr);
> >                       *last =3D strbuf_detach(&sb, NULL);
> >                       continue;
>
> This is not wrong per-se, but it is unclear if use of strbuf_attach*
> family to avoid an explicit malloc/copy/free is buying much at this
> callsite.  Simplifying the code here of course is not within the
> scope of this series.

For the other patches in this series, I spent some time and effort
investigating where strings came from, "do I really feel certain that
they're NUL-terminated?". But for this patch, I more or less went "we've
been using strlen on this all this time, surely if it wasn't guaranteed
to be NUL-terminated we'd have messed up already". And I don't think I'm
making anything worse. But yeah, I didn't really step back to look at
what these sites are really doing, and how, as much as I did for the
others.


Martin
