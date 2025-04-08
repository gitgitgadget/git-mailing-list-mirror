Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF7A26461C
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744102289; cv=none; b=TNSOstOYg2Nwp0Nhc6bbFIT00gsyZMbSHsPy4CXYTTO2G+QWw42Jx32XcPwPLoyukchFvIL4OYDLJhBTJv1aLzGwOXdujLgkdj1ZDk7+kLAhAPsOiqDDXpvlcnNR/ZrSu/JKAxboU0SbNbb1LpJh+rHrLdsu/sHLaeWudIfy+/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744102289; c=relaxed/simple;
	bh=6uUFh7uieb5CfgzsSyUJVvgFuM9hkCf+ZmJAQIj2Zhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ONMnNVjvdyvXIdECRhR9lzTuStg6NikNSADf01sNmgnGLaj6Z4jO3jj1GFTtVNqmJIFud1vw5lx/Rzo7hoeqXbKBJd67X20kgg3jfObY0MoByCc0hWhghKsuEkWuoBw3zX2sysMpGO70xQEjA23fEeEmeeexAHf2LsZyqSOANrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyx4bZ6s; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyx4bZ6s"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abec8b750ebso892451366b.0
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 01:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744102286; x=1744707086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWPDsaP8F2lcBcR2r2yxC38a4GG0cs8AMfeY8dYSB+k=;
        b=iyx4bZ6sWNU2NpcBvQH77vOoIdHLn7bvlzc3iGCilSZ88tmu4WyYX1cA9hY1CW2+vU
         A8ss2gRC2akSHq1ez2gu72bLrUnH/6RDjl4VhIu30ckXRJ/gdoUpuc7J1/bF/RM2+t2Y
         xHaNy1V2o4TOb8my1vZmWif1MSQT1FsNcgqZ4pOAm7FGHZwUUb1QNd8CNdeIS/zEXEE7
         u6y+sXmT77LoykLbatCNCpoCtpuMwIOSa8v2e6l+UgXNUwy2dNXbm4xop53Ybxx2OzMc
         OnB8WG3aPJam6B75hR9+9f3gaWvH4Y1TvCuL0XTuuPf+14wKEeBvu+msliMZvTvX1wuB
         rKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744102286; x=1744707086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWPDsaP8F2lcBcR2r2yxC38a4GG0cs8AMfeY8dYSB+k=;
        b=H7cyXEXGx/b1iuuwLVcVRayhsWTp8RLcuzqpt/+rTrvUQptb59fPLBXGhBAcgQVeBQ
         71ozbSiPMylh6qs6mbgTn5ZmcKK3pXvtZQjv8aLwCqgK/o0OfjTVjBVMuYiGvrSNTsjz
         uibMdcwnZoLKNWZ9hm8PiC4Xv22Qd4WE4NtOa0FXG8G9iHNe9rLBzn/8vNThGBCpQOKG
         cnQkgOSBl0SKdFKbdbxDw+/ZT6kAYk7z+OYr7EPk4F0O0h6cxfijWc4aoctyWcF9Ddr8
         Braqvf+0J6aEIMXfx6NxJj/yBKSjDJmP0s2GcM6/yIyS07ltRWeZIf4ory2cvfP2wMfc
         +tuA==
X-Gm-Message-State: AOJu0YzVKe3zWPm7w1zfyF2TbC2kyWhCH4K+M2fCV3eR4zwJmUAvs6f9
	4HC+QyLQdWedDdf9ylDZNFyDpCvLpXSRUfAfnb1rzKMeYbdZNN/0
X-Gm-Gg: ASbGnctplcrgh21aFq8L6kVBQS/tgB50Y/R8fOUuuzJAX/nxq3tOAuU7tQdUNJC64Vk
	REtOltXPthUBCt80mFaBq+7njNTwwejdS6JgI+Nc4/5UQj7SRCb6tJTive/89I+RLQnWNdFhswf
	cwGRCtlcI6rXUV1CFrqYtS98OyGIXlTyRiyt7GsYZXXe4Dsz8QsHMJBtkE76Rj+p36r/tYrsncg
	P57xV65ZXH4WwQBgVJj+38an+hXW9ezMahyMKPR7r3xcxqL97Uvrw2yMdTsf4AgOjO4tDRXUbyJ
	4zec7SA2d+gZMl8xz2zwhJawlBG0r15Nd0XTIPjtGEexyClT2l9DM6c5ZQ==
X-Google-Smtp-Source: AGHT+IHQsPkX6xE5gr6hPTCmbRDnK1JmZfSEGoXd8Eum3Mhi6IIs5zj/6D1WMwne3/E4J5Os/NQi6g==
X-Received: by 2002:a17:907:1b10:b0:abf:4ca9:55ff with SMTP id a640c23a62f3a-ac7e7274280mr981459066b.32.1744102285987;
        Tue, 08 Apr 2025 01:51:25 -0700 (PDT)
Received: from localhost.localdomain ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe5c804sm890801366b.15.2025.04.08.01.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 01:51:25 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	ps@pks.im,
	jn.avila@free.fr,
	gitster@pobox.com
Subject: [PATCH v6 1/8] refs/files: remove redundant check in split_symref_update()
Date: Tue,  8 Apr 2025 10:51:05 +0200
Message-ID: <20250408085120.614893-2-karthik.188@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250408085120.614893-1-karthik.188@gmail.com>
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
 <20250408085120.614893-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In `split_symref_update()`, there were two checks for duplicate
refnames:

  - At the start, `string_list_has_string()` ensures the refname is not
    already in `affected_refnames`, preventing duplicates from being
    added.

  - After adding the refname, another check verifies whether the newly
    inserted item has a `util` value.

The second check is unnecessary because the first one guarantees that
`string_list_insert()` will never encounter a preexisting entry.

The `item->util` field is assigned to validate that a rename doesn't
already exist in the list. The validation is done after the first check.
As this check is removed, clean up the validation and the assignment of
this field in `split_head_update()` and `files_transaction_prepare()`.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/files-backend.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index ff54a4bb7e..15559a09c5 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2382,7 +2382,6 @@ static int split_head_update(struct ref_update *update,
 			     struct string_list *affected_refnames,
 			     struct strbuf *err)
 {
-	struct string_list_item *item;
 	struct ref_update *new_update;
 
 	if ((update->flags & REF_LOG_ONLY) ||
@@ -2421,8 +2420,7 @@ static int split_head_update(struct ref_update *update,
 	 */
 	if (strcmp(new_update->refname, "HEAD"))
 		BUG("%s unexpectedly not 'HEAD'", new_update->refname);
-	item = string_list_insert(affected_refnames, new_update->refname);
-	item->util = new_update;
+	string_list_insert(affected_refnames, new_update->refname);
 
 	return 0;
 }
@@ -2441,7 +2439,6 @@ static int split_symref_update(struct ref_update *update,
 			       struct string_list *affected_refnames,
 			       struct strbuf *err)
 {
-	struct string_list_item *item;
 	struct ref_update *new_update;
 	unsigned int new_flags;
 
@@ -2496,11 +2493,7 @@ static int split_symref_update(struct ref_update *update,
 	 * be valid as long as affected_refnames is in use, and NOT
 	 * referent, which might soon be freed by our caller.
 	 */
-	item = string_list_insert(affected_refnames, new_update->refname);
-	if (item->util)
-		BUG("%s unexpectedly found in affected_refnames",
-		    new_update->refname);
-	item->util = new_update;
+	string_list_insert(affected_refnames, new_update->refname);
 
 	return 0;
 }
@@ -2834,7 +2827,6 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 	 */
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
-		struct string_list_item *item;
 
 		if ((update->flags & REF_IS_PRUNING) &&
 		    !(update->flags & REF_NO_DEREF))
@@ -2843,13 +2835,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 		if (update->flags & REF_LOG_ONLY)
 			continue;
 
-		item = string_list_append(&affected_refnames, update->refname);
-		/*
-		 * We store a pointer to update in item->util, but at
-		 * the moment we never use the value of this field
-		 * except to check whether it is non-NULL.
-		 */
-		item->util = update;
+		string_list_append(&affected_refnames, update->refname);
 	}
 	string_list_sort(&affected_refnames);
 	if (ref_update_reject_duplicates(&affected_refnames, err)) {
-- 
2.48.1

