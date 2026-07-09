Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6CB3F86EA
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 12:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783598918; cv=none; b=ankuQT2U1GVhXYOeJtiFFcLtRk/QCMg645uLXMGuvBVkZPPu2QImeMFC2cz7GOkTAyUXncUaAoJ6kqmicdKPRqcFcI7tlT81H5DuwVYFPqeM2bXX9iqB712wu3SwzIVTm2lg35P+dmIxpBk2VaXmlXWfx0nrRD8NhNICSpxr2ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783598918; c=relaxed/simple;
	bh=nYoYTtABMtjs0xsuVwSwqsOm5SRY3iGBfmEDgmWTMVM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oUQRDQhe/0CYdE+o8lNmLnem5vFsXeZRq8z97VYHAug74Haurm2ooqZ2cLVJRVXG0+y09YxHZS4Mp2zks3Z3REhBilK4minpXkLHlHjJswGDDHUPe5nakgg+5+Z2VPwl1eSQCJIdcVaI/JyrwWohO9osxkgiGxAAtAiDuH0+Y38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMqC+jXc; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMqC+jXc"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e5d50b0dbso106580185a.1
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 05:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783598916; x=1784203716; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YVFQVE+OBL5oc1x8+MQ+mf9ZzGxfAtfmtji57DdxhD4=;
        b=iMqC+jXc7g5fWFN8nW8grNvWrIsb4sq5XkoIQoccekZyRGXenweWEam2kUmadeCilp
         XTCnG68E/+Ge1rytIJ5knC1yOFySqsID5DjArWSjEmX6S3jjechvL22+9eKOG5ZMq1aU
         +diCCkEWCCZE7h/6PJttnlmeFmXCHF71KSrQRtdE39S98cz3JT85osW1qzXaZ2jZAgWq
         G3C4pv52hfTUmFgXTmXmANhySPUoAgvZZ3JkDVXidVqlU1eAt50tw8I9qQ+m7err5NpE
         pvAGl0NORvaEc5MczwPPu3DI+VcRjYkwRLmxHrWK1uQRfjbHo5Bm3vhjhfwQbkYDC1QK
         rxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783598916; x=1784203716;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YVFQVE+OBL5oc1x8+MQ+mf9ZzGxfAtfmtji57DdxhD4=;
        b=QyE/WrdZ1ti8RQKGwPk0/czvi7Gxqh8BgGkT6mQ55igtf1bbgc690Zmal/HcnKjiX9
         buH6iuHGhu4ppt9jj0ERUGXWjzfca7w3raNGcwctdIPFBtjLn7gWxmjsUYRZf+OQNGDz
         nYPNN9EPFQiHMsFRLQa3d3VRn859xeiU9eXFo74DZl6Ily+xmAd4gSrvbbjvfmArIhwP
         jm5ZExVUaH0K+tbjLoLeQs6bza05Nf5TbvpMhFfZpNKdNVNQqmY+cvIbvzrT5osQxUmE
         88yx9BXM3zbbR3yedlskOd6s2nKAtUnqLMr+uCw/EriAJZS+Me9Jh0vBdsYieJ4DkODK
         9Myg==
X-Gm-Message-State: AOJu0Yzimgkhj88PeFkkKB10kEAL8jyR9v2IiHP+mH6uQjYg/NicrE7d
	8aLUXWgpCtW7qNh94wSQQ9pFfp9+V2yi7iFgC8tGK/f6ci1TiH82uDHngKwRWWZZ
X-Gm-Gg: AfdE7ckpxFQsPA9Si0CUzxjUhpIEYbEaxlnhzdDxEJOeAZBKETPvhTvv2GSG+1VPqfD
	gZK7RLZfBgyYvarNvNFok+GrlThYHYFNkk7knjSUWcieSSowhhLhu++iAPLaVuo9T0L1grDNjam
	FpW+HWUlEO/HgFY6xNOEHmqcVvYBCTowUPuuiK3B2HQNIY+TU0xJJhMxIEyzqnXbmV+xDmxFv8f
	81kNMQaH+Gz0P+ZNa/IUilIGn6L5j01s7OXyIE3+q/XJQ28wFQBLnFU3M4T1VU0OfS4DAPOlgoe
	SwE5kJyiA+I965WVpZqQ/cp79Soq78+Ln/zbeK0iFxEQe4n6OwaHlhrluf1YMAyqLKzlDEYDK0g
	jwzwWf1mwYAB58HE6SP9H/wG43qreLq/X2tDUC24nxckcc3oQJQ0tFsjtskAhYpzEuRwIsZtD+L
	b6iqtvw8eoAVXLPw==
X-Received: by 2002:a05:620a:2855:b0:92e:7a2e:fff2 with SMTP id af79cd13be357-92ecf6c6ff4mr718499485a.48.1783598915555;
        Thu, 09 Jul 2026 05:08:35 -0700 (PDT)
Received: from [127.0.0.1] ([40.79.247.66])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90ce5126sm1641674185a.41.2026.07.09.05.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 05:08:35 -0700 (PDT)
Message-Id: <c13f15ddc20f721443fa1d462ea1b7c2356fbffc.1783598912.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2166.v2.git.1783598912.gitgitgadget@gmail.com>
References: <pull.2166.git.1783344957.gitgitgadget@gmail.com>
	<pull.2166.v2.git.1783598912.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 12:08:31 +0000
Subject: [PATCH v2 2/2] reftable: fix quadratic behavior in the presence of
 tombstones
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

When many tombstones are present in a reftable, operations that need
to look up or iterate over refs exhibit quadratic behavior.  With
8000 refs deleted and re-created, update-ref takes ~15s, quadrupling
for each doubling of input size.

The root cause is the merged iterator's suppress_deletions flag.
When set, merged_iter_next_void() silently consumes tombstone records
in a tight internal loop before returning to the caller.  This
prevents higher-level code from checking iteration bounds (such as
prefix or refname comparisons) until after all tombstones have been
scanned.

This affects any code path that seeks into a range containing
tombstones, including:

 - refs_verify_refnames_available() seeks to "refs/tags/foo-1/" to
   check for D/F conflicts and must scan through all subsequent
   tombstones before the caller can see that they are past the prefix
   of interest.

 - reftable_backend_read_ref() seeks to a specific refname and must
   scan through all subsequent tombstones before returning "not
   found", because the merged iterator skips the matching tombstone
   and searches for the next live record.

Fix this by no longer setting suppress_deletions on the stack's
merged table and instead handling deletion records at each call site
in the reftable backend, where prefix and refname bounds are
available.  Tombstones are now returned to callers, which skip them
after their existing bounds checks.  This allows iteration to
terminate as soon as a tombstone past the relevant bound is
encountered.

The suppress_deletions flag and its logic in the merged iterator are
retained for downstream users of the reftable library (e.g. libgit2).

This also requires adding deletion checks to the log iteration paths,
since suppress_deletions applied to both ref and log iterators.

Both tests in p1401 go from ~14s to ~0.2s with this change.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 refs/reftable-backend.c | 54 ++++++++++++++++++++++++++++++++---------
 reftable/stack.c        |  1 -
 2 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 212408c769..028f0211af 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -84,7 +84,8 @@ static int reftable_backend_read_ref(struct reftable_backend *be,
 	if (ret)
 		goto done;
 
-	if (strcmp(ref.refname, refname)) {
+	if (strcmp(ref.refname, refname) ||
+	    reftable_ref_record_is_deletion(&ref)) {
 		ret = 1;
 		goto done;
 	}
@@ -110,7 +111,6 @@ static int reftable_backend_read_ref(struct reftable_backend *be,
 		oidread(oid, reftable_ref_record_val1(&ref),
 			&hash_algos[hash_id]);
 	} else {
-		/* We got a tombstone, which should not happen. */
 		BUG("unhandled reference value type %d", ref.value_type);
 	}
 
@@ -652,6 +652,9 @@ static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
 			break;
 		}
 
+		if (iter->ref.value_type == REFTABLE_REF_DELETION)
+			continue;
+
 		if (iter->exclude_patterns && should_exclude_current_ref(iter))
 			continue;
 
@@ -1532,6 +1535,8 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 					ret = 0;
 					break;
 				}
+				if (reftable_log_record_is_deletion(&log))
+					continue;
 
 				ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
 				tombstone = &logs[logs_nr++];
@@ -1929,6 +1934,8 @@ static int write_copy_table(struct reftable_writer *writer, void *cb_data)
 			ret = 0;
 			break;
 		}
+		if (reftable_log_record_is_deletion(&old_log))
+			continue;
 
 		free(old_log.refname);
 
@@ -2061,6 +2068,9 @@ static int reftable_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 		if (iter->err)
 			break;
 
+		if (reftable_log_record_is_deletion(&iter->log))
+			continue;
+
 		/*
 		 * We want the refnames that we have reflogs for, so we skip if
 		 * we've already produced this name. This could be faster by
@@ -2220,6 +2230,8 @@ static int reftable_be_for_each_reflog_ent_reverse(struct ref_store *ref_store,
 			ret = 0;
 			break;
 		}
+		if (reftable_log_record_is_deletion(&log))
+			continue;
 
 		ret = yield_log_record(refs, &log, fn, cb_data);
 		if (ret)
@@ -2272,6 +2284,10 @@ static int reftable_be_for_each_reflog_ent(struct ref_store *ref_store,
 			ret = 0;
 			break;
 		}
+		if (reftable_log_record_is_deletion(&log)) {
+			reftable_log_record_release(&log);
+			continue;
+		}
 
 		ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
 		logs[logs_nr++] = log;
@@ -2318,18 +2334,26 @@ static int reftable_be_reflog_exists(struct ref_store *ref_store,
 		goto done;
 
 	/*
-	 * Check whether we get at least one log record for the given ref name.
-	 * If so, the reflog exists, otherwise it doesn't.
+	 * Check whether we get at least one non-deleted log record for the
+	 * given ref name.  If so, the reflog exists, otherwise it doesn't.
 	 */
-	ret = reftable_iterator_next_log(&it, &log);
-	if (ret < 0)
-		goto done;
-	if (ret > 0) {
-		ret = 0;
-		goto done;
+	while (1) {
+		ret = reftable_iterator_next_log(&it, &log);
+		if (ret < 0)
+			goto done;
+		if (ret > 0) {
+			ret = 0;
+			goto done;
+		}
+		if (strcmp(log.refname, refname)) {
+			ret = 0;
+			goto done;
+		}
+		if (!reftable_log_record_is_deletion(&log))
+			break;
 	}
 
-	ret = strcmp(log.refname, refname) == 0;
+	ret = 1;
 
 done:
 	reftable_iterator_destroy(&it);
@@ -2442,6 +2466,8 @@ static int write_reflog_delete_table(struct reftable_writer *writer, void *cb_da
 			ret = 0;
 			break;
 		}
+		if (reftable_log_record_is_deletion(&log))
+			continue;
 
 		tombstone.refname = (char *)arg->refname;
 		tombstone.value_type = REFTABLE_LOG_DELETION;
@@ -2625,6 +2651,10 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 			reftable_log_record_release(&log);
 			break;
 		}
+		if (reftable_log_record_is_deletion(&log)) {
+			reftable_log_record_release(&log);
+			continue;
+		}
 
 		oidread(&old_oid, log.value.update.old_hash,
 			ref_store->repo->hash_algo);
@@ -2791,6 +2821,8 @@ static int reftable_be_fsck(struct ref_store *ref_store, struct fsck_options *o,
 		report.path = refname.buf;
 
 		switch (ref.value_type) {
+		case REFTABLE_REF_DELETION:
+			continue;
 		case REFTABLE_REF_VAL1:
 		case REFTABLE_REF_VAL2: {
 			struct object_id oid;
diff --git a/reftable/stack.c b/reftable/stack.c
index ab12926708..fd7d8f3f1e 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -337,7 +337,6 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 	/* Update the stack to point to the new tables. */
 	if (st->merged)
 		reftable_merged_table_free(st->merged);
-	new_merged->suppress_deletions = 1;
 	st->merged = new_merged;
 
 	if (st->tables)
-- 
gitgitgadget
