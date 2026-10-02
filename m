Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D24440658
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 08:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790929135; cv=none; b=Fv2pQs9Nbuwv0d9CAhNZ+H08hlVyn9XFdFhIWzTXfd/IFENFpTqxmd4uuOJvKxWTX0WlZGplRCkc+UNcHMklPVfeV0RFUKSUS6lFKfivqCDgq3El+GaDqGS7IY/gHb48fWgB3tU0syFuE73Qr2cKDP/tD7ex11jkZCpcxpp0Vrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790929135; c=relaxed/simple;
	bh=wCe/jP9fR4pzQLBakWWr+l2wq5I/3TxqGLjfr0r0nBA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rhvS2qIneCInQP9Lw4iG8amXV7yLCAqH12rLHtW9SvP1UCNDDtiFqgk6wGDhX714XCeiqrry+i+1wnfKrfwoWtY39remdPJNzoo4ejzQU1c6IGhmiFFxOoBrg3FSE7NuZdwSgHGRP7/S5EZE+nDOmPkEk2D0rpwpY+D4ESG4Vnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gitbutler.net; spf=pass smtp.mailfrom=gitbutler.net; dkim=pass (2048-bit key) header.d=gitbutler.net header.i=@gitbutler.net header.b=dfIxfOSd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fNHjV1QZ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gitbutler.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gitbutler.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gitbutler.net header.i=@gitbutler.net header.b="dfIxfOSd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fNHjV1QZ"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 325F91400090
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 04:18:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 02 Oct 2026 04:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gitbutler.net;
	 h=cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1790929132; x=
	1791015532; bh=czbrPLYLmOSNGpg3eoboGH5E6UImmlwQ7dNiQu8GR5w=; b=d
	fIxfOSdmM+fnmc1/5uSHsU07k+Sqss+Xogee7OVUNmW8h8Ln6WcVwpbCt1zYi4w7
	z2JQ/ZqwWE6s534tDoZ0/p/ZU5AISzzjsF84hvz+PMaqLC04s0Cm5JkTMzpywbbg
	XeAQtlz2V45DMRyjRLUhZHX0m4RHIEVX6M8p1Xp5XKFw14zC5AY+IbinarGQD74T
	hRnPHyjDqOBrpdNGVT73H3zXzQ0WgQ9iQJSyvv7W0B6XcJzXX0ksHHTYObVep4Lj
	lQhkoUK6x0rsgd1XkzaP46mOWk/86MBidRMjcU9ydon65s6sN77NKg06brot440V
	GD/6GCuBpY0V0wELr434g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1790929132; x=1791015532; bh=czbrPLYLmOSNGpg3eoboGH5E6UIm
	mlwQ7dNiQu8GR5w=; b=fNHjV1QZgPkP9OuVsya7uOr1QvHkNAtpjsV4thZOnA0J
	LxpUI2PGVx4GBUw4TTpCQD3TQ+395lhpaqJ0Kar1AooaI8IW5BSw5G1yfBBs5gBD
	GxJsc/MhqHiMqWbFIqm7e9mo72XgbNpYeGUB3YjChUxb5n4Ka7lsn547iHI/9yVx
	d+R1eG75OyJHDsUybR02PO7ST7Xhv4jEaHNMjgd/VgT7bYL1ZoZaoWizbAlHThzD
	GJXj8lQhE/cvPrXXakD8rJEMqpQ/l82OaO1RhJ6hP3umxfqGi/3h4Wt1595r4ILb
	5L9GcWwwU2bIzSLhWsY/U4t52ootGPMi1C8NxBt8EQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=gitbutler.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790929132; d=gitbutler.net;
	mf=PHNjb3R0QGdpdGJ1dGxlci5uZXQ+;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:pUdlwcBbt+H2vQptaYOB2PJ4o2KBiLsnzHFkzMExdQkGqqO
	zMhQB2sX8NUt2lSXXZybTJ++Na+YXuCbrnaeZiR3mdy3CMP+w7wPVM5bLXZ9cg9K
	mdYUarmB+iieLSgmcg0DDfxRkTe8h65Ljq6G9BHeqBzeYoa+h7F/M+aM9bRRhJ0O
	d0OBIzSZHj5Cszk0wJk05gDNx9jpg6vglLSbO0M41c/L50UNZK+EvvGlRxYkl5gP
	JMDv2D8tq3IldUWY/q/74ElArsLrjaYWelHoJbDwTEfC2YMk5jOSyeBgCJTeqlmD
	84NF6QD/HKZ5GdZM3Ger5+6IFu1zT80fHkj+2Rg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:bJDIVXWNftWa5qpqjpt8oY2bev0hdDAIzgI8f6eKKF8=:wCe/jP9fR4pzQLBakWWr+l2wq5I/3TxqGLjfr0r0nBA=;
X-ME-Sender: <xms:7Gi_ag7zsMmcoRmDFw_WzabOmrPuxpoISvRauDS8sbYXb0ydV3jPWw>
    <xme:7Gi_ao0lPrbrcz9axaC8KXmdmdt_hcZGtaa9tmBJzRaZSVSkmzNy8L90XKVNJa5Ie
    vYQH1KMub4uByoAFlL7rQL9JGzmvsPVXIDNWdDcH14PAAFKmPXbya7d>
X-ME-Received: <xmr:7Gi_alEWUc59Y82b2p1mOdSiO_WrrjAuJ7kOinBNQ8OoBubqKebXEgNSjioAONAktsvqUdk5QZ_N>
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
X-ME-Proxy: <xmx:7Gi_aqTHtOsPQz4rJiRCMjZIvD5QHENz91c_2-OeIjaTsHms7deQ6w>
    <xmx:7Gi_akBOq6tmrQ1hzf8BLWfpOKmAF_uzGN6aCghT_eO92jgUhy66Og>
    <xmx:7Gi_ai2-6GQVy3Fy5S6plxJH_wUdVjL_P2b7jo-V2O_FNSGp9DowTQ>
    <xmx:7Gi_aqVwcHjvm5Dc-Nc6_9miryl7vZlCwV811QVrrOvIv4SDMsW1jA>
    <xmx:7Gi_ahZIupplvc_XOjWj68eWhK2LWSxVWRHjd7BBcVYDJHDP_sgD2X2Z>
Feedback-ID: iecfe4abb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 2 Oct 2026 04:18:51 -0400 (EDT)
From: Scott Chacon <scott@gitbutler.net>
To: git@vger.kernel.org
Subject: [RFC PATCH 2/4] tag: add --hash=sha256 to sign a tree-sha256 header
Date: Fri,  2 Oct 2026 10:18:44 +0200
Message-ID: <20261002081846.25144-3-scott@gitbutler.net>
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

Teach "git tag -s" and "git tag -u" a "--hash=sha256" option that
puts the tree-sha256 of the tagged tree in a header after "tagger":

  object <commit>
  type commit
  tag <name>
  tagger <ident>
  tree-sha256 <hex>

Being in the header, it is part of the signed payload, and so the
signature now covers the contents of the tagged tree directly. 

"--hash=sha256" without signing is an error, as there is nothing to
gain from an unsigned digest. It also makes "git tag" create a tag
object, so that it isn't silently dropped when making a lightweight
tag. "--hash=none" is accepted so that a later patch can let it
override a configured default.

---
 Documentation/git-tag.adoc    | 11 ++++-
 builtin/tag.c                 | 29 +++++++++++--
 t/meson.build                 |  1 +
 t/t7032-tree-sha256-signed.sh | 76 +++++++++++++++++++++++++++++++++++
 tree-sha256.c                 |  9 +++++
 tree-sha256.h                 |  6 +++
 6 files changed, 128 insertions(+), 4 deletions(-)
 create mode 100755 t/t7032-tree-sha256-signed.sh

diff --git a/Documentation/git-tag.adoc b/Documentation/git-tag.adoc
index cea3202fdb..8901090a6d 100644
--- a/Documentation/git-tag.adoc
+++ b/Documentation/git-tag.adoc
@@ -9,7 +9,7 @@ git-tag - Create, list, delete or verify tags
 SYNOPSIS
 --------
 [synopsis]
-git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]
+git tag [-a | -s | -u <key-id>] [--hash=<algorithm>] [-f] [-m <msg> | -F <file>] [-e]
 	[(--trailer <token>[(=|:)<value>])...]
 	<tagname> [<commit> | <object>]
 git tag -d <tagname>...
@@ -84,6 +84,15 @@ OPTIONS
 	`gpg.format` configuration variable. See
 	linkgit:git-config[1].
 
+`--hash=<algorithm>`::
+	When signing, add a `tree-sha256` header holding a SHA-256
+	digest of every file in the tagged object's tree, including the
+	contents of checked-out submodules, so that the signature covers
+	the content directly rather than only its SHA-1 object names.
+	_<algorithm>_ is `sha256`, or `none` (the default).
+	Giving `--hash=sha256` without signing is an error. All
+	submodules must be checked out.
+
 `-f`::
 `--force`::
 	Replace an existing tag with the given name (instead of failing)
diff --git a/builtin/tag.c b/builtin/tag.c
index 06c125b53c..9bc4c946d1 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -33,9 +33,10 @@
 #include "write-or-die.h"
 #include "object-file-convert.h"
 #include "trailer.h"
+#include "tree-sha256.h"
 
 static const char * const git_tag_usage[] = {
-	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]\n"
+	N_("git tag [-a | -s | -u <key-id>] [--hash=<algorithm>] [-f] [-m <msg> | -F <file>] [-e]\n"
 	   "        [(--trailer <token>[(=|:)<value>])...]\n"
 	   "        <tagname> [<commit> | <object>]"),
 	N_("git tag -d <tagname>..."),
@@ -281,6 +282,7 @@ struct create_tag_options {
 	unsigned int message_given:1;
 	unsigned int use_editor:1;
 	unsigned int sign;
+	unsigned int tree_hash;
 	enum {
 		CLEANUP_NONE,
 		CLEANUP_SPACE,
@@ -316,11 +318,19 @@ static void create_tag(const struct object_id *object, const char *object_ref,
 		    "object %s\n"
 		    "type %s\n"
 		    "tag %s\n"
-		    "tagger %s\n\n",
+		    "tagger %s\n",
 		    oid_to_hex(object),
 		    type_name(type),
 		    tag,
 		    git_committer_info(IDENT_STRICT));
+	if (opt->sign && opt->tree_hash) {
+		strbuf_addstr(&header, TREE_SHA256_HEADER " ");
+		if (tree_sha256_hex(the_repository, object, &header))
+			die(_("unable to compute %s for %s"),
+			    TREE_SHA256_HEADER, object_ref);
+		strbuf_addch(&header, '\n');
+	}
+	strbuf_addch(&header, '\n');
 
 	should_edit = opt->use_editor || !opt->message_given;
 	if (should_edit || trailer_args->nr) {
@@ -468,6 +478,7 @@ int cmd_tag(int argc,
 	int cmdmode = 0, create_tag_object = 0;
 	char *msgfile = NULL;
 	const char *keyid = NULL;
+	const char *hash_arg = NULL;
 	struct msg_arg msg = { .buf = STRBUF_INIT };
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
@@ -503,6 +514,8 @@ int cmd_tag(int argc,
 			   N_("add custom trailer(s)")),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of tag message")),
 		OPT_BOOL('s', "sign", &opt.sign, N_("annotated and GPG-signed tag")),
+		OPT_STRING(0, "hash", &hash_arg, N_("algorithm"),
+			   N_("sign a tree-sha256 header of the tagged tree (sha256 or none)")),
 		OPT_CLEANUP(&cleanup_arg),
 		OPT_STRING('u', "local-user", &keyid, N_("key-id"),
 					N_("use another key to sign the tag")),
@@ -556,6 +569,14 @@ int cmd_tag(int argc,
 
 	argc = parse_options(argc, argv, prefix, options, git_tag_usage, 0);
 
+	if (hash_arg) {
+		int tree_hash = parse_signing_hash(hash_arg);
+		if (tree_hash < 0)
+			die(_("unsupported --hash value '%s' (use 'sha256' or 'none')"),
+			    hash_arg);
+		opt.tree_hash = tree_hash;
+	}
+
 	if (!cmdmode) {
 		if (argc == 0)
 			cmdmode = 'l';
@@ -579,7 +600,7 @@ int cmd_tag(int argc,
 		set_signing_key(keyid);
 	}
 	create_tag_object = (opt.sign || annotate || msg.given || msgfile ||
-			     edit_flag || trailer_args.nr);
+			     edit_flag || trailer_args.nr || opt.tree_hash);
 
 	if ((create_tag_object || force) && (cmdmode != 0))
 		usage_with_options(git_tag_usage, options);
@@ -683,6 +704,8 @@ int cmd_tag(int argc,
 	if (create_tag_object) {
 		if (force_sign_annotate && !annotate)
 			opt.sign = 1;
+		if (opt.tree_hash && !opt.sign)
+			die(_("--hash=%s requires a signed tag (-s or -u)"), hash_arg);
 		path = repo_git_path(the_repository, "TAG_EDITMSG");
 		create_tag(&object, object_ref, tag, &buf, &opt, &prev, &object,
 			   &trailer_args, path);
diff --git a/t/meson.build b/t/meson.build
index 8ff3dbe69d..ff83368847 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -877,6 +877,7 @@ integration_tests = [
   't7012-skip-worktree-writing.sh',
   't7030-verify-tag.sh',
   't7031-verify-tag-signed-ssh.sh',
+  't7032-tree-sha256-signed.sh',
   't7060-wtstatus.sh',
   't7061-wtstatus-ignore.sh',
   't7062-wtstatus-ignorecase.sh',
diff --git a/t/t7032-tree-sha256-signed.sh b/t/t7032-tree-sha256-signed.sh
new file mode 100755
index 0000000000..083f25e665
--- /dev/null
+++ b/t/t7032-tree-sha256-signed.sh
@@ -0,0 +1,76 @@
+#!/bin/sh
+
+test_description='signed tags and commits with a tree-sha256 header'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+GNUPGHOME_NOT_USED=$GNUPGHOME
+. "$TEST_DIRECTORY/lib-gpg.sh"
+
+# Print the value of the tree-sha256 header of <type> <object>, if any.
+header_of () {
+	git cat-file "$1" "$2" >object &&
+	sed -n "/^$/q; s/^tree-sha256 //p" object
+}
+
+test_expect_success GPGSSH 'setup' '
+	git config --global gpg.format ssh &&
+	git config --global gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
+	git config --global user.signingkey "${GPGSSH_KEY_PRIMARY}" &&
+	mkdir dir &&
+	echo one >dir/file &&
+	echo two >file &&
+	git add dir file &&
+	test_tick &&
+	git commit -m initial &&
+	test-tool tree-sha256 HEAD >expect
+'
+
+test_expect_success GPGSSH 'tag -s --hash=sha256 signs a tree-sha256 header' '
+	git tag -s --hash=sha256 -m release v1 &&
+	header_of tag v1 >actual &&
+	test_cmp expect actual &&
+	sed -n "4,5p" object >lines &&
+	test_grep "^tagger " lines &&
+	test_grep "^tree-sha256 " lines &&
+	git tag -v v1 &&
+	git fsck --strict
+'
+
+test_expect_success GPGSSH 'tag -u --hash=sha256 signs a tree-sha256 header' '
+	git tag -u "${GPGSSH_KEY_PRIMARY}" --hash=sha256 -m release v2 &&
+	header_of tag v2 >actual &&
+	test_cmp expect actual &&
+	git tag -v v2
+'
+
+test_expect_success GPGSSH 'tag -s without --hash has no header' '
+	git tag -s -m release v3 &&
+	header_of tag v3 >actual &&
+	test_must_be_empty actual &&
+	git tag -s --hash=none -m release v4 &&
+	header_of tag v4 >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success GPGSSH 'tag --hash=sha256 requires signing' '
+	test_must_fail git tag --hash=sha256 -m release v5 2>err &&
+	test_grep "requires a signed tag" err &&
+	test_must_fail git tag --hash=sha256 v5 2>err &&
+	test_grep "requires a signed tag" err &&
+	test_must_fail git rev-parse --verify v5
+'
+
+test_expect_success GPGSSH 'tag --hash rejects unknown algorithms' '
+	test_must_fail git tag -s --hash=md5 -m release v5 2>err &&
+	test_grep "unsupported --hash value" err &&
+	test_must_fail git rev-parse --verify v5
+'
+
+test_expect_success GPGSSH 'tag --hash=sha256 needs an object with a tree' '
+	test_must_fail git tag -s --hash=sha256 -m blob v5 HEAD:file &&
+	test_must_fail git rev-parse --verify v5
+'
+
+test_done
diff --git a/tree-sha256.c b/tree-sha256.c
index fb58962232..90f0306521 100644
--- a/tree-sha256.c
+++ b/tree-sha256.c
@@ -236,3 +236,12 @@ int tree_sha256_hex(struct repository *r, const struct object_id *oid,
 	oid_array_clear(&chain);
 	return ret;
 }
+
+int parse_signing_hash(const char *value)
+{
+	if (!strcasecmp(value, "sha256"))
+		return 1;
+	if (!strcasecmp(value, "none"))
+		return 0;
+	return -1;
+}
diff --git a/tree-sha256.h b/tree-sha256.h
index 6d3e5018aa..dc070129ea 100644
--- a/tree-sha256.h
+++ b/tree-sha256.h
@@ -27,4 +27,10 @@ struct strbuf;
 int tree_sha256_hex(struct repository *r, const struct object_id *oid,
 		    struct strbuf *hex);
 
+/*
+ * Parse the value of a --hash=<algorithm> option. Returns 1 for
+ * "sha256", 0 for "none", and -1 for anything else.
+ */
+int parse_signing_hash(const char *value);
+
 #endif /* TREE_SHA256_H */
-- 
2.50.1 (Apple Git-155)

