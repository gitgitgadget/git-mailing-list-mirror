Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B2D352C51
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 06:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785567215; cv=none; b=DJ5qpIT2Re8/jp5Uha7Rq5qnacXk+IlUb4y8iF/wC8Ij9nWmW1EoHc7jZJK3LR0wc57DaDQgg9HfqGE37uQi1WwA64jP65YE82KMCBnJo9mayoGSXUg07qS3chd3dns9WYA4b86piwxwQqG3h/yX4yXssEpS/gO4wUUBmKp/AtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785567215; c=relaxed/simple;
	bh=6ezV2Y9KVfrWfrWMNXmk0soejo5gai8maYtuwQpbsRg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=J3/T6Kda2Z5jJOkX/Xi6YFaOTUigXZfY4cO7c4fxcuhMFbp4Dy+UxlM/rzFrI0hjwEEPC/PiOVWXQRyQ9GuxeAROTvkZXnZodGtzs09bvgdIeJhQcFUlXtmDvOgplYQhG3yPX2X/MWZ1otoU/eDdelCTyW9Qwxmvh7AzmRovAd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bi/sRZnf; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bi/sRZnf"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84830c774a0so1784174b3a.1
        for <git@vger.kernel.org>; Fri, 31 Jul 2026 23:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785567213; x=1786172013; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=THQiB1D+Og7JJANO9uEtf1HunTOUdg5NwhCEiTIBqWw=;
        b=bi/sRZnfas4F+QYDkcss43Q5GdmsTXV+H/PTtT143ygc7NKVx/7oYuWJ9LI5Sa0vPi
         d2ixyFJUiFvsdoG+xQa1ABq0FJJf91v1yvnSH5kSgSLcxz0/mZ/j09GXrzpdd6dXlPuq
         +VwZWDk1awKrzVd+wfSBiFXUgG69Bzq0GZKZWL4Z/ilIywrTsnPF4zw8d5/0JUeisLro
         4YkYP/WmoNxM9krApzeOLd6k47Ge2RuPr7dVHZDYaZL+BoIhGyS7J3ImFob+mHoDac2S
         jqNNbLAsPkNfhIkGn8kyZ1SiSyrapM/OZU51cdSfFVa3lJzwP+hSx1V8EVbutlypXDdE
         Ur8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785567213; x=1786172013;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=THQiB1D+Og7JJANO9uEtf1HunTOUdg5NwhCEiTIBqWw=;
        b=gDsBeHLSnTB9oLZgB2i2+8a/cpK81aG8NgQ0Hk0HEoYM8Ccsj44y7fq9tSFzlZAgXc
         8Lg05YDpEIfmqPbfi93+GTOR0RXVl/wHJZc7CRo3RHvjvL5VCT27EvecIOILCuAVXElz
         kTlfwE12La5QBduWzlh4YLsPae1rk4KMp9nlWNMBGDFRRvxd8RIlG2lhhDVZP0WWUR9E
         HSJNj7hmdbOdAn3Xep0ZLOMMPr4L0iTI2E2w55oiGKpn7Rig+mMYtatgcv8tureEHM0n
         vwstAfdMzyB/xsueLeHYfSK/e+nD/bLYIOXiSvggqVxYsDlUFOupw+mlHJPR0F/EgPwH
         2WEw==
X-Gm-Message-State: AOJu0YxM/n836pM07PPz/hUMwtY7oUoO3mCWUfCMhff02RbrxFBrNeob
	w2dAe+kPA4kLs0bLKgXZR3CkuSN+bJzV1gG7ZP3KG9BrnvwUimE+2JhV4iL5NFii
X-Gm-Gg: AR+sD13w1NHDVdGqNJeRZ6wi9pQzfNUh1eBdmXHqYgwcNRyJFdopMgFJDzKOsX3bonZ
	Jeu1hOsf6tHU1RBinwtBaAjuoj+FOKzRbUsAFMqG0SWzCSjHRGh5HhTErsRWHjs7GhQjsTHM9WA
	GmZEBepeMI7AoIGi2w4J79RR9Q7tfUQ60hoY/pSggy+AlviDTBOvE3vd/NlYU5QtT2a/r5ndUT1
	U6fHXTxRkv0qvBeuS47fetD0ccnt0K7oxbSXD9w6sfP6w9wevaK2issfdKyS5/Dh+qk9SAE/SjI
	7dRlQLPkDOoxyOXugv/QAYoWE5Q50Ah/TZLprujmB5fNdumsls43GfhEUkpKnRusvbA+NdlENEF
	D0BSVwYznXChZ/PhWNAeG90wqLnPz5t1YgYyCl+8kXSK5ul/WptL2rBUCRY7whJ12KVC6A/EKI5
	n2IF+9wWzzzLw978YrPz7BVXUDE688kgU5EJArDpV6FU2xzu/HFxkFEHehZiHr6HY=
X-Received: by 2002:a05:6a00:138e:b0:848:53c7:b927 with SMTP id d2e1a72fcca58-84ee494ddd1mr2101150b3a.76.1785567213144;
        Fri, 31 Jul 2026 23:53:33 -0700 (PDT)
Received: from [127.0.0.1] ([52.190.138.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc5221d8sm1336840b3a.53.2026.07.31.23.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 23:53:32 -0700 (PDT)
Message-Id: <dd1deb5e5b52a1c585c3f96e6140cbb89fe8d8d8.1785567209.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v11.git.git.1785567209.gitgitgadget@gmail.com>
References: <pull.2337.v10.git.git.1784536024.gitgitgadget@gmail.com>
	<pull.2337.v11.git.git.1785567209.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 01 Aug 2026 06:53:26 +0000
Subject: [PATCH v11 1/4] history: extract helper for a commit's parent tree
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matt Hunter <m@lfurio.us>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Three places resolve the tree of a commit's first parent, falling back
to the empty tree for a root commit, each repeating the same parse and
oidcpy dance. Extract a first_parent_tree_oid() helper and route the
existing callers through it.

No change in behavior.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/history.c | 58 +++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 32 deletions(-)

diff --git a/builtin/history.c b/builtin/history.c
index d28c1f08bb..673744a55a 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -164,6 +164,25 @@ out:
 	return ret;
 }
 
+static int first_parent_tree_oid(struct repository *repo,
+				 struct commit *commit,
+				 struct object_id *out)
+{
+	struct commit *parent = commit->parents ? commit->parents->item : NULL;
+
+	if (!parent) {
+		oidcpy(out, repo->hash_algo->empty_tree);
+		return 0;
+	}
+
+	if (repo_parse_commit(repo, parent))
+		return error(_("unable to parse parent commit %s"),
+			     oid_to_hex(&parent->object.oid));
+
+	oidcpy(out, &repo_get_commit_tree(repo, parent)->object.oid);
+	return 0;
+}
+
 static int commit_tree_with_edited_message(struct repository *repo,
 					   const char *action,
 					   struct commit *original,
@@ -171,21 +190,11 @@ static int commit_tree_with_edited_message(struct repository *repo,
 {
 	struct object_id parent_tree_oid;
 	const struct object_id *tree_oid;
-	struct commit *parent;
 
 	tree_oid = &repo_get_commit_tree(repo, original)->object.oid;
 
-	parent = original->parents ? original->parents->item : NULL;
-	if (parent) {
-		if (repo_parse_commit(repo, parent)) {
-			return error(_("unable to parse parent commit %s"),
-				     oid_to_hex(&parent->object.oid));
-		}
-
-		parent_tree_oid = repo_get_commit_tree(repo, parent)->object.oid;
-	} else {
-		oidcpy(&parent_tree_oid, repo->hash_algo->empty_tree);
-	}
+	if (first_parent_tree_oid(repo, original, &parent_tree_oid) < 0)
+		return -1;
 
 	return commit_tree_ext(repo, action, original, original->parents,
 			       &parent_tree_oid, tree_oid, out, COMMIT_TREE_EDIT_MESSAGE);
@@ -475,18 +484,10 @@ static int commit_became_empty(struct repository *repo,
 			       struct commit *original,
 			       struct tree *result)
 {
-	struct commit *parent = original->parents ? original->parents->item : NULL;
 	struct object_id parent_tree_oid;
 
-	if (parent) {
-		if (repo_parse_commit(repo, parent))
-			return error(_("unable to parse parent of %s"),
-				     oid_to_hex(&original->object.oid));
-
-		parent_tree_oid = repo_get_commit_tree(repo, parent)->object.oid;
-	} else {
-		oidcpy(&parent_tree_oid, repo->hash_algo->empty_tree);
-	}
+	if (first_parent_tree_oid(repo, original, &parent_tree_oid) < 0)
+		return -1;
 
 	return oideq(&result->object.oid, &parent_tree_oid);
 }
@@ -830,16 +831,9 @@ static int split_commit(struct repository *repo,
 	struct tree *split_tree;
 	int ret;
 
-	if (original->parents) {
-		if (repo_parse_commit(repo, original->parents->item)) {
-			ret = error(_("unable to parse parent commit %s"),
-				    oid_to_hex(&original->parents->item->object.oid));
-			goto out;
-		}
-
-		parent_tree_oid = *get_commit_tree_oid(original->parents->item);
-	} else {
-		oidcpy(&parent_tree_oid, repo->hash_algo->empty_tree);
+	if (first_parent_tree_oid(repo, original, &parent_tree_oid) < 0) {
+		ret = -1;
+		goto out;
 	}
 	original_commit_tree_oid = get_commit_tree_oid(original);
 
-- 
gitgitgadget

