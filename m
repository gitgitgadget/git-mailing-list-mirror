Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AD83BE638
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 12:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823213; cv=none; b=WlhRXCxGV+dHbIiP6IbWDtXbAqUWqFUIx+KdtfnZlSB1p3AimAHR1N7Lg7iIE+DDRHJKvfDoq7cLM7mQS0Y60msss5z53hIWZ/tnMA9eRH2WgGjvrieGBSzB1t4F6AIKj4HxAZsOcCsVpe+wl61PWDqOkBWIrpL2L+KyxbEoG3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823213; c=relaxed/simple;
	bh=yZ2z0iYWlhvcsNX1FPKDhplk3EYquH+PfHlLtDFEE5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mMrGBnlM1w0R775Cy5VF1B7+9T80XQ68P1tFPYYACtUhSfTrVpFsUJBjpH2NtMELKGB4FvUm/IgvpTtPmHDDvgeyk5nAXAbCY25/BmW1QufoyhtJJYtsmUN8fGn/omqBxS+ndfS8yKTVZ+I9aEOmv5a2hzJgZ2FUp+RR06supgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mRe4BdiL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V/6smPY/; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mRe4BdiL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V/6smPY/"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DBFCF7A00EB;
	Fri, 10 Apr 2026 08:13:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 10 Apr 2026 08:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775823211;
	 x=1775909611; bh=zfFk/HJ7BfnmwDHZC4mGuan3hi29Ap/bpyqTNii3uTs=; b=
	mRe4BdiLrQfUygaIr3aiVAZg/w91lIrU1xIuX3VVLO4pZKY/KWO9cfuZ7Mbc0B9f
	ZWuO1PgSM7RiGE8BnR7r1p0Gr00ICaLfGg5rF8VbB6u80oTws1j2Z92gBgvebwjP
	kYn1xGmmCclcjLbQ1COHTHrzhuMu8SiqLVE4SFdbjuCia+m7TRx3+EtHixxovGyH
	pEp8kk78IQ1S9PAAnaAh/XitFBn/DUYnGPGvZPrrLZgXaBmqP9gSHrZmXkzpafYf
	b50np7O+eyZ09GwFkOx4EBLRx/zWeT6E4SFuNlWQLU+daFqDuAhLScknCxBQXBCv
	S2bqOdCaGcR8KXdLP5Tx9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775823211; x=
	1775909611; bh=zfFk/HJ7BfnmwDHZC4mGuan3hi29Ap/bpyqTNii3uTs=; b=V
	/6smPY/Qf1ur+q1NMSyJ1cb6P7TkjIJPY7gX6vHVLZs/pTuipWIaSTXJm6lENJA1
	cVPIPnQXR0Ztxu9vZuJHxnI9U+2/9ioUrQXxrE8Uvkco+szjan60n4ftWdPTTugr
	G7/GUFHiDdox47Qc7JpR5GJHRPs8e1UeGbhoOJjYa3LCEWNrVNj3DNDl77AFG0s3
	sj17QgOjDAKgB2d+SBF+nQzr5IWBEC0PcasX+bcFW08e9LkCh6xZt7WzOhjD0/yO
	qZ1/crzaak2jaizJBWxlELejDrynHNl9PCRwKdLqqcZPMghkIDVcE8dyWe8OC2LK
	8spdZOPCyUkmOxbmxuuMQ==
X-ME-Sender: <xms:a-nYaeUqsdtepHwTsJsNxKXOWDP3iBnGW7ISO9DfpFHHKm1jip8JLg>
    <xme:a-nYaSD55onnaillSjV0HBb9fewebpYWevWhDxP6ijdTJEf8Zh9Qe_fd0uPeKzqKi
    cxHyPK1osigkN88E8CXRR2_zO5ObLrYJ70YgOkztYpyVnf13tgj>
X-ME-Received: <xmr:a-nYafzaKNkQOzMTWEZJfuTGbXVMolwU-BBO-5ZAq3gayXufOG_1wRmI7-CNa0uA1chRRR8m5v4wN7gsC55yUjONk6NzdocK7DVE_DOlnOXU-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:a-nYafAoPnx-WGznoAndNNhUrfAtC6msy2wFFz293LWcKBkPE7Y74w>
    <xmx:a-nYacaJ4AYRd0ayPBAp3btneyFs5Sgp4_7IjPHFaBSX4biYS41TNQ>
    <xmx:a-nYaXgOfGqKo49xYGRjuVaG1-6f_Q781_RBsBlVu_b6yRuTFx-bwg>
    <xmx:a-nYae4CRaBZxp87Ak1ev-rTWmMcqHNNr3oIvQT6vNtsc90nH2iaNQ>
    <xmx:a-nYaWBL-zd4H3zgSemi1V_aLKG40i4nHDVhJKLdDSAQ5Pg8DGycQ7RK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 08:13:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 94c0a743 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Apr 2026 12:13:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Apr 2026 14:12:47 +0200
Subject: [PATCH v3 17/17] t/unit-tests: add tests for the in-memory object
 source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-b4-pks-odb-source-inmemory-v3-17-22fd0fad58fe@pks.im>
References: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
In-Reply-To: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.1

While the in-memory object source is a full-fledged source, our code
base only exercises parts of its functionality because we only use it in
git-blame(1). Implement unit tests to verify that the yet-unused
functionality of the backend works as expected.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                      |   1 +
 t/meson.build                 |   1 +
 t/unit-tests/u-odb-inmemory.c | 313 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 315 insertions(+)

diff --git a/Makefile b/Makefile
index 3cda12c455..68b4daa1ad 100644
--- a/Makefile
+++ b/Makefile
@@ -1529,6 +1529,7 @@ CLAR_TEST_SUITES += u-hash
 CLAR_TEST_SUITES += u-hashmap
 CLAR_TEST_SUITES += u-list-objects-filter-options
 CLAR_TEST_SUITES += u-mem-pool
+CLAR_TEST_SUITES += u-odb-inmemory
 CLAR_TEST_SUITES += u-oid-array
 CLAR_TEST_SUITES += u-oidmap
 CLAR_TEST_SUITES += u-oidtree
diff --git a/t/meson.build b/t/meson.build
index 7528e5cda5..db5e01c49b 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -6,6 +6,7 @@ clar_test_suites = [
   'unit-tests/u-hashmap.c',
   'unit-tests/u-list-objects-filter-options.c',
   'unit-tests/u-mem-pool.c',
+  'unit-tests/u-odb-inmemory.c',
   'unit-tests/u-oid-array.c',
   'unit-tests/u-oidmap.c',
   'unit-tests/u-oidtree.c',
diff --git a/t/unit-tests/u-odb-inmemory.c b/t/unit-tests/u-odb-inmemory.c
new file mode 100644
index 0000000000..482502ef4b
--- /dev/null
+++ b/t/unit-tests/u-odb-inmemory.c
@@ -0,0 +1,313 @@
+#include "unit-test.h"
+#include "hex.h"
+#include "odb/source-inmemory.h"
+#include "odb/streaming.h"
+#include "oidset.h"
+#include "repository.h"
+#include "strbuf.h"
+
+#define RANDOM_OID "da39a3ee5e6b4b0d3255bfef95601890afd80709"
+#define FOOBAR_OID "f6ea0495187600e7b2288c8ac19c5886383a4632"
+
+static struct repository repo = {
+	.hash_algo = &hash_algos[GIT_HASH_SHA1],
+};
+static struct object_database *odb;
+
+static void cl_assert_object_info(struct odb_source_inmemory *source,
+				  const struct object_id *oid,
+				  enum object_type expected_type,
+				  const char *expected_content)
+{
+	enum object_type actual_type;
+	unsigned long actual_size;
+	void *actual_content;
+	struct object_info oi = {
+		.typep = &actual_type,
+		.sizep = &actual_size,
+		.contentp = &actual_content,
+	};
+
+	cl_must_pass(odb_source_read_object_info(&source->base, oid, &oi, 0));
+	cl_assert_equal_u(actual_size, strlen(expected_content));
+	cl_assert_equal_u(actual_type, expected_type);
+	cl_assert_equal_s((char *) actual_content, expected_content);
+
+	free(actual_content);
+}
+
+void test_odb_inmemory__initialize(void)
+{
+	odb = odb_new(&repo, "", "");
+}
+
+void test_odb_inmemory__cleanup(void)
+{
+	odb_free(odb);
+}
+
+void test_odb_inmemory__new(void)
+{
+	struct odb_source_inmemory *source = odb_source_inmemory_new(odb);
+	cl_assert_equal_i(source->base.type, ODB_SOURCE_INMEMORY);
+	odb_source_free(&source->base);
+}
+
+void test_odb_inmemory__read_missing_object(void)
+{
+	struct odb_source_inmemory *source = odb_source_inmemory_new(odb);
+	struct object_id oid;
+	const char *end;
+
+	cl_must_pass(parse_oid_hex_algop(RANDOM_OID, &oid, &end, repo.hash_algo));
+	cl_must_fail(odb_source_read_object_info(&source->base, &oid, NULL, 0));
+
+	odb_source_free(&source->base);
+}
+
+void test_odb_inmemory__read_empty_tree(void)
+{
+	struct odb_source_inmemory *source = odb_source_inmemory_new(odb);
+	cl_assert_object_info(source, repo.hash_algo->empty_tree, OBJ_TREE, "");
+	odb_source_free(&source->base);
+}
+
+void test_odb_inmemory__read_written_object(void)
+{
+	struct odb_source_inmemory *source = odb_source_inmemory_new(odb);
+	const char data[] = "foobar";
+	struct object_id written_oid;
+
+	cl_must_pass(odb_source_write_object(&source->base, data, strlen(data),
+					     OBJ_BLOB, &written_oid, NULL, 0));
+	cl_assert_equal_s(oid_to_hex(&written_oid), FOOBAR_OID);
+	cl_assert_object_info(source, &written_oid, OBJ_BLOB, "foobar");
+
+	odb_source_free(&source->base);
+}
+
+void test_odb_inmemory__read_stream_object(void)
+{
+	struct odb_source_inmemory *source = odb_source_inmemory_new(odb);
+	struct odb_read_stream *stream;
+	struct object_id written_oid;
+	const char data[] = "foobar";
+	char buf[3] = { 0 };
+
+	cl_must_pass(odb_source_write_object(&source->base, data, strlen(data),
+					     OBJ_BLOB, &written_oid, NULL, 0));
+
+	cl_must_pass(odb_source_read_object_stream(&stream, &source->base,
+						   &written_oid));
+	cl_assert_equal_i(stream->type, OBJ_BLOB);
+	cl_assert_equal_u(stream->size, 6);
+
+	cl_assert_equal_i(odb_read_stream_read(stream, buf, 2), 2);
+	cl_assert_equal_s(buf, "fo");
+	cl_assert_equal_i(odb_read_stream_read(stream, buf, 2), 2);
+	cl_assert_equal_s(buf, "ob");
+	cl_assert_equal_i(odb_read_stream_read(stream, buf, 2), 2);
+	cl_assert_equal_s(buf, "ar");
+	cl_assert_equal_i(odb_read_stream_read(stream, buf, 2), 0);
+
+	odb_read_stream_close(stream);
+	odb_source_free(&source->base);
+}
+
+static int add_one_object(const struct object_id *oid,
+			  struct object_info *oi UNUSED,
+			  void *payload)
+{
+	struct oidset *actual_oids = payload;
+	cl_must_pass(oidset_insert(actual_oids, oid));
+	return 0;
+}
+
+void test_odb_inmemory__for_each_object(void)
+{
+	struct odb_source_inmemory *source = odb_source_inmemory_new(odb);
+	struct odb_for_each_object_options opts = { 0 };
+	struct oidset expected_oids = OIDSET_INIT;
+	struct oidset actual_oids = OIDSET_INIT;
+	struct strbuf buf = STRBUF_INIT;
+
+	cl_must_pass(odb_source_for_each_object(&source->base, NULL,
+						add_one_object, &actual_oids, &opts));
+	cl_assert_equal_u(oidset_size(&actual_oids), 0);
+
+	for (int i = 0; i < 10; i++) {
+		struct object_id written_oid;
+
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "%d", i);
+
+		cl_must_pass(odb_source_write_object(&source->base, buf.buf, buf.len,
+						     OBJ_BLOB, &written_oid, NULL, 0));
+		cl_must_pass(oidset_insert(&expected_oids, &written_oid));
+	}
+
+	cl_must_pass(odb_source_for_each_object(&source->base, NULL,
+						add_one_object, &actual_oids, &opts));
+	cl_assert_equal_b(oidset_equal(&expected_oids, &actual_oids), true);
+
+	odb_source_free(&source->base);
+	oidset_clear(&expected_oids);
+	oidset_clear(&actual_oids);
+	strbuf_release(&buf);
+}
+
+static int abort_after_two_objects(const struct object_id *oid UNUSED,
+				   struct object_info *oi UNUSED,
+				   void *payload)
+{
+	unsigned *counter = payload;
+	(*counter)++;
+	if (*counter == 2)
+		return 123;
+	return 0;
+}
+
+void test_odb_inmemory__for_each_object_can_abort_iteration(void)
+{
+	struct odb_source_inmemory *source = odb_source_inmemory_new(odb);
+	struct odb_for_each_object_options opts = { 0 };
+	struct object_id written_oid;
+	unsigned counter = 0;
+
+	cl_must_pass(odb_source_write_object(&source->base, "1", 1,
+					     OBJ_BLOB, &written_oid, NULL, 0));
+	cl_must_pass(odb_source_write_object(&source->base, "2", 1,
+					     OBJ_BLOB, &written_oid, NULL, 0));
+	cl_must_pass(odb_source_write_object(&source->base, "3", 1,
+					     OBJ_BLOB, &written_oid, NULL, 0));
+
+	cl_assert_equal_i(odb_source_for_each_object(&source->base, NULL,
+						     abort_after_two_objects,
+						     &counter, &opts),
+			  123);
+	cl_assert_equal_u(counter, 2);
+
+	odb_source_free(&source->base);
+}
+
+void test_odb_inmemory__count_objects(void)
+{
+	struct odb_source_inmemory *source = odb_source_inmemory_new(odb);
+	struct object_id written_oid;
+	unsigned long count;
+
+	cl_must_pass(odb_source_count_objects(&source->base, 0, &count));
+	cl_assert_equal_u(count, 0);
+
+	cl_must_pass(odb_source_write_object(&source->base, "1", 1,
+					     OBJ_BLOB, &written_oid, NULL, 0));
+	cl_must_pass(odb_source_write_object(&source->base, "2", 1,
+					     OBJ_BLOB, &written_oid, NULL, 0));
+	cl_must_pass(odb_source_write_object(&source->base, "3", 1,
+					     OBJ_BLOB, &written_oid, NULL, 0));
+
+	cl_must_pass(odb_source_count_objects(&source->base, 0, &count));
+	cl_assert_equal_u(count, 3);
+
+	odb_source_free(&source->base);
+}
+
+void test_odb_inmemory__find_abbrev_len(void)
+{
+	struct odb_source_inmemory *source = odb_source_inmemory_new(odb);
+	struct object_id oid1, oid2;
+	unsigned abbrev_len;
+
+	/*
+	 * The two blobs we're about to write share the first 10 hex characters
+	 * of their object IDs ("a09f43dc45"), so at least 11 characters are
+	 * needed to tell them apart:
+	 *
+	 *   "368317" -> a09f43dc4562d45115583f5094640ae237df55f7
+	 *   "514796" -> a09f43dc45fef837235eb7e6b1a6ca5e169a3981
+	 *
+	 * With only one blob written we expect a length of 4.
+	 */
+	cl_must_pass(odb_source_write_object(&source->base, "368317", strlen("368317"),
+					     OBJ_BLOB, &oid1, NULL, 0));
+	cl_must_pass(odb_source_find_abbrev_len(&source->base, &oid1, 4,
+						&abbrev_len));
+	cl_assert_equal_u(abbrev_len, 4);
+
+	/*
+	 * With both objects present, the shared 10-character prefix means we
+	 * need at least 11 characters to uniquely identify either object.
+	 */
+	cl_must_pass(odb_source_write_object(&source->base, "514796", strlen("514796"),
+					     OBJ_BLOB, &oid2, NULL, 0));
+	cl_must_pass(odb_source_find_abbrev_len(&source->base, &oid1, 4,
+						&abbrev_len));
+	cl_assert_equal_u(abbrev_len, 11);
+
+	odb_source_free(&source->base);
+}
+
+void test_odb_inmemory__freshen_object(void)
+{
+	struct odb_source_inmemory *source = odb_source_inmemory_new(odb);
+	struct object_id written_oid;
+	struct object_id oid;
+	const char *end;
+
+	cl_must_pass(parse_oid_hex_algop(RANDOM_OID, &oid, &end, repo.hash_algo));
+	cl_assert_equal_i(odb_source_freshen_object(&source->base, &oid), 0);
+
+	cl_must_pass(odb_source_write_object(&source->base, "foobar",
+					     strlen("foobar"), OBJ_BLOB,
+					     &written_oid, NULL, 0));
+	cl_assert_equal_i(odb_source_freshen_object(&source->base,
+						    &written_oid), 1);
+
+	odb_source_free(&source->base);
+}
+
+struct membuf_write_stream {
+	struct odb_write_stream base;
+	const char *buf;
+	size_t offset;
+	size_t size;
+};
+
+static ssize_t membuf_write_stream_read(struct odb_write_stream *stream,
+					unsigned char *buf, size_t len)
+{
+	struct membuf_write_stream *s = container_of(stream, struct membuf_write_stream, base);
+	size_t chunk_size = 2;
+
+	if (chunk_size > len)
+		chunk_size = len;
+	if (chunk_size > s->size - s->offset)
+		chunk_size = s->size - s->offset;
+
+	memcpy(buf, s->buf + s->offset, chunk_size);
+
+	s->offset += chunk_size;
+	if (s->offset == s->size)
+		s->base.is_finished = 1;
+
+	return chunk_size;
+}
+
+void test_odb_inmemory__write_object_stream(void)
+{
+	struct odb_source_inmemory *source = odb_source_inmemory_new(odb);
+	const char data[] = "foobar";
+	struct membuf_write_stream stream = {
+		.base.read = membuf_write_stream_read,
+		.buf = data,
+		.size = strlen(data),
+	};
+	struct object_id written_oid;
+
+	cl_must_pass(odb_source_write_object_stream(&source->base, &stream.base,
+						    strlen(data), &written_oid));
+	cl_assert_equal_s(oid_to_hex(&written_oid), FOOBAR_OID);
+	cl_assert_object_info(source, &written_oid, OBJ_BLOB, "foobar");
+
+	odb_source_free(&source->base);
+}

-- 
2.54.0.rc0.707.g0fbf48f4d6.dirty

