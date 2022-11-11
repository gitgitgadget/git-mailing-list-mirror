Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B660BC4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 07:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbiKKHfC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 02:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbiKKHe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 02:34:59 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C6579D18
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 23:34:58 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id k8so5376967wrh.1
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 23:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVRCA/Vj3iWfP1v51N/p0YliwQJxjrjjB8kuWpuvQbk=;
        b=lKZqFz+lmBLmjJh4w5RC5ockoD9HL8rfqCHcmVv0O7/GrZmqXsEvxuqZJ9fVQ6p2CH
         VIQ1o2xstrNdnnY4k6A/iBmXsK4zYlLoCAnHntwmPqLUxxdIaBqiec4Gq2hIfAMVz9JY
         vYEdFPkB0+gBVkYH3DTDT8SMPj0IMoOJFF+TOwK+JvvMbO7aMa3TdeHc4zjioG1g5YbU
         /WGkwq2ehS33Y8ZkEdqZCu7cZVuLmaQ50OJEwgdKvrgWMyZrqBJARngOf/AXviGbbZN3
         5Yld3bDLNBPnDF/NDXle73xw4J6QrLX/5RU0cy5yfTgEgvBEpzt2HUg0BT0Dt7vc4MTq
         Gsiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVRCA/Vj3iWfP1v51N/p0YliwQJxjrjjB8kuWpuvQbk=;
        b=RTToDfGdBJ18D6uTXQJNWXjvpqcoi2sIew6m9RVr7kHnY2ArioqgBSOXPDZHlhOZkR
         O7evdj7n0ShEn4AQb6JxgBV8NcGurufqSQKIeLEy2wfzgXLifLEaGPiA2++fAU0c7wel
         B07fAujh/mZVJ6AVca1Q2ctNnPkWacO80feywMN9cXHPGO8/zZ3dtmMxvtun6Q667gBp
         jjVJOt65BScl3NneDred25XK0X7Q8+vH74DBTt+5c8Pvr5MCeC/zyXi60ygGg7tXpFm2
         KpERXiRaZX868FkHypclabXnYUmMGocNKvOZedyekBVMNMTap4VEv5l3xdKPLAR41egD
         mmmA==
X-Gm-Message-State: ANoB5pl996LdHbEGzn3ByQl/KWL1lEaL9org0TRciQAIiMv+Mzxh6SfT
        GXlmnbLuAjYGETDP/W7oaFH4gaVJejY=
X-Google-Smtp-Source: AA0mqf6f1G6g473YrELyA2W+5voFGtWe7XmIW7XUsMeqOhBBtV149OQxDGvKikNPt0lmTj9Iqp8mPQ==
X-Received: by 2002:a05:6000:4d:b0:236:4ba1:fb2c with SMTP id k13-20020a056000004d00b002364ba1fb2cmr463510wrx.431.1668152096928;
        Thu, 10 Nov 2022 23:34:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n9-20020a7bcbc9000000b003b47ff307e1sm1918910wmi.31.2022.11.10.23.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 23:34:56 -0800 (PST)
Message-Id: <de482cf9cf1c791418e4279523123580f330245b.1668152094.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1413.v2.git.1668152094.gitgitgadget@gmail.com>
References: <pull.1413.git.1668013114.gitgitgadget@gmail.com>
        <pull.1413.v2.git.1668152094.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Nov 2022 07:34:52 +0000
Subject: [PATCH v2 1/3] chainlint: sidestep impoverished macOS "terminfo"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

Although the macOS Terminal.app is "xterm"-compatible, its corresponding
"terminfo" entries -- such as "xterm", "xterm-256color", and
"xterm-new"[1] -- neglect to mention capabilities which Terminal.app
actually supports (such as "dim text"). This oversight on Apple's part
ends up penalizing users of "good citizen" console programs which
consult "terminfo" to tailor their output based upon reported terminal
capabilities (as opposed to programs which assume that the terminal
supports ANSI codes). The same problem is present in other Apple
"terminfo" entries, such as "nsterm"[2], with which macOS Terminal.app
may be configured.

Sidestep this Apple problem by imbuing get_colors() with specific
knowledge of capabilities common to "xterm" and "nsterm", rather than
trusting "terminfo" to report them correctly. Although hard-coding such
knowledge is ugly, "xterm" support is nearly ubiquitous these days, and
Git itself sets precedence by assuming support for ANSI color codes. For
other terminal types, fall back to querying "terminfo" via `tput` as
usual.

FOOTNOTES

[1] iTerm2 FAQ suggests "xterm-new": https://iterm2.com/faq.html

[2] Neovim documentation recommends terminal type "nsterm" with
    Terminal.app: https://neovim.io/doc/user/term.html#terminfo

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.pl | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/t/chainlint.pl b/t/chainlint.pl
index 7972c5bbe6f..0ee5cc36437 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -653,21 +653,32 @@ my @NOCOLORS = (bold => '', rev => '', reset => '', blue => '', green => '', red
 my %COLORS = ();
 sub get_colors {
 	return \%COLORS if %COLORS;
-	if (exists($ENV{NO_COLOR}) ||
-	    system("tput sgr0 >/dev/null 2>&1") != 0 ||
-	    system("tput bold >/dev/null 2>&1") != 0 ||
-	    system("tput rev  >/dev/null 2>&1") != 0 ||
-	    system("tput setaf 1 >/dev/null 2>&1") != 0) {
+	if (exists($ENV{NO_COLOR})) {
 		%COLORS = @NOCOLORS;
 		return \%COLORS;
 	}
-	%COLORS = (bold  => `tput bold`,
-		   rev   => `tput rev`,
-		   reset => `tput sgr0`,
-		   blue  => `tput setaf 4`,
-		   green => `tput setaf 2`,
-		   red   => `tput setaf 1`);
-	chomp(%COLORS);
+	if ($ENV{TERM} =~ /xterm|xterm-\d+color|xterm-new|xterm-direct|nsterm|nsterm-\d+color|nsterm-direct/) {
+		%COLORS = (bold  => "\e[1m",
+			   rev   => "\e[7m",
+			   reset => "\e[0m",
+			   blue  => "\e[34m",
+			   green => "\e[32m",
+			   red   => "\e[31m");
+		return \%COLORS;
+	}
+	if (system("tput sgr0 >/dev/null 2>&1") == 0 &&
+	    system("tput bold >/dev/null 2>&1") == 0 &&
+	    system("tput rev  >/dev/null 2>&1") == 0 &&
+	    system("tput setaf 1 >/dev/null 2>&1") == 0) {
+		%COLORS = (bold  => `tput bold`,
+			   rev   => `tput rev`,
+			   reset => `tput sgr0`,
+			   blue  => `tput setaf 4`,
+			   green => `tput setaf 2`,
+			   red   => `tput setaf 1`);
+		return \%COLORS;
+	}
+	%COLORS = @NOCOLORS;
 	return \%COLORS;
 }
 
-- 
gitgitgadget

