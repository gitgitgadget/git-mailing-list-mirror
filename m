Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5083A36729C
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 08:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790929136; cv=none; b=sbSBcNfS/oJ7WXNWSW1Q9md6etfEduM3a5dyfxchGGEktkXWkg1xm/0ui64kVLTHTwAEMnKnjZSoiqrvHjkwM+wGsDRFTuzUug2TTGXx3vrGgOlaQ+dnNvIXWuXDWr8RQ72fbAY61k4nUs6gGOBIXCCRj+51+nGw7YlW1G98xvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790929136; c=relaxed/simple;
	bh=Z1UAMSxRgrGbup70tNXCIqOluIqI7YeER4E/OXlLPPA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSXxDKXHgRanTkHWj0fV54PBTADbtxcmTWvqSw/4SFLC1GUWsA0kc68Zf0/F7XVL1pZ/3RVWprzsRfF/LwsnDUzMI2rtPlHJyLZ9ffDWWFO+BEfkNaL3sLmOmSE+rPBjPQ4+pqMesnsq9rbDH7k1Eya3Gf4SEYO8gSNNEmB9R5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gitbutler.net; spf=pass smtp.mailfrom=gitbutler.net; dkim=pass (2048-bit key) header.d=gitbutler.net header.i=@gitbutler.net header.b=l3TKFrUq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t3IZ36xv; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gitbutler.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gitbutler.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gitbutler.net header.i=@gitbutler.net header.b="l3TKFrUq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t3IZ36xv"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 72F4EEC0292
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 04:18:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 02 Oct 2026 04:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gitbutler.net;
	 h=cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1790929133; x=
	1791015533; bh=vCvqgQxLar8kB5Pnj0AQIXXvUAgXAQfwgvuadjPzWI0=; b=l
	3TKFrUqHH5qR1zyDG60P2Jvth842Bzhp4sbjKg9NoRUbFhYcbOKvtWWHr16pfqrl
	kIKiLw8EGJ32Mc9xmMH+PapPZZfRgBl87wF+uEjGqFYfVaCLn7CRE4EnEV1UEMce
	6FdRSA4eTuZ4IsAOvYuNOWGjx7r11o2THZUWU46oN+UyE277zrXgrHw+t8wrjgau
	rOgJciD+myu98k5JBxJp8ODaG2JR78iycXDLyA+dvbO7l7/Ap9p2NFTM1I/o0NkJ
	1xJYjLS7k87+HAlxtq/spOB7G42KcnQvyXdDEE2KjG1Og50mPH6u81BfCayM848s
	aJ7QHTBp2Whg/Et8qFcLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1790929133; x=1791015533; bh=vCvqgQxLar8kB5Pnj0AQIXXvUAgX
	AQfwgvuadjPzWI0=; b=t3IZ36xvCU3Fv3phbcn2LYjF4n9aVbcFmGTCJxstIxZu
	9HAPIq5EEunC+NhOCxegE8uUgNPjL8AtF/4e+2wckEJtiHVah6hTC5vG3nC+jZnh
	j2ZhQaEVQjBGjolkFsoE8IrnqDqzPUTmCe4bih8HnWBttoDmRoe+0yPSVjhCyTqg
	eiGj3wvwJnFfuTKzfAXLDugsbpTPNwJlNPEeneRswbpQmMolKYNQmLaqrgoeBkUm
	VGa6sjL56yJBb2Mcn9C3vazk+LtLYEnhuje+ZIa5dRnJ6p9AIZ2ntT8SHJ8pJCet
	E9sIHwaLR2eefU1m4O3BcKbnf9sIaSsOmwa7gRVCWw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=gitbutler.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790929133; d=gitbutler.net;
	mf=PHNjb3R0QGdpdGJ1dGxlci5uZXQ+;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:k7CMR8k2DqZ7gVjtBOK+JHiYre+6FQYFh+ZiPI9F4YhG/tM
	7rBDgKiRVNcp9SOPCLqOo62szb5QziULiLejol4fzLCFfKbxcvzo8lVFdKAnO166
	nOmF7YcSjfi7/COVDGSZvS3PHkKDugoXG/V3rZNZofBVK270wqIObffDCZSTVZ8r
	Edc1ncwRS5k4MNAohpO4riw4/SxNPvpCbaJ4jgb6VEVwuyVoIutL8Z2KO4eq0UWA
	wZFop/rV4s/PzSNrwGRCvzgHoJtmfedQYxBNRBZN/BfLqFeSGRzXUj5Q/qtkgvi7
	a1wwnTGE6ULimV6FF7EZnSpwfEf/DGcx8MuW4WA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:QiB71qNaBaQuh3Lx5rKC4p/yPGkaly6fuZhKahp+AvA=:Z1UAMSxRgrGbup70tNXCIqOluIqI7YeER4E/OXlLPPA=;
X-ME-Sender: <xms:7Wi_akLyMvotIOl-NUy_-rCqd4TQ28C25DsoZIXfsoV9L0H1XSfTPQ>
    <xme:7Wi_arGG0ITN1vhjU-05Eeb_KxBw4mZW7JC9hQkhUBp-LgxdOHaQHzRLu2QA_B8Ot
    LECKOr9e8Tq18QoHlZ7wzlRHA-9tv70weaUMm_D54WCBwoDO7Uj0z9N>
X-ME-Received: <xmr:7Wi_aqXKGgvf1YHB-mcNyh86bAal1sfBxY_WAUCkhHO-3lE-Nmj31ndO8YSfMXE9bGrmy_XJ--k2>
X-ME-Proxy-Cause: dmFkZTEd2zeuDlEa1fUJIB9wZKgluecjPq8b7le5L/VgxhUPUKgWU3O3YGKYQOcrmr5DnC
    BlUsi8hBQlbFwalwGHfE6gNCkKjUOUg0w/lXpxgt2M+gBbTxyaUVyj+mTJ172U6LczwzBu
    aKB72OOJhL6i2/co6UjI3vTcEs4Z/ytRX+7gPSuKKDwfaYX45ZRj2XQPFzNZCZEqg03hPp
    AO16yM9197LEK11VRTywNoAuASX1t0XjMe3y3B2GYEytaEnC0f/ARXB4DJoH7Uj9fiHdsN
    JgB8zXVkZ63wkNhLVzwkSa0zh7rK3HTHhznE6N/05Kuyw0NglFYBTEg0Ki58JXfPstcvhF
    iDs9oBw7NqxNwM6npKIGCU4vpv8Vivrj/yE6poaNQS4qyE9rIN9/FoF+LchXcD1CkLkcAG
    uhMLTmlIvFSq3mOduDgJC/kExVDIve3vSAhtC17JfxZItYojJ6BqK+j7WDrNirGg3FQEW0
    2Y0y+FEJKi9d9Hq3ypnDQkaXvwP+nDDRQxBjA47nPOBuBvSjxBYc3jRJMfF9yRH9gSBP98
    hHyUcAg0RLISG+IRRcKSGnnId0gmDiQuJa1hKBlCLz5XRMX1Moeq8xYA6bMIZrnrzwnUsu
    gqL2hTqXXBM3dyLVLqeKnVtsi1wXWqgr5wP0f5kakkb2CjM3k97/rm/7h22w
X-ME-Proxy: <xmx:7Wi_amgHChtc0l4HBSOS-AztcTaXKw0DFsfCmZ-vKLzIenJUPmzLgg>
    <xmx:7Wi_arSM8Srjoh5huWBvf8R0kzHJ0N5JzddCtADjuyVT0mS2d4YqVw>
    <xmx:7Wi_apGN3dyAyEs8c69wghAJvjDUmGQf-m9NqZg7ROnebecAtQtDRA>
    <xmx:7Wi_ajmWMGbhHXGp5rJATiih_ko1OKscFlIewSWKRS_zI6992pXXYQ>
    <xmx:7Wi_aqNGKd4rtrdqhIZPwdvtJCptKGeY93mWf3rT9kQqLO6vdwJOIkMI>
Feedback-ID: iecfe4abb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 2 Oct 2026 04:18:52 -0400 (EDT)
From: Scott Chacon <scott@gitbutler.net>
To: git@vger.kernel.org
Subject: [RFC PATCH 4/4] gpg: add gpg.treeHash to sign a tree-sha256 header by default
Date: Fri,  2 Oct 2026 10:18:46 +0200
Message-ID: <20261002081846.25144-5-scott@gitbutler.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261002081846.25144-1-scott@gitbutler.net>
References: <20261002081846.25144-1-scott@gitbutler.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Someone who wants their signatures to cover the contents of their
trees wants it for every tag and commit they sign, and shouldn't have
to remember "--hash=sha256" each time, much as "tag.gpgSign" and
"commit.gpgSign" save them from remembering "-s" and "-S".

Add "gpg.treeHash", which "git tag" and "git commit" use as the
default for "--hash". It is a single variable rather than one for
each command, since the reason for wanting it is the same for both.

It only applies to objects that are signed: with it set, unsigned
commits and annotated or lightweight tags are made as before, rather
than failing as an explicit "--hash=sha256" without signing does.
"--hash=none" overrides it.

---
 Documentation/config/gpg.adoc |  6 +++++
 Documentation/git-commit.adoc |  2 +-
 Documentation/git-tag.adoc    |  2 +-
 builtin/commit.c              |  8 +++++++
 builtin/tag.c                 | 14 ++++++++++-
 t/t7032-tree-sha256-signed.sh | 44 +++++++++++++++++++++++++++++++++++
 tree-sha256.h                 |  4 ++--
 7 files changed, 75 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/gpg.adoc b/Documentation/config/gpg.adoc
index 240e46c050..6728c13a62 100644
--- a/Documentation/config/gpg.adoc
+++ b/Documentation/config/gpg.adoc
@@ -16,6 +16,12 @@ gpg.format::
 See linkgit:gitformat-signature[5] for the signature format, which differs
 based on the selected `gpg.format`.
 
+gpg.treeHash::
+	When set to `sha256`, `git commit` and `git tag` add a
+	`tree-sha256` header to every commit and tag they sign, as if
+	`--hash=sha256` were given. Defaults to `none`. See the
+	`--hash` option in linkgit:git-commit[1] and linkgit:git-tag[1].
+
 gpg.<format>.program::
 	Use this to customize the program used for the signing format you
 	chose. (see `gpg.program` and `gpg.format`) `gpg.program` can still
diff --git a/Documentation/git-commit.adoc b/Documentation/git-commit.adoc
index c027de2adb..1ed6635eee 100644
--- a/Documentation/git-commit.adoc
+++ b/Documentation/git-commit.adoc
@@ -405,7 +405,7 @@ changes to tracked files.
 	digest of every file in the commit's tree, including the
 	contents of checked-out submodules, so that the signature covers
 	the content directly rather than only its SHA-1 object names.
-	_<algorithm>_ is `sha256`, or `none` (the default).
+	_<algorithm>_ is `sha256`, or `none` to override `gpg.treeHash`.
 	Giving `--hash=sha256` without signing is an error. All
 	submodules must be checked out.
 
diff --git a/Documentation/git-tag.adoc b/Documentation/git-tag.adoc
index 8901090a6d..445be41db1 100644
--- a/Documentation/git-tag.adoc
+++ b/Documentation/git-tag.adoc
@@ -89,7 +89,7 @@ OPTIONS
 	digest of every file in the tagged object's tree, including the
 	contents of checked-out submodules, so that the signature covers
 	the content directly rather than only its SHA-1 object names.
-	_<algorithm>_ is `sha256`, or `none` (the default).
+	_<algorithm>_ is `sha256`, or `none` to override `gpg.treeHash`.
 	Giving `--hash=sha256` without signing is an error. All
 	submodules must be checked out.
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 871a2bdcd7..7e56c434db 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1687,6 +1687,14 @@ static int git_commit_config(const char *k, const char *v,
 		sign_commit = git_config_bool(k, v) ? "" : NULL;
 		return 0;
 	}
+	if (!strcmp(k, "gpg.treehash")) {
+		if (!v)
+			return config_error_nonbool(k);
+		tree_hash = parse_signing_hash(v);
+		if (tree_hash < 0)
+			return error(_("invalid value for '%s': '%s'"), k, v);
+		return 0;
+	}
 	if (!strcmp(k, "commit.verbose")) {
 		int is_bool;
 		config_commit_verbose = git_config_bool_or_int(k, v, ctx->kvi,
diff --git a/builtin/tag.c b/builtin/tag.c
index 9bc4c946d1..86871317ed 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -51,6 +51,7 @@ static const char * const git_tag_usage[] = {
 static unsigned int colopts;
 static int force_sign_annotate;
 static int config_sign_tag = -1; /* unspecified */
+static int config_tree_hash;
 
 static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting,
 		     struct ref_format *format)
@@ -223,6 +224,15 @@ static int git_tag_config(const char *var, const char *value,
 		return 0;
 	}
 
+	if (!strcmp(var, "gpg.treehash")) {
+		if (!value)
+			return config_error_nonbool(var);
+		config_tree_hash = parse_signing_hash(value);
+		if (config_tree_hash < 0)
+			return error(_("invalid value for '%s': '%s'"), var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "tag.forcesignannotated")) {
 		force_sign_annotate = git_config_bool(var, value);
 		return 0;
@@ -601,6 +611,8 @@ int cmd_tag(int argc,
 	}
 	create_tag_object = (opt.sign || annotate || msg.given || msgfile ||
 			     edit_flag || trailer_args.nr || opt.tree_hash);
+	if (!hash_arg)
+		opt.tree_hash = config_tree_hash;
 
 	if ((create_tag_object || force) && (cmdmode != 0))
 		usage_with_options(git_tag_usage, options);
@@ -704,7 +716,7 @@ int cmd_tag(int argc,
 	if (create_tag_object) {
 		if (force_sign_annotate && !annotate)
 			opt.sign = 1;
-		if (opt.tree_hash && !opt.sign)
+		if (opt.tree_hash && !opt.sign && hash_arg)
 			die(_("--hash=%s requires a signed tag (-s or -u)"), hash_arg);
 		path = repo_git_path(the_repository, "TAG_EDITMSG");
 		create_tag(&object, object_ref, tag, &buf, &opt, &prev, &object,
diff --git a/t/t7032-tree-sha256-signed.sh b/t/t7032-tree-sha256-signed.sh
index 44c363b5d2..5a656a7816 100755
--- a/t/t7032-tree-sha256-signed.sh
+++ b/t/t7032-tree-sha256-signed.sh
@@ -122,4 +122,48 @@ test_expect_success GPGSSH 'amending recomputes or drops the header' '
 	test_must_be_empty actual
 '
 
+test_expect_success GPGSSH 'gpg.treeHash signs the header by default' '
+	test-tool tree-sha256 HEAD >expect &&
+	test_config gpg.treeHash sha256 &&
+	git tag -s -m release v6 &&
+	header_of tag v6 >actual &&
+	test_cmp expect actual &&
+	test_tick &&
+	git commit --allow-empty -S -m signed &&
+	header_of commit HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success GPGSSH 'gpg.treeHash leaves unsigned objects alone' '
+	test_config gpg.treeHash sha256 &&
+	git tag -a -m annotated v7 &&
+	header_of tag v7 >actual &&
+	test_must_be_empty actual &&
+	git tag v8 &&
+	test "$(git cat-file -t v8)" = commit &&
+	test_tick &&
+	git commit --allow-empty -m unsigned &&
+	header_of commit HEAD >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success GPGSSH '--hash=none overrides gpg.treeHash' '
+	test_config gpg.treeHash sha256 &&
+	git tag -s --hash=none -m release v9 &&
+	header_of tag v9 >actual &&
+	test_must_be_empty actual &&
+	test_tick &&
+	git commit --allow-empty -S --hash=none -m signed &&
+	header_of commit HEAD >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success GPGSSH 'invalid gpg.treeHash is an error' '
+	test_config gpg.treeHash md5 &&
+	test_must_fail git tag -s -m release v10 2>err &&
+	test_grep "invalid value for .gpg.treehash." err &&
+	test_must_fail git commit --allow-empty -S -m signed 2>err &&
+	test_grep "invalid value for .gpg.treehash." err
+'
+
 test_done
diff --git a/tree-sha256.h b/tree-sha256.h
index dc070129ea..6d54c2c9f9 100644
--- a/tree-sha256.h
+++ b/tree-sha256.h
@@ -28,8 +28,8 @@ int tree_sha256_hex(struct repository *r, const struct object_id *oid,
 		    struct strbuf *hex);
 
 /*
- * Parse the value of a --hash=<algorithm> option. Returns 1 for
- * "sha256", 0 for "none", and -1 for anything else.
+ * Parse the value of a --hash=<algorithm> option or of gpg.treeHash.
+ * Returns 1 for "sha256", 0 for "none", and -1 for anything else.
  */
 int parse_signing_hash(const char *value);
 
-- 
2.50.1 (Apple Git-155)

