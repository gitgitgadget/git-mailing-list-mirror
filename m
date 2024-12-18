Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C93E3596A
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 00:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734483517; cv=none; b=QbVMAfqHAeCVHD6VeKDQkMqOh3jpmAR4R1egOzrd/l6MCxe5cr5iFN877MED4RvZuOtaQKodWk24Ipdb00aEwHZz/O1A8U3ygz+Rvunretoftt1zQgKibpUVZz+0CztNpmqB4W7i3jZQx8fyPSPsd55yIqZXzr0gwtIHL5AsuIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734483517; c=relaxed/simple;
	bh=OlIlWoROWW2mTflWMAUr+/gJ+5ktBCTZD7ywGCIChRE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Bfi09S5e8HGye1mREMr5RB5PqUs9M9zWT68webvoWzJSZbWiEXEZHIFsEk6fP6Qp16nL7uXIEKFglmgjQ1NyuEJyt2UJkS8sd3QTAjKSB36PVIrgH4cJ56C3HJXpeJXs+KygEmHmdb/dX8El/Us00lsSJ/xPhJVFP/lXnp4k/OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzX8Yi9u; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzX8Yi9u"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-382610c7116so3055937f8f.0
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 16:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734483513; x=1735088313; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cj9u70SUX07gnTG+pOmYMNYmVaFdqPLlb79lstB9BnA=;
        b=SzX8Yi9uxSy9IjQpZxr6LVNfltIu//yaEEKpiwGCN5HsO4w50lohiIN6df8ZyJU48/
         PftDnp34w8LYziCDBf7ycHz5NONo+9qPjwMmWw7wlZ4rCBSEBz3KzXU+OFWI6FL+Xzc7
         h6Fg7pIVQbBUEL4JF60VKfzjen9g90hkYBuuVS2EbSwkGD5i7IOWMVyHeXOt6PREkL0y
         oexay4k1a8vLFeGJS9eQVDuf4EfEhLugwr+c4A96k6YaiU/1hn0QDHG85hnwO6GPNMf4
         6j9ppz6/rRfZ5ffhFoWjkqt8giGGDOmgCIvRXxQRXcudAC6LlFwgH72k2MNbNxX1UMmy
         i6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734483513; x=1735088313;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cj9u70SUX07gnTG+pOmYMNYmVaFdqPLlb79lstB9BnA=;
        b=asqsmNv9gjpxnhNzUIPLAwcUuJe0yjKjDff1RANmvIlR+W7yHMROIn2EHfMxgkXNGh
         pnXlqMR/wt5EX7ZmecvomrnfiR8y/8UytBRYjdHF787Eapbn/zVFZfxmw7hqVhBSfKAe
         xRgh5wMNsQ9IHxE3rMjUfSNrfcBJ7blVmTP3knw728ZJfgxHzZd9H69pk4dEV8cqnkWq
         5ihSuY7mT5n6OftQjspffKlTNaGw8LdQw0Yc8zNPhSRoiNsKr5MYnm6FiLctVB/+Ly7g
         PQSfI5jKDNrqJ9q23Xo5ZzsZXllj38uU2NT1JEdnShLbBmF1Y/aiKNWYbQDajAivCV9r
         rRnQ==
X-Gm-Message-State: AOJu0Yx2G4ZPxofk6RJb0cADtLtx+uORi8eH5UU4OBsOop0QuJA01Vng
	9In527jKC6w9DzjqgKplFSYUjQpQXF+qou4hdkKlwWdTfeYWpEPFXZ1ktQ==
X-Gm-Gg: ASbGnctK+rUgZ0VILokMjJO1eOx+b/Zsz5pUeZHMnrj563OE8J3Leimne1L7Gs6ze/B
	g+QVAsZPQpOtsExnEpB9P2MZI6tsTbFoOJxE1zvU9rSQ76NTJNfVyhg9XqLGCHLpYEVbxUCD+5s
	JD5iD6KfpjBkTDPF55zTUDC0xYC3jlu+dSkK785/CeE+uBcnsIaALHz9z5AjyWMangJaYWrkrt8
	xyRQUJCbusNImigdiSYS4RI3hS6FttU/O/pE8Hr4SBy7P1SJFHBDO3fYg==
X-Google-Smtp-Source: AGHT+IF2ggYqropfse9JweOT0AR3twgsfa14sYuwCIFpRpEZnVHWoRptaIyM/wrjXmVyHtEOSoBKxw==
X-Received: by 2002:a5d:5c11:0:b0:382:49f9:74bb with SMTP id ffacd0b85a97d-388e4d6384amr661346f8f.35.1734483512945;
        Tue, 17 Dec 2024 16:58:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656afc217sm3046075e9.8.2024.12.17.16.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 16:58:32 -0800 (PST)
Message-Id: <pull.1390.v9.git.git.1734483511642.gitgitgadget@gmail.com>
In-Reply-To: <pull.1390.v8.git.git.1734482895877.gitgitgadget@gmail.com>
References: <pull.1390.v8.git.git.1734482895877.gitgitgadget@gmail.com>
From: "AreaZR via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Dec 2024 00:58:31 +0000
Subject: [PATCH v9] git: use calloc instead of malloc where possible
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
Cc: "Jeff Hostetler [ ]" <git@jeffhostetler.com>,
    "=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason [ ]" <avarab@gmail.com>,
    "Bagas Sanjaya [ ]" <bagasdotme@gmail.com>,
    AreaZR <gfunni234@gmail.com>,
    Seija Kijin <doremylover123@gmail.com>

From: Seija Kijin <doremylover123@gmail.com>

Avoid having to calling malloc+memset by calling calloc.

Signed-off-by: Seija <doremylover123@gmail.com>
---
    git: use calloc instead of malloc where possible
    
    We can avoid having to call memset by calling calloc
    
    Signed-off-by: Seija doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1390%2FAreaZR%2Fcalloc-v9
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1390/AreaZR/calloc-v9
Pull-Request: https://github.com/git/git/pull/1390

Range-diff vs v8:

 1:  b78f068b3a3 ! 1:  35994dfb8af git: use calloc instead of malloc where possible
     @@ Metadata
       ## Commit message ##
          git: use calloc instead of malloc where possible
      
     -    We can avoid having to call memset by calling calloc.
     +    Avoid having to calling malloc+memset by calling calloc.
      
          Signed-off-by: Seija <doremylover123@gmail.com>
      


 remote.c    |  4 ++--
 submodule.c | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/remote.c b/remote.c
index 10104d11e3c..462ff105273 100644
--- a/remote.c
+++ b/remote.c
@@ -2854,9 +2854,9 @@ void apply_push_cas(struct push_cas_option *cas,
 
 struct remote_state *remote_state_new(void)
 {
-	struct remote_state *r = xmalloc(sizeof(*r));
+	struct remote_state *r;
 
-	memset(r, 0, sizeof(*r));
+	CALLOC_ARRAY(r, 1);
 
 	hashmap_init(&r->remotes_hash, remotes_hash_cmp, NULL, 0);
 	hashmap_init(&r->branches_hash, branches_hash_cmp, NULL, 0);
diff --git a/submodule.c b/submodule.c
index 7ec564854d0..7707c6f48f0 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1489,14 +1489,13 @@ struct fetch_task {
  */
 static const struct submodule *get_non_gitmodules_submodule(const char *path)
 {
-	struct submodule *ret = NULL;
+	struct submodule *ret;
 	const char *name = default_name_or_path(path);
 
 	if (!name)
 		return NULL;
 
-	ret = xmalloc(sizeof(*ret));
-	memset(ret, 0, sizeof(*ret));
+	CALLOC_ARRAY(ret, 1);
 	ret->path = name;
 	ret->name = name;
 
@@ -1536,8 +1535,9 @@ static struct fetch_task *fetch_task_create(struct submodule_parallel_fetch *spf
 					    const char *path,
 					    const struct object_id *treeish_name)
 {
-	struct fetch_task *task = xmalloc(sizeof(*task));
-	memset(task, 0, sizeof(*task));
+	struct fetch_task *task;
+
+	CALLOC_ARRAY(task, 1);
 
 	if (validate_submodule_path(path) < 0)
 		exit(128);

base-commit: 063bcebf0c917140ca0e705cbe0fdea127e90086
-- 
gitgitgadget
