Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469A13A451E
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 08:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673354; cv=none; b=C53d9/agRuuayAdUYvdA1ad7J8EddUWGvNxhIJL+F1TdPaz9QHrpHifaYSiQiNNSfVW8W4J5rgQzYQv1x3pyi9iEWJsVro+ToGDSU55HLHU1El50zBQu68JsfAsBxmfdqDM90eMcAUOwG2nLrup+LQ+H0btooc5Yhyn2IQt0k8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673354; c=relaxed/simple;
	bh=N/RVb8Yqp5WFL8J2nPhRlcJYUlTJK0FKWLAKpTn33nY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T2Gt+Sqfpje4TO+twDziunlKFWN3Tv9t0kKMPLz/MJxc3wCJNhOvaw9Qk1pw+xvxgQ/H7wg1JilI2ah75iqt8EvofwJWfuBptJTGeoCGvcCpud2RxNkzsAkSX/6CdQDSUZsZ2ueO7MQ8PgxtgcTz7qe7d8ZpQSa49ujQGuRqfoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VTRoHFAg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hGWb37kT; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VTRoHFAg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hGWb37kT"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8E0E114000E3;
	Fri, 10 Jul 2026 04:49:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 10 Jul 2026 04:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783673352;
	 x=1783759752; bh=UzlcB+Em1GH8A3ZZ7i3Qys7Pjeizr5hDEg52wPp72JM=; b=
	VTRoHFAgNigkdCeMy7UgOJGgV4uFxh28c6VI/KNu5rwx69cJqGCWYdAksBLYd3p0
	XWjC0dSHLjSAcW4Oy24ia9bt+1LQcb01XOY+H73SaNpuAHFF1KbxcnMhx6bcsKxM
	I9SaGBRl6QydPwpSOIfyIoCw6CfGQA5IcURqKEAN6Q/dov2p8AlTy9RLXAxudBKh
	v38jYfODfQ25sXnfgT/x/EmFj00O8Su4ixPZFefvON2bZ0NgpBJvJPTUVmDQXxpA
	2MDCrgAftD8hoJ+myREiqRVX0aFi4YHu05x9uFygI4/th6QH9M0FGcaMOd4tavTr
	k92L+FTbJyhzP2D/n1giPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783673352; x=
	1783759752; bh=UzlcB+Em1GH8A3ZZ7i3Qys7Pjeizr5hDEg52wPp72JM=; b=h
	GWb37kT73t/vDXxxbPyUlAYYEAMQm8dI2ecOVJfR3DC3Nd1p9FfLDzw1WUxZ1cM2
	pjBlIQEkLpZ46iLUsOtDiAh6TWhPklumr2rwfc8NMJugLvHNuhI4SFSSo4MB9Srb
	W1CGGKHdd2DPGcb9wyqO+QRrqFyi3dXPOfO728DU3p98R0j78F1rxk7N/iUOAd3Q
	t/RaRqAOgtvwioOUalO7BAp8pLcISuoIqLLnX2jdSgMXJ8aYJDcV9j8NgcctA26H
	w4K1Lmo06txoNhimGap7DqTY3JPhJtmyWGhePiMzlJpsZ+GiLcjRostuuNcWt+u+
	pdfwDWirkKFBUy/ldHElQ==
X-ME-Sender: <xms:CLJQaui15NEE4TUHdUCo_0gxVTgmPpO6nVkcqVk_lgwHjKG8uYr-YA>
    <xme:CLJQamfbgW20CsSTOPxFY8sN3KR6pvm4p2rQuc2orT66eFtKbbDUPz41pgFU6j0o5
    i-x-i9mg_OnqkWyMykfAdOeYq1Rygelpw3jUnTNIvKcHy9r9ozLig>
X-ME-Received: <xmr:CLJQajf92hQPaUxpT-4-KeJnAT48We6MBO2rAL18maZM5h-ub6juIFCKy_LghIvgdPjcRFZ4n3JKetLXZpvYQ_9LE-aSfg8oAI2iiKwVnedkZg>
X-ME-Proxy-Cause: dmFkZTGb4Vrx08qDmYPi9ab4YASd2IUWYaD5+JRoIRe7FbbJyO9XbgM1xNd/z3RU6mbk7z
    bE6U1CXfMdE7NeJMbBrOnmMVpvtGzdwJ5CdtO+lPSd1b46MXWof+UdyM9zCCDZpnlioVM2
    Z/+w/D7Q9O4UU/SAMZMQRfWxZ47QG39Tr8smjIKlVUgCJ20PuyOyeM8bz0cPdbGr4Ds/ON
    OhjY6GxRHw3bcJCmKq4D0ET4QUuwm3TWJicoFxOilXA7z/UHvjTPswYOOjc4s7CXbNT5hF
    sKsHPEhbnvPoa7IhgtQcgjSjkXRlr5isIrsN7kZXGgnAReTx0k7p6dtBK04pDoLPbvO2LB
    KCtw9/TjdvHqm3YxRBYfPHUnKyBwBCF2hHLKn4XJA6eFiR5l972i2aAdJlTTkzuYJlF62m
    Sr+f9zlwYngGSkJ1gtknWMDFKs8FhqVPWCKc46HveL0VhE2ZIlpgL3653aFzC2BTwdfOL/
    Sr59+ocbgdgbs0qT1pEbN/TLHs2e9bNZpELYI7B2jB1eXMNT7ULBEsOioADaFHChSwPcZg
    jF60PIecrU3/waLFkdm/kT4cCB/HTsuJ8TeBDKk1gxgWjShFyqL3KFo5wNOGk+sMts2q3W
    mP7H3KICUk1OCr2O4GY1MJ5FMw4jzWla9h7onNVZpxAuACfd6hVLr97dPAfg
X-ME-Proxy: <xmx:CLJQag--O6qEy6OQ4D7qzW5_WKHya1viURPYvOEqmYtb6tVhFKAldA>
    <xmx:CLJQavnhZsppQ-SdO0zzaJNXc7FoknC_K-gQrMCrv8WpRrIJW_t9nw>
    <xmx:CLJQai9u8eaq_r6yJhYScMoGuJJtTuuLdb3VQVQEYr0vOx4I3cCy7g>
    <xmx:CLJQatkt8QBREiw2UXwtKCdy7uJsmbBGSHtPnYnuMvzQI1KC8srRdg>
    <xmx:CLJQamcshhgP7Z0wdqsAs3uieW6gGMvcDNAnJ6hFE44Yx8WODGOtdhfW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 04:49:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 847e2667 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Jul 2026 08:49:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Jul 2026 10:48:55 +0200
Subject: [PATCH v2 3/8] pack-bitmap: allow aborting iteration of bitmapped
 objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-pks-odb-for-each-object-filter-v2-3-3710a9cc165a@pks.im>
References: <20260710-pks-odb-for-each-object-filter-v2-0-3710a9cc165a@pks.im>
In-Reply-To: <20260710-pks-odb-for-each-object-filter-v2-0-3710a9cc165a@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

In a subsequent commit we'll lift iteration of bitmapped objects into
the "packed" backend and make it accessible via `odb_for_each_object()`.
The calling convention for that function is that the callback may return
a non-zero exit code, and if so we'll abort iteration. This is currently
impossible to realize though, as `for_each_bitmapped_object()` will
ignore any return value and just churn through all objects completely.

This doesn't matter to the callers of `for_each_bitmapped_object()`, as
there's only one of them in git-cat-file(1), and the callbacks we pass
always return zero. But once we move the logic into the generic
infrastructure it becomes a latent bug waiting to happen.

Refactor the code so that the return value of the `show_reach` callback
is not ignored anymore. Instead, returning a non-zero value will cause
us to abort iteration in both `show_objects_for_type()` and in
`for_each_bitmapped_object()`.

Note though that there's a second user of `show_objects_for_type()` with
`traverse_bitmap_commit_list()`, and that function does indeed invoke
callbacks that may return non-zero. This non-zero return value never had
any effect at all though, and the callbacks that return non-zero values
are only ever invoked via `traverse_bitmap_commit_list()`. Consequently,
we adapt them to always return 0.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c |  2 +-
 builtin/rev-list.c     |  2 +-
 pack-bitmap.c          | 31 +++++++++++++++++++++----------
 pack-bitmap.h          |  3 ++-
 4 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ea5eab4cf8..8ff92c5272 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1909,7 +1909,7 @@ static int add_object_entry_from_bitmap(const struct object_id *oid,
 		return 0;
 
 	create_object_entry(oid, type, name_hash, 0, 0, pack, offset);
-	return 1;
+	return 0;
 }
 
 struct pbase_tree_cache {
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 8f63003709..02818b81c6 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -486,7 +486,7 @@ static int show_object_fast(
 	void *payload UNUSED)
 {
 	fprintf(stdout, "%s\n", oid_to_hex(oid));
-	return 1;
+	return 0;
 }
 
 static void print_disk_usage(off_t size)
diff --git a/pack-bitmap.c b/pack-bitmap.c
index a47c231632..eda38a5433 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1695,7 +1695,7 @@ static void init_type_iterator(struct ewah_or_iterator *it,
 	}
 }
 
-static void show_objects_for_type(
+static int show_objects_for_type(
 	struct bitmap_index *bitmap_git,
 	struct bitmap *objects,
 	enum object_type object_type,
@@ -1704,6 +1704,7 @@ static void show_objects_for_type(
 {
 	size_t i = 0;
 	uint32_t offset;
+	int ret;
 
 	struct ewah_or_iterator it;
 	eword_t filter;
@@ -1749,11 +1750,17 @@ static void show_objects_for_type(
 
 			hash = bitmap_name_hash(bitmap_git, index_pos);
 
-			show_reach(&oid, object_type, 0, hash, pack, ofs, payload);
+			ret = show_reach(&oid, object_type, 0, hash, pack, ofs, payload);
+			if (ret)
+				goto out;
 		}
 	}
 
+	ret = 0;
+
+out:
 	ewah_or_iterator_release(&it);
+	return ret;
 }
 
 static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
@@ -2062,6 +2069,12 @@ int for_each_bitmapped_object(struct bitmap_index *bitmap_git,
 			      show_reachable_fn show_reach,
 			      void *payload)
 {
+	const enum object_type types[] = {
+		OBJ_COMMIT,
+		OBJ_TREE,
+		OBJ_BLOB,
+		OBJ_TAG,
+	};
 	struct bitmap *filtered_bitmap = NULL;
 	uint32_t objects_nr;
 	size_t full_word_count;
@@ -2086,14 +2099,12 @@ int for_each_bitmapped_object(struct bitmap_index *bitmap_git,
 		goto out;
 	}
 
-	show_objects_for_type(bitmap_git, filtered_bitmap,
-			      OBJ_COMMIT, show_reach, payload);
-	show_objects_for_type(bitmap_git, filtered_bitmap,
-			      OBJ_TREE, show_reach, payload);
-	show_objects_for_type(bitmap_git, filtered_bitmap,
-			      OBJ_BLOB, show_reach, payload);
-	show_objects_for_type(bitmap_git, filtered_bitmap,
-			      OBJ_TAG, show_reach, payload);
+	for (size_t i = 0; i < ARRAY_SIZE(types); i++) {
+		ret = show_objects_for_type(bitmap_git, filtered_bitmap,
+					    types[i], show_reach, payload);
+		if (ret)
+			goto out;
+	}
 
 	ret = 0;
 out:
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 47935eb24e..ae8dc491ac 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -93,7 +93,8 @@ struct list_objects_filter_options;
 /*
  * Filter bitmapped objects and iterate through all resulting objects,
  * executing `show_reach` for each of them. Returns `-1` in case the filter is
- * not supported, `0` otherwise.
+ * not supported, `0` otherwise. Aborts iteration and bubbles up the return
+ * value in case `show_reach()` returns non-zero.
  */
 int for_each_bitmapped_object(struct bitmap_index *bitmap_git,
 			      const struct list_objects_filter_options *filter,

-- 
2.55.0.229.g6434b31f56.dirty

