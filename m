Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82B1443A91
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 08:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790929135; cv=none; b=imzjwRo+UTXh9uCN5O1ucAiHW1xgkzDEAXL+SNqWOXDb3zIg46/CiOYZLjuw7OJCRd7EvbuzJ8yj+MAryHqWgCUVOA6SUYs9rCjqxTuv/CyoNX2Zi3CQHoQKcAw9MqPYrXk4IStZJoNhtlSSg/CFUg5umwi52S+pMPhjp+6yq6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790929135; c=relaxed/simple;
	bh=/ccd+a4nsAPoYCdd42B3haNB7ZJzklZzTkIeV7w9USU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhEVYSankvbNF7oOAB8Afmn7OowhWn5500Wpj166cX7xjwx1XAaqF268gwVFMDBQfJcxJt4Z137U5e/V/rS+Xm3oQAH6vwSOSb0Bqx1OJUEZjKvaKJNR1QfWE1Lpx/OWIKQeLG9yUmR2i5EZm+OdfVp2nSaEv42XM8jhhBHGyLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gitbutler.net; spf=pass smtp.mailfrom=gitbutler.net; dkim=pass (2048-bit key) header.d=gitbutler.net header.i=@gitbutler.net header.b=LgXTyqlP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T/vIUuw+; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gitbutler.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gitbutler.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gitbutler.net header.i=@gitbutler.net header.b="LgXTyqlP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T/vIUuw+"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id CBF91EC0196
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 04:18:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 02 Oct 2026 04:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gitbutler.net;
	 h=cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1790929132; x=
	1791015532; bh=ZGPW11qX2Jw10/lTYHU+e0b3dSKx+cx/GhGHrYJEFGQ=; b=L
	gXTyqlPiVQGeBd4nB+IQaR1OxpVQh2pGZkJGV0VKMZj0HsA5/sClCbUgvaKdMJVB
	agjp3rGKnJ80EDPOq99evyp88GRIMW/YkJigSz8B8E4C/hERLz2jp5zxEgqYrXW+
	itJoz2iD1AWkNuR8Jm/nDSu/r+8P3kXn9xSlH8HHIqfo8UOGd82qaBYJg7MBWGNv
	tHEqkvf8l+F0TZ04E87H4EVxWGlvEWaXxXH7J6iYm5NJg0Wq8o5BplBal2HsGltB
	nx3ZZ5ll7oRzJbIHeWhWqgKse+pwDRfts9q+GF4GaB3jdm2Nv2l7RFMi+oUkoFrB
	mCG5dfpcgRdE309WJyiaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1790929132; x=1791015532; bh=ZGPW11qX2Jw10/lTYHU+e0b3dSKx
	+cx/GhGHrYJEFGQ=; b=T/vIUuw+JM7IgfJFwi3eFXLedg0B6AN3prsFMFN/V5VQ
	idE6kM82zlxOHgUqS+uPuHCl9yUPVsI8OUSc26OT5GJ7Wp3E0hUGCkYB6fF3WJld
	xrRPrNtWRWRCPC7kIOpy1fDGyv+lzNihr1qFNCJKdT10K5ZYJT7lWb1vkMHxNNNh
	e0EMO+FrxyKQFesDFS67FvdR0lZfise4VZjkPykPZacUjvy7mEgKyOHVMJY0EtSU
	2pEiCQqIdzAN/dnbmFmWGdBlIht/Vg4uOMknsyHAeVAmsCTajQtPNflvpqK6xpVK
	VjWvnz5GPIpEaqsESzpX8PxKHQNsA7hfmoAh/Qs7zw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=gitbutler.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790929132; d=gitbutler.net;
	mf=PHNjb3R0QGdpdGJ1dGxlci5uZXQ+;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:PV00jiTLFc5vZ4gAnsuuhGVOpYZQf3GART4jPKAAGeoLhym
	JjIqHTEAaBVXGH2TJu76ivzBoSiUy86RsoqDWYfmmgHfyJ4Gx+TuDfcSmzQWtU1Y
	gSM8faNXBILuLipxRbHC+x0nF2A0LcWCWwc1agp0j1Jx/0IW5/7e9nP3SAeoutZU
	QLD4E5t1TIgf1IDucPlCZv/tGzvkxf53+k1C9vd+IndW8O5G4qwfkcvT5j7im1fb
	g+PCuADWH3OaQLZLrmy/LscH6q1WD5R/eckso7dzLACARVACtQ088uFaYe6GxbLg
	aZ0IAeSj8CGUBgof9kmFtcPNoD3g9eikEDvGNNQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:uLglJifknHkcs9uDjD6p8XXbWx8S12YNuCwu+c/DnX8=:/ccd+a4nsAPoYCdd42B3haNB7ZJzklZzTkIeV7w9USU=;
X-ME-Sender: <xms:7Gi_arvLzlusH9BIBX57t6FDlM_YLsC-y49PSJlHSlLyQHIcUeCJJA>
    <xme:7Gi_ajbVGoPs8DKqpV5mSJKIxw0eAhaAS-5KtZFOD3haIk2nmSrKOS5zRUy2cKAxM
    efvxl2s1xGoC-qNuv5kIR01tG_d3Fsf0BD33-7mfW0T6opFFqE5qG8>
X-ME-Received: <xmr:7Gi_aka35cuObU0xZcUdMqZWamRN7Yqdgs1wJp4ZjrYq0pffJqqenoAinQcGDXL7qAumxylcbyAZ>
X-ME-Proxy-Cause: dmFkZTEif+69Hun6V9bGLTYF9WISorEiD9Un8ZSVGxomN2XY6G62IWpqTgCeUDWgR2Y7Rz
    H3KMZsAnTPjLAzQ4ns8Rxat+QU3wwvcMS9x+32T5Sf2EGJsC8T3ABkAIe+nUAxfM46nR13
    pr6ssav0WZM0vosJmalicMtpUeZVxsDOVeiODy5ucFz/f1eOH+GnHloAGSKX3T7pG/Prw0
    9rJpkQk0c90UuCEUqRjqjVwkuOdnXkZs8HIjMt3JnBTmR8YFjY455GOnblo2wfBm7X2ULg
    366s4INQI42EuxVF2Q9KF7rsg2JXhyVaP5QMdbOO6Bk1xCrtgAaHVoeGhlAWQCvdmawFqv
    57ogF5wrxZiHxlEC20sHjhjJndrUluIEmc1fdyAYyZXhjbYAnBnnl6cxiRXz4D27JJYvNe
    GH+RRjezFwdohW8/xraM9rKNKDKtXQWhAPUqNyG7JKp6RXD/X993fvUQmDCxD/ic8n0x6l
    rkK6zCYYWsGNJ9poCHelGs9mJbXsE6ljj3pEY9i7JPPrZU8Pm5vuDciP9QBTdFaNjTJhXr
    Q/gVvNbDTm/piH2e1QB2/nfeDCO5AkLqq+bdgRp1kcNSE1j7x3fRNwhJXBsRFov8edPVOo
    mtf4R3rh7Wt4l+wbQ6MlYckxcYQztfNWRquaLgTpR+Amu5cvJHr1GLJGsQhg
X-ME-Proxy: <xmx:7Gi_avVtdURuc17LkFb4_7l8W4U9ESWSi23c4vgiND4X2rKOoGiaMg>
    <xmx:7Gi_ar3kyhtlkwyCEWTC5_Xfa0oamh_rAoDZQ8UcvcXCj8WdjOQ-2g>
    <xmx:7Gi_amYfzKRiyxU4gvkyCH-sqlk6ix9eCmoaTC1c9B4ilSc5uh17jg>
    <xmx:7Gi_auoLJgS4NnkkQ7h8l6SR72xr9IBoz37SUOYIE6c8Zjew-ZMcjQ>
    <xmx:7Gi_aqckpWFy5gnYOyG5XKhE99sKh_uQlJ4OTTyJiOhAsa3SEcPF8yGf>
Feedback-ID: iecfe4abb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 2 Oct 2026 04:18:52 -0400 (EDT)
From: Scott Chacon <scott@gitbutler.net>
To: git@vger.kernel.org
Subject: [RFC PATCH 3/4] commit: add --hash=sha256 to sign a tree-sha256 header
Date: Fri,  2 Oct 2026 10:18:45 +0200
Message-ID: <20261002081846.25144-4-scott@gitbutler.net>
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

Teach "git commit -S" the same "--hash=sha256" option as "git tag",
which adds the tree-sha256 of the tree being committed as an extra
header after "committer":

  tree <tree>
  parent <parent>
  author <ident>
  committer <ident>
  tree-sha256 <hex>
  gpgsig <signature>

Extra headers are written before the commit is signed, so the
signature covers it, and "git verify-commit" works as before.

When amending, we normally carry over the extra headers of the commit
being amended. Don't do that for tree-sha256, which would be wrong as
soon as the tree changes, and add a new one only if the amended commit
is signed with "--hash=sha256".

---
 Documentation/git-commit.adoc | 11 +++++++-
 builtin/commit.c              | 38 ++++++++++++++++++++++++---
 t/t7032-tree-sha256-signed.sh | 49 +++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-commit.adoc b/Documentation/git-commit.adoc
index 8329c1034b..c027de2adb 100644
--- a/Documentation/git-commit.adoc
+++ b/Documentation/git-commit.adoc
@@ -15,7 +15,7 @@ git commit [-a | --interactive | --patch] [-s] [-v] [-u[<mode>]] [--amend]
 	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
 	   [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]
 	   [(--trailer <token>[(=|:)<value>])...] [-S[<keyid>]]
-	   [--] [<pathspec>...]
+	   [--hash=<algorithm>] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -400,6 +400,15 @@ changes to tracked files.
 	countermand both `commit.gpgSign` configuration variable, and
 	earlier `--gpg-sign`.
 
+`--hash=<algorithm>`::
+	When signing, add a `tree-sha256` header holding a SHA-256
+	digest of every file in the commit's tree, including the
+	contents of checked-out submodules, so that the signature covers
+	the content directly rather than only its SHA-1 object names.
+	_<algorithm>_ is `sha256`, or `none` (the default).
+	Giving `--hash=sha256` without signing is an error. All
+	submodules must be checked out.
+
 `--`::
 	Do not interpret any more arguments as options.
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 840b6b4083..871a2bdcd7 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -43,6 +43,7 @@
 #include "commit-graph.h"
 #include "pretty.h"
 #include "trailer.h"
+#include "tree-sha256.h"
 
 static const char * const builtin_commit_usage[] = {
 	N_("git commit [-a | --interactive | --patch] [-s] [-v] [-u[<mode>]] [--amend]\n"
@@ -52,7 +53,7 @@ static const char * const builtin_commit_usage[] = {
 	   "           [--date=<date>] [--cleanup=<mode>] [--[no-]status]\n"
 	   "           [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]\n"
 	   "           [(--trailer <token>[(=|:)<value>])...] [-S[<keyid>]]\n"
-	   "           [--] [<pathspec>...]"),
+	   "           [--hash=<algorithm>] [--] [<pathspec>...]"),
 	NULL
 };
 
@@ -129,7 +130,8 @@ static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
 static int config_commit_verbose = -1; /* unspecified */
 static int no_post_rewrite, allow_empty_message, pathspec_file_nul;
 static const char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
-static const char *sign_commit, *pathspec_from_file;
+static const char *sign_commit, *pathspec_from_file, *hash_arg;
+static int tree_hash;
 static struct strvec trailer_args = STRVEC_INIT;
 
 /*
@@ -1737,6 +1739,8 @@ int cmd_commit(int argc,
 			.flags = PARSE_OPT_OPTARG,
 			.defval = (intptr_t) "",
 		},
+		OPT_STRING(0, "hash", &hash_arg, N_("algorithm"),
+			   N_("sign a tree-sha256 header of the committed tree (sha256 or none)")),
 		/* end commit message options */
 
 		OPT_GROUP(N_("Commit contents options")),
@@ -1821,6 +1825,14 @@ int cmd_commit(int argc,
 	argc = parse_and_validate_options(argc, argv, builtin_commit_options,
 					  builtin_commit_usage,
 					  prefix, current_head, &s);
+	if (hash_arg) {
+		tree_hash = parse_signing_hash(hash_arg);
+		if (tree_hash < 0)
+			die(_("unsupported --hash value '%s' (use 'sha256' or 'none')"),
+			    hash_arg);
+		if (tree_hash && !sign_commit)
+			die(_("--hash=%s requires a signed commit (-S)"), hash_arg);
+	}
 	if (trailer_args.nr)
 		trailer_config_init();
 
@@ -1928,13 +1940,31 @@ int cmd_commit(int argc,
 	}
 
 	if (amend) {
-		const char *exclude_gpgsig[3] = { "gpgsig", "gpgsig-sha256", NULL };
-		extra = read_commit_extra_headers(current_head, exclude_gpgsig);
+		const char *exclude[4] = {
+			"gpgsig", "gpgsig-sha256", TREE_SHA256_HEADER, NULL
+		};
+		extra = read_commit_extra_headers(current_head, exclude);
 	} else {
 		struct commit_extra_header **tail = &extra;
 		append_merge_tag_headers(parents, &tail);
 	}
 
+	if (sign_commit && tree_hash) {
+		struct commit_extra_header **tail = &extra;
+		struct strbuf hex = STRBUF_INIT;
+
+		if (tree_sha256_hex(the_repository,
+				    &the_repository->index->cache_tree->oid, &hex)) {
+			rollback_index_files();
+			die(_("unable to compute %s"), TREE_SHA256_HEADER);
+		}
+		while (*tail)
+			tail = &(*tail)->next;
+		CALLOC_ARRAY(*tail, 1);
+		(*tail)->key = xstrdup(TREE_SHA256_HEADER);
+		(*tail)->value = strbuf_detach(&hex, &(*tail)->len);
+	}
+
 	if (commit_tree_extended(sb.buf, sb.len, &the_repository->index->cache_tree->oid,
 				 parents, &oid, author_ident.buf, NULL,
 				 sign_commit, extra)) {
diff --git a/t/t7032-tree-sha256-signed.sh b/t/t7032-tree-sha256-signed.sh
index 083f25e665..44c363b5d2 100755
--- a/t/t7032-tree-sha256-signed.sh
+++ b/t/t7032-tree-sha256-signed.sh
@@ -73,4 +73,53 @@ test_expect_success GPGSSH 'tag --hash=sha256 needs an object with a tree' '
 	test_must_fail git rev-parse --verify v5
 '
 
+test_expect_success GPGSSH 'commit -S --hash=sha256 signs a tree-sha256 header' '
+	test_tick &&
+	git commit --allow-empty -S --hash=sha256 -m signed &&
+	header_of commit HEAD >actual &&
+	test_cmp expect actual &&
+	git verify-commit HEAD
+'
+
+test_expect_success GPGSSH 'commit -S without --hash has no header' '
+	test_tick &&
+	git commit --allow-empty -S -m signed &&
+	header_of commit HEAD >actual &&
+	test_must_be_empty actual &&
+	git commit --allow-empty -S --hash=none -m signed &&
+	header_of commit HEAD >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success GPGSSH 'commit --hash=sha256 requires signing' '
+	git rev-parse HEAD >before &&
+	test_must_fail git commit --allow-empty --hash=sha256 -m unsigned 2>err &&
+	test_grep "requires a signed commit" err &&
+	test_must_fail git commit --allow-empty -S --no-gpg-sign --hash=sha256 \
+		-m unsigned 2>err &&
+	test_grep "requires a signed commit" err &&
+	test_must_fail git commit --allow-empty -S --hash=md5 -m signed 2>err &&
+	test_grep "unsupported --hash value" err &&
+	git rev-parse HEAD >after &&
+	test_cmp before after
+'
+
+test_expect_success GPGSSH 'amending recomputes or drops the header' '
+	git commit --allow-empty -S --hash=sha256 -m signed &&
+	echo changed >dir/file &&
+	git add dir/file &&
+	test_tick &&
+	git commit --amend -S --hash=sha256 -m amended &&
+	test-tool tree-sha256 HEAD >expect-amended &&
+	! test_cmp expect expect-amended &&
+	header_of commit HEAD >actual &&
+	test_cmp expect-amended actual &&
+	git verify-commit HEAD &&
+
+	test_tick &&
+	git commit --amend -m "amended unsigned" &&
+	header_of commit HEAD >actual &&
+	test_must_be_empty actual
+'
+
 test_done
-- 
2.50.1 (Apple Git-155)

