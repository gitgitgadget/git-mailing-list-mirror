Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D726512FB37
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 08:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723882993; cv=none; b=OYOGXxCwubCKVJJyyv0Af7nyHN9VB7De8mN1Wcf77njrKkGSvCxUwnMcQlKlhKBhrA9oN2xE5pa4wJVgHMkXf64vGKAiMnsere4K7FPnO9CzuFTrkORzvcf1pzgzzoxrDZVFrw0dMUIlqgd06hI8YX/mF9PqfZMPLPXeLsUntwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723882993; c=relaxed/simple;
	bh=ywOn7EbP0IVt1EsP/x6DX0G5TezlszCYiYkS7bJz84Y=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUBPo1avPvmCboybYZEzrwx9zBod12INU80Zk3vDQJc1lj9suEdpZFs4bTl69OWffvolcpNHoYj5oUy6IlnGLM40HpEVbOHT16vDHbyHGWYb9l67Pqauoyuv+Z0NyHUWu9vY+36NJKHWM54OS49EMdpps8+YluEPnux+uQzr+2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24702 invoked by uid 109); 17 Aug 2024 08:23:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Aug 2024 08:23:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27953 invoked by uid 111); 17 Aug 2024 08:23:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Aug 2024 04:23:14 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Aug 2024 04:23:09 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 07/15] unit-tests: ignore unused argc/argv
Message-ID: <20240817082309.GG10287@coredump.intra.peff.net>
References: <20240817082101.GA6761@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240817082101.GA6761@coredump.intra.peff.net>

All of the unit test programs have their own cmd_main() function, but
none of them actually look at the argc/argv that is passed in.

In the long run we may want them to handle options for the test harness.
But we'd probably do that with a shared harness cmd_main(), dispatching
to the individual tests. In the meantime, let's annotate the unused
parameters to avoid triggering -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/unit-tests/t-ctype.c           | 2 +-
 t/unit-tests/t-hash.c            | 2 +-
 t/unit-tests/t-mem-pool.c        | 2 +-
 t/unit-tests/t-prio-queue.c      | 2 +-
 t/unit-tests/t-reftable-basics.c | 2 +-
 t/unit-tests/t-reftable-merged.c | 2 +-
 t/unit-tests/t-reftable-pq.c     | 2 +-
 t/unit-tests/t-reftable-record.c | 2 +-
 t/unit-tests/t-reftable-tree.c   | 2 +-
 t/unit-tests/t-strbuf.c          | 2 +-
 t/unit-tests/t-strcmp-offset.c   | 2 +-
 t/unit-tests/t-strvec.c          | 2 +-
 t/unit-tests/t-trailer.c         | 2 +-
 13 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/t/unit-tests/t-ctype.c b/t/unit-tests/t-ctype.c
index d6ac1fe678..24cc566cfe 100644
--- a/t/unit-tests/t-ctype.c
+++ b/t/unit-tests/t-ctype.c
@@ -33,7 +33,7 @@
 	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
 	"\x7f"
 
-int cmd_main(int argc, const char **argv) {
+int cmd_main(int argc UNUSED, const char **argv UNUSED) {
 	TEST_CHAR_CLASS(isspace, " \n\r\t");
 	TEST_CHAR_CLASS(isdigit, DIGIT);
 	TEST_CHAR_CLASS(isalpha, LOWER UPPER);
diff --git a/t/unit-tests/t-hash.c b/t/unit-tests/t-hash.c
index e9a78bf2c0..e62647019b 100644
--- a/t/unit-tests/t-hash.c
+++ b/t/unit-tests/t-hash.c
@@ -38,7 +38,7 @@ static void check_hash_data(const void *data, size_t data_length,
 		     "SHA1 and SHA256 (%s) works", #literal); \
 	} while (0)
 
-int cmd_main(int argc, const char **argv)
+int cmd_main(int argc UNUSED, const char **argv UNUSED)
 {
 	struct strbuf aaaaaaaaaa_100000 = STRBUF_INIT;
 	struct strbuf alphabet_100000 = STRBUF_INIT;
diff --git a/t/unit-tests/t-mem-pool.c b/t/unit-tests/t-mem-pool.c
index a0d57df761..fe500c704b 100644
--- a/t/unit-tests/t-mem-pool.c
+++ b/t/unit-tests/t-mem-pool.c
@@ -20,7 +20,7 @@ static void t_calloc_100(struct mem_pool *pool)
 	check(pool->mp_block->end != NULL);
 }
 
-int cmd_main(int argc, const char **argv)
+int cmd_main(int argc UNUSED, const char **argv UNUSED)
 {
 	TEST(setup_static(t_calloc_100, 1024 * 1024),
 	     "mem_pool_calloc returns 100 zeroed bytes with big block");
diff --git a/t/unit-tests/t-prio-queue.c b/t/unit-tests/t-prio-queue.c
index 7a4e5780e1..fe6ae37935 100644
--- a/t/unit-tests/t-prio-queue.c
+++ b/t/unit-tests/t-prio-queue.c
@@ -69,7 +69,7 @@ static void test_prio_queue(int *input, size_t input_size,
 #define TEST_INPUT(input, result) \
 	test_prio_queue(input, ARRAY_SIZE(input), result, ARRAY_SIZE(result))
 
-int cmd_main(int argc, const char **argv)
+int cmd_main(int argc UNUSED, const char **argv UNUSED)
 {
 	TEST(TEST_INPUT(((int []){ 2, 6, 3, 10, 9, 5, 7, 4, 5, 8, 1, DUMP }),
 			((int []){ 1, 2, 3, 4, 5, 5, 6, 7, 8, 9, 10 })),
diff --git a/t/unit-tests/t-reftable-basics.c b/t/unit-tests/t-reftable-basics.c
index 4e80bdf16d..7ffee74dca 100644
--- a/t/unit-tests/t-reftable-basics.c
+++ b/t/unit-tests/t-reftable-basics.c
@@ -145,7 +145,7 @@ static void test_u16_roundtrip(void)
 	check_int(in, ==, out);
 }
 
-int cmd_main(int argc, const char *argv[])
+int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 {
 	TEST(test_common_prefix(), "common_prefix_size works");
 	TEST(test_parse_names_normal(), "parse_names works for basic input");
diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index b6263ee8b5..2d65d5c3cb 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -452,7 +452,7 @@ static void t_default_write_opts(void)
 }
 
 
-int cmd_main(int argc, const char *argv[])
+int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 {
 	TEST(t_default_write_opts(), "merged table with default write opts");
 	TEST(t_merged_logs(), "merged table with multiple log updates for same ref");
diff --git a/t/unit-tests/t-reftable-pq.c b/t/unit-tests/t-reftable-pq.c
index 039bd0f1f9..ada4c19f18 100644
--- a/t/unit-tests/t-reftable-pq.c
+++ b/t/unit-tests/t-reftable-pq.c
@@ -142,7 +142,7 @@ static void t_merged_iter_pqueue_top(void)
 	merged_iter_pqueue_release(&pq);
 }
 
-int cmd_main(int argc, const char *argv[])
+int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 {
 	TEST(t_pq_record(), "pq works with record-based comparison");
 	TEST(t_pq_index(), "pq works with index-based comparison");
diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index cb649ee419..a7f67d4d9f 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -532,7 +532,7 @@ static void t_reftable_index_record_roundtrip(void)
 	strbuf_release(&in.u.idx.last_key);
 }
 
-int cmd_main(int argc, const char *argv[])
+int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 {
 	TEST(t_reftable_ref_record_comparison(), "comparison operations work on ref record");
 	TEST(t_reftable_log_record_comparison(), "comparison operations work on log record");
diff --git a/t/unit-tests/t-reftable-tree.c b/t/unit-tests/t-reftable-tree.c
index e7d774d774..700479d34b 100644
--- a/t/unit-tests/t-reftable-tree.c
+++ b/t/unit-tests/t-reftable-tree.c
@@ -75,7 +75,7 @@ static void t_infix_walk(void)
 	tree_free(root);
 }
 
-int cmd_main(int argc, const char *argv[])
+int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 {
 	TEST(t_tree_search(), "tree_search works");
 	TEST(t_infix_walk(), "infix_walk works");
diff --git a/t/unit-tests/t-strbuf.c b/t/unit-tests/t-strbuf.c
index 6027dafef7..3f4044d697 100644
--- a/t/unit-tests/t-strbuf.c
+++ b/t/unit-tests/t-strbuf.c
@@ -105,7 +105,7 @@ static void t_addstr(struct strbuf *buf, const void *data)
 	check_str(buf->buf + orig_len, text);
 }
 
-int cmd_main(int argc, const char **argv)
+int cmd_main(int argc UNUSED, const char **argv UNUSED)
 {
 	if (!TEST(t_static_init(), "static initialization works"))
 		test_skip_all("STRBUF_INIT is broken");
diff --git a/t/unit-tests/t-strcmp-offset.c b/t/unit-tests/t-strcmp-offset.c
index fe4c2706b1..6880f21161 100644
--- a/t/unit-tests/t-strcmp-offset.c
+++ b/t/unit-tests/t-strcmp-offset.c
@@ -24,7 +24,7 @@ static void check_strcmp_offset(const char *string1, const char *string2,
 				 expect_offset),                           \
 	     "strcmp_offset(%s, %s) works", #string1, #string2)
 
-int cmd_main(int argc, const char **argv)
+int cmd_main(int argc UNUSED, const char **argv UNUSED)
 {
 	TEST_STRCMP_OFFSET("abc", "abc", 0, 3);
 	TEST_STRCMP_OFFSET("abc", "def", -1, 0);
diff --git a/t/unit-tests/t-strvec.c b/t/unit-tests/t-strvec.c
index fa1a041469..c3b610dda7 100644
--- a/t/unit-tests/t-strvec.c
+++ b/t/unit-tests/t-strvec.c
@@ -227,7 +227,7 @@ static void t_detach(void)
 	free(detached);
 }
 
-int cmd_main(int argc, const char **argv)
+int cmd_main(int argc UNUSED, const char **argv UNUSED)
 {
 	TEST(t_static_init(), "static initialization");
 	TEST(t_dynamic_init(), "dynamic initialization");
diff --git a/t/unit-tests/t-trailer.c b/t/unit-tests/t-trailer.c
index 2ecca359d9..e1c6ad7461 100644
--- a/t/unit-tests/t-trailer.c
+++ b/t/unit-tests/t-trailer.c
@@ -308,7 +308,7 @@ static void run_t_trailer_iterator(void)
 	}
 }
 
-int cmd_main(int argc, const char **argv)
+int cmd_main(int argc UNUSED, const char **argv UNUSED)
 {
 	run_t_trailer_iterator();
 	return test_done();
-- 
2.46.0.585.gd6679c16d8

