Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E078003A
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 18:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130303; cv=none; b=LfYTCMubbSExF5i8SZSuca3wcVVBtaPPYGAfNY0RfTkvLqoVNiR59wtjQG18aui54ejqCnFQOw0bMjzi5sT+6OnbSKqEIzKQl2ueyXwadIQEqA7qYvTCOaqevKYG33cRe1OqIXcAvlFH5f5wzyuShrfIg98nnzA9mD/yKE83uak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130303; c=relaxed/simple;
	bh=vggQz5xtKp4oYLuEIP0VITAk9w6tsTow1AjNYRGSm+k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VhmESR8TBCnxzw7ZtMZaT6pmPHZYApjRn/dALfitXBCkXWxWnhuuTicaIuwdR+Q9PdauDBxzqHbMyS7IT2c1XnF+KBusgZnXb1CwhQoQNGB/fTQaJeT28aBi9jNiY+R+LZAzLopjRcMacvIISqh2yhy2JH1m10axg48DTjWDqco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJJcDw96; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJJcDw96"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-35dc9cef36dso1348508f8f.3
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718130300; x=1718735100; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+pumRK8woWcFCtpeQ0wPDzTGFwi1qaB2U9Y2Hxalmg=;
        b=fJJcDw96h0qO3j6puRVKCRr6CxYBzjAy8EJzKmM0z8FelYylzC9+nuTMPeIi4XnBHh
         wi98woyIOP0RDPHqy/YKn94Jyx9EcjcungHRBem7z2bg/j8W4ntgiKWOwv6VFaeVDv8L
         XC0o1npowBV4TujVfscl3deBy/i7M3nlb417sj2iOeGDeZOOsYoEMyPdeplqMjQLb11Y
         CGdALTQkxd3uy1yJbCIqAm9gKtn8D7TE1dZzcZUQ5UtC3KPrA7VzC3lfE9roq3e23210
         KV+59BFPu/3Z50SD6oq84uPwo77WAe3co8qTKxYOGscPlgm6WN8yb9dR9szKP06wk0kW
         /8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718130300; x=1718735100;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+pumRK8woWcFCtpeQ0wPDzTGFwi1qaB2U9Y2Hxalmg=;
        b=WjwwcNq9sFOUfzq/eoAq8bHceia+M2j5VFckG5CdA5ldtfyYBfxqt0U0dNRZl0bgXj
         Of+hot7iWOXdtXZKtCz0y+1KUNiC7CAEozKLZjCneZBeyHwjbOYep8fy/uKRewDt7sdu
         ZKdUdfI/Sz00vMB48lP1H39GQcCowcaVutfgf1c8ZOIVtHKj2yZ/ElHEgygqcNb/t0Fc
         xYYfPwy7YnDwziqNBAJdezXVN6uc4buKUuw0H6WXvCU64eU9QIxseyV1x/CA+jZJorub
         z2ILE9hNlZ5mKp9iKfoXZ4s+bShgEpWdC4VRLY51Y9NTI8Z5pFSZriim/PDZ1Qd9qLpe
         B6Rw==
X-Gm-Message-State: AOJu0YyxwXCmkhTRuqkQWjtjCZGDWSSVcV4aZquuHm2iCYGNIcafAL0L
	HOqce8huabb4R1zLJ+3cJhqPIrFLmf/SntHtAbUkxy8fkKf8EkWryD0hrw==
X-Google-Smtp-Source: AGHT+IGDE4QCdiN1xX3doqqKEa2SDI3axnkx2FOjUWoiedT3a/iyoZ5lnYPHEZYDuu2V8K/SemcJSA==
X-Received: by 2002:a05:6000:1541:b0:35f:24dc:ad97 with SMTP id ffacd0b85a97d-35f24dcaedcmr5277825f8f.34.1718130300197;
        Tue, 11 Jun 2024 11:25:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f254fb3c2sm5836625f8f.49.2024.06.11.11.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 11:24:59 -0700 (PDT)
Message-Id: <94d6615d634c4f78c88d3e01abbb27f13f85828c.1718130288.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Jun 2024 18:24:44 +0000
Subject: [PATCH 12/16] mktree: use iterator struct to add tree entries to
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
Cc: Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Create 'struct tree_entry_iterator' to manage iteration through a 'struct
tree_entry_array'. Using an iterator allows for conditional iteration; this
functionality will be necessary in later commits when performing parallel
iteration through multiple sets of tree entries.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/mktree.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index 12f68187221..bee359e9978 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -137,6 +137,38 @@ static void sort_and_dedup_tree_entry_array(struct tree_entry_array *arr)
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
+static void init_tree_entry_iterator(struct tree_entry_iterator *iter,
+				     struct tree_entry_array *arr)
+{
+	iter->priv.arr = arr;
+	iter->priv.idx = 0;
+	iter->current = 0 < arr->nr ? arr->entries[0] : NULL;
+}
+
+/*
+ * Advance the tree entry iterator to the next entry in the array. If no entries
+ * remain, 'current' is set to NULL. Returns the previous 'current' value of the
+ * iterator.
+ */
+static struct tree_entry *advance_tree_entry_iterator(struct tree_entry_iterator *iter)
+{
+	struct tree_entry *prev = iter->current;
+	iter->current = (iter->priv.idx + 1) < iter->priv.arr->nr
+			? iter->priv.arr->entries[++iter->priv.idx]
+			: NULL;
+	return prev;
+}
+
 static int add_tree_entry_to_index(struct index_state *istate,
 				   struct tree_entry *ent)
 {
@@ -155,15 +187,17 @@ static int add_tree_entry_to_index(struct index_state *istate,
 
 static void write_tree(struct tree_entry_array *arr, struct object_id *oid)
 {
+	struct tree_entry_iterator iter = { NULL };
+	struct tree_entry *ent;
 	struct index_state istate = INDEX_STATE_INIT(the_repository);
 	istate.sparse_index = 1;
 
 	sort_and_dedup_tree_entry_array(arr);
 
-	/* Construct an in-memory index from the provided entries */
-	for (size_t i = 0; i < arr->nr; i++) {
-		struct tree_entry *ent = arr->entries[i];
+	init_tree_entry_iterator(&iter, arr);
 
+	/* Construct an in-memory index from the provided entries & base tree */
+	while ((ent = advance_tree_entry_iterator(&iter))) {
 		if (add_tree_entry_to_index(&istate, ent))
 			die(_("failed to add tree entry '%s'"), ent->name);
 	}
-- 
gitgitgadget

