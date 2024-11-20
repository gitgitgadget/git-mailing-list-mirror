Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3D81B6555
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732110003; cv=none; b=PwYGzOIBSoXdgw/unXMbo48SHpsfU4U4bDC6gru0pmclzwav4rVMYAzYLg4+fgbjytPr1jzfACWQHwXvJRt0CQlCLY8TdvrGiMFLjVCNQWOax9zbnjyZhmd/8yun1qfLDN6KalJBpBQe+i2UxefXI3Tqzv8tGWRnwSDYw4edtzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732110003; c=relaxed/simple;
	bh=F5vtOVre06cSU/Q6+wcUvGy+w4sNO5Vq8u6LSGE6OCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PZCDKJ7Un/b8cG148bBQ+lY/DFeZ6/yI6/93Kn758qTIFG+uLTd1f3kxqV87C1rN0+elUCZFDHw7NtNFZz35YWouGtyIsg4BBeg0Wq5ZEOYJwdnywU8my08ZYr9ki801JhT4IyTxps6f39z+Zg9Xo/GsdYAnGw6YrBw156NQ5zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WSmtKTcg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QypsWSuI; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WSmtKTcg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QypsWSuI"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A5F3811401CE;
	Wed, 20 Nov 2024 08:40:00 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 20 Nov 2024 08:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732110000;
	 x=1732196400; bh=ceEvW/XlUYVGnjJQcZ4O9GzRgePII+TUgfvMWmyUCZI=; b=
	WSmtKTcg7viDG7Ps0PQpF4eys5C34p2qeIYQ+h52Qqv3Wqu+90vo+B7wbsfiws+j
	WrEw6N0M9eK4qAaVG80+yDl0Xp6kx+AAdnOfsIIYfuyDvyQX8S8eHegcSzmWcYcf
	5VDVEs5FVM7KsttPYp4yYjYDowx5Yg5tl5+tUMVyraXG2TdQJnxo/fYQTZoLsk9K
	bjxnDmcxUk7ImETeuzMdwzu28rrsEZJ53TQ6rsCXzAh+gvobQdBLnN3yUGKMTw0h
	LZDkaK1srehmWUlRvB3fY8YMxufd6yAukAnzyb3CHXFRRgjHACTYJZTOPMDPcjWz
	8ONLOgNB+PrdSUJ7E5JXjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732110000; x=
	1732196400; bh=ceEvW/XlUYVGnjJQcZ4O9GzRgePII+TUgfvMWmyUCZI=; b=Q
	ypsWSuIeAvI53N/Lwzh5dyxEUrZ5fwBkKiqc8/kljrPOWUpWmZ8Z06zIDBzB6K+g
	d/qfo2I6LFNOd6j5PKj5LVynzWnBAm31j8wyUj/POm+WVFn09l7n9U+bEK+KL2Kq
	LcYQ1LOsNLNgpDpJyeflMyMcg5fvHQzJn1V206pOEgzJi5TLh7ZsUR8Tjk6SaYYK
	hHUk1ibuierDNITSk/9P3EDk1YGpr1f8EKo7m6xVEWoMddU+5gBaYs66KYZ2HN4j
	4p9byMvu694f8jq1UKFh3JexuHTXjDRIKSyeYE3H4LbV2YR6To4HHKP4SFzLxazs
	sQcdRK8bBLSoYUASJZh2w==
X-ME-Sender: <xms:sOY9Z0Ilol34wY8Aw9X4xDehJYzS9cuPStywOuXG4brpaQwFRkaW4g>
    <xme:sOY9Z0JFUWhYaE2ABVroRtrYZxNZcDSf6jSujUdoEe9ymiH0Ezw-ZUnooatuZWx-7
    dfCfwePdpzR-_UJoQ>
X-ME-Received: <xmr:sOY9Z0shDHsfLkc-0Hn0pT29EuuQWrSwx69feKXeZiwUaql8rezMUwp8BssLPj0RNnwtwm1X7Bzlq49JHBrVv8PhZVbLvZECzQozuj6sxozUsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehrjhhushhtohesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:sOY9Zxb7GkoXphWy685qoHX1CJRp0eewc1-28Braq5q2oYAImLywCg>
    <xmx:sOY9Z7ZwnpNgbLptc3v_NuKiiT55dQ9M1S9ApNKW5WyVPaKx-pKxTA>
    <xmx:sOY9Z9AdaHBh73T6Z1bcRNdQ2TngI4J96d6yi7sQKmlpdODF9itOcA>
    <xmx:sOY9ZxYje7XcjpKbWy0tZYiCvbRJARtsGCnhoeN4HRC7kS4aT8BOxA>
    <xmx:sOY9Z6W-yfCRJMM_8D6qF1q-Bjxr9FuPeexwX7lMZQzpesCdFIi1d2MA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 08:39:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1f223a9f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 13:39:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 20 Nov 2024 14:39:42 +0100
Subject: [PATCH v3 13/27] builtin/sparse-checkout: fix leaking sanitized
 patterns
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-b4-pks-leak-fixes-pt10-v3-13-d67f08f45c74@pks.im>
References: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
In-Reply-To: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, 
 Jeff King <peff@peff.net>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

Both `git sparse-checkout add` and `git sparse-checkout set` accept a
list of additional directories or patterns. These get massaged via calls
to `sanitize_paths()`, which may end up modifying the passed-in array by
updating its pointers to be prefixed paths. This allocates memory that
we never free.

Refactor the code to instead use a `struct strvec`, which makes it way
easier for us to track the lifetime correctly. The couple of extra
memory allocations likely do not matter as we only ever populate it with
command line arguments.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/sparse-checkout.c | 61 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 22 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 49aedc1de81a17b8b491cded7fa71b384e0e8be9..698d93a9ec5ed6d51d4a1db212f776b2db06cfc3 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -669,7 +669,7 @@ static void add_patterns_literal(int argc, const char **argv,
 	add_patterns_from_input(pl, argc, argv, use_stdin ? stdin : NULL);
 }
 
-static int modify_pattern_list(int argc, const char **argv, int use_stdin,
+static int modify_pattern_list(struct strvec *args, int use_stdin,
 			       enum modify_type m)
 {
 	int result;
@@ -679,13 +679,13 @@ static int modify_pattern_list(int argc, const char **argv, int use_stdin,
 	switch (m) {
 	case ADD:
 		if (core_sparse_checkout_cone)
-			add_patterns_cone_mode(argc, argv, pl, use_stdin);
+			add_patterns_cone_mode(args->nr, args->v, pl, use_stdin);
 		else
-			add_patterns_literal(argc, argv, pl, use_stdin);
+			add_patterns_literal(args->nr, args->v, pl, use_stdin);
 		break;
 
 	case REPLACE:
-		add_patterns_from_input(pl, argc, argv,
+		add_patterns_from_input(pl, args->nr, args->v,
 					use_stdin ? stdin : NULL);
 		break;
 	}
@@ -706,12 +706,12 @@ static int modify_pattern_list(int argc, const char **argv, int use_stdin,
 	return result;
 }
 
-static void sanitize_paths(int argc, const char **argv,
+static void sanitize_paths(struct strvec *args,
 			   const char *prefix, int skip_checks)
 {
 	int i;
 
-	if (!argc)
+	if (!args->nr)
 		return;
 
 	if (prefix && *prefix && core_sparse_checkout_cone) {
@@ -721,8 +721,11 @@ static void sanitize_paths(int argc, const char **argv,
 		 */
 		int prefix_len = strlen(prefix);
 
-		for (i = 0; i < argc; i++)
-			argv[i] = prefix_path(prefix, prefix_len, argv[i]);
+		for (i = 0; i < args->nr; i++) {
+			char *prefixed_path = prefix_path(prefix, prefix_len, args->v[i]);
+			strvec_replace(args, i, prefixed_path);
+			free(prefixed_path);
+		}
 	}
 
 	if (skip_checks)
@@ -732,20 +735,20 @@ static void sanitize_paths(int argc, const char **argv,
 		die(_("please run from the toplevel directory in non-cone mode"));
 
 	if (core_sparse_checkout_cone) {
-		for (i = 0; i < argc; i++) {
-			if (argv[i][0] == '/')
+		for (i = 0; i < args->nr; i++) {
+			if (args->v[i][0] == '/')
 				die(_("specify directories rather than patterns (no leading slash)"));
-			if (argv[i][0] == '!')
+			if (args->v[i][0] == '!')
 				die(_("specify directories rather than patterns.  If your directory starts with a '!', pass --skip-checks"));
-			if (strpbrk(argv[i], "*?[]"))
+			if (strpbrk(args->v[i], "*?[]"))
 				die(_("specify directories rather than patterns.  If your directory really has any of '*?[]\\' in it, pass --skip-checks"));
 		}
 	}
 
-	for (i = 0; i < argc; i++) {
+	for (i = 0; i < args->nr; i++) {
 		struct cache_entry *ce;
 		struct index_state *index = the_repository->index;
-		int pos = index_name_pos(index, argv[i], strlen(argv[i]));
+		int pos = index_name_pos(index, args->v[i], strlen(args->v[i]));
 
 		if (pos < 0)
 			continue;
@@ -754,9 +757,9 @@ static void sanitize_paths(int argc, const char **argv,
 			continue;
 
 		if (core_sparse_checkout_cone)
-			die(_("'%s' is not a directory; to treat it as a directory anyway, rerun with --skip-checks"), argv[i]);
+			die(_("'%s' is not a directory; to treat it as a directory anyway, rerun with --skip-checks"), args->v[i]);
 		else
-			warning(_("pass a leading slash before paths such as '%s' if you want a single file (see NON-CONE PROBLEMS in the git-sparse-checkout manual)."), argv[i]);
+			warning(_("pass a leading slash before paths such as '%s' if you want a single file (see NON-CONE PROBLEMS in the git-sparse-checkout manual)."), args->v[i]);
 	}
 }
 
@@ -780,6 +783,8 @@ static int sparse_checkout_add(int argc, const char **argv, const char *prefix)
 			 N_("read patterns from standard in")),
 		OPT_END(),
 	};
+	struct strvec patterns = STRVEC_INIT;
+	int ret;
 
 	setup_work_tree();
 	if (!core_apply_sparse_checkout)
@@ -791,9 +796,14 @@ static int sparse_checkout_add(int argc, const char **argv, const char *prefix)
 			     builtin_sparse_checkout_add_options,
 			     builtin_sparse_checkout_add_usage, 0);
 
-	sanitize_paths(argc, argv, prefix, add_opts.skip_checks);
+	for (int i = 0; i < argc; i++)
+		strvec_push(&patterns, argv[i]);
+	sanitize_paths(&patterns, prefix, add_opts.skip_checks);
 
-	return modify_pattern_list(argc, argv, add_opts.use_stdin, ADD);
+	ret = modify_pattern_list(&patterns, add_opts.use_stdin, ADD);
+
+	strvec_clear(&patterns);
+	return ret;
 }
 
 static char const * const builtin_sparse_checkout_set_usage[] = {
@@ -826,6 +836,8 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 			   PARSE_OPT_NONEG),
 		OPT_END(),
 	};
+	struct strvec patterns = STRVEC_INIT;
+	int ret;
 
 	setup_work_tree();
 	repo_read_index(the_repository);
@@ -846,13 +858,18 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 	 * top-level directory (much as 'init' would do).
 	 */
 	if (!core_sparse_checkout_cone && !set_opts.use_stdin && argc == 0) {
-		argv = default_patterns;
-		argc = default_patterns_nr;
+		for (int i = 0; i < default_patterns_nr; i++)
+			strvec_push(&patterns, default_patterns[i]);
 	} else {
-		sanitize_paths(argc, argv, prefix, set_opts.skip_checks);
+		for (int i = 0; i < argc; i++)
+			strvec_push(&patterns, argv[i]);
+		sanitize_paths(&patterns, prefix, set_opts.skip_checks);
 	}
 
-	return modify_pattern_list(argc, argv, set_opts.use_stdin, REPLACE);
+	ret = modify_pattern_list(&patterns, set_opts.use_stdin, REPLACE);
+
+	strvec_clear(&patterns);
+	return ret;
 }
 
 static char const * const builtin_sparse_checkout_reapply_usage[] = {

-- 
2.47.0.274.g962d0b743d.dirty

