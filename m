Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B348C433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 22:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FC0E6105A
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 22:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhJYWfF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 18:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbhJYWfC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 18:35:02 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778C8C061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 15:32:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id z11-20020a1c7e0b000000b0030db7b70b6bso829059wmc.1
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 15:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Q9rBPsMgT8LYpfRhHZ5HzeLIgql79EkT+iZdqWZg3As=;
        b=hDOc5Mq6lYxbdjWC4VYer0gdILUd8kDxnl/sHPOyW4Pmjlv56AkiYowBmq7fuYkBGL
         f3XaLESk1G3wIJafywKT/NCte1KDNUX/0005HltBsJs5sU9FZWZ79lxI4tsvIcZ8NYAP
         VmHv/NPx/qrIlA9Ev4QnRnmGPmlWEiyCwy/XGlw+73VLQdYbVEdMQFnwRPCL/uPxRFqG
         o+UDYkIAoi/X+qIU5/skkvB7kdR1UF/URZnvYGQFYgIKyuDgqr5dkn26N/S3zWmI5r95
         IsNjRzHCezgSr41nXy06zqxtefwJc13Ovus8YH8TdUnNoNbLPw1kUD8RHNSh/DxZWsBQ
         eRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Q9rBPsMgT8LYpfRhHZ5HzeLIgql79EkT+iZdqWZg3As=;
        b=4C6jMY4t2U1L88dGkbMYHWcMXjZT4tdY5k1BIvuGy9Xi/bZ59ZSdf1kFLaiNVCboIx
         gs76M3EuMRZNqNI0q+wgOwYLBLtR9Np+9FJtHTmdvBuJdcNZiNbVTXcVEt3/CqQHX7BK
         jMzfSsd36XhPo6iCfPXbJEJ0PWCmtCODfZmFcNvUJvXULTP/208iIzDDQ9l1N0A6ZPcC
         OmPyzAmi1I55X5bsJeEpCyiIcmL5PR6EQhY2BrMMVEJdB9UE43tRZZ92gsBpi0hwOcvM
         pyPRlKs1Hxe+8WkjMKs8SXK4YCwMr8i5J/EjrLj+TI4CRwUIVB9UESMXXDCEOIv6cheM
         tF6g==
X-Gm-Message-State: AOAM533xUGB63VM7J3Ul4ALZVA60nyJfiASAlhRIqiPneccakd10Vkkk
        VDbR4OuudMnmtQ5HCO/gUShaSBIEHio=
X-Google-Smtp-Source: ABdhPJxBBcT+yP6UF5u6W6a4EjUxTdBydEI9f4giBezVgbXvGg2qvoXa+XyT/fY+yWL2oQDMA5pWYg==
X-Received: by 2002:a1c:4644:: with SMTP id t65mr5906989wma.149.1635201158096;
        Mon, 25 Oct 2021 15:32:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r15sm11949504wru.9.2021.10.25.15.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:32:37 -0700 (PDT)
Message-Id: <504da32a95bd4a1e4368aca68b609387316ea671.1635201156.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1116.git.git.1635201156.gitgitgadget@gmail.com>
References: <pull.1116.git.git.1635201156.gitgitgadget@gmail.com>
From:   "Robert Estelle via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Oct 2021 22:32:36 +0000
Subject: [PATCH 2/2] color: support "default" to restore fg/bg color
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Robert Estelle <robert.estelle@gmail.com>,
        Robert Estelle <robertestelle@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Estelle <robertestelle@gmail.com>

The name "default" can now be used in foreground or background colors,
and means to use the terminal's default color, discarding any
explicitly-set color without affecting the other attributes. On many
modern terminals, this is *not* the same as specifying "white" or
"black".

Although attributes could previously be cleared like "no-bold", there
had not been a similar mechanism available for colors, other than a full
"reset", which cannot currently be combined with other settings.

Note that this is *not* the same as the existing name "normal", which is
a no-op placeholder to permit setting the background without changing
the foreground. (i.e. what is currently called "normal" might have been
more descriptively named "inherit", "none", "pass" or similar).

Signed-off-by: Robert Estelle <robertestelle@gmail.com>
---
 Documentation/config.txt | 18 +++++++++++++-----
 color.c                  | 23 ++++++++++++++++++++++-
 color.h                  |  4 ++++
 t/t4026-color.sh         | 12 ++++++++++++
 4 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bf82766a6a2..78f13f061e5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -262,11 +262,19 @@ color::
        colors (at most two, one for foreground and one for background)
        and attributes (as many as you want), separated by spaces.
 +
-The basic colors accepted are `normal`, `black`, `red`, `green`, `yellow`,
-`blue`, `magenta`, `cyan` and `white`.  The first color given is the
-foreground; the second is the background.  All the basic colors except
-`normal` have a bright variant that can be specified by prefixing the
-color with `bright`, like `brightred`.
+The basic colors accepted are `normal`, `black`, `red`, `green`,
+`yellow`, `blue`, `magenta`, `cyan`, `white` and `default`.  The first
+color given is the foreground; the second is the background.  All the
+basic colors except `normal` and `default` have a bright variant that can
+be specified by prefixing the color with `bright`, like `brightred`.
++
+The color `normal` makes no change to the color. It is the same as an
+empty string, but can be used as the foreground color when specifying a
+background color alone (for example, "normal red").
++
+The color `default` explicitly resets the color to the terminal default,
+for example to specify a cleared background. Although it varies between
+terminals, this is usually not the same as setting to "white black".
 +
 Colors may also be given as numbers between 0 and 255; these use ANSI
 256-color mode (but note that not all terminals may support this).  If
diff --git a/color.c b/color.c
index 64f52a4f93a..a5fa9b79a7a 100644
--- a/color.c
+++ b/color.c
@@ -40,7 +40,7 @@ struct color {
 	enum {
 		COLOR_UNSPECIFIED = 0,
 		COLOR_NORMAL,
-		COLOR_ANSI, /* basic 0-7 ANSI colors */
+		COLOR_ANSI, /* basic 0-7 ANSI colors + "default" (value = 9) */
 		COLOR_256,
 		COLOR_RGB
 	} type;
@@ -83,6 +83,27 @@ static int parse_ansi_color(struct color *out, const char *name, int len)
 	int i;
 	int color_offset = COLOR_FOREGROUND_ANSI;
 
+	if (match_word(name, len, "default")) {
+		/*
+		 * Restores to the terminal's default color, which may not be
+		 * the same as explicitly setting "white" or "black".
+		 *
+		 * ECMA-48 - Control Functions \
+		 *  for Coded Character Sets, 5th edition (June 1991):
+		 * > 39 default display colour (implementation-defined)
+		 * > 49 default background colour (implementation-defined)
+		 *
+		 * Although not supported /everywhere/--according to terminfo,
+		 * some terminals define "op" (original pair) as a blunt
+		 * "set to white on black", or even "send full SGR reset"--
+		 * it's standard and well-supported enough that if a user
+		 * asks for it in their config this will do the right thing.
+		 */
+		out->type = COLOR_ANSI;
+		out->value = 9 + color_offset;
+		return 0;
+	}
+
 	if (strncasecmp(name, "bright", 6) == 0) {
 		color_offset = COLOR_FOREGROUND_BRIGHT_ANSI;
 		name += 6;
diff --git a/color.h b/color.h
index c20d324e7ca..27e817016bf 100644
--- a/color.h
+++ b/color.h
@@ -32,6 +32,7 @@ struct strbuf;
 #define GIT_COLOR_MAGENTA	"\033[35m"
 #define GIT_COLOR_CYAN		"\033[36m"
 #define GIT_COLOR_WHITE		"\033[37m"
+#define GIT_COLOR_DEFAULT	"\033[39m"
 #define GIT_COLOR_BOLD_BLACK	"\033[1;30m"
 #define GIT_COLOR_BOLD_RED	"\033[1;31m"
 #define GIT_COLOR_BOLD_GREEN	"\033[1;32m"
@@ -40,6 +41,7 @@ struct strbuf;
 #define GIT_COLOR_BOLD_MAGENTA	"\033[1;35m"
 #define GIT_COLOR_BOLD_CYAN	"\033[1;36m"
 #define GIT_COLOR_BOLD_WHITE	"\033[1;37m"
+#define GIT_COLOR_BOLD_DEFAULT	"\033[1;39m"
 #define GIT_COLOR_FAINT_BLACK	"\033[2;30m"
 #define GIT_COLOR_FAINT_RED	"\033[2;31m"
 #define GIT_COLOR_FAINT_GREEN	"\033[2;32m"
@@ -48,6 +50,7 @@ struct strbuf;
 #define GIT_COLOR_FAINT_MAGENTA	"\033[2;35m"
 #define GIT_COLOR_FAINT_CYAN	"\033[2;36m"
 #define GIT_COLOR_FAINT_WHITE	"\033[2;37m"
+#define GIT_COLOR_FAINT_DEFAULT	"\033[2;39m"
 #define GIT_COLOR_BG_BLACK	"\033[40m"
 #define GIT_COLOR_BG_RED	"\033[41m"
 #define GIT_COLOR_BG_GREEN	"\033[42m"
@@ -56,6 +59,7 @@ struct strbuf;
 #define GIT_COLOR_BG_MAGENTA	"\033[45m"
 #define GIT_COLOR_BG_CYAN	"\033[46m"
 #define GIT_COLOR_BG_WHITE	"\033[47m"
+#define GIT_COLOR_BG_DEFAULT	"\033[49m"
 #define GIT_COLOR_FAINT		"\033[2m"
 #define GIT_COLOR_FAINT_ITALIC	"\033[2;3m"
 #define GIT_COLOR_REVERSE	"\033[7m"
diff --git a/t/t4026-color.sh b/t/t4026-color.sh
index c0b642c1ab0..e34838ded95 100755
--- a/t/t4026-color.sh
+++ b/t/t4026-color.sh
@@ -94,6 +94,18 @@ test_expect_success '24-bit colors' '
 	color "#ff00ff black" "[38;2;255;0;255;40m"
 '
 
+test_expect_success '"default" foreground' '
+	color "default" "[39m"
+'
+
+test_expect_success '"normal default" to clear background' '
+	color "normal default" "[49m"
+'
+
+test_expect_success '"default" can be combined with attributes' '
+	color "default default no-reverse bold" "[1;27;39;49m"
+'
+
 test_expect_success '"normal" yields no color at all"' '
 	color "normal black" "[40m"
 '
-- 
gitgitgadget
