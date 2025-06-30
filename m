Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5942BE56A
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 19:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751311749; cv=none; b=gHzMaTbJDYiBPbvUzVCeo+xJFD3skR2JnBeyTGpfVL+SBdgALDhMP3TdWf8h+Vb6LlkZhbq+wGnXES6PUXYuDAKISG9EZB6I+tXSVzjK0vGeMe2gcAofeYmWvEmfnGMPjFR8fR6SBri1sObIVXP+xHW1Vh+cVh+ll1UevY66e3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751311749; c=relaxed/simple;
	bh=T9NJsdSSlpElMrB4/JOG4iEMzJtYMICfUZFLxvv9W28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YIb9sXieCqEAja/XMBmrdVWTS5z++ZrjYiRI6bSNq8qYDfq7k/3e/0be3tBTf5MATUwUZ3SGCYSOkzySDQWlCiAKEsBvqBhtR1Wwpd6zTJ5fCPvUb77ScX0BoijyelT9/8e5iFKg9xFQKPJ3b64BTtlprlIsB5Lg5mjAu7S8meU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUZ0DYvR; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUZ0DYvR"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-747fc77bb2aso2378076b3a.3
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 12:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751311748; x=1751916548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hf6plflFvjF83ejLdXBzot6Lz2tAzRitQPYeA30Jwc=;
        b=fUZ0DYvRFeRGZcj/B6V+oUNGhwkDIvUZ0bvlVjJvGHtNGCO02fbc83T/tslxNeN3hH
         35ad47L5LE9pydAMI7pdbYOgMzXpn1IGy9Rpz+EFApFz7pKpn+kTGt+AxRpGoaw8TFek
         jQ21JYkkdimS7E+1n/UYVlh8yiaDKu9lfdVEoKjnJFYR8QUg8GKbil4HtycMF0RBpFcq
         dvRn9eiqi7VnrfA3ZlYq+egLtqVkMgpwZbOgO5v5qmp2xxRt79eKspmX11uIyG+aCTgz
         AvrP0oKw2pFG5bJHYazRPL4ZwEBX0BaTd2kgjk8GN0jBzjPAmuqdzzIL1V6KhVj9YqKr
         nfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751311748; x=1751916548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hf6plflFvjF83ejLdXBzot6Lz2tAzRitQPYeA30Jwc=;
        b=BupoW54AeRniZcak406sSqSk1hoEWD+dG+otr1hjbTGQfFubJHNkv15Y1XYj6H5o2T
         ue6ETwP89dia1ud7o+vikQ3y56UZe1Wb7r1Cd0a3n7AaC1OHRprRfDNAcE/cbPuF5iwK
         /LEvoVk+TmfyJTxLLQACfJY/l2ezkMBWnkpApJ1AR6m6qrNg9L/zuc5YJvTuedYs9hop
         mRaFfq4emUB03EQ4/zHbtsGkMzhEeGXe6NlJOJAyBVVr4JR3g1F+DSLM9eVVJHpMLgev
         hEdrVffP8Iof83GoZd8oX69DYTGIl+yb90Kv7qdCztopcJieahaGYF3dlJ4HyRPOXSGs
         JtxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyuL45L9mpw2VfIuJ3e+Ij5IbV2DUYJ1hq2KXwyOZmIJLltuaMvLo3fUXX0kH0yV9dPyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEo9xaus7UaZKWVw2ikSCmSXSNQuQ7x26QciL+1okiaCk6VYoI
	fvj6T28xBaAfBaHW3dZ/id113coRAu3DkaTBkiKEs8U24zseyjzpRtM7
X-Gm-Gg: ASbGncuV74U5dCsKAEOR0R7NlcJHqF5hTJ9p+9yNKdAYTOWK9vLqxYZXE6haDWya7Kq
	qB/197XUniRr/foKs9bb+09P/F5mh7k0iiVPaD4QzfPm/4fIdYA76ZuF8Wv93OKljxGbwAx1HvP
	a4pBgQ/Kah08QBEJ49e5eW0tKmWcZAHVP3Z1/pkvZO0JIODUNbHi6JGhoXShJ68VBNY2K3sK4SE
	EqhqWZdyLCjdIQsApzsefWTEh2ahckBRzfiA3O7jNDkI33kAkPoXaBFt0ZeIotsWagg6QtPEyyd
	Lhh/wmSVbJ3IZi4VrB8kGmZeiNupPIViU0c2Ai10kx0nklS9GUt9IB0RB2QG9bqp25Dmk0wv+pO
	mQQ==
X-Google-Smtp-Source: AGHT+IEXMaY60sUGJv5E+hzBehZyXcSTGc3Q3/RmzmaUlxvecrGKPdmpPeXrDrhW4SKdZ9qyS6HDSA==
X-Received: by 2002:a05:6a21:918a:b0:21a:eabb:ab93 with SMTP id adf61e73a8af0-220a12a67damr23737879637.6.1751311747618;
        Mon, 30 Jun 2025 12:29:07 -0700 (PDT)
Received: from thinku.localdomain ([110.226.180.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af557b27dsm9757779b3a.84.2025.06.30.12.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 12:29:07 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	shyamthakkar001@gmail.com,
	gitster@pobox.com,
	ps@pks.im,
	ben.knoble@gmail.com
Subject: [GSOC PATCH v5 3/3] environment: remove the global variable 'sparse_expect_files_outside_of_patterns'
Date: Tue,  1 Jul 2025 00:57:48 +0530
Message-ID: <45c84a6615aa15f19b34b7f3d73a6e418c178427.1751309770.git.ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751309770.git.ayu.chandekar@gmail.com>
References: <cover.1751309770.git.ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The global variable 'sparse_expect_files_outside_of_patterns' is used in
a single function named 'clear_skip_worktree_from_present_files()' in
sparse-index.c. Move its declaration inside that function, removing
unnecessary global state.

This also allows us to remove the definition '#define
USE_THE_REPOSITORY_VARIABLE' from the file 'sparse-index.c'.

This change is part of an ongoing effort to eliminate global variables,
improve modularity and help libify the codebase.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
---
 config.c       | 14 --------------
 environment.c  |  1 -
 environment.h  |  2 --
 sparse-index.c |  4 +++-
 4 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/config.c b/config.c
index 707fe0707a..d212329799 100644
--- a/config.c
+++ b/config.c
@@ -1636,17 +1636,6 @@ static int git_default_core_config(const char *var, const char *value,
 	return platform_core_config(var, value, ctx, cb);
 }
 
-static int git_default_sparse_config(const char *var, const char *value)
-{
-	if (!strcmp(var, "sparse.expectfilesoutsideofpatterns")) {
-		sparse_expect_files_outside_of_patterns = git_config_bool(var, value);
-		return 0;
-	}
-
-	/* Add other config variables here and to Documentation/config/sparse.adoc. */
-	return 0;
-}
-
 static int git_default_i18n_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "i18n.commitencoding")) {
@@ -1808,9 +1797,6 @@ int git_default_config(const char *var, const char *value,
 		return 0;
 	}
 
-	if (starts_with(var, "sparse."))
-		return git_default_sparse_config(var, value);
-
 	/* Add other config variables here and to Documentation/config.adoc. */
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 7d46b80711..d51e0a14aa 100644
--- a/environment.c
+++ b/environment.c
@@ -64,7 +64,6 @@ enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
 #endif
 enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 int grafts_keep_true_parents;
-int sparse_expect_files_outside_of_patterns;
 int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 unsigned long pack_size_limit_cfg;
diff --git a/environment.h b/environment.h
index 00a5b332a0..5121a28d3f 100644
--- a/environment.h
+++ b/environment.h
@@ -160,8 +160,6 @@ extern int precomposed_unicode;
 extern int protect_hfs;
 extern int protect_ntfs;
 
-extern int sparse_expect_files_outside_of_patterns;
-
 enum rebase_setup_type {
 	AUTOREBASE_NEVER = 0,
 	AUTOREBASE_LOCAL,
diff --git a/sparse-index.c b/sparse-index.c
index 6fd782a8fc..ff33b8516b 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -668,6 +667,9 @@ static void clear_skip_worktree_from_present_files_full(struct index_state *ista
 
 void clear_skip_worktree_from_present_files(struct index_state *istate)
 {
+	int sparse_expect_files_outside_of_patterns = 0;
+	repo_config_get_bool(istate->repo, "sparse.expectfilesoutsideofpatterns",
+		&sparse_expect_files_outside_of_patterns);
 	if (!istate->repo->settings.sparse_checkout ||
 	    sparse_expect_files_outside_of_patterns)
 		return;
-- 
2.49.0

