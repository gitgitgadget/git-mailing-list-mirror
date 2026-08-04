Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22C743BDA3
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 08:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832257; cv=none; b=k39Tyo15pCGUVFJimnG6MjcKjGOdgKi1Whum7Lp3FpIxWkx9dv1b13y7ZODqpLftDFUKR0SDXR9lA5Y1KWrnC5S/RehRtFa34uoAeZlmmWmI3PZa0+skVpUCRjrTHyUtbK/CrOoiO2IsGzivaCQJ+PoBJaF9NXiTHfbZjX4uhMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832257; c=relaxed/simple;
	bh=N/7TUrm6vOe+kNW/w55de34FWofa1fGLe4BX7byRVGM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=byjImFcATSnXBcF/jsRRsKBtKO0hNioN8tKhyY/PgHzjneMOKa6oOaSNyIT0fwaXpd0L8Yd4XQ7nka4wuVodbTQ9fsJqxzAHO7/a54ex+c/t6ZpzWvXYEsaqALnvCuRp8gPSMef8zyU66uYfExO1i7RpX8YobZZantBjqOC7Pnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTZNVpBW; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTZNVpBW"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8201447e8cdso844087b3.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 01:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785832255; x=1786437055; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rAlw9fZ4pcjJIlmbwvwo+WycocKD+lpYuPpSb5wpU0U=;
        b=VTZNVpBWsbYuF2eGATzxu6OmBtxqhGg+p3zWAYB5f7u/kHEDpJ1htUFVV1fKBKKe22
         fm7VvVxmnfPyQFr4DgifdmCUT4HnfXwgtoIUBxCsML/jz66R16R2P8kCBL6nll6QVcw1
         mPhlOk1JtU67MGD69ExYUc1VTGee5p8/NUm+uP8At7+MYl0jOr26aYoZHCEBOLHWXFav
         PS0m8l2oS35iceqD5C3cyVkz/F1jceJW1+4X3FPKsb5hIc4EIsoXuhxROw2AdrXxpFqH
         pznftW9RV3Pfyc2AHhtt5JMVn4N5c0AnC6p10RoREyPiMiOoD2xWImbp+uiwYfUE618P
         7+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785832255; x=1786437055;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rAlw9fZ4pcjJIlmbwvwo+WycocKD+lpYuPpSb5wpU0U=;
        b=oBDvoXKWtGMlNiGSBIJFX2dO1IEDnn859He3LD54otASQwLmPM+7vGkQALa2ovVk21
         VIYNGV2asUbtDZ1E0YKcU8Wsob9QV55FqG3eOSmNzg8PjAfZBiPaCE4eQ9Es1A6vgHgc
         p/JP9NdgmB1as2MZC/enZqS+IFI7ZvxmvHsZqhi8TYmxzlbp4s0VYLlQcEYiEiFCjK+l
         ny1plYDzMyw8nrNcF49r/gY69qe9vjfPEGGgPIOq8yOoHkf/oJHGkGiX9VISYg4O865T
         UKBYiyRBzLTF9nRIvIcQLO91AYbp9kP/XXVuBFPvTfmnTd9SZ56i0YiRLKOjGoq5nJVt
         Tx8A==
X-Gm-Message-State: AOJu0YxXqxVlnTf7FDWDEqAp08861jPS8dD+EMdUJKYgQj/DiRuUaxVs
	s3bQqSYmcwPBURvIahWgw+pkDKope2ow+MYQR1PrFVwbr39KrMr4i5ovXHXSwg==
X-Gm-Gg: AR+sD13+igyPO3qgyy7oE6odoAUnlBf4X+Vna7S5a842wt1gWn6JXTvqETfZBzpIXxr
	o7a6dPwXXu0FBDK2VybdtfblnYSj36v+dx3Bjn9FA6Y6cNQVd/NZ/gQEFZqfxtKTKRw+eiVcVv2
	sXv2raLwDe790CQZxxZTrHnSI13ywWk8oLOUbgCwFy0GE4zwgh+vpqiGK3DXJfJbT6Man/vunnw
	r5MIR04kZSuCJcjP3uecIK6s9gtWQl4sPyvA3ZxFhtIFhbpqLkqt8w5PKlq4gCNnPf54HYa6sMW
	epNtYKAYbpN8tjQRRYs5TxGRaifz8WstDMtkZhHH7dkXKcWrtz3UkVkTM/ZnStl83NMdUe0EeHH
	QPaRaE+5PLROUVQUE/jM6uC+NVbv5d3CNc/2lDMoY1GWQOXDuOXWMKmQaucWLlkaY11mMtc+e4k
	/GapjRbWMwW2wlPbB6voaAQezfMOB6nfLrCcnLVmlxtyoVr0qPD/2pX7XtIGjd30I=
X-Received: by 2002:a05:690c:604:b0:7fd:4ef9:e5a4 with SMTP id 00721157ae682-81fd4bd6688mr177643617b3.29.1785832254931;
        Tue, 04 Aug 2026 01:30:54 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.143.40])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-82012f4ea2esm1775967b3.0.2026.08.04.01.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 01:30:53 -0700 (PDT)
Message-Id: <20e050a0ad9a3e9d665921561749cfed4ca089fd.1785832251.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v12.git.git.1785832251.gitgitgadget@gmail.com>
References: <pull.2337.v11.git.git.1785567209.gitgitgadget@gmail.com>
	<pull.2337.v12.git.git.1785832251.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 04 Aug 2026 08:30:48 +0000
Subject: [PATCH v12 1/4] history: extract helper for a commit's parent tree
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

