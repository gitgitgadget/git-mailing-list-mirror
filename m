Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5909928CF43
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745430012; cv=none; b=nDt9f/81Xf32I7g7959YXz7EVEkPVnSU4OzULtYTR35MxAPG/lGWLn7HAgaFcfuGoqG/ltyTvXjXOlfOJpnMlBYN8FAx1S5a0C0lW3TmuGeohetoJ1SBvjJkbDzYyGUl5MMAtywrj8g/45gr1Qxu+CcWbckIM4CbOGLD1DTQMM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745430012; c=relaxed/simple;
	bh=0OvQcOsCfZ8+q2NkRhTOO5++a3kR6ChnUJNi77NRPEw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=F+bMiKtKzbHw8FpdRBW9/tyH046ppAnFRbrTXl6rdC5RgT+96uRgEyywOG77kMpDBjYNgSM6V51HSRBdoT9p+DpbIHD+hFJfjgpBMiTP1Z6egy+9MT7vBoSNNUm7mRoKviJPm1QsRokwrjfWCsdYx4Xb0tF1w74gug5xRzQrM+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWef28OJ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWef28OJ"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a064a3e143so51702f8f.3
        for <git@vger.kernel.org>; Wed, 23 Apr 2025 10:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745430008; x=1746034808; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JumsPIeOLqwQpQI7yXWfbVCZfe3frK2vYnlhg2Yjv9U=;
        b=FWef28OJjvf0Qq7pwXmm3bywCoC7tWACrvd2uT7fcRSgLdclOFMjWq6nZ6atjPmVWl
         5wugyxoo3VHXgCVPnkGUXI27UyWwmxw+dKNhBTUMSFHC5AsTPk2sPppAC/yEkGCYvWsD
         hYItjkT86P3sdTd1x1AjweDMu6LZu6kZ9sJHt+GgmgxAwg5b8MeqVInoLumphN36ohvm
         4K6cmtS8XIPtAiExHfzq+KUSazhxsS7JpofCmoXC18IZVOwMivRcHDwtDELy+p6DAcFs
         3aEvMqy7bk2odkwPdkbYraoqM/j0nHkxmRf5APqbrbWbeMv07Dy0hplt7tcXOuuPm9kJ
         zESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745430008; x=1746034808;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JumsPIeOLqwQpQI7yXWfbVCZfe3frK2vYnlhg2Yjv9U=;
        b=dHoMtVC29h0X59wHdiRqlPnxBf5lhSOlkroKJc1eylO4A49tSDQTHeJLPmnH1ox2BN
         S6CaNrqxaaLK9kPUI1c/SoDCQ3ZCu7dCZJOJiASkia9SXJ04qWc4NqyCuZ+FqpJPxyTY
         AYV1Uh1h5GoLrvowv0a/2q5rxfFZDdXJmsRh7JePs4d1yotU0+dqdTSMAUU+Pu2e35Kf
         YhO85o38bVJogzsUQlXo3FFssm9Ee69R+rIVzhXOewykvUgQupwvPIjZD2aJz6aCN/kf
         09SxLf78zqzhoRkygnBUT5IIO+ZiSNQDPhd4pgJk+YtDVz59q7Nh9qRUGJ8zvk5TAIp6
         rnsg==
X-Gm-Message-State: AOJu0YzneuInROhYtDMO61X4u+W+H1YeFcu/m76dLeKI9iCWKCEF/ZgI
	W9/6hzVP09u0bClOlVQztfqRHLWb2DGQQMaXmYaeZkkElorEsUgH8xNAyw==
X-Gm-Gg: ASbGnctjc8psnF/moZBxZeKwMzXcwf0q06WlXstXCRPPiH971orl7s4LfyEPGzw/yQa
	BNTsYKme+2LJsrVKqRnH2Hmv/G8FxJO9gJTiL7zVIiPggBmpIZIcEOGGzM7p93RqWqGt4C0a1//
	1ocF4wfv9bSc6sNprDpYx9rMwIHO/xh2xGPRinKnVAGbf1kivsWXEcI4jnDaWe6iby2Hr+mgvDC
	W2UI4HPoGJAyCOEdRIzOCyzdlHLWEjOThRuJj20sjqRVMEYWxGnMniXelwvRaB2Z/7u1T9vowGV
	2c5gw0fVCoXkOHmgRbb+kxQm73cpToCJxi8nayLgbQ==
X-Google-Smtp-Source: AGHT+IEDzGlfvOXRf6GEWWq7VIb/2HoEqf/vRTnuvU07pRkJzVCfc3f+58AbGNADe84aW45abzfQCQ==
X-Received: by 2002:a5d:648c:0:b0:39e:cbca:7156 with SMTP id ffacd0b85a97d-39efba2ab70mr17451129f8f.1.1745430008110;
        Wed, 23 Apr 2025 10:40:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa493446sm19456725f8f.74.2025.04.23.10.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:40:07 -0700 (PDT)
Message-Id: <27d36402fe9c8262c459d606bf4aace1919aa2ae.1745430004.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1906.git.1745430004.gitgitgadget@gmail.com>
References: <pull.1906.git.1745430004.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 23 Apr 2025 17:40:04 +0000
Subject: [PATCH 3/3] index-pack: allow revisiting REF_DELTA chains
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
Cc: gitster@pobox.com,
    peff@peff.net,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

As detailed in the previous changes to t5309-pack-delta-cycles.sh, the
logic within 'git index-pack' to analyze an incoming thin packfile with
REF_DELTAs is suspect. The algorithm is overly cautious around delta
cycles, and that leads in fact to failing even when there is no cycle.

This change adjusts the algorithm to no longer fail in these cases. In
fact, these cycle cases will no longer fail but more importantly the
valid cases will no longer fail, either. The resulting packfile from the
--fix-thin operation will not have cycles either since REF_DELTAs are
forbidden from the on-disk format and OFS_DELTAs are impossible to write
as a cycle.

The crux of the matter is how the algorithm works when the REF_DELTAs
point to base objects that exist in the local repository. When reading
the thin packfile, the object IDs for the delta objects are unknown so
we do not have the delta chain structure automatically. Instead, we need
to start somewhere by selecting a delta whose base is inside our current
object database.

Consider the case where the packfile has two REF_DELTA objects, A and B,
and the delta chain looks like "A depends on B" and "B depends on C" for
some third object C, where C is already in the current repository. The
algorithm _should_ start with all objects that depend on C, finding B,
and then moving on to all objects depending on B, finding A.

However, if the repository also already has object B, then the delta
chain can be analyzed in a different order. The deltas with base B can
be analyzed first, finding A, and then the deltas with base C are
analyzed, finding B. The algorithm currently continues to look for
objects that depend on B, finding A again. This fails due to A's
'real_type' member already being overwritten from OBJ_REF_DELTA to the
correct object type.

This scenario is possible in a typical 'git fetch' where the client does
not advertise B as a 'have' but requests A as a 'want' (and C is noticed
as a common object based on other 'have's). The reason this isn't
typically seen is that most Git servers use OFS_DELTAs to represent
deltas within a packfile. However, if a server uses only REF_DELTAs,
then this kind of issue can occur. There is nothing in the explicit
packfile format that states this use of inter-pack REF_DELTA is
incorrect, only that REF_DELTAs should not be used in the on-disk
representation to avoid cycles.

This die() was introduced in ab791dd138 (index-pack: fix race condition
with duplicate bases, 2014-08-29). Several refactors have adjusted the
error message and the surrounding logic, but this issue has existed for
a longer time as that was only a conversion from an assert().

The tests in t5309 originated in 3b910d0c5e (add tests for indexing
packs with delta cycles, 2013-08-23) and b2ef3d9ebb (test index-pack on
packs with recoverable delta cycles, 2013-08-23). These changes make
note that the current behavior of handling "resolvable" cycles is mostly
a documentation-only test, not that this behavior is the best way for
Git to handle the situation.

The fix here is somewhat complicated due to the amount of state being
adjusted by the loop within threaded_second_pass(). Instead of trying to
resume the start of the loop while adjusting the necessary context, I
chose to scan the REF_DELTAs depending on the current 'parent' and skip
any that have already been processed. This necessarily leaves us in a
state where 'child' and 'child_obj' could be left as NULL and that must
be handled later. There is also some careful handling around skipping
REF_DELTAs when there are also OFS_DELTAs depending on that parent.
There may be value in extending 'test-tool pack-deltas' to allow writing
OFS_DELTAs in order to exercise this logic across the delta types.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/index-pack.c         | 58 ++++++++++++++++++++----------------
 t/t5309-pack-delta-cycles.sh | 12 ++++++--
 2 files changed, 41 insertions(+), 29 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index de127c0ff13..dbe79701fb8 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1109,8 +1109,8 @@ static void *threaded_second_pass(void *data)
 		set_thread_data(data);
 	for (;;) {
 		struct base_data *parent = NULL;
-		struct object_entry *child_obj;
-		struct base_data *child;
+		struct object_entry *child_obj = NULL;
+		struct base_data *child = NULL;
 
 		counter_lock();
 		display_progress(progress, nr_resolved_deltas);
@@ -1137,15 +1137,18 @@ static void *threaded_second_pass(void *data)
 			parent = list_first_entry(&work_head, struct base_data,
 						  list);
 
-			if (parent->ref_first <= parent->ref_last) {
+			while (parent->ref_first <= parent->ref_last) {
 				int offset = ref_deltas[parent->ref_first++].obj_no;
 				child_obj = objects + offset;
-				if (child_obj->real_type != OBJ_REF_DELTA)
-					die("REF_DELTA at offset %"PRIuMAX" already resolved (duplicate base %s?)",
-					    (uintmax_t) child_obj->idx.offset,
-					    oid_to_hex(&parent->obj->idx.oid));
+				if (child_obj->real_type != OBJ_REF_DELTA) {
+					child_obj = NULL;
+					continue;
+				}
 				child_obj->real_type = parent->obj->real_type;
-			} else {
+				break;
+			}
+
+			if (!child_obj && parent->ofs_first <= parent->ofs_last) {
 				child_obj = objects +
 					ofs_deltas[parent->ofs_first++].obj_no;
 				assert(child_obj->real_type == OBJ_OFS_DELTA);
@@ -1178,29 +1181,32 @@ static void *threaded_second_pass(void *data)
 		}
 		work_unlock();
 
-		if (parent) {
-			child = resolve_delta(child_obj, parent);
-			if (!child->children_remaining)
-				FREE_AND_NULL(child->data);
-		} else {
-			child = make_base(child_obj, NULL);
-			if (child->children_remaining) {
-				/*
-				 * Since this child has its own delta children,
-				 * we will need this data in the future.
-				 * Inflate now so that future iterations will
-				 * have access to this object's data while
-				 * outside the work mutex.
-				 */
-				child->data = get_data_from_pack(child_obj);
-				child->size = child_obj->size;
+		if (child_obj) {
+			if (parent) {
+				child = resolve_delta(child_obj, parent);
+				if (!child->children_remaining)
+					FREE_AND_NULL(child->data);
+			} else{
+				child = make_base(child_obj, NULL);
+				if (child->children_remaining) {
+					/*
+					 * Since this child has its own delta children,
+					 * we will need this data in the future.
+					 * Inflate now so that future iterations will
+					 * have access to this object's data while
+					 * outside the work mutex.
+					 */
+					child->data = get_data_from_pack(child_obj);
+					child->size = child_obj->size;
+				}
 			}
 		}
 
 		work_lock();
 		if (parent)
 			parent->retain_data--;
-		if (child->data) {
+
+		if (child && child->data) {
 			/*
 			 * This child has its own children, so add it to
 			 * work_head.
@@ -1209,7 +1215,7 @@ static void *threaded_second_pass(void *data)
 			base_cache_used += child->size;
 			prune_base_data(NULL);
 			free_base_data(child);
-		} else {
+		} else if (child) {
 			/*
 			 * This child does not have its own children. It may be
 			 * the last descendant of its ancestors; free those
diff --git a/t/t5309-pack-delta-cycles.sh b/t/t5309-pack-delta-cycles.sh
index 9029f8a0dda..fc3594aaae9 100755
--- a/t/t5309-pack-delta-cycles.sh
+++ b/t/t5309-pack-delta-cycles.sh
@@ -60,7 +60,10 @@ test_expect_success 'index-pack detects REF_DELTA cycles' '
 test_expect_success 'failover to an object in another pack' '
 	clear_packs &&
 	git index-pack --stdin <ab.pack &&
-	test_must_fail git index-pack --stdin --fix-thin <cycle.pack
+
+	# This cycle does not fail since the existence of A & B in
+	# the repo allows us to resolve the cycle.
+	git index-pack --stdin --fix-thin <cycle.pack
 '
 
 test_expect_success 'failover to a duplicate object in the same pack' '
@@ -72,10 +75,13 @@ test_expect_success 'failover to a duplicate object in the same pack' '
 		pack_obj $A
 	} >recoverable.pack &&
 	pack_trailer recoverable.pack &&
-	test_must_fail git index-pack --fix-thin --stdin <recoverable.pack
+
+	# This cycle does not fail since the existence of a full copy
+	# of A in the pack allows us to resolve the cycle.
+	git index-pack --fix-thin --stdin <recoverable.pack
 '
 
-test_expect_failure 'index-pack works with thin pack A->B->C with B on disk' '
+test_expect_success 'index-pack works with thin pack A->B->C with B on disk' '
 	git init server &&
 	(
 		cd server &&
-- 
gitgitgadget
