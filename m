Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2FE384CD5
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 07:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786088376; cv=none; b=D/4L+WZFywUZNv8wiI90CCVkoTQQsFrZFIp/udFbMkzCrtX30gd4Oydp+vgq2ZWUzil5vGWYXv9tV//zaa5mXfrZLPWY2Wvx67xAOAl3W3jd+xq12JLUQg1OSQNOTpFWm/pamm+xj9MCSkCd1DFdSjMgHprH0m0C6ANJqeE9560=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786088376; c=relaxed/simple;
	bh=N/7TUrm6vOe+kNW/w55de34FWofa1fGLe4BX7byRVGM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=olWrR+hD49rwKeTMqlOCiKkvbclwWWVI5Z4loqHq7Lqk4g4pAYWt+buUIe6+u8npnmVXf8YMYFZAzSmQoQxw6NeCEyHc07m7epu1uPrlr4WYBOmv8xsOakXajB1Bzcu6hOB1w4vP8SfVTpNe5ULjI0zZIh9amwK8P4o+N6moPgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMVHAZ2q; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMVHAZ2q"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ccf2360620so29780805ad.3
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 00:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786088375; x=1786693175; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rAlw9fZ4pcjJIlmbwvwo+WycocKD+lpYuPpSb5wpU0U=;
        b=BMVHAZ2qU95O7W1NTdokA4Usiv1CuZOBl7tRPmYZDSc2otsPBOAYq6OT9QGiUFbQ6/
         IZBfNcQX8QUVVaAlUB3kuE8kW6byv4YZ35OiKF28EWuMrbMoigV3yivcBfKL19yD3DaP
         zgqwYGlH+O3JjxD0ghGQk9ofaiXs+yxkAKhgKoJGRDCZEi2tl4a4kEWPADW3AmKibrka
         qATlmOvCFxq+QxXQ9W1oqwugo8MdNdVzNekXlF9OxmOCAad5oPacaeynkU2xRV9/4IL7
         XZ0ZGrxP7kTGLvQaxA1AxZO9v8O2sDpPfR3lC9KVtlxFji+Situk/ttf5i2FD0ZLoJ0j
         +P3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786088375; x=1786693175;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rAlw9fZ4pcjJIlmbwvwo+WycocKD+lpYuPpSb5wpU0U=;
        b=RGZed+wEoX+hJ+ZUdvtQHdp7O4ZT8esAn8nuKtg3A1sCNgMKobZiF/KMJApOpOfOk5
         4ZUId5mXrenrtIiCu1R+rOw9TaM7bPg5gFzFzF7pRPTDcHQ0EKK6p/PwmqJHGV/gAZS8
         vbFebmv3qr2eU6505MfpuqFdzu0eSCxxITgRURLDQwASrfHuCFA+Wof1fy7tjgTF7Pvd
         e8O1J7qAytijD1WUYz+nnLzATPoIEKkTcj+J+W8UDwZ4sHsqwtFSGRDsSV1Kq9d5V4fm
         zAEWyM3UiroiQgJ6aIhrYBy/me32BUkfgHyLwnpaIuya35NyTYTE0gzrfeZpOmpEU6Ee
         sPpQ==
X-Gm-Message-State: AOJu0Yx5dj3EbmyYR4dk9tVg39TrZWUkSONU9b4CxedjplA8YYyJVMpN
	Ktn+Gv1Lm7pqMT/egn82g5GdwDc/SpBE44fDiao9ue8ku6f8hWNvuFtaguAijw==
X-Gm-Gg: AR+sD10Tm/zSCtHWg9qNJp71XtxL9N5Ol/nkH0+bsYJktu9Z79UUTn7RgUAJ2OSEnXv
	e901nm0wGPDxpnXUMoyXI9kfsHAngY6+gtF/AaJ3zNrlZuXyVpWQOHjDmeUekDdYOLRc6LmRPt1
	4lMlWpx/aXPnsd761jIO8K2wzzQeOG7vGZez6e5VssB/BcscmHjpll5a5QyfEqxkGfpVR3zowYK
	4IWNFnM9VEYWTlvoiSO9j90RQXcqWUowLi51apS4ywPFqtbgkzSm5cnA741FoB3YtSsP5xehC7D
	LOWajrW9aI1drm8YEnWW4tB8RtVUPgQ7VIjWzNcdKrv2oj27IGroF4ZTrOFXtvpztQzjR3RIshG
	fa9aFZuw0CVzYFDu0kRzF7hSueP07msYfrXMDSNuk3ZB8nIapFWpAn0icunl9MlYyZrwBidUGkt
	cvkGXFTFlMzKZnAXr1a67jvMQH3J21GK2truIDobcLrNcfjjl3yVKo2WScBZpxo8w=
X-Received: by 2002:a17:902:e787:b0:2c9:c083:cd50 with SMTP id d9443c01a7336-2d106e333f0mr88500695ad.17.1786088374869;
        Fri, 07 Aug 2026 00:39:34 -0700 (PDT)
Received: from [127.0.0.1] ([20.163.82.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14ccabdf5sm4831845ad.14.2026.08.07.00.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 00:39:34 -0700 (PDT)
Message-Id: <b175bdca54c1ba24b96a19eaf53c5ed81c78f8c0.1786088371.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v13.git.git.1786088371.gitgitgadget@gmail.com>
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
	<pull.2337.v13.git.git.1786088371.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 07 Aug 2026 07:39:24 +0000
Subject: [PATCH v13 1/8] history: extract helper for a commit's parent tree
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
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
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
index 000155ad9c..c22715d848 100644
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

