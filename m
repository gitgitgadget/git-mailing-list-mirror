Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE90211A3C
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743436289; cv=none; b=HjqXwnQIUsDVdF7E8oUz/DHUBiP2wZLiSFhVy6jtdvvn5V1ddoN4mGTMn7sqhqu/I2FGp9zZMcUR2oSMBm9dsWAIPZqLnytv9VdlBzx5S78kmTNxk5c0hSHKU274MbLJ/NCS1D84MpbKhiYUos0FAde6QBC14bQzyyfs3hZBkcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743436289; c=relaxed/simple;
	bh=L4lxolB2tYaHNy7VDTe/eONuYsbby63x2s2HxKaWjHM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Esm2SJPtKFASUkDATCluyjBHsBBldM54L1mLO5cgXZz44EeKSmsTYS1ANvr52CF9E2RgeQ8Dt/B5TT0tADMcUI6Iqi0piBkj5/3FVVZqWkN8q73i2/y1CG0tX/hEJmZzxOFERYXRJHpnxnUj7juIZWMOWSIWB9VZztJCMECKrUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8EgIuX4; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8EgIuX4"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso4446549f8f.0
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 08:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743436285; x=1744041085; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHNLSWzKsgEAT54mfo5BmzjuzXYWxeumxxUZzgW97BA=;
        b=X8EgIuX4kiekp6JfvpfkCPLaQdYFryvO/c/mvmfCTEqfHqFlUAxjMhxR1U0VvrDOqt
         3b3//ffTmDB66hkA5d2FW8AWPYsAMVYx6ROR9HMC7/akNa4e36e/GZfPL/Y7bg9baj4j
         Rj0dkEkyKPi8/563CrSlvvCeNzwAsPdcKs/Y5jf0Ga8i7yNMNKSv7zYkUl4dgicgJa09
         5JHpsmQMAs9MmEJ5+Ib4Hql+NXW1ozDbhlycquX3guun6WXqiU3MnETv0GgtEcipwYxw
         MED0Ws3o7l+txZH/8AxTD/jeEkFWt9U3upxZwJkqwQTmXErEBWwAS8ZZnZlZfpGaEpLr
         /VcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743436285; x=1744041085;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jHNLSWzKsgEAT54mfo5BmzjuzXYWxeumxxUZzgW97BA=;
        b=WWSAShiSMPECwWfxqNA0/OyIvoGMcrHrDW0o651M1GZikoMCxooMwaEwHgslQSZgWr
         f7wElBseK9fj52UDyN83O7maSoffOUZS8NkcZf/8m/+pcKAmuKLWhSJbnOapQs6OvLe9
         x4IMbesRx1/w2ic0R4/SjgrrRDdNRo6IY+sukd+drVXdVbE6bnYy0GwtbX9+stJLGDRF
         mOYYvs1Tb0IhS+h1co9wgoDkDTm3dgp+Qi0k+t5XCLhX+55H0eq4/Yaegq4m6DqwJmwO
         P9dP3rYFN7JjDkyuMVZhHzx+TrmS5iG8qGXv0H3UjXzmZf0SAdCzjEKYQpuEe5Xni7e4
         bCzw==
X-Gm-Message-State: AOJu0YyZXJ+L19zPl0Zlf4pmpeK5iabzW4AUryWi6P0Y4QI3BWXWOUfH
	Y8uMkvEUejRHMJVmLXchqWJH5HzWeE1TqCgNPBFU5wA279kDTOOWv38uTg==
X-Gm-Gg: ASbGncsjy/ScEgdVRNWcjo4bHQkouyd9v6oTLya6r01EZTNFzoWjepoIX9zAjw9cdgQ
	vja/titHPkViUy0THYjGfbz7ns1LMqxua6pCFSMRp27iErfHY9bzdSJINIkYXTE8Z4t8/skpv/c
	fkVa1p7eRNlNNVtMOkzbLE/6pcgjWZXkjolZOIezFb6GZCKEwplJ3YYZ7t1SHGk2ucIpeAwNYKO
	5krtTLsglpK/rBgzHzkUkwDkpCCfsvFOLUHuFYENkw3fILpO2JgkqGD8K5qcP5iESHfR8ykPcLq
	8GzDiCziO18lpHI28AXxIXKxvXq4hLdOzcpinaT5W0WiUQ==
X-Google-Smtp-Source: AGHT+IHQ/BTYiQxZcD/Ch6gtluabzChUkUvj+sjqJA5XlkS3ly07zblP9ELZkhccwAuJ6M+ofDV/kA==
X-Received: by 2002:a05:6000:178b:b0:39c:1258:7e17 with SMTP id ffacd0b85a97d-39c12587e3amr7569335f8f.56.1743436285155;
        Mon, 31 Mar 2025 08:51:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b66a8c9sm11479933f8f.47.2025.03.31.08.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 08:51:24 -0700 (PDT)
Message-Id: <39ff4860fcdfd5c80181971fa2b3fdd90428a163.1743436280.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1898.git.1743436279.gitgitgadget@gmail.com>
References: <pull.1898.git.1743436279.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 31 Mar 2025 15:51:15 +0000
Subject: [PATCH 4/8] sequencer: switch non-recursive merges over to ort
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

The do_recursive_merge() function, which is somewhat misleadingly named
since its purpose in life is to do a *non*-recursive merge, had code to
allow either using the recursive or ort backends.  The default has been
ort for a very long time, let's just remove the code path for allowing
the recursive backend to be selected.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 sequencer.c | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index ad0ab75c8d4..b5d91fd3515 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -781,28 +781,19 @@ static int do_recursive_merge(struct repository *r,
 	for (i = 0; i < opts->xopts.nr; i++)
 		parse_merge_opt(&o, opts->xopts.v[i]);
 
-	if (!opts->strategy || !strcmp(opts->strategy, "ort")) {
-		memset(&result, 0, sizeof(result));
-		merge_incore_nonrecursive(&o, base_tree, head_tree, next_tree,
-					    &result);
-		show_output = !is_rebase_i(opts) || !result.clean;
-		/*
-		 * TODO: merge_switch_to_result will update index/working tree;
-		 * we only really want to do that if !result.clean || this is
-		 * the final patch to be picked.  But determining this is the
-		 * final patch would take some work, and "head_tree" would need
-		 * to be replace with the tree the index matched before we
-		 * started doing any picks.
-		 */
-		merge_switch_to_result(&o, head_tree, &result, 1, show_output);
-		clean = result.clean;
-	} else {
-		ensure_full_index(r->index);
-		clean = merge_trees(&o, head_tree, next_tree, base_tree);
-		if (is_rebase_i(opts) && clean <= 0)
-			fputs(o.obuf.buf, stdout);
-		strbuf_release(&o.obuf);
-	}
+	memset(&result, 0, sizeof(result));
+	merge_incore_nonrecursive(&o, base_tree, head_tree, next_tree, &result);
+	show_output = !is_rebase_i(opts) || !result.clean;
+	/*
+	 * TODO: merge_switch_to_result will update index/working tree;
+	 * we only really want to do that if !result.clean || this is
+	 * the final patch to be picked.  But determining this is the
+	 * final patch would take some work, and "head_tree" would need
+	 * to be replace with the tree the index matched before we
+	 * started doing any picks.
+	 */
+	merge_switch_to_result(&o, head_tree, &result, 1, show_output);
+	clean = result.clean;
 	if (clean < 0) {
 		rollback_lock_file(&index_lock);
 		return clean;
-- 
gitgitgadget

