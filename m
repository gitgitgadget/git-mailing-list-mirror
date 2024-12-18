Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6499B13B58F
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 16:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734540525; cv=none; b=bcIGZSU2mN4cFzET2K8Gr7vS21loxsIGFCPor/2MNW05PNiATFUHKmO1VKuQWLwQ2Q88GFPYcQjj64SL053T2ofKjKuZl3GgNRh0E1tPIm6Tn1u5lrvW1IOx8fxdGrUkZcHDAyUaagWvqGpz9QcoPGnnkvzV0i6+SQQctq+KdaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734540525; c=relaxed/simple;
	bh=6/MQQTXk6V3DahMPeAdAYFkLhIvvt1CjyLjhC60jvKo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=H4eEUMMcnvbmsInvKKYoeRL35fUHMfhuqrOjPstPlVmTq1D9yymvl7RB1Ezo3NxbE3grEycVxE5OiJMczPM4Ac9m97bq5/mJpRbgGqh3vyBc+9JwO6KLQbUYjE+MXAhkw97Ctl3flQvZuvSwniz/02O/4HsNRdEpwhUKOzbWsNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuUe2pM2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuUe2pM2"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-436249df846so46892555e9.3
        for <git@vger.kernel.org>; Wed, 18 Dec 2024 08:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734540520; x=1735145320; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96Nlrm1vdwBC3OCsenaMp9iSi4S1c4xrxkVgS664Bt8=;
        b=HuUe2pM2UF/h0STIhhSb6V8iBYczddBNBFdf/YrvXqlvPzGIZVrI0A8VLm2DU1xoy6
         M1LkT+HllRSKOSjeRvuGCVkpyRewMcvrqACUTFwsPiHxfdJ3lBcpFiiarxWsCrpXNE+O
         dLdS/zDC7gvLXB5h5EgxOzMFqjhqBznTR+ohCP8VGcqs3XO9p3qfpMXzz4TMPB7YloxM
         36HlJiiZqFmDFw1ICO+flTP94+zvSudjQGnXfLlBvGPU+1jUtxoHE1kbUCWBPuSGwN5/
         IkOr4Df33keoN1Ai1bkBnB8BPr/IhORuqnhBDivY8BifbIiVIjuZlCM5Y5VK0CL8cEUN
         cqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734540520; x=1735145320;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96Nlrm1vdwBC3OCsenaMp9iSi4S1c4xrxkVgS664Bt8=;
        b=T2Sz18FQ0lMd5IlCRmeCnuKh9k653UyeCeDjJlLKikZVb95Xd7/nEvBI6ucB7GHLWo
         lkefHkyK9p7XkefeTk71Ijir7hYC+gwy0cqouowXb5nogRbng6/A5exG1tsiBviIEXIL
         NXnCKohn/1sCxkJAihhq73h7Gw9alTbApxqxDMFT6erdxPPBEuIaeGvWCnuKavahb11H
         DdAuNliYAMLPXkAhCYZl+9HiLK+TqCa2UPJrXQX/KudYGaYhfqCIkkomkypa3PGAV1FH
         o+7yxjr6jqMSBIEsww97lME+2/hTSM0cOv2rzubAOyoaV2naAMcLUFAz7McejBNnhNZj
         ivPw==
X-Gm-Message-State: AOJu0YzcU44eXsux7YNBdJli5qEDyh1ItBTEE8IoTcwQNWpJj3b2Qr+M
	HSNHWrlOmshiygZfuEPhaHIPPXWfEp4fHdfwV/Yi81JmeuvfYLXrEEHIyg==
X-Gm-Gg: ASbGncvGIH1+LUERdlEA+wgs+XOwP7etlxruHkTfqQkKuJNpQZWhDId9CnxHFUsAjhH
	rnF0wxM78XIr/dC13KVZWo02PPKh2lXEO2tSLPin/Bj+/B8J/Vk2Yf+22CEepPEnn8hH9jp0M0B
	q+nCmX3IGbcrt+LHZ/hdErf1AC1NqAf+yuYfRNzvrBL581+4mJ+S3d3Iacr9Snm+OoSaVmoQwza
	/WPjeTKHGXG5mufrpOELWDHdPuxTLzi5VB7y/DoMMVy1CYzaron6FsfSQ==
X-Google-Smtp-Source: AGHT+IHUQIk3/V3AW0tJfxOt8Ljq9cyCBVLUDueWLTGkBGkmy5jBSvMY5vxfdp0Ah4nPIpbqEP4gxg==
X-Received: by 2002:a05:600c:154c:b0:434:9f81:76d5 with SMTP id 5b1f17b1804b1-436553f321cmr28372305e9.22.1734540513994;
        Wed, 18 Dec 2024 08:48:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b19217sm25191215e9.33.2024.12.18.08.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 08:48:33 -0800 (PST)
Message-Id: <pull.1390.v11.git.git.1734540512582.gitgitgadget@gmail.com>
In-Reply-To: <pull.1390.v10.git.git.1734485187081.gitgitgadget@gmail.com>
References: <pull.1390.v10.git.git.1734485187081.gitgitgadget@gmail.com>
From: "AreaZR via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Dec 2024 16:48:32 +0000
Subject: [PATCH v11] git: use calloc instead of malloc + memset where possible
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
Cc: AreaZR <gfunni234@gmail.com>,
    Seija Kijin <doremylover123@gmail.com>

From: Seija Kijin <doremylover123@gmail.com>

Avoid calling malloc + memset by calling calloc.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    git: use calloc instead of malloc + memset where possible
    
    Avoid calling malloc + memset by calling calloc. cc: Jeff Hostetler
    git@jeffhostetler.com cc: Ævar Arnfjörð Bjarmason avarab@gmail.com cc:
    Bagas Sanjaya bagasdotme@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1390%2FAreaZR%2Fcalloc-v11
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1390/AreaZR/calloc-v11
Pull-Request: https://github.com/git/git/pull/1390

Range-diff vs v10:

 1:  d7b7959be0a ! 1:  cd18ee951cc git: use calloc instead of malloc + memset where possible
     @@ Commit message
      
          Avoid calling malloc + memset by calling calloc.
      
     -    Signed-off-by: Seija <doremylover123@gmail.com>
     +    Signed-off-by: Seija Kijin <doremylover123@gmail.com>
      
       ## remote.c ##
      @@ remote.c: void apply_push_cas(struct push_cas_option *cas,


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

base-commit: d882f382b3d939d90cfa58d17b17802338f05d66
-- 
gitgitgadget
