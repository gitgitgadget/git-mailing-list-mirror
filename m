Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EEB1E7C27
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 19:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730834666; cv=none; b=Tmv1bcjjIyhftmdpj94C69LJ8D7hWwvbfG19Dj11sa0L1dcWidJCszBNSBmVADk49G6fqfEaAJrYBsm5aMaYqCnCqOTM7FmZ98Md3b2vbXYefBGboxMgQsJuVKfY5izw9S9hu61BV9UWMgp3kXLdaVYe12d6KHLp933XSgNScnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730834666; c=relaxed/simple;
	bh=TT0E0grESMdAvYeOWLZmMAHXiZduPhp9HsYtXQnbBTs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sQs1a+SihDISXYC28BzfFoZyE71mWYPv/nEo91DOr783KXfKY9uleqSYqYaPJkRD5WnTPJ7jwOAWD62s70T9+FZK5ppV5AvBSQbGYaDorVsojfGFdg93LQl1R3bM8S10Z6w2eCalBB16eKQ1jTHdWogFjgV1bPy5fYhX+SOUD+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oIWPzKzJ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oIWPzKzJ"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e376aa4586so110799277b3.1
        for <git@vger.kernel.org>; Tue, 05 Nov 2024 11:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730834664; x=1731439464; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AOWADm0GAx8KxjldMDZJgWwnYk5ilMVzSY537NVZiuA=;
        b=oIWPzKzJstDy9V0Zqh1BQOPr+9WsewTYp5CJqs5r1BsdnICOY3mrKwTyIHADxdtpHL
         V5lPOYWU9f0Ipv2rGGYmSfSHYzIbyFLfomYg+J+1tb7D60CaVMS9m3bfcRHqhYlOu2jY
         KV7gpfEvx4yazPUcp0v1yGX8gjco9O6y7gmqaqjqguDYPdIUC7cP89ATlhYA9ocWDDFq
         xKv6kDHAYBbHLEFQ7fPjmPBvoIERB8CY6w5WUx5RupK3xLe1zCqZ7ESWXOgXxZ7xoNaE
         p80Xyf/9XQYM7sWfgqY2+d4ZU2qUPFsNeFlgA7g/ShbSvoVDSoFYzeLS4gM938yU2BVN
         ZEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730834664; x=1731439464;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AOWADm0GAx8KxjldMDZJgWwnYk5ilMVzSY537NVZiuA=;
        b=Nb1lPMDSHr+twueNny73y8rVRk/GPLU4sCFwND1UFBXYiBkk6sY17OT6Ty0+gWmIPu
         FofFOexEA7i0AtTJ72vW1Ejp4gF8t/Z6hBQCp72+PsI/XEOSm2ncr+x4O/8mWDyyWWdz
         qgvmU5ej2mbIqxAqWjzMbQOFNZeKAYeCeZc+eWwAMO9DupX4ltxSZFI8P7nbW7vvDRCv
         +5yO/dF0HG9LRaSVi6Vs5g9IQasyVMOWGHDvQ5k5cizr5Fgmp2VTBrU69hIBJrwLD2Y8
         Gu1YnfXhC6ZKOiEq7rpoxcE6N9f4A8zNBTYKtO2EO30lHjARcvuHnphoPpwr4AHCYfqh
         HitQ==
X-Gm-Message-State: AOJu0YwSG1lVokjCa7yj7e2kkKFiz7nv0qP3UJohvusb8gsV2QPX6Hx8
	NUC3iBiFje28IDuZDX85R6MvSgs0oCFWxFPMaMdKZsOHMD6r41Hd4FNspvEZ8Iu4IW2XFAsObr8
	F882bksjkJwyXXJLoEdhBs05LvlIg7dUzj86d6kl3i7mOwqRaGE1l139T5RHUiXloakqIXAegXq
	YZGN0N1WdF+8M5tLphNYQfNc4Vp9r1LZB3fUAhW9jEcc3rlKGqDU/PG9cSnPVhnElE4w==
X-Google-Smtp-Source: AGHT+IFL3Lcf0gBuctALOr6YTBwEDxaOXVxos7jGx1nwOcInpSS3ppA5W/6fiE/KllOLauIfCaCMxyjNLZxggAzZlkUp
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:af5d:b903:295d:2c17])
 (user=jonathantanmy job=sendgmr) by 2002:a05:690c:6f06:b0:6e3:2f0b:b595 with
 SMTP id 00721157ae682-6ea3b968a7bmr3092307b3.5.1730834663841; Tue, 05 Nov
 2024 11:24:23 -0800 (PST)
Date: Tue,  5 Nov 2024 11:24:18 -0800
In-Reply-To: <cover.1730833754.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1730235646.git.jonathantanmy@google.com> <cover.1730833754.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <34e87b83884e27e421a64cb4a3594b1dacc2a391.1730833754.git.jonathantanmy@google.com>
Subject: [PATCH v3 1/2] Revert "fetch-pack: add a deref_without_lazy_fetch_extended()"
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

This reverts commit a6e65fb39caf18259c660c1c7910d5bf80bc15cb.

This revert simplifies the next patch in this patch set.

The commit message of that commit mentions that the new function "will
be used for the bundle-uri client in a subsequent commit", but it seems
that eventually it wasn't used.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index f752da93a8..6728a0d2f5 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -122,12 +122,11 @@ static void for_each_cached_alternate(struct fetch_negotiator *negotiator,
 		cb(negotiator, cache.items[i]);
 }
 
-static struct commit *deref_without_lazy_fetch_extended(const struct object_id *oid,
-							int mark_tags_complete,
-							enum object_type *type,
-							unsigned int oi_flags)
+static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
+					       int mark_tags_complete)
 {
-	struct object_info info = { .typep = type };
+	enum object_type type;
+	struct object_info info = { .typep = &type };
 	struct commit *commit;
 
 	commit = lookup_commit_in_graph(the_repository, oid);
@@ -136,9 +135,9 @@ static struct commit *deref_without_lazy_fetch_extended(const struct object_id *
 
 	while (1) {
 		if (oid_object_info_extended(the_repository, oid, &info,
-					     oi_flags))
+					     OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK))
 			return NULL;
-		if (*type == OBJ_TAG) {
+		if (type == OBJ_TAG) {
 			struct tag *tag = (struct tag *)
 				parse_object(the_repository, oid);
 
@@ -152,7 +151,7 @@ static struct commit *deref_without_lazy_fetch_extended(const struct object_id *
 		}
 	}
 
-	if (*type == OBJ_COMMIT) {
+	if (type == OBJ_COMMIT) {
 		struct commit *commit = lookup_commit(the_repository, oid);
 		if (!commit || repo_parse_commit(the_repository, commit))
 			return NULL;
@@ -162,16 +161,6 @@ static struct commit *deref_without_lazy_fetch_extended(const struct object_id *
 	return NULL;
 }
 
-
-static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
-					       int mark_tags_complete)
-{
-	enum object_type type;
-	unsigned flags = OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK;
-	return deref_without_lazy_fetch_extended(oid, mark_tags_complete,
-						 &type, flags);
-}
-
 static int rev_list_insert_ref(struct fetch_negotiator *negotiator,
 			       const struct object_id *oid)
 {
-- 
2.47.0.277.g8800431eea-goog

