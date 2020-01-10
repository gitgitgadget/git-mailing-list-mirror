Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5439C282DD
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 00:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DDC20661
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 00:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOMS870i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbgAJAUY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 19:20:24 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:41196 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730072AbgAJAUY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 19:20:24 -0500
Received: by mail-wr1-f51.google.com with SMTP id c9so102379wrw.8
        for <git@vger.kernel.org>; Thu, 09 Jan 2020 16:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P+utRVnWYBjwvTYJaI4/g20jtojdwUI98tmdvcNjKB8=;
        b=AOMS870ims77ifBKriVn8xxouW+kEns6a3iJdiZEYBeEM/RAbixZENugXpZEU4OtpI
         kTzDCp7bYcOpbublxAJ/ph5TRlfUtt2hq3mezVWOBCHr6QvnilJb7Uy3mAUpLHOOLwzh
         uqxwO3XVp+/U67jDIb84Cy2LxYv4dzeL/6usiD7KK0rcoL+GoZODkgQJASyYQydST+uF
         4kz+riqcrqAcUGBeoaBuwwC0M9cVTgkz0wk9o+nb0gjKxTzswUdZ4RtBORJ9QQ7Emi7S
         9C3xnn+LhSmZGziXQDH8FYW0cLuF3G4DES6044g5eSkiyigcgjd2rdnkELN8p3e4Y3Tk
         5ndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P+utRVnWYBjwvTYJaI4/g20jtojdwUI98tmdvcNjKB8=;
        b=H3tQuSSTVTo4r1KXBn7CWVkqH6bi9qbTCVPHqv4CTtYhTRRVseWw8mYUaImFZDvpgj
         XVk+wBO44ZEHr/pwVX0I5plIx6KMc4bRc95KszTJRJOo8uf6qmTEr1UtkgHTJKp0cZgX
         iIUhDeZkX2sXyFTkV4KmAOvyiJImC8/yR2tHdFkKapCHxUTiW28kSIW9epxhQKmqLQ7w
         IvzMcB4FUKiMgDpJY8Q/LPAiC8l4bW39XRATq+QUKxc9DakMZ+PMO3TI2NAPyInZ55KP
         9oYwvo3e08RPhv31yuZpPkR7SMXVli1604bG7oOo2SJ1ojezXmP1SuuXYU3d6UqrJXeZ
         v7Dw==
X-Gm-Message-State: APjAAAXYfURa4SGlrJQB1SOzuuMMI24uX4j5HCe5dOa1GHC1vfLMqw3U
        GkDCtggMEh7+fS8sIcfW9Hz/4X6d5k2cD/tYpCU=
X-Google-Smtp-Source: APXvYqzADi1fbsVi2J61OPN7izDfnzOjblW8IZ70I2uJI14bA6zJ+Yh4/XGEWNtpFQHQu0xMiDz8h21RYzD7bgfQC5A=
X-Received: by 2002:a5d:5704:: with SMTP id a4mr144576wrv.198.1578615621188;
 Thu, 09 Jan 2020 16:20:21 -0800 (PST)
MIME-Version: 1.0
References: <CANsz78+ugmd62F4Qk+VT7Pi=ZPtMSkZjXOwLNRCFhoS9jrOkeQ@mail.gmail.com>
 <CANsz78K-BiswWPdhd_N25NuApcv7zSb2cw2Y9DSinkpNpuogYw@mail.gmail.com>
 <CANsz78LEZiocv_E-Hvj3iBahFFgomPb3BFNdmas2iqxqRLfRiw@mail.gmail.com> <20200108095229.GC87523@coredump.intra.peff.net>
In-Reply-To: <20200108095229.GC87523@coredump.intra.peff.net>
From:   Eyal Soha <shawarmakarma@gmail.com>
Date:   Thu, 9 Jan 2020 19:20:09 -0500
Message-ID: <CANsz78Lm3ggVZLrSxM5tc0MozFMdAmVBOix_3sjJT4+s3VHLPQ@mail.gmail.com>
Subject: Re: Fwd: Add support for axiterm colors in parse_color
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Depending on your terminal, you can already access these colors via
> 256-color mode. Generally 0-7 are the standard colors there, then 8-15
> are the "bright" variants, and then an rgb cube.

Yes.  According to the wikipedia page
https://en.wikipedia.org/wiki/ANSI_escape_code#Colors :

     0-  7:  standard colors (as in ESC [ 30=E2=80=9337 m)
     8- 15:  high intensity colors (as in ESC [ 90=E2=80=9397 m)
    16-231:  6 =C3=97 6 =C3=97 6 cube (216 colors): 16 + 36 =C3=97 r + 6 =
=C3=97 g + b (0 =E2=89=A4
r, g, b =E2=89=A4 5)
   232-255:  grayscale from black to white in 24 steps

So 8bit 0-7 and 8bit 8-15 match the ANSI colors 30-37 and 90-97.  The
background color versions match 40-47 and 100-107.

On my desktop, the RGB and ANSI colors match in color as described above.

> That said, I'm not entirely opposed to having more human-readable
> aliases. I'm not sure if it's worth using the 16-color version (e.g.,
> "ESC[91m" versus the 256-color version "ESC[38;5;9m"). It's possible it
> would be compatible with more terminals, and it is slightly fewer bytes.

My motivation for this patch was to fix the github workflow log output
that doesn't support 8bit colors properly.  Only the "ANSI" colors
0-15 worked.  None of the 8-bit colors worked except for 30-37, 40-47,
90-97, and 100-107, which matched the ANSI colors.  That is a very
broken color scheme!  But that's how it displayed.

> What's AXITERM? I couldn't find it mentioned anywhere around ANSI codes.

Oops, I misread it.  The wikipedia page mentions it, it's "aixterm".

> I kind of wonder if we could just call these ANSI as well, and have
> color_output() just decide whether to add an offset of 60 when we see a
> color number between 8 and 15. Or possibly c->value should just have the
> 60-offset value in the first place.

Done.

> This "type" field was already pretty ugly, and I think your patch makes
> it even worse. It would probably be less bad if we just passed in the
> integer 30 instead of '3', and then do:

Done.

> Bonus points for declaring:
>
>   enum {
>     COLOR_FOREGROUND =3D 30,
>     COLOR_BACKGROUND =3D 40,
>   } color_ground;

Done in a slightly different way.

> This BUG() can go away. The point was to make sure we don't overflow
> "out", but xsnprintf() will check that for us (that's why there isn't
> one in the COLOR_256 and COLOR_RGB case arms).

Removed.

> And if we can handle the regular/bright stuff instead of color_output(),
> we don't need to have this extra fg.type check.

Done.  Here's a new patch!

diff --git a/color.c b/color.c
index ebb222ec33..efbe9a1858 100644
--- a/color.c
+++ b/color.c
@@ -24,6 +24,14 @@ const char *column_colors_ansi[] =3D {
        GIT_COLOR_RESET,
 };

+enum {
+       COLOR_BACKGROUND_OFFSET =3D 10,
+       COLOR_FOREGROUND_ANSI =3D 30,
+       COLOR_FOREGROUND_RGB =3D 38,
+       COLOR_FOREGROUND_256 =3D 38,
+       COLOR_FOREGROUND_BRIGHT_ANSI =3D 90,
+};
+
 /* Ignore the RESET at the end when giving the size */
 const int column_colors_ansi_max =3D ARRAY_SIZE(column_colors_ansi) - 1;

@@ -92,7 +100,13 @@ static int parse_color(struct color *out, const
char *name, int len)
        for (i =3D 0; i < ARRAY_SIZE(color_names); i++) {
                if (match_word(name, len, color_names[i])) {
                        out->type =3D COLOR_ANSI;
-                       out->value =3D i;
+                       out->value =3D i + COLOR_FOREGROUND_ANSI;
+                       return 0;
+               }
+               if (*name =3D=3D '+' &&
+                   match_word(name+1, len-1, color_names[i])) {
+                       out->type =3D COLOR_ANSI;
+                       out->value =3D i + COLOR_FOREGROUND_BRIGHT_ANSI;
                        return 0;
                }
        }
@@ -109,10 +123,15 @@ static int parse_color(struct color *out, const
char *name, int len)
                else if (val < 0) {
                        out->type =3D COLOR_NORMAL;
                        return 0;
-               /* Rewrite low numbers as more-portable standard colors. */
+               /* Rewrite 0-7 as more-portable standard colors. */
                } else if (val < 8) {
                        out->type =3D COLOR_ANSI;
-                       out->value =3D val;
+                       out->value =3D val + COLOR_FOREGROUND_ANSI;
+                       return 0;
+               /* Rewrite 8-15 as more-portable aixterm colors. */
+               } else if (val < 16) {
+                       out->type =3D COLOR_ANSI;
+                       out->value =3D val - 8 + COLOR_FOREGROUND_BRIGHT_AN=
SI;
                        return 0;
                } else if (val < 256) {
                        out->type =3D COLOR_256;
@@ -166,24 +185,24 @@ int color_parse(const char *value, char *dst)
  * already have the ANSI escape code in it. "out" should have enough
  * space in it to fit any color.
  */
-static char *color_output(char *out, int len, const struct color *c, char =
type)
+static char *color_output(char *out, int len, const struct color *c,
+                         int offset)
 {
        switch (c->type) {
        case COLOR_UNSPECIFIED:
        case COLOR_NORMAL:
                break;
        case COLOR_ANSI:
-               if (len < 2)
-                       BUG("color parsing ran out of space");
-               *out++ =3D type;
-               *out++ =3D '0' + c->value;
+               out +=3D xsnprintf(out, len, "%d", c->value + offset);
                break;
        case COLOR_256:
-               out +=3D xsnprintf(out, len, "%c8;5;%d", type, c->value);
+         out +=3D xsnprintf(out, len, "%d;5;%d", COLOR_FOREGROUND_256 + of=
fset,
+                          c->value);
                break;
        case COLOR_RGB:
-               out +=3D xsnprintf(out, len, "%c8;2;%d;%d;%d", type,
-                                c->red, c->green, c->blue);
+         out +=3D xsnprintf(out, len, "%d;2;%d;%d;%d",
+                          COLOR_FOREGROUND_RGB + offset,
+                          c->red, c->green, c->blue);
                break;
        }
        return out;
@@ -279,14 +298,12 @@ int color_parse_mem(const char *value, int
value_len, char *dst)
                if (!color_empty(&fg)) {
                        if (sep++)
                                OUT(';');
-                       /* foreground colors are all in the 3x range */
-                       dst =3D color_output(dst, end - dst, &fg, '3');
+                       dst =3D color_output(dst, end - dst, &fg, 0);
                }
                if (!color_empty(&bg)) {
                        if (sep++)
                                OUT(';');
-                       /* background colors are all in the 4x range */
-                       dst =3D color_output(dst, end - dst, &bg, '4');
+                       dst =3D color_output(dst, end - dst, &bg,
COLOR_BACKGROUND_OFFSET);
                }
                OUT('m');
        }
diff --git a/t/t4026-color.sh b/t/t4026-color.sh
index 671e951ee5..e3f11a94f9 100755
--- a/t/t4026-color.sh
+++ b/t/t4026-color.sh
@@ -30,6 +30,14 @@ test_expect_success 'attribute before color name' '
        color "bold red" "[1;31m"
 '

+test_expect_success 'axiterm bright fg color' '
+       color "+red" "[91m"
+'
+
+test_expect_success 'axiterm bright bg color' '
+       color "green +blue" "[32;104m"
+'
+
 test_expect_success 'color name before attribute' '
        color "red bold" "[1;31m"
 '
@@ -74,6 +82,10 @@ test_expect_success '0-7 are aliases for basic ANSI
color names' '
        color "0 7" "[30;47m"
 '

+test_expect_success '8-15 are aliases for aixterm color names' '
+       color "12 13" "[94;105m"
+'
+
 test_expect_success '256 colors' '
        color "254 bold 255" "[1;38;5;254;48;5;255m"
 '
