Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7799220281
	for <e@80x24.org>; Fri, 29 Sep 2017 20:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752574AbdI2UM7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 16:12:59 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:50917 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752561AbdI2UMV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 16:12:21 -0400
Received: by mail-pf0-f170.google.com with SMTP id m63so334366pfk.7
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 13:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=lLwl+LCO7N1tSXFRNm3VOPrwc/EDc+70xbefFo1SO8I=;
        b=wLZhMaxXkBl8tG4ZG6TEymGd1vRmvA8kqk9g7dDv8xs6pUbXFXslgxvkbtasZOnYjx
         c3Xv90WQKp2tUZut3/ZMz1LSox9a8jsRSs8G7qMWjDWjzsiWD3TL4KOom1DebneppSVa
         N90D8Hkp6wzXIAO7rOBPI2WxVC7q7SUfMZXOGB01go74toJ/cTaU2F312EJoqQu3LeHY
         VYbT7pJjelrmmR8CwRxqCzNZQkYrtDTEKdMzu+7C5441jm6WeYHW+u3Zh45hikE2KG2F
         4b9Me0IT6SbXAD4fnmv6CotSUEDoaDvWNwMyFqj+T93xQnSJP9IS64E+PrhQQCHyCA1C
         9THw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=lLwl+LCO7N1tSXFRNm3VOPrwc/EDc+70xbefFo1SO8I=;
        b=GZB71YZspPRskiymBdpF/1sCktdOp1RRsfIGzAjxrfoM7s2pU1DN1kNYA89gTEtgD2
         0k1uNfBBRTo3G6gnjVyMEYXfiyf0IAZ9PghoZ4JW4Vh0ngqgKOjPrhxbV8iKcE9Ulf9G
         mRKlT6m/AiU4XgbjfOApj5vnfkGbqgC9yfWj8y/cqy59ktj65wxVRBUiiWrxOcMElFea
         Vazm2iGg/XeuTXLDrViaHPZ3xGkWJs3+lB6J25xeuNo3UvLURTrrLyhB7ecpyxcokX0I
         alFZVApeIYkLP3nIIidDFa9HRewF+q14Y8gVMT+JZMIkA87oWQHT1C4Bq3lJNuXJ9dfe
         YHJg==
X-Gm-Message-State: AHPjjUjuo/RfOBQNFJeBi0Gh68IBGBC6IeGlXKAQJJsBF5jYl1/LWVsq
        mUk7p73GgRKXWvUphgJMZXWVC0CAw68=
X-Google-Smtp-Source: AOwi7QC/Nb/boK7EWoMcWHZYlATOzZdUnNqrOUuTSDNZ9OJXtHUemxGDVNC3zZqj7XyZ9ZTf43WCxA==
X-Received: by 10.98.207.194 with SMTP id b185mr8845450pfg.243.1506715940578;
        Fri, 29 Sep 2017 13:12:20 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([100.96.218.44])
        by smtp.gmail.com with ESMTPSA id g5sm9280561pgo.66.2017.09.29.13.12.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Sep 2017 13:12:19 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        git@jeffhostetler.com, peartben@gmail.com,
        christian.couder@gmail.com
Subject: [PATCH 10/18] pack-objects: rename want_.* to ignore_.*
Date:   Fri, 29 Sep 2017 13:11:46 -0700
Message-Id: <2d96de7a542d82f150fb47196b21763e7156f829.1506714999.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.748.g20475d2c7
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
In-Reply-To: <cover.1506714999.git.jonathantanmy@google.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, in pack_objects, add_object_entry() distinguishes between 2
types of non-preferred-base objects:

 (1) objects that should not be in "to_pack" because an option like
     --local or --honor-pack-keep is set
 (2) objects that should be in "to_pack"

A subsequent commit will teach pack-objects to exclude certain objects
(specifically, blobs that are larger than a user-given threshold and are
not potentially a Git special file [1]), but unlike in (1) above, these
exclusions need to be reported. So now we have 3 types of
non-preferred-base objects:

 (a) objects that should not be in "to_pack" and should not be reported
     because an option like --local or --honor-pack-keep is set
 (b) objects that should not be in "to_pack" and should be reported
     because they are blobs that are oversized and non-Git-special
 (c) objects that should be in "to_pack"

add_object_entry() will be taught to distinguish between these 3 types
by the following:

 - renaming want_found_object() and want_object_in_pack() to ignore_.*
   to make it clear that they only check for (a) (this commit)
 - adding a new function to check for (b) and using it within
   add_object_entry() (a subsequent commit)

The alternative would be to retain the names want_found_object() and
want_object_in_pack() and have them handle both the cases (a) and (b),
but that would result in more complicated code.

We also take the opportunity to use the terminology "preferred_base"
instead of "excluded" in these methods. It is true that preferred bases
are not included in the final packfile generation, but at this point in
the code, there is no exclusion taking place - on the contrary, if
something is "excluded", it is in fact guaranteed to be in to_pack.

[1] For the purposes of pack_objects, a blob is a Git special file if it
    appears in a to-be-packed tree with a filename beginning with
    ".git".

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/pack-objects.c | 56 +++++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 958822bf4..ef0b61d5f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -949,12 +949,12 @@ static int have_duplicate_entry(const unsigned char *sha1,
 	return 1;
 }
 
-static int want_found_object(int exclude, struct packed_git *p)
+static int ignore_found_object(int preferred_base, struct packed_git *p)
 {
-	if (exclude)
-		return 1;
-	if (incremental)
+	if (preferred_base)
 		return 0;
+	if (incremental)
+		return 1;
 
 	/*
 	 * When asked to do --local (do not include an object that appears in a
@@ -972,19 +972,19 @@ static int want_found_object(int exclude, struct packed_git *p)
 	 */
 	if (!ignore_packed_keep &&
 	    (!local || !have_non_local_packs))
-		return 1;
+		return 0;
 
 	if (local && !p->pack_local)
-		return 0;
+		return 1;
 	if (ignore_packed_keep && p->pack_local && p->pack_keep)
-		return 0;
+		return 1;
 
 	/* we don't know yet; keep looking for more packs */
 	return -1;
 }
 
 /*
- * Check whether we want the object in the pack (e.g., we do not want
+ * Check whether we should ignore this object (e.g., we do not want
  * objects found in non-local stores if the "--local" option was used).
  *
  * If the caller already knows an existing pack it wants to take the object
@@ -992,16 +992,16 @@ static int want_found_object(int exclude, struct packed_git *p)
  * function finds if there is any pack that has the object and returns the pack
  * and its offset in these variables.
  */
-static int want_object_in_pack(const unsigned char *sha1,
-			       int exclude,
-			       struct packed_git **found_pack,
-			       off_t *found_offset)
+static int ignore_object(const unsigned char *sha1,
+			 int preferred_base,
+			 struct packed_git **found_pack,
+			 off_t *found_offset)
 {
 	struct mru_entry *entry;
-	int want;
+	int ignore;
 
-	if (!exclude && local && has_loose_object_nonlocal(sha1))
-		return 0;
+	if (!preferred_base && local && has_loose_object_nonlocal(sha1))
+		return 1;
 
 	/*
 	 * If we already know the pack object lives in, start checks from that
@@ -1009,9 +1009,9 @@ static int want_object_in_pack(const unsigned char *sha1,
 	 * are present we will determine the answer right now.
 	 */
 	if (*found_pack) {
-		want = want_found_object(exclude, *found_pack);
-		if (want != -1)
-			return want;
+		ignore = ignore_found_object(preferred_base, *found_pack);
+		if (ignore != -1)
+			return ignore;
 	}
 
 	for (entry = packed_git_mru->head; entry; entry = entry->next) {
@@ -1030,15 +1030,15 @@ static int want_object_in_pack(const unsigned char *sha1,
 				*found_offset = offset;
 				*found_pack = p;
 			}
-			want = want_found_object(exclude, p);
-			if (!exclude && want > 0)
+			ignore = ignore_found_object(preferred_base, p);
+			if (!preferred_base && ignore > 0)
 				mru_mark(packed_git_mru, entry);
-			if (want != -1)
-				return want;
+			if (ignore != -1)
+				return ignore;
 		}
 	}
 
-	return 1;
+	return 0;
 }
 
 static void create_object_entry(const unsigned char *sha1,
@@ -1073,16 +1073,16 @@ static const char no_closure_warning[] = N_(
 );
 
 static int add_object_entry(const unsigned char *sha1, enum object_type type,
-			    const char *name, int exclude)
+			    const char *name, int preferred_base)
 {
 	struct packed_git *found_pack = NULL;
 	off_t found_offset = 0;
 	uint32_t index_pos;
 
-	if (have_duplicate_entry(sha1, exclude, &index_pos))
+	if (have_duplicate_entry(sha1, preferred_base, &index_pos))
 		return 0;
 
-	if (!want_object_in_pack(sha1, exclude, &found_pack, &found_offset)) {
+	if (ignore_object(sha1, preferred_base, &found_pack, &found_offset)) {
 		/* The pack is missing an object, so it will not have closure */
 		if (write_bitmap_index) {
 			warning(_(no_closure_warning));
@@ -1092,7 +1092,7 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
 	}
 
 	create_object_entry(sha1, type, pack_name_hash(name),
-			    exclude, name && no_try_delta(name),
+			    preferred_base, name && no_try_delta(name),
 			    index_pos, found_pack, found_offset);
 
 	display_progress(progress_state, nr_result);
@@ -1109,7 +1109,7 @@ static int add_object_entry_from_bitmap(const unsigned char *sha1,
 	if (have_duplicate_entry(sha1, 0, &index_pos))
 		return 0;
 
-	if (!want_object_in_pack(sha1, 0, &pack, &offset))
+	if (ignore_object(sha1, 0, &pack, &offset))
 		return 0;
 
 	create_object_entry(sha1, type, name_hash, 0, 0, index_pos, pack, offset);
-- 
2.14.2.822.g60be5d43e6-goog

