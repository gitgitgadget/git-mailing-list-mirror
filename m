Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BD415D5B3
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 21:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718834308; cv=none; b=BDK5JKibWcKA4bw/Qy6pVLwa73Vn8KKLnTSaBP9wjhNRSnOao41zDg5FEq3OWVzahrWeUWmegpwcnQM9y71FbIpuauhztYHLsfUMCvIv7v8kf4muw5nNXLgJUVGj74IAHCYQ1CquSVBrlsjwdKopbtOqiTNdQfvlvQhvpkkBFAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718834308; c=relaxed/simple;
	bh=jcZMD+8RfTEOcB1+UKG0s/gAmNFV7KsJj1hSTvdFnqg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DGkjqww9ByTmyXG/JvZeAAEjyo4B699TRupMg5egBbNv+cEejmeGFOs8w9mcM+qom2UbBklBwNYR2V0+kyAd1OD4k0BmT7P0of6SBrmrBevLgBaM0WJFC9EuRwske9ipvRDpqwtPE8oqPgf+LSh2dW0qxPBkmkJD9Gf81IievUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOPv2QOz; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOPv2QOz"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-364a39824baso160421f8f.1
        for <git@vger.kernel.org>; Wed, 19 Jun 2024 14:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718834304; x=1719439104; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8aWo1CHlqx8/5ZeKAeCnaltdbcBQkOzvetzcKsMhh8=;
        b=aOPv2QOzOAAeS8WPuZPn/ZAvGU+Xwi0LeLxbDtvfmz3fRBhPRYEagNSw/FrVZ+zFXw
         i/zGr4sXV/hVMXJLec/XL6YVpJLELXkUZ8BkkAoE46zsf6m+XV1AzIWB1Od3fTseCbMT
         sTK/MoqfSMjA3hHG+ntd0DZ4Ac29FOvxqL38oFzc7xZSqJ3ztEcQtUiyY6TPNtCJ/zC7
         iBL/ANTEgxGFd1jdbncqUMwhvER81HVO6xuSoy4Jzcl9UIsndIQNpXUFdX0OaE0aDy+V
         kfyr/LxyU6P+k6o4GyAufXOfWctSuykP2mBMV1sGIRaxEZXGIjSEv+6NZtSFFd5W8lsf
         RP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718834304; x=1719439104;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8aWo1CHlqx8/5ZeKAeCnaltdbcBQkOzvetzcKsMhh8=;
        b=LGMCwwDRf2zz+1LYV7SdZMYrU4BCmztf/D40woFh4Jxw7CUrSYcMsOgpR0kulAE/nU
         HzSJVGCgR556z1cRHz4liEtHAPdCKF0pqrPFYQk1odwF9nhoO512nddoHQCrqCJJNIss
         FX7MyWVHnSebGVzXiTHdx8FxWcFfQjUGROPAnQq5xNzcgtclPD7pCy2Xr7VhA7aIyV0Y
         Gnx8z2uCOqUGZbXQNH8vivbAdhRI8QV4ig3djDlMRycE5c2WK2knN3UOlPbNv1+m5e3n
         WdN4bXdZBKzi84h2Ogq20zV2np40zlMvpL2StVVyy8SwZzO4G8mO+AAZYo4G+11ZXl7W
         u8Dw==
X-Gm-Message-State: AOJu0YyO2UAaB2p5cx3ZnEL3NbLclpi5x+1G5SwoOfznurXCh08Aw5Ai
	L7EQo0WR5LRs4tEDclgwKtqBtGKuyAF9YGI9MMLwQtkqqMC6ulgLOyxPXg==
X-Google-Smtp-Source: AGHT+IExqKgpraiuhstAgaLW9ju1iXv7za4P5uQ4vt375O5gu3x5pZo6fp4yUTuaWcrmf909/QoEWQ==
X-Received: by 2002:a05:600c:15cc:b0:421:8445:4f8d with SMTP id 5b1f17b1804b1-4247529e08amr23221825e9.38.1718834304472;
        Wed, 19 Jun 2024 14:58:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0c0f35sm3788815e9.18.2024.06.19.14.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 14:58:23 -0700 (PDT)
Message-Id: <56f28efff5404a3fa22bd544d6de8ce2d919b78a.1718834285.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
	<pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Jun 2024 21:58:01 +0000
Subject: [PATCH v2 13/17] mktree: use iterator struct to add tree entries to
 index
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Patrick Steinhardt <ps@pks.im>,
    Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Create 'struct tree_entry_iterator' to manage iteration through a 'struct
tree_entry_array'. Using an iterator allows for conditional iteration; this
functionality will be necessary in later commits when performing parallel
iteration through multiple sets of tree entries.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/mktree.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index 3ce8d3dc524..344c9b9b6fe 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -139,6 +139,35 @@ static void sort_and_dedup_tree_entry_array(struct tree_entry_array *arr)
 	QSORT_S(arr->entries, arr->nr, ent_compare, &ignore_mode);
 }
 
+struct tree_entry_iterator {
+	struct tree_entry *current;
+
+	/* private */
+	struct {
+		struct tree_entry_array *arr;
+		size_t idx;
+	} priv;
+};
+
+static void tree_entry_iterator_init(struct tree_entry_iterator *iter,
+				     struct tree_entry_array *arr)
+{
+	iter->priv.arr = arr;
+	iter->priv.idx = 0;
+	iter->current = 0 < arr->nr ? arr->entries[0] : NULL;
+}
+
+/*
+ * Advance the tree entry iterator to the next entry in the array. If no
+ * entries remain, 'current' is set to NULL.
+ */
+static void tree_entry_iterator_advance(struct tree_entry_iterator *iter)
+{
+	iter->current = (iter->priv.idx + 1) < iter->priv.arr->nr
+			? iter->priv.arr->entries[++iter->priv.idx]
+			: NULL;
+}
+
 static int add_tree_entry_to_index(struct index_state *istate,
 				   struct tree_entry *ent)
 {
@@ -157,14 +186,18 @@ static int add_tree_entry_to_index(struct index_state *istate,
 
 static void write_tree(struct tree_entry_array *arr, struct object_id *oid)
 {
+	struct tree_entry_iterator iter = { NULL };
 	struct index_state istate = INDEX_STATE_INIT(the_repository);
 	istate.sparse_index = 1;
 
 	sort_and_dedup_tree_entry_array(arr);
 
-	/* Construct an in-memory index from the provided entries */
-	for (size_t i = 0; i < arr->nr; i++) {
-		struct tree_entry *ent = arr->entries[i];
+	tree_entry_iterator_init(&iter, arr);
+
+	/* Construct an in-memory index from the provided entries & base tree */
+	while (iter.current) {
+		struct tree_entry *ent = iter.current;
+		tree_entry_iterator_advance(&iter);
 
 		if (add_tree_entry_to_index(&istate, ent))
 			die(_("failed to add tree entry '%s'"), ent->name);
-- 
gitgitgadget

