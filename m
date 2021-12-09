Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A59C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 19:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhLITXe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 14:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhLITX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 14:23:29 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B73C0698C7
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 11:19:42 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id y196so5066121wmc.3
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 11:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Om4XtICmfyJPXniEbXRkpDc1meIlVEWmcmXMYBRaEcI=;
        b=dYyu/f608zCHQRekwhQjeWpgwaCAs8eCZJapk6zL6r8Yd/Vh4f0GqnZC/nAs0DsXAR
         ZQ1iixF0gyIU3eU/uMWvTDteO3uZCHfNWvrIlNJ3iqRD9H7kACaO3Om71KBXZMZ7G36k
         zjTRniK5L7WxJm2ETuMtFdOHEwyBgA1NOhHPG3ZO/XHh2Y099UMTJwWdn1nh4nMeWaJ2
         QRTEZ6Pzd2w47H8o7ItStdsUCPKQ2XoZzM+YHnS/x4H4Qh3knl0dsWYLmCbgSaB9Ml0T
         0ZtzIvt2MebsnREqGbeKgt2Z+nuKkTosooJJ1CKw4SMwK6Ne4vLJ256+bT/jkzmGWZ0T
         C+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Om4XtICmfyJPXniEbXRkpDc1meIlVEWmcmXMYBRaEcI=;
        b=6NVWc6iG7iI/JDoRXx1z0SiOcV6sUKZGdkF55DfLwn5VagJs8F30AfMfkMZto7qeWH
         HASemeU4UNfqr2bj2+4LL7XRNiAJY/1aBy+NT/Cgfb5Nnp4kKG/bDvREoqzkvdDxfAVQ
         9KzHjQ7X0nTLvkG9w9vh4Htva5jchvF4XyfS/g3lEYL5BdLtSIL/VSJLerU4t9EvlDkn
         TbIIZQq54cuLkWvKuPYABFJA7BVeUQsuRo8yO8ftwzMcprtmE/Tk5OQ7q4/wsFScqA43
         dp6OOCYWOrAJ+hdtu0nTTH2F4q4hVjkAoOuvd6al6XSRs301+r7vNzfzZ0LpoED1GACb
         YesA==
X-Gm-Message-State: AOAM532GDP8eIqB2oT3CQOERJ/+X7KQzEhCPe8t5YNOLHIpjPRLld7ce
        TGsrU1Nf4mBgGeX8sBZnUzEoSEyLjg8ucg==
X-Google-Smtp-Source: ABdhPJxaNzf1gVeRTzwtLhDc6tpc933x4b1QuDQGbdBl/0m1mOI8YDh5yKwvks3RctCKcIG9uyCdLA==
X-Received: by 2002:a1c:4d3:: with SMTP id 202mr9746978wme.174.1639077581121;
        Thu, 09 Dec 2021 11:19:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x13sm562180wrr.47.2021.12.09.11.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 11:19:40 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 10/10] linear-assignment.c: use "intmax_t" instead of "int"
Date:   Thu,  9 Dec 2021 20:19:27 +0100
Message-Id: <RFC-patch-10.10-46395080b64-20211209T191653Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.930.g0f9292b224d
In-Reply-To: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "int" type used by compute_assignment() to "intmax_t". On
64 bit systems this changes the overflow "die" added in the preceding
commit (which before that was a segfault) to something that merely
takes a very long time and a lot of memory to run.

On my relatively beefy system this completes:

    git -P range-diff --creation-factor=50 origin/master...git-for-windows/main

In around 300 seconds, with a reported max RSS of just under 18GB, but
it does give you correct results for all ~50k commitsin that range.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 linear-assignment.c | 92 ++++++++++++++++++++++-----------------------
 linear-assignment.h |  8 +---
 range-diff.c        | 11 +++---
 3 files changed, 54 insertions(+), 57 deletions(-)

diff --git a/linear-assignment.c b/linear-assignment.c
index e45099d651a..ccd760520f8 100644
--- a/linear-assignment.c
+++ b/linear-assignment.c
@@ -7,14 +7,14 @@
 #include "linear-assignment.h"
 #include "compat/gnulib/intprops.h"
 
-static inline int cost_index(int *cost, int a, int b, int c)
+static inline intmax_t cost_index(intmax_t *cost, intmax_t a, intmax_t b, intmax_t c)
 {
-	int r;
+	intmax_t r;
 
 	if (INT_MULTIPLY_WRAPV(a, c, &r))
-		die(_("integer overflow in cost[%d + %d * %d] multiplication"), b, a, c);
+		die(_("integer overflow in cost[%"PRIuMAX" + %"PRIuMAX" * %"PRIuMAX"] multiplication"), b, a, c);
 	if (INT_ADD_WRAPV(b, r, &r))
-		die(_("integer overflow in cost[%d + ((%d * %d) = %d)] addition"), b, a, c, r);
+		die(_("integer overflow in cost[%"PRIuMAX" + ((%"PRIuMAX" * %"PRIuMAX") = %"PRIuMAX")] addition"), b, a, c, r);
 
 	return r;
 }
@@ -22,15 +22,15 @@ static inline int cost_index(int *cost, int a, int b, int c)
 #define COST(column, row) cost[cost_index(cost, column_count, column, row)]
 
 static void columns_reduction(size_t column_count, size_t row_count,
-			      int *cost,
-			      int *column2row, int *row2column,
-			      int *v)
+			      intmax_t *cost,
+			      intmax_t *column2row, intmax_t *row2column,
+			      intmax_t *v)
 {
-	int i, j;
+	intmax_t i, j;
 
 	/* column reduction */
 	for (j = column_count - 1; j >= 0; j--) {
-		int i1 = 0;
+		intmax_t i1 = 0;
 
 		for (i = 1; i < row_count; i++)
 			if (COST(j, i1) > COST(j, i))
@@ -49,22 +49,22 @@ static void columns_reduction(size_t column_count, size_t row_count,
 }
 
 static void reduction_transfer(size_t column_count, size_t row_count,
-			       int *cost,
-			       int *free_row, int *free_count,
-			       int *column2row, int *row2column,
-			       int *v)
+			       intmax_t *cost,
+			       intmax_t *free_row, intmax_t *free_count,
+			       intmax_t *column2row, intmax_t *row2column,
+			       intmax_t *v)
 {
-	int i, j;
+	intmax_t i, j;
 
 	/* reduction transfer */
 	for (i = 0; i < row_count; i++) {
-		int j1 = row2column[i];
+		intmax_t j1 = row2column[i];
 		if (j1 == -1)
 			free_row[(*free_count)++] = i;
 		else if (j1 < -1)
 			row2column[i] = -2 - j1;
 		else {
-			int min = COST(!j1, i) - v[!j1];
+			intmax_t min = COST(!j1, i) - v[!j1];
 			for (j = 1; j < column_count; j++)
 				if (j != j1 && min > COST(j, i) - v[j])
 					min = COST(j, i) - v[j];
@@ -74,31 +74,31 @@ static void reduction_transfer(size_t column_count, size_t row_count,
 }
 
 static void augmenting_row_reduction(size_t column_count,
-				     int *cost,
-				     int *column2row, int *row2column,
-				     int *free_row, int *free_count, int *saved_free_count,
-				     int *v)
+				     intmax_t *cost,
+				     intmax_t *column2row, intmax_t *row2column,
+				     intmax_t *free_row, intmax_t *free_count, intmax_t *saved_free_count,
+				     intmax_t *v)
 {
 	int phase;
 
 	/* augmenting row reduction */
 	for (phase = 0; phase < 2; phase++) {
-		int i;
-		int k = 0;
+		intmax_t i;
+		intmax_t k = 0;
 
 		*saved_free_count = *free_count;
 		*free_count = 0;
 		while (k < *saved_free_count) {
-			int j;
-			int u1, u2;
-			int j1 = 0, j2, i0;
+			intmax_t j;
+			intmax_t u1, u2;
+			intmax_t j1 = 0, j2, i0;
 
 			i = free_row[k++];
 			u1 = COST(j1, i) - v[j1];
 			j2 = -1;
-			u2 = INT_MAX;
+			u2 = INTMAX_MAX;
 			for (j = 1; j < column_count; j++) {
-				int c = COST(j, i) - v[j];
+				intmax_t c = COST(j, i) - v[j];
 				if (u2 > c) {
 					if (u1 < c) {
 						u2 = c;
@@ -137,15 +137,15 @@ static void augmenting_row_reduction(size_t column_count,
 }
 
 static void augmentation(size_t column_count,
-			 int *cost,
-			 int *column2row, int *row2column,
-			 int *free_row, int free_count,
-			 int *v)
+			 intmax_t *cost,
+			 intmax_t *column2row, intmax_t *row2column,
+			 intmax_t *free_row, intmax_t free_count,
+			 intmax_t *v)
 {
-	int i, j;
-	int *d;
-	int *pred, *col;
-	int saved_free_count;
+	intmax_t i, j;
+	intmax_t *d;
+	intmax_t *pred, *col;
+	intmax_t saved_free_count;
 
 	/* augmentation */
 	saved_free_count = free_count;
@@ -153,8 +153,8 @@ static void augmentation(size_t column_count,
 	ALLOC_ARRAY(pred, column_count);
 	ALLOC_ARRAY(col, column_count);
 	for (free_count = 0; free_count < saved_free_count; free_count++) {
-		int i1 = free_row[free_count], low = 0, up = 0, last, k;
-		int min, c, u1;
+		intmax_t i1 = free_row[free_count], low = 0, up = 0, last, k;
+		intmax_t min, c, u1;
 
 		for (j = 0; j < column_count; j++) {
 			d[j] = COST(j, i1) - v[j];
@@ -184,7 +184,7 @@ static void augmentation(size_t column_count,
 
 			/* scan a row */
 			do {
-				int j1 = col[low++];
+				intmax_t j1 = col[low++];
 
 				i = column2row[j1];
 				u1 = COST(j1, i) - v[j1] - min;
@@ -208,14 +208,14 @@ static void augmentation(size_t column_count,
 update:
 		/* updating of the column pieces */
 		for (k = 0; k < last; k++) {
-			int j1 = col[k];
+			intmax_t j1 = col[k];
 			v[j1] += d[j1] - min;
 		}
 
 		/* augmentation */
 		do {
 			if (j < 0)
-				BUG("negative j: %d", j);
+				BUG("negative j: %"PRIuMAX, j);
 			i = pred[j];
 			column2row[j] = i;
 			SWAP(j, row2column[i]);
@@ -232,15 +232,15 @@ static void augmentation(size_t column_count,
  * i is `cost[j + column_count * i].
  */
 void compute_assignment(size_t column_count, size_t row_count,
-			int *cost,
-			int *column2row, int *row2column)
+			intmax_t *cost,
+			intmax_t *column2row, intmax_t *row2column)
 {
-	int *v;
-	int *free_row, free_count = 0, saved_free_count;
+	intmax_t *v;
+	intmax_t *free_row, free_count = 0, saved_free_count;
 
 	assert(column_count > 1);
-	memset(column2row, -1, sizeof(int) * column_count);
-	memset(row2column, -1, sizeof(int) * row_count);
+	memset(column2row, -1, sizeof(intmax_t) * column_count);
+	memset(row2column, -1, sizeof(intmax_t) * row_count);
 	ALLOC_ARRAY(v, column_count);
 
 	columns_reduction(column_count, row_count, cost, column2row,
diff --git a/linear-assignment.h b/linear-assignment.h
index 9ff055baac1..ee2726a7c8b 100644
--- a/linear-assignment.h
+++ b/linear-assignment.h
@@ -14,10 +14,6 @@
  * row_count).
  */
 void compute_assignment(size_t column_count, size_t row_count,
-			int *cost,
-			int *column2row, int *row2column);
-
-/* The maximal cost in the cost matrix (to prevent integer overflows). */
-#define COST_MAX (1<<16)
-
+			intmax_t *cost,
+			intmax_t *column2row, intmax_t *row2column);
 #endif
diff --git a/range-diff.c b/range-diff.c
index b0ccb46ff4c..3442ebdd65c 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -302,20 +302,21 @@ static int diffsize(const char *a, const char *b)
 		return count;
 
 	error(_("failed to generate diff"));
-	return COST_MAX;
+	return INT_MAX;
 }
 
 static void get_correspondences(struct string_list *a, struct string_list *b,
 				int creation_factor)
 {
 	size_t n = st_add(a->nr, b->nr);
-	int *cost, c, *a2b, *b2a;
+	intmax_t *cost, c, *a2b, *b2a;
 	size_t i, j;
 
 	CALLOC_ARRAY(cost, st_mult(n, n));
 	CALLOC_ARRAY(a2b, n);
 	CALLOC_ARRAY(b2a, n);
 
+
 	for (i = 0; i < a->nr; i++) {
 		struct patch_util *a_util = a->items[i].util;
 
@@ -327,12 +328,12 @@ static void get_correspondences(struct string_list *a, struct string_list *b,
 			else if (a_util->matching < 0 && b_util->matching < 0)
 				c = diffsize(a_util->diff, b_util->diff);
 			else
-				c = COST_MAX;
+				c = INT_MAX;
 			cost[i + n * j] = c;
 		}
 
 		c = a_util->matching < 0 ?
-			a_util->diffsize * creation_factor / 100 : COST_MAX;
+			a_util->diffsize * creation_factor / 100 : INT_MAX;
 		for (j = b->nr; j < n; j++)
 			cost[i + n * j] = c;
 	}
@@ -341,7 +342,7 @@ static void get_correspondences(struct string_list *a, struct string_list *b,
 		struct patch_util *util = b->items[j].util;
 
 		c = util->matching < 0 ?
-			util->diffsize * creation_factor / 100 : COST_MAX;
+			util->diffsize * creation_factor / 100 : INT_MAX;
 		for (i = a->nr; i < n; i++)
 			cost[i + n * j] = c;
 	}
-- 
2.34.1.930.g0f9292b224d

