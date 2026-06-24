Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD3C29ACCD
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 10:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782297441; cv=none; b=ekFXnPaVyVa7pra9LT4SPRE6eXudWEA2BxaxZUvHDqx4ednJC/IwUrgmKPDEeVNmMBEotrVpxNR5N2UtDnYQp2IjJVvD8PS8/Ik6wsxdqCUMPzyB6tZ8aYdp6Zw0FkaLVMsYNu3T0CNeJAjjHLE9uwF1dVGjpPVNVAnojGm8M1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782297441; c=relaxed/simple;
	bh=RB6abOOhMOfNCPs3/YhOseq3wN7ozz1/Cx//1mnrxaU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZYxybIFFsX34mZVbqeoqgewPkFORSPHwOQt/P8jdFYHcnhEGbile9jh7W7+Rg5jHNawSxnUlUS7YdyrdPepWkZDXUV3ZvSTfr29zCFuedhib5krugau+bDrqoOgZUusqWMABJUD2qFOeycvY4DqFdxdJ+1A/XK7hPA5RzEm40uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I+vCHeCx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ieoZqa/t; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I+vCHeCx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ieoZqa/t"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 18A697A013E;
	Wed, 24 Jun 2026 06:37:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 24 Jun 2026 06:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782297439;
	 x=1782383839; bh=JItMsYGAqjtedF5GL0jVQH54KJZEFMzXpzQ0a5TktWk=; b=
	I+vCHeCx3jP+nxWJf8INcpSjpvLwTMuAgW8naJefGnz8Q/dN1KE7mYiMiGydZkuk
	vogJ9HHpQ9xpJtjBI2zmOZHqPIpy9N91bUt4/M1QFKerB8BpjyVrSP8wcDUGG9NU
	cskXtv3xCjiQ3qu4a4GXV+a95omBLwojmESYeFgwcxkAamtfvIQUVDJ+YXpkr6OC
	S5evoaWsb87Hbtm409ro+G5yCY90oPSwEdfV3MS/j9lkrelAeHi61PRRryyvEXMj
	lNibWMx7N1on9NtMyPCuWEl7AoIoy3F/yrXsGFMeF3zC86JhuV5bIDVX0yGrr2wa
	nDyn2cTi9rrpoOgCqSXBng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782297439; x=
	1782383839; bh=JItMsYGAqjtedF5GL0jVQH54KJZEFMzXpzQ0a5TktWk=; b=i
	eoZqa/t1KkpOQMp9WogHmj/USmYTVZVf2N61mUioXZuFuXiX1jyNy3ZQE2+S6tEe
	2ZELYWrIDxWpszGSrg9aTZthrMADMUH/7Qy7xLn5GAIll0Nfu+BHVtgjCRAWy7SW
	mSyXs/MU3qAqcl6m2wEP9eUpn7PBJ5RxdjM+jiCrOLYJpP1HhvROZ8cOgPxP7/Pd
	wYltE57Hwx9g48HhjDmMBba9tiZrfu/sPtbU8AtWIyJBU/C+fmI/IpMKL5u8g7iQ
	O6Jak6jU/fA4yAsDFFCNQggWwcyL8VmbEA0ksZYxXlfbjVn0eSSIIDeg8gnVHZ57
	o4hxrKnKnYt18rXaIchbQ==
X-ME-Sender: <xms:X7M7aokKKMr8NGDdOC5iqmLcZh7Vg6fzH03lytQ3uRjBLRUXW6TE0g>
    <xme:X7M7avSJoUJMB6CeGxd6peQEioC4ODDdykFc8y6XdhUdAOnXr-nn3y4mH70yFl0hG
    I8n8yls744A8XGstcOvegRlKvSIonqLzybhw7UiKuNGaHb39j4x>
X-ME-Received: <xmr:X7M7akD9JnpSpPzqJ3nMQJKy21mVbDq10W2P663LV9IJGzmYyAoiJsdmVVRxd1WlO_WiLoIUXC3o3UxrdIsE2s98ElU2iLwGy_iTUzye>
X-ME-Proxy-Cause: dmFkZTEOwm4YoRsqFw0fXg4S9vibqhIjnq3CiK14uK5FjeG4Pjj47W66neq0QFAMtlLRvm
    JK8JIMJ9wQ8saYTRxk6t5b4UxJiYlnDrLqO47htI8sxO+J/Say5jKZSEP2D7A7pObQhm6r
    lKQ2NqJCCp0oXDPfqyMmHbDn3JT6fGlY32Cz8SeiwgjBwpGOTD6/V8y4W20+4Gt5+tLsEE
    ktr3MVx/eC0cP0DSNDwYr4lzkXS9VHkWGzpA0TZ5lrziO6+2/D2yl9u6KE7QfJ6xmPZRtl
    8LlPQoUSg864j3FNeioxfBshytaxXuyfhW1wzArwh5HfwCOrvnjF/TELDiZKETzbq2q5OI
    iFYGNCJez/p7cAOI1xSKYGepoavQ5BtoD1eYrSBqisGaOSH2SwMMOf7+5wN69Gz0AtAq73
    EDEVm89ARqr+Jg45b/U6Cq/EXvxw2HYvnJ0JTihIZRQ5PoQobtVqyRPFNlHzCZgouC9kju
    nVLQ/Pkw6vsg2IocAKk4CqOnmY3sCFlkfrVRJou7PxZJTZN7+Gaq3WyXPgLcCGF0SNRR0N
    k2qFiVXK8zetQO64yD/qUUoCGqrmTXbwg2vBv1LnsVvGdLp87evELUFXIVrn8MfIlDMdHC
    gFfDsIY093ccGlcAi07UTfjWMsfQ69fbwsAPieRJg4lwzATKnrYnqtAFAlLA
X-ME-Proxy: <xmx:X7M7auTX6-n5PCo2RgRjXooD4G46Nd0QQgmehGUyIdzByQCOe4IF7A>
    <xmx:X7M7aqo_86VQBTZfgDloqBO6gpKD0vETOwT_Ykv_jT0pd-z5ToLopA>
    <xmx:X7M7aoxYDlsX_Q-kJx2cmDw00otseiKGe4EX3AEwiHITFeoKTznNIA>
    <xmx:X7M7anKFjB9UaYjbaz4QXXXa2Ob0i1ZDKKmyqxRNeKnRfwoV1RUdPg>
    <xmx:X7M7ao73AIcVENRKjYDKp4t7cyXNEESxBjuaNfydOEGKlQ6hw7L32uCe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 06:37:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 17e97bfa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jun 2026 10:37:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 24 Jun 2026 12:37:06 +0200
Subject: [PATCH v2 4/4] connected: search promisor objects generically
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-pks-connected-generic-promisor-checks-v2-4-132d73ee47b9@pks.im>
References: <20260624-pks-connected-generic-promisor-checks-v2-0-132d73ee47b9@pks.im>
In-Reply-To: <20260624-pks-connected-generic-promisor-checks-v2-0-132d73ee47b9@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15.2

When performing connectivity checks we have to figure out whether any of
the new objects are promisor objects, as we cannot assume full
connectivity if so.

This check is performed by iterating through all packfiles in the
repository and searching each of them for the given object. Of course,
this mechanism is quite specific to implementation details of the object
database, as we assume that it uses packfiles in the first place.

Refactor the logic so that we instead use `odb_for_each_object_ext()`
with an object prefix filter and the `ODB_FOR_EACH_OBJECT_PROMISOR_ONLY`
flag. This will yield all objects that have the exact object name and
that are part of a promisor pack in a generic way.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 connected.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/connected.c b/connected.c
index d2b334173f..b557ff5db9 100644
--- a/connected.c
+++ b/connected.c
@@ -11,6 +11,13 @@
 #include "packfile.h"
 #include "promisor-remote.h"
 
+static int promised_object_cb(const struct object_id *oid UNUSED,
+			      struct object_info *oi UNUSED,
+			      void *payload UNUSED)
+{
+	return 1;
+}
+
 /*
  * For partial clones, we don't want to have to do a regular connectivity check
  * because we have to enumerate and exclude all promisor objects (slow), and
@@ -30,25 +37,28 @@ static int check_connected_promisor(oid_iterate_fn fn,
 				    void *cb_data,
 				    const struct object_id **oid)
 {
+	struct odb_for_each_object_options opts = {
+		.flags = ODB_FOR_EACH_OBJECT_PROMISOR_ONLY,
+		.prefix_hex_len = the_repository->hash_algo->hexsz,
+	};
+	int err;
+
 	odb_reprepare(the_repository->objects);
 	do {
-		struct packed_git *p;
+		opts.prefix = *oid;
 
-		repo_for_each_pack(the_repository, p) {
-			if (!p->pack_promisor)
-				continue;
-			if (find_pack_entry_one(*oid, p))
-				goto promisor_pack_found;
-		}
+		err = odb_for_each_object_ext(the_repository->objects,
+					      NULL, promised_object_cb,
+					      NULL, &opts);
+		if (err < 0)
+			return err;
 
 		/*
 		 * We have found an object that is not part of a promisor pack,
 		 * and thus we cannot skip the full connectivity check.
 		 */
-		return 0;
-
-promisor_pack_found:
-		;
+		if (err > 0)
+			return 0;
 	} while ((*oid = fn(cb_data)) != NULL);
 
 	return 1;

-- 
2.55.0.rc1.745.g43192e7977.dirty

