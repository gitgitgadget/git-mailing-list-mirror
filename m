Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC64C433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 17:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiKIRBn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 12:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiKIRAz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 12:00:55 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EEE13EB8
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 08:58:41 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id g12so26651316wrs.10
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 08:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sxjw4FZind5IBeKVQ8WS0RO5VP8SsMIjVtapS56zweM=;
        b=hwMGRlR5zCf38YrMnfZRGnk7e6rGxxEKpWHeMRhzhm5eQebMkhxK2U9ahuPAMcBQcS
         ofEsYJ1QOyhQERVqquw9MS3xBJTFyqrWr4jf2Nxr2VOItf5zoQtKsYlU4vpEBuAU4zvK
         D/pkVax9FB601UADH8hSOnmyiZGA0plVD5qqEvPbkNdIO2noFuxg9vUETh2nonHGZK7c
         49Bxj9AklhWN/PwdtL5B7sfkT6h1oVTZVpLgEWVfS2MWU3hIrSiJB4F61k9rYq7aM0MN
         7DuSW2h9m2IgzsGKoXuAVfGCSvi0txGh+rWG29sBPJjn2A4FLaeKz49nWCuFcoQGGc5x
         zAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sxjw4FZind5IBeKVQ8WS0RO5VP8SsMIjVtapS56zweM=;
        b=gphgB/Hx8lXYqUwpVabXhvRPHPOpVp5BH26qirG8C+UF4pnZavqTC1ItkxHVDRJnGQ
         qz8GvI82X3uv/xWhK+PJXK9fuB+A3sQJPWFYJBDop17wCRghb2usO7torAc1lw3Z5Zis
         8WcSEFkm2K52YoArKDTbp1ilQHPQsqJoWttBwD5p9Do4EPsS2FiQCGPYGTqQL3aoDATJ
         HGWvXRsCwWaBynUbVwEBFxqpDqfPQ6eTS5N9UxilS/L7ePezI5Ps8ua/FKMxn5eQ2LyP
         EJ2QUNDEYBE5OVvoOA9WfduET15tVIZOZJVy5k78LL0g5cdutLZMx0aAAeFxTMQt4/hJ
         B8cQ==
X-Gm-Message-State: ACrzQf3Uvuws2zzb0/lVsvDPO/Fy2xQRjhGSVig+idc6Mprt8Z4E9yB/
        EkYhlHMa6kbrjOkLoqv175mO8FG5As0=
X-Google-Smtp-Source: AMsMyM4/ySEgAHrsKWWG88wKzkyvxMrsBfQ9JrTqCf9e+joguqE0hWGuJim5m+ssvTkvcB0qT5KiNw==
X-Received: by 2002:adf:f10e:0:b0:239:6cea:a4ff with SMTP id r14-20020adff10e000000b002396ceaa4ffmr21960099wro.36.1668013120075;
        Wed, 09 Nov 2022 08:58:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m189-20020a1c26c6000000b003c6edc05159sm2099946wmm.1.2022.11.09.08.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 08:58:37 -0800 (PST)
Message-Id: <b85b28e5a6beea97c149f0b9de6ba8d0a4a7c1f9.1668013114.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1413.git.1668013114.gitgitgadget@gmail.com>
References: <pull.1413.git.1668013114.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Nov 2022 16:58:32 +0000
Subject: [PATCH 1/3] chainlint: sidestep impoverished macOS "terminfo"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

Although the macOS Terminal.app is "xterm"-compatible, its corresponding
"terminfo" entry neglects to mention capabilities which Terminal.app
actually supports (such as "dim text"). This oversight on Apple's part
ends up penalizing users of "good citizen" console programs which
consult "terminfo" to tailor their output based upon reported terminal
capabilities (as opposed to programs which assume that the terminal
supports ANSI codes).

Sidestep this Apple problem by imbuing get_colors() with specific
knowledge of "xterm" capabilities rather than trusting "terminfo" to
report them correctly. Although hard-coding such knowledge is ugly,
"xterm" support is nearly ubiquitous these days, and Git itself sets
precedence by assuming support for ANSI color codes. For non-"xterm",
fall back to querying "terminfo" via `tput` as usual.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.pl | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/t/chainlint.pl b/t/chainlint.pl
index 7972c5bbe6f..fcf4d459249 100755
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
+	if ($ENV{TERM} =~ /\bxterm\b/) {
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

