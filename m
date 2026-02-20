Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869511E9B12
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 08:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771575879; cv=none; b=PDQPWZ0hLrcnqWcauMc7K2t8wwjRIa87EGClZtulUugujsoYabnIj18HV+jtToOwWRlIUsQ3HIj0fYysbijHVOlscP2hchwfyOVl2rQzdqDgFPuJ3FVvuocf9ezmQcA3L1s6/Kfl6yJ5GJhZFshmWa3h8qJmfwcgppqWQ0Ylg4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771575879; c=relaxed/simple;
	bh=Dlh1KrNadICSlErIZLhhkokqTTMFxadHmgAI/UwyyHY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mWaaYlo9Bg2xm24oBRC624TCTj4ldhdeUbdcDkkhpYYfwVRVt6Oj8VXGfDNhpz7sTPn27gzkwbbj86ougSsn/JVOUdTIrTKKKmRLIB3NBQXzjt8FVuh3IL/Cmhbz40/lRY9gEAaSGnURt/qdLOKOjueY1GVxE+Ww/9+dBfvIFQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gAdVb3i2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zd8OpnLC; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gAdVb3i2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zd8OpnLC"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8E2B67A0174;
	Fri, 20 Feb 2026 03:24:36 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 20 Feb 2026 03:24:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771575876;
	 x=1771662276; bh=6FTr1aRuJsb+iGzvDNX55Eq+gZQ25Qxl2IEClFeH+fk=; b=
	gAdVb3i2eL5lmz/RyIbf+KhxrYZj7spUowqGhce0+7krrLRn7kHImW70GDJP60CN
	CUBpl8k8X11o+RvLF+4ZbzCxoy5AyDQg0xGS4IYgZTwlBcq0nVCXs1fcw/h/c+Mw
	WjNUx+HJ4Wev38dtWw8WtC4yKlLwLzrK0wAHm1wg5g/eNlD1GAqZnhexwD5JaPdm
	enyhDdegZyrlBLOm1T0uafTHdFW6ekljYfBeJOsYNAX6/2P0vcwbmhoVvlXcJt92
	WpHtT6V9XNHBm8LfVxx+C4Fy5r/nNAs2+oix7GjQMAw3e9/U6yeV+tGPfmE5c6Jn
	Ka2L7uMPB2HrBgFzqRuaGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771575876; x=
	1771662276; bh=6FTr1aRuJsb+iGzvDNX55Eq+gZQ25Qxl2IEClFeH+fk=; b=Z
	d8OpnLCSBm6KBW1BuPm/Rk5sVVjhONwgR+7bQH4aTi3e2DYBDgNNdPzHhIiWypb4
	bzrJMbF+pIqY1ByhGFpJ5UcLW9RIvkIh9HdqeAHqLRPRkjUh3XROOUAu5KAlyvSj
	7zRGiJiGWU7J1hG40RLHomyaGsxFkNqa2pVHcajCfvokY2cMf7ClGPsV+TpdS8HQ
	OXQQz6VZpoEjAbl5UzvQx144P7sOJ97F+CVTzn/3XcKQRnzTcttZ+nd28NjkbJfy
	RkXfvutm+udpFkax3UfJfJaADLgcrhfgrV0/FlZJNP9kJ4O55v36oden+MTJ3GL4
	TI4w+4tJjXcbaxVaLYSJQ==
X-ME-Sender: <xms:RBqYaZNZbhZhCSu3KeciVCVh2cngM7iRg-xf3f7Mcve7FREp7mJo2w>
    <xme:RBqYaR_VjZf0yyjX5KrCr7E8e5WTn1MXBj8HXuFOkkIWpL95r3AzamkIq5V5Xx3pC
    HLS3H2jVxstx0J_v7EfW3IuHUgd5CE6N2VbT4S52uXfukLTcCG49Nw>
X-ME-Received: <xmr:RBqYaV6OuoNFFw1Rhgimv2Ls_z_rmWsrn6sk6eDT79TOeL1-FgIuN-1P_cP2FvEjoPrJaY6PGLhvnHbRXmMTR9sS8cvD3Rt3dUoNROKr1sWj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdejleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RBqYaQ1b2Zyegru7gbi1AlnJKATNwJFPU9PmYVEwhR9i2kp3L36vgQ>
    <xmx:RBqYaUDwGzAGnZ6WT7P0hzVZyAqZkTYdiPGKI-7iB67V7y36ExDx6Q>
    <xmx:RBqYaa22Vi7tBHAcKfBW7h4Eooo39JTmMWr6wIpyNeyYdGYSn3q9mQ>
    <xmx:RBqYaWvoG-wt69WMJ5sPlKypjIg99G83RDp9DLUdGkG-boNxLi4XyQ>
    <xmx:RBqYab91TU1QU6odSwcVuzKhXZzdpjG4c-nRvRGNhh5SDOvSY7Gn6vaK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 03:24:35 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 279ae453 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 08:24:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Feb 2026 09:24:08 +0100
Subject: [PATCH 04/17] refs: rename `each_ref_fn`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-pks-refs-for-each-unification-v1-4-17170bd99de1@pks.im>
References: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
In-Reply-To: <20260220-pks-refs-for-each-unification-v1-0-17170bd99de1@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Similar to the preceding commit, rename `each_ref_fn` to better match
our current best practices around how we name things.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pack-bitmap.c   |  2 +-
 pack-bitmap.h   |  2 +-
 ref-filter.c    |  6 +++---
 refs.c          | 36 ++++++++++++++++++------------------
 refs.h          | 40 ++++++++++++++++++++--------------------
 refs/iterator.c |  2 +-
 revision.c      |  8 ++++----
 submodule.c     |  2 +-
 upload-pack.c   |  2 +-
 worktree.c      |  2 +-
 worktree.h      |  2 +-
 11 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 1c93871484..efef7081e6 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -3324,7 +3324,7 @@ static const struct string_list *bitmap_preferred_tips(struct repository *r)
 }
 
 void for_each_preferred_bitmap_tip(struct repository *repo,
-				   each_ref_fn cb, void *cb_data)
+				   refs_for_each_cb cb, void *cb_data)
 {
 	struct string_list_item *item;
 	const struct string_list *preferred_tips;
diff --git a/pack-bitmap.h b/pack-bitmap.h
index d0611d0481..a95e1c2d11 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -105,7 +105,7 @@ int for_each_bitmapped_object(struct bitmap_index *bitmap_git,
  * "pack.preferBitmapTips" and invoke the callback on each function.
  */
 void for_each_preferred_bitmap_tip(struct repository *repo,
-				   each_ref_fn cb, void *cb_data);
+				   refs_for_each_cb cb, void *cb_data);
 
 #define GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL \
 	"GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL"
diff --git a/ref-filter.c b/ref-filter.c
index 4bc54ebd9d..049e845a19 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2781,7 +2781,7 @@ static int start_ref_iterator_after(struct ref_iterator *iter, const char *marke
 	return ret;
 }
 
-static int for_each_fullref_with_seek(struct ref_filter *filter, each_ref_fn cb,
+static int for_each_fullref_with_seek(struct ref_filter *filter, refs_for_each_cb cb,
 				       void *cb_data, unsigned int flags)
 {
 	struct ref_iterator *iter;
@@ -2804,7 +2804,7 @@ static int for_each_fullref_with_seek(struct ref_filter *filter, each_ref_fn cb,
  * pattern match, so the callback still has to match each ref individually.
  */
 static int for_each_fullref_in_pattern(struct ref_filter *filter,
-				       each_ref_fn cb,
+				       refs_for_each_cb cb,
 				       void *cb_data)
 {
 	if (filter->kind & FILTER_REFS_ROOT_REFS) {
@@ -3303,7 +3303,7 @@ void filter_is_base(struct repository *r,
 	free(bases);
 }
 
-static int do_filter_refs(struct ref_filter *filter, unsigned int type, each_ref_fn fn, void *cb_data)
+static int do_filter_refs(struct ref_filter *filter, unsigned int type, refs_for_each_cb fn, void *cb_data)
 {
 	const char *prefix = NULL;
 	int ret = 0;
diff --git a/refs.c b/refs.c
index 0cad3b4759..e9ac0a7101 100644
--- a/refs.c
+++ b/refs.c
@@ -445,7 +445,7 @@ char *refs_resolve_refdup(struct ref_store *refs,
 struct for_each_ref_filter {
 	const char *pattern;
 	const char *prefix;
-	each_ref_fn *fn;
+	refs_for_each_cb *fn;
 	void *cb_data;
 };
 
@@ -527,22 +527,22 @@ void refs_warn_dangling_symrefs(struct ref_store *refs, FILE *fp,
 	refs_for_each_rawref(refs, warn_if_dangling_symref, &data);
 }
 
-int refs_for_each_tag_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
+int refs_for_each_tag_ref(struct ref_store *refs, refs_for_each_cb fn, void *cb_data)
 {
 	return refs_for_each_ref_in(refs, "refs/tags/", fn, cb_data);
 }
 
-int refs_for_each_branch_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
+int refs_for_each_branch_ref(struct ref_store *refs, refs_for_each_cb fn, void *cb_data)
 {
 	return refs_for_each_ref_in(refs, "refs/heads/", fn, cb_data);
 }
 
-int refs_for_each_remote_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
+int refs_for_each_remote_ref(struct ref_store *refs, refs_for_each_cb fn, void *cb_data)
 {
 	return refs_for_each_ref_in(refs, "refs/remotes/", fn, cb_data);
 }
 
-int refs_head_ref_namespaced(struct ref_store *refs, each_ref_fn fn, void *cb_data)
+int refs_head_ref_namespaced(struct ref_store *refs, refs_for_each_cb fn, void *cb_data)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int ret = 0;
@@ -590,7 +590,7 @@ void normalize_glob_ref(struct string_list_item *item, const char *prefix,
 	strbuf_release(&normalized_pattern);
 }
 
-int refs_for_each_glob_ref_in(struct ref_store *refs, each_ref_fn fn,
+int refs_for_each_glob_ref_in(struct ref_store *refs, refs_for_each_cb fn,
 			      const char *pattern, const char *prefix, void *cb_data)
 {
 	struct strbuf real_pattern = STRBUF_INIT;
@@ -620,7 +620,7 @@ int refs_for_each_glob_ref_in(struct ref_store *refs, each_ref_fn fn,
 	return ret;
 }
 
-int refs_for_each_glob_ref(struct ref_store *refs, each_ref_fn fn,
+int refs_for_each_glob_ref(struct ref_store *refs, refs_for_each_cb fn,
 			   const char *pattern, void *cb_data)
 {
 	return refs_for_each_glob_ref_in(refs, fn, pattern, NULL, cb_data);
@@ -1788,7 +1788,7 @@ const char *find_descendant_ref(const char *dirname,
 	return NULL;
 }
 
-int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
+int refs_head_ref(struct ref_store *refs, refs_for_each_cb fn, void *cb_data)
 {
 	struct object_id oid;
 	int flag;
@@ -1860,7 +1860,7 @@ struct ref_iterator *refs_ref_iterator_begin(
 
 static int do_for_each_ref(struct ref_store *refs, const char *prefix,
 			   const char **exclude_patterns,
-			   each_ref_fn fn, int trim,
+			   refs_for_each_cb fn, int trim,
 			   enum refs_for_each_flag flags, void *cb_data)
 {
 	struct ref_iterator *iter;
@@ -1874,25 +1874,25 @@ static int do_for_each_ref(struct ref_store *refs, const char *prefix,
 	return do_for_each_ref_iterator(iter, fn, cb_data);
 }
 
-int refs_for_each_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
+int refs_for_each_ref(struct ref_store *refs, refs_for_each_cb fn, void *cb_data)
 {
 	return do_for_each_ref(refs, "", NULL, fn, 0, 0, cb_data);
 }
 
 int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
-			 each_ref_fn fn, void *cb_data)
+			 refs_for_each_cb fn, void *cb_data)
 {
 	return do_for_each_ref(refs, prefix, NULL, fn, strlen(prefix), 0, cb_data);
 }
 
 int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
 			     const char **exclude_patterns,
-			     each_ref_fn fn, void *cb_data)
+			     refs_for_each_cb fn, void *cb_data)
 {
 	return do_for_each_ref(refs, prefix, exclude_patterns, fn, 0, 0, cb_data);
 }
 
-int refs_for_each_replace_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
+int refs_for_each_replace_ref(struct ref_store *refs, refs_for_each_cb fn, void *cb_data)
 {
 	const char *git_replace_ref_base = ref_namespace[NAMESPACE_REPLACE].ref;
 	return do_for_each_ref(refs, git_replace_ref_base, NULL, fn,
@@ -1902,7 +1902,7 @@ int refs_for_each_replace_ref(struct ref_store *refs, each_ref_fn fn, void *cb_d
 
 int refs_for_each_namespaced_ref(struct ref_store *refs,
 				 const char **exclude_patterns,
-				 each_ref_fn fn, void *cb_data)
+				 refs_for_each_cb fn, void *cb_data)
 {
 	struct strvec namespaced_exclude_patterns = STRVEC_INIT;
 	struct strbuf prefix = STRBUF_INIT;
@@ -1920,19 +1920,19 @@ int refs_for_each_namespaced_ref(struct ref_store *refs,
 	return ret;
 }
 
-int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
+int refs_for_each_rawref(struct ref_store *refs, refs_for_each_cb fn, void *cb_data)
 {
 	return refs_for_each_rawref_in(refs, "", fn, cb_data);
 }
 
 int refs_for_each_rawref_in(struct ref_store *refs, const char *prefix,
-			    each_ref_fn fn, void *cb_data)
+			    refs_for_each_cb fn, void *cb_data)
 {
 	return do_for_each_ref(refs, prefix, NULL, fn, 0,
 			       REFS_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
-int refs_for_each_include_root_refs(struct ref_store *refs, each_ref_fn fn,
+int refs_for_each_include_root_refs(struct ref_store *refs, refs_for_each_cb fn,
 				    void *cb_data)
 {
 	return do_for_each_ref(refs, "", NULL, fn, 0,
@@ -2001,7 +2001,7 @@ int refs_for_each_fullref_in_prefixes(struct ref_store *ref_store,
 				      const char *namespace,
 				      const char **patterns,
 				      const char **exclude_patterns,
-				      each_ref_fn fn, void *cb_data)
+				      refs_for_each_cb fn, void *cb_data)
 {
 	struct strvec namespaced_exclude_patterns = STRVEC_INIT;
 	struct string_list prefixes = STRING_LIST_INIT_DUP;
diff --git a/refs.h b/refs.h
index 8ac1ef7a8b..e37574009b 100644
--- a/refs.h
+++ b/refs.h
@@ -170,7 +170,7 @@ int ref_store_remove_on_disk(struct ref_store *refs, struct strbuf *err);
  *
  *   peel_object(r, oid, &peeled);
  *
- * with the "oid" value given to the each_ref_fn callback, except
+ * with the "oid" value given to the refs_for_each_cb callback, except
  * that some ref storage may be able to answer the query without
  * actually loading the object in memory.
  */
@@ -329,7 +329,7 @@ int check_tag_ref(struct strbuf *sb, const char *name);
 struct ref_transaction;
 
 /*
- * Bit values set in the flags argument passed to each_ref_fn() and
+ * Bit values set in the flags argument passed to refs_for_each_cb() and
  * stored in ref_iterator::flags. Other bits are for internal use
  * only:
  */
@@ -400,7 +400,7 @@ int reference_get_peeled_oid(struct repository *repo,
  * argument is only guaranteed to be valid for the duration of a
  * single callback invocation.
  */
-typedef int each_ref_fn(const struct reference *ref, void *cb_data);
+typedef int refs_for_each_cb(const struct reference *ref, void *cb_data);
 
 /*
  * These flags are passed to refs_ref_iterator_begin() (and do_for_each_ref(),
@@ -449,22 +449,22 @@ enum refs_for_each_flag {
  * stop the iteration. Returned references are sorted.
  */
 int refs_head_ref(struct ref_store *refs,
-		  each_ref_fn fn, void *cb_data);
+		  refs_for_each_cb fn, void *cb_data);
 int refs_head_ref_namespaced(struct ref_store *refs,
-			     each_ref_fn fn, void *cb_data);
+			     refs_for_each_cb fn, void *cb_data);
 
 int refs_for_each_ref(struct ref_store *refs,
-		      each_ref_fn fn, void *cb_data);
+		      refs_for_each_cb fn, void *cb_data);
 int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
-			 each_ref_fn fn, void *cb_data);
+			 refs_for_each_cb fn, void *cb_data);
 int refs_for_each_tag_ref(struct ref_store *refs,
-			  each_ref_fn fn, void *cb_data);
+			  refs_for_each_cb fn, void *cb_data);
 int refs_for_each_branch_ref(struct ref_store *refs,
-			     each_ref_fn fn, void *cb_data);
+			     refs_for_each_cb fn, void *cb_data);
 int refs_for_each_remote_ref(struct ref_store *refs,
-			     each_ref_fn fn, void *cb_data);
+			     refs_for_each_cb fn, void *cb_data);
 int refs_for_each_replace_ref(struct ref_store *refs,
-			      each_ref_fn fn, void *cb_data);
+			      refs_for_each_cb fn, void *cb_data);
 
 /*
  * references matching any pattern in "exclude_patterns" are omitted from the
@@ -472,7 +472,7 @@ int refs_for_each_replace_ref(struct ref_store *refs,
  */
 int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
 			     const char **exclude_patterns,
-			     each_ref_fn fn, void *cb_data);
+			     refs_for_each_cb fn, void *cb_data);
 
 /**
  * iterate all refs in "patterns" by partitioning patterns into disjoint sets
@@ -487,13 +487,13 @@ int refs_for_each_fullref_in_prefixes(struct ref_store *refs,
 				      const char *namespace,
 				      const char **patterns,
 				      const char **exclude_patterns,
-				      each_ref_fn fn, void *cb_data);
+				      refs_for_each_cb fn, void *cb_data);
 
 /* iterates all refs that match the specified glob pattern. */
-int refs_for_each_glob_ref(struct ref_store *refs, each_ref_fn fn,
+int refs_for_each_glob_ref(struct ref_store *refs, refs_for_each_cb fn,
 			   const char *pattern, void *cb_data);
 
-int refs_for_each_glob_ref_in(struct ref_store *refs, each_ref_fn fn,
+int refs_for_each_glob_ref_in(struct ref_store *refs, refs_for_each_cb fn,
 			      const char *pattern, const char *prefix, void *cb_data);
 
 /*
@@ -502,17 +502,17 @@ int refs_for_each_glob_ref_in(struct ref_store *refs, each_ref_fn fn,
  */
 int refs_for_each_namespaced_ref(struct ref_store *refs,
 				 const char **exclude_patterns,
-				 each_ref_fn fn, void *cb_data);
+				 refs_for_each_cb fn, void *cb_data);
 
 /* can be used to learn about broken ref and symref */
-int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data);
+int refs_for_each_rawref(struct ref_store *refs, refs_for_each_cb fn, void *cb_data);
 int refs_for_each_rawref_in(struct ref_store *refs, const char *prefix,
-			    each_ref_fn fn, void *cb_data);
+			    refs_for_each_cb fn, void *cb_data);
 
 /*
  * Iterates over all refs including root refs, i.e. pseudorefs and HEAD.
  */
-int refs_for_each_include_root_refs(struct ref_store *refs, each_ref_fn fn,
+int refs_for_each_include_root_refs(struct ref_store *refs, refs_for_each_cb fn,
 				    void *cb_data);
 
 /*
@@ -1427,6 +1427,6 @@ void ref_iterator_free(struct ref_iterator *ref_iterator);
  * iterator style.
  */
 int do_for_each_ref_iterator(struct ref_iterator *iter,
-			     each_ref_fn fn, void *cb_data);
+			     refs_for_each_cb fn, void *cb_data);
 
 #endif /* REFS_H */
diff --git a/refs/iterator.c b/refs/iterator.c
index d79aa5ec82..d5cacde51b 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -423,7 +423,7 @@ struct ref_iterator *prefix_ref_iterator_begin(struct ref_iterator *iter0,
 }
 
 int do_for_each_ref_iterator(struct ref_iterator *iter,
-			     each_ref_fn fn, void *cb_data)
+			     refs_for_each_cb fn, void *cb_data)
 {
 	int retval = 0, ok;
 
diff --git a/revision.c b/revision.c
index 29972c3a19..8c206830d5 100644
--- a/revision.c
+++ b/revision.c
@@ -1646,7 +1646,7 @@ static void init_all_refs_cb(struct all_refs_cb *cb, struct rev_info *revs,
 
 static void handle_refs(struct ref_store *refs,
 			struct rev_info *revs, unsigned flags,
-			int (*for_each)(struct ref_store *, each_ref_fn, void *))
+			int (*for_each)(struct ref_store *, refs_for_each_cb, void *))
 {
 	struct all_refs_cb cb;
 
@@ -2728,7 +2728,7 @@ void revision_opts_finish(struct rev_info *revs)
 	}
 }
 
-static int for_each_bisect_ref(struct ref_store *refs, each_ref_fn fn,
+static int for_each_bisect_ref(struct ref_store *refs, refs_for_each_cb fn,
 			       void *cb_data, const char *term)
 {
 	struct strbuf bisect_refs = STRBUF_INIT;
@@ -2739,12 +2739,12 @@ static int for_each_bisect_ref(struct ref_store *refs, each_ref_fn fn,
 	return status;
 }
 
-static int for_each_bad_bisect_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
+static int for_each_bad_bisect_ref(struct ref_store *refs, refs_for_each_cb fn, void *cb_data)
 {
 	return for_each_bisect_ref(refs, fn, cb_data, term_bad);
 }
 
-static int for_each_good_bisect_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
+static int for_each_good_bisect_ref(struct ref_store *refs, refs_for_each_cb fn, void *cb_data)
 {
 	return for_each_bisect_ref(refs, fn, cb_data, term_good);
 }
diff --git a/submodule.c b/submodule.c
index 508938e4da..4f9aaa2c75 100644
--- a/submodule.c
+++ b/submodule.c
@@ -101,7 +101,7 @@ int is_staging_gitmodules_ok(struct index_state *istate)
 }
 
 static int for_each_remote_ref_submodule(const char *submodule,
-					 each_ref_fn fn, void *cb_data)
+					 refs_for_each_cb fn, void *cb_data)
 {
 	return refs_for_each_remote_ref(repo_get_submodule_ref_store(the_repository,
 								     submodule),
diff --git a/upload-pack.c b/upload-pack.c
index 2d2b70cbf2..7fe397b0d0 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -607,7 +607,7 @@ static int allow_hidden_refs(enum allow_uor allow_uor)
 	return !(allow_uor & (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1));
 }
 
-static void for_each_namespaced_ref_1(each_ref_fn fn,
+static void for_each_namespaced_ref_1(refs_for_each_cb fn,
 				      struct upload_pack_data *data)
 {
 	const char **excludes = NULL;
diff --git a/worktree.c b/worktree.c
index 9308389cb6..bf8c54c04d 100644
--- a/worktree.c
+++ b/worktree.c
@@ -575,7 +575,7 @@ void strbuf_worktree_ref(const struct worktree *wt,
 	strbuf_addstr(sb, refname);
 }
 
-int other_head_refs(each_ref_fn fn, void *cb_data)
+int other_head_refs(refs_for_each_cb fn, void *cb_data)
 {
 	struct worktree **worktrees, **p;
 	struct strbuf refname = STRBUF_INIT;
diff --git a/worktree.h b/worktree.h
index e4bcccdc0a..12484a91a7 100644
--- a/worktree.h
+++ b/worktree.h
@@ -191,7 +191,7 @@ int is_shared_symref(const struct worktree *wt,
  * Similar to head_ref() for all HEADs _except_ one from the current
  * worktree, which is covered by head_ref().
  */
-int other_head_refs(each_ref_fn fn, void *cb_data);
+int other_head_refs(refs_for_each_cb fn, void *cb_data);
 
 int is_worktree_being_rebased(const struct worktree *wt, const char *target);
 int is_worktree_being_bisected(const struct worktree *wt, const char *target);

-- 
2.53.0.414.gf7e9f6c205.dirty

