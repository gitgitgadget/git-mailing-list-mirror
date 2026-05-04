Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A853E3C4B
	for <git@vger.kernel.org>; Mon,  4 May 2026 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777916658; cv=none; b=W5HSLHOxU1xFiDPJan69nBS6l4an+mVSHAyrXVGfOrFQdD5ehowjXOnNSdOPjVHhLYilKgo5SOf0yMJAXyI+W8kQk+BeDGRIkH38OZdpXqr5GoiepugS6QJ6ZdvOUBPppSjSs8ZonuCnNON/zld5/Esrgc9HweSQCgNYoh9CcPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777916658; c=relaxed/simple;
	bh=TbIrlzJjgXVMlOZxss5mCpB2iHtkFVz/+miIiYS0o9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rAAlYLpDLU5IyU9IL4ziKASslASy8uwMVEno1z86COROs9iC4kqTPiInvOl3CNMFvBvo4FAOFVSZmuqVs0raAEKUp+3e7NI2IcBSpoay7eDDycoVy4axYmINnsnWTB3mkU83Kn0gdLfUDEGRAD7ZJvyTMcn+y8lwVLVotoJTMzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUOzBLXa; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUOzBLXa"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488d2079582so47080365e9.2
        for <git@vger.kernel.org>; Mon, 04 May 2026 10:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777916656; x=1778521456; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+LeRUARsCUVGeOSHInEicMUg+JEZeWMyLkeZ4i3ZkI=;
        b=JUOzBLXaLHB+qdDmZvNNy3YPeLWnBtZ8uZBr32uncstKvWYL6wo8Y2t8HlGspkFarL
         h2ZPeZTNpDjZ35ttQnti/qsWBgM9HwFTWHV2gFqtuElq9i/b10IZhSoGAKhrQGlK4bp2
         s5s3ddD2ojetrIfn6nfUWOIzFHWEu3qrWOJFTOKkKL7NfqkMYAEB/icKo73YO9Aagw8M
         IYMZVujfX7397ulTpAEF7cgcxA0EMqLelyeDNlWcxUrqeS3wOPmGcC4OvdklQSOytIan
         e7q/6asN98rSIUaQBm1tCZ4G5XmNKLnrWF082RqqV1SPxQl+W92R9UiMHLGz8qcm8z3h
         rrcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777916656; x=1778521456;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9+LeRUARsCUVGeOSHInEicMUg+JEZeWMyLkeZ4i3ZkI=;
        b=WuLvWT/c8Hp5GZaJ3V0yBdJTiNrgEWGPsfpSbqMViFWfubicRkI3KDxFRY8NbBgCyB
         f6SBDCBhfKXyF4KGzc1y29pEIaLPo8sNkfOOTDpo3kpEz1QnhXgPnQV0WV+3TF/p+q94
         J+nBv2K3G8ZysY2EdX6etNd7xKETk6CUTTpDh+OZYBD3pV0SJya21jbhpc6lmMdTS0PB
         IKYsta6l2BEv2C9O1iEiUnQ0D2H1lqea4728tzcw/WSnTahFGAd+7Mv39q6TPeWH8KRN
         3aLb07O6Pq/lXVWeg0rc71htCvcGVfz+Yt3Jmsm3MkgQmkNJuMjSW9YuGrh8Rj2VqibK
         fPYg==
X-Gm-Message-State: AOJu0Yw7+FJpP+YKBKz0ahqj7okAsRR2Mrka+hpYAfCUzO+ZoUddVDeU
	zKFIjFoIj+U1Cx27FwHdWMw0qjwwEvnv1V0xgWlLUHCIQIpr8uy5Y/lY
X-Gm-Gg: AeBDieu8/NqPEsjfsRjw2iQz0XSSht9BnOOPyEx2br/8yneIk/JoxZmRvs8/HBA3X7l
	4tl3CGaobP09VIFikEn5qoIuALbxHVaDB0td4epMVjGpjfh/THrJNvEQna48Bz3S/d87bzLv84O
	wubVr/Wi11JLOn8XwAyU1s9opczFTg28gH7jJk7pkmUfR0tQjv1P3vLUSxB48xppAboPgUasxRx
	JFXDYoEjMJRjLIm9F1W9uUH1STuCM7GLGWzdsfP7FUto7/AfKokgPQXfPJxi+i93t34wsFQBWLm
	h5QrDZjTg8/4RO7Y9PhvImgBmICAzEQnbiC/4CeNKOykwS6hzZ7m/WWm2IWBClvaTnbt29uSJyt
	PzeOgskR2rghb/Jo16DV2RDVn9b06ZIlszUnzwz0V4xPn7ZqExeVRM9lA7WtxdqzuQbsdpzokwW
	h/ljQFb21z8RDUIMaD7BaDnwsSxgYrqhQAwbOI/qNkKJXfrI52/kw=
X-Received: by 2002:a05:600c:c058:b0:48a:58ae:992f with SMTP id 5b1f17b1804b1-48a9865f831mr134081405e9.16.1777916655458;
        Mon, 04 May 2026 10:44:15 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1f8b:93fc:106a:20a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb75fc1sm299297675e9.7.2026.05.04.10.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 10:44:14 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 04 May 2026 19:44:07 +0200
Subject: [PATCH v4 3/9] refs: extract out reflog config to generic layer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-refs-move-to-generic-layer-v4-3-936ac2f0b1a3@gmail.com>
References: <20260504-refs-move-to-generic-layer-v4-0-936ac2f0b1a3@gmail.com>
In-Reply-To: <20260504-refs-move-to-generic-layer-v4-0-936ac2f0b1a3@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, toon@iotcl.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2678; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=TbIrlzJjgXVMlOZxss5mCpB2iHtkFVz/+miIiYS0o9M=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGn42ulQBeyUDtP4OmjuGGUl7aK4kix6+r+yZ
 dw2wQu9ASt/b4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp+NrpAAoJED7VnySO
 Rox/zGwL/jLflp6yJhZS8TEO5SHVQspxkzdluEY7G+qmYwW8V7cO5qgYpgO5mzmnVHJfCf2nm0P
 3OBehJWKAMc+L+gujXSEA2wJDNM0acJx2nG8kL1o6yNd4NVFSxUFfc9t2fnfoSbTQNiGo07GU6d
 ABWaI8g2j8P6+vIT3PSp4RxU6Sr/ej6mIQqM1D2R2BPUWDUjeV5bFToLQliPWKccbxs7mhFIAAX
 pmJvI4aODk4zOR0NFsqprOdDYYeGz6XGIZs4Xam4YHJk+pXTbmvKqmQ3NcsQOcxgcdxI2MOAybt
 3mclid3hUMFYgQLIR8kSwO7UOLztgkKKOXPAgO2Rs/iMvFRjliizKE9Z2R9jLv0Gceo4Xx50pBA
 I/lq7B955KW1I+T71FMaZvPRknz9ZJ3wAaL4GHw2UgZlNRtxnHOPnmvLr3rLovfOFN2sTcMJwRP
 5y8Ueu5yT4v/YXzU/3OuK9MOv1Y62yUWIpfOzxp47VK/BtJ8+IMjtaaQZURnkr2S/LpLnA/qPN6
 7o=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The reference backends need to know when to create reflog entries, this
is dictated by the 'core.logallrefupdates' config. Instead of relying on
the backends to call `repo_settings_get_log_all_ref_updates()` to obtain
this config value, let's do this in the generic layer and pass down the
value to the backends.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                  | 1 +
 refs/files-backend.c    | 2 +-
 refs/refs-internal.h    | 6 ++++++
 refs/reftable-backend.c | 2 +-
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 8992dd6ae8..6b506aeea3 100644
--- a/refs.c
+++ b/refs.c
@@ -2297,6 +2297,7 @@ static struct ref_store *ref_store_init(struct repository *repo,
 	struct ref_store *refs;
 	struct ref_store_init_options opts = {
 		.access_flags = flags,
+		.log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo),
 	};
 
 	be = find_ref_storage_backend(format);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 72afe62cee..4b2faf4777 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -125,7 +125,7 @@ static struct ref_store *files_ref_store_init(struct repository *repo,
 	refs->packed_ref_store =
 		packed_ref_store_init(repo, NULL, refs->gitcommondir, opts);
 	refs->store_flags = opts->access_flags;
-	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
+	refs->log_all_ref_updates = opts->log_all_ref_updates;
 
 	repo_config_get_bool(repo, "core.prefersymlinkrefs", &refs->prefer_symlink_refs);
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index f49b3807bf..d103387ebf 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -392,6 +392,12 @@ struct ref_store;
 struct ref_store_init_options {
 	/* The kind of operations that the ref_store is allowed to perform. */
 	unsigned int access_flags;
+
+	/*
+	 * Denotes under what conditions reflogs should be created when updating
+	 * references.
+	 */
+	enum log_refs_config log_all_ref_updates;
 };
 
 /*
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index ad4ee2627c..93374d25c2 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -386,7 +386,7 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 
 	base_ref_store_init(&refs->base, repo, refdir.buf, &refs_be_reftable);
 	strmap_init(&refs->worktree_backends);
-	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
+	refs->log_all_ref_updates = opts->log_all_ref_updates;
 	refs->store_flags = opts->access_flags;
 
 	switch (repo->hash_algo->format_id) {

-- 
2.53.GIT

