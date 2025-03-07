Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB26321B9C8
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741357147; cv=none; b=glzgl2RN2AzFQbi+XNarXJGWDN5CGcJxM+eAG2wpVCkYVNP4L7rfInjOEorOdveREz4jneaWVMPISVCDl2MHEhl0jhjYIFIFbJRFJBu+npkoaEC/odL2ZosBfKASG7Wpsj5yYGtNqYQYgmXx37indWtWyxK72880GsRz08bMVIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741357147; c=relaxed/simple;
	bh=l6vfHxMQsfAk2Qo3m9vjhJ+Y7ZUBwfGJqNafkI6rHmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OUJMENgtlvLzQpeUwbXAZ0+Xr0IixfJmaxDBwyxZIfQsJ49ZVuAmr52xhG2kvjO7YrMguLhQafZPkaU2aGMljl3ASU82NbAmqRkiGIxo6uPOuasZ8xuCFiScSs4M8HD0B8yVx1boRcEwHID42grUq43Xt0isP9hYpn7Id/MYQYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=adpOGT2Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hpggdRXJ; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="adpOGT2Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hpggdRXJ"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ED51D25401DC;
	Fri,  7 Mar 2025 09:19:04 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 07 Mar 2025 09:19:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741357144;
	 x=1741443544; bh=EB42OqKPgYccqjSUi5BBsPv0PfiBSBd8mpmIBQub4AE=; b=
	adpOGT2QkhQmtj7+NDejBx/YffRybwZ/Jnu0i/78zhZO9kBykR3LldL6o9qcZdvk
	W8RtdOxIkkJKTiG3YiPTwmtBVoHZM88NLNNm4nJyalMKeskrqouw+5UWLiPewNfv
	lGsZivTtJGRNWXyR86eDFA7fXHxJtZNE4QHE4dOKu05AX8jD5eOxGfpTIRB+6b/v
	UK0mENnLXlFxFCx9rSILE+o7peL1+3JhhEclkPeI18vTel/YwSYTJVjieDkpMzRw
	Bi1ztuiXkzWW3Iv1ZL787ZEdI/f0Jcn3Zo/ZfH/amAYvzBOyWC48zP2d+w5AP6Eu
	erp8FBhHkFSPJJ0TQxJ1Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741357144; x=
	1741443544; bh=EB42OqKPgYccqjSUi5BBsPv0PfiBSBd8mpmIBQub4AE=; b=h
	pggdRXJEiCEE76JgRnYbOnV63yskLyHRbNIMk1raDJjxnMos0jjfhDzVgT+eLssu
	LC3mX9gvaKI355JpCL4uGRj/Pel2EZLer4RQhyBmzNGLWdY2EHeEPYpd/CS62KOh
	THy4OLzfwCU88MOR7aAjMUkHf81bXkxK2ygTam9uI5envOlu4Wu/My4E0YW2AMUW
	xTR3mSbFpAgaevu2pg7G4dZv0tVPKw0o+5Ia3jUmuDUARwfm79PbdLXm4pCK6XhC
	PtZPG8N+ZiEBUm9v6hGAvazGWyNpqArJPGuW2oQKcYIOddPcKpxmPDzhy0KZtFk8
	rSkpyN2GQ1kjtU8Dhsm+g==
X-ME-Sender: <xms:WADLZwt16e8QxPgqFHarGWf2u9lo_90XnX8olLxBJjXfZTysXSo3QA>
    <xme:WADLZ9fTqJ0DKqrHY6BKhUL6kj6N5oNg5R43BqnS6ZICWhU7dYQ0Ey0DlYMVmXKiY
    UIr0QzqmJwMsShIhQ>
X-ME-Received: <xmr:WADLZ7y0yYJuriXyQJIeoeVa2g-WXEF5M-SJADkNF-qg8n3ZF7S3WUzgINW7tssHLg25rNj0TGtOCdz3SN0xoO8RHfgCaS-_1AzvfxdGGKDt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:WADLZzNIdtJYTgtCXADP-sOB4yVWp3sK1j-QikgRpK8dmDah9wW1ig>
    <xmx:WADLZw9Ugub853Xpl4r4cveF-Or3ZvQ11Rl_FUUtQJ1l1XinrZHH0w>
    <xmx:WADLZ7XgvT2bNMGZBUnH_HwJ1nuIWWCZdIybCp5pSq-pkYh1uSn-Ow>
    <xmx:WADLZ5fcNHGRIfttAov2VWi1qtGIFbZDuTEBt-d4PTJemZSYmssGFw>
    <xmx:WADLZ_bH266GPLw6wULTtrN1yb1Ihtq3FyupS9DcdX0-pOVJ2pC2mJhs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 09:19:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 40f73abe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Mar 2025 14:19:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Mar 2025 15:18:58 +0100
Subject: [PATCH v3 05/12] pack-check: stop depending on `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-b4-pks-objects-without-the-repository-v3-5-7bccf408731e@pks.im>
References: <20250307-b4-pks-objects-without-the-repository-v3-0-7bccf408731e@pks.im>
In-Reply-To: <20250307-b4-pks-objects-without-the-repository-v3-0-7bccf408731e@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

There are multiple sites in "pack-check.c" where we use the global
`the_repository` variable, either explicitly or implicitly by using
`the_hash_algo`. In all of those cases we already have a repository
available in the calling context though.

Refactor the code to instead use the caller-provided repository and
remove the `USE_THE_REPOSITORY_VARIABLE` define.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pack-check.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/pack-check.c b/pack-check.c
index 017dc740f7b..95dcbbe9852 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -44,7 +43,7 @@ int check_pack_crc(struct packed_git *p, struct pack_window **w_curs,
 	} while (len);
 
 	index_crc = p->index_data;
-	index_crc += 2 + 256 + (size_t)p->num_objects * (the_hash_algo->rawsz/4) + nr;
+	index_crc += 2 + 256 + (size_t)p->num_objects * (p->repo->hash_algo->rawsz/4) + nr;
 
 	return data_crc != ntohl(*index_crc);
 }
@@ -81,11 +80,11 @@ static int verify_packfile(struct repository *r,
 	} while (offset < pack_sig_ofs);
 	git_hash_final(hash, &ctx);
 	pack_sig = use_pack(p, w_curs, pack_sig_ofs, NULL);
-	if (!hasheq(hash, pack_sig, the_repository->hash_algo))
+	if (!hasheq(hash, pack_sig, r->hash_algo))
 		err = error("%s pack checksum mismatch",
 			    p->pack_name);
 	if (!hasheq(index_base + index_size - r->hash_algo->hexsz, pack_sig,
-		    the_repository->hash_algo))
+		    r->hash_algo))
 		err = error("%s pack checksum does not match its index",
 			    p->pack_name);
 	unuse_pack(w_curs);
@@ -132,7 +131,7 @@ static int verify_packfile(struct repository *r,
 		unuse_pack(w_curs);
 
 		if (type == OBJ_BLOB &&
-		    repo_settings_get_big_file_threshold(the_repository) <= size) {
+		    repo_settings_get_big_file_threshold(r) <= size) {
 			/*
 			 * Let stream_object_signature() check it with
 			 * the streaming interface; no point slurping
@@ -181,7 +180,7 @@ int verify_pack_index(struct packed_git *p)
 		return error("packfile %s index not opened", p->pack_name);
 
 	/* Verify SHA1 sum of the index file */
-	if (!hashfile_checksum_valid(the_repository->hash_algo, p->index_data, p->index_size))
+	if (!hashfile_checksum_valid(p->repo->hash_algo, p->index_data, p->index_size))
 		err = error("Packfile index for %s hash mismatch",
 			    p->pack_name);
 	return err;

-- 
2.49.0.rc1.455.g4cd33545ba.dirty

