Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DE416DEBD
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 21:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730409554; cv=none; b=kxOfu7aER/hfPxizc7Cm/DgCbkS4544l4xE5qvRa48CH6Sx/Gx4IbCTCl2BVEDK+8evyPCsgEyimB2Wq7pO//7HgOY47sbdEu9IRMcKI/Y2ZwdH/BcnnCejKVd759dLhmou8QuKxEEuk6ONGLPgtG8kON+HWhKVT3gcTlMqz5Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730409554; c=relaxed/simple;
	bh=E6rKEQze5mF1WSxaCBmVIO4drG+1tOHkqA+eUB508C0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZMSu1ZSze/afV+AJa5ZnL2iczi9pwqbiUVrPGzItDs/uz3KmzPzZnywdBtWUKaL5PHUlOIfWr27mNUJ0xykeYyekatAyX/wPAQ+4ijAREdK92MIBbCLboa/KEZQW0AZ1RA0VdJb0+6RjeE332gU6E1WFKnHiqL9UzphjsFufOgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NgG+GIvG; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NgG+GIvG"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e28fea2adb6so2130490276.3
        for <git@vger.kernel.org>; Thu, 31 Oct 2024 14:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730409547; x=1731014347; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pXPybpYrTnqSLF07PFF1gDnMoaNoPeNXzoFWo1CYy5Q=;
        b=NgG+GIvG5xFzxb4FCVbI3DdjsEWzcvLcP86YLc3VErhj6IJj6NK69ouhwEPQ7zYYvF
         9s392bjAuM2U/Hb8CBVqGxFfuZzYuIL+C8aIiuNk9Vpmcu2ct+PGgGP+68p2aMhuq8CS
         dD+UK0fiF97d2PY4WfvvBlMzUQk0LgYPCZF/l5Q1CkLs4MDSSApmrKAlIShLIHKZ6/sp
         cxjNbobCg3+A9TpTRY0g6/TeWPBN5tMqWF9vogSXgwavGo5ONCJbA6u0GVfLDFvyiNIs
         RKN6JCE5f2/HRZEJaY1at7Vkioi3YCjSu0+CBliRZBPj1Qys6eZyYG9/gdPdjeKtBocB
         K9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730409547; x=1731014347;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pXPybpYrTnqSLF07PFF1gDnMoaNoPeNXzoFWo1CYy5Q=;
        b=Fsl5hLwq9deehDVQtYwKtQ713FhtUWzmIqtJkAnrwjTMXD1vN+AeTccX96/bjYgPKr
         RM2tBfT/H1uQtSfGBEsvX8bomkCrY8oSL2soWFZZKdMVNLqZnD9KFa01HGsiB+I4TCqW
         HfhHvLYFAqzsP1G7/6rgJrl+ZFP6fAI4uJ5OOfkDQqTiOMU96ctdRJQll11gElsuvVK5
         NutFh73rHejqCr6Eypqq9abPPvsO5aJCMBmzoyBY5bZoKw5HxsjIYIHSohEg4wgjKqYY
         ZWFoTLgrK931+hyQpxjbUwfd8BzqNbwhEuX/baPy4vm02VQbDPivneamziaaBp5g3xuj
         La+w==
X-Gm-Message-State: AOJu0YyFm8FQkKYZXlVBsGZ8pmmKGPl+a5X8xjvE2tQguw+Kwlrk4uvO
	Uc1mWyAk92jR7+m+jDItwNXGm2FcNsn6H2G07p756Zw+eFCafO1zHw695no4jChI7NJ0Tc68Vkb
	V+VeBr9Ptva5hk1LybVsb68zd9XBx92+xVtSVeN4qnTAcQsWz2ARIlwvL89677m/r11xy71ibtY
	lvgSJ/ow+M2kIbVTvyZn9LyObg2K408b9zpnYcF3z892JUWoeojVMM+Ao2bcND4hydZQ==
X-Google-Smtp-Source: AGHT+IGGIWXM/TDCvaZMU4GN0LBdKjgPZH6JtO8fRVH7Fz/BwQ72SOSDbobE87mmi/DxDQCXeXr97Djc5b4cfaI880iY
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:1f26:d3e7:169a:dbab])
 (user=jonathantanmy job=sendgmr) by 2002:a25:abe9:0:b0:e30:b98d:a33d with
 SMTP id 3f1490d57ef6-e30b98da4f0mr32469276.5.1730409546873; Thu, 31 Oct 2024
 14:19:06 -0700 (PDT)
Date: Thu, 31 Oct 2024 14:19:00 -0700
In-Reply-To: <cover.1730409376.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1730235646.git.jonathantanmy@google.com> <cover.1730409376.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <34e87b83884e27e421a64cb4a3594b1dacc2a391.1730409376.git.jonathantanmy@google.com>
Subject: [PATCH v2 1/2] Revert "fetch-pack: add a deref_without_lazy_fetch_extended()"
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>, steadmon@google.com, me@ttaylorr.com, 
	hanxin.hx@bytedance.com
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
2.47.0.163.g1226f6d8fa-goog

