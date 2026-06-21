Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1B64964F
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 05:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782021200; cv=none; b=J+bNxoUCTGH4XdCh6KqQoOhJAO2FEAJhQCihgKfUtlzwmJRk2jHsC2cFxX+xOM5EZZ2Yz+uNwohQRZX15YL4BJViTeqYEWCwqPtfh5HFRRo74tvBDryDGR/B3WrmGG8ibv2X2HPvquuJ2Ap60mQG1j+rZz4CXFoMp2sslVZrvu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782021200; c=relaxed/simple;
	bh=Aieed0Ab3Y4Dhk5Bw+SRCcVyjjkjozfHkljAft8EY2o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gAd0eDrunRvbjPLcaCHN863A4WYUmYx0HMYp40ng//4uhJ33QXuhsD/s/8UsokDLqpteWfM8K8maqhF9tqOCYvI2w6+FLTAFnD2GhO97efLZw0epfR/zj+M4ncV6C3saN46z4IYQDgizltl3Zd1AQJbIwB8enpGPLzvVFS1UGPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s7Drs0+S; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7Drs0+S"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8dd6e530061so48228116d6.2
        for <git@vger.kernel.org>; Sat, 20 Jun 2026 22:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782021198; x=1782625998; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dn2UlbkrfFoLTynEoVyv1vGrG/Yhu5EM4WbV5afBQiA=;
        b=s7Drs0+S2WLt2s5HWo/TzL/GNtXi3WiP2+qyrglRgvN4n4obf7eVe4EOPH/zwSVp3B
         6eLI6NfmuiTndHNsPcP7AwN+WsSuGT3qxpqHf3TcmH7QDa5A+nhNXbeETnOrSmYfU0E+
         sFtoCi90oorKKzjH2ia/5hZtwagmiHdAmakdKz74B2pMoBwTW6uDR9Ovds+n8kBWGbBL
         5u7w3WD0ouzk7WxC4yDs4b8FLfps+xY7bq9MlUKl+csQaQTZ+RDZ9iXhEd+et3lJmjZH
         6xnFyj+ozMwXCNlXRnrbFoQid3u8hCAKcr5mB55wdP0FIlwybNweLguGvm8aiWs5NqJP
         pmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782021198; x=1782625998;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dn2UlbkrfFoLTynEoVyv1vGrG/Yhu5EM4WbV5afBQiA=;
        b=G7k1I91BqRVvpOwmspOLdMAGQHnAhHSC38gQLu08XA69hOnBxxK4o9nS+MRdtZJnjN
         //FNnO6CNyg3koeEOBN67xXgoUu79p1w3SsgFfiC3Zr4aEjg35VDtE5ZYGKUN7v5hXv6
         Z2aX1MxZbhlrWOth4XI0G2lEC5nGckMzdW6kq4hX9oGH+bQjUoil4BAIlf8SknaatRV5
         Int8pfG8l+5mhTozc4w0MFBhiXg/DHUTLXF+1/QkYT4GyNa6IMH6sReUMcqtA0NVgFU9
         xJn7Rw7Go7Ao+MkyAB/ea924NpJrREgS2aMAlGKgOTHYOWTgHTfsW6bFyXNCyzZyCUbD
         R9Aw==
X-Gm-Message-State: AOJu0Yx3ZN0t9RgJ5nrBdCpKyDLcYUoTTvHMvjReTg/FG9M5lB7JZPcw
	fUJs/gcY8fHAph7i2BTNrwWcFwm3wYzlSkeC0bFuX0ankEIGstAc1/6zbecGZA==
X-Gm-Gg: AfdE7cluYP6W62uAgrQlpKL1/W9dbAF7CzwRw0aeIPYsrKcUKzuAJ9IJtZk/8KyJ+cz
	zzTfTkAXe3AT90nZYCNY1/UscA2IMP2gvV9HO07Od1W5uX5QhV7v+XrKBzfuNa/Zg4hQjiuEeGK
	XWTSFEnh9g7nzDiLTwjFuzxNBEKvGezwRIxOYawstDT3WTVV1ZYUpgJ/NjLxvbP78a9n+zFocAl
	OX0UHFAHl0hVUQ2uMaVzUr9wYOn7QYJsJ+O/7kY242F5XuPh4mGemEzokOTgLvZGiGioilHV0BR
	IHSFrtFbqheD05W3IiZKcPTdpeLw9t7axqd1gU+GDYYuNmN+FZeKcYqpTjYM4pA9/Y5AU9shK4I
	kVtmOjeOcYfE1kWTTDt4e1Dnjm6RPFEfjsLI01ZszCAcJHVr80y1+QEzDDFaH2wLzqM7oySjm7i
	V68p72s+KBsxNuNf1cDw==
X-Received: by 2002:a05:6214:5b87:b0:8cc:d736:5f5b with SMTP id 6a1803df08f44-8de41c9ced4mr175798276d6.32.1782021197842;
        Sat, 20 Jun 2026 22:53:17 -0700 (PDT)
Received: from [127.0.0.1] ([172.178.117.209])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df82c6459bsm51900846d6.46.2026.06.20.22.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 22:53:17 -0700 (PDT)
Message-Id: <fc2801c0b123c567120dcce45aa2dd58a97aac6a.1782021195.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
References: <pull.2337.v3.git.git.1781810226.gitgitgadget@gmail.com>
	<pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 21 Jun 2026 05:53:12 +0000
Subject: [PATCH v4 1/4] history: extract helper for a commit's parent tree
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
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
index 091465a59e..f95f26e684 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -157,6 +157,25 @@ out:
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
@@ -164,21 +183,11 @@ static int commit_tree_with_edited_message(struct repository *repo,
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
@@ -444,18 +453,10 @@ static int commit_became_empty(struct repository *repo,
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
@@ -799,16 +800,9 @@ static int split_commit(struct repository *repo,
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

