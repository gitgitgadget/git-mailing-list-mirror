Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C09F259C98
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 23:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756941432; cv=none; b=PGXJdOYnoe11cja6CKGnjkWwlNWyxkCPbDpzTa+AXcenL5tZupnQma7F7E6ptAnuQz7sdcB5nZRFEXlCsDRO7WqYvMjKjiINjhofqEw5IqLhBZf383NEOLhI0hmuH5yeRedAfYQughgpXMNmwfHzni/nCHmWtAMMWwFwUF6rlbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756941432; c=relaxed/simple;
	bh=3bVVK3Umbe42KjtiM9GqHL3AZ5TPciymLVOoaMp/X3M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=q3bHpAPeQXzjyxyU0iC7r4whRvXpHITfB2S3WgpmsxxY2yDRBTSed1CxTAFSZAhCoey9t/LSWSVGotxYubxvhiW+IdjOcrL+bVCuAevsmPlcytKg9xSMRizMZ853sflVS9gXDetK220Vr+t8ZB4lSnrgIQOZehhhu+cWGpyg9k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfSXxNY1; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfSXxNY1"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4f9d61e7deso238525a12.2
        for <git@vger.kernel.org>; Wed, 03 Sep 2025 16:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756941429; x=1757546229; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKSE19dzwVBGUdeU+v3BoOUbv3mqBkERvWaR3UMdCBE=;
        b=PfSXxNY1k19uN+yMoGp4LyKd+sok6Vi4T63gMuge+lxboMQCwDaKekg7SasEGXy0Am
         WkOss9VKtaAbsuKW58B9QgE+GDl6dvFpKYEZNZgHhzehyKD/0gP7kz/QWKEJCrunxIgN
         m5ya3vqEfL6JjqoiIP+/Kp2Z1HKxj4TUmJc+4CHDVaaGBbqLM4Td0j1P088003N2xmSM
         OXIgoLdXiYqqlz2a/UMRofMaDJ9AyUgdRHhUoO5RgGA2JizS5UbQaFcpxkv7vdzynBwn
         NA60S2wXmfLipYLP6astos1FnFpAB7K/UZolWlkOb5UwfqgpY3f+OC6gL4kh3W4SQgNl
         2bEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756941429; x=1757546229;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKSE19dzwVBGUdeU+v3BoOUbv3mqBkERvWaR3UMdCBE=;
        b=lrSpB6Gyq9mAqJ4uxkNwphElj5VQWIfHZzYsyweYHJZWNsFI8Sup1l1HoyUCnYmPMD
         cm/18BQy3dU1YWuU+i0Tvim9mFtWU+vHPa2tmg5umsnh5sug9XVOtkEPHe+sUZrlPhLn
         2p/S1IhEoBdhUrRLFdoY6XESem85FzebM1uWjs6ld+CIND9ESgBFK4/kh0dQ5MlNmrWP
         k9Bc0OE7aZpXvpRFKAVkU3i7fl6UsUFZbKayPMEFPhoDCY+qRF6/+lHXX+3tNUe4tP4Y
         uzNYUoe7LjaScmJa2qzXYYj8ihomxiKitYPQk4D//Mk71YF5s6hl+WuBh1AaNbPx2ugV
         omxg==
X-Gm-Message-State: AOJu0YzZxYXbwjQa0h6sjhtzYVE9+TLFwGQMR0j0oiuXx7tZsQ70RGeC
	d0vGsrAQyjBnKqf2wDAX81aWJhucibPnREw7MOrfK0Zp0RwVF1QxPT1puQnz6Q==
X-Gm-Gg: ASbGncuyNzQDUbacScPPfCOuIevktmmMvSxWMgDeW2w2szozw6qzP9QP1axAP034sV8
	XkXLsjKxhIHareS5ZCv9Q5d29ycEFKu2XQn8g8W36m7ZoCnEXiBO36TZhaQ8GJEVXlcEF2gm4y5
	My74uOaSCIrh2giP5vv16P2tL0+FQZTPMz3y7xpiDGWb/qS+P+g6VSmKjRjVg6CoGFNjg3tG6E+
	HwDQmJ2/gD2OE0hkCdZ0XwlkKrCpuzJjBPO365lMBuXblevgY+5M8hkgphNrSgvr3bYcSSf7ZDD
	k9x0hqVEBrNpuPdU8bFolAmjWttHnQ1lY4pPZISIzAVwfTbUTpZ8i9V0tth2wpRyzn9gMvHMFIb
	fFdHmYO1/FuY7U/btyazwQH23x9C+3euHh8j7
X-Google-Smtp-Source: AGHT+IGSTu2h+OkevJlCqQL1LnOYfvO/ZfuQBToWm3H7oxC2KAGRjcaQk8FgYDyj4OEP3zh+Q6ES1Q==
X-Received: by 2002:a17:902:ce07:b0:24c:7b94:2f87 with SMTP id d9443c01a7336-24c7b943278mr76817385ad.14.1756941429305;
        Wed, 03 Sep 2025 16:17:09 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.228.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b2342b95bsm51226895ad.38.2025.09.03.16.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 16:17:08 -0700 (PDT)
Message-Id: <pull.2040.v4.git.git.1756941427825.gitgitgadget@gmail.com>
In-Reply-To: <pull.2040.v3.git.git.1756472406487.gitgitgadget@gmail.com>
References: <pull.2040.v3.git.git.1756472406487.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?=E3=83=8E=E3=82=A6=E3=83=A9?= | Flare via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 03 Sep 2025 23:17:07 +0000
Subject: [PATCH v4] alloc: fix dangling pointer in alloc_state cleanup
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
    
    cc: Torsten Bögershausen tboegi@web.de cc: Jeff King peff@peff.net

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2040%2Fnouraellm%2Ffix-dangling-pointer-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2040/nouraellm/fix-dangling-pointer-v4
Pull-Request: https://github.com/git/git/pull/2040

Range-diff vs v3:

 1:  c521b44adb ! 1:  82d228661d alloc: fix dangling pointer in alloc_state cleanup
     @@ alloc.c: struct alloc_state {
      -void clear_alloc_state(struct alloc_state *s)
      +void alloc_state_free_and_null(struct alloc_state **s_)
       {
     -+	struct alloc_state *s = *s_;
     ++	struct alloc_state *s;
      +
      +	if (!s_ || !*s_) return;
     ++
     ++	s = *s_;
      +
       	while (s->slab_nr > 0) {
       		s->slab_nr--;


 alloc.c  | 11 +++++++++--
 alloc.h  |  4 ++--
 object.c | 26 ++++++++++----------------
 3 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/alloc.c b/alloc.c
index 377e80f5dd..1483697ca8 100644
--- a/alloc.c
+++ b/alloc.c
@@ -36,19 +36,26 @@ struct alloc_state {
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
+	struct alloc_state *s;
+
+	if (!s_ || !*s_) return;
+
+	s = *s_;
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
