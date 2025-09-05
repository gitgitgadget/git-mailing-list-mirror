Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0A82848B4
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 18:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098313; cv=none; b=ecs6E1+iOkVtNGu0NEggNNcO/ZIP+H3MFCgu4gLtkZdnZIYhXnXFmOJjIVCMIC5qZWssUF2twSj1uGeXHdVyR+UFciIGewfBk76m5UiTAEj924MtEHzq7Xje0ARBeLKQURw/pP6wsgkGHpaCU8u4bmz3k6q9yyfCcnuS9tweRBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098313; c=relaxed/simple;
	bh=zXWJlWCHxYGco+Z0oPY+qgnRaGN+wZGrUTTlZKrx84A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=E5ZAP7T+pMrgevpVy2C9JgxxuXNaOIY9d31Cj3O9GYl4NmPYwTRr7SGOWsehtzkdAbMuzAjIGpbYwCgQYBjW6OgvX9SGO8i9pEQwiOG6/Nn41ddIOp84b48qEjqHUNeT+F/tou/jy19eDO89/8sEwk5pXcsK7MufNpTd4aZUM6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFLgtvPw; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFLgtvPw"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4c9a6d3fc7so1405961a12.3
        for <git@vger.kernel.org>; Fri, 05 Sep 2025 11:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757098310; x=1757703110; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JANTcZkcAQL+G2NPdUPZROfSUbffVbNfVkud++CqltY=;
        b=ZFLgtvPwnRKWgrojnbdxTND4fN7+pOh1If7rTQsKZIUcE5lOuJjgt+nXYSb8LX+7yt
         7ZqDO9fCMBXpWEqVNnIqYOJFUi5Zn3KVOOPdl+REmKtwUu8rYRxZfUrPIbTZls8cYuT0
         9m3/OB5C5Y2XezJjF3qKY+B1qUBGU6HH4FFdcPfXD+KHGJ8Dzjn0gS3jQXSv3XBOruZ8
         YxNp85hqJXiMUp0vBdWRRCpTjBAQ2yrQRfwtr6pRXJoWP1Z6w45QjsPXjIUqlfLKwz2Q
         NZeLVGEGDVBo0E2q+nwKEYdrsdjdO0Qk0E92jNW/2hZ+woFx8H6sCl5XpoC5x6QEp8b+
         0jHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757098310; x=1757703110;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JANTcZkcAQL+G2NPdUPZROfSUbffVbNfVkud++CqltY=;
        b=PEYvIx7z0qz/f0gdhsJazeJl+fWiLqK6olS+q58wTJf+e0wp5Y6oootKrk8UKqOtb3
         ZtaXtspq5O1swXnD8iRBTb9XLb60xYIxY8uBY0DbHEQzMJrcgDXNdgA/3VdWIkIk097J
         7uZAn/gNDc4ExMeEy2+Tz4TJ+Xi5E273OEjy2Jrlhm5E+9A2ugztxcxZoUQj/MgFmaLh
         wpr/rIB2ewHrewwZG5LoAg+GCg6AkNiS6ZdCJ9Vqsqs17x/tF4BftAxak4f2fFrlrLbR
         IuAU6uYms2efxDk1jtb39DSAjIYrzOKp3kANtdKq6M9YLXPIk0necBAE4B0C+QDdPbCn
         40Eg==
X-Gm-Message-State: AOJu0YzCuNPoA87RXuGiXNl8r/DC44GAsyJQmwHtX5f8FE4W+PxN2sGq
	voEkYNOXqTRqT1eEH5/Ufm/luMGaN87Ndst4OUsvBUlqJ8lzNLOBLnSncsNdPg==
X-Gm-Gg: ASbGncv/Nv40fVuBEm7bidck3YFghh06vJSynPJt377TawOhHhjn2ChGpBAfgNVhmno
	w7U8NibloiIoXDaUEWSBRmy//5uGA8ck2NhLs2/RLlSIbsi76gn2R+Yt3JaDoXWlf8pnnUX2c5o
	0FO5CWLsrHWkjL3TboLYJc45FHXae9BjwNGi2DuvYxuM9yc0t+TiNxGrW7VSIbFkzdAvGC/nIgM
	DhBjAY7n0FxqYPjBVDJ79Q56GkMMIH5URNLGx8wTQ2xV9dpIYUjjM/KX0tHIpgEG1SlH6EUEnkB
	M4S6ND7pU+5R08z9dLPStnsUtZPYqr41Z+9pyNKrdpg0/pyQMGUKuxqsPqAjQKYsS+1RkLuuAOn
	maExReA9tPIZx4R6YEaaz+2fifQ==
X-Google-Smtp-Source: AGHT+IG2Qdp9eVv0Ca+gHmxd5ioT4naaZ/GTSHvyAGN/N39w2518SQiVJizDOH8dJSMrIqBloYuWwg==
X-Received: by 2002:a17:903:3b84:b0:24e:742b:660a with SMTP id d9443c01a7336-24e742b6a4bmr28760695ad.32.1757098309967;
        Fri, 05 Sep 2025 11:51:49 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cbe170977sm53462475ad.42.2025.09.05.11.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 11:51:49 -0700 (PDT)
Message-Id: <pull.2040.v6.git.git.1757098308277.gitgitgadget@gmail.com>
In-Reply-To: <pull.2040.v5.git.git.1757007856062.gitgitgadget@gmail.com>
References: <pull.2040.v5.git.git.1757007856062.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?=E3=83=8E=E3=82=A6=E3=83=A9?= | Flare via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 05 Sep 2025 18:51:48 +0000
Subject: [PATCH v6] alloc: fix dangling pointer in alloc_state cleanup
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

As it is a moral equivalent of FREE_AND_NULL(), except that what it
frees has internal structure that needs to be cleaned, allow the
helper to be called twice in a row, by making a call with a pointer
to a pointer variable that already is NULLed.

While at it, rename allocate_alloc_state() and name the new
function alloc_state_free_and_null(), to follow more closely the
function naming convention specified in the CodingGuidelines
(namely, functions about S are named with S_ prefix and then
verb).

Signed-off-by: ノウラ | Flare <nouraellm@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
    alloc: fix dangling pointer in alloc_state cleanup
    
    cc: Torsten Bögershausen tboegi@web.de cc: Jeff King peff@peff.net

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2040%2Fnouraellm%2Ffix-dangling-pointer-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2040/nouraellm/fix-dangling-pointer-v6
Pull-Request: https://github.com/git/git/pull/2040

Range-diff vs v5:

 1:  d04b0258f5 ! 1:  5afd5b6a26 alloc: fix dangling pointer in alloc_state cleanup
     @@ Commit message
          in addition frees the structure, as well as NULLing the pointer
          that points at it and adjust existing callers.
      
     +    As it is a moral equivalent of FREE_AND_NULL(), except that what it
     +    frees has internal structure that needs to be cleaned, allow the
     +    helper to be called twice in a row, by making a call with a pointer
     +    to a pointer variable that already is NULLed.
     +
          While at it, rename allocate_alloc_state() and name the new
          function alloc_state_free_and_null(), to follow more closely the
          function naming convention specified in the CodingGuidelines
     @@ Commit message
          verb).
      
          Signed-off-by: ノウラ | Flare <nouraellm@gmail.com>
     +    Helped-by: Jeff King <peff@peff.net>
     +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## alloc.c ##
      @@ alloc.c: struct alloc_state {
     @@ alloc.c: struct alloc_state {
      +void alloc_state_free_and_null(struct alloc_state **s_)
       {
      +	struct alloc_state *s = *s_;
     ++
     ++	if (!s)
     ++	    return;
      +
       	while (s->slab_nr > 0) {
       		s->slab_nr--;


 alloc.c  | 10 ++++++++--
 alloc.h  |  4 ++--
 object.c | 26 ++++++++++----------------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/alloc.c b/alloc.c
index 377e80f5dd..7a0af6b4bb 100644
--- a/alloc.c
+++ b/alloc.c
@@ -36,19 +36,25 @@ struct alloc_state {
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
+	if (!s)
+	    return;
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
