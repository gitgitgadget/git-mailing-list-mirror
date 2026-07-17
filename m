Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8213C13F5
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 09:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280746; cv=none; b=airm+aIi9qvkiIQQ5GECWVGZk1SIAac+kSa/KW5H/7hzcaa+io6PbqNNCjGqmkzVUbCEqqyyX+sxOMFpFF5dQRbLHNwIHW7erfDwocqZth0BOQOJ8kL9CU+jlGOTUbDFsr+2LcOeQDT8/z14xCqZ3ypcL/Ha140q7iOApO1jTZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280746; c=relaxed/simple;
	bh=hHzoLnZCtzW7krFdfxUP1F4M4phZHDCrQ/m7ZqmPYag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ljdqZseQc5c+vj2tL4kbL3AjIpdL1BSd7MIR383Ul7Cqgf3Tr4wmsAUZgO25YHyNIvUe+OXOn/9Q5BNRScQJ0rhSeT5CHQfpdNQJvomtxpD1nKhaz5X7o25mlTaPdR67IByDW+S+94pFLfV85rt+SBY++rNF0qQTfRycX8G72eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Rim3dXfU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hjToVzxz; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Rim3dXfU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hjToVzxz"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A49637A00AC;
	Fri, 17 Jul 2026 05:32:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 17 Jul 2026 05:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784280743;
	 x=1784367143; bh=i0M24A6G7FjtxuWaVEIpPhqfOmRsy2tmxT1MuquETGw=; b=
	Rim3dXfUZuZDLVbAAAVV4lyprGneqP2zXqWhChtdnbubYcFtteocBObt9MXh3wVK
	krCH19A7y3M2driweA335naLMEuWdSogT65WGrH4fTcsWi5LLxzTVDlYA3H+t/Z1
	dFADaG3ypkzMmRWJX8O7uQgfom9eYSELy6O+qOcrNYHqiEZUrJi7ZuI0moXYy0Uu
	CrICMe4/y/NSQxPrBoJ7Kcdfuo+0CTz4/sCNeU5d+bQy3ge6Qy0XcBWNMiD9qLsh
	pdRoMj5Un/yUKfNF33ukWCjNYQdi9JBsMoTHkE3ab0tTpZQThQKA/V9uvxdI9n8l
	Ydyd4capND9d2ChPAgNd3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784280743; x=
	1784367143; bh=i0M24A6G7FjtxuWaVEIpPhqfOmRsy2tmxT1MuquETGw=; b=h
	jToVzxz0rsiQ9C4NoSswWDyiQC87gZnHOcmOtiRYBYYWWTPTLitHhkgnxf574URb
	gMJW7sUENMD1Z84MYvoBUbIvZaT4reEO8/gUpQTO5iTXJsSfJ3Anv0aGDFw50c1k
	ZEvRGKHD7Ny1jaK10bBqIAKVuTYjPwVETEzgqtkVbHQJgrC5MqR3MycqNafw4Bgv
	5ain7gRqkiAfRUWFOeo++jpb27jfpI7qzhhwv6Q9yMpsPUlU2HYwtVhn1lJouuL5
	EH6l5mQVP0/6o36wjuK6jL8hlwojO24Mimgvy2TaFUeltOq0BUfk54T7PD2nN8mm
	jqctJyGkDeWDEB2U9lSWg==
X-ME-Sender: <xms:p_ZZajysIIzdRsZNvmYpcmLNASIM9v6tEIIrh6ErqWRBnzI09SHboA>
    <xme:p_ZZahTdiqzpLp79jhIzZT-V9wAMPrZqHXHAy_T18Xxd2JosCyQ94oFuhlCphZm_w
    xpEdw47svPRUvNyJ4FWoFXmE4k9gSX97FjQN6tRqXDOnMCdf6ovkg>
X-ME-Received: <xmr:p_ZZaq8PeZSqNiwPpxDlJdu9ruM7A9elTSK9Swgjuy0JokXf0giq9WDYVhfq_KCiyTmknlEvd-zQC7Pac8bH8BxjneV9-sRoYlxN7al07nQ>
X-ME-Proxy-Cause: dmFkZTEPgWsCPQv+zxSWEft837Na6Ert1SlmN3P5ZmZ6YVgwDD0i8FWTKtTHRWTsiWlqAf
    Ee3/fhnAtu7H1tpfszCQ9TpTtYDRq9/Ej+1toGtU2M4Btlsq1pdMD6WQ1yGfoiLr4szbCI
    waU9J+ehUfgAu5Wanq56c7n6wqTMKgid98yVYjCsZ3lgk6w6eA2/c75Y8tf8tburLwkElo
    WIveSLuviSET+E2Li1iK4PFXEMXOIYmHGdAPQjQZ/ZM4k+MBe94Ic0rS1bAkMoxhgnze0d
    MvjikpHRu8nDYV0sOz9NDUBG04xBQks3AtbvI4iyZ3NLFDV9y0pp6sScxFsmkkVul8TknX
    bqeIQb60VSWrHgq9Eh2E/ReNaWGnaHMO5KbSh9L4TNtS804qnYKT1EqL7aJx7gxKvDCp20
    H9WrPEf4amcv0jzDHxn72aTZWZWLzrj2GOLN80MRz1d/6eILac1fo9dASuAjBU2X9ZC2lm
    xSBYcy8fl71G9i/igxIjh7w5+9BtTEPZjzZP2AZ2raL+RCUHCG5vTQE+21ImV16z1Zgmr2
    L59+TDH9AxbxMxCYhRLpAhJNBIG29baXlbUmpoAQ9tlw6w5+VSNKhAh3l7ehTnn5qh171L
    tNOsYvtpLogiiUZwMj8fwSc0lj3auEK2HW3ur/86Og91GOB3ooBwHE4uRzLw
X-ME-Proxy: <xmx:p_ZZaoow0VoLr-ohpO8RLPscPZm8JEO3VIMoVIE6CI1Z-af1MkxA6g>
    <xmx:p_ZZankkrPErooMs6nBrlZdTbp7WzuzR99TCbqFvXhTnIYDDkb7zrA>
    <xmx:p_ZZavIoNLol3oe-LPUHpU3ijpHE4-GvpqVOKlrU8-WBh-ogwp75Eg>
    <xmx:p_ZZasyNq5uMCKxuSPZBmLQ2o94KxD6azaA5nb9mM-yOEPml_7ri5Q>
    <xmx:p_ZZavgKVxRLwxyyI6Xd9Zc0RZYKDvpHrcMjdhn9I1LV_K19kUKuyWG4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 05:32:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 86251098 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Jul 2026 09:32:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 17 Jul 2026 11:32:10 +0200
Subject: [PATCH 2/9] t/u-odb-inmemory: implement wrapper for writing
 objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-pks-odb-move-loose-object-writing-v1-2-46446a3cb5b7@pks.im>
References: <20260717-pks-odb-move-loose-object-writing-v1-0-46446a3cb5b7@pks.im>
In-Reply-To: <20260717-pks-odb-move-loose-object-writing-v1-0-46446a3cb5b7@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

In the next commit we're about to change how objects are being written
into the object database source. Prepare for this refactoring by
introducing a wrapper function into our unit tests so that we don't have
to adjust all callsites.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/unit-tests/u-odb-inmemory.c | 48 +++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/t/unit-tests/u-odb-inmemory.c b/t/unit-tests/u-odb-inmemory.c
index 6844bfc37c..2dbc3ab1df 100644
--- a/t/unit-tests/u-odb-inmemory.c
+++ b/t/unit-tests/u-odb-inmemory.c
@@ -1,5 +1,6 @@
 #include "unit-test.h"
 #include "hex.h"
+#include "object-file.h"
 #include "odb/source-inmemory.h"
 #include "odb/streaming.h"
 #include "oidset.h"
@@ -36,6 +37,16 @@ static void cl_assert_object_info(struct odb_source_inmemory *source,
 	free(actual_content);
 }
 
+static void cl_assert_write_object(struct odb_source_inmemory *source,
+				   const char *content,
+				   enum object_type type,
+				   struct object_id *oid)
+{
+	size_t content_len = strlen(content);
+	cl_must_pass(odb_source_write_object(&source->base, content, content_len,
+					     type, oid, NULL, 0));
+}
+
 void test_odb_inmemory__initialize(void)
 {
 	odb = odb_new(&repo, "", "");
@@ -78,8 +89,7 @@ void test_odb_inmemory__read_written_object(void)
 	const char data[] = "foobar";
 	struct object_id written_oid;
 
-	cl_must_pass(odb_source_write_object(&source->base, data, strlen(data),
-					     OBJ_BLOB, &written_oid, NULL, 0));
+	cl_assert_write_object(source, data, OBJ_BLOB, &written_oid);
 	cl_assert_equal_s(oid_to_hex(&written_oid), FOOBAR_OID);
 	cl_assert_object_info(source, &written_oid, OBJ_BLOB, "foobar");
 
@@ -94,8 +104,7 @@ void test_odb_inmemory__read_stream_object(void)
 	const char data[] = "foobar";
 	char buf[3] = { 0 };
 
-	cl_must_pass(odb_source_write_object(&source->base, data, strlen(data),
-					     OBJ_BLOB, &written_oid, NULL, 0));
+	cl_assert_write_object(source, data, OBJ_BLOB, &written_oid);
 
 	cl_must_pass(odb_source_read_object_stream(&stream, &source->base,
 						   &written_oid));
@@ -141,8 +150,7 @@ void test_odb_inmemory__for_each_object(void)
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "%d", i);
 
-		cl_must_pass(odb_source_write_object(&source->base, buf.buf, buf.len,
-						     OBJ_BLOB, &written_oid, NULL, 0));
+		cl_assert_write_object(source, buf.buf, OBJ_BLOB, &written_oid);
 		cl_must_pass(oidset_insert(&expected_oids, &written_oid));
 	}
 
@@ -174,12 +182,9 @@ void test_odb_inmemory__for_each_object_can_abort_iteration(void)
 	struct object_id written_oid;
 	unsigned counter = 0;
 
-	cl_must_pass(odb_source_write_object(&source->base, "1", 1,
-					     OBJ_BLOB, &written_oid, NULL, 0));
-	cl_must_pass(odb_source_write_object(&source->base, "2", 1,
-					     OBJ_BLOB, &written_oid, NULL, 0));
-	cl_must_pass(odb_source_write_object(&source->base, "3", 1,
-					     OBJ_BLOB, &written_oid, NULL, 0));
+	cl_assert_write_object(source, "1", OBJ_BLOB, &written_oid);
+	cl_assert_write_object(source, "2", OBJ_BLOB, &written_oid);
+	cl_assert_write_object(source, "3", OBJ_BLOB, &written_oid);
 
 	cl_assert_equal_i(odb_source_for_each_object(&source->base, NULL,
 						     abort_after_two_objects,
@@ -199,12 +204,9 @@ void test_odb_inmemory__count_objects(void)
 	cl_must_pass(odb_source_count_objects(&source->base, 0, &count));
 	cl_assert_equal_u(count, 0);
 
-	cl_must_pass(odb_source_write_object(&source->base, "1", 1,
-					     OBJ_BLOB, &written_oid, NULL, 0));
-	cl_must_pass(odb_source_write_object(&source->base, "2", 1,
-					     OBJ_BLOB, &written_oid, NULL, 0));
-	cl_must_pass(odb_source_write_object(&source->base, "3", 1,
-					     OBJ_BLOB, &written_oid, NULL, 0));
+	cl_assert_write_object(source, "1", OBJ_BLOB, &written_oid);
+	cl_assert_write_object(source, "2", OBJ_BLOB, &written_oid);
+	cl_assert_write_object(source, "3", OBJ_BLOB, &written_oid);
 
 	cl_must_pass(odb_source_count_objects(&source->base, 0, &count));
 	cl_assert_equal_u(count, 3);
@@ -228,8 +230,7 @@ void test_odb_inmemory__find_abbrev_len(void)
 	 *
 	 * With only one blob written we expect a length of 4.
 	 */
-	cl_must_pass(odb_source_write_object(&source->base, "368317", strlen("368317"),
-					     OBJ_BLOB, &oid1, NULL, 0));
+	cl_assert_write_object(source, "368317", OBJ_BLOB, &oid1);
 	cl_must_pass(odb_source_find_abbrev_len(&source->base, &oid1, 4,
 						&abbrev_len));
 	cl_assert_equal_u(abbrev_len, 4);
@@ -238,8 +239,7 @@ void test_odb_inmemory__find_abbrev_len(void)
 	 * With both objects present, the shared 10-character prefix means we
 	 * need at least 11 characters to uniquely identify either object.
 	 */
-	cl_must_pass(odb_source_write_object(&source->base, "514796", strlen("514796"),
-					     OBJ_BLOB, &oid2, NULL, 0));
+	cl_assert_write_object(source, "514796", OBJ_BLOB, &oid2);
 	cl_must_pass(odb_source_find_abbrev_len(&source->base, &oid1, 4,
 						&abbrev_len));
 	cl_assert_equal_u(abbrev_len, 11);
@@ -257,9 +257,7 @@ void test_odb_inmemory__freshen_object(void)
 	cl_must_pass(parse_oid_hex_algop(RANDOM_OID, &oid, &end, repo.hash_algo));
 	cl_assert_equal_i(odb_source_freshen_object(&source->base, &oid), 0);
 
-	cl_must_pass(odb_source_write_object(&source->base, "foobar",
-					     strlen("foobar"), OBJ_BLOB,
-					     &written_oid, NULL, 0));
+	cl_assert_write_object(source, "foobar", OBJ_BLOB, &written_oid);
 	cl_assert_equal_i(odb_source_freshen_object(&source->base,
 						    &written_oid), 1);
 

-- 
2.55.0.407.g700c83d4f3.dirty

