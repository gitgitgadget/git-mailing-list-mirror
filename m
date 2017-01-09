Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ACF520756
	for <e@80x24.org>; Mon,  9 Jan 2017 10:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935368AbdAIKdS (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 05:33:18 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36276 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758875AbdAIKdP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 05:33:15 -0500
Received: by mail-pg0-f65.google.com with SMTP id 75so13144445pgf.3
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 02:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=92dKXpjChpNVJydTX+bW2jsv4PaEylwjdqNjuGsGhgY=;
        b=pdNJuFgWA4xnCRiEylaiRSTlUWoEfS90ooCMS33HPYl4QFnb8oHivvo93FER/dr8NX
         jLth3hIg+Ea9vYbYFzYyEx8MjiqtXVlezxgKZ0GTP+qn6jfGY9y8mbMaSP4J/bIGjHUL
         9NSfrnknsTuYGljf+oYt3T8GHsOi+XzTDP5Y0MFpbNeSSpqa5KBE0JICVo74Igi042Al
         Q8nPJozLl48UFQF5AwslAZK6QkVkVOWc8rx38wvOExXWsB2VMVVo7ewvkWG8ZFHU3ftt
         rBPuU7zI+Ltwjif1dhCRzIJ9Vc56V1SDgefEOw1VTdk8Ki9CY/Qz8G9UJ6D5dm3LpGQR
         PolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=92dKXpjChpNVJydTX+bW2jsv4PaEylwjdqNjuGsGhgY=;
        b=CjDM/fYO+vmMEP+xB92/YdPtHLO7G77csnVdxfQRDMMr0Td8k+kpEl/YTc4fxGC8iq
         8/XWRxI5zIv/LVADO6gzVyZ995Y09A0v5vlGqvoJYPG03IBDV2kGe9FvZIyG7PdfQxCn
         bXCgeTrq2TSAO7jkD7BtGFDGQKmNMgfKaxqOfrPLbv3LvoIeaKZnVgS8IFET01Lfw0WS
         2/ZyyMsFhDCnfRfDWM5Vfk/kqmzMPXLCdszVBI0X6tdFrBZZ+xW65oHboBVoYVtRQiv0
         sbeqwa8URUzpbVU4lh/FLyfYvZtFS8eYqX/sDChhtsC2GRhvI0Dim8PiKZRd1dkpFTze
         mhhw==
X-Gm-Message-State: AIkVDXJlwdC2GndR4U6oOdXw+LEyGTL7O50q1EmYT6kV3Fl+vo9/AIb6/Bi58OVhTv7hsQ==
X-Received: by 10.84.194.129 with SMTP id h1mr155068235pld.169.1483957994496;
        Mon, 09 Jan 2017 02:33:14 -0800 (PST)
Received: from ash ([115.72.187.80])
        by smtp.gmail.com with ESMTPSA id a11sm178023360pfe.96.2017.01.09.02.33.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jan 2017 02:33:13 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 09 Jan 2017 17:33:09 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4] log --graph: customize the graph lines with config log.graphColors
Date:   Mon,  9 Jan 2017 17:32:58 +0700
Message-Id: <20170109103258.25341-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20170108101333.26221-1-pclouds@gmail.com>
References: <20170108101333.26221-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you have a 256 colors terminal (or one with true color support), then
the predefined 12 colors seem limited. On the other hand, you don't want
to draw graph lines with every single color in this mode because the two
colors could look extremely similar. This option allows you to hand pick
the colors you want.

Even with standard terminal, if your background color is neither black
or white, then the graph line may match your background and become
hidden. You can exclude your background color (or simply the colors you
hate) with this.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 v4:

 * rename the function again (and it reads better)
 * use argv_array
 * fix a bug with two consecutive commas (after spaces are trimmed)

 Documentation/config.txt |  4 ++++
 graph.c                  | 43 +++++++++++++++++++++++++++++++++++++++++--
 t/t4202-log.sh           | 22 ++++++++++++++++++++++
 3 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0bcb679..33a007b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2003,6 +2003,10 @@ log.follow::
 	i.e. it cannot be used to follow multiple files and does not work well
 	on non-linear history.
 
+log.graphColors::
+	A list of colors, separated by commas, that can be used to draw
+	history lines in `git log --graph`.
+
 log.showRoot::
 	If true, the initial commit will be shown as a big creation event.
 	This is equivalent to a diff against an empty tree.
diff --git a/graph.c b/graph.c
index dd17201..83b1d42 100644
--- a/graph.c
+++ b/graph.c
@@ -4,6 +4,7 @@
 #include "graph.h"
 #include "diff.h"
 #include "revision.h"
+#include "argv-array.h"
 
 /* Internal API */
 
@@ -62,6 +63,45 @@ enum graph_state {
 static const char **column_colors;
 static unsigned short column_colors_max;
 
+static void read_graph_colors_config(void)
+{
+	static struct argv_array colors = ARGV_ARRAY_INIT;
+	char *string = NULL;
+	const char *end, *start;
+
+	if (git_config_get_string("log.graphcolors", &string)) {
+		graph_set_column_colors(column_colors_ansi,
+					column_colors_ansi_max);
+		return;
+	}
+
+	argv_array_clear(&colors);
+	start = string;
+	end = string + strlen(string);
+	while (start < end) {
+		const char *comma = strchrnul(start, ',');
+		char color[COLOR_MAXLEN];
+
+		while (start < comma && isspace(*start))
+			start++;
+		if (start == comma) {
+			start = comma + 1;
+			continue;
+		}
+
+		if (!color_parse_mem(start, comma - start, color))
+			argv_array_push(&colors, color);
+		else
+			warning(_("ignore invalid color '%.*s' in log.graphColors"),
+				(int)(comma - start), start);
+		start = comma + 1;
+	}
+	free(string);
+	argv_array_push(&colors, GIT_COLOR_RESET);
+	/* graph_set_column_colors takes a max-index, not a count */
+	graph_set_column_colors(colors.argv, colors.argc - 1);
+}
+
 void graph_set_column_colors(const char **colors, unsigned short colors_max)
 {
 	column_colors = colors;
@@ -208,8 +248,7 @@ struct git_graph *graph_init(struct rev_info *opt)
 	struct git_graph *graph = xmalloc(sizeof(struct git_graph));
 
 	if (!column_colors)
-		graph_set_column_colors(column_colors_ansi,
-					column_colors_ansi_max);
+		read_graph_colors_config();
 
 	graph->commit = NULL;
 	graph->revs = opt;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index e2db47c..0aeabed 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -313,6 +313,28 @@ test_expect_success 'log --graph with merge' '
 	test_cmp expect actual
 '
 
+cat > expect.colors <<\EOF
+*   Merge branch 'side'
+<BLUE>|<RESET><CYAN>\<RESET>
+<BLUE>|<RESET> * side-2
+<BLUE>|<RESET> * side-1
+* <CYAN>|<RESET> Second
+* <CYAN>|<RESET> sixth
+* <CYAN>|<RESET> fifth
+* <CYAN>|<RESET> fourth
+<CYAN>|<RESET><CYAN>/<RESET>
+* third
+* second
+* initial
+EOF
+
+test_expect_success 'log --graph with merge with log.graphColors' '
+	test_config log.graphColors ",, blue,invalid-color, cyan, red  , " &&
+	git log --color=always --graph --date-order --pretty=tformat:%s |
+		test_decode_color | sed "s/ *\$//" >actual &&
+	test_cmp expect.colors actual
+'
+
 test_expect_success 'log --raw --graph -m with merge' '
 	git log --raw --graph --oneline -m master | head -n 500 >actual &&
 	grep "initial" actual
-- 
2.8.2.524.g6ff3d78

