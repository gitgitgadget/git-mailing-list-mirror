Return-Path: <SRS0=Tp/o=2W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585F2C32764
	for <git@archiver.kernel.org>; Wed,  1 Jan 2020 05:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2592A2072C
	for <git@archiver.kernel.org>; Wed,  1 Jan 2020 05:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZ+DC3xf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgAAFVC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jan 2020 00:21:02 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:37337 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgAAFVC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jan 2020 00:21:02 -0500
Received: by mail-ed1-f42.google.com with SMTP id cy15so36499512edb.4
        for <git@vger.kernel.org>; Tue, 31 Dec 2019 21:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1zxW/SDLCl6cBAn0DRiyckQ45MB0PQwNrpurrg63Urw=;
        b=XZ+DC3xfMoCTZ0hVGk5HHnDfBltBvrTHL41pHhglwF5fAHcJOMMxDmPtXruiwyAy6y
         V3IZ/lzmuVsd6AJxvpvm4meg8wuCUGedEvHb3MC7zGgEShZRfYii37g0pQ8B9zmoXvNn
         QhR4xNw4Bndnheq2zHF83r8Fgxk8QAcRrww1T1CELTPKu+PeNuuH6BASshjzFOMwl4yk
         TukeVlgs1e3aU/h9vsUKImmDwUyzX3kS+ipRlOQLBeXAMVTb8BLh1e7biXJKEV5zY6Jv
         jCze4xRPphOUOY2YUhkb7nJ7MZmhguOMdQt2t4GHe5SadCOT1+K5gK2XnEKk1PRg2CT3
         CdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1zxW/SDLCl6cBAn0DRiyckQ45MB0PQwNrpurrg63Urw=;
        b=NHywPu5A46X7ldmRdd6N4ykfioMxrRci6KOBj0cCUZZ76k1hH91q2RQ1oSlw/z1OzB
         Lf0PfOyil6Ky8bo6e50t2XTvdPTOirn92SXFGdlBL2ZyAPb+YXNJiz4x4sPQnJ/gvnKS
         NzmEltrH3iEkCEka7VD3yTvvUHhhzsuxgYt52Vhgye+AYx7s6B5wD/hB09T0X5WmVgRi
         NzcG09dVc47sd+NJLSyXMRh1TAbZe/PLYgO1IrGvMMYE5QjUgwx8CvrevHffkwh+xUiV
         IvbVs4UvzLDvZyPm+DOU1gpvXDQJ2rZJCDMq37X587JMfbenFz/J5FYFx+8HN4PsDtAY
         FM2Q==
X-Gm-Message-State: APjAAAURHRBPrdFUBrTrVGoeihRXtHBQStFkEFSLViqzRYU8w9Rn4anE
        Ft7r0DVG9lPRrGaaoygr6j8gxx/k
X-Google-Smtp-Source: APXvYqwHrvS52/Vkcj8gkxfiw2NWcIM0f2t6sOoe77d3R9lr5+v0RHIDu0/67QNZxNfzXrgHEpg2Uw==
X-Received: by 2002:a05:6402:545:: with SMTP id i5mr79206395edx.11.1577856059756;
        Tue, 31 Dec 2019 21:20:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y4sm6124906edl.11.2019.12.31.21.20.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Dec 2019 21:20:59 -0800 (PST)
Message-Id: <c653a9b8d3863b3484eff224bbfbde65c250eaf0.1577856057.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.685.git.git.1577856057.gitgitgadget@gmail.com>
References: <pull.685.git.git.1577856057.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Jan 2020 05:20:57 +0000
Subject: [PATCH 1/1] merge-recursive: remove unnecessary oid_eq function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Back when merge-recursive was first introduced in commit 6d297f8137
(Status update on merge-recursive in C, 2006-07-08), it created a
sha_eq() function.  This function pre-dated the introduction of
hashcmp() to cache.h by about a month, but was switched over to using
hashcmp() as part of commit 9047ebbc22 (Split out merge_recursive() to
merge-recursive.c, 2008-08-12).  In commit b4da9d62f9 (merge-recursive:
convert leaf functions to use struct object_id, 2016-06-24), sha_eq() was
renamed to oid_eq() and its hashcmp() call was switched to oideq().

oid_eq() is basically just a wrapper around oideq() that has some extra
checks to protect against NULL arguments or to allow short-circuiting if
one of the arguments is NULL.  I don't know if any caller ever tried to
call with NULL arguments, but certainly none do now which means the
extra checks serve no purpose.  (Also, if these checks were genuinely
useful, then they probably should be added to the main oideq() so all
callers could benefit from them.)

Reduce the cognitive overhead of having both oid_eq() and oideq(), by
getting rid of merge-recursive's special oid_eq() wrapper.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 11869ad81c..10dca5644b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -224,17 +224,6 @@ static struct commit *make_virtual_commit(struct repository *repo,
 	return commit;
 }
 
-/*
- * Since we use get_tree_entry(), which does not put the read object into
- * the object pool, we cannot rely on a == b.
- */
-static int oid_eq(const struct object_id *a, const struct object_id *b)
-{
-	if (!a && !b)
-		return 2;
-	return a && b && oideq(a, b);
-}
-
 enum rename_type {
 	RENAME_NORMAL = 0,
 	RENAME_VIA_DIR,
@@ -805,7 +794,7 @@ static int was_tracked_and_matches(struct merge_options *opt, const char *path,
 
 	/* See if the file we were tracking before matches */
 	ce = opt->priv->orig_index.cache[pos];
-	return (oid_eq(&ce->oid, &blob->oid) && ce->ce_mode == blob->mode);
+	return (oideq(&ce->oid, &blob->oid) && ce->ce_mode == blob->mode);
 }
 
 /*
@@ -1317,7 +1306,7 @@ static int merge_mode_and_contents(struct merge_options *opt,
 			oidcpy(&result->blob.oid, &b->oid);
 		}
 	} else {
-		if (!oid_eq(&a->oid, &o->oid) && !oid_eq(&b->oid, &o->oid))
+		if (!oideq(&a->oid, &o->oid) && !oideq(&b->oid, &o->oid))
 			result->merge = 1;
 
 		/*
@@ -1333,9 +1322,9 @@ static int merge_mode_and_contents(struct merge_options *opt,
 			}
 		}
 
-		if (oid_eq(&a->oid, &b->oid) || oid_eq(&a->oid, &o->oid))
+		if (oideq(&a->oid, &b->oid) || oideq(&a->oid, &o->oid))
 			oidcpy(&result->blob.oid, &b->oid);
-		else if (oid_eq(&b->oid, &o->oid))
+		else if (oideq(&b->oid, &o->oid))
 			oidcpy(&result->blob.oid, &a->oid);
 		else if (S_ISREG(a->mode)) {
 			mmbuffer_t result_buf;
@@ -1368,7 +1357,7 @@ static int merge_mode_and_contents(struct merge_options *opt,
 			switch (opt->recursive_variant) {
 			case MERGE_VARIANT_NORMAL:
 				oidcpy(&result->blob.oid, &a->oid);
-				if (!oid_eq(&a->oid, &b->oid))
+				if (!oideq(&a->oid, &b->oid))
 					result->clean = 0;
 				break;
 			case MERGE_VARIANT_OURS:
@@ -2836,15 +2825,15 @@ static int process_renames(struct merge_options *opt,
 			dst_other.mode = ren1->dst_entry->stages[other_stage].mode;
 			try_merge = 0;
 
-			if (oid_eq(&src_other.oid, &null_oid) &&
+			if (oideq(&src_other.oid, &null_oid) &&
 			    ren1->dir_rename_original_type == 'A') {
 				setup_rename_conflict_info(RENAME_VIA_DIR,
 							   opt, ren1, NULL);
-			} else if (oid_eq(&src_other.oid, &null_oid)) {
+			} else if (oideq(&src_other.oid, &null_oid)) {
 				setup_rename_conflict_info(RENAME_DELETE,
 							   opt, ren1, NULL);
 			} else if ((dst_other.mode == ren1->pair->two->mode) &&
-				   oid_eq(&dst_other.oid, &ren1->pair->two->oid)) {
+				   oideq(&dst_other.oid, &ren1->pair->two->oid)) {
 				/*
 				 * Added file on the other side identical to
 				 * the file being renamed: clean merge.
@@ -2859,7 +2848,7 @@ static int process_renames(struct merge_options *opt,
 						      1, /* update_cache */
 						      0  /* update_wd    */))
 					clean_merge = -1;
-			} else if (!oid_eq(&dst_other.oid, &null_oid)) {
+			} else if (!oideq(&dst_other.oid, &null_oid)) {
 				/*
 				 * Probably not a clean merge, but it's
 				 * premature to set clean_merge to 0 here,
@@ -3037,7 +3026,7 @@ static int blob_unchanged(struct merge_options *opt,
 
 	if (a->mode != o->mode)
 		return 0;
-	if (oid_eq(&o->oid, &a->oid))
+	if (oideq(&o->oid, &a->oid))
 		return 1;
 	if (!renormalize)
 		return 0;
@@ -3478,7 +3467,7 @@ static int merge_trees_internal(struct merge_options *opt,
 					       opt->subtree_shift);
 	}
 
-	if (oid_eq(&merge_base->object.oid, &merge->object.oid)) {
+	if (oideq(&merge_base->object.oid, &merge->object.oid)) {
 		output(opt, 0, _("Already up to date!"));
 		*result = head;
 		return 1;
-- 
gitgitgadget
