Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD7F41737B
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 08:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327863; cv=none; b=KkSV62nrk8Ci7mUwcASZUNWHCe6nDqwlyAN4im9MP6ov+dJIDK6/8Nd3Zr+hvxsI5NyMPD28cZH5w6FhuIZh1pW1AUMccRQY2yqemjbySY4NF1xlFAPIRl0SOeXoDUXaAv41wSvXdJKDh+I6YiOslk1axOZOgG80PkBLF4zpt80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327863; c=relaxed/simple;
	bh=Aieed0Ab3Y4Dhk5Bw+SRCcVyjjkjozfHkljAft8EY2o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=smed0auPhOqFyyg7lkCexbeNySXh3i0An6HvD40BQpG/TR+F3+lU2UWa1MnhRdLmmWlbt+aLLPBF4FVRBhKH+Z/JbsQls/bgY3dMkLMKTBLSNycOdGrwhfXr7PxxUippe/pC6fbaXdf7s3WztzwynvELnTrlsWbDz9/+Plc+kwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEHUTXTQ; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEHUTXTQ"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e622cc874so137569685a.0
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 01:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783327855; x=1783932655; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dn2UlbkrfFoLTynEoVyv1vGrG/Yhu5EM4WbV5afBQiA=;
        b=YEHUTXTQOpX7IBH9CEMTYnkjtSKU57e+W7MRBlv29SZzDs9PAvP7DJRC3JlzaxV+gA
         l3dtVucxguF4TAjlUCFp9O4WarwebAjFxutIkaqAfBDgDYT8bSi15z00xH5g0a+uY1fG
         yd3tEfEu2Xb55rvNdzH2dsQZfEZ5To7nrmHSDWHmU/JHKHnffiy7ceqiQetg2Joh8nSv
         GUbk52Hea7l+Ajf6XzESiTA/XUkESoMzuymkVoBp+G6IUKGU4sVnnmHAPDTZhYkgoHjc
         5Yf0JdzFX0yd468BKysugdaGhN06jazg5Iup3mwMBHKsdHzOQRQixkBTLO9jN7MsyC91
         m9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783327855; x=1783932655;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dn2UlbkrfFoLTynEoVyv1vGrG/Yhu5EM4WbV5afBQiA=;
        b=WuiAnd1lWTV2RdKljBFdWl7xON5M/puGx5zXYiVLHkiZHc7MoZKHwu3qogJcwDJpmK
         IIYlivzAdVt96w4SC0Xsimc51ks8e6zsIcB6/kX0lkyUHT6o7AnZkWG3bcJ+yWG6KgEE
         iEVq+NI791dF+xqopxnPJ+NegHb/rqPxKHNdWChfxXRbxHIKkz9U71XOVt73Yo8ISqor
         uYSounkW6/smJxstaIGZF7WWBbMi8OxLr6qdru20CJS5f1rmiQTsyQFkICMVNB03tGm6
         N4rpzZqx7PH6+dVXePafZjbZOBeySVy+FlcrcLRqYUCTFXGo9DZzpFtkMLUydsDN93rP
         kcSg==
X-Gm-Message-State: AOJu0YyLeXptPqaaotTJXgoQfnlNvPEi6nhYjp/C2c0PPzAktAgBs4DP
	mk8NENJ3njLzZVOgU7koVMYp5Ja4pxjbhTA7s/e/cKtwmy9epIhiRnA3tJ8WuAXQ
X-Gm-Gg: AfdE7clN0LCL3P8P/QLjO/srkQvKiKz3uUtneQ5olqI+KXGOwCEjzKStExDsrWrX8t8
	Z1UL3SS0ZFgE3o1rZLZipnLHnI5oCJnQ+xCOZPvAqO78CFnZ61VmMnFl4/QXTUfSLvtTPls54Q3
	8IXPmBqC/Gj38Kvk2tU0wLToZLvnC8pz4crAFQpfy1NsFArTuhBi/4crRvKM9hI93Mt3P0+JMDF
	hLssQXpioTOZjMGPfZlunIyZFmETfQ5lMFprHNz2wgWoFhNT3poO9UPtEOG4ZI5gNM4znEh+b9X
	tsRJwjdzdLVV87cJ8bR3L0BGbjl1Qj1DvtgofL0Liq2XJODpsDCK5C4UaEarq4XvE8/UikrD71U
	O8Byy7HTEEQdlTZ7uRQ6ZwI4JjkLrJ7RhB7EtmvKkOR7DUYnDTB1/du1DwHxQerpfhK2oJIVMMT
	kh+hMBMrkDgF5NnUU=
X-Received: by 2002:a05:620a:4147:b0:92e:61f7:5689 with SMTP id af79cd13be357-92e9a4cb130mr1266761485a.58.1783327854181;
        Mon, 06 Jul 2026 01:50:54 -0700 (PDT)
Received: from [127.0.0.1] ([4.227.174.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90b81342sm878234685a.7.2026.07.06.01.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 01:50:52 -0700 (PDT)
Message-Id: <56ed8fadbb469f695182ca0fccf88833dda4835a.1783327849.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v7.git.git.1783327849.gitgitgadget@gmail.com>
References: <pull.2337.v6.git.git.1782635349.gitgitgadget@gmail.com>
	<pull.2337.v7.git.git.1783327849.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Jul 2026 08:50:45 +0000
Subject: [PATCH v7 1/5] history: extract helper for a commit's parent tree
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

