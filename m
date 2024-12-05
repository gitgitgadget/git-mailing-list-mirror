Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106381D63EE
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 09:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733391421; cv=none; b=IbSe3Do1i2mHILr/6zssZ7/cxhqwQGfpUShSBquBbgVjTDYobzNAp3eMse5Yj9A6KWO4IHnY57FwMGXErPSl+hDqyKxzAgd48jQmN6usafEiPpPuwdIl0UlmTWtvT/AAsk1AkFhzUx3BxnHKOhXOPf43gf2sWblIOQCQXFH+dZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733391421; c=relaxed/simple;
	bh=Rp1V85zkACb5kitxQsHE6VJbbbXeaLSy7gx6e4xwJWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ekoL7VntEhmif9Hzyegu6xN8SU/A2drF2ZsMO7rgrzIatZOrKkEqLEme9cPCGWdRbw4dHSLpU0jTNRPBIRleCK9Vl2gxw0udauU8kNmf+XCPNLYhdJ3RHMl5E8kZZHnZZDGAuUq9AgD9kVparitdKaDcQilHL8gXRrOcG4t4GGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Acy44v0L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SVw6wuF1; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Acy44v0L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SVw6wuF1"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailflow.phl.internal (Postfix) with ESMTP id 21FF42005BD;
	Thu,  5 Dec 2024 04:36:56 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 05 Dec 2024 04:36:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733391416;
	 x=1733398616; bh=vCyNMnJobNpeTWZuITUhMHyY1ZUbabrEXybYI5D4XAE=; b=
	Acy44v0LjS6y7QfsrABw0EDwIEUQTtfblw98uIphIh97iHF9AIDk0yWim0ABcY4G
	XVPvZaBuaF2enq4ax0J0CS6ki9DhFQvvXLwYi/wFBH79c3B2Z0yDbefXFrR+XxRM
	sSl0WxXCWJ3wRHxzRggkRaCghrePpj/54tkPgGxvQtjlF+ep0ZoY26l5+ce4RN30
	Wa5w8JuvlkGS+/JOCafwmsI6Au3LtNDqJpMQ8MkIDrbfeEVyQn2+CNTAW6SV+T38
	roye43pl2BTcsuj8/UxyiywMHxulCnUxO2u3wE0nREHFKMV0uBbSX1V+ZAN/TNSy
	qK70r7kSh/Q0nU1YsidOxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733391416; x=
	1733398616; bh=vCyNMnJobNpeTWZuITUhMHyY1ZUbabrEXybYI5D4XAE=; b=S
	Vw6wuF1SyJbLKkVqwL0KW0kTwS+4bQ/GRwoEGPstjGfUFWImZYvym2wSu5dXht5d
	VGUqlKmaXAsKaHvp36q4XDm0OMnsRtF8jhm/RrNTLeexq04zycCLk13V8MwyBzDl
	DignqwcsgCGJB59bHAsEF8Z3ismKTNOb2FlFaaN533ekfbU1jlbNp7h8uu84rgyt
	GJ2g6vkQobHfLkOzjPZKKe7igkwhb8JOpbhc7lwBVckzmXMkQI9Xm9KGAsi5K59A
	NQ+fhzIsH0bBZ3lK5P+ln8YCToXGWeU8Aa4DQyVnL/6vDumI5wZCqbAtOTXmWM9k
	2mioLDWSFa4CuTS4qr6sQ==
X-ME-Sender: <xms:N3RRZyrW46Do-rISABwejCHSrXvwbXfnxV8pYgo2mAZNWKM3VRmoJw>
    <xme:N3RRZwoIGlYrwgXHecHHuIrVWT6FrnoSN-34t1Ty8ZoC22mLlgg_dtpe7sniROpti
    Rux4juuMy3wCvOEmg>
X-ME-Received: <xmr:N3RRZ3PA5hhAdUWxmGCocneKIcT3exIoUUKCt8r60IiKv6vM9RbEkE-WqvDzIQUF4gLt2zw25g2IG_S5NBjMi2Hz70U6isB-MMiE_niBdV6zWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieejgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecuogfuphgrmhgfrhhlucdlfe
    dttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhm
    pefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtf
    frrghtthgvrhhnpeefjeffhefgudegleeijeduuddugfegledttdffhfffueduleetfffg
    kefgkedujeenucffohhmrghinhepghhnuhdrohhrghdprhgvfhgvrhgvnhgtvghsrdhnrh
    enucfuphgrmhgfrhhlpehhthhtphemsddsfiiffidrghhnuhdrohhrghdslhhitggvnhhs
    vghsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepph
    hssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshh
    gvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdr
    nhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:OHRRZx6vDlT4jA8e2oAjXGytfyHX8FbjqOvGSR7LF66eGnIKY_i2eQ>
    <xmx:OHRRZx5IgasvkL8v-2MPV3EYpx-PxiDWJJn7FGjj17JhEpPFtGlglQ>
    <xmx:OHRRZxhFZS3alC04DIi2EOAuwcRbnN6Ui7lW72iUUP7bXMuVTt1eXg>
    <xmx:OHRRZ76M70Sq_FbGYQhn_igwZjf9UQ_J9bRsvA6ndeYLPL4wrHxm8Q>
    <xmx:OHRRZzRAVQGIm1cqZgZ2NMAXTZJsJQ-c8QYLV3uJjLqSE_QQ6eJqxpid>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Dec 2024 04:36:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2e5a47d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Dec 2024 09:35:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Dec 2024 10:36:30 +0100
Subject: [PATCH v3 08/15] global: trivial conversions to fix
 `-Wsign-compare` warnings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-pks-sign-compare-v3-8-e211ee089717@pks.im>
References: <20241205-pks-sign-compare-v3-0-e211ee089717@pks.im>
In-Reply-To: <20241205-pks-sign-compare-v3-0-e211ee089717@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

We have a bunch of loops which iterate up to an unsigned boundary using
a signed index, which generates warnigs because we compare a signed and
unsigned value in the loop condition. Address these sites for trivial
cases and enable `-Wsign-compare` warnings for these code units.

This patch only adapts those code units where we can drop the
`DISABLE_SIGN_COMPARE_WARNINGS` macro in the same step.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 advice.c                             |  9 ++-------
 base85.c                             |  5 +----
 builtin/add.c                        | 10 ++++------
 builtin/branch.c                     |  1 -
 builtin/difftool.c                   |  4 ++--
 builtin/for-each-repo.c              |  5 ++---
 builtin/help.c                       |  4 +---
 builtin/mailsplit.c                  |  3 +--
 builtin/merge-tree.c                 |  6 ++----
 builtin/pack-redundant.c             |  4 +---
 builtin/pull.c                       |  4 +---
 builtin/push.c                       |  5 ++---
 builtin/rerere.c                     |  9 ++++-----
 builtin/stash.c                      |  7 ++-----
 builtin/submodule--helper.c          |  8 +++-----
 builtin/var.c                        |  4 +---
 commit.c                             |  4 +---
 compat/fsmonitor/fsm-listen-darwin.c |  5 +----
 compat/terminal.c                    |  5 +----
 diagnose.c                           |  8 +++-----
 diffcore-rename.c                    |  4 +---
 entry.c                              |  5 ++---
 ewah/ewah_bitmap.c                   |  6 +-----
 git.c                                | 21 +++++++--------------
 help.h                               |  8 +++-----
 hex.c                                |  7 ++-----
 http-push.c                          |  4 +---
 list-objects-filter-options.c        |  5 +----
 list-objects.c                       |  8 ++------
 ls-refs.c                            |  5 +----
 merge.c                              |  5 ++---
 path.c                               |  5 ++---
 pkt-line.c                           |  5 +----
 refs/debug.c                         |  5 +----
 send-pack.c                          |  6 ++----
 serve.c                              |  8 ++------
 strvec.c                             |  5 +----
 t/helper/test-bloom.c                | 10 ++--------
 t/helper/test-dump-fsmonitor.c       |  4 +---
 t/helper/test-dump-split-index.c     |  4 +---
 t/helper/test-dump-untracked-cache.c |  7 +++----
 t/helper/test-hash-speed.c           |  7 ++-----
 t/helper/test-parse-options.c        |  7 ++-----
 t/helper/test-reach.c                |  4 +---
 t/helper/test-ref-store.c            |  4 +---
 t/helper/test-tool.c                 |  5 +----
 t/unit-tests/t-example-decorate.c    |  5 ++---
 t/unit-tests/t-prio-queue.c          |  4 +---
 tmp-objdir.c                         |  4 +---
 trailer.c                            |  4 +---
 transport-helper.c                   | 14 ++++++--------
 transport.c                          | 14 ++++----------
 usage.c                              |  4 +---
 version.c                            |  4 +---
 versioncmp.c                         |  4 +---
 55 files changed, 99 insertions(+), 232 deletions(-)

diff --git a/advice.c b/advice.c
index c2da976543c946a02d532e6dc3fe53bec86ee2a2..147b596d33974e45d74747d6ca43c05eedeee0fe 100644
--- a/advice.c
+++ b/advice.c
@@ -1,5 +1,3 @@
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "git-compat-util.h"
 #include "advice.h"
 #include "config.h"
@@ -162,7 +160,6 @@ void advise_if_enabled(enum advice_type type, const char *advice, ...)
 int git_default_advice_config(const char *var, const char *value)
 {
 	const char *k, *slot_name;
-	int i;
 
 	if (!strcmp(var, "color.advice")) {
 		advice_use_color = git_config_colorbool(var, value);
@@ -181,7 +178,7 @@ int git_default_advice_config(const char *var, const char *value)
 	if (!skip_prefix(var, "advice.", &k))
 		return 0;
 
-	for (i = 0; i < ARRAY_SIZE(advice_setting); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(advice_setting); i++) {
 		if (strcasecmp(k, advice_setting[i].key))
 			continue;
 		advice_setting[i].level = git_config_bool(var, value)
@@ -195,9 +192,7 @@ int git_default_advice_config(const char *var, const char *value)
 
 void list_config_advices(struct string_list *list, const char *prefix)
 {
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(advice_setting); i++)
+	for (size_t i = 0; i < ARRAY_SIZE(advice_setting); i++)
 		list_config_item(list, prefix, advice_setting[i].key);
 }
 
diff --git a/base85.c b/base85.c
index a6b827203965714bddbf673fecb0198b3ceef237..80e899a2b1a20d840117609993811d8ab9a31733 100644
--- a/base85.c
+++ b/base85.c
@@ -1,5 +1,3 @@
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "git-compat-util.h"
 #include "base85.h"
 
@@ -31,10 +29,9 @@ static const char en85[] = {
 static char de85[256];
 static void prep_base85(void)
 {
-	int i;
 	if (de85['Z'])
 		return;
-	for (i = 0; i < ARRAY_SIZE(en85); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(en85); i++) {
 		int ch = en85[i];
 		de85[ch] = i + 1;
 	}
diff --git a/builtin/add.c b/builtin/add.c
index ff6a7d7fd0868cafb98327ec4ffa81dcac66e4bb..78dfb265776724109f4a8b93a419c32667979954 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -4,8 +4,6 @@
  * Copyright (C) 2006 Linus Torvalds
  */
 
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "builtin.h"
 #include "advice.h"
 #include "config.h"
@@ -42,9 +40,9 @@ static int chmod_pathspec(struct repository *repo,
 			  char flip,
 			  int show_only)
 {
-	int i, ret = 0;
+	int ret = 0;
 
-	for (i = 0; i < repo->index->cache_nr; i++) {
+	for (size_t i = 0; i < repo->index->cache_nr; i++) {
 		struct cache_entry *ce = repo->index->cache[i];
 		int err;
 
@@ -72,9 +70,9 @@ static int renormalize_tracked_files(struct repository *repo,
 				     const struct pathspec *pathspec,
 				     int flags)
 {
-	int i, retval = 0;
+	int retval = 0;
 
-	for (i = 0; i < repo->index->cache_nr; i++) {
+	for (size_t i = 0; i < repo->index->cache_nr; i++) {
 		struct cache_entry *ce = repo->index->cache[i];
 
 		if (!include_sparse &&
diff --git a/builtin/branch.c b/builtin/branch.c
index bf54f974cf1289a94d74b22d1aaa71569d44a1ac..0fbd017588690fcaecc0f8f290829ecc3f1e48a0 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -6,7 +6,6 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
 #include "config.h"
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 1914708a764d3f0637b327768a7f5cf8a6f96c13..03a8bb92a95896f4b4d2f0bef3d8256359c08c06 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -13,7 +13,6 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
 
@@ -367,7 +366,8 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	char *lbase_dir = NULL, *rbase_dir = NULL;
 	size_t ldir_len, rdir_len, wtdir_len;
 	const char *workdir, *tmp;
-	int ret = 0, i;
+	int ret = 0;
+	size_t i;
 	FILE *fp = NULL;
 	struct hashmap working_tree_dups = HASHMAP_INIT(working_tree_entry_cmp,
 							NULL);
diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index 7e36be9d8a55e9454668b935e8d13f52cdc0f62a..325a7925f1fdb577f4802466065ae4f05f48f449 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
 #include "config.h"
@@ -38,7 +37,7 @@ int cmd_for_each_repo(int argc,
 {
 	static const char *config_key = NULL;
 	int keep_going = 0;
-	int i, result = 0;
+	int result = 0;
 	const struct string_list *values;
 	int err;
 
@@ -63,7 +62,7 @@ int cmd_for_each_repo(int argc,
 	else if (err)
 		return 0;
 
-	for (i = 0; i < values->nr; i++) {
+	for (size_t i = 0; i < values->nr; i++) {
 		int ret = run_command_on_repo(values->items[i].string, argc, argv);
 		if (ret) {
 			if (!keep_going)
diff --git a/builtin/help.c b/builtin/help.c
index f45cbd8b32ba1401725e01068ca468bb09eb3aef..98bcd48867eca205b9d30643deee2f61e60213f4 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -3,7 +3,6 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
 #include "config.h"
@@ -131,7 +130,6 @@ static void list_config_help(enum show_config_type type)
 	struct string_list keys = STRING_LIST_INIT_DUP;
 	struct string_list keys_uniq = STRING_LIST_INIT_DUP;
 	struct string_list_item *item;
-	int i;
 
 	for (p = config_name_list; *p; p++) {
 		const char *var = *p;
@@ -158,7 +156,7 @@ static void list_config_help(enum show_config_type type)
 			    e->prefix, e->placeholder);
 
 	string_list_sort(&keys);
-	for (i = 0; i < keys.nr; i++) {
+	for (size_t i = 0; i < keys.nr; i++) {
 		const char *var = keys.items[i].string;
 		const char *wildcard, *tag, *cut;
 		const char *dot = NULL;
diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 52481f7f2ee75f0cc6a384fdc78ddd1ccad584df..41dd3047313e6cab6dcf7fe65d2f5529e70e4aa2 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -175,7 +175,6 @@ static int split_maildir(const char *maildir, const char *dir,
 	char *file = NULL;
 	FILE *f = NULL;
 	int ret = -1;
-	int i;
 	struct string_list list = STRING_LIST_INIT_DUP;
 
 	list.cmp = maildir_filename_cmp;
@@ -183,7 +182,7 @@ static int split_maildir(const char *maildir, const char *dir,
 	if (populate_maildir_list(&list, maildir) < 0)
 		goto out;
 
-	for (i = 0; i < list.nr; i++) {
+	for (size_t i = 0; i < list.nr; i++) {
 		char *name;
 
 		free(file);
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 3328144029a50894ef7fa3afe0f44133db406cda..9a6c8b4e4cf21219da5866111f5ae5eda0e1b83a 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
 #include "tree-walk.h"
@@ -499,10 +498,9 @@ static int real_merge(struct merge_tree_options *o,
 	if (!result.clean) {
 		struct string_list conflicted_files = STRING_LIST_INIT_NODUP;
 		const char *last = NULL;
-		int i;
 
 		merge_get_conflicted_files(&result, &conflicted_files);
-		for (i = 0; i < conflicted_files.nr; i++) {
+		for (size_t i = 0; i < conflicted_files.nr; i++) {
 			const char *name = conflicted_files.items[i].string;
 			struct stage_info *c = conflicted_files.items[i].util;
 			if (!o->name_only)
@@ -586,7 +584,7 @@ int cmd_merge_tree(int argc,
 
 	if (xopts.nr && o.mode == MODE_TRIVIAL)
 		die(_("--trivial-merge is incompatible with all other options"));
-	for (int x = 0; x < xopts.nr; x++)
+	for (size_t x = 0; x < xopts.nr; x++)
 		if (parse_merge_opt(&o.merge_options, xopts.v[x]))
 			die(_("unknown strategy option: -X%s"), xopts.v[x]);
 
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 978c42aae7b86f0ce049eea0ac0b9bcfcf598348..275333f543476c94bf1d73f74158613c2d050101 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -7,7 +7,6 @@
 */
 
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
 #include "gettext.h"
@@ -391,7 +390,6 @@ static int cmp_remaining_objects(const void *a, const void *b)
 static void sort_pack_list(struct pack_list **pl)
 {
 	struct pack_list **ary, *p;
-	int i;
 	size_t n = pack_list_size(*pl);
 
 	if (n < 2)
@@ -405,7 +403,7 @@ static void sort_pack_list(struct pack_list **pl)
 	QSORT(ary, n, cmp_remaining_objects);
 
 	/* link them back again */
-	for (i = 0; i < n - 1; i++)
+	for (size_t i = 0; i < n - 1; i++)
 		ary[i]->next = ary[i + 1];
 	ary[n - 1]->next = NULL;
 	*pl = ary[0];
diff --git a/builtin/pull.c b/builtin/pull.c
index 6f8a32620c378f22f36cee4480d975d273bb04ff..9c4a00620a053b375294b9895a2b402a3deed6e8 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -7,7 +7,6 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
 #include "advice.h"
@@ -943,11 +942,10 @@ static int get_can_ff(struct object_id *orig_head,
 static int already_up_to_date(struct object_id *orig_head,
 			      struct oid_array *merge_heads)
 {
-	int i;
 	struct commit *ours;
 
 	ours = lookup_commit_reference(the_repository, orig_head);
-	for (i = 0; i < merge_heads->nr; i++) {
+	for (size_t i = 0; i < merge_heads->nr; i++) {
 		struct commit_list *list = NULL;
 		struct commit *theirs;
 		int ok;
diff --git a/builtin/push.c b/builtin/push.c
index 7174efed6dce226a0dfbd117f996ce67b45a2625..90de3746b5229f87655c4111112980945cd49832 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -3,7 +3,6 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
 #include "advice.h"
@@ -420,7 +419,7 @@ static int do_push(int flags,
 		   const struct string_list *push_options,
 		   struct remote *remote)
 {
-	int i, errs;
+	int errs;
 	struct strvec *url;
 	struct refspec *push_refspec = &rs;
 
@@ -435,7 +434,7 @@ static int do_push(int flags,
 	}
 	errs = 0;
 	url = push_url_of_remote(remote);
-	for (i = 0; i < url->nr; i++) {
+	for (size_t i = 0; i < url->nr; i++) {
 		struct transport *transport =
 			transport_get(remote, url->v[i]);
 		if (flags & TRANSPORT_PUSH_OPTIONS)
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 706a9472133862a0dd513a4cee454403f5de748b..41127e24e5309815dbb8d36cf9bbf905d1703c79 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
 #include "config.h"
@@ -57,7 +56,7 @@ int cmd_rerere(int argc,
 	       struct repository *repo UNUSED)
 {
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
-	int i, autoupdate = -1, flags = 0;
+	int autoupdate = -1, flags = 0;
 
 	struct option options[] = {
 		OPT_SET_INT(0, "rerere-autoupdate", &autoupdate,
@@ -100,11 +99,11 @@ int cmd_rerere(int argc,
 		if (setup_rerere(the_repository, &merge_rr,
 				 flags | RERERE_READONLY) < 0)
 			return 0;
-		for (i = 0; i < merge_rr.nr; i++)
+		for (size_t i = 0; i < merge_rr.nr; i++)
 			printf("%s\n", merge_rr.items[i].string);
 	} else if (!strcmp(argv[0], "remaining")) {
 		rerere_remaining(the_repository, &merge_rr);
-		for (i = 0; i < merge_rr.nr; i++) {
+		for (size_t i = 0; i < merge_rr.nr; i++) {
 			if (merge_rr.items[i].util != RERERE_RESOLVED)
 				printf("%s\n", merge_rr.items[i].string);
 			else
@@ -116,7 +115,7 @@ int cmd_rerere(int argc,
 		if (setup_rerere(the_repository, &merge_rr,
 				 flags | RERERE_READONLY) < 0)
 			return 0;
-		for (i = 0; i < merge_rr.nr; i++) {
+		for (size_t i = 0; i < merge_rr.nr; i++) {
 			const char *path = merge_rr.items[i].string;
 			const struct rerere_id *id = merge_rr.items[i].util;
 			if (diff_two(rerere_path(id, "preimage"), path, path, path))
diff --git a/builtin/stash.c b/builtin/stash.c
index c859888439dcb352c741e15232d8a3e551ff7842..1416a557378df1d0212fd609e2f5d31cfdd473e2 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
 #include "abspath.h"
@@ -869,9 +868,8 @@ static void diff_include_untracked(const struct stash_info *info, struct diff_op
 	struct tree *tree[ARRAY_SIZE(oid)];
 	struct tree_desc tree_desc[ARRAY_SIZE(oid)];
 	struct unpack_trees_options unpack_tree_opt = { 0 };
-	int i;
 
-	for (i = 0; i < ARRAY_SIZE(oid); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(oid); i++) {
 		tree[i] = parse_tree_indirect(oid[i]);
 		if (parse_tree(tree[i]) < 0)
 			die(_("failed to parse tree"));
@@ -1550,12 +1548,11 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 
 	repo_read_index_preload(the_repository, NULL, 0);
 	if (!include_untracked && ps->nr) {
-		int i;
 		char *ps_matched = xcalloc(ps->nr, 1);
 
 		/* TODO: audit for interaction with sparse-index. */
 		ensure_full_index(the_repository->index);
-		for (i = 0; i < the_repository->index->cache_nr; i++)
+		for (size_t i = 0; i < the_repository->index->cache_nr; i++)
 			ce_path_match(the_repository->index, the_repository->index->cache[i], ps,
 				      ps_matched);
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 160d2d6a22498e9ee8449720b0efe9248cb275d1..a62ab4403089080e78a52c58dfe4194566f6c66f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
 #include "abspath.h"
@@ -196,7 +195,7 @@ static int module_list_compute(const char **argv,
 			       struct pathspec *pathspec,
 			       struct module_list *list)
 {
-	int i, result = 0;
+	int result = 0;
 	char *ps_matched = NULL;
 
 	parse_pathspec(pathspec, 0,
@@ -209,7 +208,7 @@ static int module_list_compute(const char **argv,
 	if (repo_read_index(the_repository) < 0)
 		die(_("index file corrupt"));
 
-	for (i = 0; i < the_repository->index->cache_nr; i++) {
+	for (size_t i = 0; i < the_repository->index->cache_nr; i++) {
 		const struct cache_entry *ce = the_repository->index->cache[i];
 
 		if (!match_pathspec(the_repository->index, pathspec, ce->name, ce_namelen(ce),
@@ -3385,7 +3384,6 @@ static void die_on_index_match(const char *path, int force)
 		die(_("index file corrupt"));
 
 	if (ps.nr) {
-		int i;
 		char *ps_matched = xcalloc(ps.nr, 1);
 
 		/* TODO: audit for interaction with sparse-index. */
@@ -3395,7 +3393,7 @@ static void die_on_index_match(const char *path, int force)
 		 * Since there is only one pathspec, we just need to
 		 * check ps_matched[0] to know if a cache entry matched.
 		 */
-		for (i = 0; i < the_repository->index->cache_nr; i++) {
+		for (size_t i = 0; i < the_repository->index->cache_nr; i++) {
 			ce_path_match(the_repository->index, the_repository->index->cache[i], &ps,
 				      ps_matched);
 
diff --git a/builtin/var.c b/builtin/var.c
index 74aa39dd6bfb261170152d7dd3dc3d724bec61bc..1449656cc924f849ee9c881c18b734a3ec55e9f3 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -5,7 +5,6 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
 
@@ -181,10 +180,9 @@ static void list_vars(void)
 		if ((val = ptr->read(0))) {
 			if (ptr->multivalued && *val) {
 				struct string_list list = STRING_LIST_INIT_DUP;
-				int i;
 
 				string_list_split(&list, val, '\n', -1);
-				for (i = 0; i < list.nr; i++)
+				for (size_t i = 0; i < list.nr; i++)
 					printf("%s=%s\n", ptr->name, list.items[i].string);
 				string_list_clear(&list, 0);
 			} else {
diff --git a/commit.c b/commit.c
index 9c1f9fa2367e8c0930c8446e88b9368472dc6ade..8f6045a6c3400e09e0ec174f7eab5fdae8a6cd3f 100644
--- a/commit.c
+++ b/commit.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "tag.h"
@@ -1766,7 +1765,6 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 			{ &compat_sig, r->compat_hash_algo },
 			{ &sig, r->hash_algo },
 		};
-		int i;
 
 		/*
 		 * We write algorithms in the order they were implemented in
@@ -1780,7 +1778,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 		 * We traverse each algorithm in order, and apply the signature
 		 * to each buffer.
 		 */
-		for (i = 0; i < ARRAY_SIZE(bufs); i++) {
+		for (size_t i = 0; i < ARRAY_SIZE(bufs); i++) {
 			if (!bufs[i].algo)
 				continue;
 			add_header_signature(&buffer, bufs[i].sig, bufs[i].algo);
diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 58f3878a22666ea8a0bd5bfc215eadf06de747c0..43c3a915a0edfc8d625ed9218f85ecdc2ba8985b 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -23,8 +23,6 @@
 #endif
 #endif
 
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "git-compat-util.h"
 #include "fsmonitor-ll.h"
 #include "fsm-listen.h"
@@ -210,13 +208,12 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef UNUSED,
 	const char *slash;
 	char *resolved = NULL;
 	struct strbuf tmp = STRBUF_INIT;
-	int k;
 
 	/*
 	 * Build a list of all filesystem changes into a private/local
 	 * list and without holding any locks.
 	 */
-	for (k = 0; k < num_of_events; k++) {
+	for (size_t k = 0; k < num_of_events; k++) {
 		/*
 		 * On Mac, we receive an array of absolute paths.
 		 */
diff --git a/compat/terminal.c b/compat/terminal.c
index 7fe515b9c88e266f075043c0d48a6cbce5dacea2..584f27bf7e1078338d5b7a0aedf12aecdc95fbd1 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -1,5 +1,3 @@
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "git-compat-util.h"
 #include "compat/terminal.h"
 #include "gettext.h"
@@ -261,14 +259,13 @@ static DWORD cmode_in, cmode_out;
 void restore_term(void)
 {
 	if (use_stty) {
-		int i;
 		struct child_process cp = CHILD_PROCESS_INIT;
 
 		if (stty_restore.nr == 0)
 			return;
 
 		strvec_push(&cp.args, "stty");
-		for (i = 0; i < stty_restore.nr; i++)
+		for (size_t i = 0; i < stty_restore.nr; i++)
 			strvec_push(&cp.args, stty_restore.items[i].string);
 		run_command(&cp);
 		string_list_clear(&stty_restore, 0);
diff --git a/diagnose.c b/diagnose.c
index f340996e27b994c1ab58654bf248305a45833adc..b11931df86c4ba84f7aec77cb7965083f5aa31fa 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "diagnose.h"
@@ -32,7 +31,6 @@ static struct diagnose_option diagnose_options[] = {
 
 int option_parse_diagnose(const struct option *opt, const char *arg, int unset)
 {
-	int i;
 	enum diagnose_mode *diagnose = opt->value;
 
 	if (!arg) {
@@ -40,7 +38,7 @@ int option_parse_diagnose(const struct option *opt, const char *arg, int unset)
 		return 0;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(diagnose_options); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(diagnose_options); i++) {
 		if (!strcmp(arg, diagnose_options[i].option_name)) {
 			*diagnose = diagnose_options[i].mode;
 			return 0;
@@ -187,7 +185,7 @@ int create_diagnostics_archive(struct strbuf *zip_path, enum diagnose_mode mode)
 	char **argv_copy = NULL;
 	int stdout_fd = -1, archiver_fd = -1;
 	struct strbuf buf = STRBUF_INIT;
-	int res, i;
+	int res;
 	struct archive_dir archive_dirs[] = {
 		{ ".git", 0 },
 		{ ".git/hooks", 0 },
@@ -240,7 +238,7 @@ int create_diagnostics_archive(struct strbuf *zip_path, enum diagnose_mode mode)
 
 	/* Only include this if explicitly requested */
 	if (mode == DIAGNOSE_ALL) {
-		for (i = 0; i < ARRAY_SIZE(archive_dirs); i++) {
+		for (size_t i = 0; i < ARRAY_SIZE(archive_dirs); i++) {
 			if (add_directory_to_archiver(&archiver_args,
 						      archive_dirs[i].path,
 						      archive_dirs[i].recursive)) {
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 08ebb1fc3d087ffe666f747ebf5301a8f6f8b2d8..10bb0321b10d5896aaa6a26a624d2066598bf51f 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -4,7 +4,6 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "diff.h"
@@ -689,7 +688,6 @@ static void cleanup_dir_rename_info(struct dir_rename_info *info,
 	struct hashmap_iter iter;
 	struct strmap_entry *entry;
 	struct string_list to_remove = STRING_LIST_INIT_NODUP;
-	int i;
 
 	if (!info->setup)
 		return;
@@ -735,7 +733,7 @@ static void cleanup_dir_rename_info(struct dir_rename_info *info,
 		if (strintmap_contains(counts, UNKNOWN_DIR))
 			strintmap_remove(counts, UNKNOWN_DIR);
 	}
-	for (i = 0; i < to_remove.nr; ++i)
+	for (size_t i = 0; i < to_remove.nr; ++i)
 		strmap_remove(info->dir_rename_count,
 			      to_remove.items[i].string, 1);
 	string_list_clear(&to_remove, 0);
diff --git a/entry.c b/entry.c
index 93bd6a78ffac4ba3b5b6ac64ec0fd23c9793e56f..53a1c393582b2e6be4398985ca3c5f4fadece3cb 100644
--- a/entry.c
+++ b/entry.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "object-store-ll.h"
@@ -442,7 +441,7 @@ static int check_path(const char *path, int len, struct stat *st, int skiplen)
 static void mark_colliding_entries(const struct checkout *state,
 				   struct cache_entry *ce, struct stat *st)
 {
-	int i, trust_ino = check_stat;
+	int trust_ino = check_stat;
 
 #if defined(GIT_WINDOWS_NATIVE) || defined(__CYGWIN__)
 	trust_ino = 0;
@@ -452,7 +451,7 @@ static void mark_colliding_entries(const struct checkout *state,
 
 	/* TODO: audit for interaction with sparse-index. */
 	ensure_full_index(state->istate);
-	for (i = 0; i < state->istate->cache_nr; i++) {
+	for (size_t i = 0; i < state->istate->cache_nr; i++) {
 		struct cache_entry *dup = state->istate->cache[i];
 
 		if (dup == ce) {
diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
index 9be9bb3758cf0bc267d09d59b3b23a127b3e4721..67f8f588e056248dbc2707f68abdd832203e5d97 100644
--- a/ewah/ewah_bitmap.c
+++ b/ewah/ewah_bitmap.c
@@ -17,8 +17,6 @@
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "git-compat-util.h"
 #include "ewok.h"
 #include "ewok_rlw.h"
@@ -258,10 +256,8 @@ void ewah_each_bit(struct ewah_bitmap *self, void (*callback)(size_t, void*), vo
 		++pointer;
 
 		for (k = 0; k < rlw_get_literal_words(word); ++k) {
-			int c;
-
 			/* todo: zero count optimization */
-			for (c = 0; c < BITS_IN_EWORD; ++c, ++pos) {
+			for (size_t c = 0; c < BITS_IN_EWORD; ++c, ++pos) {
 				if ((self->buffer[pointer] & ((eword_t)1 << c)) != 0)
 					callback(pos, payload);
 			}
diff --git a/git.c b/git.c
index 69a17f7c13c6204de59687085e77ede5edef660f..45951b635c9e8ed17ece154e9de40c0658d8ac2e 100644
--- a/git.c
+++ b/git.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
 #include "config.h"
@@ -56,7 +55,7 @@ static void list_builtins(struct string_list *list, unsigned int exclude_option)
 
 static void exclude_helpers_from_list(struct string_list *list)
 {
-	int i = 0;
+	size_t i = 0;
 
 	while (i < list->nr) {
 		if (strstr(list->items[i].string, "--"))
@@ -76,7 +75,6 @@ static int match_token(const char *spec, int len, const char *token)
 static int list_cmds(const char *spec)
 {
 	struct string_list list = STRING_LIST_INIT_DUP;
-	int i;
 	int nongit;
 
 	/*
@@ -114,7 +112,7 @@ static int list_cmds(const char *spec)
 		if (*spec == ',')
 			spec++;
 	}
-	for (i = 0; i < list.nr; i++)
+	for (size_t i = 0; i < list.nr; i++)
 		puts(list.items[i].string);
 	string_list_clear(&list, 0);
 	return 0;
@@ -323,10 +321,9 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			trace2_cmd_name("_query_");
 			if (!strcmp(cmd, "parseopt")) {
 				struct string_list list = STRING_LIST_INIT_DUP;
-				int i;
 
 				list_builtins(&list, NO_PARSEOPT);
-				for (i = 0; i < list.nr; i++)
+				for (size_t i = 0; i < list.nr; i++)
 					printf("%s ", list.items[i].string);
 				string_list_clear(&list, 0);
 				exit(0);
@@ -654,8 +651,7 @@ static struct cmd_struct commands[] = {
 
 static struct cmd_struct *get_builtin(const char *s)
 {
-	int i;
-	for (i = 0; i < ARRAY_SIZE(commands); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(commands); i++) {
 		struct cmd_struct *p = commands + i;
 		if (!strcmp(s, p->cmd))
 			return p;
@@ -670,8 +666,7 @@ int is_builtin(const char *s)
 
 static void list_builtins(struct string_list *out, unsigned int exclude_option)
 {
-	int i;
-	for (i = 0; i < ARRAY_SIZE(commands); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(commands); i++) {
 		if (exclude_option &&
 		    (commands[i].option & exclude_option))
 			continue;
@@ -682,7 +677,6 @@ static void list_builtins(struct string_list *out, unsigned int exclude_option)
 void load_builtin_commands(const char *prefix, struct cmdnames *cmds)
 {
 	const char *name;
-	int i;
 
 	/*
 	 * Callers can ask for a subset of the commands based on a certain
@@ -693,7 +687,7 @@ void load_builtin_commands(const char *prefix, struct cmdnames *cmds)
 	if (!skip_prefix(prefix, "git-", &prefix))
 		BUG("prefix '%s' must start with 'git-'", prefix);
 
-	for (i = 0; i < ARRAY_SIZE(commands); i++)
+	for (size_t i = 0; i < ARRAY_SIZE(commands); i++)
 		if (skip_prefix(commands[i].cmd, prefix, &name))
 			add_cmdname(cmds, name, strlen(name));
 }
@@ -859,9 +853,8 @@ static int run_argv(int *argcp, const char ***argv)
 
 		seen = unsorted_string_list_lookup(&cmd_list, *argv[0]);
 		if (seen) {
-			int i;
 			struct strbuf sb = STRBUF_INIT;
-			for (i = 0; i < cmd_list.nr; i++) {
+			for (size_t i = 0; i < cmd_list.nr; i++) {
 				struct string_list_item *item = &cmd_list.items[i];
 
 				strbuf_addf(&sb, "\n  %s", item->string);
diff --git a/help.h b/help.h
index e716ee27ea174c4dfc3b941619bf361972894212..6e255fe719f1b2b30dc0e45622e65f23185bde2e 100644
--- a/help.h
+++ b/help.h
@@ -60,8 +60,7 @@ static inline void list_config_item(struct string_list *list,
 #define define_list_config_array(array)					\
 void list_config_##array(struct string_list *list, const char *prefix)	\
 {									\
-	int i;								\
-	for (i = 0; i < ARRAY_SIZE(array); i++)				\
+	for (size_t i = 0; i < ARRAY_SIZE(array); i++)			\
 		if (array[i])						\
 			list_config_item(list, prefix, array[i]);	\
 }									\
@@ -70,11 +69,10 @@ struct string_list
 #define define_list_config_array_extra(array, values)			\
 void list_config_##array(struct string_list *list, const char *prefix)	\
 {									\
-	int i;								\
 	static const char *extra[] = values;				\
-	for (i = 0; i < ARRAY_SIZE(extra); i++)				\
+	for (size_t i = 0; i < ARRAY_SIZE(extra); i++)			\
 		list_config_item(list, prefix, extra[i]);		\
-	for (i = 0; i < ARRAY_SIZE(array); i++)				\
+	for (size_t i = 0; i < ARRAY_SIZE(array); i++)			\
 		if (array[i])						\
 			list_config_item(list, prefix, array[i]);	\
 }									\
diff --git a/hex.c b/hex.c
index e62406c182ae54ad9475424f0be00e2d9a6bcaab..865a232167553d6376c51d51604544cc71813fb1 100644
--- a/hex.c
+++ b/hex.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "hash.h"
@@ -8,8 +7,7 @@
 static int get_hash_hex_algop(const char *hex, unsigned char *hash,
 			      const struct git_hash_algo *algop)
 {
-	int i;
-	for (i = 0; i < algop->rawsz; i++) {
+	for (size_t i = 0; i < algop->rawsz; i++) {
 		int val = hex2chr(hex);
 		if (val < 0)
 			return -1;
@@ -84,7 +82,6 @@ char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash,
 {
 	static const char hex[] = "0123456789abcdef";
 	char *buf = buffer;
-	int i;
 
 	/*
 	 * Our struct object_id has been memset to 0, so default to printing
@@ -93,7 +90,7 @@ char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash,
 	if (algop == &hash_algos[0])
 		algop = the_hash_algo;
 
-	for (i = 0; i < algop->rawsz; i++) {
+	for (size_t i = 0; i < algop->rawsz; i++) {
 		unsigned int val = *hash++;
 		*buf++ = hex[val >> 4];
 		*buf++ = hex[val & 0xf];
diff --git a/http-push.c b/http-push.c
index a5e8c3e9003074c125f562769b26ffe11985c0c3..43da1c7cd33b402ea77e3ce79e496f670ffdcc3b 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "environment.h"
@@ -1339,7 +1338,6 @@ static struct object_list **process_tree(struct tree *tree,
 
 static int get_delta(struct rev_info *revs, struct remote_lock *lock)
 {
-	int i;
 	struct commit *commit;
 	struct object_list **p = &objects;
 	int count = 0;
@@ -1352,7 +1350,7 @@ static int get_delta(struct rev_info *revs, struct remote_lock *lock)
 			count += add_send_request(&commit->object, lock);
 	}
 
-	for (i = 0; i < revs->pending.nr; i++) {
+	for (size_t i = 0; i < revs->pending.nr; i++) {
 		struct object_array_entry *entry = revs->pending.objects + i;
 		struct object *obj = entry->item;
 		const char *name = entry->name;
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index d1f7c56e6f973062ce69312718dbda79f4b944cd..948376d42d06afa5e6a05ffb50dd88054c881597 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "config.h"
@@ -395,8 +394,6 @@ void list_objects_filter_copy(
 	struct list_objects_filter_options *dest,
 	const struct list_objects_filter_options *src)
 {
-	int i;
-
 	/* Copy everything. We will overwrite the pointers shortly. */
 	memcpy(dest, src, sizeof(struct list_objects_filter_options));
 
@@ -405,7 +402,7 @@ void list_objects_filter_copy(
 	dest->sparse_oid_name = xstrdup_or_null(src->sparse_oid_name);
 
 	ALLOC_ARRAY(dest->sub, dest->sub_alloc);
-	for (i = 0; i < src->sub_nr; i++)
+	for (size_t i = 0; i < src->sub_nr; i++)
 		list_objects_filter_copy(&dest->sub[i], &src->sub[i]);
 }
 
diff --git a/list-objects.c b/list-objects.c
index 2075c69496cde719e3f8deeb05dd5e14f589f036..deacef98aafdaa951a986a9a96a4a25d82717136 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "tag.h"
@@ -284,7 +283,6 @@ void mark_edges_uninteresting(struct rev_info *revs,
 			      int sparse)
 {
 	struct commit_list *list;
-	int i;
 
 	if (sparse) {
 		struct oidset set;
@@ -321,7 +319,7 @@ void mark_edges_uninteresting(struct rev_info *revs,
 	}
 
 	if (revs->edge_hint_aggressive) {
-		for (i = 0; i < revs->cmdline.nr; i++) {
+		for (size_t i = 0; i < revs->cmdline.nr; i++) {
 			struct object *obj = revs->cmdline.rev[i].item;
 			struct commit *commit = (struct commit *)obj;
 			if (obj->type != OBJ_COMMIT || !(obj->flags & UNINTERESTING))
@@ -344,11 +342,9 @@ static void add_pending_tree(struct rev_info *revs, struct tree *tree)
 static void traverse_non_commits(struct traversal_context *ctx,
 				 struct strbuf *base)
 {
-	int i;
-
 	assert(base->len == 0);
 
-	for (i = 0; i < ctx->revs->pending.nr; i++) {
+	for (size_t i = 0; i < ctx->revs->pending.nr; i++) {
 		struct object_array_entry *pending = ctx->revs->pending.objects + i;
 		struct object *obj = pending->item;
 		const char *name = pending->name;
diff --git a/ls-refs.c b/ls-refs.c
index 89a796a3561502893e160917bf04fb66af54397b..e28c841375861d3b735755de1dea780283bb7d28 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "environment.h"
@@ -54,12 +53,10 @@ static enum {
  */
 static int ref_match(const struct strvec *prefixes, const char *refname)
 {
-	int i;
-
 	if (!prefixes->nr)
 		return 1; /* no restriction */
 
-	for (i = 0; i < prefixes->nr; i++) {
+	for (size_t i = 0; i < prefixes->nr; i++) {
 		const char *prefix = prefixes->v[i];
 
 		if (starts_with(refname, prefix))
diff --git a/merge.c b/merge.c
index da04fff3baa6b64e2581ac86186b99db914a6858..5ecaf508e4cb98d6093fff0f2da0a27f777dd016 100644
--- a/merge.c
+++ b/merge.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "gettext.h"
@@ -26,11 +25,11 @@ int try_merge_command(struct repository *r,
 		      const char *head_arg, struct commit_list *remotes)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
-	int i, ret;
+	int ret;
 	struct commit_list *j;
 
 	strvec_pushf(&cmd.args, "merge-%s", strategy);
-	for (i = 0; i < xopts_nr; i++)
+	for (size_t i = 0; i < xopts_nr; i++)
 		strvec_pushf(&cmd.args, "--%s", xopts[i]);
 	for (j = common; j; j = j->next)
 		strvec_push(&cmd.args, merge_argument(j->item));
diff --git a/path.c b/path.c
index 1f210048047b72370d87a6161c4af0142c17cf6a..b4be7581aa6c94380223045648778a18f74596bf 100644
--- a/path.c
+++ b/path.c
@@ -3,7 +3,6 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "abspath.h"
@@ -1141,12 +1140,12 @@ int strbuf_normalize_path(struct strbuf *src)
  */
 int longest_ancestor_length(const char *path, struct string_list *prefixes)
 {
-	int i, max_len = -1;
+	int max_len = -1;
 
 	if (!strcmp(path, "/"))
 		return -1;
 
-	for (i = 0; i < prefixes->nr; i++) {
+	for (size_t i = 0; i < prefixes->nr; i++) {
 		const char *ceil = prefixes->items[i].string;
 		int len = strlen(ceil);
 
diff --git a/pkt-line.c b/pkt-line.c
index f48b558ad23dd99f334d2d60e954ce9a83ac6114..a2bce206c2f9aab77cbb591c45323011ec97a8dd 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -1,5 +1,3 @@
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "git-compat-util.h"
 #include "copy.h"
 #include "pkt-line.h"
@@ -41,7 +39,6 @@ static int packet_trace_pack(const char *buf, unsigned int len, int sideband)
 
 static void packet_trace(const char *buf, unsigned int len, int write)
 {
-	int i;
 	struct strbuf out;
 	static int in_pack, sideband;
 
@@ -74,7 +71,7 @@ static void packet_trace(const char *buf, unsigned int len, int write)
 		    get_trace_prefix(), write ? '>' : '<');
 
 	/* XXX we should really handle printable utf8 */
-	for (i = 0; i < len; i++) {
+	for (unsigned int i = 0; i < len; i++) {
 		/* suppress newlines */
 		if (buf[i] == '\n')
 			continue;
diff --git a/refs/debug.c b/refs/debug.c
index 5082e83c8d6b08a5ae75f353b853746bcee217b6..aa67a0588b66555610607ca7b98efc7f549e1f41 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -1,5 +1,3 @@
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "git-compat-util.h"
 #include "hex.h"
 #include "refs-internal.h"
@@ -85,9 +83,8 @@ static void print_update(int i, const char *refname,
 
 static void print_transaction(struct ref_transaction *transaction)
 {
-	int i;
 	trace_printf_key(&trace_refs, "transaction {\n");
-	for (i = 0; i < transaction->nr; i++) {
+	for (size_t i = 0; i < transaction->nr; i++) {
 		struct ref_update *u = transaction->updates[i];
 		print_update(i, u->refname, &u->old_oid, &u->new_oid, u->flags,
 			     u->type, u->msg);
diff --git a/send-pack.c b/send-pack.c
index 6e68074e50dbc48622b0e63e56cfbe3560dcd605..7e8321368379efe2600a1f573e2e4cd5140a008d 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "config.h"
@@ -73,7 +72,6 @@ static int pack_objects(int fd, struct ref *refs, struct oid_array *advertised,
 	 */
 	struct child_process po = CHILD_PROCESS_INIT;
 	FILE *po_in;
-	int i;
 	int rc;
 
 	trace2_region_enter("send_pack", "pack_objects", the_repository);
@@ -105,9 +103,9 @@ static int pack_objects(int fd, struct ref *refs, struct oid_array *advertised,
 	 * parameters by writing to the pipe.
 	 */
 	po_in = xfdopen(po.in, "w");
-	for (i = 0; i < advertised->nr; i++)
+	for (size_t i = 0; i < advertised->nr; i++)
 		feed_object(&advertised->oid[i], po_in, 1);
-	for (i = 0; i < negotiated->nr; i++)
+	for (size_t i = 0; i < negotiated->nr; i++)
 		feed_object(&negotiated->oid[i], po_in, 1);
 
 	while (refs) {
diff --git a/serve.c b/serve.c
index 1e08fa92510c5f78e675aa0e91c8505018d5dcfa..c8694e375159ca0044cb045500954770e1e5cb93 100644
--- a/serve.c
+++ b/serve.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "repository.h"
@@ -164,12 +163,11 @@ void protocol_v2_advertise_capabilities(void)
 {
 	struct strbuf capability = STRBUF_INIT;
 	struct strbuf value = STRBUF_INIT;
-	int i;
 
 	/* serve by default supports v2 */
 	packet_write_fmt(1, "version 2\n");
 
-	for (i = 0; i < ARRAY_SIZE(capabilities); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(capabilities); i++) {
 		struct protocol_capability *c = &capabilities[i];
 
 		if (c->advertise(the_repository, &value)) {
@@ -195,12 +193,10 @@ void protocol_v2_advertise_capabilities(void)
 
 static struct protocol_capability *get_capability(const char *key, const char **value)
 {
-	int i;
-
 	if (!key)
 		return NULL;
 
-	for (i = 0; i < ARRAY_SIZE(capabilities); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(capabilities); i++) {
 		struct protocol_capability *c = &capabilities[i];
 		const char *out;
 		if (!skip_prefix(key, c->name, &out))
diff --git a/strvec.c b/strvec.c
index 03d6eee6cdd1b17b1dec8be7fb148a9317464b2b..59b4ca7695dde37532af3eb4c45318fae4652c21 100644
--- a/strvec.c
+++ b/strvec.c
@@ -1,5 +1,3 @@
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "git-compat-util.h"
 #include "strvec.h"
 #include "strbuf.h"
@@ -110,8 +108,7 @@ void strvec_split(struct strvec *array, const char *to_split)
 void strvec_clear(struct strvec *array)
 {
 	if (array->v != empty_strvec) {
-		int i;
-		for (i = 0; i < array->nr; i++)
+		for (size_t i = 0; i < array->nr; i++)
 			free((char *)array->v[i]);
 		free(array->v);
 	}
diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index 8d4ef441312e2059058c6465b0c084e6f31921cc..14e075c1a11a4e06f111df4d410f0a11354ea4b8 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "test-tool.h"
 #include "bloom.h"
@@ -12,30 +11,25 @@ static struct bloom_filter_settings settings = DEFAULT_BLOOM_FILTER_SETTINGS;
 
 static void add_string_to_filter(const char *data, struct bloom_filter *filter) {
 		struct bloom_key key;
-		int i;
 
 		fill_bloom_key(data, strlen(data), &key, &settings);
 		printf("Hashes:");
-		for (i = 0; i < settings.num_hashes; i++){
+		for (size_t i = 0; i < settings.num_hashes; i++)
 			printf("0x%08x|", key.hashes[i]);
-		}
 		printf("\n");
 		add_key_to_filter(&key, filter, &settings);
 		clear_bloom_key(&key);
 }
 
 static void print_bloom_filter(struct bloom_filter *filter) {
-	int i;
-
 	if (!filter) {
 		printf("No filter.\n");
 		return;
 	}
 	printf("Filter_Length:%d\n", (int)filter->len);
 	printf("Filter_Data:");
-	for (i = 0; i < filter->len; i++) {
+	for (size_t i = 0; i < filter->len; i++)
 		printf("%02x|", filter->data[i]);
-	}
 	printf("\n");
 }
 
diff --git a/t/helper/test-dump-fsmonitor.c b/t/helper/test-dump-fsmonitor.c
index 7b78f9d182d89dae4878e0ecf3e0bd99f79bfd39..efd017ca357e0b27b5bd5d07a62f1fd5d1d7d843 100644
--- a/t/helper/test-dump-fsmonitor.c
+++ b/t/helper/test-dump-fsmonitor.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "test-tool.h"
 #include "read-cache-ll.h"
@@ -9,7 +8,6 @@
 int cmd__dump_fsmonitor(int ac UNUSED, const char **av UNUSED)
 {
 	struct index_state *istate = the_repository->index;
-	int i;
 
 	setup_git_directory();
 	if (do_read_index(istate, the_repository->index_file, 0) < 0)
@@ -20,7 +18,7 @@ int cmd__dump_fsmonitor(int ac UNUSED, const char **av UNUSED)
 	}
 	printf("fsmonitor last update %s\n", istate->fsmonitor_last_update);
 
-	for (i = 0; i < istate->cache_nr; i++)
+	for (size_t i = 0; i < istate->cache_nr; i++)
 		printf((istate->cache[i]->ce_flags & CE_FSMONITOR_VALID) ? "+" : "-");
 
 	return 0;
diff --git a/t/helper/test-dump-split-index.c b/t/helper/test-dump-split-index.c
index f31b44a7677a96ed2f2eec870ded3af8d1b2a79e..f855a3862c97bb3af7a2a3a83c6a5a033b4a3dea 100644
--- a/t/helper/test-dump-split-index.c
+++ b/t/helper/test-dump-split-index.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "test-tool.h"
 #include "hex.h"
@@ -17,7 +16,6 @@ static void show_bit(size_t pos, void *data UNUSED)
 int cmd__dump_split_index(int ac UNUSED, const char **av)
 {
 	struct split_index *si;
-	int i;
 
 	setup_git_directory();
 
@@ -29,7 +27,7 @@ int cmd__dump_split_index(int ac UNUSED, const char **av)
 		return 0;
 	}
 	printf("base %s\n", oid_to_hex(&si->base_oid));
-	for (i = 0; i < the_repository->index->cache_nr; i++) {
+	for (size_t i = 0; i < the_repository->index->cache_nr; i++) {
 		struct cache_entry *ce = the_repository->index->cache[i];
 		printf("%06o %s %d\t%s\n", ce->ce_mode,
 		       oid_to_hex(&ce->oid), ce_stage(ce), ce->name);
diff --git a/t/helper/test-dump-untracked-cache.c b/t/helper/test-dump-untracked-cache.c
index ae057958000e41959ec452c6577287fbd8475173..01a109496bee7872d098ba3ac64c9e7e07404da7 100644
--- a/t/helper/test-dump-untracked-cache.c
+++ b/t/helper/test-dump-untracked-cache.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "test-tool.h"
 #include "dir.h"
@@ -24,7 +23,7 @@ static int compare_dir(const void *a_, const void *b_)
 
 static void dump(struct untracked_cache_dir *ucd, struct strbuf *base)
 {
-	int i, len;
+	int len;
 	QSORT(ucd->untracked, ucd->untracked_nr, compare_untracked);
 	QSORT(ucd->dirs, ucd->dirs_nr, compare_dir);
 	len = base->len;
@@ -38,9 +37,9 @@ static void dump(struct untracked_cache_dir *ucd, struct strbuf *base)
 	if (ucd->valid)
 		fputs(" valid", stdout);
 	printf("\n");
-	for (i = 0; i < ucd->untracked_nr; i++)
+	for (size_t i = 0; i < ucd->untracked_nr; i++)
 		printf("%s\n", ucd->untracked[i]);
-	for (i = 0; i < ucd->dirs_nr; i++)
+	for (size_t i = 0; i < ucd->dirs_nr; i++)
 		dump(ucd->dirs[i], base);
 	strbuf_setlen(base, len);
 }
diff --git a/t/helper/test-hash-speed.c b/t/helper/test-hash-speed.c
index 81a446dd64e4134585f90a01c28e95edf0b059de..80df1aae66b6242e91725bd7ad8d3e72742034b3 100644
--- a/t/helper/test-hash-speed.c
+++ b/t/helper/test-hash-speed.c
@@ -1,5 +1,3 @@
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "test-tool.h"
 #include "hash.h"
 
@@ -18,12 +16,11 @@ int cmd__hash_speed(int ac, const char **av)
 	unsigned char hash[GIT_MAX_RAWSZ];
 	clock_t initial, start, end;
 	unsigned bufsizes[] = { 64, 256, 1024, 8192, 16384 };
-	int i;
 	void *p;
 	const struct git_hash_algo *algo = NULL;
 
 	if (ac == 2) {
-		for (i = 1; i < GIT_HASH_NALGOS; i++) {
+		for (size_t i = 1; i < GIT_HASH_NALGOS; i++) {
 			if (!strcmp(av[1], hash_algos[i].name)) {
 				algo = &hash_algos[i];
 				break;
@@ -38,7 +35,7 @@ int cmd__hash_speed(int ac, const char **av)
 
 	printf("algo: %s\n", algo->name);
 
-	for (i = 0; i < ARRAY_SIZE(bufsizes); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(bufsizes); i++) {
 		unsigned long j, kb;
 		double kb_per_sec;
 		p = xcalloc(1, bufsizes[i]);
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index f6acd09941b9d14af3dff6f5d90a478bb7e8dd85..93792ee46e19a18d2acfdc22ee4448755f18485f 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -1,5 +1,3 @@
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "test-tool.h"
 #include "parse-options.h"
 #include "strbuf.h"
@@ -176,7 +174,6 @@ int cmd__parse_options(int argc, const char **argv)
 		OPT_ALIAS('Z', "alias-target", "alias-source"),
 		OPT_END(),
 	};
-	int i;
 	int ret = 0;
 
 	trace2_cmd_name("_parse_");
@@ -200,10 +197,10 @@ int cmd__parse_options(int argc, const char **argv)
 	show(&expect, &ret, "dry run: %s", dry_run ? "yes" : "no");
 	show(&expect, &ret, "file: %s", file ? file : "(not set)");
 
-	for (i = 0; i < list.nr; i++)
+	for (size_t i = 0; i < list.nr; i++)
 		show(&expect, &ret, "list: %s", list.items[i].string);
 
-	for (i = 0; i < argc; i++)
+	for (int i = 0; i < argc; i++)
 		show(&expect, &ret, "arg %02d: %s", i, argv[i]);
 
 	expect.strdup_strings = 1;
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 25c232464df1639766c2db013d6e5b4b7021cbb2..01cf77ae65b9a7db2f31a9a1558b8bb84b2e81d3 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "test-tool.h"
 #include "commit.h"
@@ -14,7 +13,6 @@
 
 static void print_sorted_commit_ids(struct commit_list *list)
 {
-	int i;
 	struct string_list s = STRING_LIST_INIT_DUP;
 
 	while (list) {
@@ -24,7 +22,7 @@ static void print_sorted_commit_ids(struct commit_list *list)
 
 	string_list_sort(&s);
 
-	for (i = 0; i < s.nr; i++)
+	for (size_t i = 0; i < s.nr; i++)
 		printf("%s\n", s.items[i].string);
 
 	string_list_clear(&s, 0);
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index b1c2b8b3eb0686b9a62780687ecce17682416308..e84529f7c045b66f7cf319a08973a521088618b9 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "test-tool.h"
 #include "hex.h"
@@ -25,14 +24,13 @@ struct flag_definition {
 static unsigned int parse_flags(const char *str, struct flag_definition *defs)
 {
 	struct string_list masks = STRING_LIST_INIT_DUP;
-	int i = 0;
 	unsigned int result = 0;
 
 	if (!strcmp(str, "0"))
 		return 0;
 
 	string_list_split(&masks, str, ',', 64);
-	for (; i < masks.nr; i++) {
+	for (size_t i = 0; i < masks.nr; i++) {
 		const char *name = masks.items[i].string;
 		struct flag_definition *def = defs;
 		int found = 0;
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index b626f64eca47cce16abdd9915462af46c66b0044..4a7aa993ba99e2791718e0d7206158aad207dc56 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -1,5 +1,3 @@
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "git-compat-util.h"
 #include "test-tool.h"
 #include "test-tool-utils.h"
@@ -103,7 +101,6 @@ static NORETURN void die_usage(void)
 
 int cmd_main(int argc, const char **argv)
 {
-	int i;
 	const char *working_directory = NULL;
 	struct option options[] = {
 		OPT_STRING('C', NULL, &working_directory, "directory",
@@ -122,7 +119,7 @@ int cmd_main(int argc, const char **argv)
 	if (working_directory && chdir(working_directory) < 0)
 		die("Could not cd to '%s'", working_directory);
 
-	for (i = 0; i < ARRAY_SIZE(cmds); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(cmds); i++) {
 		if (!strcmp(cmds[i].name, argv[1])) {
 			argv++;
 			argc--;
diff --git a/t/unit-tests/t-example-decorate.c b/t/unit-tests/t-example-decorate.c
index 61da8e1c8bedb6313369bc5eefd63b5aa54f78d6..bfc776e223868735f36276f454b4932298800749 100644
--- a/t/unit-tests/t-example-decorate.c
+++ b/t/unit-tests/t-example-decorate.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "test-lib.h"
 #include "object.h"
@@ -43,9 +42,9 @@ static void t_lookup(struct test_vars *vars)
 
 static void t_loop(struct test_vars *vars)
 {
-	int i, objects_noticed = 0;
+	int objects_noticed = 0;
 
-	for (i = 0; i < vars->n.size; i++) {
+	for (size_t i = 0; i < vars->n.size; i++) {
 		if (vars->n.entries[i].base)
 			objects_noticed++;
 	}
diff --git a/t/unit-tests/t-prio-queue.c b/t/unit-tests/t-prio-queue.c
index a3d1aabab5ce08aedbce2ff815d0676d8784bad6..a0536350003b81a9f8afbc10627afa503a891e10 100644
--- a/t/unit-tests/t-prio-queue.c
+++ b/t/unit-tests/t-prio-queue.c
@@ -1,5 +1,3 @@
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "test-lib.h"
 #include "prio-queue.h"
 
@@ -27,7 +25,7 @@ static void test_prio_queue(int *input, size_t input_size,
 	struct prio_queue pq = { intcmp };
 	int j = 0;
 
-	for (int i = 0; i < input_size; i++) {
+	for (size_t i = 0; i < input_size; i++) {
 		void *peek, *get;
 		switch(input[i]) {
 		case GET:
diff --git a/tmp-objdir.c b/tmp-objdir.c
index b9084d0ac3cf8b4de879951a6f2480f26635172b..659fcdcc2954ed392f9e241667ea6a7d2c79b828 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "tmp-objdir.h"
@@ -238,7 +237,6 @@ static int migrate_paths(struct strbuf *src, struct strbuf *dst,
 {
 	size_t src_len = src->len, dst_len = dst->len;
 	struct string_list paths = STRING_LIST_INIT_DUP;
-	int i;
 	int ret = 0;
 
 	if (read_dir_paths(&paths, src->buf) < 0)
@@ -246,7 +244,7 @@ static int migrate_paths(struct strbuf *src, struct strbuf *dst,
 	paths.cmp = pack_copy_cmp;
 	string_list_sort(&paths);
 
-	for (i = 0; i < paths.nr; i++) {
+	for (size_t i = 0; i < paths.nr; i++) {
 		const char *name = paths.items[i].string;
 		enum finalize_object_file_flags flags_copy = flags;
 
diff --git a/trailer.c b/trailer.c
index b7e406328534e8904c7fe7980e22d7777e6c4002..310cf582dc370374953b0c7ecef90d6e616c9942 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "config.h"
@@ -523,7 +522,6 @@ static int git_trailer_config(const char *conf_key, const char *value,
 	struct conf_info *conf;
 	char *name = NULL;
 	enum trailer_info_type type;
-	int i;
 
 	if (!skip_prefix(conf_key, "trailer.", &trailer_item))
 		return 0;
@@ -533,7 +531,7 @@ static int git_trailer_config(const char *conf_key, const char *value,
 		return 0;
 
 	variable_name++;
-	for (i = 0; i < ARRAY_SIZE(trailer_config_items); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(trailer_config_items); i++) {
 		if (strcmp(trailer_config_items[i].name, variable_name))
 			continue;
 		name = xstrndup(trailer_item,  variable_name - trailer_item - 1);
diff --git a/transport-helper.c b/transport-helper.c
index 387c67d5bd198e01250addbcfc12b59868d2007e..d457b425501a74d8837cdbb41855a205fc151b01 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "transport.h"
@@ -314,9 +313,9 @@ static int string_list_set_helper_option(struct helper_data *data,
 					 struct string_list *list)
 {
 	struct strbuf buf = STRBUF_INIT;
-	int i, ret = 0;
+	int ret = 0;
 
-	for (i = 0; i < list->nr; i++) {
+	for (size_t i = 0; i < list->nr; i++) {
 		strbuf_addf(&buf, "option %s ", name);
 		quote_c_style(list->items[i].string, &buf, NULL, 0);
 		strbuf_addch(&buf, '\n');
@@ -334,7 +333,7 @@ static int set_helper_option(struct transport *transport,
 {
 	struct helper_data *data = transport->data;
 	struct strbuf buf = STRBUF_INIT;
-	int i, ret, is_bool = 0;
+	int ret, is_bool = 0;
 
 	get_helper(transport);
 
@@ -345,12 +344,12 @@ static int set_helper_option(struct transport *transport,
 		return string_list_set_helper_option(data, name,
 						     (struct string_list *)value);
 
-	for (i = 0; i < ARRAY_SIZE(unsupported_options); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(unsupported_options); i++) {
 		if (!strcmp(name, unsupported_options[i]))
 			return 1;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(boolean_options); i++) {
+	for (size_t i = 0; i < ARRAY_SIZE(boolean_options); i++) {
 		if (!strcmp(name, boolean_options[i])) {
 			is_bool = 1;
 			break;
@@ -482,7 +481,6 @@ static int get_exporter(struct transport *transport,
 {
 	struct helper_data *data = transport->data;
 	struct child_process *helper = get_helper(transport);
-	int i;
 
 	child_process_init(fastexport);
 
@@ -498,7 +496,7 @@ static int get_exporter(struct transport *transport,
 	if (data->import_marks)
 		strvec_pushf(&fastexport->args, "--import-marks=%s", data->import_marks);
 
-	for (i = 0; i < revlist_args->nr; i++)
+	for (size_t i = 0; i < revlist_args->nr; i++)
 		strvec_push(&fastexport->args, revlist_args->items[i].string);
 
 	fastexport->git_cmd = 1;
diff --git a/transport.c b/transport.c
index abf0ff57066edb0f88d5ab06306e4d58c98017dd..d94ed4f98f338eb4eeec56ff05a022a1a64bc3a9 100644
--- a/transport.c
+++ b/transport.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "advice.h"
@@ -48,7 +47,6 @@ static int transport_color_config(void)
 		"color.transport.rejected"
 	}, *key = "color.transport";
 	char *value;
-	int i;
 	static int initialized;
 
 	if (initialized)
@@ -61,7 +59,7 @@ static int transport_color_config(void)
 	if (!want_color_stderr(transport_use_color))
 		return 0;
 
-	for (i = 0; i < ARRAY_SIZE(keys); i++)
+	for (size_t i = 0; i < ARRAY_SIZE(keys); i++)
 		if (!git_config_get_string(keys[i], &value)) {
 			if (!value)
 				return config_error_nonbool(keys[i]);
@@ -154,14 +152,13 @@ static struct ref *get_refs_from_bundle(struct transport *transport,
 {
 	struct bundle_transport_data *data = transport->data;
 	struct ref *result = NULL;
-	int i;
 
 	if (for_push)
 		return NULL;
 
 	get_refs_from_bundle_inner(transport);
 
-	for (i = 0; i < data->header.references.nr; i++) {
+	for (size_t i = 0; i < data->header.references.nr; i++) {
 		struct string_list_item *e = data->header.references.items + i;
 		const char *name = e->string;
 		struct ref *ref = alloc_ref(name);
@@ -1282,11 +1279,9 @@ void transport_set_verbosity(struct transport *transport, int verbosity,
 
 static void die_with_unpushed_submodules(struct string_list *needs_pushing)
 {
-	int i;
-
 	fprintf(stderr, _("The following submodule paths contain changes that can\n"
 			"not be found on any remote:\n"));
-	for (i = 0; i < needs_pushing->nr; i++)
+	for (size_t i = 0; i < needs_pushing->nr; i++)
 		fprintf(stderr, "  %s\n", needs_pushing->items[i].string);
 	fprintf(stderr, _("\nPlease try\n\n"
 			  "	git push --recurse-submodules=on-demand\n\n"
@@ -1602,9 +1597,8 @@ int transport_get_remote_bundle_uri(struct transport *transport)
 void transport_unlock_pack(struct transport *transport, unsigned int flags)
 {
 	int in_signal_handler = !!(flags & TRANSPORT_UNLOCK_PACK_IN_SIGNAL_HANDLER);
-	int i;
 
-	for (i = 0; i < transport->pack_lockfiles.nr; i++)
+	for (size_t i = 0; i < transport->pack_lockfiles.nr; i++)
 		if (in_signal_handler)
 			unlink(transport->pack_lockfiles.items[i].string);
 		else
diff --git a/usage.c b/usage.c
index 00696d447bade5474c279a3ba4f58ecb48d9fb35..14e5ed51e709faf38bf1ecfa7666d2494d641d18 100644
--- a/usage.c
+++ b/usage.c
@@ -4,8 +4,6 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "trace2.h"
@@ -192,7 +190,7 @@ void NORETURN die(const char *err, ...)
 static const char *fmt_with_err(char *buf, int n, const char *fmt)
 {
 	char str_error[256], *err;
-	int i, j;
+	size_t i, j;
 
 	err = strerror(errno);
 	for (i = j = 0; err[i] && j < sizeof(str_error) - 1; ) {
diff --git a/version.c b/version.c
index d5aadab709e06dcd55765f36ba8e949cfa1541f1..44cd39ae26baa38e1ceaf3ee7a44dfece8719db0 100644
--- a/version.c
+++ b/version.c
@@ -1,4 +1,3 @@
-#define DISABLE_SIGN_COMPARE_WARNINGS
 #include "git-compat-util.h"
 #include "version.h"
 #include "strbuf.h"
@@ -25,11 +24,10 @@ const char *git_user_agent_sanitized(void)
 
 	if (!agent) {
 		struct strbuf buf = STRBUF_INIT;
-		int i;
 
 		strbuf_addstr(&buf, git_user_agent());
 		strbuf_trim(&buf);
-		for (i = 0; i < buf.len; i++) {
+		for (size_t i = 0; i < buf.len; i++) {
 			if (buf.buf[i] <= 32 || buf.buf[i] >= 127)
 				buf.buf[i] = '.';
 		}
diff --git a/versioncmp.c b/versioncmp.c
index 71cef7e85862270b537df3dface350a6462e94ed..b6eebdb989c04264124fa501f19b6c346f56f7e1 100644
--- a/versioncmp.c
+++ b/versioncmp.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "config.h"
@@ -78,11 +77,10 @@ static int swap_prereleases(const char *s1,
 			    int off,
 			    int *diff)
 {
-	int i;
 	struct suffix_match match1 = { -1, off, -1 };
 	struct suffix_match match2 = { -1, off, -1 };
 
-	for (i = 0; i < prereleases->nr; i++) {
+	for (size_t i = 0; i < prereleases->nr; i++) {
 		const char *suffix = prereleases->items[i].string;
 		int start, suffix_len = strlen(suffix);
 		if (suffix_len < off)

-- 
2.47.0.366.g5daf58cba8.dirty

