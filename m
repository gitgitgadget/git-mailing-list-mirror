Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE253911C0
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 08:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782118185; cv=none; b=mbs0ubVY/h9CiXLAJqvBH9lbB1pejU2sjJive/d7xilEV4XOYiHl6PbPl+w+ELLXq1zAMl/FK84iMUVn4kt2O2rcoVof+qk07UI4cwnVDBDtBxxtLc3+JGxREVOMzeooQaGH3vvo7TGj2upGrWR+KquYFb8l6mfh/1RsbfIIRZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782118185; c=relaxed/simple;
	bh=FRaRvRIVCmBF/Dx1V7WygT0oKQF0J5G8Ufj8eKU7s00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qhY7N0sldi0vTYR5pDfAM6nnlIjDLAAokSG7Nkfs/uhK2kjvs2oNc3O3hW5yRDnqle3QPYcNQUG9dvRJeZsISCXP8tB/H6JzemO+NIaRccHl7JhEGeiCP0MCgBJd1B+Lc3AHsZSI8EGTe50R3v0HQW+PZCVyGuV4LRZ1+gLHEyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XV20UOLl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L1L4WT5n; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XV20UOLl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L1L4WT5n"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 6BFA41D00071
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 04:49:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 22 Jun 2026 04:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782118183;
	 x=1782204583; bh=GjzFkFougG764Swh/1mmRPi1sK9r7DXWTTegjqkCTMs=; b=
	XV20UOLlSW2WL466V14eSCU0lw97R5fA8FWgLPKlXC8nvHJxmA57k3kRhmljZURG
	60YTg5WvQUXDrQdlgCryU4L3F3XQ2JqXXAp4Ps3xAZkfz6QQlRIe3J0umuBBuA6W
	Hw1r5zF/FAA5AJIrwQkmfC4TxNHQl2yIryWnFnLLsp1Giw/7aWlxH6ZvGkdamfoZ
	fryAKKqVNk/UDY8dmE2QFWCa8Nra1MH9oawen6agobSKdzQ7zLK7OYQK4yF0F1CF
	huyae+STk6i6RU0/zb8cymRDhSESZAcYqMLRlL1Aie2Ffv0+DrdJGsyHsmX9KlRI
	Wy1Kufc9Zd6E2T4G6Z+dQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782118183; x=
	1782204583; bh=GjzFkFougG764Swh/1mmRPi1sK9r7DXWTTegjqkCTMs=; b=L
	1L4WT5nGP01Hf6q5e8xQ/eVuXphHLeGNHD6gB54gqz0Qt46sOFuhCGDI7n4dSGRW
	GCi9eyr4W6S/aRPOK2rMm6uiYmEg9XALKr7lcp28QOHOjXXdpVUkmodP9kHZe2J0
	BWqrtYrC1YCpqt98OmZQn1z6Pr+HIwTYhBdf9SyLqAvi9OflBLzkD1JtBbBfyrpu
	+asuzn/flodARHf6LpBD+edHdIlh9LNPuZXJbVgQP5VrGoIfkym/XUl1RBucMUg+
	4jOIx0np9w+BqbBoAKbIegFkPcHYD/13SUccrEQLhf60kJ7wUKx+lkFrKFn1hWHh
	m4fSZ9Bl91oW5Sk85vB0A==
X-ME-Sender: <xms:J_c4arR_jTZcDsHzA8_x_AY7lllIikhF17FIRKI-DDac6m7qujZ-xw>
    <xme:J_c4ajssi9PEGtUF_jwM0UmonSk43IkNps8AIskxRfslNUg1_nyM2SuZZY2f7Ldy8
    OazsbaWHZqSRW-RwairXsvVWWqCLqfLjE5kbxHdkolQEbKnntTJWGQ>
X-ME-Received: <xmr:J_c4amdChYixE3pAzA4bd9yrVAWgbTofOYUjeoS5fzl80_ZPngf7oilVIcpdjO0ANFKlj4NeWsv1mQp4iGnfFAKErJZmcg_5YtwqGwpxLg>
X-ME-Proxy-Cause: dmFkZTEOnajbKOjPDvzPIuSD6qi/CT4lxSKsp/grLoo+rkJBbIcbiK4GoLKyEODVuxYFKg
    Ua9MbapOYi58Bwzv0rDKaK6aGXCi6K3Uz/d7bTlu9te/pFqeZJ5TRoWQGRmLd1dVxgWmZn
    Vgb5EZZVJvJ7qbDwBkxlUt+c3nBAZJfAOe1r5YwrQDC5mIEpZTlaU1wiLGLBIVUJjiNYCX
    2PYvpXpc1EhP64Lnq4+sbRWpC+xDeUMiWDfLVCnHJN89DHIvNVfAIOZrKlZEA9lL6kicKx
    eUU1+iMrHMbXepB5nnaTwyeDj8GM+uEqMUbUnRU83HO6B8ETa8cKoDaUfnYHdN+vdmxeGT
    PoSnLsNIfvV6ixD3mMFCA90kE+XQJVeaM/d0G3Jj/fiBsszGacSDdA8sM0gyT9tGHYpkR0
    N4mF0QGDvQzENUJNda9Wq+7Iv1lVglL+gz/QaTbWj8oM/bh7CrLkv0qJk9hDYBx/PbGXQt
    QN2/s3c7R6iCAM/G7nJNYW1uPibLeOGpASbC8Vf+9oZEpNgzLUHInT0XMmrptwp4l1IjP2
    XpR884OtzECc4StLqG0akhG6qFf0tvPMj3U0ltWD74JaYXDsWQ5WvKLbvS5XwfRVMoNCgj
    sXQ0kqPSmaNIB5WeDrgyEtoUPsNQ5hsWFjK33bdFsJa4LWmjs2lEcyxUD54w
X-ME-Proxy: <xmx:J_c4agJRz8uSKExxfzVIe1y-92rfGkb8cnw9PMCbL8ArqmzZfFvrKA>
    <xmx:J_c4akY_ChVhm7uMa9-2u_DDQbB-1LZe5QfoXDHmEdmXu49HoVHLHQ>
    <xmx:J_c4arvBaPSay5TpGNFeGVks6-DqSx6Lpivd4Ugb0JlOvTNPus3L5Q>
    <xmx:J_c4ahuICwCPYHlCKh2OX_vShkKlGhUcagKei9UxzNS4rBbtzXtBVg>
    <xmx:J_c4avTkITWkyIyM7CSmlGH_eXirY4rsy4dBBCB9Gkgq1oqv32ZBYVKm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 22 Jun 2026 04:49:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 857add22 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 22 Jun 2026 08:49:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 22 Jun 2026 10:49:29 +0200
Subject: [PATCH 3/3] connected: search promisor objects generically
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-pks-connected-generic-promisor-checks-v1-3-25eba2698202@pks.im>
References: <20260622-pks-connected-generic-promisor-checks-v1-0-25eba2698202@pks.im>
In-Reply-To: <20260622-pks-connected-generic-promisor-checks-v1-0-25eba2698202@pks.im>
To: git@vger.kernel.org
Cc: 
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
 connected.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/connected.c b/connected.c
index 7e26976832..9a666f0cdf 100644
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
  * If we feed all the commits we want to verify to this command
  *
@@ -46,6 +53,11 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 	}
 
 	if (repo_has_promisor_remote(the_repository)) {
+		struct odb_for_each_object_options opts = {
+			.flags = ODB_FOR_EACH_OBJECT_PROMISOR_ONLY,
+			.prefix_hex_len = the_repository->hash_algo->hexsz,
+		};
+
 		/*
 		 * For partial clones, we don't want to have to do a regular
 		 * connectivity check because we have to enumerate and exclude
@@ -54,31 +66,30 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		 * object is a promisor object. Instead, just make sure we
 		 * received, in a promisor packfile, the objects pointed to by
 		 * each wanted ref.
-		 *
-		 * Before checking for promisor packs, be sure we have the
-		 * latest pack-files loaded into memory.
 		 */
-		odb_reprepare(the_repository->objects);
 		do {
-			struct packed_git *p;
-
-			repo_for_each_pack(the_repository, p) {
-				if (!p->pack_promisor)
-					continue;
-				if (find_pack_entry_one(oid, p))
-					goto promisor_pack_found;
+			opts.prefix = oid;
+
+			err = odb_for_each_object_ext(the_repository->objects,
+						      NULL, promised_object_cb,
+						      NULL, &opts);
+			if (err < 0)
+				break;
+			if (err > 0) {
+				err = 0;
+				continue;
 			}
+
 			/*
 			 * Fallback to rev-list with oid and the rest of the
 			 * object IDs provided by fn.
 			 */
 			goto no_promisor_pack_found;
-promisor_pack_found:
-			;
 		} while ((oid = fn(cb_data)) != NULL);
+
 		if (opt->err_fd)
 			close(opt->err_fd);
-		return 0;
+		return err;
 	}
 
 no_promisor_pack_found:

-- 
2.55.0.rc1.745.g43192e7977.dirty

