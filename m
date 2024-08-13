Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C403B791
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 06:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723530280; cv=none; b=q+608KB3jwHdrX84/MegV7cohrVggebE83MSFBbqT/w1w40l7epnsEflgJzzvoKkYfTxblgYMpUejWxAwlTowXo+cwjM0cxkSC335wQRlfI+PuGYP77h0MxOZN/A3+xLC5oU4EpcUXLwapRX0tftuTf8mwLrq+ZOHQK65S6Cw3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723530280; c=relaxed/simple;
	bh=sbm2LABtedkEkw6qh62E/XYlwAsIg3FOTYGO0VDt//E=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuiYPHVXWCox8Q/muYvxrM19g37viHnz2frIXLPHurMf8wbR91Sx2b2nBaJRHMMofy+VT4ITmsfAerIT3Ba7Dxnzm2eHespiCg3SQ7+f4vLq13w0jzWgM0J3kd6EtK3Togu7/luko25vZUHZq8bWTmvQq99u7TbZB21fwwvd2eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BVMdOHNO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B/UA7Unp; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BVMdOHNO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B/UA7Unp"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id DAFD7138FD36
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 02:24:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 13 Aug 2024 02:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723530277; x=1723616677; bh=LV16Lv5WoF
	3bfbCT8dIHSa4VkKsYmQyknu+3joM6svI=; b=BVMdOHNOYJtvxMnOA0DZs6jRis
	BSRDeluG7Nxu0Se9c+7TdiQtiUNKZqO4IzmGUSp8LBMFSeBLIQCWGQWHaBZhdu3C
	U/eUeZJxz+9iTowuvdHRTb5SVZeyx8qGK7NT85aDOUajyd9zv6ufejH2qWC7ma6r
	YUBl7eEja8SmoHdAVSjEBGvLaDHCP74sxfbCp7VfLjufOs01m6o1hxmLw4zLWOtL
	EJXe9IgNtwv4TplgaaBGbUTVYl/6nPhGSC1DWkzRF9hZItWbdHjUUmFWocunrJZt
	grZsRhutPJ18Du9AgzItEwF9bu+qwB3rsQeJsreiWrm/jXikUTM+zGtRe1pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723530277; x=1723616677; bh=LV16Lv5WoF3bfbCT8dIHSa4VkKsY
	mQyknu+3joM6svI=; b=B/UA7UnpFkuS3O5TkBug5m2uYsjhk8KqalXqqzl6Pp9N
	mUoTwfdJuObl78UiPrALmm2fGu69mJAr7AElvnFuOdly8z2QNG6PIUZcu+kYRXzh
	RuE0L2MgAJjCkTd6UiBKk5uwrQW29hm1PvnL9hWA5yrJRrxNO6kM1R37vmcVzwvB
	OXwyBCGV2htp4RxbiYMzbXMDEUkAmUe9WJElt668RjwGjXf9TJUezJ7CaCf2QpUG
	vnV7TLJydsxlw3R2vDh8tN20WrDBDzIq4oDnMjoKjQjUpuuIULFxH5Wm3uEnPjh6
	bH4dxd9PdWnJ/udt2hrPYQITNb4sDRmcylRpClQ1Nw==
X-ME-Sender: <xms:Jfy6ZujvKprGgcgvKHCGYwyDIXlOWsaGxyX2gQd6dnHQjipFkLhGgA>
    <xme:Jfy6ZvCxqNmCk0_2QHy4zvmeJTN5zB1kAmkQnq6SJ5aKMm6L-5ypCbOjrGGVeQBRA
    ly31OLjfbKB6dMXPQ>
X-ME-Received: <xmr:Jfy6ZmG7UV1cbWUf5o0eTbklO0Db0hUORX1zvFcqeKrMBsQ-RFByicyi2qyrzRx5eeB7b_wJZgvPHQXekie72AjrwuITBF0uQD7dDcnGgmjgNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtuddguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeetleegteevte
    euhfeigfefjeejffdttefhvdevtefghfeuhefgtdfhffefffeugeenucffohhmrghinhep
    vhgrlhdvrdhtrghrghgvthdpuhhpuggrthgvrdhnrghmvgdpuhhpuggrthgvrdgvmhgrih
    hlpdhuphgurghtvgdrthiipdhuphgurghtvgdrnhgvfienucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtph
    htthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Jfy6ZnRadUqOQ0z-vaC80jxQ5ZL6579plwRtUJ2mKErgV_oTIdnXkA>
    <xmx:Jfy6Zrx_b1oEv7yhHu1851wZCGgNPXfWp5vvC2gp645VOOcNTIAm3A>
    <xmx:Jfy6Zl7ncvhSu0KWNNR-ZcDdsBOkt9yMoBEtr0pSdsFsH7xHXVfHJg>
    <xmx:Jfy6ZoyIEEYiYvoViZUcx_20A9dlUl3wi0qx_pGvgku7uiHL-JHKTQ>
    <xmx:Jfy6ZkrAabb9YKLuvaanqo4iFkjWpfmOAGXDIZO4vlVn1M9R8looigA4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 13 Aug 2024 02:24:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4ad9bb61 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 13 Aug 2024 06:24:20 +0000 (UTC)
Date: Tue, 13 Aug 2024 08:24:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 08/10] reftable/dump: drop unused printing functionality
Message-ID: <1f211e514d049379ada609e6a4e8cf985e721271.1723528765.git.ps@pks.im>
References: <cover.1723528765.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723528765.git.ps@pks.im>

We have a bunch of infrastructure wired up that allows us to print
reftable records, tables and stacks. While this functionality is wired
up via various "test-tool reftable" options, it is never used. It also
feels kind of dubious whether any other eventual user of the reftable
library should use it as it very much feels like a debugging aid rather
than something sensible. The format itself is somewhat inscrutable and
the infrastructure is non-extensible.

Drop this code. The only remaining function in this context is
`reftable_reader_print_blocks()`, which we do use in our tests.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/dump.c             |  16 +----
 reftable/generic.c          |  47 -------------
 reftable/reader.c           |  21 ------
 reftable/record.c           | 127 ------------------------------------
 reftable/record.h           |   4 --
 reftable/reftable-generic.h |   3 -
 reftable/reftable-reader.h  |   2 -
 reftable/reftable-record.h  |   8 ---
 reftable/reftable-stack.h   |   3 -
 reftable/stack.c            |  20 ------
 reftable/stack_test.c       |   7 --
 11 files changed, 1 insertion(+), 257 deletions(-)

diff --git a/reftable/dump.c b/reftable/dump.c
index 2953e0a83a..35a1731da9 100644
--- a/reftable/dump.c
+++ b/reftable/dump.c
@@ -41,9 +41,6 @@ int reftable_dump_main(int argc, char *const *argv)
 {
 	int err = 0;
 	int opt_dump_blocks = 0;
-	int opt_dump_table = 0;
-	int opt_dump_stack = 0;
-	uint32_t opt_hash_id = GIT_SHA1_FORMAT_ID;
 	const char *arg = NULL, *argv0 = argv[0];
 
 	for (; argc > 1; argv++, argc--)
@@ -51,12 +48,6 @@ int reftable_dump_main(int argc, char *const *argv)
 			break;
 		else if (!strcmp("-b", argv[1]))
 			opt_dump_blocks = 1;
-		else if (!strcmp("-t", argv[1]))
-			opt_dump_table = 1;
-		else if (!strcmp("-6", argv[1]))
-			opt_hash_id = GIT_SHA256_FORMAT_ID;
-		else if (!strcmp("-s", argv[1]))
-			opt_dump_stack = 1;
 		else if (!strcmp("-?", argv[1]) || !strcmp("-h", argv[1])) {
 			print_help();
 			return 2;
@@ -70,13 +61,8 @@ int reftable_dump_main(int argc, char *const *argv)
 
 	arg = argv[1];
 
-	if (opt_dump_blocks) {
+	if (opt_dump_blocks)
 		err = reftable_reader_print_blocks(arg);
-	} else if (opt_dump_table) {
-		err = reftable_reader_print_file(arg);
-	} else if (opt_dump_stack) {
-		err = reftable_stack_print_directory(arg, opt_hash_id);
-	}
 
 	if (err < 0) {
 		fprintf(stderr, "%s: %s: %s\n", argv0, arg,
diff --git a/reftable/generic.c b/reftable/generic.c
index 6ecf9b880f..495ee9af6b 100644
--- a/reftable/generic.c
+++ b/reftable/generic.c
@@ -61,53 +61,6 @@ int reftable_table_read_ref(struct reftable_table *tab, const char *name,
 	return err;
 }
 
-int reftable_table_print(struct reftable_table *tab) {
-	struct reftable_iterator it = { NULL };
-	struct reftable_ref_record ref = { NULL };
-	struct reftable_log_record log = { NULL };
-	uint32_t hash_id = reftable_table_hash_id(tab);
-	int err;
-
-	reftable_table_init_ref_iter(tab, &it);
-
-	err = reftable_iterator_seek_ref(&it, "");
-	if (err < 0)
-		return err;
-
-	while (1) {
-		err = reftable_iterator_next_ref(&it, &ref);
-		if (err > 0) {
-			break;
-		}
-		if (err < 0) {
-			return err;
-		}
-		reftable_ref_record_print(&ref, hash_id);
-	}
-	reftable_iterator_destroy(&it);
-	reftable_ref_record_release(&ref);
-
-	reftable_table_init_log_iter(tab, &it);
-
-	err = reftable_iterator_seek_log(&it, "");
-	if (err < 0)
-		return err;
-
-	while (1) {
-		err = reftable_iterator_next_log(&it, &log);
-		if (err > 0) {
-			break;
-		}
-		if (err < 0) {
-			return err;
-		}
-		reftable_log_record_print(&log, hash_id);
-	}
-	reftable_iterator_destroy(&it);
-	reftable_log_record_release(&log);
-	return 0;
-}
-
 uint64_t reftable_table_max_update_index(struct reftable_table *tab)
 {
 	return tab->ops->max_update_index(tab->table_arg);
diff --git a/reftable/reader.c b/reftable/reader.c
index e3f5854229..fbd93b88df 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -798,27 +798,6 @@ void reftable_table_from_reader(struct reftable_table *tab,
 	tab->table_arg = reader;
 }
 
-
-int reftable_reader_print_file(const char *tablename)
-{
-	struct reftable_block_source src = { NULL };
-	int err = reftable_block_source_from_file(&src, tablename);
-	struct reftable_reader *r = NULL;
-	struct reftable_table tab = { NULL };
-	if (err < 0)
-		goto done;
-
-	err = reftable_new_reader(&r, &src, tablename);
-	if (err < 0)
-		goto done;
-
-	reftable_table_from_reader(&tab, r);
-	err = reftable_table_print(&tab);
-done:
-	reftable_reader_free(r);
-	return err;
-}
-
 int reftable_reader_print_blocks(const char *tablename)
 {
 	struct {
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
index d778133e6e..5edd46ec75 100644
--- a/reftable/record.h
+++ b/reftable/record.h
@@ -72,9 +72,6 @@ struct reftable_record_vtable {
 	 * the same type.
 	 */
 	int (*cmp)(const void *a, const void *b);
-
-	/* Print on stdout, for debugging. */
-	void (*print)(const void *rec, int hash_size);
 };
 
 /* returns true for recognized block types. Block start with the block type. */
@@ -136,7 +133,6 @@ void reftable_record_init(struct reftable_record *rec, uint8_t typ);
 /* see struct record_vtable */
 int reftable_record_cmp(struct reftable_record *a, struct reftable_record *b);
 int reftable_record_equal(struct reftable_record *a, struct reftable_record *b, int hash_size);
-void reftable_record_print(struct reftable_record *rec, int hash_size);
 void reftable_record_key(struct reftable_record *rec, struct strbuf *dest);
 void reftable_record_copy_from(struct reftable_record *rec,
 			       struct reftable_record *src, int hash_size);
diff --git a/reftable/reftable-generic.h b/reftable/reftable-generic.h
index 65670ea093..b8b1323a33 100644
--- a/reftable/reftable-generic.h
+++ b/reftable/reftable-generic.h
@@ -41,7 +41,4 @@ uint64_t reftable_table_min_update_index(struct reftable_table *tab);
 int reftable_table_read_ref(struct reftable_table *tab, const char *name,
 			    struct reftable_ref_record *ref);
 
-/* dump table contents onto stdout for debugging */
-int reftable_table_print(struct reftable_table *tab);
-
 #endif
diff --git a/reftable/reftable-reader.h b/reftable/reftable-reader.h
index a32f31d648..7c7d171651 100644
--- a/reftable/reftable-reader.h
+++ b/reftable/reftable-reader.h
@@ -64,8 +64,6 @@ uint64_t reftable_reader_min_update_index(struct reftable_reader *r);
 void reftable_table_from_reader(struct reftable_table *tab,
 				struct reftable_reader *reader);
 
-/* print table onto stdout for debugging. */
-int reftable_reader_print_file(const char *tablename);
 /* print blocks onto stdout for debugging. */
 int reftable_reader_print_blocks(const char *tablename);
 
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
diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
index 09e97c9991..f4f8cabc7f 100644
--- a/reftable/reftable-stack.h
+++ b/reftable/reftable-stack.h
@@ -140,7 +140,4 @@ struct reftable_compaction_stats {
 struct reftable_compaction_stats *
 reftable_stack_compaction_stats(struct reftable_stack *st);
 
-/* print the entire stack represented by the directory */
-int reftable_stack_print_directory(const char *stackdir, uint32_t hash_id);
-
 #endif
diff --git a/reftable/stack.c b/reftable/stack.c
index d08ec00959..bedd503e7e 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1603,23 +1603,3 @@ int reftable_stack_clean(struct reftable_stack *st)
 	reftable_addition_destroy(add);
 	return err;
 }
-
-int reftable_stack_print_directory(const char *stackdir, uint32_t hash_id)
-{
-	struct reftable_stack *stack = NULL;
-	struct reftable_write_options opts = { .hash_id = hash_id };
-	struct reftable_merged_table *merged = NULL;
-	struct reftable_table table = { NULL };
-
-	int err = reftable_new_stack(&stack, stackdir, &opts);
-	if (err < 0)
-		goto done;
-
-	merged = reftable_stack_merged_table(stack);
-	reftable_table_from_merged_table(&table, merged);
-	err = reftable_table_print(&table);
-done:
-	if (stack)
-		reftable_stack_destroy(stack);
-	return err;
-}
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index dbca9eaf4a..42044ed8a3 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -179,13 +179,6 @@ static void test_reftable_stack_add_one(void)
 	EXPECT(0 == strcmp("master", dest.value.symref));
 	EXPECT(st->readers_len > 0);
 
-	printf("testing print functionality:\n");
-	err = reftable_stack_print_directory(dir, GIT_SHA1_FORMAT_ID);
-	EXPECT_ERR(err);
-
-	err = reftable_stack_print_directory(dir, GIT_SHA256_FORMAT_ID);
-	EXPECT(err == REFTABLE_FORMAT_ERROR);
-
 #ifndef GIT_WINDOWS_NATIVE
 	strbuf_addstr(&scratch, dir);
 	strbuf_addstr(&scratch, "/tables.list");
-- 
2.46.0.46.g406f326d27.dirty

