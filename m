Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5903D3CF1E6
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 08:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784536030; cv=none; b=B93s7vHmrTAsOIbm8Nmgwb4GpS7B9uMEidWWxJWBvnBl4eUTbnj1isYlaYpyFsQUngkvzj4SPUvf7Cx0MwBqGS08iIsvJSWU56kI+sRZd8VD1HtsRvnqEEuXYYONw5vZRjbajUJ3ypFY2uNO77y+fNMc3ark4Oi9XeL9dYcIDuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784536030; c=relaxed/simple;
	bh=6ezV2Y9KVfrWfrWMNXmk0soejo5gai8maYtuwQpbsRg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oIbjkZGY84y0pVhqQhsQ8QW/WolA1CKZsBBkwzd9xbV4ts/A9FCvJrrHuvimE1GF+bLIGM5oKfxjpQ6/ZAoVaA/6X+yr9Hh/YfxpBP9YQ2mWBHmsc0nWZrY1cwu5w40DFP4sJQRt/tVI38XMVm25NwIY36rRcxoPYVCVFdJn5hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvFGj5En; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvFGj5En"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e512a9a6bso602163185a.2
        for <git@vger.kernel.org>; Mon, 20 Jul 2026 01:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784536027; x=1785140827; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=THQiB1D+Og7JJANO9uEtf1HunTOUdg5NwhCEiTIBqWw=;
        b=fvFGj5EnYJtSK8z/rnDf6Ka30S14fUYd+4LEhTJGQw9016PU9r4vYwZ5sME4JJqxu1
         yBAVKoCxfSPoRoI2LAA9iKanfVZE+jErUjs8XxiEV7x4H51lOFZ5H/BEmgwoKdb8tK4H
         RPjmy1yfIsHcBT+Jqib0CHO6rlJkVLoOsL4e3SJOsqVmxSELAs77JovrEv0SIDfnabLj
         UfYC1PH8Qy0lQHomXGp6pibkbYX8Al2VS7BUywYAugW8JDzCl0Ccm0V3N9yVJdpfdqma
         hUVJmSdwCXbj69opEVSCLlD4oW7WEl55koOUVfxmv+ZuwjEMvxHjhKcEN9cfX8ePRD/U
         vECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784536027; x=1785140827;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=THQiB1D+Og7JJANO9uEtf1HunTOUdg5NwhCEiTIBqWw=;
        b=kWAWO2376HngzhbL0M5NKY0kGsMQcpvzMwexCLUGI6tR1C8KaQ1MYKuz7lLp5koJT/
         0hOPpTcaF+Ima2+ej+JuvX+hvaJxVBezrBwVwjlcXr3Bt8Jr8XW4yxIHglangfbqSG0e
         1/V/05DVKAialwZBuRHPoYAHQT43G1YzXARONFfuCaHALRCFSHk8SYFN9O/64QrH/R+F
         M10tRTpvdftmU3uXBY8svmCrsLa1CfWFRFb4j+ltQQHCNBPMkLL/OSpqopfyy1VJzSra
         ujMR7As2FIn+wKZZF941C23RLLHh155Hk17EVDKg/D/Ru/gLOU9yzd9/Wpuxo41JtjxO
         bqIQ==
X-Gm-Message-State: AOJu0Yy/Vv3+0GfRzWTO5D7Pxbg5CoRKfp51ScPhi8NXxmzTWSfvN6p9
	062aWmph3c64IEd+SrbBME1CWWiVP14b9M7iZFV+/dH0KlN3x+HNp39iH4cKtQ==
X-Gm-Gg: AfdE7clwxYhZYxW+YRtHPPOhQwKOjHLsoHamTyS6xNij0TvwDDJ0ksCpq+ycSDLj1R7
	SoWYf7yzXYl2vT4R57BAv5H0CRMH2Y/MQD67kQ2YSbNC5rO3nMHD+tvYAiO/j1IFX1hO8BiUBpE
	snC6Ty8T9dXisrd66sBW65z4nc06RklaE2OGpEPDcu6mVKknQtoERfOCUnL9PPMZuzxzZY7oqbP
	MqVImWB0n7ZjvzctnONEulN9XeY8z+4WblTFsFfFFhXbuxaYzKVm+xDoS+40PvpP4OIEepaU0cX
	B0244RzFfIdhYeB6F5epvl9rXe9qvUE763bcFJGvvux93rcXjy0VFlTY1x/rXPLFfB6ZykKPAdA
	LNQwP8e23eFJHEl18IPPOuFaKwzybKe/4yV/ho640vFjYT9vsGFkC95F0SiCW11XU8dVQq+INsd
	unbWVox3kqpdmvjCfDHA==
X-Received: by 2002:a05:620a:1720:b0:92e:8405:7ae8 with SMTP id af79cd13be357-930b3e8d4damr1248487785a.4.1784536026915;
        Mon, 20 Jul 2026 01:27:06 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.110.128])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545ed7esm818653985a.32.2026.07.20.01.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:27:06 -0700 (PDT)
Message-Id: <f8481034975769641a15a94e0f33b39d9cf7b07f.1784536024.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v10.git.git.1784536024.gitgitgadget@gmail.com>
References: <pull.2337.v9.git.git.1784128573.gitgitgadget@gmail.com>
	<pull.2337.v10.git.git.1784536024.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 20 Jul 2026 08:27:00 +0000
Subject: [PATCH v10 1/5] history: extract helper for a commit's parent tree
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

