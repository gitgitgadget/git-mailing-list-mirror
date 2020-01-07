Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C9EC33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 15:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF5CA2081E
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 15:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qd5gHazG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgAGPhI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 10:37:08 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:40047 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgAGPhI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 10:37:08 -0500
Received: by mail-wr1-f53.google.com with SMTP id c14so54437706wrn.7
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 07:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=4J4xFNGx+X8+jSi8M0NAHMXd7lwZXuuD5C3tMx1rLRE=;
        b=Qd5gHazGpRLCaOtTZGogEA+mLlQCpqECUKmEfJGzWYbmJ9GTcA+FjhnYrZIJpFjZlx
         ETcK2ox61o42Fbto2Stx3aanjAfJLDlk+9MTizK/k73nTHWekuukK3XOJ93OMGnC7E76
         m4b08WVed0/uhMS5fPRvS+j+DXLnzku+uYT02+GOQ+FPe0Ad0UfmLAU+1OugYVGAaKoe
         np8kGBHaYs61FaIg46xf//LgfZ4zxzmlee6+Px76FHHxX/eQeTMtOpEBoLVlrc/PQC9O
         BGwRjTbmUf3uAfP3W8uYZp5qwkL7UIadynvIddPb7/+CViWDSQfiMJx1Y2iuRKqJqvtp
         x8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=4J4xFNGx+X8+jSi8M0NAHMXd7lwZXuuD5C3tMx1rLRE=;
        b=Y3Btg3ZBKszjzOpjedulj8Ebmm6dwJcgzLQ7XEjwDZAmbUFpEbakR5r2/qN3FyQmoO
         ABGtwmQAPOtPogQUrhGJ54TaNR91JIoa+H8LY/PAMV3lyV+XXrU66JbA5lSHwwtlGitP
         qxSH7w6MBd9Av0NHoWJMzMyZkWEhVnH8GZGLwUTjPgKbldrEIYFXZ6Nw8smZKespx6Ks
         0q3HVbJ3XIb5u+08D3K/8QtQiuoia7fXYG0Iw+3mfjZqMOjDrAI1yQc13g1e/y4bcta5
         RWsb8okzdp4UR6+TpKAk9vB52Qmf48ABslnr9apvQ0ppfUj/8yWJ0vAITYBvVtsYOBhV
         2lcA==
X-Gm-Message-State: APjAAAVOGPCKtnYbkslMnj0HlDa7511GD+ULnF5xRWSeHoyzHkFpAuo5
        BPbgla9z1GNZvrDsBdshc2U2XUfIU/VBLD/v+NPlOQ==
X-Google-Smtp-Source: APXvYqyZqv/GiXZkCFGC6xazWnffsG8DppWwwLqRPOCxhhKT9XddCJHME+uGMjlNsAXBRwB/5sjzrrN5TAUQ6zutyAQ=
X-Received: by 2002:adf:e6c6:: with SMTP id y6mr110277466wrm.284.1578411424321;
 Tue, 07 Jan 2020 07:37:04 -0800 (PST)
MIME-Version: 1.0
References: <CANsz78+ugmd62F4Qk+VT7Pi=ZPtMSkZjXOwLNRCFhoS9jrOkeQ@mail.gmail.com>
 <CANsz78K-BiswWPdhd_N25NuApcv7zSb2cw2Y9DSinkpNpuogYw@mail.gmail.com>
In-Reply-To: <CANsz78K-BiswWPdhd_N25NuApcv7zSb2cw2Y9DSinkpNpuogYw@mail.gmail.com>
From:   Eyal Soha <shawarmakarma@gmail.com>
Date:   Tue, 7 Jan 2020 10:36:53 -0500
Message-ID: <CANsz78LEZiocv_E-Hvj3iBahFFgomPb3BFNdmas2iqxqRLfRiw@mail.gmail.com>
Subject: Fwd: Add support for axiterm colors in parse_color
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

https://en.wikipedia.org/wiki/ANSI_escape_code

ANSI color codes 90-97 and 100-107 are brighter versions of the 30-37
and 40-47 colors.  To view them, run `colortest-16`.  In that
colortest, they are named with a leading "+".  Maybe git config could
support those colors, too, with a leading plus in the name?  They are
nice for having a different shade of a color in a diff.

Here's a patch with tests.  I don't know how to submit it.  Thoughts?

Eyal

diff --git a/color.c b/color.c
index ebb222ec33..a39fe7d133 100644
--- a/color.c
+++ b/color.c
@@ -33,6 +33,7 @@ struct color {
                COLOR_UNSPECIFIED = 0,
                COLOR_NORMAL,
                COLOR_ANSI, /* basic 0-7 ANSI colors */
+               COLOR_AXITERM, /* brighter than 0-7 ANSI colors */
                COLOR_256,
                COLOR_RGB
        } type;
@@ -95,6 +96,12 @@ static int parse_color(struct color *out, const
char *name, int len)
                        out->value = i;
                        return 0;
                }
+               if (*name == '+' &&
+                   match_word(name+1, len-1, color_names[i])) {
+                       out->type = COLOR_AXITERM;
+                       out->value = i;
+                       return 0;
+               }
        }

        /* And finally try a literal 256-color-mode number */
@@ -166,23 +173,24 @@ int color_parse(const char *value, char *dst)
  * already have the ANSI escape code in it. "out" should have enough
  * space in it to fit any color.
  */
-static char *color_output(char *out, int len, const struct color *c, char type)
+static char *color_output(char *out, int len, const struct color *c,
+                          const char *type)
 {
        switch (c->type) {
        case COLOR_UNSPECIFIED:
        case COLOR_NORMAL:
                break;
        case COLOR_ANSI:
-               if (len < 2)
+       case COLOR_AXITERM:
+               if (len < strlen(type) + 1)
                        BUG("color parsing ran out of space");
-               *out++ = type;
-               *out++ = '0' + c->value;
+               out += xsnprintf(out, len, "%s%c", type, '0' + c->value);
                break;
        case COLOR_256:
-               out += xsnprintf(out, len, "%c8;5;%d", type, c->value);
+               out += xsnprintf(out, len, "%s8;5;%d", type, c->value);
                break;
        case COLOR_RGB:
-               out += xsnprintf(out, len, "%c8;2;%d;%d;%d", type,
+               out += xsnprintf(out, len, "%s8;2;%d;%d;%d", type,
                                 c->red, c->green, c->blue);
                break;
        }
@@ -279,14 +287,24 @@ int color_parse_mem(const char *value, int
value_len, char *dst)
                if (!color_empty(&fg)) {
                        if (sep++)
                                OUT(';');
-                       /* foreground colors are all in the 3x range */
-                       dst = color_output(dst, end - dst, &fg, '3');
+                       /* foreground colors are in the 3x range */
+                       char *range = "3";
+                       if (fg.type == COLOR_AXITERM) {
+                               /* axiterm fg colors are in the 9x range */
+                               range = "9";
+                       }
+                       dst = color_output(dst, end - dst, &fg, range);
                }
                if (!color_empty(&bg)) {
                        if (sep++)
                                OUT(';');
                        /* background colors are all in the 4x range */
-                       dst = color_output(dst, end - dst, &bg, '4');
+                       char *range = "4";
+                       if (bg.type == COLOR_AXITERM) {
+                               /* axiterm bg colors are in the 10x range */
+                               range = "10";
+                       }
+                       dst = color_output(dst, end - dst, &bg, range);
                }
                OUT('m');
        }
diff --git a/t/t4026-color.sh b/t/t4026-color.sh
index 671e951ee5..2b8430584f 100755
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
