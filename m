Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C994820402B
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 21:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730236274; cv=none; b=YXY5kbfPAP9I8l/yvvFstZTDtjct8uiFy56SlDNf41MHETQ5ibESesIeHjficZ16Ec28+8w/ibcvM/SmMBHbq5loQbLoKSEW8rO24HawMK2X9zfUcsvovA5Ehvx09oQ9GN7/eHUEKVaUPdV7LZ0rFvcmeJYlnxy30/58EBkbaIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730236274; c=relaxed/simple;
	bh=u6nKfLCO9qJhl/eAo1nHY02uYQx8IyN/LhEu6tVy9MU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ONAcVOOpdfKDfwRV3zdYUbbDChrte9dDASO4/i9+xlAUtKj3XwrXFNgG5nTbM/JJdFjSm9I4RifmSPpYb9imsdfjs4bZABv4eTx0FL6lzaAxdQH7bLMVwIYWDURHYfrn5ukT6/7o8/7/QtIVvp/S83T7r5p1GCS2nkfR+E+LEzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BXd3qj4c; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BXd3qj4c"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea258fe4b6so32279527b3.1
        for <git@vger.kernel.org>; Tue, 29 Oct 2024 14:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730236272; x=1730841072; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JRbEh/ubsCOT7g6Mv42wQINjcFeyntyGlSdCT2oP5JA=;
        b=BXd3qj4cTDBJ0i3CB+eSarmNAQcHCPUvOTlucqnDirOr+QO5XTcm7vFQPANhZ9VvqM
         ckIM19F8eRLKgFzSxpfgLqdQc60Pz5eaD2olg8Vc//Yp1i+U8nL/5vzzmOxRjxrfdSKg
         eKli08/k0kGyCimFAEjrLBpslqfPuhqW1ZnEIHcnLAG13FkUFuejfeqClbJQk/SiejvH
         ESMYo9biZUMwvkzfB2TVDspw0qDGT32SY7ELTcGt5yJiX/O322Kq/mqhU+LmUh351Lqf
         bfiqbbko7ddIdnBvFmGVs+Cuaivcoruoks06+6MxJNwrjv5Evf2KBQLxElMXbK9nkLGO
         4tgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730236272; x=1730841072;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JRbEh/ubsCOT7g6Mv42wQINjcFeyntyGlSdCT2oP5JA=;
        b=Y2vKBP7RAKQJsb0vSf5GBkSOUaDByju0byXnnH0EjEYCGZ+IJyLcxvMqRlad5JzyUh
         cp93y3aqIA9+qbMtGQ6iNZsABlesq/QMvo+s5OVMO0Fl7+wEuwmPorH45DWfmNRd7jWJ
         k0k63VJCOoijf+8tBfQkA3UhJWvY0fmw0yHhKrbjRlBzZbi38QHAMMAceh1scaI9NfBa
         q+QRCaz4cuskuypYrPkhUk6sNpLSq/odBvNQvHvET7VYgPpZe12JX92pfO9xAHjcsD4x
         PZS3gtcvJfiJhi8UkOLsAsI/AyAq5luCHL9zG2bIbvtI7zMjslTQc+XoE+Y0ak94THz/
         UFdg==
X-Gm-Message-State: AOJu0YwndWC5o9BNoo09l1985KQUyRKl+88HOf36Pw75xuCt1j4wU1sj
	uwl2nCqU2lc+6nejMU7jH179eEqkXKneWviAeOkYT3l2ahK1SdHj6vXRv72KF+PS4Q7Rmy3oHLh
	M658mklJrGBxInn0CB3HGO3v1MZ5Hgc545aa1kZJj+Ba/W1i6t8C9D2BHf+q3cVgtx4kTfB0zks
	EDIWidiSFLUSMlizwo7N0uFg0UsOx27xGJ1R9qKfbY329aawLpSlYpEbVQIzG3BfgkxA==
X-Google-Smtp-Source: AGHT+IHqJUyb5twP2r/1PmIYXmmzX7VCyTW/vfQdSjx+/nd0jh3GowsdQg+14Gk1LhjOpIGFBj48eOlLKQDdB+D4a/WP
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:c9ca:c50e:3acc:7e6b])
 (user=jonathantanmy job=sendgmr) by 2002:a81:a8c4:0:b0:6e3:2693:ca6b with
 SMTP id 00721157ae682-6e9d897c43cmr3221837b3.2.1730236271649; Tue, 29 Oct
 2024 14:11:11 -0700 (PDT)
Date: Tue, 29 Oct 2024 14:11:04 -0700
In-Reply-To: <cover.1730235646.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241003223546.1935471-1-emilyshaffer@google.com> <cover.1730235646.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <4dea8933cf05a5020da7d78c088f4b091100952c.1730235646.git.jonathantanmy@google.com>
Subject: [PATCH 1/2] Revert "fetch-pack: add a deref_without_lazy_fetch_extended()"
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"

This reverts commit a6e65fb39caf18259c660c1c7910d5bf80bc15cb.

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

