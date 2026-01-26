Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F9323B61E
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769453789; cv=none; b=IW0/b5zNhAZpbxKG7HuVwZwnNzkYRVgxiXJnKE0y3wquiB3V3SFfbwf0mcvQjUEKON02DcZC4tic5NaX2DNg3TbSnXgYLjTqono6udixbeOmWadUtUvBs/bV66JUrv1JgkBnLqRLpdggAemkvda9LxPYVAvd7LSKGdQApq4sOSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769453789; c=relaxed/simple;
	bh=yuUk3c+YzEJfyO/meItkbqepEAeepIApp/6/5/m8tsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+/YpfjnkOYC8M12kU5EuMdL59dye5BDcYg6R5Hwx/FVWip+p/iTa17+UBOFTwZjfO/Qr/smJhwYHMP7MFK6LVhsAzwiz+336imjPU29P8jOry+UBACrwu5yaNSQukAxdJmobavXe5otKdmgV+RfP/ckjRTn4Rf9zovPDSL0PCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjOvbMtg; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjOvbMtg"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43596062728so3614676f8f.1
        for <git@vger.kernel.org>; Mon, 26 Jan 2026 10:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769453786; x=1770058586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYU4HC2heGfKUN6ZpqqKiA+YDj1ZwVaaQiNyb7anzxw=;
        b=hjOvbMtgHdbiI/uRQJ5t2FR7ddR7EAs+u9FHrj3aAiHiZKDU5KeasrtIWYnQkqIiVJ
         2ZZDrCoJrwrQaUWi4qjCjIln/Hnw/gExXOL5rJuaMXzaEjhwSY5npCiVL6Kb4z5U67ny
         DNrWsCfWQl81zQOg2hVgfpV2HL8wtVs/AEOSEU0IXM74XpeEJeyX8uyoUilwqaUVH2dx
         bIF/liSfRSntRa48Z9UAypVybWFaUCwEJwnN8/pA0ULPRw8e0t8n/A/skAlnPeAE/WAy
         oGtO88BIoxdsbVmFEANWDKagX9zCbSWnUi4Hf+CiXO/SK1NmxCRNS92YS7sWr/2adeOm
         j/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769453786; x=1770058586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JYU4HC2heGfKUN6ZpqqKiA+YDj1ZwVaaQiNyb7anzxw=;
        b=MISiVTdeNXO+MEk+1kJIccmJy0Nm2pNdRZPhuXY20gGCHbDxUje0ipBJF6rxgDDzv5
         7/9C13X0X0zwncmrfElpzxlsznxts3oIS9swTzYaOhJ3PnX5Vd1VFmpa+bjEQ3W7wKKI
         ydrJgrj2U4gQPOFb3xOqiHGNlXROXv6TWicxBq+7hhR3JfPyZ1bUIfQ+Acww4MvQ8wn0
         DWjv2aup51XnGZ9nUMnbNGflPKDZbE2nwaQCyOaOMl2wtd4c5G+pFVe1sAKCE0Ev63p3
         cMCkOaVp2KXh4BVRmyyLsygxtcFpNkgJ/Q0yJ9YVT/159g6G9zVpQzURV0BmVh4eiSpo
         TStg==
X-Gm-Message-State: AOJu0YzttTmCYNCLFcJBkesfG0UWssj3xptNkcVEFzdUhxR8MDlMqt9f
	QE29XenpEhK1zDV628bY8lQfAX+2g/YtMiJB9DyaGgPt2HfWt80lUVRVBnV8hZSS
X-Gm-Gg: AZuq6aLagyqCPAtPEpJo06uTMHyTxxyNcwovlHhZqdbGKLatGjuhu9BB6t42+SlcSnq
	bUeXyV5AYDmf0m5wbQMSFLVWGNAHvmr6jNml7hfwzmu5YWVWpN0p+jdRzmgGte8zIsxGwfqkB2l
	B4pFFON5XjzWdsmiH8LJaoDbYnioEXOgvIma7/fVbW2uEmpxJhAZ/tz7YWOrLZNtsfW1KxDjzyX
	O3syiy/OC2d/whxqd1dDzKjLepjOqvUL/II1jWst8bNbqJsvzdxa1IeKM7ao2nZ5AVoqYH485i1
	HRKtifh97rr/IlJsDO7ylZ2jYeStbmj/kQntGSGzg1jn02EQ5RXlAQr7gpwSXqCGdKcfKkdGcFU
	TawV9uTPqGyAvzqcdtqR8yl28+rUOWwI93vtyBCzIx7FpLrMF5No45W7mT+NF4pxmak2i750350
	CQHACUbkYmi4lHF+8DyCqpfgmwXFBI1gm2gkLXWTyIZyVrl+14TxtwYhl/eBTLSsb/Ov2j
X-Received: by 2002:a5d:64e8:0:b0:432:b953:b02b with SMTP id ffacd0b85a97d-435c9b1db2fmr10649475f8f.16.1769453786314;
        Mon, 26 Jan 2026 10:56:26 -0800 (PST)
Received: from localhost.localdomain ([115.98.235.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1b6e2besm32159135f8f.0.2026.01.26.10.56.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Jan 2026 10:56:25 -0800 (PST)
From: Amisha Chhajed <amishhhaaaa@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Amisha Chhajed <amishhhaaaa@gmail.com>
Subject: [PATCH v2 2/2] string-list: add string_list_sort_u() that mimics "sort -u"
Date: Tue, 27 Jan 2026 00:26:04 +0530
Message-ID: <20260126185604.90089-2-amishhhaaaa@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126185604.90089-1-amishhhaaaa@gmail.com>
References: <20260122171523.94234-1-amishhhaaaa@gmail.com>
 <20260126185604.90089-1-amishhhaaaa@gmail.com>
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
index 6b2b16671c..9d11a2f3fb 100644
--- a/t/unit-tests/u-string-list.c
+++ b/t/unit-tests/u-string-list.c
@@ -431,6 +431,40 @@ void test_string_list__remove_duplicates(void)
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

