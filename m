Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B2D2C21D9
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784128579; cv=none; b=Q0veJY+f5jh9fS31ZeTgMTSjB0Q0MUvqxr6ZgSuJjbYfvPU5tawHnNkT0jq26SmiCq9yZntxWXU8xVQ9zHGwrOSe1NcgAteGeLjXKZsHdndtMCyurd7lC1/LeaYewYQt98Hc0Mvwq/71CrOj1KLSS3DTMYp/hulrLkk2dLwt8Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784128579; c=relaxed/simple;
	bh=LgcZcASSmdDaWX/9Fl3YtCMi6FXzbJphsS1lXcE4Mr8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EuL40lY+Rh6/uGwj/QtnuHgYZYTj/0bMVWPQsTVVRkvmC9blSzrFuNkHWkjKGj/EQZ1vOkaqXlEZsxobwS9rm0Eonuhx7Zc8csdbHxjkSbft0RrFYoirDvrswNP6M/b0odozCxpHZkKoBa+dEj6ScEworrBv9eIoPnnc3yZQ3/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StAzI7gb; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StAzI7gb"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8efbafa1bacso46574156d6.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 08:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784128577; x=1784733377; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R/Drl4QmOGkoWQT0CmGfdmq/g5W/9fiTTPJZ6xzDKVY=;
        b=StAzI7gbGz5xny1Pb3rIjW68P39cZKuNAWHp7RTWEXcRKFhQyB7fQu9XjgToTzbDKI
         c0S4rasvguJVHGfNkrS8FUzrfzyQqNc1ZCjWICfjPmUFDGmetZCGNhQZWIfpfxOz4mLy
         xfLHZFPFEMg6YoC3+0IAscOS5T5X4r7kymnwwE845tB7p8ICbWezVSPl6eHJbL6YuQ0m
         r0YM3Aw8CKa+KhlDlNYqfTRfBaMxaCsDt6Fl+kA5sYNUR53yD5KQyGj4DQhSHF3E3+6Y
         fRVZQtUfmcBECcK6XNeUog1uVVpQlg3y+2kWV/WQgZGcxOomU4ELK+Z6AcqCSmgVjI08
         7xJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784128577; x=1784733377;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R/Drl4QmOGkoWQT0CmGfdmq/g5W/9fiTTPJZ6xzDKVY=;
        b=MT2byO6Edy2Gm4YlxtJ55MPTInhzJsuYjUVi8Yh8dQiExjwCT9P91Ye4WBR0m5m6Kc
         jgKvOrjPwhvfl+SwOe3FBMllvDIaPrIzd9ad8Ad9hauw1ZA3gQK6gWQR8idGTlYSY/tc
         l+XIkUx6UqSzUAcvkS/+oLNF4HHTu+PVh638hh92IVD6f3ccrVdwlONvDyyrDTbguiTf
         anyGHgTuA+p+miv3k+/5Kmc6jOf1qzf37atVUUFn5+tzO3kFond3lRrgeKyPDc+ZdKe+
         UGr0nQECD/PyEuZOTQ7riYqOgpW9u9C4CvqR4MxmRKULVyT3BXzauIYV0OsUFkoKsX0M
         D9Zg==
X-Gm-Message-State: AOJu0YzbviAQiCSdyRKV+/DoKRCRbxWeQf8WtzIVGpJrGE8Y8b6js6Ao
	M8mUZ+sfIreujd3ov6TnlzTvmayZWzXFr+fCc3bWJvOdcby5xSsy+EUTHwziXPfg
X-Gm-Gg: AfdE7clmePRBZA2YkML1ht7OfCvyWF/2oIi4A8iFtsWEB3UYqZ8m1Q4i3hcthPrS3VI
	zKBYHJY0pvnD5Ym2Elv6u+uyysGKdZcCL3OGRSFtwE59nnFIuSP/MKQi5/yF6Du4WZ91+tudh3L
	dKWsxCjRd+L3A95DcyGdhhwUWSz/IqDameRcVus4jV3qjFXTFCrgBuhIh8bipFawtgKB0MhkW9c
	e58kNDCdmZhLVPkyyHFWCTeaDki29gx6rUY4KWu/fqeGN8ixnxlcJzLVGndpLpQDm8sBTm797d7
	EOMsG0BWLDKvDyAqQv1e2lUrBM/Caw0MwTuaWxxtU6XpAp2iLXLMLpd0SE+/WhyHibpzbPhca4Y
	42yisVVHhbgfx3RCieFC5epkRxvmyqDOuAD3TL9SiMIcX5pKAPo3AT9Hf/7JUXCyZZykqIeQckg
	su5Tm97T8wJTgvaLY=
X-Received: by 2002:a05:6214:2465:b0:8f0:afa3:594e with SMTP id 6a1803df08f44-90758cbff9fmr36478876d6.8.1784128577057;
        Wed, 15 Jul 2026 08:16:17 -0700 (PDT)
Received: from [127.0.0.1] ([20.83.175.145])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd57baf98sm198935886d6.17.2026.07.15.08.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 08:16:16 -0700 (PDT)
Message-Id: <352c818c29f6423eb3d7f2f6b1f0b3eee8ce77e0.1784128573.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v9.git.git.1784128573.gitgitgadget@gmail.com>
References: <pull.2337.v8.git.git.1783674396.gitgitgadget@gmail.com>
	<pull.2337.v9.git.git.1784128573.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Jul 2026 15:16:09 +0000
Subject: [PATCH v9 1/5] history: extract helper for a commit's parent tree
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
index fd83de8265..9f516687fe 100644
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

