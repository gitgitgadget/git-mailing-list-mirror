Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DF51531C0
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 06:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724308526; cv=none; b=KMFSFsolWRv2TqD9J8RrzCnTc+H+5CV9YONs21IE3YCMtLWP0asB04+Irm9Pm+UoV1h6AlCs1yztacE7UcwY/ACQGcU0iDbJhU+tMXhtMPqPXmapAnPLU6SL5sc0MdgBV0ybP/FsCJmJ2pDS5lzEUl84a45NKCtdA7jneNlBpnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724308526; c=relaxed/simple;
	bh=EuUGExPjVxOfWARmE63th2NOSib52j1v/PuSh4etJDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYUySRy7vBkrXs4KzRZeyE2rFwCa51rZ0cEOmwgZp+AMcSs57i7IqN8cLgTEGjIUlHc7HWD2eGbJm7UpCbyLkU9FR081zLY2FiDTQKmEN6LGaNT9jv4Cyz0c0UfYLcK0u2vYDIqw4yMpcGy8Rmsxs3gFHzsAwvk49GGg2swpiSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BSX7ay5B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mLayEAbE; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BSX7ay5B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mLayEAbE"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 733561151863;
	Thu, 22 Aug 2024 02:35:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 22 Aug 2024 02:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724308524; x=1724394924; bh=YHxMY53l8G
	B/sThGFbmnQ2rHvt78gDq+BLMlHEfGuEA=; b=BSX7ay5BCtce43Aahf8DMv6pQf
	8ZbSbJsBNTcIVQV1J53Di+oOGK4bReC8VxzQY9rVgLBvBYO73BqjAv9RF/3PdAvl
	ibqGFsEPHLpGbOT86WzefddEha5/zAWtb0kARBDJZ+sIzNEb/shbUDXuOP2pwInV
	CnONUsGffEnsxrh35gVzMYLd+3gKcJrnsj1l/UabWHovtdzWpsBtvY0ToWQ9acfo
	WdcXZBoSVfOPforTXFZwrFHEgr86GQ3416of10nFIUvAF+/Pmxt7rboZGiYQFEl3
	S5AAR5Jwp+FAL0gaHXWtjQTUJ4y+HMrJclMeDoTUYGFhRskAu9k34CEKNDDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724308524; x=1724394924; bh=YHxMY53l8GB/sThGFbmnQ2rHvt78
	gDq+BLMlHEfGuEA=; b=mLayEAbEwuwGdzUMndnZYQqXpwaTKVmVov2klPIKnepq
	AtyTTkG2/zhQaJMSUzB2cswghWfn7k4XV+TfeH4jbu0hv5Cgdg1AwChfOKZWfDUG
	BQWVYInSHeiIpQjWgUehtOk0lKQwULnyeSOw9br4x6wEePNsdhc6BSSMY9qK+gMa
	6i3V2sxcbn/eUCUjI1Rs/k/odFdBt4ApUr0ofzphSANzl7NPDWxiJQNMLAFNVwQB
	JmK4rnzAtjzy0INEk7d6doop7B59ZvlQCfuym1eaPSbZO/EIU0ZOwZysFnks/Cuc
	krm9AuI/mrgPkbApCJwotgaqhd9Dcv9Xwgr8i6Bfkg==
X-ME-Sender: <xms:LNzGZp-OTrvmVymmJ2vZPm8Y_BkK_327wE3gKrZV6QmBZMTHcmKtxQ>
    <xme:LNzGZtuvH_kMiSZ8YkPEiAGhh1N0G1pOEB-L9S6chxyt29ZCQvVFv8gx90RjglJ8R
    pUoJcLHGDzJFbfHCA>
X-ME-Received: <xmr:LNzGZnD6wIn0koheRUm7PdfW0KafZo2mbOHbStaQmbqNj0VhahWB8C3FX36opV0wzJjDRBO6MVePI-qeCdwuUX-miHlbmJIRb4QQvr-OSgHCHGI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduledguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpefgteduleethfettddthfefvdffvdffvddtleehfffh
    jeehtedvkeeileeuveeigeenucffohhmrghinhepvhgrlhdvrdhtrghrghgvthdpuhhpug
    grthgvrdgvmhgrihhlpdhuphgurghtvgdrthiipdhuphgurghtvgdrnhgvfienucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehk
    rghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:LNzGZtetTkwh8nQRbL2v1VikMdeshmpCtjJQWbMgilB96obvZ1Ui_g>
    <xmx:LNzGZuPyJh6s9sZSmQf-GrYI0WWvUv8MP_cejtPhFEncC2_kUs5r8Q>
    <xmx:LNzGZvn49xi3sriqdun0GmwhEJSmA0sez3IXKZ2omFgIDFhUT3PuGw>
    <xmx:LNzGZotJblFMRo51g6Tvzik_DRRzH-9gPBj5Ss-KgB8tJKPIGEMfpA>
    <xmx:LNzGZrokP8SNzALbBYg_PO92XQulg5zYbvP_-_Rf6dYfe0IGDvVrXjoo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 02:35:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b79b0f51 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 06:34:48 +0000 (UTC)
Date: Thu, 22 Aug 2024 08:35:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 13/15] t/helper: use `hash_to_hex_algop()` to print hashes
Message-ID: <0a3c619e8425ac0d710f827be915931f003c00ad.1724308389.git.ps@pks.im>
References: <cover.1723640107.git.ps@pks.im>
 <cover.1724308389.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724308389.git.ps@pks.im>

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
index cb22d7537a9..234fb80010f 100644
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
2.46.0.164.g477ce5ccd6.dirty

