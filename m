Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A282BD5A4
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097294; cv=none; b=J1uuZzUPV0vY171tQI+2A9sQYdyMM/aB4MdDupvE084N0jXBt8ChueQah0yvMEQlmsazPhUHN70XGrqOkEPshXKIb6yCRTkRFr/uR3ahvNVWGY4fUlMr3Udz0uY3jQeYNa6OwSZe1p2Y1l0V5msgBjVaNBaZXqDYYQuQE6M/MF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097294; c=relaxed/simple;
	bh=2+jvRIWGyFn5oeAhLFDyahNNL1Md9IZ3W/+CrX3M2GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJe9yOHYWn8kFmy6CC+SJvnJtj7sBeMgO4Scp7QtG1EpVsgMiI9yPpbxAk8O2x1IyU/Qv3OIJcf9Qhf41rhdXxkBHlJ6pWNw/zMsM0Dn7pJ0OgTKCT3jtpWX1szHwWtfOsrSMrQH7M4AS0syeOqwo/cVNx1lRTjoo56zn+lBWvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=dET5F5gF; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="dET5F5gF"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-72ce9790aceso39444607b3.3
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097290; x=1759702090; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rNtVKpm7eOUtkY+Eq52hFD1A9wwFjR7NzfFOJAEqMDo=;
        b=dET5F5gF2tANUL/PDZ/TGx1/L4OVDDWlTkM+IwfK2uxHWryQ5aH48I4UnzAiCnA/NW
         o5ye1+TtOk34cAYkd3dVuXxwk9DyxBNnz9MA+X/cQEHP4tklcgT2ZS+WlvtuplXNYaFl
         SEJ0LE/cHvsTPNZs/0Pdakk9NYp6qK6fTqtONoTkJKSKpKxfUUtOSS7jdHVD99qoR7Ca
         ZhrFWtT3hk6b47B0VYZYY3yI/PeHU6H5l8Na2Nhmm7Ak7yY6UMjFysxeh/RmECanmohu
         YeXblRem60qo5Hnpm9AD7IDZr1WPehPRxinD/SYG82/Zxh1a3iNkxnMpH/a5ONWeE3Y3
         3X9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097290; x=1759702090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNtVKpm7eOUtkY+Eq52hFD1A9wwFjR7NzfFOJAEqMDo=;
        b=RoCoelUEnfan7cXlVB0OnnC5jkDpzLQdFM3PMeAw3WYX1CMqNmG1k3bnXr7SAh4ZiY
         t9fiG9VynpXfDmcO9cK678jrN5dNZxwYI2/o9VB/cXIxaFYS2V5QBG/daFXyJFz7g5Wq
         Ov+/uFPpnStApdqJ8R4rx1No9qDZ/+HLRj61qksqwgEyaEAYqB1aBhJeP0q71gC41ynX
         ev5PNLyNpquE6qNAWXddZ9UwlB7HhevH4zvQnDPARs34ysNoSoHPB9ryINJY/3t80F/A
         beT16hn/rF+e89nCiqWTdzI2WfKubnUqSQLePrZXk/eRlWWN4g4xW//pDqBDaLUQy4a8
         fxUg==
X-Gm-Message-State: AOJu0YyxLORnhp++sItlfay6/t5mShoRbsISp7hvzmUW5hGIlCSl1o0i
	FTelNkaDAn4TsEvV87Ghl7MeOgXXhO/bjZ3Frei4JGapWGVSqijWXRKEKfEoarfEFJJ4XGkGPkX
	4B3vzqHU=
X-Gm-Gg: ASbGncsBADIMpRU5Ieel/9IZmhGU0rn1l1kB3TUJEhLIjoFPS82Br27I2XHUOVKdNiU
	oFIkKlr0wAMMK8gSoPuOStDnPvarG+44r/06frSm0blOWYUPqMMPyQMvuN2jddkcsuyzAPAUHI1
	PnIkFSmRoNJu2eE1PlST1qkORdeuaNUzQ76ZBFVLso/tNjiObY2WIH4r2Ou51HGTdEq14gBXR/f
	yZpiyJbucfCLk14CmhRPDF/+/U3X8DSv140h13wkDzoTExZVyhaOMilQoAV7Rk0QYdJox83A/KF
	kV6SlxVNId5hiLEo9cnEd1KHitxxKQZx0HDVCdVJ6wXNLw+dCpt4O5MFdpHrKcGAJCF/odXYN2n
	K7Lpt9o7bVIWFB3wA98ETboCmabsJRNGq+vCpeTA3vA3iCmPNUI7VG6osWBpcmEmZEnMLK7aDJI
	9opkoJSpdxVoRXyI3RsNp2M22mA5TIlJGHY/JDS0WuS0xkYkg=
X-Google-Smtp-Source: AGHT+IHxjXF/QDTLJJvgXi6n5MFxzCqLsY4zbwXFhc8bl42abzurENIdtMsbP3bmI9S5sIBAd/rz2Q==
X-Received: by 2002:a05:690e:2450:b0:636:1409:9b46 with SMTP id 956f58d0204a3-6361a84161cmr12612727d50.27.1759097290307;
        Sun, 28 Sep 2025 15:08:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-eb50e50c67asm1743683276.34.2025.09.28.15.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:08:10 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:08:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 15/49] builtin/repack.c: rename many 'struct existing_packs'
 functions
Message-ID: <02e26f78ac8e3b7e800385cb60d2581398492cc9.1759097191.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759097191.git.me@ttaylorr.com>

Rename many of the 'struct existing_packs'-related functions according
to the convention introduced in and described by 541204aabe
(Documentation: document naming schema for structs and their functions,
2024-07-30).

Note that some functions which operate over an individual entry in the
list of existing packs are prefixed with "existing_pack_" instead of the
plural form.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 66 +++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 32 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index ff93654cfe..f82e6c3930 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -121,39 +121,39 @@ struct existing_packs {
 	.cruft_packs = STRING_LIST_INIT_DUP, \
 }
 
-static int has_existing_non_kept_packs(const struct existing_packs *existing)
+static int existing_packs_has_non_kept(const struct existing_packs *existing)
 {
 	return existing->non_kept_packs.nr || existing->cruft_packs.nr;
 }
 
-static void pack_mark_for_deletion(struct string_list_item *item)
+static void existing_pack_mark_for_deletion(struct string_list_item *item)
 {
 	item->util = (void*)((uintptr_t)item->util | DELETE_PACK);
 }
 
-static void pack_unmark_for_deletion(struct string_list_item *item)
+static void existing_pack_unmark_for_deletion(struct string_list_item *item)
 {
 	item->util = (void*)((uintptr_t)item->util & ~DELETE_PACK);
 }
 
-static int pack_is_marked_for_deletion(struct string_list_item *item)
+static int existing_pack_is_marked_for_deletion(struct string_list_item *item)
 {
 	return (uintptr_t)item->util & DELETE_PACK;
 }
 
-static void pack_mark_retained(struct string_list_item *item)
+static void existing_packs_mark_retained(struct string_list_item *item)
 {
 	item->util = (void*)((uintptr_t)item->util | RETAIN_PACK);
 }
 
-static int pack_is_retained(struct string_list_item *item)
+static int existing_pack_is_retained(struct string_list_item *item)
 {
 	return (uintptr_t)item->util & RETAIN_PACK;
 }
 
-static void mark_packs_for_deletion_1(const struct git_hash_algo *algop,
-				      struct string_list *names,
-				      struct string_list *list)
+static void existing_packs_mark_for_deletion_1(const struct git_hash_algo *algop,
+					       struct string_list *names,
+					       struct string_list *list)
 {
 	struct string_list_item *item;
 	const int hexsz = algop->hexsz;
@@ -165,8 +165,8 @@ static void mark_packs_for_deletion_1(const struct git_hash_algo *algop,
 			continue;
 		sha1 = item->string + len - hexsz;
 
-		if (pack_is_retained(item)) {
-			pack_unmark_for_deletion(item);
+		if (existing_pack_is_retained(item)) {
+			existing_pack_unmark_for_deletion(item);
 		} else if (!string_list_has_string(names, sha1)) {
 			/*
 			 * Mark this pack for deletion, which ensures
@@ -175,13 +175,13 @@ static void mark_packs_for_deletion_1(const struct git_hash_algo *algop,
 			 * will actually delete this pack (if `-d` was
 			 * given).
 			 */
-			pack_mark_for_deletion(item);
+			existing_pack_mark_for_deletion(item);
 		}
 	}
 }
 
-static void retain_cruft_pack(struct existing_packs *existing,
-			      struct packed_git *cruft)
+static void existing_packs_retain_cruft(struct existing_packs *existing,
+					struct packed_git *cruft)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct string_list_item *item;
@@ -193,17 +193,19 @@ static void retain_cruft_pack(struct existing_packs *existing,
 	if (!item)
 		BUG("could not find cruft pack '%s'", pack_basename(cruft));
 
-	pack_mark_retained(item);
+	existing_packs_mark_retained(item);
 	strbuf_release(&buf);
 }
 
-static void mark_packs_for_deletion(struct existing_packs *existing,
-				    struct string_list *names)
+static void existing_packs_mark_for_deletion(struct existing_packs *existing,
+					     struct string_list *names)
 
 {
 	const struct git_hash_algo *algop = existing->repo->hash_algo;
-	mark_packs_for_deletion_1(algop, names, &existing->non_kept_packs);
-	mark_packs_for_deletion_1(algop, names, &existing->cruft_packs);
+	existing_packs_mark_for_deletion_1(algop, names,
+					   &existing->non_kept_packs);
+	existing_packs_mark_for_deletion_1(algop, names,
+					   &existing->cruft_packs);
 }
 
 static void remove_redundant_pack(struct repository *repo,
@@ -225,13 +227,13 @@ static void remove_redundant_packs_1(struct repository *repo,
 {
 	struct string_list_item *item;
 	for_each_string_list_item(item, packs) {
-		if (!pack_is_marked_for_deletion(item))
+		if (!existing_pack_is_marked_for_deletion(item))
 			continue;
 		remove_redundant_pack(repo, packdir, item->string);
 	}
 }
 
-static void remove_redundant_existing_packs(struct existing_packs *existing)
+static void existing_packs_remove_redundant(struct existing_packs *existing)
 {
 	remove_redundant_packs_1(existing->repo, &existing->non_kept_packs);
 	remove_redundant_packs_1(existing->repo, &existing->cruft_packs);
@@ -250,7 +252,7 @@ static void existing_packs_release(struct existing_packs *existing)
  * .keep file or not.  Packs without a .keep file are not to be kept
  * if we are going to pack everything into one file.
  */
-static void collect_pack_filenames(struct existing_packs *existing,
+static void existing_packs_collect(struct existing_packs *existing,
 				   const struct string_list *extra_keep)
 {
 	struct packfile_store *packs = existing->repo->objects->packfiles;
@@ -721,7 +723,7 @@ static int midx_has_unknown_packs(char **midx_pack_names,
 
 			item = string_list_lookup(&existing->non_kept_packs,
 						  pack_name);
-			if (item && !pack_is_marked_for_deletion(item))
+			if (item && !existing_pack_is_marked_for_deletion(item))
 				continue;
 		}
 
@@ -851,7 +853,7 @@ static void midx_included_packs(struct string_list *include,
 		}
 	} else {
 		for_each_string_list_item(item, &existing->non_kept_packs) {
-			if (pack_is_marked_for_deletion(item))
+			if (existing_pack_is_marked_for_deletion(item))
 				continue;
 
 			strbuf_reset(&buf);
@@ -888,10 +890,10 @@ static void midx_included_packs(struct string_list *include,
 			 * --geometric case, but doing so is unnecessary
 			 *  since no packs are marked as pending
 			 *  deletion (since we only call
-			 *  `mark_packs_for_deletion()` when doing an
-			 *  all-into-one repack).
+			 *  `existing_packs_mark_for_deletion()` when
+			 *  doing an all-into-one repack).
 			 */
-			if (pack_is_marked_for_deletion(item))
+			if (existing_pack_is_marked_for_deletion(item))
 				continue;
 
 			strbuf_reset(&buf);
@@ -1128,7 +1130,7 @@ static void combine_small_cruft_packs(FILE *in, size_t combine_cruft_below_size,
 		if (p->pack_size < combine_cruft_below_size) {
 			fprintf(in, "-%s\n", pack_basename(p));
 		} else {
-			retain_cruft_pack(existing, p);
+			existing_packs_retain_cruft(existing, p);
 			fprintf(in, "%s\n", pack_basename(p));
 		}
 	}
@@ -1382,7 +1384,7 @@ int cmd_repack(int argc,
 	packtmp = mkpathdup("%s/%s", packdir, packtmp_name);
 
 	existing.repo = repo;
-	collect_pack_filenames(&existing, &keep_pack_list);
+	existing_packs_collect(&existing, &keep_pack_list);
 
 	if (geometry.split_factor) {
 		if (pack_everything)
@@ -1431,7 +1433,7 @@ int cmd_repack(int argc,
 	if (pack_everything & ALL_INTO_ONE) {
 		repack_promisor_objects(repo, &po_args, &names);
 
-		if (has_existing_non_kept_packs(&existing) &&
+		if (existing_packs_has_non_kept(&existing) &&
 		    delete_redundant &&
 		    !(pack_everything & PACK_CRUFT)) {
 			for_each_string_list_item(item, &names) {
@@ -1647,7 +1649,7 @@ int cmd_repack(int argc,
 	/* End of pack replacement. */
 
 	if (delete_redundant && pack_everything & ALL_INTO_ONE)
-		mark_packs_for_deletion(&existing, &names);
+		existing_packs_mark_for_deletion(&existing, &names);
 
 	if (write_midx) {
 		struct string_list include = STRING_LIST_INIT_DUP;
@@ -1671,7 +1673,7 @@ int cmd_repack(int argc,
 
 	if (delete_redundant) {
 		int opts = 0;
-		remove_redundant_existing_packs(&existing);
+		existing_packs_remove_redundant(&existing);
 
 		if (geometry.split_factor)
 			geometry_remove_redundant_packs(&geometry, &names,
-- 
2.51.0.243.g16eca91f2c0

