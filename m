Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6B71AE867
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 13:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723641814; cv=none; b=V0dEE3IaKQffwFe5feMD0MnI/dJzJepfz9A+uLl8LNgudWwbswOtpOBPomwsQb0mDwk1IVgodbb9E7Td1ckyReKY+2SOnGdzRmw2pleIbjG4U15C5STjvGQnPvuFS+l29QM+XtpES9xFkf522s8NiUmNHDsKQYQ2KnDuEHqIlNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723641814; c=relaxed/simple;
	bh=RD0gYYAyUQiLnRWW4qTxXdv4hUNnF513eTQuiGAmNlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBrVwnjVjJ72ygNbLU5YcATUKm5mlIunvBO+htpjD2YlUlb/q/u18WDiqtRL1p1Fl4UHtzOye1IS5wywxCl9m7GXmH41iRtMio8WbWq1YOoVKO6kQl+DinhzOnPBr06fwAd23u8C4wA/d9c66XH60uBx7ywX+tk9wfQi60Ru5TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Px9kTHl5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FmiZKz6S; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Px9kTHl5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FmiZKz6S"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 98842138FD33;
	Wed, 14 Aug 2024 09:23:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 14 Aug 2024 09:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723641811; x=1723728211; bh=DyMfzlxGZ9
	ibx/eIoyLDlu3Ax7SffuC4yGmzvQJOBZA=; b=Px9kTHl57zB9vcO8Xbb+MEcvhJ
	WsGYqkhjITgHff3o1UnKu5fIJLEYSjWJvwZkq2l3Er5uy5NtD3mwT92leRi9SK7D
	s71Ewc9hrI3o71DhfH40x4wWlyKEdfHhov1BshLql45IeazSc8HIaN4xODgn+2SZ
	W/KvC/djf1/EloTZtul/tguM5dXJ5QKXY7ncq1rVbrXScbQnCz8yECUSJ90YOdiR
	dEX8EeNj2ncM1UB0ImVzB5hjq1lo/d9M5zyZPzlRzNLpXzEOJFWdKpuKvm4lb9u9
	de3fcx1gM50RnnLZF5rl9phfKOTMJP9+ewR+YOxQ+miLlYUGVeOzDy/UHgJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723641811; x=1723728211; bh=DyMfzlxGZ9ibx/eIoyLDlu3Ax7Sf
	fuC4yGmzvQJOBZA=; b=FmiZKz6S/p95SeEhcvmEvNMAUBeMSlux8zXcoYwch1XV
	dnBmE659sbrcCJ3nwn+u4Jh4tKG/CYD7aKG8V5xGbfLqFSwhOw3vsOPiwgV9cMxT
	p2rdmtQDLHt5Vxx7EgIbY8VnhBLZ9EdoO8NTdavgfDxoI8MtuZOzVEJ1sBcmkog6
	emTy2QIpCKnVoM6VeeNhUUG+bXDcKx8VXUfWF2VobzMp4boMdiWh7jiEdqCCPp6D
	sqyyUMdzJj4/yXhAZzNL55uOInopvGpU1yaJXVilZPVz0kQIcFvS+osDFUM6ALwa
	1EM/JqYoMmKl1mB9BBlW/XprPDhomLW06PeAos9lyg==
X-ME-Sender: <xms:06-8ZvgwgjO_do48fnhhH7oWI92j3z37ofnkEYSW4i91xbtpR3Zo8w>
    <xme:06-8ZsDFA2O22Snrz9c8TPgXcm6_K9WG4w0IX1hIFCDeV4pFNp0k-8lwqJCTuc0H4
    u6w8ObeaUHdkxAlRg>
X-ME-Received: <xmr:06-8ZvEKplBe6W8YcC9ZB87SchoEu9FCu4RNYC8FzP56GqfPwiEytMK7zZHnGP2h5fx5Ex46ASEui0YXyoxtys5_Je7Dk9RwX4i54jtAZnOS0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtgedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepteegueetudefieehjedvuedvteeuhfevgeevvddtvddu
    veetgfffjeetkedvhfdtnecuffhomhgrihhnpehvrghlvddrthgrrhhgvghtpdhuphgurg
    htvgdrnhgrmhgvpdhuphgurghtvgdrvghmrghilhdpuhhpuggrthgvrdhtiidpuhhpuggr
    thgvrdhnvgifnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:06-8ZsSalt3zVob94o2zePFVqNWhpzbdV9l-1vbz-oaoR-voNx8hog>
    <xmx:06-8ZszBH4mnDeHB9kxsqjLgeD7G2DZXh33dONTk9HuOPz7zT0p9Yw>
    <xmx:06-8Zi5omfu_Kna7OHxQM69M0cNkKURbYj2Me-txhB3JmHu0DDskdg>
    <xmx:06-8ZhxB8FS79lBtJunpTMYrma1tGpw1Yzc88fD1xXQso4NLKdS8rg>
    <xmx:06-8Zn-8vNnwxSf90KUwXH3f0AZSq-t5n7dl4zsLrXdGEpZRU_UgFcjI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 09:23:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f633b06b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 13:23:11 +0000 (UTC)
Date: Wed, 14 Aug 2024 15:23:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v2 12/15] t/helper: inline printing of reftable records
Message-ID: <c50aabbb8043af148c72ded123d2ac7538c564d3.1723640107.git.ps@pks.im>
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
index a2cba5ef74..e26bd4bc8d 100644
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
index d778133e6e..5003bacdb0 100644
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
index ff486eb1f7..2d42463c58 100644
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
index 82159fa51f..cb22d7537a 100644
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
2.46.0.46.g406f326d27.dirty

