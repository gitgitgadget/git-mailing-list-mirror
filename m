Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264991F4607
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 08:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991669; cv=none; b=iWd26XrTb+gX2PLk8AU7V5zD+M9ISubJH0n3mHcLqPLQqIH7VFSSX9+CTisdZNcx1/cHmcKFiD1B97ZqWSyonauL1F2uIalqKsxwqYgIh3vU58sthqM7CAcqYCdYCGja5QqM0ygLrgyEwnwKtB8jkZfsOUCCww3JQtPLF4/L8nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991669; c=relaxed/simple;
	bh=CEzg+8JoEPNRl5lTk38sh2ql24gStIClwQpZYVvG/J4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VJVTiXclTNw03alGyIuqca+tPPa0Y/e1FGpJBh4lkLt41ptqMgZheOcYuqFlvKWAN7Mb/gy51Hv5vt0o9EgkFqec0HJxe0HH7GdVz7X5ZS9QPKhsfQdFTwNhAXc0uF4ihXFHPcAnLWL5i//NDOinNWJTJSL4GiVHfHJvP39RoHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Yl4pWKMb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=6rH/jsq8; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Yl4pWKMb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="6rH/jsq8"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 145481140164
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 03:47:46 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 03 Mar 2025 03:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740991665;
	 x=1741078065; bh=A+Njk9AWxGeZpEgYpxM+Y1kH7VGKqzvT53fL2QliU3A=; b=
	Yl4pWKMb749PbAugUJNno0sdTCSjQkLSIHM6b+E2QnOG/2Fku/4waVpRA0nfUCVw
	WVk8oWVeFouHCGDXiUGAg437yGZyaWoGGOjDdeSHYyGUtAsng2ljC3RyjRwEG/hz
	Y92Rkp8uz0P5Y251yj1LYWgu74/I/zRWZOH8cHq7U+vmVVHTMOLIc7u41BVtEX/M
	oceibG2jjM5j99WzbWed4uXtU//HF8FJl04PVx8Pz6xfsyg+uWbj5Lc1c8jyntj+
	ErdPD+DONR72io+iMZrEw87uzi9m/5TMuyvgEt870XEBdd52fW+XFFChfHD+zW72
	LTk7IPVQY/+tbRBVj+xnUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740991665; x=
	1741078065; bh=A+Njk9AWxGeZpEgYpxM+Y1kH7VGKqzvT53fL2QliU3A=; b=6
	rH/jsq8j7XZNr8UwpA38pozk8709v76Hd9sRODWn42s0JlRFa/Y/HQxXPl+qBCFW
	f/uQjsNo99GHortzRdNZHRUsPmnoN1tI/CkXcgK66joH1+0GvTCclCnScgrVDFl0
	bfi+3FoKN4Fazkwp6yO1LspTVDyj9ax8qoIoLFsAo+2vT3wnfgOCuj81kAqZsfSv
	hluhtlN4OC/LKA7vMsk8zPaiVk+TxBdtgDZ3Ds77ufPC2NoI28NuhjeDCxpKzY7n
	TDQxgWBhnNwbjnFGRmI23xaGvHCuSvCVC3g17uKvzcPSyMRZ/qncbfM8HTl64Cga
	vM0lNWv0FIy99CWYS6cpw==
X-ME-Sender: <xms:sWzFZ-QKROhavdEkPepKTri0Dx1As_Mr9bKteyA2vdj02-WBazoFxA>
    <xme:sWzFZzyX5xBkTzS_fKtfj_N9loJ5zaP01JOOUvL8tlKNXgCQJizmHlt_bsZ4-Dl8N
    xkB7aKDIh5zXFSvdA>
X-ME-Received: <xmr:sWzFZ72kK685jvQvLKnFMctutiT6JgU9EsQUaJRtJMkEpw_LlbJX5zTcPyV8uMAVMs17oqivfmmt5qosipNobpt9a7LTw2KfRYdj13u718gYrRkZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiud
    ejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:sWzFZ6BettT9jPA4j6xC9GVdYwMQp58dr6EMCHtmNtqieOwFs7XZyw>
    <xmx:sWzFZ3jObaIgzXQtRXzwKXqYiWtK3iRaOknauL-3OIpGgkq1oknsbA>
    <xmx:sWzFZ2pVx7c0CTU9kBgGx7odR2HvTClGWjOlF9KA_pnbTUkijpfZ_Q>
    <xmx:sWzFZ6gr8nKJwhDisT3A1KoDfef3HUzcdKtEMMwInMoA6Ky7NtaUTw>
    <xmx:sWzFZ_advtg62canVjYgggW1HYGIFpT23dHwWeKlrGtJVySMz__NJGo9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Mar 2025 03:47:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3469ae18 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Mar 2025 08:47:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Mar 2025 09:47:40 +0100
Subject: [PATCH 11/12] hash: fix "-Wsign-compare" warnings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-b4-pks-objects-without-the-repository-v1-11-c5dd43f2476e@pks.im>
References: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
In-Reply-To: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

There are a couple of trivial "-Wsign-compare" warnings in "hash.c". Fix
them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 hash.c | 12 ++++--------
 hash.h |  2 +-
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/hash.c b/hash.c
index dd5ac9d0eb2..4d9f98f72c2 100644
--- a/hash.c
+++ b/hash.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "hash.h"
@@ -246,10 +245,9 @@ const char *empty_tree_oid_hex(const struct git_hash_algo *algop)
 
 int hash_algo_by_name(const char *name)
 {
-	int i;
 	if (!name)
 		return GIT_HASH_UNKNOWN;
-	for (i = 1; i < GIT_HASH_NALGOS; i++)
+	for (size_t i = 1; i < GIT_HASH_NALGOS; i++)
 		if (!strcmp(name, hash_algos[i].name))
 			return i;
 	return GIT_HASH_UNKNOWN;
@@ -257,17 +255,15 @@ int hash_algo_by_name(const char *name)
 
 int hash_algo_by_id(uint32_t format_id)
 {
-	int i;
-	for (i = 1; i < GIT_HASH_NALGOS; i++)
+	for (size_t i = 1; i < GIT_HASH_NALGOS; i++)
 		if (format_id == hash_algos[i].format_id)
 			return i;
 	return GIT_HASH_UNKNOWN;
 }
 
-int hash_algo_by_length(int len)
+int hash_algo_by_length(size_t len)
 {
-	int i;
-	for (i = 1; i < GIT_HASH_NALGOS; i++)
+	for (size_t i = 1; i < GIT_HASH_NALGOS; i++)
 		if (len == hash_algos[i].rawsz)
 			return i;
 	return GIT_HASH_UNKNOWN;
diff --git a/hash.h b/hash.h
index 4367acfec50..55d67ed83f3 100644
--- a/hash.h
+++ b/hash.h
@@ -325,7 +325,7 @@ int hash_algo_by_name(const char *name);
 /* Identical, except based on the format ID. */
 int hash_algo_by_id(uint32_t format_id);
 /* Identical, except based on the length. */
-int hash_algo_by_length(int len);
+int hash_algo_by_length(size_t len);
 /* Identical, except for a pointer to struct git_hash_algo. */
 static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
 {

-- 
2.49.0.rc0.375.gae4b89d849.dirty

