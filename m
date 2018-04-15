Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F177B1F404
	for <e@80x24.org>; Sun, 15 Apr 2018 15:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752652AbeDOPgv (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 11:36:51 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35847 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752470AbeDOPgf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 11:36:35 -0400
Received: by mail-lf0-f68.google.com with SMTP id d20-v6so18611237lfe.3
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 08:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bMFgMzUD+cEx5ejrQyWE8QA/cT3BD2NsxF2gIwqlb0s=;
        b=D2z8tyewMtdduyAzx61cR271oRdAWY2OrAAzyGiBz+9FOQ519WzcfsZ/zIVDIKXrMg
         5iu4Na2Tw+dJ9f96akJmczRj8el9/TKDjK0yWzrpodS4Q1lmYjWluNi6NXsqVXiKU+Zu
         JjAfmlZrlEhiChBciHn1i3+GfkPdM4/+vg4nUFXNSjtMJPLL4PgW0y1vHyzc0ScQpZkH
         T4kIph87uW+dc8ajZYzRqiUl17KcIYEE9hwoeltqyoSgYSYV6DyDrUatalnHQrsNxqC+
         RlgiNZ5WZpMQFHn+m7S0aUMwWMFAWzTxLruzjkBUDGQiMDnWqAeP1UcQiS22zaMdWpPo
         usKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bMFgMzUD+cEx5ejrQyWE8QA/cT3BD2NsxF2gIwqlb0s=;
        b=rqQfY5jQqjdRn8yP43bHEtWVPeHqNOxhl2brzPfSxIFDAEBFgu5Oy3frGIMfV6CSen
         3zRCyAiR8yTRmCIq3SRLHBE14dwh7TVJJpPkOVMxd5rWGs9iYLYdDfG5zW0q2tyzHpDW
         RT7aMF1ro4q03froGwbEL0aKJEnBCLI/zJQQ/g76IDRznk8AFOExvzyNN4m9Wrq5z6GX
         qdon/ac2Dt5bNEWjWkc09K7DBb9uQ2F0QabHkmLUdh0knDDJujhRZATDl5tSPxeFMomO
         oMQHBbbSaHW0ewH1xCzkugexc1YSQ9nPtjS2BjuHb9jym7e4tgqduWljcxS1DwEkwVWf
         ZQwg==
X-Gm-Message-State: ALQs6tCJMHIgZQi3XfrltL3OyWRCL4UIbHOfWTFqZuqa5My5cWvlkM0I
        lA8GciLxnkF8SctQh5EJpPs=
X-Google-Smtp-Source: AIpwx4/2RAzcGf8Y2LbtXlhInX2Q2aX2J/6r5L6ZnCTMYyAqYPrcQeNp/cYLOB1KGxcEDbvJkFcIZA==
X-Received: by 2002:a19:921a:: with SMTP id u26-v6mr12032053lfd.112.1523806593537;
        Sun, 15 Apr 2018 08:36:33 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id w10sm826176lji.47.2018.04.15.08.36.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Apr 2018 08:36:32 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>
Subject: [PATCH v2 3/7] gc: add --keep-largest-pack option
Date:   Sun, 15 Apr 2018 17:36:14 +0200
Message-Id: <20180415153618.32019-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
In-Reply-To: <20180415153618.32019-1-pclouds@gmail.com>
References: <20180414152642.4666-1-pclouds@gmail.com>
 <20180415153618.32019-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds a new repack mode that combines everything into a secondary
pack, leaving the largest pack alone.

This could help reduce memory pressure. On linux-2.6.git, valgrind
massif reports 1.6GB heap in "pack all" case, and 535MB in "pack
all except the base pack" case. We save roughly 1GB memory by
excluding the base pack.

This should also lower I/O because we don't have to rewrite a giant
pack every time (e.g. for linux-2.6.git that's a 1.4GB pack file)..

PS. The use of string_list here seems overkill, but we'll need it in
the next patch...

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-gc.txt |  6 +++++-
 builtin/gc.c             | 45 ++++++++++++++++++++++++++++++++++++----
 t/t6500-gc.sh            | 25 ++++++++++++++++++++++
 3 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 3126e0dd00..8f903231da 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -9,7 +9,7 @@ git-gc - Cleanup unnecessary files and optimize the local repository
 SYNOPSIS
 --------
 [verse]
-'git gc' [--aggressive] [--auto] [--quiet] [--prune=<date> | --no-prune] [--force]
+'git gc' [--aggressive] [--auto] [--quiet] [--prune=<date> | --no-prune] [--force] [--keep-largest-pack]
 
 DESCRIPTION
 -----------
@@ -84,6 +84,10 @@ be performed as well.
 	Force `git gc` to run even if there may be another `git gc`
 	instance running on this repository.
 
+--keep-largest-pack::
+	All packs except the largest pack and those marked with a
+	`.keep` files are consolidated into a single pack.
+
 Configuration
 -------------
 
diff --git a/builtin/gc.c b/builtin/gc.c
index 3e67124eaa..f251662a8f 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -166,6 +166,22 @@ static int too_many_loose_objects(void)
 	return needed;
 }
 
+static void find_base_packs(struct string_list *packs)
+{
+	struct packed_git *p, *base = NULL;
+
+	for (p = get_packed_git(the_repository); p; p = p->next) {
+		if (!p->pack_local)
+			continue;
+		if (!base || base->pack_size < p->pack_size) {
+			base = p;
+		}
+	}
+
+	if (base)
+		string_list_append(packs, base->pack_name);
+}
+
 static int too_many_packs(void)
 {
 	struct packed_git *p;
@@ -188,7 +204,13 @@ static int too_many_packs(void)
 	return gc_auto_pack_limit < cnt;
 }
 
-static void add_repack_all_option(void)
+static int keep_one_pack(struct string_list_item *item, void *data)
+{
+	argv_array_pushf(&repack, "--keep-pack=%s", basename(item->string));
+	return 0;
+}
+
+static void add_repack_all_option(struct string_list *keep_pack)
 {
 	if (prune_expire && !strcmp(prune_expire, "now"))
 		argv_array_push(&repack, "-a");
@@ -197,6 +219,9 @@ static void add_repack_all_option(void)
 		if (prune_expire)
 			argv_array_pushf(&repack, "--unpack-unreachable=%s", prune_expire);
 	}
+
+	if (keep_pack)
+		for_each_string_list(keep_pack, keep_one_pack, NULL);
 }
 
 static void add_repack_incremental_option(void)
@@ -220,7 +245,7 @@ static int need_to_gc(void)
 	 * there is no need.
 	 */
 	if (too_many_packs())
-		add_repack_all_option();
+		add_repack_all_option(NULL);
 	else if (too_many_loose_objects())
 		add_repack_incremental_option();
 	else
@@ -354,6 +379,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	const char *name;
 	pid_t pid;
 	int daemonized = 0;
+	int keep_base_pack = -1;
 
 	struct option builtin_gc_options[] = {
 		OPT__QUIET(&quiet, N_("suppress progress reporting")),
@@ -366,6 +392,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		OPT_BOOL_F(0, "force", &force,
 			   N_("force running gc even if there may be another gc running"),
 			   PARSE_OPT_NOCOMPLETE),
+		OPT_BOOL(0, "keep-largest-pack", &keep_base_pack,
+			 N_("repack all other packs except the largest pack")),
 		OPT_END()
 	};
 
@@ -431,8 +459,17 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			 */
 			daemonized = !daemonize();
 		}
-	} else
-		add_repack_all_option();
+	} else {
+		struct string_list keep_pack = STRING_LIST_INIT_NODUP;
+
+		if (keep_base_pack != -1) {
+			if (keep_base_pack)
+				find_base_packs(&keep_pack);
+		}
+
+		add_repack_all_option(&keep_pack);
+		string_list_clear(&keep_pack, 0);
+	}
 
 	name = lock_repo_for_gc(force, &pid);
 	if (name) {
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index d5255dd576..c42f60bc5b 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -43,6 +43,31 @@ test_expect_success 'gc is not aborted due to a stale symref' '
 	)
 '
 
+test_expect_success 'gc --keep-largest-pack' '
+	test_create_repo keep-pack &&
+	(
+		cd keep-pack &&
+		test_commit one &&
+		test_commit two &&
+		test_commit three &&
+		git gc &&
+		( cd .git/objects/pack && ls *.pack ) >pack-list &&
+		test_line_count = 1 pack-list &&
+		BASE_PACK=.git/objects/pack/pack-*.pack &&
+		test_commit four &&
+		git repack -d &&
+		test_commit five &&
+		git repack -d &&
+		( cd .git/objects/pack && ls *.pack ) >pack-list &&
+		test_line_count = 3 pack-list &&
+		git gc --keep-largest-pack &&
+		( cd .git/objects/pack && ls *.pack ) >pack-list &&
+		test_line_count = 2 pack-list &&
+		test_path_is_file $BASE_PACK &&
+		git fsck
+	)
+'
+
 test_expect_success 'auto gc with too many loose objects does not attempt to create bitmaps' '
 	test_config gc.auto 3 &&
 	test_config gc.autodetach false &&
-- 
2.17.0.367.g5dd2e386c3

