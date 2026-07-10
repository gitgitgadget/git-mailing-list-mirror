Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E983783D8
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673349; cv=none; b=LI3rjT8Ak8FoflhbVIeHaxt72+yGtPuX8OqCwmjZDBCKHnksnANwQNSYMZVLAyw1qwmTWO/yq7twLKSxAEyDX0Pp/U2uIznMk+r2l2k/mQIaedqzCMi6A/nOSA8JJv5guKNuJYCgapIUU6zc/WKnSsbtLumXqQXamLxSYGIcwXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673349; c=relaxed/simple;
	bh=+sdwS8Gn6Vjh2W8whion23ogkQT9zIhBwtrUJhaGYlc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tV8hD+EG8zdyR+LVh/FkGTQMAbKp+B6afP+WySDS2W73aV8IAt8t3bWXQT4gZ+Tg2ypXwa9QPbt+zMoSvZ3e3LvB1qVvHB7Bu3gWXKhKjP6UTyFXarEI2NitbIh5nxnH9WZEOoVZ5urYrRB787jc7cdwn2PqxHKszDCF/F+Ei3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fKcpSUz6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XBdz61xR; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fKcpSUz6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XBdz61xR"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 9422FEC0112;
	Fri, 10 Jul 2026 04:49:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 10 Jul 2026 04:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783673346;
	 x=1783759746; bh=O1ia9hZXcByLLRvB1Zq55dfjyOwPJJD2zF1AkXjAr2M=; b=
	fKcpSUz6j+z/EBdiVf+/MLHVNhpcYm279505yrmwHRxKCVXELolmZRUUb+OP3lsv
	6awuYMYfaCmVIVXUVjk8eMqaCTsZhRGU/3LvKNlVeYNDArnWeBW+pVk/j/2NJNqP
	I0IHPM9TzKJ6HcygPDopBnIAbDr8K4l8mJCqDhTeF2edTl7A0HIuNtXidYWh0Po8
	p374vI7xg0xwmwpzrWoROWiDnoXE4tzC/139gCn2X+iHedTyDpDB7m/CExadGVEN
	wTUwQPTx0TkF5bA2Z/Me4HllYRgK/5qCNl45m8qxds+mwtTzxhcjojycy4taf/O7
	qb4mukfWj4DKAJ/BrX+X6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783673346; x=
	1783759746; bh=O1ia9hZXcByLLRvB1Zq55dfjyOwPJJD2zF1AkXjAr2M=; b=X
	Bdz61xR4Ec1qTuB52332LVCWi7aExSNGGed9688arpMlaE7L/ltmm0TVPM+PL/Au
	4bcLJ/JPGtg7rZVDhTjdjypdtaLfR57ynL0xnDOP1i35EGLmVWNaTJhXZaHGW76+
	UvYXY7TgiELXNfJXAmrcPN1vkUguS1gKHyYmbHmB9RT3u64jurl9X4kT8JnCwB7z
	iGvK4a+mpoRxuHdSbKK1hqX6SeW2MakEIb7BKZx2qKFtE37VOAQF483K/Jnm4n9H
	BrAdreIt44PvmF/Kr1duonKlYh0eXyF9uUOwlvqefti4ICnCxZGWanZMO3siFMWr
	hhkYwztsU5f5yAtsREb7A==
X-ME-Sender: <xms:ArJQagaj77eyxWriAAxoyHpJa1M2_N4IHc4m0MnFUDtabb7PybEmsA>
    <xme:ArJQai3F2cwnKtpMfgJKTvE_cMZZ22jXEzdXM2RPceiDDr0YS779vm7fmMUOSoB6Y
    fBnhO4_B9bpmSQY9YxiPOOu5y5yRNV7LHkLCz0ToIfwDrR3Knpa>
X-ME-Received: <xmr:ArJQaoVq2d9uHgDKvfEqpYcdAR8vUPARGZLNnFWmwIvvje_bywSqP0QX60fxCUOPtTyIrE_E6MD7RAov8YW-tbAEmpYcJ_1aGaTonv4O20QRoA>
X-ME-Proxy-Cause: dmFkZTGb4Vrx08qDmYPi9ab4YASd2IUWYaD5+JRoIRe7FbbJyO9XbgM1xNd/z3RU6mbk7z
    bE6U1CXfMdE7NeJMbBrOnmMVpvtGzdwJ5CdtO+lPSd1b46MXWof+UdyM9zCCDZpnlioVM2
    Z/+w/D7Q9O4UU/SAMZMQRfWxZ47QG39Tr8smjIKlVUgCJ20PuyOyeM8bz0cPdbGr4Ds/ON
    OhjY6GxRHw3bcJCmKq4D0ET4QUuwm3TWJicoFxOilXA7z/UHvjTPswYOOjc4s7CXbNT5hF
    sKsHPEhbnvPoa7IhgtQcgjSjkXRlr5isIrsN7kZXGgnAReTx0k7p6dtBK04pDoLPbvO2T2
    AkrTaAqH28WF9y1kFrfXiypyuYD8V7ADXhr+NZ2JioXZHz5sw7WWk+neK873G/CaXnRo6U
    bacixy0qfVdvYEyNQc2AEXUb4hEFN8tWdQCcy/6KAQPwN/UQ6ih+iU/L3A6UqYYvLdHK/Z
    GfQps75S4zso23PkOIBhFbD7tRjdxKTEmTI+71b23ZaZQY4JUNrjpGceuNC8jFKVyLq1n/
    PM2wri0EMUvhJ6D2F3FK84ajxAlBZU4qFo1YcR7VYG1sFEc99MU/a9EUfAeo6/1pPMb1t3
    +zfXBcuCruY5xJIEQan5eL0TfdUrffhSXmuHMiOUzgl12FWZlcRPUJR/Ldrg
X-ME-Proxy: <xmx:ArJQakVcrBaffCEo5NgX0wGJYsJCtm3idW1e8PAIlw4XppCA7N_eZQ>
    <xmx:ArJQavfCRtLVWJEToFd9KQBGxxO_mDpt1tcT9enwPcyXSJwdhRxChA>
    <xmx:ArJQalVukBO-aSLIRYB0q-KOMCbOE5dK_N0ak2dkTGDEh5-IbNKfgA>
    <xmx:ArJQagdizvEsN0mKnNfhi5QjiTsT97u-0IGJ1VqJSgOPGh9eZFt7NQ>
    <xmx:ArJQaq3Js0trBNnB0qr3Kh2oggmam7PM-5ud_PsF1a2_ee3nauEIzxKo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 04:49:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f0bf103f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Jul 2026 08:49:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Jul 2026 10:48:53 +0200
Subject: [PATCH v2 1/8] odb/source-packed: improve lookup when enumerating
 objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-pks-odb-for-each-object-filter-v2-1-3710a9cc165a@pks.im>
References: <20260710-pks-odb-for-each-object-filter-v2-0-3710a9cc165a@pks.im>
In-Reply-To: <20260710-pks-odb-for-each-object-filter-v2-0-3710a9cc165a@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

When iterating through objects of a packed source that have a specific
prefix we do so via two different methods:

  - When a multi-pack index is available we use that one to efficiently
    loop through all objects.

  - We then loop through all packfiles that aren't covered by a
    multi-pack index.

Regardless of which mechanism we use, we then iterate through all the
objects indexed by the respective data structure. Curiously though,
while we use the indices for enumerating the objects, we completely
ignore it for the actual object lookup. Instead, we call into the
generic `odb_source_read_object_info()` function, which will itself
consult the indices to figure out where the object in question even
lives.

This has two consequences:

  - It's inefficient, as we basically have to figure out the position of
    the object a second time.

  - It's subtly wrong, as it may now happen that a specific object will
    be looked up via a different pack in case it exists multiple times.
    This is unlikely to have any real-world consequences, but it's still
    the wrong thing to do.

Fix the issue by using `packed_object_info()` directly. While at it,
rename the `store` variable to `source`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-packed.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/odb/source-packed.c b/odb/source-packed.c
index 0edea5356d..9cfa02b7a2 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -143,7 +143,7 @@ static bool should_exclude_pack(struct packed_git *p, enum odb_for_each_object_f
 }
 
 static int for_each_prefixed_object_in_midx(
-	struct odb_source_packed *store,
+	struct odb_source_packed *source,
 	struct multi_pack_index *m,
 	const struct odb_for_each_object_options *opts,
 	struct odb_source_packed_for_each_object_wrapper_data *data)
@@ -170,6 +170,7 @@ static int for_each_prefixed_object_in_midx(
 		 */
 		for (i = first; i < num; i++) {
 			const struct object_id *current = NULL;
+			struct packed_git *pack;
 			struct object_id oid;
 
 			current = nth_midxed_object_oid(&oid, m, i);
@@ -177,9 +178,8 @@ static int for_each_prefixed_object_in_midx(
 			if (!match_hash(len, opts->prefix->hash, current->hash))
 				break;
 
-			if (opts->flags) {
+			if (opts->flags || data->request) {
 				uint32_t pack_id = nth_midxed_pack_int_id(m, i);
-				struct packed_git *pack;
 
 				if (prepare_midx_pack(m, pack_id)) {
 					pack_errors = true;
@@ -193,9 +193,9 @@ static int for_each_prefixed_object_in_midx(
 
 			if (data->request) {
 				struct object_info oi = *data->request;
+				off_t offset = nth_midxed_offset(m, i);
 
-				ret = odb_source_read_object_info(&store->base, current,
-								  &oi, 0);
+				ret = packed_object_info(source, pack, offset, &oi);
 				if (ret)
 					goto out;
 
@@ -219,7 +219,7 @@ static int for_each_prefixed_object_in_midx(
 }
 
 static int for_each_prefixed_object_in_pack(
-	struct odb_source_packed *store,
+	struct odb_source_packed *source,
 	struct packed_git *p,
 	const struct odb_for_each_object_options *opts,
 	struct odb_source_packed_for_each_object_wrapper_data *data)
@@ -246,8 +246,9 @@ static int for_each_prefixed_object_in_pack(
 
 		if (data->request) {
 			struct object_info oi = *data->request;
+			off_t offset = nth_packed_object_offset(p, i);
 
-			ret = odb_source_read_object_info(&store->base, &oid, &oi, 0);
+			ret = packed_object_info(source, p, offset, &oi);
 			if (ret)
 				goto out;
 

-- 
2.55.0.229.g6434b31f56.dirty

