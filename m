Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1844A3838F
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 09:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709113475; cv=none; b=fuAzO39ShI9W88ylxt4sx7fiLUiayPsZNrZ/JGqbGWsqstgQXWhIDGlC0NOplNW4U3sHrIZaE5NJUjurZhwVMDtqpzD8RTbQuRxQEGxzrEJA7HichSSaODxemj6cWh2/07i2gp7QZ1o9q5+n8PtxV9UCaGvw6eBiIGputBg/stc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709113475; c=relaxed/simple;
	bh=053G4gyJCDPXvy4KaKrU+xs7Huyanhwp3MVf7KCDwr4=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=c/+QWnD/mhQc74TXOykBqNrIqOeHreTMpHTUbgv06nNlie53TKj0DX2o3UDqGqHGHzBIrgAeeJB8FdOQjC9S5SVEYsvNI/xYDkVpYGNDF5UGKrQKLvewm9rHYo2bFvL56jhNtoTsEbI9HntLuiR0CZHQJv8ccRDlbM7NmqNKBJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiV9zWAj; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiV9zWAj"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d28e465655so40582821fa.0
        for <git@vger.kernel.org>; Wed, 28 Feb 2024 01:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709113471; x=1709718271; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAjm8UNz8yTNpUODr4WHFqUZbJI+oy7Hb6vSSq2LznE=;
        b=QiV9zWAjP3wu58xM9z1ZLDokJDWtZ1fIgiHwGgvmJSel4IBKJ+VmRvWi+d9MTaQaBX
         7JWwJtpH7xRdKEjjh5eTrvPUIID5gpqOiiqzmWH9wWwgRrmQGpIUUbDDt7IUwuIF3bRc
         Tw4VUKZxG3cuKRJ2QY6UtB1GtN3qmTsGVpee2jxMB2PQtblA9FYOEolVeI0bQydmYRdo
         GoIWT7Hni6bROgehN4U9KkoUX1lsnsEOmpOhHfOU6f+a07H8CF43J2Ud3M4tuhXNahpC
         TWwiuiz4mymwwaFY7p6GxBAp1DmivdP6Kao7HGfZWkX6qgAL/dILycsRbmynLC6tqCpq
         StNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709113471; x=1709718271;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAjm8UNz8yTNpUODr4WHFqUZbJI+oy7Hb6vSSq2LznE=;
        b=TSyD8nTbkIyTyhsiWh3AvHZ+Gd0TrZBoO2mqGH/j3aasCjgj6XgmQ9IP8/Eaijo+UD
         qLkfWPsPjbI7Hw/hcUgcOOCexwbntJW7D1DUzsKbbkPBOOB7cxuPohmFt6Ryn8Xls/Ah
         pw9dt6A3idcrngRBLBapCKKkCbT3TZHFbi34fNmZY3q3iKXPEZKAEzTqsbqTm1jrMXlq
         IQYcz1oTIkYC/caHtWVodTzOm6CeJsXxvLWihD96yXMNgoAG/BC3lOcpLlQepmdfwcXM
         fsNWyU4gAnrrMSQiNR00bM+1P2yQChhi+yRIoTPUTGsfMN4JjbxQglXAP7GgAY3HKgwB
         ZSqg==
X-Gm-Message-State: AOJu0YwZ7HxJBbzABydYVSwOSRdczds8/9vw6/YvMiGBq+nrXMXFpT6k
	nVOQxWr7x09r8N68MbPAkX7SE9j+NbZlNHLtOsE8Xruwl309vkyQdkWYKLGI
X-Google-Smtp-Source: AGHT+IH1stcaUwdiq9kaBBU60905HHID4iPZ3jvnhHR/q1ccwduun2RIa5iDqnHI5DZ75bamRSpptA==
X-Received: by 2002:a2e:9ada:0:b0:2d2:37e6:501b with SMTP id p26-20020a2e9ada000000b002d237e6501bmr7027251ljj.43.1709113470755;
        Wed, 28 Feb 2024 01:44:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o30-20020a05600c511e00b0041294d015fbsm1565769wms.40.2024.02.28.01.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 01:44:30 -0800 (PST)
Message-ID: <32587b3caa701cf548de08ddf8a32a80e7de2325.1709113459.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.v4.git.1709113457.gitgitgadget@gmail.com>
References: <pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
	<pull.1657.v4.git.1709113457.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 28 Feb 2024 09:44:16 +0000
Subject: [PATCH v4 10/11] commit-reach(repo_get_merge_bases_many): pass on
 "missing commits" errors
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Dirk Gouders <dirk@gouders.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `merge_bases_many()` function was just taught to indicate parsing
errors, and now the `repo_get_merge_bases_many()` function is aware of
that, too.

Naturally, there are a lot of callers that need to be adjusted now, too.

Next stop: `repo_get_merge_bases_dirty()`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 bisect.c              |  7 ++++---
 builtin/log.c         | 13 +++++++------
 commit-reach.c        | 16 ++++++----------
 commit-reach.h        |  7 ++++---
 commit.c              |  7 ++++---
 t/helper/test-reach.c |  9 ++++++---
 6 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/bisect.c b/bisect.c
index 1be8e0a2711..2018466d69f 100644
--- a/bisect.c
+++ b/bisect.c
@@ -851,10 +851,11 @@ static void handle_skipped_merge_base(const struct object_id *mb)
 static enum bisect_error check_merge_bases(int rev_nr, struct commit **rev, int no_checkout)
 {
 	enum bisect_error res = BISECT_OK;
-	struct commit_list *result;
+	struct commit_list *result = NULL;
 
-	result = repo_get_merge_bases_many(the_repository, rev[0], rev_nr - 1,
-					   rev + 1);
+	if (repo_get_merge_bases_many(the_repository, rev[0], rev_nr - 1,
+				      rev + 1, &result) < 0)
+		exit(128);
 
 	for (; result; result = result->next) {
 		const struct object_id *mb = &result->item->object.oid;
diff --git a/builtin/log.c b/builtin/log.c
index befafd6ae04..c75790a7cec 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1656,7 +1656,7 @@ static struct commit *get_base_commit(const char *base_commit,
 		struct branch *curr_branch = branch_get(NULL);
 		const char *upstream = branch_get_upstream(curr_branch, NULL);
 		if (upstream) {
-			struct commit_list *base_list;
+			struct commit_list *base_list = NULL;
 			struct commit *commit;
 			struct object_id oid;
 
@@ -1667,11 +1667,12 @@ static struct commit *get_base_commit(const char *base_commit,
 					return NULL;
 			}
 			commit = lookup_commit_or_die(&oid, "upstream base");
-			base_list = repo_get_merge_bases_many(the_repository,
-							      commit, total,
-							      list);
-			/* There should be one and only one merge base. */
-			if (!base_list || base_list->next) {
+			if (repo_get_merge_bases_many(the_repository,
+						      commit, total,
+						      list,
+						      &base_list) < 0 ||
+			    /* There should be one and only one merge base. */
+			    !base_list || base_list->next) {
 				if (die_on_failure) {
 					die(_("could not find exact merge base"));
 				} else {
diff --git a/commit-reach.c b/commit-reach.c
index 288d3d896a2..0aeaef25343 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -462,17 +462,13 @@ static int get_merge_bases_many_0(struct repository *r,
 	return 0;
 }
 
-struct commit_list *repo_get_merge_bases_many(struct repository *r,
-					      struct commit *one,
-					      int n,
-					      struct commit **twos)
+int repo_get_merge_bases_many(struct repository *r,
+			      struct commit *one,
+			      int n,
+			      struct commit **twos,
+			      struct commit_list **result)
 {
-	struct commit_list *result = NULL;
-	if (get_merge_bases_many_0(r, one, n, twos, 1, &result) < 0) {
-		free_commit_list(result);
-		return NULL;
-	}
-	return result;
+	return get_merge_bases_many_0(r, one, n, twos, 1, result);
 }
 
 struct commit_list *repo_get_merge_bases_many_dirty(struct repository *r,
diff --git a/commit-reach.h b/commit-reach.h
index 4690b6ecd0c..458043f4d58 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -13,9 +13,10 @@ int repo_get_merge_bases(struct repository *r,
 			 struct commit *rev1,
 			 struct commit *rev2,
 			 struct commit_list **result);
-struct commit_list *repo_get_merge_bases_many(struct repository *r,
-					      struct commit *one, int n,
-					      struct commit **twos);
+int repo_get_merge_bases_many(struct repository *r,
+			      struct commit *one, int n,
+			      struct commit **twos,
+			      struct commit_list **result);
 /* To be used only when object flags after this call no longer matter */
 struct commit_list *repo_get_merge_bases_many_dirty(struct repository *r,
 						    struct commit *one, int n,
diff --git a/commit.c b/commit.c
index 8405d7c3fce..00add5d81c6 100644
--- a/commit.c
+++ b/commit.c
@@ -1054,7 +1054,7 @@ struct commit *get_fork_point(const char *refname, struct commit *commit)
 {
 	struct object_id oid;
 	struct rev_collect revs;
-	struct commit_list *bases;
+	struct commit_list *bases = NULL;
 	int i;
 	struct commit *ret = NULL;
 	char *full_refname;
@@ -1079,8 +1079,9 @@ struct commit *get_fork_point(const char *refname, struct commit *commit)
 	for (i = 0; i < revs.nr; i++)
 		revs.commit[i]->object.flags &= ~TMP_MARK;
 
-	bases = repo_get_merge_bases_many(the_repository, commit, revs.nr,
-					  revs.commit);
+	if (repo_get_merge_bases_many(the_repository, commit, revs.nr,
+				      revs.commit, &bases) < 0)
+		exit(128);
 
 	/*
 	 * There should be one and only one merge base, when we found
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index aa816e168ea..84ee9da8681 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -117,9 +117,12 @@ int cmd__reach(int ac, const char **av)
 	else if (!strcmp(av[1], "is_descendant_of"))
 		printf("%s(A,X):%d\n", av[1], repo_is_descendant_of(r, A, X));
 	else if (!strcmp(av[1], "get_merge_bases_many")) {
-		struct commit_list *list = repo_get_merge_bases_many(the_repository,
-								     A, X_nr,
-								     X_array);
+		struct commit_list *list = NULL;
+		if (repo_get_merge_bases_many(the_repository,
+					      A, X_nr,
+					      X_array,
+					      &list) < 0)
+			exit(128);
 		printf("%s(A,X):\n", av[1]);
 		print_sorted_commit_ids(list);
 	} else if (!strcmp(av[1], "reduce_heads")) {
-- 
gitgitgadget

