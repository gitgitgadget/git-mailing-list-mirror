Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CBDC2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 11:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACB5061185
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 11:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbhFNLzS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 07:55:18 -0400
Received: from mail-yb1-f172.google.com ([209.85.219.172]:37461 "EHLO
        mail-yb1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235585AbhFNLyi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 07:54:38 -0400
Received: by mail-yb1-f172.google.com with SMTP id b13so15018303ybk.4
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 04:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NLwm0UeLIOL4cawPb/TNpBqsp6UCLBRlZkEAKEpDrIY=;
        b=K8iB9kstjQPXM1Z3D2Ikl44vCFkdqkaTCo7rRSPvrnD2tGq/M0DHcJDL6gK2Mn8n2S
         8luycUsVCkDTmfvJsV8vVgXknuHqARhnjaw5hK+DUIjBmXh75YZ2hDL+ASoboMHB5EwC
         jL6CASQlfrvg2XwG7crHRfJpb8tvbA2k1vrUe5LqTNXC/actX+IqI0AvNFtYQw3ToqIA
         NgvlOk0G84d1h4nVXExre+GOdNQLa5MNFO42nPnfaTaIm+Zb9ebZKm+r1ydH4m9RsvpV
         +tyfwJL/Kmcjk3Pna/POovhvhYgS9pqHXtH1jnyT7wY5+dj4gW9kRAjTjlahqDMo5OCp
         s1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NLwm0UeLIOL4cawPb/TNpBqsp6UCLBRlZkEAKEpDrIY=;
        b=KOgouDLXz6Ja1Hp57JDQANMd7StmXR5MTga3Lgby+bOWFMtLOOW6qWsyeALX2OP6XE
         whTdK7wAgTchjt49a1qmRGhgqYGN9Bu/Dn4E3WyYKUhtoHvDyqcyTPbk2HAX3aMAGCWd
         oKW+VSVWv+ehj1CLkzYbgAMgCGc1yQWA2lBgoh2XRRLbmVKA/NnELsQD2piBe2GXfSaI
         ugIPLT9UNp+NnBNTAXw87jNYAoNCK236uW8cAbHpkWoq25xLE/NX6PVwLqjF1vpPaGv2
         i3IyCYv2y5VFygxWRpTyIcfe5J0znW89GsqPeD+ALhfaq0zfO/lsCyl9z76EjiqQ6t3P
         jjiw==
X-Gm-Message-State: AOAM532nxrEcRYQJ1UVmGzfNmjmZb1i9F+xCB/hcpfXpl5FN71OZDr+6
        96UmA4xdq+D0dH4VT5kHhSaw/Ias2XTl3ZGgEO8=
X-Google-Smtp-Source: ABdhPJwEDQIpV4cUdi5S9ye1D/C9JbJquVdN9a22bZcNAMWS/ncdAZcDFrEiMcHTN29JPaxehO+NYIflGrIK/7OisoU=
X-Received: by 2002:a25:558b:: with SMTP id j133mr24037937ybb.520.1623671495125;
 Mon, 14 Jun 2021 04:51:35 -0700 (PDT)
MIME-Version: 1.0
References: <87im2s5jjm.fsf@evledraar.gmail.com> <20210612050711.4057-4-worldhello.net@gmail.com>
 <xmqqim2hyuj1.fsf@gitster.g>
In-Reply-To: <xmqqim2hyuj1.fsf@gitster.g>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 14 Jun 2021 19:51:23 +0800
Message-ID: <CANYiYbGtfgZepnfTWGjbmOh2bxa8tZ7bvgtVTo6qTQpCP9MPag@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] sideband: append suffix for message whose CR in
 next pktline
To:     Junio C Hamano <gitster@pobox.com>,
        Nicolas Pitre <nico@fluxnic.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=8814=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=8811:50=E5=86=99=E9=81=93=EF=BC=9A
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> >
> > When calling "demultiplex_sideband" on a sideband-2 message, will try t=
o
> > split the message by line breaks, and append a suffix to each nonempty
> > line to clear the end of the screen line.
>
> Subject of "will try" and "append" is missing.  Do you mean that
> the helper function in question does these two things?  I.e.
>
>         demultiplex_sideband() used on a sideband #2 will try
>         to... and appends ...
>
> > But in the following example,
> > there will be no suffix (8 spaces) for "<message-3>":
> >
> >     PKT-LINE(\2 <message-1> CR <message-2> CR <message-3>)
> >     PKT-LINE(\2 CR <message-4> CR <message-5> CR)
>
> That description may mechanically correct, but
>
>    after <message-3>, we fail to clear to the end of line
>
> may make it easier to understand what the problem we are trying to
> solve for those who do not remember what these suffix games are
> about.
>
> > This is because the line break of "<message-3>" is placed in the next
> > pktline message.
> >
> > Without this fix, t5411 must remove trailing spaces of the actual outpu=
t
> > of "git-push" command before comparing.
> >
> > Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> > ---
> >  sideband.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/sideband.c b/sideband.c
> > index 6f9e026732..abf2be98e1 100644
> > --- a/sideband.c
> > +++ b/sideband.c
> > @@ -185,6 +185,10 @@ int demultiplex_sideband(const char *me, int statu=
s,
> >
> >                       if (!scratch->len)
> >                               strbuf_addstr(scratch, DISPLAY_PREFIX);
> > +                     else if (!linelen)
> > +                             /* buf has a leading CR which ends the re=
maining
> > +                              * scratch of last round of "demultiplex_=
sideband" */
> > +                             strbuf_addstr(scratch, suffix);
>
> The style of multi-line comment needs fixing, but the contents of
> the comment is a bit hard to grok.
>
> >                       if (linelen > 0) {
> >                               maybe_colorize_sideband(scratch, b, linel=
en);
> >                               strbuf_addstr(scratch, suffix);
>
> I wonder if the following is simpler to read, though.
>
> -- >8 --
> Subject: [PATCH] sideband: don't lose clear-to-eol at packet boundary
>
> When demultiplex_sideband() sees a CR or LF on the sideband #2, it
> adds "suffix" string to clear to the end of the current line, which
> helps when relaying a progress display whose records are terminated
> with CRs.
>
> The code however forgot that depending on the length of the payload
> line, such a CR may fall exactly at the packet boundary and the
> number of bytes before the CR from the beginning of the packet could
> be zero.  In such a case, the message that was terminated by the CR
> were leftover in the "scratch" buffer in the previous call to the
> function and we still need to clear to the end of the current line.
>
> Just remove the unnecessary check on linelen; maybe_colorize_sideband()
> on 0-byte payload turns into a no-op, and we should be adding clear-to-eo=
l
> for each and every CR/LF anyway.
>
>  sideband.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git c/sideband.c w/sideband.c
> index 6f9e026732..1575bf16dd 100644
> --- c/sideband.c
> +++ w/sideband.c
> @@ -185,10 +185,9 @@ int demultiplex_sideband(const char *me, int status,
>
>                         if (!scratch->len)
>                                 strbuf_addstr(scratch, DISPLAY_PREFIX);
> -                       if (linelen > 0) {
> -                               maybe_colorize_sideband(scratch, b, linel=
en);
> -                               strbuf_addstr(scratch, suffix);
> -                       }
> +
> +                       maybe_colorize_sideband(scratch, b, linelen);
> +                       strbuf_addstr(scratch, suffix);
>
>                         strbuf_addch(scratch, *brk);
>                         xwrite(2, scratch->buf, scratch->len);

The above changes will add suffix to the end of each line, and even an
empty lines.  However, according to the comment in commit ebe8fa738d
(fix display overlap between remote and local progress, 2007-11-04)
which introduced the suffix implementation for the first time, no
suffix should be appended for empty lines.

    /*
     * Let's insert a suffix to clear the end
     * of the screen line, but only if current
     * line data actually contains something.
     */

So my implementation is to try not to break the original
implementation, and keep the linelen unchanged.

The strbuf "scratch" will be reset at line 18th in the while block, so
the nonempty scratch at line 7 indicates the parameter scratch of
demultiplex_sideband() is not empty. With the following patch,
additional suffix is only added before a leading CR in a packet which
is seperated with its message by packet boundary.

```
01    while ((brk =3D strpbrk(b, "\n\r"))) {
02            int linelen =3D brk - b;
03
04 +         /* Has no empty scratch from last call of "demultiplex_sideban=
d"
05 +          * and has a leading CR in buf.
06 +          */
07 +         if (scratch->len && !linelen)
08 +                   strbuf_addstr(scratch, suffix);
09            if (!scratch->len)
10                    strbuf_addstr(scratch, DISPLAY_PREFIX);
11            if (linelen > 0) {
12                    maybe_colorize_sideband(scratch, b, linelen);
13                    strbuf_addstr(scratch, suffix);
14            }
15
16            strbuf_addch(scratch, *brk);
17            xwrite(2, scratch->buf, scratch->len);
18            strbuf_reset(scratch);
19
20            b =3D brk + 1;
21    }
```
