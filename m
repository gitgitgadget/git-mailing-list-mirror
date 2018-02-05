Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69BB01F404
	for <e@80x24.org>; Mon,  5 Feb 2018 23:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750862AbeBEX4e (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 18:56:34 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35231 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752156AbeBEX4B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 18:56:01 -0500
Received: by mail-pl0-f68.google.com with SMTP id j19so92304pll.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 15:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J0Z2APcc/G0XPEMksPssSQatiLMcJJ5wfgow2CiJAns=;
        b=eNA/7mz/IA9mk9TJ6K4MwVZ2ff5P7niAn3DpChIdMuPlSnrImUs9cliPhuHXksPqYW
         dZW3wU+oIAc9fYoe/ijIYnetLW69QxvyFGJ8dsiUzJFrRhbqMbk0NMjUyu2Pun0J4mN0
         Nwz6vZbs3LUOsLvy0uFJbUTORqqY6jS/FG1C39sBSHHTTIBoU81za2IUPeQtkiAHaWl2
         GGjdaNfwUaoioxDE1HmAFjx0G8k1l+p8/5H90m98tEk+q7IYTdwaLdGVlZFGrMTTZSlw
         b0k5kYiCPE5ru5K5rGmacxdEnmPFZRlI6olv1ZY3KSoknBFXammP/M1Gzr4e38rHxfHl
         0r2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J0Z2APcc/G0XPEMksPssSQatiLMcJJ5wfgow2CiJAns=;
        b=GB7wWQeqZnKCjK/gZgUTB9zGCpb8IGxk5mJ/Ps08tY4TVxqxEbCjk3jY3R7cH8fTGX
         LD4Q/HY6tW9rn6e91vJoeaqQhyYuw2vWoI1Cyh39LPl7q9LzfzmrmhkrDecWOJaE8fWB
         NX9bNP87PQx3ByM9mtK8exvgVqGv6XpNCZVjO3VLe8SStWbwLW4NRd9oqPsxibwcRlKi
         j047AxbN00/1OCJDFuKcyiDuXY7qMap/PWgBd2WByQ32S2Q9jrlVlWJkWmG1GYEFVAdQ
         aya1AjhcNy4ay/UtFRUPm3/yBQ2BTqcWxmuLEFZsdOLT9QzwsmlqigApRN+6IjMDQJsN
         j/hQ==
X-Gm-Message-State: APf1xPDbDZOd7DMFX7feW53fI3hFeX3X4bzNkvYeJnnZUBSLybyXJ94Z
        072kwYpk0fnxsAAsaMKcTlk9zRtsOUE=
X-Google-Smtp-Source: AH8x2243BqJdMwcZhMBYDUH1NTA0tXR7udmrL2V7rSLI6JNNSnjOW303eTHp+3hJarmy29/etKPh2w==
X-Received: by 2002:a17:902:968d:: with SMTP id n13-v6mr499033plp.33.1517874960352;
        Mon, 05 Feb 2018 15:56:00 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id r2sm6171946pgt.75.2018.02.05.15.55.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 15:55:59 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 020/194] pack: add repository argument to prepare_packed_git
Date:   Mon,  5 Feb 2018 15:52:14 -0800
Message-Id: <20180205235508.216277-21-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235508.216277-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Add a repository argument to allow prepare_packed_git_mru callers to
be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

Callers adapted using contrib/coccinelle/packed_git.cocci.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/count-objects.c             |  2 +-
 builtin/fsck.c                      |  2 +-
 builtin/gc.c                        |  2 +-
 builtin/pack-objects.c              |  2 +-
 builtin/pack-redundant.c            |  2 +-
 contrib/coccinelle/packed_git.cocci |  4 ++++
 fast-import.c                       |  2 +-
 http-backend.c                      |  2 +-
 pack-bitmap.c                       |  2 +-
 packfile.c                          | 10 +++++-----
 packfile.h                          |  3 ++-
 server-info.c                       |  2 +-
 sha1_name.c                         |  4 ++--
 13 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 843a7d7d7e..e340b3e3c3 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -123,7 +123,7 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 		struct strbuf pack_buf = STRBUF_INIT;
 		struct strbuf garbage_buf = STRBUF_INIT;
 		if (!the_repository->objects.packed_git)
-			prepare_packed_git();
+			prepare_packed_git(the_repository);
 		for (p = the_repository->objects.packed_git; p; p = p->next) {
 			if (!p->pack_local)
 				continue;
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 00ec8eecf0..0e78f4ba72 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -705,7 +705,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			uint32_t total = 0, count = 0;
 			struct progress *progress = NULL;
 
-			prepare_packed_git();
+			prepare_packed_git(the_repository);
 
 			if (show_progress) {
 				for (p = the_repository->objects.packed_git; p;
diff --git a/builtin/gc.c b/builtin/gc.c
index 6970f325e5..00a3b402a8 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -174,7 +174,7 @@ static int too_many_packs(void)
 	if (gc_auto_pack_limit <= 0)
 		return 0;
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	for (cnt = 0, p = the_repository->objects.packed_git; p; p = p->next) {
 		if (!p->pack_local)
 			continue;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 2ee8b69238..d42df2a2b9 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3121,7 +3121,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (progress && all_progress_implied)
 		progress = 2;
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	if (ignore_packed_keep) {
 		struct packed_git *p;
 		for (p = the_repository->objects.packed_git; p; p = p->next)
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 55462bc826..83d2395dae 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -631,7 +631,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
 			break;
 	}
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 
 	if (load_all_packs)
 		load_all();
diff --git a/contrib/coccinelle/packed_git.cocci b/contrib/coccinelle/packed_git.cocci
index da317a51a9..7554f4773c 100644
--- a/contrib/coccinelle/packed_git.cocci
+++ b/contrib/coccinelle/packed_git.cocci
@@ -5,3 +5,7 @@
 @@ @@
 - packed_git_mru
 + the_repository->objects.packed_git_mru
+
+@@ @@
+- prepare_packed_git()
++ prepare_packed_git(the_repository)
diff --git a/fast-import.c b/fast-import.c
index 67550584da..39cd0b7540 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3471,7 +3471,7 @@ int cmd_main(int argc, const char **argv)
 		rc_free[i].next = &rc_free[i + 1];
 	rc_free[cmd_save - 1].next = NULL;
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	start_packfile();
 	set_die_routine(die_nicely);
 	set_checkpoint_signal();
diff --git a/http-backend.c b/http-backend.c
index 4d93126c15..4950078c93 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -519,7 +519,7 @@ static void get_info_packs(struct strbuf *hdr, char *arg)
 	size_t cnt = 0;
 
 	select_getanyfile(hdr);
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	for (p = the_repository->objects.packed_git; p; p = p->next) {
 		if (p->pack_local)
 			cnt++;
diff --git a/pack-bitmap.c b/pack-bitmap.c
index d51172b1d5..273bdfb631 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -336,7 +336,7 @@ static int open_pack_bitmap(void)
 
 	assert(!bitmap_git.map && !bitmap_git.loaded);
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	for (p = the_repository->objects.packed_git; p; p = p->next) {
 		if (open_pack_bitmap_1(p) == 0)
 			ret = 0;
diff --git a/packfile.c b/packfile.c
index b4ace96f0c..bf7e6d22ce 100644
--- a/packfile.c
+++ b/packfile.c
@@ -807,7 +807,7 @@ unsigned long approximate_object_count(void)
 		unsigned long count;
 		struct packed_git *p;
 
-		prepare_packed_git();
+		prepare_packed_git(the_repository);
 		count = 0;
 		for (p = the_repository->objects.packed_git; p; p = p->next) {
 			if (open_pack_index(p))
@@ -875,7 +875,7 @@ static void prepare_packed_git_mru_the_repository(void)
 		mru_append(&the_repository->objects.packed_git_mru, p);
 }
 
-void prepare_packed_git(void)
+void prepare_packed_git_the_repository(void)
 {
 	struct alternate_object_database *alt;
 
@@ -894,7 +894,7 @@ void reprepare_packed_git(void)
 {
 	the_repository->objects.approximate_object_count_valid = 0;
 	the_repository->objects.packed_git_initialized = 0;
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 }
 
 unsigned long unpack_object_header_buffer(const unsigned char *buf,
@@ -1836,7 +1836,7 @@ int find_pack_entry(const unsigned char *sha1, struct pack_entry *e)
 {
 	struct mru_entry *p;
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	if (!the_repository->objects.packed_git)
 		return 0;
 
@@ -1888,7 +1888,7 @@ int for_each_packed_object(each_packed_object_fn cb, void *data, unsigned flags)
 	int r = 0;
 	int pack_errors = 0;
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	for (p = the_repository->objects.packed_git; p; p = p->next) {
 		if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
 			continue;
diff --git a/packfile.h b/packfile.h
index 7e6959d440..e543a98b23 100644
--- a/packfile.h
+++ b/packfile.h
@@ -32,7 +32,8 @@ extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_
 #define PACKDIR_FILE_GARBAGE 4
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
-extern void prepare_packed_git(void);
+#define prepare_packed_git(r) prepare_packed_git_##r()
+extern void prepare_packed_git_the_repository(void);
 extern void reprepare_packed_git(void);
 #define install_packed_git(r, p) install_packed_git_##r(p)
 extern void install_packed_git_the_repository(struct packed_git *pack);
diff --git a/server-info.c b/server-info.c
index 96885c45f6..6cd1506e5e 100644
--- a/server-info.c
+++ b/server-info.c
@@ -201,7 +201,7 @@ static void init_pack_info(const char *infofile, int force)
 	objdir = get_object_directory();
 	objdirlen = strlen(objdir);
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	for (p = the_repository->objects.packed_git; p; p = p->next) {
 		/* we ignore things on alternate path since they are
 		 * not available to the pullers in general.
diff --git a/sha1_name.c b/sha1_name.c
index 3e490ee8f6..d3769713ea 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -196,7 +196,7 @@ static void find_short_packed_object(struct disambiguate_state *ds)
 {
 	struct packed_git *p;
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	for (p = the_repository->objects.packed_git; p && !ds->ambiguous;
 	     p = p->next)
 		unique_in_pack(p, ds);
@@ -567,7 +567,7 @@ static void find_abbrev_len_packed(struct min_abbrev_data *mad)
 {
 	struct packed_git *p;
 
-	prepare_packed_git();
+	prepare_packed_git(the_repository);
 	for (p = the_repository->objects.packed_git; p; p = p->next)
 		find_abbrev_len_for_pack(p, mad);
 }
-- 
2.15.1.433.g936d1b9894.dirty

