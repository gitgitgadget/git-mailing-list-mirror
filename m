Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E7C4718D6
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 08:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448596; cv=none; b=qTgEcXc9fEceiP+Eb8OPdIr6+1hg0+TYKD0fjaTkmK5eMeZd/oUFD9Ktg6WXRujcgtkuIhCEh10I0e1+uYGoQOBI54XhSdqknKYVt2eHL2pGO3cGk5fDek7uSbDsMBLVx/6ThtulnQiRqjFTvdIJyeYCsiL6rCmcwiNSWpOjWtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448596; c=relaxed/simple;
	bh=4jONM9VOKRIkZnzo+m7Vpzd+n8KQ48fTzI1MGq9NiQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p0VASJmWiWfDGcXFwE86URIXq5MZgQxwHGqQl62r0uaJoUeaRsZEXqFv8s0YydyN0YDizRaLCtfyBD3DSn7sTMrpojWvEVxL6Y13LEUkU5OCVcNmtz9DgfUIBpS1+fPLu7vZ7rGu9Vn4+HasYnOJEw+MWu2hII+y1mCfRS23rnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fU5vuTTt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iKnq0d+9; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fU5vuTTt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iKnq0d+9"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F3FFC1400153
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 04:36:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 08 Oct 2026 04:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791448593;
	 x=1791534993; bh=Fve1EB7aeeiIJpxl22g1EeRiqhg8+M1ICIRObHKCdAk=; b=
	fU5vuTTtz/DY4pnhzQIcqEhzYAMjp91ttwMg1UqVX3MbqyFnUwacNu21+VRIYR3K
	ltJvWDF3rfkBpZs5088u7x3Un2tXrwdUrtg/t70t6lgUkft/jgZKmwSwDkDq61Gc
	Ky53S9QRGZnHp2Yd+wZSDsCUSU9tZfgsQ4/cSN8NeXUoELcCkCa5vNcgUgTVOEwb
	HOCck+jwHbPG1qW7BvjCj9X6HItrGMsIjmCtIfcYPU0yGNkhOWUiglZqfZALoQCM
	83KgyHyNQI0Fxx4EpaRVe5KGp9VOXLumQSw1SgKCo4X2o9mNwqVSkyFffk0K+g+7
	x4NQhngJXJEW3+Qe2X+lpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791448593; x=
	1791534993; bh=Fve1EB7aeeiIJpxl22g1EeRiqhg8+M1ICIRObHKCdAk=; b=i
	Knq0d+9PRmhsUlNmOnhubdYFpplw0P0NIqVy8bjOPIKIsvvJ6j79N4XzyACZVkq9
	Jo4Obr1Rs/resQ0/+gqv2a9K8iBal/s+sJ2UQ/PUvNNK4gGYEJg4R+5oj13c7fqt
	ZlAuBQly3+XIyDi8qIYwN5R2ZXusXtSqH+sqzq0B4Ymk7b5OUnTE0SVRJhZurBMg
	q7j5thADkQLCRIyvRQ8ZM31KIpv2On7XwB4hAnUAg52s7Ca7Yr6Vs6DUP37D2Mk/
	q0JFFhKKBfAAmrtA1GipMMWw/l4qUTe8Ar6QnsMzDYh6rL0PXkdkTjv1zMovloxK
	ygM7z+k5OnvjR/IZKAWZw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791448593; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:iyx4QNONEXlyACI+PE9qrEvU7/uGJTLFUTFormQ6WjKLp8I
	BLkeHIC58BCcB++XpUgxUh/NDr4+py7tErOzRebD6llaeSWbOXqW/dxhtaIziIgE
	3dSsv4cSnrXT7d7oH9Z6+3QRSeIqERUSD4YyvR3LfLNxNLQ1Wk2emzsRQYqpEjtx
	sJ15ji7dMT7z2lwsNlNcGB2YKGLNmcXZMw3YLIi5UydZiA2WgPBgqvx9jckSf9mM
	2OyWW+DTLjIleg29YGbkWSZS5fsEflB0D+BEyGHnbbPJ7YIPdnRA/w5VU3xfE6A9
	Gs/1cxhw5Fv1lej2jz9kUedEXQFuUjsxgxk0Wkw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Iqrye6W90ADGdtsXv9uWVU76sHxSYSI7GWx/MIJTxuk=:4jONM9VOKRIkZnzo+m7Vpzd+n8KQ48fTzI1MGq9NiQs=;
X-ME-Sender: <xms:EVbHak_rAESfsJjyzvWNGnvVTyVd8Bmhf68esdRNyzmsZykIjZdbCg>
    <xme:EVbHaivKNA876MyTALQttK1YfZpza7H_jQ_jLYYBadt0oFc892AuvpPbBXL6r9dd4
    byIQvlrEsQVq0_YkFhA6APIlAvLQR1zfVV5jM0U3s5z7nfe-98VOlw>
X-ME-Received: <xmr:EVbHanqsCcWtCf2royLTsXxg-6x9BJUGKbC0czIWMsEYmnV4a8UIFA>
X-ME-Proxy-Cause: dmFkZTGTrBFKl8Y2D728a6iHluzdbQuClsZJrd0NvUJl/r6aTED1ekGkS+lTIgah9AM/RC
    XXqQZO3rKxKtgp/ow35kMpuPzpMxleBx4D6Md1g4fLMSmK6McoeoO85W2idnzSkPwg6LLG
    k6WgF0EuWvlfBJtWoMBu8t5FtKqdId600Ld1bcgoiAaVpLbMriJIx+tZY/vOaSJjIWvhab
    kUk/5kmIsR/r+o8ZpLrcaLQUs+7UpxyjziarEpXIgTRuSc8yXiN23HTk7CZJd3CvmVxWIK
    NQbXjgwnjv/oQMjXA3NIad6nTLt4378hsZpcRU5JLJJwT9R280Rh9egURr0HAQlDQrDciZ
    g2xu+M0wSP260mikxLzw1e+JteIQf63jxzxRuNYA0tLlJFzQeXerRIFMnw8byy1JaZ+ueG
    2VT3GOxozOXRkoCU3Cb+lnJCj78K+zbQlmjn8s64tn+0T3GF7fHTmnkUEJZG2NTwD+DACl
    +8QxN0YyQ75TFXfpu6y+q06v0fv1hLqb0mFnmZwfSm3RmqVfrwRE6dbmcWCgJJdRCtYvha
    W4665oUrs9kE061RNAS5qrsJkHttthQhTwZj/+HXaC7pVHAueB/nHdTIg0iyAxJpfuqTM6
    tw0BlyPsE7TAD9Q8G8S3yY0eggs6vq6/OZoyDJiAc8djBYpxgcygjTD18+Tw
X-ME-Proxy: <xmx:EVbHavlUZopCG18BI1PV70MHdFbqr_J3zSIZ-XPoFSawMTUjzXCqCg>
    <xmx:EVbHarxhPAuPed6mHaG2dAa2kqhKsS-qTCLRfF9VEx6h34Zco7ZyBQ>
    <xmx:EVbHanlwbMfTc4j8zAXlGOuVunD8gioVhDQuoZKMAj9IVH78FGiIzA>
    <xmx:EVbHakdMWc8guq4q7lQZ6eO-52wsQEHxPxQ3Bcy0C_n3DTkeDC1bTg>
    <xmx:EVbHaq_B-JnwdROC15_kIRD5CjrKn2PfypgbzI33gBIz61izxAwUGLsg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 04:36:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e8b6671d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Oct 2026 08:36:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 08 Oct 2026 10:36:00 +0200
Subject: [PATCH v2 10/13] odb/source: make `will_destroy` an implementation
 detail
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-pks-odb-move-alternates-v2-10-b47e8189baa5@pks.im>
References: <20261008-pks-odb-move-alternates-v2-0-b47e8189baa5@pks.im>
In-Reply-To: <20261008-pks-odb-move-alternates-v2-0-b47e8189baa5@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

The `struct odb_source::will_destroy` flag tracks whether a source is
part of a transaction that we know we'll destruct anyway. If so, the
backend can optimize for that particular case, for example by not
flushing any data to disk.

While the intent is sensible, it assumes that transactions are backed by
a separate source that's being linked into the object database. But that
may or may not be true, as backends may have significantly better ways
to achieve the same. So the assumption doesn't make much sense in the
first place, as we're now tracking backend-specific details on the
generic `struct odb_source` level.

Move the field from the generic source into the "loose" source, as this
is the only source that ever makes use of it anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-loose.c | 2 +-
 odb/source-loose.h | 3 +++
 odb/source.h       | 5 -----
 tmp-objdir.c       | 4 +---
 4 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/odb/source-loose.c b/odb/source-loose.c
index 3c9edba46a..b2fbccd3c0 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -599,7 +599,7 @@ static int odb_source_loose_freshen_object(struct odb_source *source,
 static void close_loose_object(struct odb_source_loose *loose,
 			       int fd, const char *filename)
 {
-	if (loose->base.will_destroy)
+	if (loose->will_destroy)
 		goto out;
 
 	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
diff --git a/odb/source-loose.h b/odb/source-loose.h
index 3cf2e1f8f1..7c7e845fe3 100644
--- a/odb/source-loose.h
+++ b/odb/source-loose.h
@@ -28,6 +28,9 @@ struct odb_source_loose {
 
 	/* Map between object IDs for loose objects. */
 	struct loose_object_map *map;
+
+	/* Whether this is a source that will never be committed to disk. */
+	int will_destroy;
 };
 
 struct odb_source_loose *odb_source_loose_new(struct object_database *odb,
diff --git a/odb/source.h b/odb/source.h
index ea00873763..9fd2b2e5b5 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -81,11 +81,6 @@ struct odb_source {
 	 */
 	bool local;
 
-	/*
-	 * This object store is ephemeral, so there is no need to fsync.
-	 */
-	int will_destroy;
-
 	/*
 	 * Path to the source. If this is a relative path, it is relative to
 	 * the current working directory.
diff --git a/tmp-objdir.c b/tmp-objdir.c
index 719b55e580..2f2ffbbc7d 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -14,7 +14,6 @@
 #include "odb/source.h"
 #include "odb/source-files.h"
 #include "odb/source-loose.h"
-#include "odb/source-packed.h"
 #include "repository.h"
 
 struct tmp_objdir {
@@ -213,8 +212,7 @@ struct tmp_objdir *tmp_objdir_create(struct repository *r,
 	 * since the objects in the database may roll back.
 	 */
 	t->temp_dir = odb_files_dir_new(t->repo->objects, t->path.buf, false);
-	t->temp_dir->loose->base.will_destroy = will_destroy;
-	t->temp_dir->packed->base.will_destroy = will_destroy;
+	t->temp_dir->loose->will_destroy = will_destroy;
 	t->temp_dir->next = files->dirs;
 
 	t->orig_dir = files->dirs;

-- 
2.56.0.406.ga2d225a756.dirty

