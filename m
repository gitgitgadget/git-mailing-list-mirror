Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EF854649
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 14:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705674435; cv=none; b=RvTHdgDR0SurTdmwGNLAGsKwDdxJlqLtcDrRMT02SmUVGvvVikj8Tv0dCrAoTUV/IgHGmpRPYAGgtQhXJcUygnvdnqzZeSxIHyDrZ7dG7pwtUcaMGCtfRSLONAeiP2peWVEbZcWPKsv9CNDo9z780Zkobe9y0nrov2WjAHB1yms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705674435; c=relaxed/simple;
	bh=C7vDmXLEbXtY3oiqVbuMkZJlKMjB4TZLmmsS529QZQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UM/Kd+gfgOff6ezY12mdHussbDLetZL8KN8xALYRbbUZpEJEGvRgAlBIe7eeG2vwrpQTDlPT0I1IlOvrY6kia7UnxwZqozySj8aN2cs1RmZAw402y3jlj0iLKUCY5sdHagw8UaOgHo/zU/JnmYV0dFLtAMo1nSffWan10OXd2F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxQpqk+X; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxQpqk+X"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a28a6cef709so81037066b.1
        for <git@vger.kernel.org>; Fri, 19 Jan 2024 06:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705674432; x=1706279232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZfgvTKUs0RX0aUMcHBIQZV5urECTbu3T6yTamxXDFk=;
        b=PxQpqk+XdCcX6MD2RrCaJOAI+h1GsKevWin2Me1UYZxRWbBacSSmpzF2FJbkhCrIbI
         iWVSNVKFDEwxDYv8D4McG3Cs82W1/SAgCuZQu2WyT7OyBJdmzCCglR3iTRf3T4vjBU2f
         hx2mC3st+r21wufVfhr8k7Du4B8fCfLdr8bD23jzFoA8jrR+unkUZ3MD2SDZrJ33pwGp
         Su4N0fkH7jqey2UFucfttzBAtI/KyEpgsB9b0ki35jnsIUDlGd8JWTpOJdot62oulmdp
         VppQZevkAaZ01jliG25umhl90bihR9nqRAJKFAHD5Huf3cH6CJ2/SoPEKm2gBDsTORY8
         3Sgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705674432; x=1706279232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZfgvTKUs0RX0aUMcHBIQZV5urECTbu3T6yTamxXDFk=;
        b=HEpzdQhKb/+h3u+hgpuFsrPLell3OXpEQqICau2nPEEq0TN2pyzA14weSkOLNJbOve
         t54e/vYAnTllFsMwJdbV0y/xN/NjR/HHUcxQI4dvel6huRGCW2E2VDTv6YwfNUMS6vNw
         4eGbPgqXhCH4AnXinkgGETxNMiGOiI+hjYjJ4J5hLZWbh5F3L+n3vJEE0cIw4voIU0Ej
         aKVO72LBkaaiNET2waPiuZJyGKrAUyj1FabamOg9h4FUNXQN9WPR+htTTUORSaUEcr+f
         4dG0hjuwjJG/1IaO60wQojV0ioHYhmnJ48mVSIlph6H3m/HRH3fIID7fFf0PJ4O6shUM
         78qQ==
X-Gm-Message-State: AOJu0YyjfG1jYMxa/TgJ+u1glWBMSb9wLs2zuqNbN2Jgon/LbXPRMzwT
	0zKu6bx2yShjx6O+ONjVAV6xTEHhHJwvwQeCwNiVH3LDFT7kRr5I0oJpeajQ
X-Google-Smtp-Source: AGHT+IGyh4PCYSBUQMdKdweXZLUu8Io7lQbuif18UHh6BUUlgK2oT48Mb6jM/P53/olppTgFTAxMOQ==
X-Received: by 2002:a17:906:fa98:b0:a2e:d71f:bd4c with SMTP id lt24-20020a170906fa9800b00a2ed71fbd4cmr1532770ejb.68.1705674431750;
        Fri, 19 Jan 2024 06:27:11 -0800 (PST)
Received: from localhost.localdomain (h-213.61.124.196.host.de.colt.net. [213.61.124.196])
        by smtp.gmail.com with ESMTPSA id t13-20020a17090616cd00b00a2ea45637desm3843494ejd.112.2024.01.19.06.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 06:27:11 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 5/5] for-each-ref: avoid filtering on empty pattern
Date: Fri, 19 Jan 2024 15:27:05 +0100
Message-ID: <20240119142705.139374-6-karthik.188@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119142705.139374-1-karthik.188@gmail.com>
References: <20240119142705.139374-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the user uses an empty string pattern (""), we don't match any refs
in git-for-each-ref(1). This is because in git-for-each-ref(1), we use
path based matching and an empty string doesn't match any path.

In this commit we change this behavior by making empty string pattern
match all references. This is done by introducing a new flag
`FILTER_REFS_NO_FILTER` in `ref-filter.c`, which uses the newly
introduced `refs_for_each_all_refs()` function to iterate over all the
refs in the repository.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  3 ++-
 builtin/for-each-ref.c             | 21 +++++++++++++++++-
 ref-filter.c                       | 13 ++++++++++--
 ref-filter.h                       |  4 +++-
 t/t6302-for-each-ref-filter.sh     | 34 ++++++++++++++++++++++++++++++
 5 files changed, 70 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index be9543f684..b1cb482bf5 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -32,7 +32,8 @@ OPTIONS
 	If one or more patterns are given, only refs are shown that
 	match against at least one pattern, either using fnmatch(3) or
 	literally, in the latter case matching completely or from the
-	beginning up to a slash.
+	beginning up to a slash. If an empty string is provided all refs
+	are printed, including HEAD and pseudorefs.
 
 --stdin::
 	If `--stdin` is supplied, then the list of patterns is read from
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 3885a9c28e..5aa879e8be 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -25,6 +25,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	struct ref_format format = REF_FORMAT_INIT;
 	int from_stdin = 0;
 	struct strvec vec = STRVEC_INIT;
+	unsigned int flags = FILTER_REFS_ALL;
 
 	struct option opts[] = {
 		OPT_BIT('s', "shell", &format.quote_style,
@@ -93,11 +94,29 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		/* vec.v is NULL-terminated, just like 'argv'. */
 		filter.name_patterns = vec.v;
 	} else {
+		size_t i;
+
 		filter.name_patterns = argv;
+
+		/*
+		 * Search for any empty string pattern, if it exists then we
+		 * print all refs without any filtering.
+		 */
+		i = 0;
+		while (argv[i]) {
+			if (!argv[i][0]) {
+				flags = FILTER_REFS_NO_FILTER;
+				/* doing this removes any pattern from being matched */
+				filter.name_patterns[0] = NULL;
+				break;
+			}
+
+			i++;
+		}
 	}
 
 	filter.match_as_path = 1;
-	filter_and_format_refs(&filter, FILTER_REFS_ALL, sorting, &format);
+	filter_and_format_refs(&filter, flags, sorting, &format);
 
 	ref_filter_clear(&filter);
 	ref_sorting_release(sorting);
diff --git a/ref-filter.c b/ref-filter.c
index 35b989e1df..6dac133b87 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2622,6 +2622,11 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 				       each_ref_fn cb,
 				       void *cb_data)
 {
+	if (filter->kind & FILTER_REFS_NO_FILTER) {
+		return refs_for_each_all_refs(
+			get_main_ref_store(the_repository), cb, cb_data);
+	}
+
 	if (!filter->match_as_path) {
 		/*
 		 * in this case, the patterns are applied after
@@ -2775,8 +2780,12 @@ static struct ref_array_item *apply_ref_filter(const char *refname, const struct
 
 	/* Obtain the current ref kind from filter_ref_kind() and ignore unwanted refs. */
 	kind = filter_ref_kind(filter, refname);
-	if (!(kind & filter->kind))
+	if (filter->kind & FILTER_REFS_NO_FILTER) {
+		if (kind == FILTER_REFS_DETACHED_HEAD)
+			kind = FILTER_REFS_OTHERS;
+	} else if (!(kind & filter->kind)) {
 		return NULL;
+	}
 
 	if (!filter_pattern_match(filter, refname))
 		return NULL;
@@ -3041,7 +3050,7 @@ static int do_filter_refs(struct ref_filter *filter, unsigned int type, each_ref
 			ret = for_each_fullref_in("refs/remotes/", fn, cb_data);
 		else if (filter->kind == FILTER_REFS_TAGS)
 			ret = for_each_fullref_in("refs/tags/", fn, cb_data);
-		else if (filter->kind & FILTER_REFS_ALL)
+		else if (filter->kind & FILTER_REFS_ALL || filter->kind & FILTER_REFS_NO_FILTER)
 			ret = for_each_fullref_in_pattern(filter, fn, cb_data);
 		if (!ret && (filter->kind & FILTER_REFS_DETACHED_HEAD))
 			head_ref(fn, cb_data);
diff --git a/ref-filter.h b/ref-filter.h
index 07cd6f6da3..1eab325ce0 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -22,7 +22,9 @@
 #define FILTER_REFS_ALL            (FILTER_REFS_TAGS | FILTER_REFS_BRANCHES | \
 				    FILTER_REFS_REMOTES | FILTER_REFS_OTHERS)
 #define FILTER_REFS_DETACHED_HEAD  0x0020
-#define FILTER_REFS_KIND_MASK      (FILTER_REFS_ALL | FILTER_REFS_DETACHED_HEAD)
+#define FILTER_REFS_NO_FILTER      0x0040
+#define FILTER_REFS_KIND_MASK      (FILTER_REFS_ALL | FILTER_REFS_DETACHED_HEAD | \
+				    FILTER_REFS_NO_FILTER)
 
 struct atom_value;
 struct ref_sorting;
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 82f3d1ea0f..3922326cab 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -31,6 +31,40 @@ test_expect_success 'setup some history and refs' '
 	git update-ref refs/odd/spot main
 '
 
+cat >expect <<-\EOF
+	HEAD
+	ORIG_HEAD
+	refs/heads/main
+	refs/heads/side
+	refs/odd/spot
+	refs/tags/annotated-tag
+	refs/tags/doubly-annotated-tag
+	refs/tags/doubly-signed-tag
+	refs/tags/four
+	refs/tags/one
+	refs/tags/signed-tag
+	refs/tags/three
+	refs/tags/two
+EOF
+
+test_expect_success 'empty pattern prints pseudorefs' '
+	git update-ref ORIG_HEAD main &&
+	git for-each-ref --format="%(refname)" "" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'empty pattern with other patterns' '
+	git update-ref ORIG_HEAD main &&
+	git for-each-ref --format="%(refname)" "" "refs/" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'empty pattern towards the end' '
+	git update-ref ORIG_HEAD main &&
+	git for-each-ref --format="%(refname)" "refs/" "" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'filtering with --points-at' '
 	cat >expect <<-\EOF &&
 	refs/heads/main
-- 
2.43.GIT

