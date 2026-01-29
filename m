Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D99C37FF72
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 12:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769688757; cv=none; b=Tl72FdcuvHGQxqDjkBqtO2wiYsUl6I5yi+FcDTDNJvx7NDE2adsGQ8xJ+GigLDPkqE5CFiSDfE50MoSlXTaMWlQitagx/KC/TlAzh6JUlDYOUfsn45ehFW69pZ64rHAlUye5erc32VzeN6qgz7Y6lrjDIDQ+kIASat38/iht0sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769688757; c=relaxed/simple;
	bh=/dVtZbxykdUXziIVcEq5XiTvl61I5UHCMS07VX0OEzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGCOyhsO2kq/A63Z2HfYD9Z9N6iBTCo3w9f9GnsXg5Xxuq22Hy2f9ReEiYVf8t9tz5P8x18LKjdNYCnG1mrdNMbYOEZC1CoqgrCDptRQfczifzpEJ+fjkQnj5N1nEAwCRwlyRWX82qSFi8/OPzcDzYqj46QU7CLR1vkJvXg/+c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkLgK15Y; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkLgK15Y"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34be2be4b7cso498541a91.3
        for <git@vger.kernel.org>; Thu, 29 Jan 2026 04:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769688755; x=1770293555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/fHqBhrW0nJv1arjQleW9UWjuwo7ipz9EMQsHJ55nY=;
        b=bkLgK15Ye8r62b/KJJb8zOE1dS1GKdCJCysocolF4wtUmlmBHlXJIvJOYdnVwyA17B
         qXuE8DzW8NiAosMXwGb9/zJxZm4bBIQ9l3zexyVngVZ7bGFyQ2KbPv8UBiMqH2Aue7H3
         p8EiViPSCll8YDdmkqjahq4H5ettsD92KvqgMnQGNdKcHxnyz2O+Ou5vEAvJcm719A/U
         GQAWhbWh1V8wZuY2YYXT5778Ennz4UJ3B7lvejWeoWnUpDb2c6oaCyh0g3nZJEIQ0xhl
         F+iN9x/t+ulxTo+pb/Jma+ZpC5lqeD1pf2EChLl0S8ZEbK9XjBZ+egX600VsUs1pHgmR
         wljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769688755; x=1770293555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l/fHqBhrW0nJv1arjQleW9UWjuwo7ipz9EMQsHJ55nY=;
        b=gTM2+IAsn/oL+rxvG7dwKEwfX9Eu4X6NssDkZxrqJvlF7b1wJSir0Ko/oKL+YuTnlR
         847xT+oiZamn25TZZwsKV4NlWWl7ctzUYXIPqT1NS1GOu1CADDtUemnmN3EWjps3Jpmk
         5Lg1Dy8laYN6zki5IM95loQdHk8CbOBOuHQ695V6cuKZ2Qu45+cExcOtHxFOp9/AKhxE
         cKmCyPiLt+wAYuEgUmozWPTcXzOWr+TqMv1dplh+w5BQpeY/z3X9v1865BMIg+/t62Xe
         tT1DyFbQTE2sfjlloqSJZlIwILg7Tk+oVqrpv4sdnpPRMx8nqzV8BgIuk/wyxlM/sDL8
         h+kg==
X-Gm-Message-State: AOJu0YzkqX5OlW3qzFDEMgjFFbhHqBkdKd4TbsOnNEqx2v0hEJTia7Wj
	ekpOTKr6V7ptinD7HzcDwxkWTaApODQv2Ax7VAEdjIV4fE3HGljHsXYKC/y7ph+b
X-Gm-Gg: AZuq6aKIwiTGIhvnEUoK70yYrDO5zcaslInmnKpzPRxAVEGhdzd8YwPG+/Qebc/k304
	634K8MZ8+1Bzt2oQtW9uuiK2/xyQAYPx9J2CldwretinvrtdUzIYWD3Eu2g1mjhed0I4icHGMCb
	xGQEcgKNDRlXzLlj7cj7bzLo2mVBRf46Q9mORwUD9VTeV3r5ksci8CYXqe79v1ZVM9S+xvirC8G
	GGHtlxzzCAzoY9//W7s6TL8cqX3AE9wlQIEkKmqCBt8gJjnXvLc7+/8fG3uhG9mlGfR9LDcwRdG
	y29pNf5NiLxYY4ymkt4iwWX3h604HlKvVvV+PeFViYQqyLYZjorMIkYiGOpc8TQj3iVWQV+S8ym
	bV2bXeVVvytcy0gVuPtY+GeswEo1yUUGQJzBU73oc/P5sxyE48A6VSK70jtyTHSomzQiqI3Hj65
	pt0In2LgkRBKXZKyJS3VB9UTRYhNAp5yodQEX4jsdgA5Wrvbs1KNzLRE2G9f6D2Huxew==
X-Received: by 2002:a17:90b:1d48:b0:340:bc27:97bd with SMTP id 98e67ed59e1d1-353fecde7d8mr7257616a91.9.1769688755069;
        Thu, 29 Jan 2026 04:12:35 -0800 (PST)
Received: from localhost.localdomain ([115.98.234.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f6128942sm8088533a91.5.2026.01.29.04.12.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Jan 2026 04:12:34 -0800 (PST)
From: Amisha Chhajed <amishhhaaaa@gmail.com>
To: git@vger.kernel.org
Cc: amishhhaaaa@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 2/2] string-list: add string_list_sort_u() that mimics "sort -u"
Date: Thu, 29 Jan 2026 17:42:20 +0530
Message-ID: <20260129121220.69267-2-amishhhaaaa@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260129121220.69267-1-amishhhaaaa@gmail.com>
References: <20260125201500.63904-2-amishhhaaaa@gmail.com>
 <20260129121220.69267-1-amishhhaaaa@gmail.com>
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
index d469a06eca..7ad84cc1cd 100644
--- a/t/unit-tests/u-string-list.c
+++ b/t/unit-tests/u-string-list.c
@@ -437,6 +437,40 @@ void test_string_list__remove_duplicates(void)
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
 static void t_string_list_remove_empty_items(
 	struct string_list *expected_strings,
 	struct string_list *list)
-- 
2.51.0

