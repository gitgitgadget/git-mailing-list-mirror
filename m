Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2BE1E3DED
	for <git@vger.kernel.org>; Sun, 25 Jan 2026 20:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769372118; cv=none; b=DwaIfXF8wk2M6oVuHgUjDDAmuZewdEnDdpEvprzExENyi9MeYeMjCoGdIS/UhMcmIURK3aBkfxRpfV3g8m/OhgeW8ny4iiQZMH711JDVdGFLcjG8NBUsD5q4GADMx5QQHTmHM7+RhnsMvB6EbZRG+D7NbRufgxZ5ptbiIXOdSfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769372118; c=relaxed/simple;
	bh=qje1CwPtApqM6TS72Rfn+RFu3qjJsqRhOI4KgI/0NvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fuYHGt7F1BkpDHHpHZvx+AOS/RGPL90g68MwbbPGIa8pnJU5aEQ6tpUbrcyjPosKZaEY5vlaNPZttJKi20xVE2p+qPjD5aQ8u3IbAPOm0R7sJkHwsznLEMjYnsMRCDEiiGv9FOFaIvVqnJpigKxqRCE4RXsRImmJQLeHCOK89cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GujgxyRY; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GujgxyRY"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-81e8a9d521dso2239746b3a.2
        for <git@vger.kernel.org>; Sun, 25 Jan 2026 12:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769372117; x=1769976917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAiMKPmm0E6a10p6C/PfXCfPUSr5oAxNb+BJqSsUSek=;
        b=GujgxyRYT8VJdlrcIC24cs6op7adCP+mRMx4mISxsVS1LdvUvhV4K64LWf9b7s8pWp
         d/mPUo4etxmB7YLHVKJwfP+hhDasyLGHSWY1H2WVx1L8Wsvqis16W47yqDeB2Sr4fKlb
         Zu+uaAL8P7QOSSKTg6sz5LQrtha3FAXEg7CE5C/kUcBYupc/DzUCeI0DbdMd6Fzb5kt2
         0ZDSvoyIUdygXDBbjCOBd5TTMCQLmmV26ykIfn9pGMvJitiSSWj5pp38ChZcI2GQ59Bg
         uoJayzmyPYnaMANwGRzyHQhL30W/kgyI2tKrxUqF8uuEA7LD/4jpQ3KFeq29t4ngA7TO
         Q/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769372117; x=1769976917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oAiMKPmm0E6a10p6C/PfXCfPUSr5oAxNb+BJqSsUSek=;
        b=rDNPom/AL1cNDh2CqGrThbPi49FekSO8jqbNYfQ2PP1LlqTsmoZHbTkyVi+EAyVnmB
         p+NgRyARcmSadFDWJBGJovjcWeuXa4nXdm7C3gY33Hwad6Yh2n9SNQ3Shd+ATL6/4uSz
         MF+3xP9wPVsopJP3pTbdGaeo+F5/I75CndWsSTyX6+CLyuF0RmrLfTzmg7x/fIpUfKOd
         Di42sasrwSeqnrM3SDa9kzUhLV+Zvp9Sw5LnrO2c8MVB0Gnm9CnF3slfT9ZvP6AOaQkv
         4qUdBiCSmRHemhD9gwusvvQmDdzs4FRdVvrKdfJ2aAVYeHotpDKXFYElngrDtKKaUGnk
         CmPw==
X-Forwarded-Encrypted: i=1; AJvYcCUpgxNH6AZFg46zIt9jZZCI3k9qoTsre9Fk5O0R26Nz0JS7PZW47AUy6sG+7lrKFxVieb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5P4jJmXA0Oh9BWw2TiVZP/p99Mg/4pzrt/PcT4RrDUfxhn0Pl
	L8oaPGPcUGKdqG+s2j7+8gdYTHZsvITHUHCuyBdLK+dCq3s3h9s3P0T8
X-Gm-Gg: AZuq6aLKZ4n8INF4XT5v3H3HiNtL28sIfClx56ohasDRiwo2xexjyU/unxt050tyGrO
	uDVih1d4KDvdXwECtm7LRd71rNgBJCn9IlLb7SDRR0hoZwR8HA7EUo6sBPHZQKFk55QstdJtIQ3
	Vmw307tbT9YO74J2XW7IwMbRqQxTwkc+CmpehWXpA3hDf6hZW+ZhvbAnLfRbg8V3/sZ1eTaYAbI
	q1wDrZaLsVUrU3T3SGc8XGqH472rEgpa1M+BhXi/9rtIx/dmjVBDzuCus4EOW2pxG5RcAPFDKNE
	GGY/UEXNMMMCHt4RkMsBmVDfEYVezTACD9gjUU/qEShucXgyNpEruUIvbJg2N5p9oobbUWUp4vI
	U2GKOiHM4bBm+Lyaylwa3KfaaK0ljNUwwOfY7rLmu0ahxgb6yWdZfQLsxgOHWtW+lCe4HhSOVK7
	OuSQLF/jO57K7eQJ/ytSiS6nRJ3LOr6bHQBWSvQJgEXqkOYw/3YJDBbhTwmIzUgJB1pUbW
X-Received: by 2002:a05:6a00:23c2:b0:80a:fc3c:f839 with SMTP id d2e1a72fcca58-823412be856mr1826781b3a.49.1769372116679;
        Sun, 25 Jan 2026 12:15:16 -0800 (PST)
Received: from localhost.localdomain ([115.98.233.166])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82318663addsm7569844b3a.20.2026.01.25.12.15.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 25 Jan 2026 12:15:16 -0800 (PST)
From: Amisha Chhajed <amishhhaaaa@gmail.com>
To: amishhhaaaa@gmail.com
Cc: Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	git@vger.kernel.org
Subject: [PATCH 2/2] string-list: add string_list_sort_u() that mimics "sort -u"
Date: Mon, 26 Jan 2026 01:45:00 +0530
Message-ID: <20260125201500.63904-2-amishhhaaaa@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125201500.63904-1-amishhhaaaa@gmail.com>
References: <20260122171523.94234-1-amishhhaaaa@gmail.com>
 <20260125201500.63904-1-amishhhaaaa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many callsites of string_list_remove_duplicates() call it
immdediately after calling string_list_sort(), understandably
as the former requires string-list to be sorted, it is clear
that these places are sorting only to remove duplicates and
for no other reason.

Introduce a helper function string_list_sort_u that combines
these two calls that often appear together, to simplify
these callsites. Replace the current calls of those methods with
string_list_sort_u().

Signed-off-by: Amisha Chhajed <amishhhaaaa@gmail.com>
---
 builtin/clone.c              |  3 +--
 builtin/fast-export.c        |  3 +--
 builtin/pack-objects.c       |  6 ++----
 builtin/sparse-checkout.c    |  6 ++----
 help.c                       |  3 +--
 notes.c                      |  3 +--
 string-list.c                |  6 ++++++
 string-list.h                |  6 ++++++
 t/unit-tests/u-string-list.c | 34 ++++++++++++++++++++++++++++++++++
 9 files changed, 54 insertions(+), 16 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index b19b302b06..f05364c268 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1136,8 +1136,7 @@ int cmd_clone(int argc,
 		int val;
 
 		/* remove duplicates */
-		string_list_sort(&option_recurse_submodules);
-		string_list_remove_duplicates(&option_recurse_submodules, 0);
+		string_list_sort_u(&option_recurse_submodules, 0);
 
 		/*
 		 * NEEDSWORK: In a multi-working-tree world, this needs to be
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index b90da5e616..0c5d2386d8 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -1118,8 +1118,7 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 			free(full_name);
 	}
 
-	string_list_sort(&extra_refs);
-	string_list_remove_duplicates(&extra_refs, 0);
+	string_list_sort_u(&extra_refs, 0);
 }
 
 static void handle_tags_and_duplicates(struct string_list *extras)
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ca44b7894f..649dab4ed0 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3849,10 +3849,8 @@ static void read_packs_list_from_stdin(struct rev_info *revs)
 		strbuf_reset(&buf);
 	}
 
-	string_list_sort(&include_packs);
-	string_list_remove_duplicates(&include_packs, 0);
-	string_list_sort(&exclude_packs);
-	string_list_remove_duplicates(&exclude_packs, 0);
+	string_list_sort_u(&include_packs, 0);
+	string_list_sort_u(&exclude_packs, 0);
 
 	repo_for_each_pack(the_repository, p) {
 		const char *pack_name = pack_basename(p);
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 15d51e60a8..25de7692c9 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -292,8 +292,7 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 			string_list_insert(&sl, pe->pattern);
 	}
 
-	string_list_sort(&sl);
-	string_list_remove_duplicates(&sl, 0);
+	string_list_sort_u(&sl, 0);
 
 	fprintf(fp, "/*\n!/*/\n");
 
@@ -316,8 +315,7 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 
 	strbuf_release(&parent_pattern);
 
-	string_list_sort(&sl);
-	string_list_remove_duplicates(&sl, 0);
+	string_list_sort_u(&sl, 0);
 
 	for (i = 0; i < sl.nr; i++) {
 		char *pattern = escaped_pattern(sl.items[i].string);
diff --git a/help.c b/help.c
index 20e114432d..2070095b6f 100644
--- a/help.c
+++ b/help.c
@@ -420,8 +420,7 @@ void list_cmds_by_config(struct string_list *list)
 	if (repo_config_get_string_tmp(the_repository, "completion.commands", &cmd_list))
 		return;
 
-	string_list_sort(list);
-	string_list_remove_duplicates(list, 0);
+	string_list_sort_u(list, 0);
 
 	while (*cmd_list) {
 		struct strbuf sb = STRBUF_INIT;
diff --git a/notes.c b/notes.c
index 8e00fd8c47..090c48bbd5 100644
--- a/notes.c
+++ b/notes.c
@@ -921,8 +921,7 @@ int combine_notes_cat_sort_uniq(struct object_id *cur_oid,
 	if (string_list_add_note_lines(&sort_uniq_list, new_oid))
 		goto out;
 	string_list_remove_empty_items(&sort_uniq_list, 0);
-	string_list_sort(&sort_uniq_list);
-	string_list_remove_duplicates(&sort_uniq_list, 0);
+	string_list_sort_u(&sort_uniq_list, 0);
 
 	/* create a new blob object from sort_uniq_list */
 	if (for_each_string_list(&sort_uniq_list,
diff --git a/string-list.c b/string-list.c
index 08dc00984c..020ed8fef7 100644
--- a/string-list.c
+++ b/string-list.c
@@ -247,6 +247,12 @@ void string_list_sort(struct string_list *list)
 	QSORT_S(list->items, list->nr, cmp_items, &sort_ctx);
 }
 
+void string_list_sort_u(struct string_list *list, int free_util)
+{
+	string_list_sort(list);
+	string_list_remove_duplicates(list, free_util);
+}
+
 struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
 						     const char *string)
 {
diff --git a/string-list.h b/string-list.h
index fa6ba07853..3ad862a187 100644
--- a/string-list.h
+++ b/string-list.h
@@ -239,6 +239,12 @@ struct string_list_item *string_list_append_nodup(struct string_list *list, char
  */
 void string_list_sort(struct string_list *list);
 
+/**
+ * Sort the list and then remove duplicate entries.  If free_util is true,
+ * call free() on the util members of any items that have to be deleted.
+ */
+void string_list_sort_u(struct string_list *list, int free_util);
+
 /**
  * Like `string_list_has_string()` but for unsorted lists. Linear in
  * size of the list.
diff --git a/t/unit-tests/u-string-list.c b/t/unit-tests/u-string-list.c
index 6b4b858330..f91bb60e09 100644
--- a/t/unit-tests/u-string-list.c
+++ b/t/unit-tests/u-string-list.c
@@ -432,6 +432,40 @@ void test_string_list__remove_duplicates(void)
 	t_string_list_clear(&list, 0);
 }
 
+static void t_string_list_sort_u(struct string_list *list, ...)
+{
+	struct string_list expected_strings = STRING_LIST_INIT_DUP;
+	va_list ap;
+
+	va_start(ap, list);
+	t_vcreate_string_list_dup(&expected_strings, 0, ap);
+	va_end(ap);
+
+	string_list_sort_u(list, 0);
+	t_string_list_equal(list, &expected_strings);
+
+	string_list_clear(&expected_strings, 0);
+}
+
+void test_string_list__sort_u(void)
+{
+	struct string_list list = STRING_LIST_INIT_DUP;
+
+	t_create_string_list_dup(&list, 0, NULL);
+	t_string_list_sort_u(&list, NULL);
+
+	t_create_string_list_dup(&list, 0, "", "", "", "", NULL);
+	t_string_list_sort_u(&list, "", NULL);
+
+	t_create_string_list_dup(&list, 0, "b", "a", "a", "", NULL);
+	t_string_list_sort_u(&list, "", "a", "b", NULL);
+
+	t_create_string_list_dup(&list, 0, "b", "a", "a", "d", "c", "c", NULL);
+	t_string_list_sort_u(&list, "a", "b", "c", "d", NULL);
+
+	t_string_list_clear(&list, 0);
+}
+
 static void t_string_list_remove_empty_items(struct string_list *expected_strings, struct string_list *list)
 {
 	string_list_remove_empty_items(list, 0);
-- 
2.51.0

