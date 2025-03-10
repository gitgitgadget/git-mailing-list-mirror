Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1286B1AF0D7
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 01:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741571470; cv=none; b=IbERf8KH0/UGBTWeDXt3hdtWDKJ55hkxSWmvY50gbtfMueAsAwUEUrE4AMsxO397RdA592DF6Gv01nK+UNiztvVXduuITjW5893ypgDUxXES/yLBv0zlTOCCpECLhW+iaLU9fn4V40wUXpjPYrUobGIrHL91hVjG+wcogjHNe0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741571470; c=relaxed/simple;
	bh=kCrtpVmaZtkNa9JdXMkfPQ641sVIatLW6dgU9uN5LIY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CDb998UpTSCeeT1QX3qSrSSBTDGQE0AmQXhwi67p8VZKwEDV3MYqlrkayHUrFNhNIVNK5qSnWuh6afvISQs8uG0DBQnFhWN0fj1f4gZtZEI5Ma2cdpbtPKBGJo7DpFHOMO1Svh6gsp+Vrj4guUIuW062jqpLGkFyPeugl38bnEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxksGsiu; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxksGsiu"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso756576066b.3
        for <git@vger.kernel.org>; Sun, 09 Mar 2025 18:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741571466; x=1742176266; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLOIoWnFx8VUubhdQEUj5Fum6YfFLlJgENW/fBhnY3I=;
        b=gxksGsiuPa3gh4pMq9Vim58NuWYsSntNQuvVNU/ScbrdB6M6rSvuN2bxpxDbKzRrMZ
         dk/ZJK/Yfi+c/DYxhcjXWBMPFMvA4yXeRNW1ez/wPkKNObfqBjVXOU9+GFFXmtrd/aRe
         rudKPS17aNUCVfeZEkix4L9Z2xOAmWSlmRcoj9ms6utOo+xpwC1XTeGzsOnsnLJxy8B6
         csXMAtsZr7dpBzraXyUbTLoMAbmpzEc66JLsOtqKoav6YdsuO4Cl/rk8ZWNt8Hd+Dlc4
         XAwCoG3QPO8AMmetf69ycQjToiX6dXNHbhWnrocrpZn9U1BsgBmxxuayOMgcE/M/Jwqj
         wNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741571466; x=1742176266;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLOIoWnFx8VUubhdQEUj5Fum6YfFLlJgENW/fBhnY3I=;
        b=O363Em3H3G963/WX90a23+vU8wR7XvOsV67jQLeDw9xEZZRZun4KgVFmjgkaEbcr8F
         EYro0uiE4bMMwSwJo2bDUhMcQOXxt7cFLxo1g0fz+QkFYdjtjlynXf2mCayZyGwYGJbr
         fRUDUqs6v1cP9wk72Eq90EBsOTh6fAuGFah73H+Oa3J6+wKn/mBkR2DQIDkUU1TGevvp
         hX1B7yTnbgOLJ5Q+9eKNicG5uydgyqtxxFDA0FY2XyvL34Tl7WkQ6SJXSKN0f1sb8MUj
         3RHyq8ckE19Rc5P9zFzcZc9N1z7znB1JVM0uNtJZUhcs5HYsIqg49AbK9EfFBbJ0r4K8
         99/A==
X-Gm-Message-State: AOJu0Yy/CJkcNKZBWdDLnRFehIWm+2a6BAlC0Nd/zjAJ4Kxkzt9P8xme
	+9xCmJ7sb7iQartv8iZQ2Nd8vXlqDPPCiGN5/IaQUB8m5uK9Ybx9DCn0Kg==
X-Gm-Gg: ASbGncthK1OaJwxjXSSkvQwGwU6dIrafmc5CaBoecU8P9ZFu2VGlqmJRwcLUXJx9Qqx
	FwgrMc5JsDnKAzvQzLkG1xxZ7bPmg3FyYPu3Zso8tY+4GI+TS1w7q3eb5c5EEFw753ppi+uhYBI
	FIxLLrxyAmcBgZU1c7S0tdO7s8FXYP6t3sTHDn9i8IHFLsPim6d8DdwHdCB4BMkEljtqQ6dEc+T
	zT9zsq2UAU2Xbm5j/Vp3Kzgd45VXZdvtfRQErHrAmeyhpTg6FYwV566oLZyvN3oEQ2txRQD8+aR
	a4bNzQG4FKg9jHG+0QPK6/RzxT6C/sqe1YCIyC0+kaRP4g==
X-Google-Smtp-Source: AGHT+IG17jgaIYdr2o5yTRwjHwiaWUdt8yR6zQv8Qk4CxCtBnZ4cDoisK/Xzbglx1YPKMaVyq1SPGQ==
X-Received: by 2002:a17:907:1b05:b0:ac2:4b9:dff8 with SMTP id a640c23a62f3a-ac2527048b1mr1247206966b.32.1741571466079;
        Sun, 09 Mar 2025 18:51:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23943c476sm674764866b.3.2025.03.09.18.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 18:51:05 -0700 (PDT)
Message-Id: <bc9383ef11cd31c2a39f7d626ac57060891dcd2c.1741571455.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 10 Mar 2025 01:50:54 +0000
Subject: [PATCH 12/13] path-walk: add new 'edge_aggressive' option
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

In preparation for allowing both the --shallow and --path-walk options
in the 'git pack-objects' builtin, create a new 'edge_aggressive' option
in the path-walk API. This option will help walk the boundary more
thoroughly and help avoid sending extra objects during fetches and
pushes.

The only use of the 'edge_hint_aggressive' option in the revision API is
within mark_edges_uninteresting(), which is usually called before
between prepare_revision_walk() and before visiting commits with
get_revision(). In prepare_revision_walk(), the UNINTERESTING commits
are walked until a boundary is found.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/technical/api-path-walk.adoc |  8 ++++++++
 path-walk.c                                |  6 +++++-
 path-walk.h                                |  7 +++++++
 t/helper/test-path-walk.c                  |  2 ++
 t/t6601-path-walk.sh                       | 20 ++++++++++++++++++++
 5 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/api-path-walk.adoc b/Documentation/technical/api-path-walk.adoc
index e522695dd9f..34c905eb9c3 100644
--- a/Documentation/technical/api-path-walk.adoc
+++ b/Documentation/technical/api-path-walk.adoc
@@ -56,6 +56,14 @@ better off using the revision walk API instead.
 	the revision walk so that the walk emits commits marked with the
 	`UNINTERESTING` flag.
 
+`edge_aggressive`::
+	For performance reasons, usually only the boundary commits are
+	explored to find UNINTERESTING objects. However, in the case of
+	shallow clones it can be helpful to mark all trees and blobs
+	reachable from UNINTERESTING tip commits as UNINTERESTING. This
+	matches the behavior of `--objects-edge-aggressive` in the
+	revision API.
+
 `pl`::
 	This pattern list pointer allows focusing the path-walk search to
 	a set of patterns, only emitting paths that match the given
diff --git a/path-walk.c b/path-walk.c
index 341bdd2ba4e..2d4ddbadd50 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -503,7 +503,11 @@ int walk_objects_by_path(struct path_walk_info *info)
 	if (prepare_revision_walk(info->revs))
 		die(_("failed to setup revision walk"));
 
-	/* Walk trees to mark them as UNINTERESTING. */
+	/*
+	 * Walk trees to mark them as UNINTERESTING.
+	 * This is particularly important when 'edge_aggressive' is set.
+	 */
+	info->revs->edge_hint_aggressive = info->edge_aggressive;
 	edge_repo = info->revs->repo;
 	edge_tree_list = root_tree_list;
 	mark_edges_uninteresting(info->revs, show_edge,
diff --git a/path-walk.h b/path-walk.h
index 473ee9d361c..5ef5a8440e6 100644
--- a/path-walk.h
+++ b/path-walk.h
@@ -50,6 +50,13 @@ struct path_walk_info {
 	 */
 	int prune_all_uninteresting;
 
+	/**
+	 * When 'edge_aggressive' is set, then the revision walk will use
+	 * the '--object-edge-aggressive' option to mark even more objects
+	 * as uninteresting.
+	 */
+	int edge_aggressive;
+
 	/**
 	 * Specify a sparse-checkout definition to match our paths to. Do not
 	 * walk outside of this sparse definition. If the patterns are in
diff --git a/t/helper/test-path-walk.c b/t/helper/test-path-walk.c
index 61e845e5ec2..fe63002c2be 100644
--- a/t/helper/test-path-walk.c
+++ b/t/helper/test-path-walk.c
@@ -82,6 +82,8 @@ int cmd__path_walk(int argc, const char **argv)
 			 N_("toggle inclusion of tree objects")),
 		OPT_BOOL(0, "prune", &info.prune_all_uninteresting,
 			 N_("toggle pruning of uninteresting paths")),
+		OPT_BOOL(0, "edge-aggressive", &info.edge_aggressive,
+			 N_("toggle aggressive edge walk")),
 		OPT_BOOL(0, "stdin-pl", &stdin_pl,
 			 N_("read a pattern list over stdin")),
 		OPT_END(),
diff --git a/t/t6601-path-walk.sh b/t/t6601-path-walk.sh
index c89b0f1e19d..785c2f22373 100755
--- a/t/t6601-path-walk.sh
+++ b/t/t6601-path-walk.sh
@@ -378,6 +378,26 @@ test_expect_success 'topic, not base, boundary with pruning' '
 	test_cmp_sorted expect out
 '
 
+test_expect_success 'topic, not base, --edge-aggressive with pruning' '
+	test-tool path-walk --prune --edge-aggressive -- topic --not base >out &&
+
+	cat >expect <<-EOF &&
+	0:commit::$(git rev-parse topic)
+	1:tree::$(git rev-parse topic^{tree})
+	1:tree::$(git rev-parse base^{tree}):UNINTERESTING
+	2:tree:right/:$(git rev-parse topic:right)
+	2:tree:right/:$(git rev-parse base:right):UNINTERESTING
+	3:blob:right/c:$(git rev-parse base:right/c):UNINTERESTING
+	3:blob:right/c:$(git rev-parse topic:right/c)
+	blobs:2
+	commits:1
+	tags:0
+	trees:4
+	EOF
+
+	test_cmp_sorted expect out
+'
+
 test_expect_success 'trees are reported exactly once' '
 	test_when_finished "rm -rf unique-trees" &&
 	test_create_repo unique-trees &&
-- 
gitgitgadget

