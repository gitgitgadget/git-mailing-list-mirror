Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45E53E717E
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773076345; cv=none; b=u+NqtoOngHanUIQBNrBAfcjxSafkdFhz0cy4Oy87F/Ozn43+3L4I2ccbxudzTNw0Rk8GbW3Ds24jT2iDEUZjsnQji2dKBQrg5zBfyxhR/ybt1OdfeUN+dnthSB/e6bnbdoh2NVd4wzUhvswc3M+zjw2ij6HHfdoGQ23AHfqWwmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773076345; c=relaxed/simple;
	bh=pcHEEakSadLLB/aL+vGhcdjg/XjK4nTOv42AwfqB2gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMQrMGbddjQSjsn6RGCx+PxlNRvt+XHfxYvlIG1AbLzCY0yvtSs69H1BtGdh/n1IYQTAAcQzHshrd34YIT9bABlhVjvAk5MtWjLWVen43hjc4hy3Y4EaGTHuM/4WY7Knmy6VVqhli92i50ONdJWEbSNAxOHd2KtthBpO0I+VtPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JywKIENG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JywKIENG"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so131371895ad.2
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 10:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773076344; x=1773681144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/IijtGVRXF7++a41ZtVUwUCvlGaRb63Awlk9TvTqvts=;
        b=JywKIENG1yeH4VqF9QkDV9IkGs/GHMNJqpSC+DdAIO8h7uCkd1lDZ9Mb55g7fbZlCG
         FFMBoe8B+Q7jN/uzxPaZMM1nmxKfu9DhSRflL4C7b87NTqh5gi9YWfy/mnu/IIdUw9JA
         stihqFg+8W+H3cQJx/XSF8It6BqIuR8nwhOTLUzzBzwIohUfKR7Y2IefL8RPzjNBdlqJ
         QzrNIssWI4Xs2ecXDCc5f96hLiedrXWEjg64MW1bgDEWn0r/BtZyyKRv6oAibVnOHoVj
         +De8nKCBw+2m5bFenruSuZaEmXa8PZ5LSSiVePNvlfKfZX7p9EPwtsZgHfnvghxi70BE
         MbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773076344; x=1773681144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/IijtGVRXF7++a41ZtVUwUCvlGaRb63Awlk9TvTqvts=;
        b=Ik1KAPTF8nEXYNnPfLGct1AzwEmIwXNq2drjOjBJ5ty2+QPf4jj8sV0AjDtY1yZmJ5
         quvoKUEm+MWMFBEVSB+HbjF1IZ2CDn+XeCJTbrAAI+ANPeUjuDZe90t+LyEJ5qimwBnb
         D/CBY+Blfmbh7Tr77gtvn+yQgFKL5PtWviHQiHehNYp4v1dQmvi7xu4kPDg4oR4ssYqj
         JtZOhzZUDXZ7pNtFCMu/DTwEFzGTfzgyU854+/L/u8bG26Acr16ih9bgnaQ5RyEh/kXI
         GpgcxGOIkdeqrLRibbPG5GqhQpmjU0/UOpRoBvPA7jSf3oY1Oq93CMiGtN4gHH2ZduI1
         TV1A==
X-Gm-Message-State: AOJu0YxuK/38fMsWTo/t1lSGfPRZofUy7ov4O4/09gfY7ZnkInByLEZK
	BKHFCmZBfKd/HifTsCZILwgiyy5MNH7MgIy9artevpTr8MPiSi71tO+k2e2xSkXB
X-Gm-Gg: ATEYQzz2PYz63SehZgT+XwEhXV1HmzS8FiPJQte8OxOm/rk/QPEc5yHiU6Xl8wlkM1F
	gdSimR78/COFaJZXOgLda3Ny0lIu8nZEKrdvgT4RwhRSnfUVML8MnXWBfEXrs2DsNHQqk6ArlJN
	8BVTAsIJXpFwkEGU5fcUR9g4vM4lut+uOXmkGf2m4KQu143zFZDhRW43S6/nc87haX6XcOE2dTF
	a1popzfA3cQSq41qXK0768LoSeShXCsIwtlvGGopYBt8wUsYcESE/X/fZ1McKYoenwZfo3967Vx
	bakyNPMT0ssI+ro4sb9CxLhU491J2i5XUx5Im/K2YKWqwft7wjyL0UVnFSvDCXELIdjj9uB8fLR
	dblEjLkXV4qhW2tbVv4yM1AS4Ay2d5jWfaSsvAcqv0wCbPJuiXTmuwt+8+gbiGXig3LlIBrQfr5
	NVwVcSYvy3GOMgVHijgBfC6Lrd6FevBQ==
X-Received: by 2002:a17:903:1ac5:b0:2ae:4908:de22 with SMTP id d9443c01a7336-2ae824611ecmr121062055ad.47.1773076343553;
        Mon, 09 Mar 2026 10:12:23 -0700 (PDT)
Received: from dorna-OEM.. ([111.119.49.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e584aesm118469805ad.3.2026.03.09.10.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 10:12:23 -0700 (PDT)
From: drona <dronarajgyawali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Dorna Raj Gyawali <dronarajgyawali@gmail.com>
Subject: [PATCH 3/3] repo-settings: lazy-load core.filemode in prepare_repo_settings
Date: Mon,  9 Mar 2026 22:57:16 +0545
Message-ID: <20260309171216.13339-2-dronarajgyawali@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309171216.13339-1-dronarajgyawali@gmail.com>
References: <20260309171216.13339-1-dronarajgyawali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dorna Raj Gyawali <dronarajgyawali@gmail.com>

- Removed direct handling of core.filemode from environment.c.
- Moved trust_executable_bit assignment to prepare_repo_settings() in repo-settings.c
  using repo_config_get_bool().
- Updated all references in apply.c, update-index.c, diff-lib.c, and read-cache.c
  to use the_repository->settings.trust_executable_bit.
- Ensures repository-scoped settings and preserves lazy-loading semantics.
- No changes needed in git_default_core_config().

Signed-off-by: Dorna Raj Gyawali <dronarajgyawali@gmail.com>
---
 environment.c   | 6 ------
 repo-settings.c | 3 +++
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/environment.c b/environment.c
index 9d12c5fa56..efec0758b7 100644
--- a/environment.c
+++ b/environment.c
@@ -302,12 +302,6 @@ int git_default_core_config(const char *var, const char *value,
 {
 	struct repo_config_values *cfg = repo_config_values(the_repository);
 
-	/* This needs a better name */
-	if (!strcmp(var, "core.filemode")) {
-		prepare_repo_settings(the_repository);
-		the_repository->settings.trust_executable_bit = git_config_bool(var, value);
-		return 0;
-	}
 	if (!strcmp(var, "core.trustctime")) {
 		trust_ctime = git_config_bool(var, value);
 		return 0;
diff --git a/repo-settings.c b/repo-settings.c
index 208e09ff17..0e44825a18 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -85,6 +85,9 @@ void prepare_repo_settings(struct repository *r)
 		      r->settings.pack_use_bitmap_boundary_traversal);
 	repo_cfg_bool(r, "core.usereplacerefs", &r->settings.read_replace_refs, 1);
 
+	/* Lazy-load core.filemode here */
+	repo_cfg_bool(r, "core.filemode", &r->settings.trust_executable_bit, 1);
+
 	/*
 	 * The GIT_TEST_MULTI_PACK_INDEX variable is special in that
 	 * either it *or* the config sets
-- 
2.43.0

