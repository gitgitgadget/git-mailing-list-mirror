Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893E6443A83
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 08:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790929135; cv=none; b=L9qAuOuEyRIZzhy0NXp6SgNT7dA/oYNbE8GE5RiVfny3TR5ZHiqf9pQLax5W/7fRAugkCtFfPujJPEJepvA6c9Bgu6Czcaz8rtQtJTpty+uYjIFrVFQ3f91wlr18C3yGsaPeaWlDB4H6oR8tCMV7zBMC4VlGSUK1tyUEI/miN0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790929135; c=relaxed/simple;
	bh=UyzGs7kiK7hG2rkDmOOXnwmnfwE0Ooq2Q3Pa5MOdHiY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MX2P7uCogOs7LgcdcJEhMjxONk21QpGLjdLyDVB5PV6JIdqk34uO3drKrEtPh4m1hYQC5zGmKFTOYL1g4WmjqG7y44K1UV+VRJ48AF6CksQOBKOdhiPpnDe20ppcAU8XpN8YJKCHYTmMGQjawsPOZWPiNPHwgiI90tAVCS17DZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gitbutler.net; spf=pass smtp.mailfrom=gitbutler.net; dkim=pass (2048-bit key) header.d=gitbutler.net header.i=@gitbutler.net header.b=CtnTB/3B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r1yY44TN; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gitbutler.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gitbutler.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gitbutler.net header.i=@gitbutler.net header.b="CtnTB/3B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r1yY44TN"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 64FED140003B
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 04:18:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 02 Oct 2026 04:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gitbutler.net;
	 h=cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1790929131; x=
	1791015531; bh=75xNVlGy3lDMMYnNmckQjRlHD3uVJGAav2iwkZlJ6qE=; b=C
	tnTB/3BmbnUZkpHjVXTqq+QV4Gc+HTGFexL81BY4KFNGNlht0U7l9iENNnTspZ/a
	hi9inG2a2baRtgpYdEuhF8gXe6Wiz/k5HdhePI4oVkyaViy9vJYHYosOuynM3AbA
	3RWoTiFHLFKtOkVCiAk4dYY+BuA55i/Ml/6Ql6WDR54220OxhmD2oUlZVE4GYrKG
	Rosiq8RzSiGpTKjX0e6/5Zo2EJhLFUAVhYfMeh4lEpN3Y6AuQW0J3WSqk06ewLSH
	fPjLbcVJgpfq5g/M67YBPbNo9YKwGHKFoIUH9pm7Ug89mOL+DNDAAkdNZpjvUYM/
	gxtb77He58sUvZ4pxezDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1790929131; x=1791015531; bh=75xNVlGy3lDMMYnNmckQjRlHD3uV
	JGAav2iwkZlJ6qE=; b=r1yY44TN/To0i/mE/AgRxQJ/qsicFi23T9gGkkGNpwp3
	tfozM1UYkYJql7mv8MlgvgyMzXTgeXB27Hufxdxz6ar8k5ucWvE6rKgJzxG9IBeq
	S5gXMemxsDfRo51lGy8LKXc0Sr+Q5Y25Oi3cyuiBqcD6BrBhceLShnwehm0gMuaI
	4Yl3Tjey/+t6zgxrFu6XB/WCs9Wm4HVAsw/2T0/Eh7RzfkwwGxyu+tmu0kpY3IaQ
	9bSw/79STYDaSJPel1L+DzP3e/Rt1kfxJlPgOvqis0oDdoSiYmjygmpxNriaQuZI
	UF/2CS2hY+j2i9d4UIwM2DiXiEnFStTMyiuVKNK5Zw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=gitbutler.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790929131; d=gitbutler.net;
	mf=PHNjb3R0QGdpdGJ1dGxlci5uZXQ+;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:jUCQy3DbWPH2+xKQz8t3rw/7SI89cbw08dfrlT8gWTXCpMf
	DO9FyXTDxKxDjXlfVzKTVy6UQ2CThOoHdMmR4y9IQK4tjjJ46NbupxlwC9CSttvz
	BAS+mrRgirtobiTwsKK4CVn8CRxdaoiKyyzfAI16X+qTRMW+AnnHhIyDvMR3R3lD
	PjH2I/BbbUVHD1Hq9teWY6xh3NQ/YtCuKmlS9jbXrZaKHpT+0qGFIv673NQDrmOw
	6JeZPFWUUmceAwCAY5Y9EjsSsZRJwSF8S365sLnfmiHv4PyhnjGiXqSv7/Bv/cjv
	etz/iPoxj/VpUBIwwPapfYGU9PiU4TZkgcDvBzQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:vD3CG0IJik/LytU/QAGiX21T+3ftADh41FEvhnlV4bY=:UyzGs7kiK7hG2rkDmOOXnwmnfwE0Ooq2Q3Pa5MOdHiY=;
X-ME-Sender: <xms:62i_al_0kQPo3mZ7cAExy3OpXKxic3QYCjfTjAqJ9gow9c25IWIWJA>
    <xme:62i_agp75vaVZgBn3mtLR1M_amspbs0j_KD8mF73X2lnYNhet3B1nfMWjl3PaHch5
    TG-lR99Ql1PMbFfcf64Ogv3Lsg32apu2vvgar0UAFYRer2owdqlp9w>
X-ME-Received: <xmr:62i_aorKB8gW96VAdb0rMjtnxRxmqvtIVwdXvea9_yNDFUzaTXZrgAxyF7b6XjT_q-K3GdT1uamD>
X-ME-Proxy-Cause: dmFkZTE5shk5j/0UYNIwyWlth3ODH7voAtHC7B8rxARENPq0+uH2/7WaOTCarlCSBoyvkR
    j0uOuT4M5z2izGu2as1WZ3KXgug2xRcOxwK4DpqnV49yFCuIeQrdlSb56pR9O6JoHAD+S6
    zlnWdTNbpHBl6dg4rL7t1CFh5Jiyv4fbMlw1KxfR9jlqA9bdgO9C8HlmUSUv7z1qxS5PGi
    FwXKIJWgTG8UqQnUixz356vOXp50M4Pe1CS1+kTPYbwZi8RuD7sVNCG2qiIq8fMxAmjdg+
    Rx62ck/l101cS5u19XsQieVVnbxHxKAK306cmCoHajrCI8YM/zvUDkgFHGTTVvJNuTKJuD
    pARzw4W7q+dfGotC9dcMCI3ylxF6xKiajz6dtKN5pBlHMOE9rUZ8Kx7GTz0L1VttWjrBdT
    +84hI+5BWSq2XvMxaaVQbTJQUEPf1t3zLhRgY+bUMY/z+kmKMc34nJkVT3VAgqdED+WYnK
    scaRx6+tGx3wfNsKljkIQMM139QYjEXGEwzLFmlhR6PZx0L4Hxad9pC0UZVzwa5ixSF1rP
    lTsPb5C/m0GdMf2ce5TqADt3LZm4pyLC+FyJFQz5Aa6I+X5B434WWTkfapXk+9ztsfpSjO
    5uoBYkcUwOQoG3dbGQNjRiAAGfpA4AVFKlvdDHEsBf/y7vQafM2RTuTzhsGA
X-ME-Proxy: <xmx:62i_aum59vYlEiY8p8jo61Te_LwQ3Ch0piDxdxTiQgryY8m4e04PvQ>
    <xmx:62i_aqFzBeS90KYZgqNfbcTwrIvnS-epUh7gt_yamXbKiyE1kkaWGQ>
    <xmx:62i_anrOS_RM4hNhPU2IH20iQlsXEzazh_1zsnTEsrQw1HOvK7m0Yw>
    <xmx:62i_am6PP1NUxi1Ev7Jn8XtAf2A5Q_f_gBr4fhnPmnMD6CMSsM4H7w>
    <xmx:62i_aptVoaESB-s3smsSeKH6lW0Ww_B0C6QvTMEGjj5ue4E-yl292rD8>
Feedback-ID: iecfe4abb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 2 Oct 2026 04:18:50 -0400 (EDT)
From: Scott Chacon <scott@gitbutler.net>
To: git@vger.kernel.org
Subject: [RFC PATCH 1/4] tree-sha256: hash the contents of a tree with SHA-256
Date: Fri,  2 Oct 2026 10:18:43 +0200
Message-ID: <20261002081846.25144-2-scott@gitbutler.net>
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

Add a way to compute a SHA-256 digest of the contents of a tree that
doesn't depend on the object format, so that it can be put in the
signed payload. Each blob in the tree, recursively, becomes one record, 
and the digest is SHA-256 over the records sorted by path:

  <hex sha256 of content> SP <path> NUL

A gitlink is followed into the submodule's own repository, and the
tree of the commit it pins is hashed in the same way, giving one record
with a trailing slash on the path:

  <hex digest of submodule tree> SP <path>/ NUL

A path never ends in a slash in a tree, so these can't be confused
with files. If a submodule isn't available, or doesn't have the pinned
commit, we can't say anything about its contents and so fail, listing
every one of them. A submodule that pins a commit already being hashed
above it would be recorded as "cycle:<commit>" instead, which can't
happen without a hash collision but keeps the walk from going around
forever if it does.

The digest can be reproduced with "git ls-tree -r", "git cat-file"
and sha256sum, which is how the new test checks it, through a new
"test-tool tree-sha256". The following patches use it in "git tag"
and "git commit".

---
 Makefile                    |   2 +
 meson.build                 |   1 +
 t/helper/meson.build        |   1 +
 t/helper/test-tool.c        |   1 +
 t/helper/test-tool.h        |   1 +
 t/helper/test-tree-sha256.c |  31 +++++
 t/meson.build               |   1 +
 t/t1018-tree-sha256.sh      | 123 +++++++++++++++++++
 tree-sha256.c               | 238 ++++++++++++++++++++++++++++++++++++
 tree-sha256.h               |  30 +++++
 10 files changed, 429 insertions(+)
 create mode 100644 t/helper/test-tree-sha256.c
 create mode 100755 t/t1018-tree-sha256.sh
 create mode 100644 tree-sha256.c
 create mode 100644 tree-sha256.h

diff --git a/Makefile b/Makefile
index c649c93c51..e042163635 100644
--- a/Makefile
+++ b/Makefile
@@ -878,6 +878,7 @@ TEST_BUILTINS_OBJS += test-submodule.o
 TEST_BUILTINS_OBJS += test-subprocess.o
 TEST_BUILTINS_OBJS += test-synthesize.o
 TEST_BUILTINS_OBJS += test-trace2.o
+TEST_BUILTINS_OBJS += test-tree-sha256.o
 TEST_BUILTINS_OBJS += test-truncate.o
 TEST_BUILTINS_OBJS += test-userdiff.o
 TEST_BUILTINS_OBJS += test-wildmatch.o
@@ -1357,6 +1358,7 @@ LIB_OBJS += trailer.o
 LIB_OBJS += transport-helper.o
 LIB_OBJS += transport.o
 LIB_OBJS += tree-diff.o
+LIB_OBJS += tree-sha256.o
 LIB_OBJS += tree-walk.o
 LIB_OBJS += tree.o
 LIB_OBJS += unpack-trees.o
diff --git a/meson.build b/meson.build
index 0a95d90d21..771e1247f7 100644
--- a/meson.build
+++ b/meson.build
@@ -562,6 +562,7 @@ libgit_sources = [
   'transport-helper.c',
   'transport.c',
   'tree-diff.c',
+  'tree-sha256.c',
   'tree-walk.c',
   'tree.c',
   'unpack-trees.c',
diff --git a/t/helper/meson.build b/t/helper/meson.build
index 3235f10ab8..6f6a4e0a42 100644
--- a/t/helper/meson.build
+++ b/t/helper/meson.build
@@ -72,6 +72,7 @@ test_tool_sources = [
   'test-synthesize.c',
   'test-tool.c',
   'test-trace2.c',
+  'test-tree-sha256.c',
   'test-truncate.c',
   'test-userdiff.c',
   'test-wildmatch.c',
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index b71a22b43b..d3452f7297 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -84,6 +84,7 @@ static struct test_cmd cmds[] = {
 	{ "subprocess", cmd__subprocess },
 	{ "synthesize", cmd__synthesize },
 	{ "trace2", cmd__trace2 },
+	{ "tree-sha256", cmd__tree_sha256 },
 	{ "truncate", cmd__truncate },
 	{ "userdiff", cmd__userdiff },
 	{ "xml-encode", cmd__xml_encode },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index f2885b33d5..410d71f6a9 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -77,6 +77,7 @@ int cmd__submodule_nested_repo_config(int argc, const char **argv);
 int cmd__subprocess(int argc, const char **argv);
 int cmd__synthesize(int argc, const char **argv);
 int cmd__trace2(int argc, const char **argv);
+int cmd__tree_sha256(int argc, const char **argv);
 int cmd__truncate(int argc, const char **argv);
 int cmd__userdiff(int argc, const char **argv);
 int cmd__xml_encode(int argc, const char **argv);
diff --git a/t/helper/test-tree-sha256.c b/t/helper/test-tree-sha256.c
new file mode 100644
index 0000000000..d3fca5c0b7
--- /dev/null
+++ b/t/helper/test-tree-sha256.c
@@ -0,0 +1,31 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
+#include "test-tool.h"
+#include "git-compat-util.h"
+#include "hash.h"
+#include "object-name.h"
+#include "repository.h"
+#include "setup.h"
+#include "strbuf.h"
+#include "tree-sha256.h"
+
+int cmd__tree_sha256(int argc, const char **argv)
+{
+	struct object_id oid;
+	struct strbuf hex = STRBUF_INIT;
+	int ret = 0;
+
+	setup_git_directory(the_repository);
+	if (argc != 2)
+		die("usage: test-tool tree-sha256 <tree-ish>");
+	if (repo_get_oid(the_repository, argv[1], &oid))
+		die("not a valid object name: %s", argv[1]);
+
+	if (tree_sha256_hex(the_repository, &oid, &hex))
+		ret = 1;
+	else
+		puts(hex.buf);
+
+	strbuf_release(&hex);
+	return ret;
+}
diff --git a/t/meson.build b/t/meson.build
index 3ca7b27104..8ff3dbe69d 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -172,6 +172,7 @@ integration_tests = [
   't1015-read-index-unmerged.sh',
   't1016-compatObjectFormat.sh',
   't1017-cat-file-remote-object-info.sh',
+  't1018-tree-sha256.sh',
   't1020-subdirectory.sh',
   't1022-read-tree-partial-clone.sh',
   't1050-large.sh',
diff --git a/t/t1018-tree-sha256.sh b/t/t1018-tree-sha256.sh
new file mode 100755
index 0000000000..ff2edd159e
--- /dev/null
+++ b/t/t1018-tree-sha256.sh
@@ -0,0 +1,123 @@
+#!/bin/sh
+
+test_description='SHA-256 digest of the contents of a tree'
+
+. ./test-lib.sh
+
+# Recompute the tree-sha256 of <rev> in repository <dir> by hand: one
+# "<sha256 of content> <path>" record per file and "<digest> <path>/"
+# per submodule, sorted by path, NUL-terminated and hashed together.
+expect_tree_sha256 () {
+	git -C "$1" ls-tree -r --format="%(objectmode) %(objectname) %(path)" "$2" |
+	while read mode oid path
+	do
+		case "$mode" in
+		160000)
+			printf "%s %s/\n" "$(expect_tree_sha256 "$1/$path" "$oid")" "$path" ;;
+		*)
+			printf "%s %s\n" "$(git -C "$1" cat-file blob "$oid" |
+					    test-tool sha256)" "$path" ;;
+		esac
+	done |
+	LC_ALL=C sort -t " " -k2 |
+	tr "\n" "\000" |
+	test-tool sha256
+}
+
+test_expect_success 'setup' '
+	git config --global protocol.file.allow always &&
+
+	git init inner &&
+	test_commit -C inner inner-file &&
+	git init sub &&
+	test_commit -C sub sub-file &&
+	git -C sub submodule add ../inner inner &&
+	git -C sub commit -m "add inner" &&
+
+	mkdir -p a/deeper &&
+	echo one >a/deeper/file &&
+	echo two >a.b &&
+	echo exe >exe &&
+	git add a a.b exe &&
+	test_ln_s_add a.b link &&
+	git commit -m initial
+'
+
+test_expect_success 'digest of files, directories and symlinks' '
+	expect_tree_sha256 . HEAD >expect &&
+	test-tool tree-sha256 HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'commits, tags and trees give the same digest' '
+	git tag -a -m tag v1 &&
+	test-tool tree-sha256 v1 >tag &&
+	test-tool tree-sha256 HEAD^{tree} >tree &&
+	test_cmp expect tag &&
+	test_cmp expect tree
+'
+
+test_expect_success 'file mode is not part of the digest' '
+	test_chmod +x exe &&
+	git commit -m executable &&
+	test-tool tree-sha256 HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'content and paths are' '
+	echo changed >a/deeper/file &&
+	git commit -a -m changed &&
+	test-tool tree-sha256 HEAD >changed &&
+	! test_cmp expect changed &&
+
+	git mv a.b a.c &&
+	git commit -m renamed &&
+	test-tool tree-sha256 HEAD >renamed &&
+	! test_cmp changed renamed
+'
+
+test_expect_success 'submodules are hashed recursively' '
+	git submodule add ./sub sub &&
+	git submodule update --init --recursive &&
+	git commit -m "add sub" &&
+	expect_tree_sha256 . HEAD >expect &&
+	test-tool tree-sha256 HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'submodule contents are part of the digest' '
+	test_commit -C sub/inner more &&
+	git -C sub commit -a -m "update inner" &&
+	git commit -a -m "update sub" &&
+	test-tool tree-sha256 HEAD >updated &&
+	! test_cmp expect updated &&
+	expect_tree_sha256 . HEAD >expect &&
+	test_cmp expect updated
+'
+
+test_expect_success 'submodules are read from their gitdir without a worktree' '
+	mv sub/inner inner.away &&
+	test_when_finished "mv inner.away sub/inner" &&
+	test-tool tree-sha256 HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'unavailable submodules are an error' '
+	mv sub/inner inner.away &&
+	mv sub/.git/modules/inner inner.git.away &&
+	test_when_finished "mv inner.away sub/inner && mv inner.git.away sub/.git/modules/inner" &&
+	test_must_fail test-tool tree-sha256 HEAD 2>err &&
+	test_grep "sub/inner (not checked out)" err
+'
+
+test_expect_success 'submodule missing the pinned commit is an error' '
+	tree=$(printf "160000 commit %s\tinner\n" $(test_oid deadbeef) |
+	       git -C sub mktree) &&
+	(
+		cd sub &&
+		test_must_fail test-tool tree-sha256 $tree 2>err &&
+		test_grep "inner (checked out, but missing commit $(test_oid deadbeef))" err
+	)
+'
+
+test_done
diff --git a/tree-sha256.c b/tree-sha256.c
new file mode 100644
index 0000000000..fb58962232
--- /dev/null
+++ b/tree-sha256.c
@@ -0,0 +1,238 @@
+#include "git-compat-util.h"
+#include "tree-sha256.h"
+#include "commit.h"
+#include "gettext.h"
+#include "hash.h"
+#include "hex.h"
+#include "object.h"
+#include "odb.h"
+#include "oid-array.h"
+#include "pathspec.h"
+#include "repository.h"
+#include "string-list.h"
+#include "strbuf.h"
+#include "tree.h"
+
+struct record {
+	char *path; /* submodules carry a trailing '/' */
+	struct object_id oid;
+	unsigned submodule:1;
+};
+
+struct collect {
+	struct record *items;
+	size_t nr, alloc;
+};
+
+struct walk {
+	/* "<path> (<reason>)" for each submodule that can't be hashed */
+	struct string_list missing;
+};
+
+static int collect_entry(const struct object_id *oid, struct strbuf *base,
+			 const char *pathname, unsigned mode, void *context)
+{
+	struct collect *c = context;
+	struct record *rec;
+
+	if (S_ISDIR(mode))
+		return READ_TREE_RECURSIVE;
+
+	ALLOC_GROW(c->items, c->nr + 1, c->alloc);
+	rec = &c->items[c->nr++];
+	oidcpy(&rec->oid, oid);
+	rec->submodule = S_ISGITLINK(mode);
+	rec->path = xstrfmt("%.*s%s%s", (int)base->len, base->buf, pathname,
+			    rec->submodule ? "/" : "");
+	return 0;
+}
+
+static int record_cmp(const void *a_, const void *b_)
+{
+	const struct record *a = a_, *b = b_;
+	return strcmp(a->path, b->path);
+}
+
+static int hash_tree(struct repository *r, const struct object_id *oid,
+		     const char *prefix, struct oid_array *chain,
+		     struct walk *walk, unsigned char *digest);
+
+static int in_chain(const struct oid_array *chain, const struct object_id *oid)
+{
+	for (size_t i = 0; i < chain->nr; i++)
+		if (oideq(&chain->oid[i], oid))
+			return 1;
+	return 0;
+}
+
+/*
+ * Hash the submodule of "r" at "path", pinned at "commit", and append
+ * its digest in hex to "out". "treeish" is the tree "path" was found
+ * in, which is where .gitmodules is read from if the submodule's
+ * gitdir isn't at "path". "full" is the path from the top repository,
+ * for messages.
+ *
+ * Returns 1 if the submodule is unavailable (recording why in
+ * walk->missing), -1 on other errors and 0 on success.
+ */
+static int hash_submodule(struct repository *r, const struct object_id *treeish,
+			  const char *path, const char *full,
+			  const struct object_id *commit,
+			  struct oid_array *chain, struct walk *walk,
+			  struct strbuf *out)
+{
+	const struct git_hash_algo *sha256 = &hash_algos[GIT_HASH_SHA256];
+	unsigned char digest[GIT_MAX_RAWSZ];
+	struct repository sub;
+	struct strbuf sub_prefix = STRBUF_INIT;
+	int ret;
+
+	if (repo_submodule_init(&sub, r, path, treeish)) {
+		string_list_append_nodup(&walk->missing, xstrfmt("%s (%s)", full,
+				    _("not checked out")));
+		return 1;
+	}
+	if (!odb_has_object(sub.objects, commit, 0)) {
+		string_list_append_nodup(&walk->missing, xstrfmt("%s (%s %s)", full,
+				    _("checked out, but missing commit"),
+				    oid_to_hex(commit)));
+		repo_clear(&sub);
+		return 1;
+	}
+
+	strbuf_addf(&sub_prefix, "%s/", full);
+	oid_array_append(chain, commit);
+	ret = hash_tree(&sub, commit, sub_prefix.buf, chain, walk, digest);
+	chain->nr--;
+	if (!ret)
+		strbuf_addstr(out, hash_to_hex_algop(digest, sha256));
+
+	strbuf_release(&sub_prefix);
+	repo_clear(&sub);
+	return ret;
+}
+
+/*
+ * Hash one tree of repository "r". "prefix" is the path of "r" from the
+ * top repository (empty, or ending in '/'), and "chain" holds the
+ * commits of the submodules being hashed above this one.
+ */
+static int hash_tree(struct repository *r, const struct object_id *oid,
+		     const char *prefix, struct oid_array *chain,
+		     struct walk *walk, unsigned char *digest)
+{
+	const struct git_hash_algo *sha256 = &hash_algos[GIT_HASH_SHA256];
+	struct git_hash_ctx outer;
+	struct collect c = { 0 };
+	struct pathspec pathspec = { 0 };
+	struct strbuf value = STRBUF_INIT;
+	struct tree *tree;
+	int ret = 0;
+
+	tree = repo_parse_tree_indirect(r, oid);
+	if (!tree)
+		return error(_("unable to read tree for %s in %s"),
+			     oid_to_hex(oid), *prefix ? prefix : ".");
+	if (read_tree(r, tree, &pathspec, collect_entry, &c))
+		return error(_("unable to read tree %s"),
+			     oid_to_hex(&tree->object.oid));
+	QSORT(c.items, c.nr, record_cmp);
+
+	git_hash_init(&outer, sha256);
+	for (size_t i = 0; i < c.nr; i++) {
+		struct record *rec = &c.items[i];
+
+		strbuf_reset(&value);
+		if (!rec->submodule) {
+			struct git_hash_ctx ctx;
+			unsigned char blob_digest[GIT_MAX_RAWSZ];
+			enum object_type type;
+			size_t size;
+			void *data;
+
+			data = odb_read_object(r->objects, &rec->oid, &type, &size);
+			if (!data || type != OBJ_BLOB) {
+				free(data);
+				ret = error(_("unable to read blob %s for %s%s"),
+					    oid_to_hex(&rec->oid), prefix, rec->path);
+				break;
+			}
+			git_hash_init(&ctx, sha256);
+			git_hash_update(&ctx, data, size);
+			git_hash_final(blob_digest, &ctx);
+			free(data);
+			strbuf_addstr(&value, hash_to_hex_algop(blob_digest, sha256));
+		} else if (in_chain(chain, &rec->oid)) {
+			/*
+			 * A commit can't contain itself without a hash
+			 * collision, but don't rely on that to stop.
+			 */
+			strbuf_addf(&value, "cycle:%s", oid_to_hex(&rec->oid));
+		} else {
+			char *path = xstrndup(rec->path, strlen(rec->path) - 1);
+			char *full = xstrfmt("%s%s", prefix, path);
+			int res = hash_submodule(r, &tree->object.oid, path, full, &rec->oid,
+						 chain, walk, &value);
+			free(path);
+			free(full);
+			if (res < 0) {
+				ret = -1;
+				break;
+			}
+		}
+
+		git_hash_update(&outer, value.buf, value.len);
+		git_hash_update(&outer, " ", 1);
+		git_hash_update(&outer, rec->path, strlen(rec->path));
+		git_hash_update(&outer, "", 1);
+	}
+	git_hash_final(digest, &outer);
+
+	for (size_t i = 0; i < c.nr; i++)
+		free(c.items[i].path);
+	free(c.items);
+	strbuf_release(&value);
+	return ret;
+}
+
+int tree_sha256_hex(struct repository *r, const struct object_id *oid,
+		    struct strbuf *hex)
+{
+	const struct git_hash_algo *sha256 = &hash_algos[GIT_HASH_SHA256];
+	unsigned char digest[GIT_MAX_RAWSZ];
+	struct walk walk = { .missing = STRING_LIST_INIT_DUP };
+	struct oid_array chain = OID_ARRAY_INIT;
+	struct commit *top;
+	struct tree *tree;
+	int ret;
+
+	tree = repo_parse_tree_indirect(r, oid);
+	if (!tree)
+		return error(_("cannot compute %s: %s does not point to a tree"),
+			     TREE_SHA256_HEADER, oid_to_hex(oid));
+
+	top = lookup_commit_reference_gently(r, oid, 1);
+	if (top)
+		oid_array_append(&chain, &top->object.oid);
+
+	ret = hash_tree(r, &tree->object.oid, "", &chain, &walk, digest);
+
+	if (!ret && walk.missing.nr) {
+		struct strbuf list = STRBUF_INIT;
+
+		string_list_sort(&walk.missing);
+		for (size_t i = 0; i < walk.missing.nr; i++)
+			strbuf_addf(&list, "\n  %s", walk.missing.items[i].string);
+		ret = error(_("%"PRIuMAX" submodule(s) are not available, and "
+			      "a %s can't be computed without their tree hashes:%s\n"
+			      "Check them out with `git submodule update --init --recursive`."),
+			    (uintmax_t)walk.missing.nr, TREE_SHA256_HEADER, list.buf);
+		strbuf_release(&list);
+	}
+	if (!ret)
+		strbuf_addstr(hex, hash_to_hex_algop(digest, sha256));
+
+	string_list_clear(&walk.missing, 0);
+	oid_array_clear(&chain);
+	return ret;
+}
diff --git a/tree-sha256.h b/tree-sha256.h
new file mode 100644
index 0000000000..6d3e5018aa
--- /dev/null
+++ b/tree-sha256.h
@@ -0,0 +1,30 @@
+#ifndef TREE_SHA256_H
+#define TREE_SHA256_H
+
+struct repository;
+struct object_id;
+struct strbuf;
+
+/* The header that carries the digest in signed commits and tags. */
+#define TREE_SHA256_HEADER "tree-sha256"
+
+/*
+ * Compute the tree-sha256 of the tree reachable from "oid" (a tree,
+ * commit or tag) and append it to "hex" as 64 lowercase hex digits.
+ *
+ * Every blob and symlink in the tree, recursively, contributes one
+ * record "<hex sha256 of content> SP <path> NUL". Every submodule
+ * contributes "<hex tree-sha256 of submodule> SP <path>/ NUL", hashed
+ * from the checked-out submodule's own repository at the commit the
+ * superproject pins; a submodule whose commit is already being hashed
+ * further up the chain is recorded as "cycle:<commit> SP <path>/ NUL".
+ * Records are sorted by path (byte order) and the digest is SHA-256
+ * over their concatenation.
+ *
+ * Returns 0 on success. On failure (for example a submodule that is
+ * not checked out) reports every problem with error() and returns -1.
+ */
+int tree_sha256_hex(struct repository *r, const struct object_id *oid,
+		    struct strbuf *hex);
+
+#endif /* TREE_SHA256_H */
-- 
2.50.1 (Apple Git-155)

