Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697983D3D0E
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 13:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876677; cv=none; b=JIM/s5U/ab5QWY6ermgkbaudoWdcbKrnRGCp8wzBYQZWjRGlrkIdq/YFC+1dEJjzulKdOA5wD9fSxFyVhYt9pElSvDP4+E7Wd/b3BuNtvdVCoOfTWRK8lxy8qPLz4G6aqNqhD+SzEh3p6REr5HYVEM5qJR19msmWDt/9sMR5cZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876677; c=relaxed/simple;
	bh=CUtlYONbuw5MDZbEl6xpfXnhUEn+EaG6VJGSMfqs08w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UIhNig+CSPDKjcx1ACFgGTFhPbCBMdCE8cHkNhLs4M3X3QDS7v+mRGHpaBgFCcEDykyU2JlKAc8byjxsIwLgUiTvv1SewiAGF7rXaXjgaNWE2DFM9lBJ+CNw8lqcVv6BkilEJEwno79/sXuTVP0iELmgyphKxcgXyXtIzpji5oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FfINAg/o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L0O8u06e; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FfINAg/o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L0O8u06e"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id C98F31D00056
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 09:17:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 30 Mar 2026 09:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774876675;
	 x=1774963075; bh=8bLITs+rhiR9OI4SsQphvcM9uGlU1cAiS9+UtaM9+SY=; b=
	FfINAg/o0nuj5mwmjv0JYJuxXt0A/uDOikAahzrYefmVtbIrVKbJwObsd4sg4f4f
	eQBcQyAvpvyPX15Plx3rM7kdRT8fUUWSiS84o+dr/yjz90T5gugP5Tjc57zBsm92
	kyYodOy+OMdzWPd19xtUV3GxB2ecGiVq3mIGqlQF8eyUEAz9aT5WaIML47J+Q/pI
	CNBHP5THf9w+pX3LeYTl+HE7h8IMlfk02eQAUrJUO7wyE6gRtxCQumrJYkUtTVBG
	tzn/hiFYeDx0PS7PBSLF2qKzC3e1TUwOkKN2FaLpmmGJBzS3EkIraO4JGVtb+zX7
	C5IZ4aSciHHoI+TL9boDqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774876675; x=
	1774963075; bh=8bLITs+rhiR9OI4SsQphvcM9uGlU1cAiS9+UtaM9+SY=; b=L
	0O8u06eJfmGbPYjPkstlu8PIWSGiXcGZavMlheD9mTMgLTL2OaXUQbop9SF0jeul
	R4q/+8vpzGanXeQGQXRYesk/ignHV+3GKiN9TYchTTpG5pkJasgXHsM0KbLvLEV7
	lxrfEVkjznPJSy5OMJqpd9xHZ0R/+Xju8aWBrOa57lNyy2p7ZXbQGLQqzyJE5x+g
	cbnYpd2bjbccmKuiiwnWPJetrphEQb9tuBOFsYmY0gtpuY55Ay75G4goAu7aDrPt
	KApB97bvq4JPUTasRzm/blkczWFtdqsLPmpKjFWz3+eZdqicGvCnlGue6iMCTnFG
	RjxgxFeeeeNZXe+fVVrEw==
X-ME-Sender: <xms:A3jKaap6rvHTQNhOCNFH5AEGKwDZbITXxKM2mlIzayqPgkDiyjq1dA>
    <xme:A3jKafkK19DWUC1VoSwIP_o0ds-dZk9i0nFpBbwXxpgM3RD8kzqr8sFio8itlgctz
    eNbqBMEqJy0IXYmOtbqU0DahHdoBC5fLZe0rVhFZCJYiygwPN5LRg>
X-ME-Received: <xmr:A3jKaU3NGacwOPtfV3-zD1UKM1KzLP0_W0klIZAspT5Sj7rnsWCXFaU6u9X1HC04Yg-Vv9jFSwK7DX00Nmd3UFpBuRTfSa7WptMok_OpqhqFQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeeltdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:A3jKafAY4cXE2q57gE2nZV4zbLHIdi1X2QsBvHrpXZrEsZrrU8wcow>
    <xmx:A3jKaZwzpDv67hShI_gu3i8RWc9x3iI5ouwZRvxWdF40wM5mNIDkqA>
    <xmx:A3jKaVkOw4iGzcqz1JGyN-w2_n60zBvactqykMR95M8V1R3FiZDQow>
    <xmx:A3jKaWEb_PDsx_TnAQTEqui5qVYRuV9VT4yP1-LoYCgPUP71VgwZFA>
    <xmx:A3jKaWKEDa8Wrl7XYzdALySWHSISSAw2thVl2rlztmTHXTOrjB_jWTqA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Mar 2026 09:17:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d2071b8c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Mar 2026 13:17:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 30 Mar 2026 15:17:26 +0200
Subject: [PATCH 04/18] setup: stop using `the_repository` in
 `prefix_path()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-pks-setup-wo-the-repository-v1-4-0d2e822837aa@pks.im>
References: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
In-Reply-To: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.0

Stop using `the_repository` in `prefix_path()` and instead accept the
repository as a parameter. The injection of `the_repository` is thus
bumped one level higher, where callers now pass it in explicitly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/blame.c            |  2 +-
 builtin/check-attr.c       |  2 +-
 builtin/checkout-index.c   |  4 ++--
 builtin/mv.c               |  5 +++--
 builtin/sparse-checkout.c  |  3 ++-
 builtin/update-index.c     |  6 +++---
 line-log.c                 |  2 +-
 object-name.c              |  2 +-
 pathspec.c                 |  2 +-
 setup.c                    | 15 ++++++++-------
 setup.h                    |  4 ++--
 t/helper/test-path-utils.c |  2 +-
 12 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index f3a11eff44..ffbd3ce5c5 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -708,7 +708,7 @@ static unsigned parse_score(const char *arg)
 
 static char *add_prefix(const char *prefix, const char *path)
 {
-	return prefix_path(prefix, prefix ? strlen(prefix) : 0, path);
+	return prefix_path(the_repository, prefix, prefix ? strlen(prefix) : 0, path);
 }
 
 static int git_blame_config(const char *var, const char *value,
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 51ed48ce43..04b86e42ae 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -67,7 +67,7 @@ static void check_attr(const char *prefix, struct attr_check *check,
 
 {
 	char *full_path =
-		prefix_path(prefix, prefix ? strlen(prefix) : 0, file);
+		prefix_path(the_repository, prefix, prefix ? strlen(prefix) : 0, file);
 
 	if (collect_all) {
 		git_all_attrs(the_repository->index, full_path, check);
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 188128aebd..311b94ff31 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -303,7 +303,7 @@ int cmd_checkout_index(int argc,
 			die("git checkout-index: don't mix '--all' and explicit filenames");
 		if (read_from_stdin)
 			die("git checkout-index: don't mix '--stdin' and explicit filenames");
-		p = prefix_path(prefix, prefix_length, arg);
+		p = prefix_path(repo, prefix, prefix_length, arg);
 		err |= checkout_file(repo->index, p, prefix);
 		free(p);
 	}
@@ -325,7 +325,7 @@ int cmd_checkout_index(int argc,
 					die("line is badly quoted");
 				strbuf_swap(&buf, &unquoted);
 			}
-			p = prefix_path(prefix, prefix_length, buf.buf);
+			p = prefix_path(repo, prefix, prefix_length, buf.buf);
 			err |= checkout_file(repo->index, p, prefix);
 			free(p);
 		}
diff --git a/builtin/mv.c b/builtin/mv.c
index 2215d34e31..948b330639 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -71,7 +71,7 @@ static void internal_prefix_pathspec(struct strvec *out,
 
 		trimmed = xmemdupz(pathspec[i], to_copy);
 		maybe_basename = (flags & DUP_BASENAME) ? basename(trimmed) : trimmed;
-		prefixed_path = prefix_path(prefix, prefixlen, maybe_basename);
+		prefixed_path = prefix_path(the_repository, prefix, prefixlen, maybe_basename);
 		strvec_push(out, prefixed_path);
 
 		free(prefixed_path);
@@ -394,7 +394,8 @@ int cmd_mv(int argc,
 			for (j = 0; j < last - first; j++) {
 				const struct cache_entry *ce = the_repository->index->cache[first + j];
 				const char *path = ce->name;
-				char *prefixed_path = prefix_path(dst_with_slash, dst_with_slash_len, path + length + 1);
+				char *prefixed_path = prefix_path(the_repository, dst_with_slash,
+								  dst_with_slash_len, path + length + 1);
 
 				strvec_push(&sources, path);
 				strvec_push(&destinations, prefixed_path);
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index f4aa405da9..2af50fb2f9 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -735,7 +735,8 @@ static void sanitize_paths(struct repository *repo,
 		int prefix_len = strlen(prefix);
 
 		for (i = 0; i < args->nr; i++) {
-			char *prefixed_path = prefix_path(prefix, prefix_len, args->v[i]);
+			char *prefixed_path = prefix_path(the_repository, prefix,
+							  prefix_len, args->v[i]);
 			strvec_replace(args, i, prefixed_path);
 			free(prefixed_path);
 		}
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 8a5907767b..7434112b8e 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -655,7 +655,7 @@ static int do_unresolve(int ac, const char **av,
 
 	for (i = 1; i < ac; i++) {
 		const char *arg = av[i];
-		char *p = prefix_path(prefix, prefix_length, arg);
+		char *p = prefix_path(the_repository, prefix, prefix_length, arg);
 		err |= unresolve_one(p);
 		free(p);
 	}
@@ -1158,7 +1158,7 @@ int cmd_update_index(int argc,
 			}
 
 			setup_work_tree();
-			p = prefix_path(prefix, prefix_length, path);
+			p = prefix_path(the_repository, prefix, prefix_length, path);
 			update_one(p);
 			if (set_executable_bit)
 				chmod_path(set_executable_bit, p);
@@ -1208,7 +1208,7 @@ int cmd_update_index(int argc,
 					die("line is badly quoted");
 				strbuf_swap(&buf, &unquoted);
 			}
-			p = prefix_path(prefix, prefix_length, buf.buf);
+			p = prefix_path(the_repository, prefix, prefix_length, buf.buf);
 			update_one(p);
 			if (set_executable_bit)
 				chmod_path(set_executable_bit, p);
diff --git a/line-log.c b/line-log.c
index eeaf68454e..a6fc46d331 100644
--- a/line-log.c
+++ b/line-log.c
@@ -589,7 +589,7 @@ parse_lines(struct repository *r, struct commit *commit,
 		range_part = xstrndup(item->string, name_part - item->string);
 		name_part++;
 
-		full_name = prefix_path(prefix, prefix ? strlen(prefix) : 0,
+		full_name = prefix_path(r, prefix, prefix ? strlen(prefix) : 0,
 					name_part);
 
 		spec = alloc_filespec(full_name);
diff --git a/object-name.c b/object-name.c
index 7b7e546b1f..ca5f060a4e 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1994,7 +1994,7 @@ static char *resolve_relative_path(struct repository *r, const char *rel)
 		die(_("relative path syntax can't be used outside working tree"));
 
 	/* die() inside prefix_path() if resolved path is outside worktree */
-	return prefix_path(startup_info->prefix,
+	return prefix_path(the_repository, startup_info->prefix,
 			   startup_info->prefix ? strlen(startup_info->prefix) : 0,
 			   rel);
 }
diff --git a/pathspec.c b/pathspec.c
index 5993c4afa0..f78b22709c 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -486,7 +486,7 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
 		match = xstrdup(copyfrom);
 		prefixlen = 0;
 	} else {
-		match = prefix_path_gently(prefix, prefixlen,
+		match = prefix_path_gently(the_repository, prefix, prefixlen,
 					   &prefixlen, copyfrom);
 		if (!match) {
 			const char *hint_path;
diff --git a/setup.c b/setup.c
index 864ce41116..331ea86a40 100644
--- a/setup.c
+++ b/setup.c
@@ -117,7 +117,8 @@ static int abspath_part_inside_repo(struct repository *repo, char *path)
  *  ../../sub1/sub2/foo -> sub1/sub2/foo (but no remaining prefix)
  *  `pwd`/../bar -> sub1/bar       (no remaining prefix)
  */
-char *prefix_path_gently(const char *prefix, int len,
+char *prefix_path_gently(struct repository *repo,
+			 const char *prefix, int len,
 			 int *remaining_prefix, const char *path)
 {
 	const char *orig = path;
@@ -130,7 +131,7 @@ char *prefix_path_gently(const char *prefix, int len,
 			free(sanitized);
 			return NULL;
 		}
-		if (abspath_part_inside_repo(the_repository, sanitized)) {
+		if (abspath_part_inside_repo(repo, sanitized)) {
 			free(sanitized);
 			return NULL;
 		}
@@ -146,13 +147,13 @@ char *prefix_path_gently(const char *prefix, int len,
 	return sanitized;
 }
 
-char *prefix_path(const char *prefix, int len, const char *path)
+char *prefix_path(struct repository *repo, const char *prefix, int len, const char *path)
 {
-	char *r = prefix_path_gently(prefix, len, NULL, path);
+	char *r = prefix_path_gently(repo, prefix, len, NULL, path);
 	if (!r) {
-		const char *hint_path = repo_get_work_tree(the_repository);
+		const char *hint_path = repo_get_work_tree(repo);
 		if (!hint_path)
-			hint_path = repo_get_git_dir(the_repository);
+			hint_path = repo_get_git_dir(repo);
 		die(_("'%s' is outside repository at '%s'"), path,
 		    absolute_path(hint_path));
 	}
@@ -162,7 +163,7 @@ char *prefix_path(const char *prefix, int len, const char *path)
 int path_inside_repo(const char *prefix, const char *path)
 {
 	int len = prefix ? strlen(prefix) : 0;
-	char *r = prefix_path_gently(prefix, len, NULL, path);
+	char *r = prefix_path_gently(the_repository, prefix, len, NULL, path);
 	if (r) {
 		free(r);
 		return 1;
diff --git a/setup.h b/setup.h
index 71d3f91883..24034572b1 100644
--- a/setup.h
+++ b/setup.h
@@ -138,8 +138,8 @@ const char *enter_repo(const char *path, unsigned flags);
 
 const char *setup_git_directory_gently(int *);
 const char *setup_git_directory(void);
-char *prefix_path(const char *prefix, int len, const char *path);
-char *prefix_path_gently(const char *prefix, int len, int *remaining, const char *path);
+char *prefix_path(struct repository *repo, const char *prefix, int len, const char *path);
+char *prefix_path_gently(struct repository *repo, const char *prefix, int len, int *remaining, const char *path);
 
 int check_filename(const char *prefix, const char *name);
 void verify_filename(const char *prefix,
diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 874542ec34..163fdeefb0 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -379,7 +379,7 @@ int cmd__path_utils(int argc, const char **argv)
 		int nongit_ok;
 		setup_git_directory_gently(&nongit_ok);
 		while (argc > 3) {
-			char *pfx = prefix_path(prefix, prefix_len, argv[3]);
+			char *pfx = prefix_path(the_repository, prefix, prefix_len, argv[3]);
 
 			puts(pfx);
 			free(pfx);

-- 
2.53.0.1185.g05d4b7b318.dirty

