Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBCD19DF5F
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 13:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756472412; cv=none; b=D6voGhRHqtMVWnKvLrtzjXhXuZ20HCkYTspJa7uj6RBCYYLLD9qaOmigIbU85NTxBlv3tt+pponY6FcE3uUCH4GPlbNGFY6l9mC353O6xp+4UNt3sSGd1n2qny9+9mmU3dnzEIQK6pW7K5SUgMQElA9G+krQ7iGbveLaEcQBKvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756472412; c=relaxed/simple;
	bh=dsExlpa6sFh5MCGKV+2P6wC3clY1mWk8MLjehxVI5Sg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=JtL0+ZGrQcm5Wi8RSL4XptO1L9Ut4FA6Fg3UR1LbTk1Nz/GmKnQk2UK1xyR9JLIRKcxcGEtTrhcqBQxgFfVZEwW/dWtVmpSxXSL6+kQWx84Huh1sSBe2rJ5GgHk3jHuMjpX5F72FtX5U1BeXFI3HLTuyHqpcN+JglogPQnxpchc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwuqFnMR; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwuqFnMR"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3ea8b3a64c4so8372855ab.2
        for <git@vger.kernel.org>; Fri, 29 Aug 2025 06:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756472409; x=1757077209; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSJB/MITg1eVCOFwuUwHEVUA4dbnnVNjwSWoZTjmT+c=;
        b=YwuqFnMRzm34Ji6z1Co4mCdrYRISvokG+sXJ6OmkEJITxPwDT3VMhYUZ+XgwpyheEl
         qqSApEh10K6MG28oMSgVILbsaRRlifPK9LiH9FnQGGyYYzhiYmdij+n5tMpWSkycSESh
         u5gijQucMLr8qi1Y9W8LgeAUThWmPJDV5ZmXc+dJ1oIrbqOYonRjJ8o2NfmUoHxYZ4F/
         iD52hX+bCt/ezvr4wv0ouZBUOphEzZxp+ff6ZPIeD9aiN6UF3Z+IIPwOZvcPKm9BIvXI
         qutLzgQaCKScwmE+f2Pg5ChwZ9rONH2qYfjtresF5SRA8ehwdA0kzW2SCls6Chm44ysy
         0y8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756472409; x=1757077209;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSJB/MITg1eVCOFwuUwHEVUA4dbnnVNjwSWoZTjmT+c=;
        b=SQXXsP8jBSl7NJI8RgWSDdCOXC3yrT0mm70x0993oM1BFC/C4oNpOKM4ngP5eDwPB+
         Ud7hZqJ3+mupncaGSAw/mwnP4bjRPpBvvpc8jdjr9eHcGMiH05YgDVZiXHMJQPfI4cYz
         JMaC23dXOsypGYacsZpcIPBXWVG0qKNJv8gpc1YpTjbKRZI9CBQwxJJKU5q8v1adsj6s
         28XYtzUWnAS4XNJqxH7ogYJ9kqRPtWOuwUnr7XhsuLzWxaH6mSWLgNVELS23F8qlaI29
         ggXM+Fonbe46rXdjjy7rfnzDxv8XdE3HZ6dJI8ouwzitJ1KKkhnx0kMAnQoiEOgdILJL
         qPeg==
X-Gm-Message-State: AOJu0YxUDrKm8xPzC+Ya0RtRFtVKawKzqs+ZScTEenwv2BlWsONk+VjU
	xfmYZ+qd1SKEKmofYdRm79ffbLrkck+Ou4Wuxv5/1u29086ycFVlfcK9+0DNnw==
X-Gm-Gg: ASbGncsSfePNuQ1dn0xaT7ESwEjn4CZ6Y/zzfbN1gL2CwIVR2hKb+s9HpEMav1RbJ3F
	Ej63FYyF3CSX5dC69XGzCuWi8GNT5Zo6Rxu05eXWWNBYA9hGE1gIvv+4FLU8DX1wmSWTb2V//87
	a+40irRShoscGGslBks81U7TYRzFG/Zp58/H4O0aRCLc3kNBQxtefVDNg7p3UEwG9MczOL4DZEl
	gW+IbtZoTSTJZc9mWe+VUFGkvLETHphfJYYFbKqMq5I1IWFDoAVo3ioIdrDNflDJoqSrhAGnDoi
	JkB7oz3wg7enrm2crNYct+IVTpyn33Lcv9N/Ib9pM/ui70iNiPudWDS600bgFGuPVNhfVCkX2Jk
	IiO55ZzZWibrp8T4mKNnLPzJn6oq5gwbIpkeD
X-Google-Smtp-Source: AGHT+IFd6q7DqnNUF8NLfdqAYMLEeZucl8lf1VZCGDmERp4z8dB2crY77I5bwdTd20qWiCVrCV3d4w==
X-Received: by 2002:a05:6e02:3c03:b0:3ec:8541:a5b6 with SMTP id e9e14a558f8ab-3ec8541a786mr305689065ab.25.1756472408161;
        Fri, 29 Aug 2025 06:00:08 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.201.37])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d7be0190esm538051173.12.2025.08.29.06.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 06:00:07 -0700 (PDT)
Message-Id: <pull.2040.v3.git.git.1756472406487.gitgitgadget@gmail.com>
In-Reply-To: <pull.2040.v2.git.git.1756337312918.gitgitgadget@gmail.com>
References: <pull.2040.v2.git.git.1756337312918.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?=E3=83=8E=E3=82=A6=E3=83=A9?= | Flare via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Aug 2025 13:00:06 +0000
Subject: [PATCH v3] alloc: fix dangling pointer in alloc_state cleanup
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?=E3=83=8E=E3=82=A6=E3=83=A9?= | Flare <nouraellm@gmail.com>,
    =?UTF-8?q?=E3=83=8E=E3=82=A6=E3=83=A9=20=7C=20Flare?=
 <nouraellm@gmail.com>

From: =?UTF-8?q?=E3=83=8E=E3=82=A6=E3=83=A9=20=7C=20Flare?=
 <nouraellm@gmail.com>

All callers of clear_alloc_state() immediately free what they
cleared, so currently it does not hurt anybody that the
alloc_state is left in an unreusable state, but it is an
error-prone API. Replace it with a new function that clears but
in addition frees the structure, as well as NULLing the pointer
that points at it and adjust existing callers.

While at it, rename allocate_alloc_state() and name the new
function alloc_state_free_and_null(), to follow more closely the
function naming convention specified in the CodingGuidelines
(namely, functions about S are named with S_ prefix and then
verb).

Signed-off-by: ノウラ | Flare <nouraellm@gmail.com>
---
    alloc: fix dangling pointer in alloc_state cleanup
    
    cc: Torsten Bögershausen tboegi@web.de

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2040%2Fnouraellm%2Ffix-dangling-pointer-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2040/nouraellm/fix-dangling-pointer-v3
Pull-Request: https://github.com/git/git/pull/2040

Range-diff vs v2:

 1:  0b980850bd ! 1:  c521b44adb alloc: fix dangling pointer in alloc_state cleanup
     @@ Metadata
       ## Commit message ##
          alloc: fix dangling pointer in alloc_state cleanup
      
     -    clear_alloc_state() freed all slabs and nulled the slabs pointer but
     -    left slab_alloc, nr, and p unchanged. If the alloc_state is reused,
     -    ALLOC_GROW() can wrongly assume that the slab array is already
     -    allocated because slab_alloc still holds a stale nonzero capacity.
     -    In that case s->slabs remains NULL and the next dereference writes
     -    through a NULL pointer, causing undefined behavior.
     +    All callers of clear_alloc_state() immediately free what they
     +    cleared, so currently it does not hurt anybody that the
     +    alloc_state is left in an unreusable state, but it is an
     +    error-prone API. Replace it with a new function that clears but
     +    in addition frees the structure, as well as NULLing the pointer
     +    that points at it and adjust existing callers.
      
     -    To fix this, this patch:
     -
     -    - Renames allocate_alloc_state() → alloc_state_alloc().
     -    - Replaces the “just clear” API with
     -      alloc_state_free_and_null(struct alloc_state **s_),
     -      which frees all slabs and the alloc_state itself,
     -      and then nulls the caller’s pointer.
     -    - Updates call sites to use the new helpers and drops
     -      redundant FREE_AND_NULL() calls.
     -
     -    This makes the alloc_state lifecycle API harder to misuse,
     -    eliminates stale-capacity state,
     -    and aligns naming with project conventions.
     +    While at it, rename allocate_alloc_state() and name the new
     +    function alloc_state_free_and_null(), to follow more closely the
     +    function naming convention specified in the CodingGuidelines
     +    (namely, functions about S are named with S_ prefix and then
     +    verb).
      
          Signed-off-by: ノウラ | Flare <nouraellm@gmail.com>
      


 alloc.c  |  9 +++++++--
 alloc.h  |  4 ++--
 object.c | 26 ++++++++++----------------
 3 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/alloc.c b/alloc.c
index 377e80f5dd..c1065551c0 100644
--- a/alloc.c
+++ b/alloc.c
@@ -36,19 +36,24 @@ struct alloc_state {
 	int slab_nr, slab_alloc;
 };
 
-struct alloc_state *allocate_alloc_state(void)
+struct alloc_state *alloc_state_alloc(void)
 {
 	return xcalloc(1, sizeof(struct alloc_state));
 }
 
-void clear_alloc_state(struct alloc_state *s)
+void alloc_state_free_and_null(struct alloc_state **s_)
 {
+	struct alloc_state *s = *s_;
+
+	if (!s_ || !*s_) return;
+
 	while (s->slab_nr > 0) {
 		s->slab_nr--;
 		free(s->slabs[s->slab_nr]);
 	}
 
 	FREE_AND_NULL(s->slabs);
+	FREE_AND_NULL(*s_);
 }
 
 static inline void *alloc_node(struct alloc_state *s, size_t node_size)
diff --git a/alloc.h b/alloc.h
index 3f4a0ad310..87a47a9709 100644
--- a/alloc.h
+++ b/alloc.h
@@ -14,7 +14,7 @@ void *alloc_commit_node(struct repository *r);
 void *alloc_tag_node(struct repository *r);
 void *alloc_object_node(struct repository *r);
 
-struct alloc_state *allocate_alloc_state(void);
-void clear_alloc_state(struct alloc_state *s);
+struct alloc_state *alloc_state_alloc(void);
+void alloc_state_free_and_null(struct alloc_state **s_);
 
 #endif
diff --git a/object.c b/object.c
index c1553ee433..986114a6db 100644
--- a/object.c
+++ b/object.c
@@ -517,12 +517,11 @@ struct parsed_object_pool *parsed_object_pool_new(struct repository *repo)
 	memset(o, 0, sizeof(*o));
 
 	o->repo = repo;
-	o->blob_state = allocate_alloc_state();
-	o->tree_state = allocate_alloc_state();
-	o->commit_state = allocate_alloc_state();
-	o->tag_state = allocate_alloc_state();
-	o->object_state = allocate_alloc_state();
-
+	o->blob_state = alloc_state_alloc();
+	o->tree_state = alloc_state_alloc();
+	o->commit_state = alloc_state_alloc();
+	o->tag_state = alloc_state_alloc();
+	o->object_state = alloc_state_alloc();
 	o->is_shallow = -1;
 	CALLOC_ARRAY(o->shallow_stat, 1);
 
@@ -573,16 +572,11 @@ void parsed_object_pool_clear(struct parsed_object_pool *o)
 	o->buffer_slab = NULL;
 
 	parsed_object_pool_reset_commit_grafts(o);
-	clear_alloc_state(o->blob_state);
-	clear_alloc_state(o->tree_state);
-	clear_alloc_state(o->commit_state);
-	clear_alloc_state(o->tag_state);
-	clear_alloc_state(o->object_state);
+	alloc_state_free_and_null(&o->blob_state);
+	alloc_state_free_and_null(&o->tree_state);
+	alloc_state_free_and_null(&o->commit_state);
+	alloc_state_free_and_null(&o->tag_state);
+	alloc_state_free_and_null(&o->object_state);
 	stat_validity_clear(o->shallow_stat);
-	FREE_AND_NULL(o->blob_state);
-	FREE_AND_NULL(o->tree_state);
-	FREE_AND_NULL(o->commit_state);
-	FREE_AND_NULL(o->tag_state);
-	FREE_AND_NULL(o->object_state);
 	FREE_AND_NULL(o->shallow_stat);
 }

base-commit: f814da676ae46aac5be0a98b99373a76dee6cedb
-- 
gitgitgadget
