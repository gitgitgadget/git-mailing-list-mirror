Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A26214F138
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 06:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724308524; cv=none; b=DZ1ayYYIjcPYpN/5PblngBaZO9sZyrGIo8Tkmg4hjdocj8I4aDprkhqLwgQaLsMImkBbudI2jUfYNo0o9LEHlHznFClrK1bKfR0zC6xqtCpZOaMbxinDE/Ayk4cY/DISgIEY7/4ml6dgPkAwHCz/fIxDSrU/lNDZrDUkIFVdK4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724308524; c=relaxed/simple;
	bh=LcSxVzmmWAQ6i8vqs/M6zriyybkkWjemQ9+bd8tDVMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVY9whHk22YMfxcCnJsuEYckzp3u6LIIYShCWYsuyhvQv3W41fHUkGEnpf0fiWhe72crOG62IOT/EfIb+qkuPMtyVb2V+IyYLJ9rwF0iiEYJglE5JpBl3BA1zLwtTnZiTlfSRwv/7jvcroN/B9bV3OLG/akgT6EGF9Uypj+Wilw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qMFN8isE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gGOX+fCg; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qMFN8isE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gGOX+fCg"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3C5381151AF6;
	Thu, 22 Aug 2024 02:35:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 22 Aug 2024 02:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724308521; x=1724394921; bh=ZztTG6Tilb
	FBcBYG4zD6gPvBQaYUN5UFBFv3nvc/tjU=; b=qMFN8isEWnbIBmZNLKBWkMGXl/
	tjcX1ljmtiRq2nAOqNj3s7ZvS/V61vsbJl6Dy15KNROtD9Y3vpU90wl7oPLw4/LK
	xd5UONR3t6RWYVRPK08iQPgyNI/GCg3iwFOVYIqPLRrdJffda9Pdg+BDE1Po5XwM
	g6TOTWSliMpRR2c4GgASP1jkDaQ441ru0Dcvbl441V9R4j7lSTzmlHq01g5X2YBs
	kjhv8NzITk8JL4Sf0eHx62oTt903cL2Xk/LMEd8ZitmsoCFaKckIAcxFNiN+17QE
	RFATRnO2rysOBijA9JnxZ2Do2nyEtSdBRer4dKPODlYcbH2jAUYLeXHvlKiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724308521; x=1724394921; bh=ZztTG6TilbFBcBYG4zD6gPvBQaYU
	N5UFBFv3nvc/tjU=; b=gGOX+fCgHbWOwPGvTOG8ixH6saZzm3ydLHPmc0GWaCMF
	0XN6R6VkkFUYjMjEFlFPr8nJHsfY2G/pbgUp+1G7WAhGKZjVAeX0TI0/TiuhfEQY
	ZZ1jcTzT9vAy5Uk8JFv6F4gciYrLawFlegqQ9Oxjt9dfCQp6MniqQZ+iLUiwVjvV
	7qbjkuutQa+IaS8vGKMuQNGjyZpvzkHzOhYBJlyALqgHcEg2YIewxlaryyPMmsep
	bWAMl3AAZNY0ikob//aI1rIeMkkTa1uraRI6gv+SrLStWE+JnxLPdeff+iRJtQ7x
	TTmPjY0GVdXvhw0LX6XlwHuDW/V8mP0rJTqVbKGztg==
X-ME-Sender: <xms:KdzGZuZMUrMGZS8Fua5x2J9AC8ekmj66EtbVpyQC6lFvDfxaSm_lpQ>
    <xme:KdzGZhZ-H-u8AClJuG1HFrjeffWu1zK-2jcYxZmAwj2ceNGb7LlYS8iU1QmF1HaMJ
    _9Ht6g9D9aLVKAdWA>
X-ME-Received: <xmr:KdzGZo_LWK819PlDDpbNlaufrcRbQXGSw2crrW2luAkTyRCAAPCSU45e3qlOuEeuuuKJiG92DwHkB2aUONZ98a9AqffLKI_R6m5BDty4JFsmnec>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduledguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeetgeeutedufeeiheejvdeuvdetuefhveegvedvtddv
    udevtefgffejteekvdfhtdenucffohhmrghinhepvhgrlhdvrdhtrghrghgvthdpuhhpug
    grthgvrdhnrghmvgdpuhhpuggrthgvrdgvmhgrihhlpdhuphgurghtvgdrthiipdhuphgu
    rghtvgdrnhgvfienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtth
    hopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:KdzGZgqSaF4w8pXPsLNK8Q6lfZgffJ9t57lUZPqB5-KDgw06yCTK4w>
    <xmx:KdzGZpruNq_ONgh4MKisfpRfChD_-A0mVUyL2swSTXr5M227p11dIg>
    <xmx:KdzGZuSPoPd4V4jPUmd_Ur1iYQvyTJR-TCjsQg8LAb6ohH__A62hwg>
    <xmx:KdzGZpqtcYGmg4ZQXRBwR_HD9CUbyofSrVzxmbMM_piooZVdlk_PsQ>
    <xmx:KdzGZgWOrfK8t1BAoKx9njz3ckzAMVJfs6DE6nDkWyrxaAbFQ1GnU3a_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 02:35:20 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2dfafab1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 06:34:45 +0000 (UTC)
Date: Thu, 22 Aug 2024 08:35:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 12/15] t/helper: inline printing of reftable records
Message-ID: <ee22a08e11e74abadb0daa05d1023f46d689e2ed.1724308389.git.ps@pks.im>
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

Move printing of reftable records into the "dump-reftable" helper. This
follows the same reasoning as the preceding commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.c          | 127 -------------------------------------
 reftable/record.h          |   1 -
 reftable/reftable-record.h |   8 ---
 t/helper/test-reftable.c   |  77 +++++++++++++++++++---
 4 files changed, 69 insertions(+), 144 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index a2cba5ef747..e26bd4bc8d9 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -259,58 +259,6 @@ static void reftable_ref_record_copy_from(void *rec, const void *src_rec,
 	}
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
-static void reftable_ref_record_print_sz(const struct reftable_ref_record *ref,
-					 int hash_size)
-{
-	char hex[GIT_MAX_HEXSZ + 1] = { 0 }; /* BUG */
-	printf("ref{%s(%" PRIu64 ") ", ref->refname, ref->update_index);
-	switch (ref->value_type) {
-	case REFTABLE_REF_SYMREF:
-		printf("=> %s", ref->value.symref);
-		break;
-	case REFTABLE_REF_VAL2:
-		hex_format(hex, ref->value.val2.value, hash_size);
-		printf("val 2 %s", hex);
-		hex_format(hex, ref->value.val2.target_value,
-			   hash_size);
-		printf("(T %s)", hex);
-		break;
-	case REFTABLE_REF_VAL1:
-		hex_format(hex, ref->value.val1, hash_size);
-		printf("val 1 %s", hex);
-		break;
-	case REFTABLE_REF_DELETION:
-		printf("delete");
-		break;
-	}
-	printf("}\n");
-}
-
-void reftable_ref_record_print(const struct reftable_ref_record *ref,
-			       uint32_t hash_id) {
-	reftable_ref_record_print_sz(ref, hash_size(hash_id));
-}
-
 static void reftable_ref_record_release_void(void *rec)
 {
 	reftable_ref_record_release(rec);
@@ -480,12 +428,6 @@ static int reftable_ref_record_cmp_void(const void *_a, const void *_b)
 	return strcmp(a->refname, b->refname);
 }
 
-static void reftable_ref_record_print_void(const void *rec,
-					   int hash_size)
-{
-	reftable_ref_record_print_sz((struct reftable_ref_record *) rec, hash_size);
-}
-
 static struct reftable_record_vtable reftable_ref_record_vtable = {
 	.key = &reftable_ref_record_key,
 	.type = BLOCK_TYPE_REF,
@@ -497,7 +439,6 @@ static struct reftable_record_vtable reftable_ref_record_vtable = {
 	.is_deletion = &reftable_ref_record_is_deletion_void,
 	.equal = &reftable_ref_record_equal_void,
 	.cmp = &reftable_ref_record_cmp_void,
-	.print = &reftable_ref_record_print_void,
 };
 
 static void reftable_obj_record_key(const void *r, struct strbuf *dest)
@@ -516,21 +457,6 @@ static void reftable_obj_record_release(void *rec)
 	memset(obj, 0, sizeof(struct reftable_obj_record));
 }
 
-static void reftable_obj_record_print(const void *rec, int hash_size)
-{
-	const struct reftable_obj_record *obj = rec;
-	char hex[GIT_MAX_HEXSZ + 1] = { 0 };
-	struct strbuf offset_str = STRBUF_INIT;
-	int i;
-
-	for (i = 0; i < obj->offset_len; i++)
-		strbuf_addf(&offset_str, "%" PRIu64 " ", obj->offsets[i]);
-	hex_format(hex, obj->hash_prefix, obj->hash_prefix_len);
-	printf("prefix %s (len %d), offsets [%s]\n",
-	       hex, obj->hash_prefix_len, offset_str.buf);
-	strbuf_release(&offset_str);
-}
-
 static void reftable_obj_record_copy_from(void *rec, const void *src_rec,
 					  int hash_size)
 {
@@ -701,41 +627,8 @@ static struct reftable_record_vtable reftable_obj_record_vtable = {
 	.is_deletion = &not_a_deletion,
 	.equal = &reftable_obj_record_equal_void,
 	.cmp = &reftable_obj_record_cmp_void,
-	.print = &reftable_obj_record_print,
 };
 
-static void reftable_log_record_print_sz(struct reftable_log_record *log,
-					 int hash_size)
-{
-	char hex[GIT_MAX_HEXSZ + 1] = { 0 };
-
-	switch (log->value_type) {
-	case REFTABLE_LOG_DELETION:
-		printf("log{%s(%" PRIu64 ") delete\n", log->refname,
-		       log->update_index);
-		break;
-	case REFTABLE_LOG_UPDATE:
-		printf("log{%s(%" PRIu64 ") %s <%s> %" PRIu64 " %04d\n",
-		       log->refname, log->update_index,
-		       log->value.update.name ? log->value.update.name : "",
-		       log->value.update.email ? log->value.update.email : "",
-		       log->value.update.time,
-		       log->value.update.tz_offset);
-		hex_format(hex, log->value.update.old_hash, hash_size);
-		printf("%s => ", hex);
-		hex_format(hex, log->value.update.new_hash, hash_size);
-		printf("%s\n\n%s\n}\n", hex,
-		       log->value.update.message ? log->value.update.message : "");
-		break;
-	}
-}
-
-void reftable_log_record_print(struct reftable_log_record *log,
-				      uint32_t hash_id)
-{
-	reftable_log_record_print_sz(log, hash_size(hash_id));
-}
-
 static void reftable_log_record_key(const void *r, struct strbuf *dest)
 {
 	const struct reftable_log_record *rec =
@@ -1039,11 +932,6 @@ static int reftable_log_record_is_deletion_void(const void *p)
 		(const struct reftable_log_record *)p);
 }
 
-static void reftable_log_record_print_void(const void *rec, int hash_size)
-{
-	reftable_log_record_print_sz((struct reftable_log_record*)rec, hash_size);
-}
-
 static struct reftable_record_vtable reftable_log_record_vtable = {
 	.key = &reftable_log_record_key,
 	.type = BLOCK_TYPE_LOG,
@@ -1055,7 +943,6 @@ static struct reftable_record_vtable reftable_log_record_vtable = {
 	.is_deletion = &reftable_log_record_is_deletion_void,
 	.equal = &reftable_log_record_equal_void,
 	.cmp = &reftable_log_record_cmp_void,
-	.print = &reftable_log_record_print_void,
 };
 
 static void reftable_index_record_key(const void *r, struct strbuf *dest)
@@ -1137,13 +1024,6 @@ static int reftable_index_record_cmp(const void *_a, const void *_b)
 	return strbuf_cmp(&a->last_key, &b->last_key);
 }
 
-static void reftable_index_record_print(const void *rec, int hash_size)
-{
-	const struct reftable_index_record *idx = rec;
-	/* TODO: escape null chars? */
-	printf("\"%s\" %" PRIu64 "\n", idx->last_key.buf, idx->offset);
-}
-
 static struct reftable_record_vtable reftable_index_record_vtable = {
 	.key = &reftable_index_record_key,
 	.type = BLOCK_TYPE_INDEX,
@@ -1155,7 +1035,6 @@ static struct reftable_record_vtable reftable_index_record_vtable = {
 	.is_deletion = &not_a_deletion,
 	.equal = &reftable_index_record_equal,
 	.cmp = &reftable_index_record_cmp,
-	.print = &reftable_index_record_print,
 };
 
 void reftable_record_key(struct reftable_record *rec, struct strbuf *dest)
@@ -1334,9 +1213,3 @@ void reftable_record_init(struct reftable_record *rec, uint8_t typ)
 		BUG("unhandled record type");
 	}
 }
-
-void reftable_record_print(struct reftable_record *rec, int hash_size)
-{
-	printf("'%c': ", rec->type);
-	reftable_record_vtable(rec)->print(reftable_record_data(rec), hash_size);
-}
diff --git a/reftable/record.h b/reftable/record.h
index d778133e6ec..5003bacdb0c 100644
--- a/reftable/record.h
+++ b/reftable/record.h
@@ -136,7 +136,6 @@ void reftable_record_init(struct reftable_record *rec, uint8_t typ);
 /* see struct record_vtable */
 int reftable_record_cmp(struct reftable_record *a, struct reftable_record *b);
 int reftable_record_equal(struct reftable_record *a, struct reftable_record *b, int hash_size);
-void reftable_record_print(struct reftable_record *rec, int hash_size);
 void reftable_record_key(struct reftable_record *rec, struct strbuf *dest);
 void reftable_record_copy_from(struct reftable_record *rec,
 			       struct reftable_record *src, int hash_size);
diff --git a/reftable/reftable-record.h b/reftable/reftable-record.h
index ff486eb1f75..2d42463c581 100644
--- a/reftable/reftable-record.h
+++ b/reftable/reftable-record.h
@@ -60,10 +60,6 @@ const unsigned char *reftable_ref_record_val2(const struct reftable_ref_record *
 /* returns whether 'ref' represents a deletion */
 int reftable_ref_record_is_deletion(const struct reftable_ref_record *ref);
 
-/* prints a reftable_ref_record onto stdout. Useful for debugging. */
-void reftable_ref_record_print(const struct reftable_ref_record *ref,
-			       uint32_t hash_id);
-
 /* frees and nulls all pointer values inside `ref`. */
 void reftable_ref_record_release(struct reftable_ref_record *ref);
 
@@ -111,8 +107,4 @@ void reftable_log_record_release(struct reftable_log_record *log);
 int reftable_log_record_equal(const struct reftable_log_record *a,
 			      const struct reftable_log_record *b, int hash_size);
 
-/* dumps a reftable_log_record on stdout, for debugging/testing. */
-void reftable_log_record_print(struct reftable_log_record *log,
-			       uint32_t hash_id);
-
 #endif
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 82159fa51f4..cb22d7537a9 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -30,12 +30,33 @@ static void print_help(void)
 	       "\n");
 }
 
+static char hexdigit(int c)
+{
+	if (c <= 9)
+		return '0' + c;
+	return 'a' + (c - 10);
+}
+
+static void hex_format(char *dest, const unsigned char *src, int hash_size)
+{
+	assert(hash_size > 0);
+	if (src) {
+		int i = 0;
+		for (i = 0; i < hash_size; i++) {
+			dest[2 * i] = hexdigit(src[i] >> 4);
+			dest[2 * i + 1] = hexdigit(src[i] & 0xf);
+		}
+		dest[2 * hash_size] = 0;
+	}
+}
+
 static int dump_table(struct reftable_table *tab)
 {
 	struct reftable_iterator it = { NULL };
 	struct reftable_ref_record ref = { NULL };
 	struct reftable_log_record log = { NULL };
 	uint32_t hash_id = reftable_table_hash_id(tab);
+	int hash_len = hash_size(hash_id);
 	int err;
 
 	reftable_table_init_ref_iter(tab, &it);
@@ -45,14 +66,35 @@ static int dump_table(struct reftable_table *tab)
 		return err;
 
 	while (1) {
+		char hex[GIT_MAX_HEXSZ + 1] = { 0 }; /* BUG */
+
 		err = reftable_iterator_next_ref(&it, &ref);
-		if (err > 0) {
+		if (err > 0)
 			break;
-		}
-		if (err < 0) {
+		if (err < 0)
 			return err;
+
+		printf("ref{%s(%" PRIu64 ") ", ref.refname, ref.update_index);
+		switch (ref.value_type) {
+		case REFTABLE_REF_SYMREF:
+			printf("=> %s", ref.value.symref);
+			break;
+		case REFTABLE_REF_VAL2:
+			hex_format(hex, ref.value.val2.value, hash_len);
+			printf("val 2 %s", hex);
+			hex_format(hex, ref.value.val2.target_value,
+				   hash_len);
+			printf("(T %s)", hex);
+			break;
+		case REFTABLE_REF_VAL1:
+			hex_format(hex, ref.value.val1, hash_len);
+			printf("val 1 %s", hex);
+			break;
+		case REFTABLE_REF_DELETION:
+			printf("delete");
+			break;
 		}
-		reftable_ref_record_print(&ref, hash_id);
+		printf("}\n");
 	}
 	reftable_iterator_destroy(&it);
 	reftable_ref_record_release(&ref);
@@ -64,14 +106,33 @@ static int dump_table(struct reftable_table *tab)
 		return err;
 
 	while (1) {
+		char hex[GIT_MAX_HEXSZ + 1] = { 0 };
+
 		err = reftable_iterator_next_log(&it, &log);
-		if (err > 0) {
+		if (err > 0)
 			break;
-		}
-		if (err < 0) {
+		if (err < 0)
 			return err;
+
+		switch (log.value_type) {
+		case REFTABLE_LOG_DELETION:
+			printf("log{%s(%" PRIu64 ") delete\n", log.refname,
+			       log.update_index);
+			break;
+		case REFTABLE_LOG_UPDATE:
+			printf("log{%s(%" PRIu64 ") %s <%s> %" PRIu64 " %04d\n",
+			       log.refname, log.update_index,
+			       log.value.update.name ? log.value.update.name : "",
+			       log.value.update.email ? log.value.update.email : "",
+			       log.value.update.time,
+			       log.value.update.tz_offset);
+			hex_format(hex, log.value.update.old_hash, hash_len);
+			printf("%s => ", hex);
+			hex_format(hex, log.value.update.new_hash, hash_len);
+			printf("%s\n\n%s\n}\n", hex,
+			       log.value.update.message ? log.value.update.message : "");
+			break;
 		}
-		reftable_log_record_print(&log, hash_id);
 	}
 	reftable_iterator_destroy(&it);
 	reftable_log_record_release(&log);
-- 
2.46.0.164.g477ce5ccd6.dirty

