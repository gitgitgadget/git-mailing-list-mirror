Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B832F1474DA
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 13:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608126; cv=none; b=m47S6fGHFx9wjZFaYFqkbpSO15D2h4GieyHRfalUGdYz3tAG+59yuCLgRv7dcg1xfkMA0ey1tpOpUb4W93Y3J4ihRxkPsebjJnBC43tvev7fAVG3B9UFu0bT4Euso3XO41KdDJPiofIcOd55/mJwycmI92FV7STmAs7NVBA6sqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608126; c=relaxed/simple;
	bh=CLpj2eQfppOLJzGwC3VItCwf3+h1DC58UrsmbIL/P+U=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WSbIbfZAnn23UAn4XZKSL7A8irSskW7L5pe27gMqrmUPH2q6yonuHcLkh2SFr0yAVqWBEwtT5P0H8rksyNftwZ7seyzNPpnvJDAHuBoJz31vhArF+xLU0K4tVbaN0t2+4N1lvBPDRKcmlDgp0sAJvnGsFyY5foDhCpWBvxWtblI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPB6s5TM; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPB6s5TM"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41282be73e7so5134215e9.3
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 05:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708608123; x=1709212923; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpB/h3lwfLFrLf+CGh0DZz5bM0QyAjW0iXQElsRCUNk=;
        b=QPB6s5TM2Mh2BDQGu4jtYyqzhrmdd8H2n3cU5DuT4wBwVdQEGqoSA+1OXmntw/SXrw
         Q/o78O2H1AYmfGx5eHmLWwAqLReyL7zXMqHNP4KSAdS4DCxxd5HHzJzo1Dva/EZk7wmj
         J8WGT7DtqNMqqim8zRSnWhZoazpG+C+y7ko/Gpbw88JMd+tJRb/EORaIFSkJ4xGAZkI1
         DD2Td2AZ6z9IC/G5IH6L5h9X+896UdHHqjOEHse9BpudfZuqY4MWKDYPz3TFIVgJ/3uq
         tjdA0cFXaA6nLklNSTSFNR9J3eTxonQcrbI557j/LzooroyC72kQUxx/bom+EXCGpy91
         hWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708608123; x=1709212923;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IpB/h3lwfLFrLf+CGh0DZz5bM0QyAjW0iXQElsRCUNk=;
        b=IVmpzELnJnrRlJ6Fyfkl984YVEBQRqsidfZrXV6UlGHXPdyDZAxbuWXTv2Yr0zsYeR
         qKk4dHMAwIHKdfKFoh4ly3vcfMUdk8Uk84uHqLNkitugupXr766SBCypEFLWjg8c3e0F
         +buWNAd4TTL9vcZkUSZZ6e6s4n6n7517yHYFy3SdzFc7hR0OZBRprYo29CzAj17vuZP6
         Ij4Gf5y85XDSZByvTTp0qc12x0HX9EdrWGIni78nxlLuDuL2D0LCnUnxLwfGH8eKgZBf
         ndr0/IW6Az5wTovakhunv105XWOpXQSd7a/zwklEmuYQKLdpQZPO4ywrsCBOIYP59iSi
         ibkQ==
X-Gm-Message-State: AOJu0Yxbem/7mlDyzVxjzOZKEC2uhdT/p/CW0hsgG5nyWYqvPRwLdgTN
	VNSyqDy8qVXO578PQxMae4uEAc3Aslm3z45dN85mFHZz+2P6sEe4B3MELRsU
X-Google-Smtp-Source: AGHT+IG2XHZ/f0IN25CndpCZpIOklwiyinTglCBJpkB6euIG1lDmsHx2+4VLvIGWDczr/HopIMqO8Q==
X-Received: by 2002:a05:600c:458d:b0:412:60f9:3fec with SMTP id r13-20020a05600c458d00b0041260f93fecmr8910598wmo.15.1708608122925;
        Thu, 22 Feb 2024 05:22:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p18-20020a05600c359200b0041256523bf8sm19332455wmq.31.2024.02.22.05.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 05:22:02 -0800 (PST)
Message-ID: <602a7383f726c14bf7941653c2825b4c345247c8.1708608110.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
References: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
	<pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Feb 2024 13:21:49 +0000
Subject: [PATCH v2 10/11] repo_get_merge_bases_many(): pass on errors from
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

