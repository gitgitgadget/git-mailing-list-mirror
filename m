Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F15E1420DC
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040514; cv=none; b=phn+wB6Ipg0sEzehiFId5MTwfVkq38o5nxQy0VKEM6VSF4PrIjywz2AkpDJcJJ5vsFAK2+R9Y8L60+dOYD30iN/7v9x2KJFYviDBDjJet0SINIihCNnF477jsY4WNcT2T3dRtntEWzkQiieXeJND2wrblDj3YCahXxl5o0ykka8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040514; c=relaxed/simple;
	bh=CLpj2eQfppOLJzGwC3VItCwf3+h1DC58UrsmbIL/P+U=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KIPBPcqv0ow61AI5HJhrbGYyiCud9wMMnioiTFmjubewBZP4P7LW2PQQLzIeqZP9SGrJFLdtXhSK/ovzCFA6fAyiGz9YGI/sJ/Gn4ek2EHi9tpls4B2tGDDAc1nKmUfZFypCShDqaWv5p481QXBKFd6MLdcezr9DgAjGIvMpczE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQPUNnVB; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQPUNnVB"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33dcad9e3a2so1334474f8f.3
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 05:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709040510; x=1709645310; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpB/h3lwfLFrLf+CGh0DZz5bM0QyAjW0iXQElsRCUNk=;
        b=BQPUNnVB4EcYK4aIJsZ4AzHRwTJDt0FCB0iwkUs2kutXfvYgsmINhF9s4V4oqfrRxf
         9ENF+N8I71pWJSlo7aHxVqKplkmcZWD2BqNayKFv3gattW48brzr/9qRlclQJhd3n25/
         5KeTL+YUMSJ2hvovgX1AiutHOsj5p6zoda4btBbStRT11d+7tWX/EPNjq/ROM0LoBKsx
         XbI76XSaa9+pDEJOieToYyCLExInOPi/r/jTNOLtchwqvwo5g46fhYQtCBjdP/Ay3YqW
         0QV2TBlgyA331SsdjOGV8Zic4qPgaWkbM8zpPOmWqEiq5zEDLgqxj+apVzPAyOF+oLhq
         n1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709040510; x=1709645310;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IpB/h3lwfLFrLf+CGh0DZz5bM0QyAjW0iXQElsRCUNk=;
        b=JNHvk2tnmPfBpfHPMWQs/fNZtIzd4hmKMcY4Dh3xk8bI8jTNABp+iFLqu2tWHCflG1
         aMEIFB5i+5urjnii6ednGqdrSBRjVi04i22Q1MOFNWFHzbJTMKBOiilON3IBTePoLtnx
         +utyCt8M0254sOzjIDpqxU//KMaecSPmSOWBN8dpjTXl4pNLGuyu8abjZFdL2xhe3aWw
         HbMIpG79ZxWJjdyiVgQTiNZUVzd6adGUcppNmO1iOfI3Chlc9DH34TD4CeJ5NmuMNFGz
         dpl4jmNBqE0QNFXsXG+6X1ZQyZfXnN+zEi6V5fwqn5ZJJJEuN3+neh2KvyH+O/R84T4r
         1RHA==
X-Gm-Message-State: AOJu0YxZIZmZKbrTJ/X/pF/ns1oJkQxu5rRdnTFKTSsybqJsLlIoINIP
	RHIUzvLtry3EJ3iO5/kEPC2y/Jk9bOjePrmg9/jSnRtvLLoNfZFAmiTOafjR
X-Google-Smtp-Source: AGHT+IH7YXaK5ipabNhqKFfRQoVYNQXdfvc86FW3xvGLp3ZE9Z39iF/hvjC4/2PXLKr0pvLVVhRqZQ==
X-Received: by 2002:adf:fd92:0:b0:33c:f35c:a395 with SMTP id d18-20020adffd92000000b0033cf35ca395mr6732542wrr.52.1709040509755;
        Tue, 27 Feb 2024 05:28:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k29-20020adfb35d000000b0033de2f2a88dsm4424665wrd.103.2024.02.27.05.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 05:28:29 -0800 (PST)
Message-ID: <c3bed9c8500a0468d8c6a0d444b9e67dbae9e0b2.1709040499.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
References: <pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
	<pull.1657.v3.git.1709040497.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Feb 2024 13:28:16 +0000
Subject: [PATCH v3 10/11] repo_get_merge_bases_many(): pass on errors from
 `merge_bases_many()`
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
index fa21a8f2f6b..954a05399f1 100644
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

