Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CE11925A8
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321541; cv=none; b=BMc87Ef7f6o49fyjsDU18Vyp8xmWdpM3hBDyv6RPZTW7UXtGGC1ojC05a4P4+8PhwXFn0+C4pY3modNQBczWPLf4CUT4SVJMUxD5HPsAp98PpH492tyXVbM6rzgf0QOrut1W74uFeCMHUPkWQOlTIEXCL5v1v8hj/PjAr+4Ylf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321541; c=relaxed/simple;
	bh=JyTZSKnK8Xk0xWaN9wxlVFK4UX3FgGn3cSou41g3FWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S92JZLgCyfozwG9IfQ5ai4IPoZoxqHpofZOGzvd0VOhWwMNQneEr4g8njMaARWDpkcl3+2Ylqo1AKkMeisUwCYj4jRXZ/jjy2GS6IwPm0stz5CBVThu3p1tkQqxLyLcM0ZgItRmH8AqESKtin98FDLS0DeZmwkJ1cYiYXvIDapc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X0CqTwo+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JRjuCyzH; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X0CqTwo+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JRjuCyzH"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DBE0F114015D;
	Mon, 11 Nov 2024 05:38:58 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 11 Nov 2024 05:38:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731321538;
	 x=1731407938; bh=ADoH2rGmABSq4uxNVVXsNhyHCz65dMDCarh1XgpuNcc=; b=
	X0CqTwo+XshcMmhtViGTzHNdASIebbvg/8omP3LBMAvnp+z4WJHbOZ/80pdAdjZ7
	E8KXn7L2JfBfnysg5xX2hCRRi5+H3awBMYyrpFJcFqeV4RZBPUdksQJUFSsnltzy
	nonZCI/UlYmXrWNW+rsex2fLJTvnTaEJEBLSF2uCaD0KENHmIOO3fqsyTgPTorNw
	laUBYihU0tALibhM5fIYn3ptM3OAipMX8SzeYieEKzP85OnsgjiYlIuphopQLbDa
	DQIt566E1MU7IVqqTW+hTCyDOBtCfdIFN8tvcySTRmESuXQMmt7ar09ybJEipYa6
	vJpayguG1MDWlPxUp0Euvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731321538; x=
	1731407938; bh=ADoH2rGmABSq4uxNVVXsNhyHCz65dMDCarh1XgpuNcc=; b=J
	RjuCyzHXXNcrYeUSW5GMPLyDGyS8oZ2vPiCYAJET48Cmiut611OLEqUxUsOvydO3
	Q1QhL9Lw1GE5MPekx95qBO9b3VOoo7Bbr0D+kRVUzRzlhuHv8w03vjXVo4n5BFQ2
	3472Og8fDZonldvSVI5EzlFPAbv6n1HFXJs6bSoSewd4tbRJqRwG9oQV3uLV5IcD
	SK4q7S9Q72xn+9KR75MThMPRmNWj7rM/ag8kC87ypluc1e24t6+hfxbQaLpgqJKh
	EqcJNQKAP46ow4Pw1QmxNk614S/R/Krsd9+8jnS0TC6E7c1bsFyKutw4qn5gGGF1
	yypogAqSsI4pc37RqOT1Q==
X-ME-Sender: <xms:wt4xZ2yIpqfBrhW5CQUeUnZGCFr2EIzqpuUyrYP2x34DJGSCq4sJxg>
    <xme:wt4xZyQ6_7Mcuh9XXCfdk-ZEjdYp3Nnp1943n6ajSwvVY8CjTPxWDYyVfLXfgWjr6
    sY8qaX1jLGRlQBvdw>
X-ME-Received: <xmr:wt4xZ4VxeLqRRiBmIwk4UC3eNPWoBg02eUt2LDpIlCFCa4JnYH5_1HiiA5qpx8CYkXcJSJSQoxEDKT5sezauhMkDFDyWdz5iOgvDA_SFAK-U2-XX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehrjhhushhtohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:wt4xZ8g_xdxFzEvdkuNYbO6XzM5Emxpe0G31LNex9O8xeYRXdZEwqQ>
    <xmx:wt4xZ4Cc7a_pwShzKLLlHtfMPvGnXOCNiiJ6GvSALfsOL0wtaEaG5w>
    <xmx:wt4xZ9I-rSmnVdhdn6uaOxbZivo2t9CwAj7KlGQYaoV14Szuc1cFtg>
    <xmx:wt4xZ_D8ad1cSGsZM3Qhw_O1ikziRORguwSF7PpI-eZ6eHcopcgOUA>
    <xmx:wt4xZ7O5Hx0pvZmqk1rGyop4fsrNM772HdlwKD_c41HOA8xH-f7qNKfz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 05:38:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f2671ea1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 10:38:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 Nov 2024 11:38:42 +0100
Subject: [PATCH v2 13/27] builtin/sparse-checkout: fix leaking sanitized
 patterns
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-b4-pks-leak-fixes-pt10-v2-13-6154bf91f0b0@pks.im>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
In-Reply-To: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
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
2.47.0.229.g8f8d6eee53.dirty

