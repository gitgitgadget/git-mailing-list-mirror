Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A04F1B29BA
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 13:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723641817; cv=none; b=InXgq4gu9ZB7k13H/OIH2N+XhavWjPLrF2PprYYhYX1+foUKfBQOW08iPdE6ZLrOmcvCSB7HL/iNNok7gt+Lo38EiLPssJuZ6MIZiY1jJT19gluz+WbDU318iFe37xyGRDO298fhCzzXNnq/3MkE4yPV3aXlkIYXCHnrTyD0WLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723641817; c=relaxed/simple;
	bh=MeuNYt9X8L52dBn9SMHZnyFI6aQ1JLxKjFDXEl1VGSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuQ0nZ49IMEmkVOpFMpIDCPvR3OWpCDebVH4JGYJ3tJY+wP9acC9n6k1PjYvIMVUD93dObbN1mGu2zBj1iyaAV1E1V8goQ7bb4MBVvDVz3Jvqvnu5+XSNNeh+qOtHAxfvG6obSKiOpiebcpMovhDe8ElhczkiyhqDC3a1CSFlDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ATg/b+ib; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lOUCiwJy; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ATg/b+ib";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lOUCiwJy"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A60A01151AAB;
	Wed, 14 Aug 2024 09:23:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 14 Aug 2024 09:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723641815; x=1723728215; bh=y16ypl84Jf
	mEjzG/+OIpd9/tCvKq3+9TJjwWNFfyW/s=; b=ATg/b+ibq9zZQHARnesd4ri8sF
	2toVHYcFDp3aPb3pYa/GiWfbrhzuMaUeRNkB/XefoJMce0NqTdcy0cWqqu7kFPRQ
	kRVcBO1RCeca5w9k7ptHaBTrO2WIfsp3ryCg2gQwFHul8tXoAK7ggGsXeQUNYnux
	K5taH+RbdPUTBz03bbwprzTLoHNoZt7vOLGawoqL5erZXYM5zKE9M/FGptdlBN0b
	G5nKHj8E3coLQqqd8mT4OAtwa3tZBDOtDL8G/v5PFMPQav5SS+8iXJdvWi27GTrb
	0VYswgPlBYD5jDaOYIeZFM9+GbeqMHJc9Yz2lLbPjrm1cXcZIh8gWKG5/vsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723641815; x=1723728215; bh=y16ypl84JfmEjzG/+OIpd9/tCvKq
	3+9TJjwWNFfyW/s=; b=lOUCiwJymTLodDGfWg1mKD37WPWVEFL4bbiuZRAnc9uu
	fcRUBYtoV6ES+q3PpVnlnDDVS3GREmNe/YVh/vp3aBNuVjOk5er75YNe4D/6jT7h
	J3ItascJC1F7Q2TiS6t4vWMCy7Ou7J4QjErIZf+JGjoTtbeVQbsZTX+3N6SUokq3
	2l2carM73lo9YMYtYEZgVkDu6pv+GJJBL90bsYG5hXkH582ASUWx6IL0I+Y3RGPA
	GRlF7JJqfzNQsVrbZTES+1Qbx0W5NzWxT64ZKkcPNSLHdzoY4G2lap9D3dNNaiwN
	+5osEAHFmzpjzD5yFGiBiEbj9/Q/pq8aROoxnAArVw==
X-ME-Sender: <xms:16-8Zp7RZ8ZNIEgcLgSIICFHIstne1yiWVIOTxdW5vojnaMEDip16g>
    <xme:16-8Zm5QJkrDZGiIhupMUEsZH58pc_7sfdYvgwIYCwymZvptymd_vnYobmOD489j1
    sQMTLdZ3Q4MUFZkzg>
X-ME-Received: <xmr:16-8ZgdrW3-t57epuIsEwC4k5ior1lpCLtWAjPZEtPsp7uoyGCVng3OfgI9cvGAMcmZNDWlUmw94Q83XiWVdMnw9ZO8JCqGfIvpfoHcBKfPbJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtgedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepgfetudeltefhtedttdfhfedvffdvffdvtdelheffhfej
    heetvdekieelueevieegnecuffhomhgrihhnpehvrghlvddrthgrrhhgvghtpdhuphgurg
    htvgdrvghmrghilhdpuhhpuggrthgvrdhtiidpuhhpuggrthgvrdhnvgifnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgr
    rhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:16-8ZiJIbF3HXz_j4C6XPVzHS4jIG1jKJ41e9NK5_ajRBmQDnKZ31Q>
    <xmx:16-8ZtIGhUfbFgO45DyxIEKKi252UW-VuYmpcjAqCZjdJ3M2HsJz4A>
    <xmx:16-8ZrwvQ95v4Qu0yCEzoz_bg5oCRX0yJO3v8Y3p5QUhRfiLust0EA>
    <xmx:16-8ZpLMa3tRwdVRl0wdPeupRnVb0Z2kYnj4bf0ke5SeG9NI-aDjKw>
    <xmx:16-8ZkVch_7GbES2KtJIL_zGBsTk-Zq3Yw7T1o3bZMCP0c177x8x2cuR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 09:23:34 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7926ec21 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 13:23:15 +0000 (UTC)
Date: Wed, 14 Aug 2024 15:23:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v2 13/15] t/helper: use `hash_to_hex_algop()` to print hashes
Message-ID: <5498395872c2aad9504910522ca0ac441728c21d.1723640107.git.ps@pks.im>
References: <cover.1723640107.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723640107.git.ps@pks.im>

The "reftable" test helper uses a hand-crafted version to convert from a
raw hash to its hex variant. This was done because this code used to be
part of the reftable library, where we do not use most functions from
the Git core.

Now that the code is integrated into the "dump-reftable" helper though,
that limitation went away. Let's thus use `hash_to_hex_algop()` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-reftable.c | 48 +++++++++-------------------------------
 1 file changed, 11 insertions(+), 37 deletions(-)

diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index cb22d7537a..234fb80010 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -1,3 +1,6 @@
+#include "git-compat-util.h"
+#include "hash.h"
+#include "hex.h"
 #include "reftable/system.h"
 #include "reftable/reftable-error.h"
 #include "reftable/reftable-generic.h"
@@ -30,33 +33,12 @@ static void print_help(void)
 	       "\n");
 }
 
-static char hexdigit(int c)
-{
-	if (c <= 9)
-		return '0' + c;
-	return 'a' + (c - 10);
-}
-
-static void hex_format(char *dest, const unsigned char *src, int hash_size)
-{
-	assert(hash_size > 0);
-	if (src) {
-		int i = 0;
-		for (i = 0; i < hash_size; i++) {
-			dest[2 * i] = hexdigit(src[i] >> 4);
-			dest[2 * i + 1] = hexdigit(src[i] & 0xf);
-		}
-		dest[2 * hash_size] = 0;
-	}
-}
-
 static int dump_table(struct reftable_table *tab)
 {
 	struct reftable_iterator it = { NULL };
 	struct reftable_ref_record ref = { NULL };
 	struct reftable_log_record log = { NULL };
-	uint32_t hash_id = reftable_table_hash_id(tab);
-	int hash_len = hash_size(hash_id);
+	const struct git_hash_algo *algop;
 	int err;
 
 	reftable_table_init_ref_iter(tab, &it);
@@ -65,9 +47,9 @@ static int dump_table(struct reftable_table *tab)
 	if (err < 0)
 		return err;
 
-	while (1) {
-		char hex[GIT_MAX_HEXSZ + 1] = { 0 }; /* BUG */
+	algop = &hash_algos[hash_algo_by_id(reftable_table_hash_id(tab))];
 
+	while (1) {
 		err = reftable_iterator_next_ref(&it, &ref);
 		if (err > 0)
 			break;
@@ -80,15 +62,11 @@ static int dump_table(struct reftable_table *tab)
 			printf("=> %s", ref.value.symref);
 			break;
 		case REFTABLE_REF_VAL2:
-			hex_format(hex, ref.value.val2.value, hash_len);
-			printf("val 2 %s", hex);
-			hex_format(hex, ref.value.val2.target_value,
-				   hash_len);
-			printf("(T %s)", hex);
+			printf("val 2 %s", hash_to_hex_algop(ref.value.val2.value, algop));
+			printf("(T %s)", hash_to_hex_algop(ref.value.val2.target_value, algop));
 			break;
 		case REFTABLE_REF_VAL1:
-			hex_format(hex, ref.value.val1, hash_len);
-			printf("val 1 %s", hex);
+			printf("val 1 %s", hash_to_hex_algop(ref.value.val1, algop));
 			break;
 		case REFTABLE_REF_DELETION:
 			printf("delete");
@@ -106,8 +84,6 @@ static int dump_table(struct reftable_table *tab)
 		return err;
 
 	while (1) {
-		char hex[GIT_MAX_HEXSZ + 1] = { 0 };
-
 		err = reftable_iterator_next_log(&it, &log);
 		if (err > 0)
 			break;
@@ -126,10 +102,8 @@ static int dump_table(struct reftable_table *tab)
 			       log.value.update.email ? log.value.update.email : "",
 			       log.value.update.time,
 			       log.value.update.tz_offset);
-			hex_format(hex, log.value.update.old_hash, hash_len);
-			printf("%s => ", hex);
-			hex_format(hex, log.value.update.new_hash, hash_len);
-			printf("%s\n\n%s\n}\n", hex,
+			printf("%s => ", hash_to_hex_algop(log.value.update.old_hash, algop));
+			printf("%s\n\n%s\n}\n", hash_to_hex_algop(log.value.update.new_hash, algop),
 			       log.value.update.message ? log.value.update.message : "");
 			break;
 		}
-- 
2.46.0.46.g406f326d27.dirty

