Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B34EF1FEB3
	for <e@80x24.org>; Sun,  8 Jan 2017 10:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033213AbdAHKPI (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jan 2017 05:15:08 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33502 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932068AbdAHKNm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2017 05:13:42 -0500
Received: by mail-pg0-f66.google.com with SMTP id 194so4219161pgd.0
        for <git@vger.kernel.org>; Sun, 08 Jan 2017 02:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VFUwF5ovaRiF8OmYh9uiS7HalALbtIKSrFOxIzZTy5g=;
        b=vCvt4mXgejnC/QWfb+l6r6Zf0s+Rvo+Ep0hUs11/BqORTK2QDokut8IiBfxDkSKVUw
         Q/HcRoPDf7X5HyGQj/gPEwjxY1Pj24MERAOCO3AKDuw/Qk2wj2XmPxN6NGful82swj79
         Jxyh886grFEZjqby2GhAjbdLGQ8BfxLncrppvk01bGktmlhB/ofL8S/Q3o9ga+Awge3P
         tdWQ3RcQkKSOg9zQJ1eOHFJBycMvPwJUe3AotmpxORJ0CZUobJA1dBFbKxvBKoVmR1Ah
         gtNUBwMZeTjskKmM6ydw3goLqs/QO0CFNMVlMIT6DahsZE0T5S1SB5pOQz8Q+A/v576/
         LX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VFUwF5ovaRiF8OmYh9uiS7HalALbtIKSrFOxIzZTy5g=;
        b=A4VVr/52BlZH65g3SKlb8ElYmixRWt7hSIEjYU7/daYpm4O5JOOJiur6o5MAYoIsO6
         udpXk2cAMR5V1FVrEavlnth2evRXIX28C/poh/CoOy9vl++NDvxDT2zud15EX2w0GKxb
         L+ITwoQrl21Wm1i6g4Td999Saozknr9109ONn5IKABSQmUXzFknQDgMYMQ9k01woH2+p
         smIVdXgRAniWYMfL2qb357Nc/KStHrj9MMtZv6zTMNjVcO6KDD5K2dn4a8N1fzrK77bQ
         +X+RvSs0zXqiGCejCAzgBgudJrHmhHr+QLD2EWdxEXaNkezMY+UGF9iACtOIFYKmMFsR
         hpGA==
X-Gm-Message-State: AIkVDXLfyKM1/Kt0GH/rwRoaUzvldVlju813nw3WP9cvTp3DYOca7FpUJkfiTOLp0oeytg==
X-Received: by 10.84.233.193 with SMTP id m1mr17804391pln.126.1483870421337;
        Sun, 08 Jan 2017 02:13:41 -0800 (PST)
Received: from ash ([115.72.187.80])
        by smtp.gmail.com with ESMTPSA id 18sm17454439pgf.28.2017.01.08.02.13.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jan 2017 02:13:39 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 08 Jan 2017 17:13:35 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3] log --graph: customize the graph lines with config log.graphColors
Date:   Sun,  8 Jan 2017 17:13:33 +0700
Message-Id: <20170108101333.26221-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <xmqqzijjd34j.fsf@gitster.mtv.corp.google.com>
References: <xmqqzijjd34j.fsf@gitster.mtv.corp.google.com>
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
 Compared to v2:

 * set_column_colors_by_config() is renamed to set_column_colors()
 * no memory leak if the function is called the second time
 * proper space trimming since color_parse_mem expects so
 * fixed the warning message, giving some context
 * at least one test to exercise the code
 * I'm not going with the cumulative behavior because I think that's
   just harder to manage colors, and we would need a way to remove
   colors from the config too.

 Documentation/config.txt |  4 ++++
 graph.c                  | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 t/t4202-log.sh           | 22 ++++++++++++++++++++++
 3 files changed, 70 insertions(+), 2 deletions(-)

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
index dd17201..048f5cb 100644
--- a/graph.c
+++ b/graph.c
@@ -62,6 +62,49 @@ enum graph_state {
 static const char **column_colors;
 static unsigned short column_colors_max;
 
+static void set_column_colors(void)
+{
+	static char **colors;
+	static int colors_max, colors_alloc;
+	char *string = NULL;
+	const char *end, *start;
+	int i;
+
+	for (i = 0; i < colors_max; i++)
+		free(colors[i]);
+	if (colors)
+		free(colors[colors_max]);
+	colors_max = 0;
+
+	if (git_config_get_string("log.graphcolors", &string)) {
+		graph_set_column_colors(column_colors_ansi,
+					column_colors_ansi_max);
+		return;
+	}
+
+	start = string;
+	end = string + strlen(string);
+	while (start < end) {
+		const char *comma = strchrnul(start, ',');
+		char color[COLOR_MAXLEN];
+
+		while (start < comma && isspace(*start))
+			start++;
+
+		if (!color_parse_mem(start, comma - start, color)) {
+			ALLOC_GROW(colors, colors_max + 1, colors_alloc);
+			colors[colors_max++] = xstrdup(color);
+		} else
+			warning(_("ignore invalid color '%.*s' in log.graphColors"),
+				(int)(comma - start), start);
+		start = comma + 1;
+	}
+	free(string);
+	ALLOC_GROW(colors, colors_max + 1, colors_alloc);
+	colors[colors_max] = xstrdup(GIT_COLOR_RESET);
+	graph_set_column_colors((const char **)colors, colors_max);
+}
+
 void graph_set_column_colors(const char **colors, unsigned short colors_max)
 {
 	column_colors = colors;
@@ -208,8 +251,7 @@ struct git_graph *graph_init(struct rev_info *opt)
 	struct git_graph *graph = xmalloc(sizeof(struct git_graph));
 
 	if (!column_colors)
-		graph_set_column_colors(column_colors_ansi,
-					column_colors_ansi_max);
+		set_column_colors();
 
 	graph->commit = NULL;
 	graph->revs = opt;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index e2db47c..afe0715 100755
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
+	test_config log.graphColors " blue , cyan , red " &&
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

