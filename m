Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5DE91FF30
	for <e@80x24.org>; Tue, 22 Nov 2016 10:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755896AbcKVKBb (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 05:01:31 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35919 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755880AbcKVKBP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 05:01:15 -0500
Received: by mail-pg0-f65.google.com with SMTP id x23so1697625pgx.3
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 02:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QZ9EDTSceV3rQ4Ai1Za+FWSZLJmkD2RCSErpgcK9RJI=;
        b=GfjlxXLZr4hPZpPH3CJioWJOoP3HxFbndJ1WkZJhyQXBnXsJ/CzEirJWWDuJ0hRe/W
         em/eoWEqKCjYMqa/uQ7aNw3stHpXcdDnkkTkhxhUmkacyD9A53PO/Akdg8WAxcJAwLv+
         W02Z67SxzNca1d1Gk1t3meqpNNFUZelMUIp9vS0te8eu3EBIlrLiCU8S8VUbKq4Y+Q9V
         Fly266TP5rSsMpNmjjQpx2i+FTTpbNYnDJFihqQHa7oJGZz7uZzxMEaTgNO7kR4uM4u8
         S0LiZnKjG/lkOBG/uea6Sp3XV200T91xNJzMwCDujlyFgx5ZyZ2AoIyEfPFWKeTTS7ZW
         xu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QZ9EDTSceV3rQ4Ai1Za+FWSZLJmkD2RCSErpgcK9RJI=;
        b=g2+5ZMbIsKNSLGLNhorarxGV83Fpfea59/zAyFjMHFDy1IliP+kf1+b2MMM0iwUNk/
         KnFT5nthdMbxxmPXyCYnXd88o7iv3vs49kJYgCQZB6pXyJ5Qc2MuTr9nyRQtKco/QStn
         krfuVskaZ2AlTCfIsVN1yvCIIPephEXkE2VyGFmaNHsepV4+OsQ/HWlOQikNK4A9/ePJ
         gQLKQCj2zMK+ni0HUK64wuKAQdmn3THhE8MjvlWxaZ7bvAMkV7i1x4KyYq1FlXnClGp5
         md14hHX4r0g8msa5ajKgH4I8r9OXgaeKE5GkI0yIiDbBnhBR2OGknuQfS0+LuPuIJhSA
         eJiw==
X-Gm-Message-State: AKaTC01C0vh2UrOooGIC0UEz/oU0qsT8RjZrI3Klpc2AB4dD9l5qkMCbzauvl1Jif9y0Tw==
X-Received: by 10.98.81.70 with SMTP id f67mr24235740pfb.179.1479808874552;
        Tue, 22 Nov 2016 02:01:14 -0800 (PST)
Received: from ash ([115.73.175.91])
        by smtp.gmail.com with ESMTPSA id 89sm43764232pfi.70.2016.11.22.02.01.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Nov 2016 02:01:13 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 22 Nov 2016 17:01:08 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, rappazzo@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 3/3] worktree list: keep the list sorted
Date:   Tue, 22 Nov 2016 17:00:46 +0700
Message-Id: <20161122100046.8341-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161122100046.8341-1-pclouds@gmail.com>
References: <20161122100046.8341-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It makes it easier to write tests for. But it should also be good for
the user since locating a worktree by eye would be easier once they
notice this.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/worktree.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index b835b91..80ccc51 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -434,6 +434,13 @@ static void measure_widths(struct worktree **wt, int *abbrev, int *maxlen)
 	}
 }
 
+static int compare_worktree(const void *a_, const void *b_)
+{
+	const struct worktree *const *a = a_;
+	const struct worktree *const *b = b_;
+	return fspathcmp((*a)->path, (*b)->path);
+}
+
 static int list(int ac, const char **av, const char *prefix)
 {
 	int porcelain = 0;
@@ -448,11 +455,20 @@ static int list(int ac, const char **av, const char *prefix)
 		usage_with_options(worktree_usage, options);
 	else {
 		struct worktree **worktrees = get_worktrees();
-		int path_maxlen = 0, abbrev = DEFAULT_ABBREV, i;
+		int path_maxlen = 0, abbrev = DEFAULT_ABBREV, i, nr;
 
 		if (!porcelain)
 			measure_widths(worktrees, &abbrev, &path_maxlen);
 
+		for (i = nr = 0; worktrees[i]; i++)
+			nr++;
+
+		/*
+		 * don't sort the first item (main worktree), which will
+		 * always be the first
+		 */
+		QSORT(worktrees + 1, nr - 1, compare_worktree);
+
 		for (i = 0; worktrees[i]; i++) {
 			if (porcelain)
 				show_worktree_porcelain(worktrees[i]);
-- 
2.8.2.524.g6ff3d78

