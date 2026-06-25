Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9653C6A38
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 09:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782381481; cv=none; b=orbL6ks8wtjYlyfgc4HUXQ1iFk4ZCXG1jKSw3TC9n6+v7dky2h/KtFt0TZy9FRiRB7OV8xXtA1jnWEje6p7yZqIL/p5o1vtxa5w1D0hd/GSouqpoVKVk6FFuf6ZQvVx5qVGH/wSwUcyGTr7t4sNkr1+scGtDtjdFazxOYMpxxtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782381481; c=relaxed/simple;
	bh=HjiN47OxfUZXTqXq/ygSXNjdefFmPEff51vc/IkYdAs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qpbnUoOdPfURUFGiaqxmCzKMFeeLMz5ovKka02rvumz2tAegsrwMz3uQbSKP/bgYbFL0K0+4AgwOTIgH7W7VseUUdLJ7CDAB4wCPhJ8VBaCk3F3Xg550sa94SgMCqdS0YoKMscSv1FcWyADjjVXUBmegZ269ZUbQ0n4Au1DIknI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kNjGmLep; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f3pK02hb; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kNjGmLep";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f3pK02hb"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 667F97A0100;
	Thu, 25 Jun 2026 05:57:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 25 Jun 2026 05:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782381479;
	 x=1782467879; bh=MTAgBKSymW31YzZdCXYJ7ZYXeUhJRwD0nD/yjxlncu8=; b=
	kNjGmLeptn7sVYSeFZzTMDkbGfH76tXgsmaKrnP0MF8oLf48giBSCDAJvwJjSrQu
	Plu4M7yd+HAKEbgba6BW21UQIT8i78hlOuOpcDqSuuXh0NiYNB+JlBgOqZ9X5l7C
	erIPLxNEUJau/70POO8FpUEkHg1izdCKdpjMXsUch9ZCeydi1CZfZrEySN3VBuE9
	fqT/hkbUE3/6j9M8lZ7iQYa6RGpIU2ZmJ3ggQPtOJMq0FXPe+TA6DipkydepGJ77
	fme2/T72hSWBnuyXL3Mkk+9TdM/EKiqSsThGID7QGcnT1IA3QYr3lRJC/hsOM2dH
	2ggaCNaRbfocKSNoutSTew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782381479; x=
	1782467879; bh=MTAgBKSymW31YzZdCXYJ7ZYXeUhJRwD0nD/yjxlncu8=; b=f
	3pK02hbu6hL1NGkzWbPHQCBW0fwgq6UhoJfCKqf41ufsW1PaIF14SslOj+lZ22qc
	CCu7PY0Jw59RXRw4uvYvK2kUxWqAhPYWQU72uAp1PC2dSy3en4CcJP07foRXLxVy
	PCe77R2SZVzXcqiEtWYRzt33ojnT2WWuyAD65MlEq9rJz1O6LDYI9WP0ayECUotH
	EbHRnv+rQ4J/uzUYsJlsv3VT/JI9hv/ed2S7GZEFeqTHzgGkUihr7RV92sOGAz11
	5328LnzgWQ1e71tH9sFTWjGMN2hhsB17kSRGUUvYZhwvWzNCpscNMCh2n+EDNstu
	TL4NoQV7rtKibvpU4j/RQ==
X-ME-Sender: <xms:p_s8avGs8rTTpfxpeor56uLvHyWDre7hzapE0f8CthFgiaVIFIr53Q>
    <xme:p_s8ajwgsjAWSk7LlQC8C1rKTxq-2zx3gGVmU78dt1VXAgCb8I0U8zyWOHUg5nuGv
    fNrwL-UWQh2qZ1PnLW2qgKYEfR9YSypdUe8PtwI1tifwLohJOVyHQ>
X-ME-Received: <xmr:p_s8auipm7jr3w4ildyjweThSXvJyfAERfjSX9MPePi570xHZDONuolU23OuwV44gMwteldIooofKn2LScZnZBy1fu5s36coYfSKSiNsoQ>
X-ME-Proxy-Cause: dmFkZTFd9OKwzScaIel6hyHQ7PTwuQAy2Y3XUhlp/jcWq3FdoRFLkibveFDERml7rQtzDU
    Eu8te+PJMbQJ99Kq2CDG/Aqz4rJ2HPe2h4ZIBkvKqrLSAWhHcrBHeW0SXEMJ8uK1Z5oqxT
    3oBH1HXTfE2rL4tejKsUVMXAZFLDaQ+w/Yu2B4yoybwOISfcetAHEB4dFDJHsE/XU6Nzv3
    +orCI+5BPg6YuDgMNcsiVTLf4AGmRGCZ0rmFjjPeEZkJF8BxdpvpN+hvQk4vYN7KcXQpHw
    M+6vjeaIXmA1bO28vEBcTKZvdg4OjRIrh9nUkmmOHgzOluOH6hQ7OsQdrjf78GFU5HX6i/
    e8lVDmHhFI9nML4QY52+BldQtlQkPqL93VDXZB8Jc3nS6KTUdJZ9dO40ZyPNQuY9iZ/8ZP
    j0TNGBZ9RGBm/crxTObqUZwqTz3x1L60js0MKjVONahaYCWz0XL1lEoFZTmDlDLXPs6mgB
    3r4pHv/K+2bXiqGCTUNRsNZbEw/rzR/7F4Swv4WHGdAWO/riDZDusbJOUZHzMMXpdV2b64
    eYHpjU1SrQqHRD9xq9qfDg2fY8QPxvFSHw7VVtzMG3P49uneXGRtICtvAxQA7ajtxlkcNS
    1wyIojb2ZrUojg26rnGA96EjNQnt9YRmo9XvjnOrt8vUal0z3Mw+6hVQwlaw
X-ME-Proxy: <xmx:p_s8amxLmC8SvT2QXbxNzHhbJd6zA1F9vwHD5FqrR6a7Jx8Hayqczg>
    <xmx:p_s8apKgjLHCnT1qFu-Qz9ZYrPUs2P9bg3tuht-CdDPLDuWFl1lsLw>
    <xmx:p_s8alQLTZ638D7xfI0XF7H4phECqtIou-eznm-2ChDy-kgNhmzfIA>
    <xmx:p_s8appUPlbe0cJgS641QXpGX5q7r04sLgclM1BTRlmapoMTd47UdQ>
    <xmx:p_s8ala_HdeuIHy1LV9oa02a-vdvIiPN38R88SzJ8X3UTGEmlEYt10sH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 05:57:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a2071796 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 25 Jun 2026 09:57:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 25 Jun 2026 11:57:42 +0200
Subject: [PATCH v3 4/4] connected: search promisor objects generically
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-pks-connected-generic-promisor-checks-v3-4-7308f3b9dc44@pks.im>
References: <20260625-pks-connected-generic-promisor-checks-v3-0-7308f3b9dc44@pks.im>
In-Reply-To: <20260625-pks-connected-generic-promisor-checks-v3-0-7308f3b9dc44@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15.2

When performing connectivity checks we have to figure out whether any of
the new objects are promisor objects, as we cannot assume full
connectivity if so.

This check is performed by iterating through all packfiles in the
repository and searching each of them for the given object. Of course,
this mechanism is quite specific to implementation details of the object
database, as we assume that it uses packfiles in the first place.

Refactor the logic so that we instead use `odb_for_each_object_ext()`
with an object prefix filter and the `ODB_FOR_EACH_OBJECT_PROMISOR_ONLY`
flag. This will yield all objects that have the exact object name and
that are part of a promisor pack in a generic way.

Add a test to verify that we indeed use the optimization.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 connected.c              | 35 ++++++++++++++++++++++++-----------
 t/t5616-partial-clone.sh | 24 ++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/connected.c b/connected.c
index d2b334173f..929b9bd28d 100644
--- a/connected.c
+++ b/connected.c
@@ -11,6 +11,15 @@
 #include "packfile.h"
 #include "promisor-remote.h"
 
+static int promised_object_cb(const struct object_id *oid UNUSED,
+			      struct object_info *oi UNUSED,
+			      void *payload)
+{
+	bool *found = payload;
+	*found = true;
+	return 1;
+}
+
 /*
  * For partial clones, we don't want to have to do a regular connectivity check
  * because we have to enumerate and exclude all promisor objects (slow), and
@@ -30,25 +39,29 @@ static int check_connected_promisor(oid_iterate_fn fn,
 				    void *cb_data,
 				    const struct object_id **oid)
 {
+	struct odb_for_each_object_options opts = {
+		.flags = ODB_FOR_EACH_OBJECT_PROMISOR_ONLY,
+		.prefix_hex_len = the_repository->hash_algo->hexsz,
+	};
+	int err;
+
 	odb_reprepare(the_repository->objects);
 	do {
-		struct packed_git *p;
+		bool found = false;
 
-		repo_for_each_pack(the_repository, p) {
-			if (!p->pack_promisor)
-				continue;
-			if (find_pack_entry_one(*oid, p))
-				goto promisor_pack_found;
-		}
+		opts.prefix = *oid;
+
+		err = odb_for_each_object_ext(the_repository->objects, NULL,
+					      promised_object_cb, &found, &opts);
+		if (err < 0)
+			return err;
 
 		/*
 		 * We have found an object that is not part of a promisor pack,
 		 * and thus we cannot skip the full connectivity check.
 		 */
-		return 0;
-
-promisor_pack_found:
-		;
+		if (!found)
+			return 0;
 	} while ((*oid = fn(cb_data)) != NULL);
 
 	return 1;
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 1c2805acca..905052072d 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -97,6 +97,30 @@ test_expect_success 'partial fetch inherits filter settings' '
 	test_line_count = 5 observed
 '
 
+test_expect_success 'partial fetch does not spawn rev-list connectivity check' '
+	test_when_finished "rm -rf connectivity-remote connectivity-client" &&
+	git init connectivity-remote &&
+	test_commit -C connectivity-remote one &&
+	git -C connectivity-remote config uploadpack.allowfilter 1 &&
+	git -C connectivity-remote config uploadpack.allowanysha1inwant 1 &&
+
+	git clone --no-checkout --filter=blob:none \
+		"file://$(pwd)/connectivity-remote" connectivity-client &&
+
+	# When doing a partial fetch where all tips are part of a promisor pack
+	# we want to skip the connectivity check, as these objects are allowed
+	# to not be fully connected.
+	test_commit -C connectivity-remote two &&
+	GIT_TRACE2_EVENT="$(pwd)/partial.trace" git -C connectivity-client fetch origin &&
+	test_subcommand_flex ! git rev-list --objects --stdin <partial.trace &&
+
+	# Otherwise, when doing a fetch where any of the tips is not part of a
+	# promisor pack, then we must run the connectivity check.
+	test_commit -C connectivity-remote three &&
+	GIT_TRACE2_EVENT="$(pwd)/full.trace" git -C connectivity-client fetch --no-filter origin &&
+	test_subcommand_flex git rev-list --objects --stdin <full.trace
+'
+
 # force dynamic object fetch using diff.
 # we should only get 1 new blob (for the file in origin/main).
 test_expect_success 'verify diff causes dynamic object fetch' '

-- 
2.55.0.rc1.745.g43192e7977.dirty

