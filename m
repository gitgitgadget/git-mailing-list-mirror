Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBC919D8BE
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 13:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732886032; cv=none; b=EIjEJEnSoNVHLxc+7bk/b5rGDBk8uOYrPFp8a6C+NGz4U9JcEIC0CHd8hYuIESSoCsMJ5eudeRdbvt+Mtzq46Z4tyAO9wRfYHUHULlWE7+kXa1LsVj/8tPsKWhMgJyY2NsgeJxv7WjE0Z+WP/a1FpMZWEQww3QY3l9qsLFWVDrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732886032; c=relaxed/simple;
	bh=sbNKyryqz3UjtQ4qbcBliE+0H/c2VUZ8lObH6AEZwQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jFQPppVG0U4zyTTg7fa7nAoKcJkYJTX2WBxx0d3q1JnQd45NeUmeJFcm+ic068M4qZthyoXOiby03uIGKHeRjeY6FRzyyPvlt9wic5T+ry+rMYZymWd4511fxikjB6Syb8etDXhQux9//wBBDXSsrqLTvmALp7iaqVPQfP/CzW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OfrtCCow; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4k+fRumV; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OfrtCCow";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4k+fRumV"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 03951254007C
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 08:13:49 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 29 Nov 2024 08:13:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732886029;
	 x=1732972429; bh=zKli0sQIAEYkB+EkZt1ex34nr/Xpsik1IINkNlEsR5I=; b=
	OfrtCCowM6ran1jL96Vz03lrOAOGXpgViMwR7xWsv6Jr06nMDtuXOQbq3N/uLizx
	mxjy1jPVTKsZw1hgaDjnp3vjU2M+/2BhbZ6LCen6WQPycNIw1zOVnEmK7oPPQ+CW
	+0QjRCZpVpHPMUsnL6b9Nvdt/ATxaCrUAnmgiXIazhz/0a7lncJFjAt0uSIiUcwQ
	z9k3ZTw7n+lbwUF4e9iVmju6ojlKae6sISUbhLP+9xgUma8Y0g7eezKes5qaIkJS
	J9G4e5DcCbY2fMfXM6ezrGBn7syPJ+hi8lI0Tq3t415Lk/l8dmH1W89wuqKsOYLb
	fggfpYZ6/u0kZdKLInO1ZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732886029; x=
	1732972429; bh=zKli0sQIAEYkB+EkZt1ex34nr/Xpsik1IINkNlEsR5I=; b=4
	k+fRumV/wAGtasKk4YTyY1KwOd2UGfhWrNFLH/0nOhiPOlBU0NqpbCUkCdRcuZbt
	n/ttDDGurdXASJ3WWCsHbrHbW8Uvd82KJd712+9E7wt6TQE8wtmKsRgM8u83V2BB
	wh7M8w9a9aoYaLCDMi/IgzfiQu1o9Owul8THZzW+p+hwsqsgp51QtgUrETLzQUJC
	Od0xA2HS86vj3w47flhD72ZHxITacxAXbzW7nS69a5ZYy/6kv7QZCWETdmVYLoTk
	5YUAfWEpF4oZBK2AdWp/mHIvNRt9DZc7Wakh+TeCqyC10/75i0NG3tVlZ2hGnoU8
	uUb4rio2JdiEJiNMkD2hA==
X-ME-Sender: <xms:Db5JZ5-ENmwwf0rmHUL6FjNAppEVuXgChPpGXmklx2BkrZnLNQMrHA>
    <xme:Db5JZ9tt53ooyRpZ7Q_9D3cfv7QuII50cOuvqkfRsZv2OC_nT-d7goHEvhoXnl6Vs
    DT638oKaqyz9LH1eg>
X-ME-Received: <xmr:Db5JZ3DggGjxu55JkLkKF4zBcGCTgZwPv7YKCAuKEcGypNVnKuJ7_VDslPsfewpGjYVABXTZPSdAHA2MtiSLj47bCcCKMyj9vmrJoLZxp8DwDZv-bg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheefgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelhe
    efjeektdffhedvhfdvteefgfdtudffudevveetgeeuuedtkefhgeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Db5JZ9ebp5SiiP-QsfkJSRpkUXLohdefABQyayDRjVDm1KoEiM3LEw>
    <xmx:Db5JZ-NI2DngMInNBOSQkaUB9j1qdZjGnFNmdGctqDTuyPxDCT56TQ>
    <xmx:Db5JZ_mWvX7qi9k34rR9IDP8HBYp3-xbDS2CeP7iYwac4QmmWc7iGg>
    <xmx:Db5JZ4uPhtqtpTMgYto_S9-CHEsbSd2EphaGpilaf_xgvlWvLL5QkQ>
    <xmx:Db5JZw2rz23osHa5uLI844a2pU4NknQVPOjy8dXxHBTkg5lmMNTa4XZ7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 29 Nov 2024 08:13:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4aec0169 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 29 Nov 2024 13:12:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 29 Nov 2024 14:13:27 +0100
Subject: [PATCH 06/10] global: fix unsigned integer promotions in ternary
 statements
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241129-pks-sign-compare-v1-6-fc406b984bc9@pks.im>
References: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
In-Reply-To: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

We have several cases in our codebase where the ternary operator changes
signedness from a signed integer type to an unsigned one. This causes
warnings with `-Wsign-compare`. Generally, we seem to have three classes
of this in our codebase:

  - Cases where we know that the result is well-formed, e.g. when
    indexing into strings to determine the length of substrings.

  - Cases where we want `-1` to mean "unlimited", counting on the
    wrap-around.

  - Cases where we may indeed run into problems when one of the
    statements returns a value that is too big.

Out of these only the last class is a bit worrying, but we can address
it by adding a call to `cast_size_t_to_int()`. Like this we're better
protected in case we have unexpectedly huge input as we'd die instead of
silently doing the wrong thing.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/blame.c           | 3 ++-
 builtin/patch-id.c        | 2 +-
 dir.c                     | 4 ++--
 gettext.c                 | 4 +---
 gpg-interface.c           | 2 +-
 scalar.c                  | 2 +-
 strbuf.c                  | 2 +-
 t/helper/test-csprng.c    | 4 +---
 t/helper/test-genrandom.c | 4 +---
 9 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index f0d209791e44025b1965cd447cf4fc1e2ca5f009..6c6b0c7ef1a4d992064c7664bbf1229ef0286b97 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -470,7 +470,8 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 
 	for (cnt = 0; cnt < ent->num_lines; cnt++) {
 		char ch;
-		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? the_hash_algo->hexsz : abbrev;
+		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ?
+			cast_size_t_to_int(the_hash_algo->hexsz) : abbrev;
 
 		if (opt & OUTPUT_COLOR_LINE) {
 			if (cnt > 0) {
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 56585757477911c96bbb9ef2cf3710691b8e744e..87fa586c4d552ba61cd2ac2cf079d68241eb3275 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -163,7 +163,7 @@ static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
 			after--;
 
 		/* Add line to hash algo (possibly removing whitespace) */
-		len = verbatim ? strlen(line) : remove_space(line);
+		len = verbatim ? cast_size_t_to_int(strlen(line)) : remove_space(line);
 		patchlen += len;
 		the_hash_algo->update_fn(&ctx, line, len);
 	}
diff --git a/dir.c b/dir.c
index 5b2181e5899ce951791aa5e46ccdbb2d71ce6144..fc77ffe56c9d8353d918553223f5521fa3bc3a94 100644
--- a/dir.c
+++ b/dir.c
@@ -1643,7 +1643,7 @@ static void prep_exclude(struct dir_struct *dir,
 		strbuf_init(&dir->internal.basebuf, PATH_MAX);
 
 	/* Read from the parent directories and push them down. */
-	current = stk ? stk->baselen : -1;
+	current = stk ? cast_size_t_to_int(stk->baselen) : -1;
 	strbuf_setlen(&dir->internal.basebuf, current < 0 ? 0 : current);
 	if (dir->untracked)
 		untracked = stk ? stk->ucd : dir->untracked->root;
@@ -2896,7 +2896,7 @@ static void new_untracked_cache(struct index_state *istate, int flags)
 	struct untracked_cache *uc = xcalloc(1, sizeof(*uc));
 	strbuf_init(&uc->ident, 100);
 	uc->exclude_per_dir = ".gitignore";
-	uc->dir_flags = flags >= 0 ? flags : new_untracked_cache_flags(istate);
+	uc->dir_flags = flags >= 0 ? (unsigned) flags : new_untracked_cache_flags(istate);
 	set_untracked_ident(uc);
 	istate->untracked = uc;
 	istate->cache_changed |= UNTRACKED_CHANGED;
diff --git a/gettext.c b/gettext.c
index 8d08a61f8487dc30559e5e5d6d31cf06a92789e1..ecb0c70c1144ce8b4280b78a2b443138e8af6603 100644
--- a/gettext.c
+++ b/gettext.c
@@ -2,8 +2,6 @@
  * Copyright (c) 2010 Ævar Arnfjörð Bjarmason
  */
 
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "environment.h"
@@ -135,7 +133,7 @@ int gettext_width(const char *s)
 	if (is_utf8 == -1)
 		is_utf8 = is_utf8_locale();
 
-	return is_utf8 ? utf8_strwidth(s) : strlen(s);
+	return is_utf8 ? utf8_strwidth(s) : cast_size_t_to_int(strlen(s));
 }
 #endif
 
diff --git a/gpg-interface.c b/gpg-interface.c
index a67d80475bf9d8452de0c3ae9bb08ceeb4c11c4b..e1720361f17e8b3b3315f0a5d93a827e11b2b036 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -700,7 +700,7 @@ size_t parse_signed_buffer(const char *buf, size_t size)
 			match = len;
 
 		eol = memchr(buf + len, '\n', size - len);
-		len += eol ? eol - (buf + len) + 1 : size - len;
+		len += eol ? (size_t) (eol - (buf + len) + 1) : size - len;
 	}
 	return match;
 }
diff --git a/scalar.c b/scalar.c
index 87bb30991bf768534a988608d9b194dc8b5ba78a..ce18fab07c08be715142379fd9d757e96c554fbb 100644
--- a/scalar.c
+++ b/scalar.c
@@ -380,7 +380,7 @@ static int delete_enlistment(struct strbuf *enlistment)
 	offset = offset_1st_component(enlistment->buf);
 	path_sep = find_last_dir_sep(enlistment->buf + offset);
 	strbuf_add(&parent, enlistment->buf,
-		   path_sep ? path_sep - enlistment->buf : offset);
+		   path_sep ? (size_t) (path_sep - enlistment->buf) : offset);
 	if (chdir(parent.buf) < 0) {
 		int res = error_errno(_("could not switch to '%s'"), parent.buf);
 		strbuf_release(&parent);
diff --git a/strbuf.c b/strbuf.c
index 8ddd4b06c595ac3f8b38a65d3e1ca4b340fddf9f..8c027a67942a72b9078c7f6e144c883c76d461d4 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1055,7 +1055,7 @@ void strbuf_stripspace(struct strbuf *sb, const char *comment_prefix)
 
 	for (i = j = 0; i < sb->len; i += len, j += newlen) {
 		eol = memchr(sb->buf + i, '\n', sb->len - i);
-		len = eol ? eol - (sb->buf + i) + 1 : sb->len - i;
+		len = eol ? (size_t) (eol - (sb->buf + i) + 1) : sb->len - i;
 
 		if (comment_prefix && len &&
 		    starts_with(sb->buf + i, comment_prefix)) {
diff --git a/t/helper/test-csprng.c b/t/helper/test-csprng.c
index ea9b9b656307d32bdc1f2e15a91793b1dda9c463..31dbe7db4ac61639541f15d262cea64368fec78f 100644
--- a/t/helper/test-csprng.c
+++ b/t/helper/test-csprng.c
@@ -1,5 +1,3 @@
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "test-tool.h"
 #include "git-compat-util.h"
 
@@ -14,7 +12,7 @@ int cmd__csprng(int argc, const char **argv)
 		return 2;
 	}
 
-	count = (argc == 2) ? strtoul(argv[1], NULL, 0) : -1L;
+	count = (argc == 2) ? strtoul(argv[1], NULL, 0) : (unsigned long) -1L;
 
 	while (count) {
 		unsigned long chunk = count < sizeof(buf) ? count : sizeof(buf);
diff --git a/t/helper/test-genrandom.c b/t/helper/test-genrandom.c
index 5b51e6648d8e698b09f400efcf67a0708c226e9d..efca20e7efff46bf66c2b8888ce88db02e545cd5 100644
--- a/t/helper/test-genrandom.c
+++ b/t/helper/test-genrandom.c
@@ -4,8 +4,6 @@
  * Copyright (C) 2007 by Nicolas Pitre, licensed under the GPL version 2.
  */
 
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "test-tool.h"
 #include "git-compat-util.h"
 
@@ -24,7 +22,7 @@ int cmd__genrandom(int argc, const char **argv)
 		next = next * 11 + *c;
 	} while (*c++);
 
-	count = (argc == 3) ? strtoul(argv[2], NULL, 0) : -1L;
+	count = (argc == 3) ? strtoul(argv[2], NULL, 0) : (unsigned long) -1L;
 
 	while (count--) {
 		next = next * 1103515245 + 12345;

-- 
2.47.0.366.g5daf58cba8.dirty

