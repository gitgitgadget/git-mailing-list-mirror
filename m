Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9974253B5F
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 12:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017110; cv=none; b=n5kZoKUKMPmSKuKCxg4RhWOKzAq93HbE4/23vAHuFXCiO95Fh3knBKiZ5d0Wu9sFg6FToKDUFKFBj7vE6/DbdVRnKs7tiQWx6CPRB3cgwZ4s9MHmb4e238p+f8FqH1YStgaBCNDiUdgsy7qyzyGcBOuK30iHMmK9rXSu2hLAVR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017110; c=relaxed/simple;
	bh=iHM3B3ed30+nTRMIP1tN497gYs3a7tyusV+U+Hm/biE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PxN1u3yBsDNhpvDn2buLmT1J/4z4XKQOefvAz9rrne3n+Oucw9Q4TX9P64fywyZ++JyVKWmFpXBQIfSHgjI5ROK7+gFrWFrwMrcUYnckFFjmqKqkw/6TzUKS5tfjX15ZUMW6EPUdaYG6s1/rS2f7JlHKGH3pjYmgPyMIdxDu+Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h9PLlXVg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mXAwPEwx; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h9PLlXVg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mXAwPEwx"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E1F801140245;
	Wed, 30 Apr 2025 08:45:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 30 Apr 2025 08:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746017106;
	 x=1746103506; bh=Em+xSFrzsJOAhrRYVYr9UVL5Lbk50hOEzKPbR1Gi86A=; b=
	h9PLlXVgNHYm/SQcKf7+sj5h/hCvCVcpKd4EsT9jo54tgxN6j4xjinqh5ORFydIu
	HObO4oOkUMhnrAsnJEbQONLKVEBu5jwO33znw1O7TXIq+yHsCgL34f/9mzBWdJEg
	BNsk0ytzZp4kiPxhYl6iH91FJK472dx/bzKIuKSNMnl0CoUsmmP2w4iaqQ4y69BT
	3So5M7wsWIi7S86Z4ejt6VHWz4ijC0oE8XWos9iFcBS5Rhw4SVLoBzWgGmsiUOmh
	bgAa+AWgR/v0gbYS7BWB7FuTZVFhhUOh6KkCERRI9FVn8BYiZYFFceyUNm4YVnyx
	+BGbt7UgB6T1S/3cT86scw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746017106; x=
	1746103506; bh=Em+xSFrzsJOAhrRYVYr9UVL5Lbk50hOEzKPbR1Gi86A=; b=m
	XAwPEwxN1G1KDOcCpO81/kDUQx5clyp9BzWb9oaToqZLRZAz14n8B+gGBe8RVnom
	lA9sTatkMkyEOvvkFJ0LI9Corm5dX4AwgdiDQBd/ZCEKaEVDfAtC3LSW9hdtQTDr
	LcuaufHUqBgPDrRGD1r52M/ltFA6BjAovTcwNEwvp70s+rMxhQyYCexdIYbi5W0v
	l9Q0QxJ5lR4llOiHDGQ9W4iaaRydSaf++xYu7cqDWLfXtjm2fS2TQ8uVxyYIX8Ln
	BDVcaDtV3kje8xt975hU4nZBq3dkJzgvDoo3zi0E+qJ5eDWaOTCa4w7KmoCKeYju
	Nknwc29YtPFSljgVeZWSg==
X-ME-Sender: <xms:UhsSaJguXHxPcElF31ALyKHNIkLrFTYqQ8_Cl7KXjKqxhq5P9rNEOw>
    <xme:UhsSaOCCMtHUpOKowSp6_JMjb2CZ7boys26x7ilDwIPEcJfBIMK2MjmgLWh1FrCyu
    dzOpkA0w0yCB6a9FA>
X-ME-Received: <xmr:UhsSaJFR91HWGoszUzSffa7sZV-CrhrOspRhPiJuAl_74BNHPpRRk3c3fbkZM6P0dpblX4bWzuhZ3wG4QcKiL3oSa2PI9Udu3gi5NfbOiGqGbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieeijeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegtoh
    guvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:UhsSaORsJU5dxpOWZzDg8AJ1xeDk70iEe-xYvI9HzgXJXoqYnX2MeA>
    <xmx:UhsSaGz5Nzx14jJhX_I-bZOv2h3hGi3IfnGrkRd3fmpgwn_0BNez_Q>
    <xmx:UhsSaE7XYgY9MbFbEt07isCw1J-MWc_LWAnX--XHR4m7TxIVyodyXg>
    <xmx:UhsSaLxRCxiTE8w5X_GYV5X5J1-1LFXV9bofVwxBUISiMYYZrhFOnQ>
    <xmx:UhsSaGHGLN4XhzsvpwVsFsdjMQFp-E5y79m7Zz_tXvANPXVuxiR1aqtw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Apr 2025 08:45:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 735b9f33 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 30 Apr 2025 12:45:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 30 Apr 2025 14:44:57 +0200
Subject: [PATCH 1/2] builtin/mv: bail out when trying to move child and its
 parent
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-pks-mv-parent-child-conflict-v1-1-11a87c55ffb9@pks.im>
References: <20250430-pks-mv-parent-child-conflict-v1-0-11a87c55ffb9@pks.im>
In-Reply-To: <20250430-pks-mv-parent-child-conflict-v1-0-11a87c55ffb9@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, 
 Junio C Hamano <gitster@pobox.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

We have a known issue in git-mv(1) where moving both a child and any of
its parents causes an assert to trigger because the child cannot be
found anymore in the index. We have added a test for this in commit
0fcd473fdd3 (t7001: add failure test which triggers assertion,
2024-10-22) without addressing the issue, which is why the test itself
is marked as `test_expect_failure`.

The behaviour of that test relies on a call to assert(3p) though, which
may or may not be compiled into the resulting binary depending on
whether or not we pass `-DNDEBUG`. When these asserts are compiled into
Git this may cause our CI to hang on Windows though, because asserts may
cause a modal window to be shown.

While we could work around the issue by converting this into a call to
`BUG()`, let's rather address the root cause of the issue by bailing out
in case we see that both a child and any of its parents are being moved
in the same command.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/mv.c  | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 t/t7001-mv.sh | 24 +++++++++++++++++++----
 2 files changed, 79 insertions(+), 6 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 54b323fff72..edb854677d9 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -39,6 +39,13 @@ enum update_mode {
 	INDEX = (1 << 2),
 	SPARSE = (1 << 3),
 	SKIP_WORKTREE_DIR = (1 << 4),
+	/*
+	 * A file gets moved implicitly via a move of one of its parent
+	 * directories. This flag causes us to skip the check that we don't try
+	 * to move a file and any of its parent directories at the same point
+	 * in time.
+	 */
+	MOVE_VIA_PARENT_DIR = (1 << 5),
 };
 
 #define DUP_BASENAME 1
@@ -183,6 +190,21 @@ static void remove_empty_src_dirs(const char **src_dir, size_t src_dir_nr)
 	strbuf_release(&a_src_dir);
 }
 
+struct pathmap_entry {
+	struct hashmap_entry ent;
+	const char *path;
+};
+
+static int pathmap_cmp(const void *cmp_data UNUSED,
+		       const struct hashmap_entry *a,
+		       const struct hashmap_entry *b,
+		       const void *key UNUSED)
+{
+	const struct pathmap_entry *e1 = container_of(a, struct pathmap_entry, ent);
+	const struct pathmap_entry *e2 = container_of(b, struct pathmap_entry, ent);
+	return fspathcmp(e1->path, e2->path);
+}
+
 int cmd_mv(int argc,
 	   const char **argv,
 	   const char *prefix,
@@ -213,6 +235,8 @@ int cmd_mv(int argc,
 	struct cache_entry *ce;
 	struct string_list only_match_skip_worktree = STRING_LIST_INIT_DUP;
 	struct string_list dirty_paths = STRING_LIST_INIT_DUP;
+	struct hashmap moved_dirs = HASHMAP_INIT(pathmap_cmp, NULL);
+	struct strbuf pathbuf = STRBUF_INIT;
 	int ret;
 
 	git_config(git_default_config, NULL);
@@ -331,6 +355,7 @@ int cmd_mv(int argc,
 
 dir_check:
 		if (S_ISDIR(st.st_mode)) {
+			struct pathmap_entry *entry;
 			char *dst_with_slash;
 			size_t dst_with_slash_len;
 			int j, n;
@@ -348,6 +373,11 @@ int cmd_mv(int argc,
 				goto act_on_entry;
 			}
 
+			entry = xmalloc(sizeof(*entry));
+			entry->path = src;
+			hashmap_entry_init(&entry->ent, fspathhash(src));
+			hashmap_add(&moved_dirs, &entry->ent);
+
 			/* last - first >= 1 */
 			modes[i] |= WORKING_DIRECTORY;
 
@@ -368,8 +398,7 @@ int cmd_mv(int argc,
 				strvec_push(&sources, path);
 				strvec_push(&destinations, prefixed_path);
 
-				memset(modes + argc + j, 0, sizeof(enum update_mode));
-				modes[argc + j] |= ce_skip_worktree(ce) ? SPARSE : INDEX;
+				modes[argc + j] = MOVE_VIA_PARENT_DIR | (ce_skip_worktree(ce) ? SPARSE : INDEX);
 				submodule_gitfiles[argc + j] = NULL;
 
 				free(prefixed_path);
@@ -465,6 +494,32 @@ int cmd_mv(int argc,
 		}
 	}
 
+	for (i = 0; i < argc; i++) {
+		const char *slash_pos;
+
+		if (modes[i] & MOVE_VIA_PARENT_DIR)
+			continue;
+
+		strbuf_reset(&pathbuf);
+		strbuf_addstr(&pathbuf, sources.v[i]);
+
+		slash_pos = strrchr(pathbuf.buf, '/');
+		while (slash_pos > pathbuf.buf) {
+			struct pathmap_entry needle;
+
+			strbuf_setlen(&pathbuf, slash_pos - pathbuf.buf);
+
+			needle.path = pathbuf.buf;
+			hashmap_entry_init(&needle.ent, fspathhash(pathbuf.buf));
+
+			if (hashmap_get_entry(&moved_dirs, &needle, ent, NULL))
+				die(_("cannot move both '%s' and its parent directory '%s'"),
+				    sources.v[i], pathbuf.buf);
+
+			slash_pos = strrchr(pathbuf.buf, '/');
+		}
+	}
+
 	if (only_match_skip_worktree.nr) {
 		advise_on_updating_sparse_paths(&only_match_skip_worktree);
 		if (!ignore_errors) {
@@ -589,6 +644,8 @@ int cmd_mv(int argc,
 	strvec_clear(&dest_paths);
 	strvec_clear(&destinations);
 	strvec_clear(&submodule_gitfiles_to_free);
+	hashmap_clear_and_free(&moved_dirs, struct pathmap_entry, ent);
+	strbuf_release(&pathbuf);
 	free(submodule_gitfiles);
 	free(modes);
 	return ret;
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 25334b50622..920479e9256 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -550,16 +550,32 @@ test_expect_success 'moving nested submodules' '
 	git status
 '
 
-test_expect_failure 'nonsense mv triggers assertion failure and partially updated index' '
+test_expect_success 'moving file and its parent directory at the same time fails' '
 	test_when_finished git reset --hard HEAD &&
 	git reset --hard HEAD &&
 	mkdir -p a &&
 	mkdir -p b &&
 	>a/a.txt &&
 	git add a/a.txt &&
-	test_must_fail git mv a/a.txt a b &&
-	git status --porcelain >actual &&
-	grep "^A[ ]*a/a.txt$" actual
+	cat >expect <<-EOF &&
+	fatal: cannot move both ${SQ}a/a.txt${SQ} and its parent directory ${SQ}a${SQ}
+	EOF
+	test_must_fail git mv a/a.txt a b 2>err &&
+	test_cmp expect err
+'
+
+test_expect_success 'moving nested directory and its parent directory at the same time fails' '
+	test_when_finished git reset --hard HEAD &&
+	git reset --hard HEAD &&
+	mkdir -p a/b/c &&
+	>a/b/c/file.txt &&
+	git add a &&
+	mkdir target &&
+	cat >expect <<-EOF &&
+	fatal: cannot move both ${SQ}a/b/c${SQ} and its parent directory ${SQ}a${SQ}
+	EOF
+	test_must_fail git mv a/b/c a target 2>err &&
+	test_cmp expect err
 '
 
 test_done

-- 
2.49.0.987.g0cc8ee98dc.dirty

