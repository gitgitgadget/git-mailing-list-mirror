Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D906A2627E4
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 15:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742829787; cv=none; b=qTUir66+LGsYlx6b3tv5siZqFHBW+hseLXnKyW48PUZdUFKFgFvAVDn2Qs4hSFkm2l87FQvaxRH7bqo4mi6qAX3UHfswqDAsTgGFzgyyn/FskA6kv7W2b5lgi/1D6XsCCSgUjICEKAmJXgHAU3O/xXYqXPsFNeV1VhPwIPZyP9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742829787; c=relaxed/simple;
	bh=kCrtpVmaZtkNa9JdXMkfPQ641sVIatLW6dgU9uN5LIY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OMkAC/Baov+xOBk0PvWlIevw/c5of6MILCUHZ7RiSQt4tFaswW7X/+QpfU+PSx+GXdd6vVYhawYatW+K+Mcyry748lCVyHlqX3vSvqdSUii/0zD4Qiv5rubhrSWpWkt7xvJ9+bgZyXgqIYIwHjVQ6YDBjs4x8Vk46u/Xw46Tgtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGIgGyr7; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGIgGyr7"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so2427989f8f.0
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 08:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742829784; x=1743434584; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLOIoWnFx8VUubhdQEUj5Fum6YfFLlJgENW/fBhnY3I=;
        b=HGIgGyr7Jg6i3jYCDNhbLl44VhK63hYtT0Ce/I5saX0MWmXkXC8KrrGgxzvhI0VwyZ
         R6flrvaN+cflCTxVC2J8VJ1M7PGlMA+7/iGyOWIwhcwueOqHvfRvLfFOaQR5IUqQ6WMl
         KyHO+YZJnygzUUF2pfGAWStpz8fOXmv8aTjIuK3WqybhapYvrkiHFxaVz6iYBeVCdroT
         XfTbp6DjPwGJmNIox5U0wiHqZ6fLHcyNOdWiuuy0l20+A22YujnYK5/WGg4ZNSWG9O0m
         mqQUWJx5F4xkbiq0sxAM/elhk1wEbhyaAtpNMhfJYaMd2RlHX7Ut8cafZ6neZownlw+w
         Ca+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742829784; x=1743434584;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLOIoWnFx8VUubhdQEUj5Fum6YfFLlJgENW/fBhnY3I=;
        b=QIAAFWZ9whBnBXrKOn/HHz/OQqT1nUvPZKH/rgMT/GO3nmk27GZY4sJj/XGDSH9Jeb
         eYNpBeIZXLobbgEUSh/7gHuuvAUw0yGOxBPw0TPungdheHZaR6PwqIF+xZ5Ide8P4y0d
         0Jt+HhZzH+zKiXa+rx81NXn7Yp8hRZiAPJWVlO63webeO8buKZ7xT9chSreXPluEBnek
         C6G3qswiwqT30O9gFUBidnjV7GixGWFpwStnn2BZ1Hl+oMx8llBHsWya0anzPtGCBm/v
         3HtSxjfwlIDNjXy3NYytp4NNeSbffGrw2CT5bnxIn8Qe8pHE6LHoM+Qi4UmYgHwDC+9u
         eCvA==
X-Gm-Message-State: AOJu0YxERx9BLn9SCyVDac6a/Iavs7P27JlDcNQ82dLWgsspH57jNmmy
	CkYDryrKgHJsCFaBT1ruv+ILY6/8T+C6CwJASnkdMPK36WakPX37LU6nmg==
X-Gm-Gg: ASbGncu5ZTPk00oF2Uzi/lVtQcatvselr43/5TGc9c3C3VVQj1RUwGA1RuI+yT+p80s
	vijYi6n8116XxZeVYlHf6NI69fGog7g8CdSnpMb5hFMOPScSDANhz6MhqE+fVIlankvWC4NouMg
	OzHDFWXb6kP3e1BbppQsikTnvlYXiKDP5EOCqyM1V6hXABQdmVdmPASxdFfDiGy5NyKi+QTB5li
	m9Imcm5qJ3F3J32femsl9HtuNn4GOFCGWErWjBs/e2VtLHV5MDLxneM3+VMF5KW/d+epufRlRKq
	c2+222B5VxlXJX+6NRtrDds1EBKJA9LdNA2IM/tTIaGfzQ==
X-Google-Smtp-Source: AGHT+IEFCceggSn7gfbajmcbI9SHnVHX4qTqEQ5tjLs9YrRXZBZ4oOnXhzMJ+RPzSuzo/+EYrk9dqQ==
X-Received: by 2002:a5d:47a5:0:b0:390:fc83:a070 with SMTP id ffacd0b85a97d-3997f8a4e9cmr10759444f8f.0.1742829783801;
        Mon, 24 Mar 2025 08:23:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b3c2csm11044801f8f.46.2025.03.24.08.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 08:23:03 -0700 (PDT)
Message-Id: <c45f35c204eb0a2d188226d0d62faa7c7453ae67.1742829770.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
	<pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 24 Mar 2025 15:22:48 +0000
Subject: [PATCH v2 12/13] path-walk: add new 'edge_aggressive' option
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

