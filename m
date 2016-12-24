Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C12A1FCC7
	for <e@80x24.org>; Sat, 24 Dec 2016 11:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753264AbcLXLig (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Dec 2016 06:38:36 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36039 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750857AbcLXLie (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Dec 2016 06:38:34 -0500
Received: by mail-pg0-f65.google.com with SMTP id n5so3508740pgh.3
        for <git@vger.kernel.org>; Sat, 24 Dec 2016 03:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KDPLyo6IIjMw+tD1TqUzmCaKurHk13XaR9/bwu4sNAs=;
        b=LQJtNyw0K6hjM6zHnInSQb9gsK4itVk7g8q78Nw5Q6NcMDHwa5eauN0Hkmxja9Din5
         +EqawUqYsoft84J7yUkhHgmp+CAuENRNkAkUeWouK3u8fNltjvyE7NztYvnw2D83SiSm
         tYDdiHmXqV1n2oeX3zISDsO5rPZxnf8XZA7o2MsA8T65Wuju9Uob6+3qhNqhDjcsQOqd
         7NSpxKmNOhm3X7TqETrtq6/HDM3DipXI7qh2uwmxbPGA4ScgjCrHM2nv+4WwMx/TR2GM
         XDQQlCeWkKAYFTjC/euAqYPz2E3BSysHAhm8k09m91nIA4IP8srCJO2DQyjn01IQp3uo
         A96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KDPLyo6IIjMw+tD1TqUzmCaKurHk13XaR9/bwu4sNAs=;
        b=jqJ7BD0kolSqc4poQLFx3wh2DdjXr3jW6cUmGGF6Z0nH7KDS+5J6SqSTQT9tXPBdWH
         8dF0CTs0HUIrDegXZnd3t2SyOt25O4CfrTVTtE9tyGTPod9iCejcKZGIn2uJNhJW0RTp
         baCfu9ANOrC+ymgRup25l/lKYNfYwN/cEOiRFuSejhGCgWkbT1cSyNIyOJxEZROIeYz8
         TyHhziPq5mYKYDjA9ALrenUCrMY6zQCnEmQ7YaCQXwzEhUxldf7SBRcpXV1zVYloUdwu
         SW8DqcCfhWOjGlQRfiXMTe7qxHTrko0wiWH286XlQmblu6wRLOp0zpZjwuA1RHA8wOfb
         RznA==
X-Gm-Message-State: AIkVDXK6mRB/khkWMcXNEv/Y4fh+j6cWpddXwWIOhoIO5qWJDxp7gzipXucgF5YXxz9FGw==
X-Received: by 10.99.19.65 with SMTP id 1mr33866459pgt.71.1482579513733;
        Sat, 24 Dec 2016 03:38:33 -0800 (PST)
Received: from ash ([115.72.187.80])
        by smtp.gmail.com with ESMTPSA id 89sm68889826pfi.70.2016.12.24.03.38.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Dec 2016 03:38:33 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 24 Dec 2016 18:38:27 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2] log --graph: customize the graph lines with config log.graphColors
Date:   Sat, 24 Dec 2016 18:38:17 +0700
Message-Id: <20161224113817.18407-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161220123929.15329-1-pclouds@gmail.com>
References: <20161220123929.15329-1-pclouds@gmail.com>
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
 Sounds like the good first step should be something like this instead
 of jumping straight to generating a new color palette automatically.

 It's not hard to create a script that generate this config value
 based on some jump calculation, if you don't want to manually picking
 colors.

 Documentation/config.txt |  4 ++++
 graph.c                  | 36 ++++++++++++++++++++++++++++++++++--
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d51182a..4f26c2a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2033,6 +2033,10 @@ log.follow::
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
index d4e8519..9c58fd1 100644
--- a/graph.c
+++ b/graph.c
@@ -79,6 +79,39 @@ static void graph_show_line_prefix(const struct diff_options *diffopt)
 static const char **column_colors;
 static unsigned short column_colors_max;
 
+static void set_column_colors_by_config(void)
+{
+	static char **colors;
+	static int colors_max, colors_alloc;
+	char *string = NULL;
+	const char *end, *start;
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
+		if (!color_parse_mem(start, comma - start, color)) {
+			ALLOC_GROW(colors, colors_max + 1, colors_alloc);
+			colors[colors_max++] = xstrdup(color);
+		} else
+			warning(_("ignore invalid color '%.*s'"),
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
@@ -239,8 +272,7 @@ struct git_graph *graph_init(struct rev_info *opt)
 	struct git_graph *graph = xmalloc(sizeof(struct git_graph));
 
 	if (!column_colors)
-		graph_set_column_colors(column_colors_ansi,
-					column_colors_ansi_max);
+		set_column_colors_by_config();
 
 	graph->commit = NULL;
 	graph->revs = opt;
-- 
2.8.2.524.g6ff3d78

