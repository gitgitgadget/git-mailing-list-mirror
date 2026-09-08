Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748883B05A0
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 20:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900125; cv=none; b=AfWZh1ueOjXEf5Bznth/froJHzoMGxsdmIV+rpqddzcLf/44UNaDmCWZrqT9HYyBlEDvyGhLphRCXzPsCzdRnlT4AIrpbb3ehsafDCM/Al+N4tn5NJ7vzYIjWRgz4aclx+tOufsdkTYg08XvomARp5fOiqNmVE7BkyIWeONYxEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900125; c=relaxed/simple;
	bh=N/7TUrm6vOe+kNW/w55de34FWofa1fGLe4BX7byRVGM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=C/sQgpFfsWcWLh31hOnaKh1pIAV2/seIE9YMZ663FxUBRsE1x0OYk8I0snoOTYuCFK2UppEGh9TXlo8dAoT+5EeSgw8gjh38jnysaYoZb7P+DueEFTBJ4D41sVqxRQ6oUP2+Ug0wjRygTShZ08QyvN37sCZqqU186gMtF/U9pc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFmP9Xcf; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFmP9Xcf"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-9309d4ea213so536017585a.1
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 13:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788900122; x=1789504922; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rAlw9fZ4pcjJIlmbwvwo+WycocKD+lpYuPpSb5wpU0U=;
        b=MFmP9XcfqhNhLW/aEOMAcWrnAWp6yj0EQsgo3KBL0zfwXjG6ADcUWW7Oo4HirQN564
         qNcuD4SekwQoLznj2VGocxzTbCTtTCfxCQ0wOm2riSP9CAHBSomynZcvqhlSCkPO6fyt
         1RSol411X0MJf3aND1lKDbNtXdUiOvIGiSoVnd8bNYDW1dGaIJWgMdAJIhvkGboSDER9
         T2E6BlryasV6pGOBY5tQx3Pu46wSagFwPacmivnTHTt6Xc4Uwb09nMQfKhSTHUCcj/kO
         I01lzwaouDZBdSVFK5Kl6IZi7jHix8eYn+cBEtd1H5iXCsuirDKq0o+diKfS6wiIxxWo
         D16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788900122; x=1789504922;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rAlw9fZ4pcjJIlmbwvwo+WycocKD+lpYuPpSb5wpU0U=;
        b=ZAWsNJ1/d+PgNrGugHQsfwWQ6q6ZETOUfpK5j79BrBBKwh3tYjG21+s6ZNP0LrLCp6
         ap2jN6l7o27f7azuDs9ZsO758xRSczEN/05RfxQjCC5UKIdngUMvY4mhHiPok+2LHfZa
         hNSEVO26CHOEdf5YJ3jWB7g4tbHRuHMpq1GzBUfDaHYiPpGysBxDxMi4ozZGbVfdPUe/
         7qBYU2mRDfvTGwKsZOccyIQz0xwpyDVhm7LhdIKeXAupy5KMZeqLhBGiQlrtMafsZAGe
         eNr4CFZ8cXqTkWEcsw71ftZPxaCtaLJo6XzasM3NN2chudvufRs1HYFGJG/WmQhsH2us
         K5ew==
X-Gm-Message-State: AFuF++nZw8NjrmVceEz3P0fjRTJjWzwjCS6Ws5d1Db1V/wNtQRxj7brn
	SzK3jG0dToIuH/dCfrNv0Z7u/Kton0T7E3JkTYAC6zHv3nINA2FLxr7XO2qmiw==
X-Gm-Gg: AYBFou0wG5GL6U2mt3Qy9CnD4nZBm5aTgy5vHPTZbU2r/0neCsAL2r/p8SbHLT2FoXv
	XF+bZVaXhWHQnrGTTFqTUFYc9Cm2XntctgX613PYWWfUrqOO7wWT3JDQTlsZYf45Ho2Teoq0XTD
	rLJ1+u8o2RyLk2OYgwWxCk4RgDbK184tQr3jSsIvbcejXwjSAYmVo6EjRpzvpH4M92ace8pmaxX
	XuOUDVLEtXmrpr3ubZy/n9b0nWmtvUE0yyjfQ4EmJrKY/iqg6Cy9M6Xr+r4xLH64Zrie8TtvDoD
	dXgTHZ2WgwO3+3hSP6sR80EQxbH6WVDrqZRTGubFV8wgIQBPc8+Y8BH/T/Z7+HQzJID+sgps1o2
	bpJn+RtkPOdv2pn2LGRwKseihdNyQJHt2vjt4sszl6o39uHjd5hYD3Leafn/8YYzOI5SvWFmilZ
	6Afj/9m3XYwEE2Ha5e+njnU2Pb+Sz8PmWbuewf8SiN/gTCk4vYxVtaer85ncBSc03C
X-Received: by 2002:a05:620a:410c:b0:936:bcd8:8650 with SMTP id af79cd13be357-9398072a3f9mr3503118985a.38.1788900121912;
        Tue, 08 Sep 2026 13:42:01 -0700 (PDT)
Received: from [127.0.0.1] ([20.106.198.166])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9399d6e267csm792753185a.44.2026.09.08.13.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 13:42:01 -0700 (PDT)
Message-Id: <98a1b756bcf13cf47f71141633df57dd1336aaed.1788900119.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v15.git.git.1788900119.gitgitgadget@gmail.com>
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
	<pull.2337.v15.git.git.1788900119.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Sep 2026 20:41:52 +0000
Subject: [PATCH v15 1/8] history: extract helper for a commit's parent tree
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
    Tuomas Ahola <taahol@utu.fi>,
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

