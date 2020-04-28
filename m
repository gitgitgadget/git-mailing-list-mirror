Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBFAC83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 07:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEC92206B9
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 07:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCyIooeV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgD1HkA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbgD1HkA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 03:40:00 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FFEC03C1A9
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 00:39:59 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id re23so16464599ejb.4
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 00:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9oNhjK3vufEohZtKSv5/sQLOMVYYERIYV3Oqgsa6ESU=;
        b=bCyIooeVwfOxgYFICSykxLszLpv2iO0kWwIPHL1yA3upiJDQ+zmuaHMtk4d5E2KR7R
         ZLr1HPO0x6PJgyJrSnV1i8IBhHkf023JWIjZd6PxS393OdN1gf0D5lny+laWs2Kf/tw8
         GgrNEHLohgEroW9+7Xe25PCbEI/Ba9nkd/pt+6A9LobwpYqymsXcZp2z9mtKHIF70TkM
         J7LDH2wM3n9iYfyk37Zzq8AwW8kGh82SPAbdS4cLTDZRdAetouvRDo9XKTamc6xMErWY
         A24rZfGBH43buRIlmvc/v5IsLtZEdgHnkY3xUDpASCHLLrepi8W0QkSFFoEtVTN68MSm
         GnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9oNhjK3vufEohZtKSv5/sQLOMVYYERIYV3Oqgsa6ESU=;
        b=scfNzd7iy++NxPNMjln7AZDr+jMPRUuRHZu709bxtHfNbI4UTeB/eu53Ne1AS6AdEE
         F3s2mWpRira8IVeIiqj+RU40TYkSYU9CiG3srr155YkI01xoGMcMlvJFNNEI1zs4yQWe
         Lw/xv07PFqKWU0WjaU554+MvJfi4Ksr8DWq40frBhPVX5FDyk1k0kw3zWlcewgbZy8GZ
         JRNs4JiMf5gbaa5YN7KR5TF0CKCcKQVDKgsILZtuTSMFg0zLZ8jfqwfxAITn5gCd3Z0j
         oSaPbKWd9o09WOMqJ+uBg5IMa+onBUq7eHqkGSqTD9sJNdgdvUlBBmrXQbHXawY2dgkA
         nKGg==
X-Gm-Message-State: AGi0PuZHkfaZcQFp94FZTZBBL1khXPYL+p5HRDizF6I6ZNoA/j+ksFIG
        njazLPEOflMazN77Yd5HE3F/jE0bvbB10jt1Ylo=
X-Google-Smtp-Source: APiQypLmbf69gtlwYCYHWs/uqL+0suTkBDS/WoeEG4WX7hdmnC9Y2iU/s51+Rn6bHto6Js2Dycj0r8rr54Xi3J7s2fI=
X-Received: by 2002:a17:906:8286:: with SMTP id h6mr15253985ejx.28.1588059597712;
 Tue, 28 Apr 2020 00:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200422163357.27056-1-chriscool@tuxfamily.org> <20200422232744.GA19100@syl.local>
In-Reply-To: <20200422232744.GA19100@syl.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 28 Apr 2020 09:39:46 +0200
Message-ID: <CAP8UFD2DdziVH0esBr9h_T17LfA73QgosViEpedSZ6NU+X=JsQ@mail.gmail.com>
Subject: Re: [RFC PATCH] fetch-pack: try harder to read an ERR packet
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 23, 2020 at 1:27 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Wed, Apr 22, 2020 at 06:33:57PM +0200, Christian Couder wrote:
>
> It looks like this may be missing a:
>
>   From: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>
> header.

Yeah, I wanted to have him as the author but forgot. The next version
will have it.

[...]

> > ---
> > This just formats the following patch from SZEDER G=C3=A1bor:
> >
> > https://lore.kernel.org/git/20190830121005.GI8571@szeder.dev/
> >
> > I haven't tried to implement some suggestions discussed later
> > in the above thread like:
> >
> >   - renaming send_request()
>
> Agreed that this is probably something we should do. Maybe
> 'send_request_retry' or something? That name is kind of terrible.

Not sure 'send_request_retry' is better as we are not really retrying
to send the request. My take would be something like
'send_request_read_err'. For now I have left it as is though.

> >   - covering more code pathes
>
> I see where Peff raised this point originally, but I think that this is
> a good step forward as-is. No need to hold this up looking for complete
> coverage, since this is obviously improving the situation.

Ok.

> >   - avoid blocking indefinitely by looking for an ERR packet
> >     only if the write() resulted in ECONNRESET or EPIPE
>
> I think that I may have addressed this point below.
>
> >   - first printing an error message with error_errno() before
> >     going on to look for an ERR packet
>
> I'm not sure what I think about this one. I'd certainly welcome all
> opinions on this matter.
>
> >   - implementing a timeout
>
> A timeout may be a good thing to do. See what you think about my
> suggestion below, first, though.

Ok, thanks for your suggestion.

> > diff --git a/fetch-pack.c b/fetch-pack.c
> > index 1734a573b0..63e8925e2b 100644
> > --- a/fetch-pack.c
> > +++ b/fetch-pack.c
> > @@ -185,14 +185,27 @@ static enum ack_type get_ack(struct packet_reader=
 *reader,
> >  }
> >
> >  static void send_request(struct fetch_pack_args *args,
> > -                      int fd, struct strbuf *buf)
> > +                      int fd, struct strbuf *buf,
> > +                      struct packet_reader *reader)
> >  {
> >       if (args->stateless_rpc) {
> >               send_sideband(fd, -1, buf->buf, buf->len, LARGE_PACKET_MA=
X);
> >               packet_flush(fd);
> >       } else {
> > -             if (write_in_full(fd, buf->buf, buf->len) < 0)
> > +             if (write_in_full(fd, buf->buf, buf->len) < 0) {
>
> This makes sense; if 'write_in_full' fails, we want to go into the
> error-handling case below.
>
> But, I wonder if we could do better than re-using 'write_in_full' here.
> We definitely do want to write 'buf->len' bytes overall, but what
> happens when a 'write()' fails? I think it's at _that_ point we want to
> try and read a packet or two off from the remote.

Yeah, good idea.

> What if instead this looked something like:
>
>   const char *p =3D buf;
>   ssize_t total =3D 0;
>
>   while (count > 0) {
>     ssize_t written =3D xwrite(fd, p, count);
>     if (written < 0)
>       return -1;
>     /* note the change on this line */
>     if (!written && packet_reader_read(reader) =3D=3D PACKET_READ_EOF) {
>       errno =3D ENOSPC;
>       return -1;
>     }
>     count -=3D written;
>     p +=3D written;
>     total +=3D written;
>   }
>
>   return total;
>
> That is basically the definition of 'write_in_full', but when we didn't
> get a chance to write anything, then we try to read one packet.

Yeah, your code above looks correct. I have added a new function doing
the above in the new version I will send soon.

> This way, we only read exactly as many packets as we need to when we hit
> this case. I'm not sure that it matters in practice, though.

I am not sure I understand what you think doesn't matter in practice.

Thanks,
Christian.
