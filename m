Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C309C33CB1
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 15:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450E5222C3
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 15:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tcq5yBAr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgAOPdG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 10:33:06 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37859 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbgAOPdF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 10:33:05 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so329065wmf.2
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 07:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=csRxQ0UUSEki60eYzNN6A7QJ5DBmI9otmuF/xKcSidM=;
        b=tcq5yBArUPsIW/TGbW3gGtkJYmxlB2DZh1/E3xANycPlr3i2JspAvNHw7hw7E3colP
         KuScSB5yYI2/CiRDzqsPp+aNaKRetBuHnpi6ld70ZsLfXqiTicpjpGli7VZEW1cRR4ip
         Ycn61OI/jVvlt/xcHJvZaOT5DpFw6ROYhbm1rILmIYLp23ofiOII9/ZlhwXA2tvTaR4O
         KsblZTE7W5m/1ErvsVifV2RDU7BsLtxJZhxbALLt8Kh4+T6RuW0D3l9RQ1svemzIIZV1
         9agKMOdSNrpTVxnimV3PpONww9G9UvUY4ZtNnQyUSpceOM9lbhszgbfYebr51lIYaxxV
         VrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=csRxQ0UUSEki60eYzNN6A7QJ5DBmI9otmuF/xKcSidM=;
        b=BgrnjzIaVnTImFg+SPSjrSivMS4Xrcl2A2kFghkGhHUMA0p8BO+tV7lXGZ6ocj2/NI
         v5ElrbXUhYUxn57+AhXP4MkQeD6NhwGNUNyF4N4yu5JQznBLvUrnOyYq6jFrGiIfzGTl
         XGjZMVOANZzgiu6eZqhyEzojQaNEAScErvUl/ci20EFWO9uayHm7Ee5m9qp7YbLXUyst
         TeSNr7CNumRlM8T+rXZKMF1Pv6kSFM2EUcGdRW8bgw/IxNAO04/NJNMqRXk6hCh6dlPz
         0PUzPuCJmwSyCFSf7J4xdVf0hFos0+BKOtKuRGtsMb+iwUcaxeHYBuo+Qbkar487z8nE
         /IBw==
X-Gm-Message-State: APjAAAU+yNf6EVFyiTW2pFeZ6RCYbTxxQR40qSg0wx6s8QNJaiWsEbE3
        BSnHQSD9qjr8Qx82P2+oMEDOQAOL7PNjewWXA7c=
X-Google-Smtp-Source: APXvYqxAyj8Y6taY0jBPYflsBMPorAN0HzsbTu+YQ9RPE6tzOwYnq0AdYYYhX3OPjvc025hV9pvt0kEPiOd7wyJxaOc=
X-Received: by 2002:a1c:4e03:: with SMTP id g3mr432142wmh.22.1579102382525;
 Wed, 15 Jan 2020 07:33:02 -0800 (PST)
MIME-Version: 1.0
References: <CANsz78+ugmd62F4Qk+VT7Pi=ZPtMSkZjXOwLNRCFhoS9jrOkeQ@mail.gmail.com>
 <CANsz78K-BiswWPdhd_N25NuApcv7zSb2cw2Y9DSinkpNpuogYw@mail.gmail.com>
 <CANsz78LEZiocv_E-Hvj3iBahFFgomPb3BFNdmas2iqxqRLfRiw@mail.gmail.com>
 <20200108095229.GC87523@coredump.intra.peff.net> <CANsz78Lm3ggVZLrSxM5tc0MozFMdAmVBOix_3sjJT4+s3VHLPQ@mail.gmail.com>
 <20200110111516.GA474613@coredump.intra.peff.net> <CANsz78Knt4RKGzNj4W3j7G9rh8N8jtCsOgOa_jTU-NetpgvVGA@mail.gmail.com>
In-Reply-To: <CANsz78Knt4RKGzNj4W3j7G9rh8N8jtCsOgOa_jTU-NetpgvVGA@mail.gmail.com>
From:   Eyal Soha <shawarmakarma@gmail.com>
Date:   Wed, 15 Jan 2020 10:32:51 -0500
Message-ID: <CANsz78Kh3YUPfbea6=oCRJf6PC5RMLihTmpX0SPZdhTKuo-D5w@mail.gmail.com>
Subject: Re: Fwd: Add support for axiterm colors in parse_color
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I sent out my patches.  Can someone take a look?

Thanks,

Eyal

On Fri, Jan 10, 2020 at 10:02 AM Eyal Soha <shawarmakarma@gmail.com> wrote:
>
> Thanks.  I think that 3 patches are in order.  The first will refactor
> and add the enums.  The second will add the aixterm colors.  The last
> will alias RGB 8-15 to aixterm colors.
>
> What's the correct way to email those patches?  I will try with
> git-send-email.  BTW, is "git help send-email" supposed to work?
>
> Eyal
> On Fri, Jan 10, 2020 at 6:15 AM Jeff King <peff@peff.net> wrote:
> >
> > On Thu, Jan 09, 2020 at 07:20:09PM -0500, Eyal Soha wrote:
> >
> > > > That said, I'm not entirely opposed to having more human-readable
> > > > aliases. I'm not sure if it's worth using the 16-color version (e.g.,
> > > > "ESC[91m" versus the 256-color version "ESC[38;5;9m"). It's possible it
> > > > would be compatible with more terminals, and it is slightly fewer bytes.
> > >
> > > My motivation for this patch was to fix the github workflow log output
> > > that doesn't support 8bit colors properly.  Only the "ANSI" colors
> > > 0-15 worked.  None of the 8-bit colors worked except for 30-37, 40-47,
> > > 90-97, and 100-107, which matched the ANSI colors.  That is a very
> > > broken color scheme!  But that's how it displayed.
> >
> > That makes sense. I'm not too surprised to see a terminal that supports
> > one but not the other.
> >
> > But I wonder if there are ones that go the other way around: supporting
> > 256-color mode but not ANSI 90-97, etc. I doubt it, but I think it would
> > be nice to split that change out into a separate commit in case we do
> > run into problems.
> >
> > > Done.  Here's a new patch!
> >
> > Thanks. The content here is looking pretty good (though I have a few
> > comments below).
> >
> > Can you also format it as described in Documentation/SubmittingPatches
> > and re-send? In particular, it needs a regular commit message and your
> > signoff.
> >
> > > +enum {
> > > +       COLOR_BACKGROUND_OFFSET = 10,
> > > +       COLOR_FOREGROUND_ANSI = 30,
> > > +       COLOR_FOREGROUND_RGB = 38,
> > > +       COLOR_FOREGROUND_256 = 38,
> > > +       COLOR_FOREGROUND_BRIGHT_ANSI = 90,
> > > +};
> >
> > The split in this enum mostly makes sense to me. It changes the meaning
> > of "value" for COLOR_ANSI, but this is all local to color.c, so your
> > changes to output_color() are all that's needed.
> >
> > It might be easier to follow the patch if switching to this enum came in
> > a separate preparatory patch.
> >
> > > @@ -92,7 +100,13 @@ static int parse_color(struct color *out, const
> > > char *name, int len)
> > >         for (i = 0; i < ARRAY_SIZE(color_names); i++) {
> > >                 if (match_word(name, len, color_names[i])) {
> > >                         out->type = COLOR_ANSI;
> > > -                       out->value = i;
> > > +                       out->value = i + COLOR_FOREGROUND_ANSI;
> > > +                       return 0;
> > > +               }
> > > +               if (*name == '+' &&
> > > +                   match_word(name+1, len-1, color_names[i])) {
> > > +                       out->type = COLOR_ANSI;
> > > +                       out->value = i + COLOR_FOREGROUND_BRIGHT_ANSI;
> > >                         return 0;
> > >                 }
> >
> > It would be slightly simpler and more efficient handle the "+" outside
> > the loop, like:
> >
> >   int offset = COLOR_FOREGROUND_ANSI;
> >   if (*name == '+') {
> >           offset = COLOR_FOREGROUND_BRIGHT_ANSI;
> >           name++;
> >           len--;
> >   }
> >
> > and then in the loop just set "out->value = i + offset".
> >
> > You'd probably want to hoist this out to a separate function since
> > "name" needs to be unchanged in the later part of the function.
> >
> > I dunno. It's almost certainly an unmeasurable micro-optimization, but
> > somehow the flow of it seems simpler to me.
> >
> > I also wondered if we'd want English aliases like "brightred" that some
> > other systems use. It would be easy to add that to the check I showed
> > above without having to repeat as much.
> >
> > > @@ -109,10 +123,15 @@ static int parse_color(struct color *out, const
> > > char *name, int len)
> > >                 else if (val < 0) {
> > >                         out->type = COLOR_NORMAL;
> > >                         return 0;
> > > -               /* Rewrite low numbers as more-portable standard colors. */
> > > +               /* Rewrite 0-7 as more-portable standard colors. */
> > >                 } else if (val < 8) {
> > >                         out->type = COLOR_ANSI;
> > > -                       out->value = val;
> > > +                       out->value = val + COLOR_FOREGROUND_ANSI;
> > > +                       return 0;
> > > +               /* Rewrite 8-15 as more-portable aixterm colors. */
> > > +               } else if (val < 16) {
> > > +                       out->type = COLOR_ANSI;
> > > +                       out->value = val - 8 + COLOR_FOREGROUND_BRIGHT_ANSI;
> >
> > And I think this 8-15 handling might want to be a separate commit on
> > top, just because it's possible it might regress some cases (though
> > again, I do doubt it).
> >
> > >         case COLOR_256:
> > > -               out += xsnprintf(out, len, "%c8;5;%d", type, c->value);
> > > +         out += xsnprintf(out, len, "%d;5;%d", COLOR_FOREGROUND_256 + offset,
> > > +                          c->value);
> >
> > Looks like some unwanted tab/space conversion (here and elsewhere).
> >
> > > +test_expect_success 'axiterm bright fg color' '
> > > +       color "+red" "[91m"
> >
> > s/axi/aix/ (here and below).
> >
> > > +test_expect_success '8-15 are aliases for aixterm color names' '
> > > +       color "12 13" "[94;105m"
> >
> > Makes sense.
> >
> > -Peff
