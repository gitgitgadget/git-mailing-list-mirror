Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5319113BC3D
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 06:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724308512; cv=none; b=NFb/HdzjA6zocKrkgB9i8orctFZ4+Ev/6XFBFg60ML04/NG9GhxjZgTjLZxa+alD/OKFgOj5Ql6b0al4WrmTsJTsILFGR0QpXOjwg9LfY6k/ohsSBUDjFX76yGmUWDFnoidBbYHwyx1rcjXr56sXB8EAMoVTB/pXQjztGigMkIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724308512; c=relaxed/simple;
	bh=48Kf6WTw+hqwBqGB+p/UyWH4G79KYYPomfGjesLdM6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+uRaxqtgHVZMpMe7tkaZ++5QtWckPixtz9mYG6PBNGDbSpJno2biRtyqtQrwFtM20znD7xMC87pdVZHFF6PS3a8ouSzSrK/jna9UrxjqKpU0GOAoFcV5wDj5gwOBt04S4EqglqfjkSA1KG7g1jBrWthDfp02w2sS+dNEwPwpEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AcMalZ8Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=be/KH3m2; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AcMalZ8Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="be/KH3m2"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id A01DF138592E;
	Thu, 22 Aug 2024 02:35:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 22 Aug 2024 02:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724308510; x=1724394910; bh=NPNSutiB4g
	1wvpQR1kGgWngYJU0Haz4HkZySik9SPJs=; b=AcMalZ8QLgd9lDOSsqr/NyJZEm
	6hkXXFcsgsrjpUa7seB9Oncx+aQbnebBDd5kdTNhqg3cHQicGchDqMT/DS2q1zH8
	8ApB7uSq4+f0rgcNRsbwsMYpS0DH9Bq0yMzqdevl94rbPsnJrGoeJJeun8ydDhqv
	WMhHDj32LwF3BNY0SqxZXzyCxI1sEDNDVUuc4NpexiAiZa8t6iJ2+tQ0j6v2Sb9e
	bBXvFQPdaE4bHUoo0N/CtLSeyGnlQ6UAxS28ohhw7pRGSEZl5m1kVgsIfJVEFysC
	ievswb4yPsudIr//Yu84TiycBlw40pMdFQ5xh4A8WRVb9Mo497knca3M6ejw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724308510; x=1724394910; bh=NPNSutiB4g1wvpQR1kGgWngYJU0H
	az4HkZySik9SPJs=; b=be/KH3m2ESe/qEH/1J3p4kVCW62Trh1wIUruW7bv2/XB
	fwiYQW1a1eQtUzz1vsw+ExKWSU6fGV/mPGdIexYCXJEmLsA/QYZI4DCqSUu5Y6QI
	EztXFMI4mihmF9W9+Grr+pHjlQ2qXz2lvPN55UZYxj9TYDG6u4kfRIX8hryCnZDx
	F5rK3pCRvJtiK/lA++iSRPkZsfaDxxi0KCM3zwLj/dBVmwz7e1TpBPYJLRg9fJdB
	n3jiTkIe5J88DrjMcvJ6+pds+PhfVWttFdLY5Pe4IEjIFNx1jJ52tlhwmpIHm1gA
	cQ8fLZR92Dsnq7LlzDDz4CtqQTIIl/bE9+1XGgDX3g==
X-ME-Sender: <xms:HtzGZiaCQcePxoe9iHSGrmhbn6DOXzve_Rhdldr1WJTXara1OdjYDw>
    <xme:HtzGZlaq0Og_ZPrckgxA0XmA0nhAw_5E5mixhBSLYhTnGyKVcZ-5OlxgZZn-xRIsY
    5DPAyYCufXQeCB4ew>
X-ME-Received: <xmr:HtzGZs8iiiw8NbX_Ntqlyuet9NKaWQ62WG8utlsAWBFrZmq3C8BX7Tqb0kdGYOsAv1C81jiWw5GWahHpoW-L0EIvt6GpHfc1q0f7_2JZHsqR09Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduledguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:HtzGZko4zu9aP5_Jcqb5za6DKnT6QxvN8ztVpy_DTfq0CoEwHfiVXQ>
    <xmx:HtzGZto33K2JEymKpQurrxXBFuHJsOWUg4qPWI6bHsZa0Bx5PDfOcw>
    <xmx:HtzGZiRA0Oq6mj1c5dodaN-GHkcs53B8CE-ojWsSA1elVOx83entGA>
    <xmx:HtzGZto4GeCyqNARWN6skMAnTH1G1nJXcsBlxt5DUaZFiy8ruuMJ2w>
    <xmx:HtzGZkUGiyMl3IxVhe1cm9luwVQzay8jcIAER3ljAqRaxLXFJQfYgPkd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 02:35:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 85d74ec1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 06:34:35 +0000 (UTC)
Date: Thu, 22 Aug 2024 08:35:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 09/15] t/helper: inline `reftable_reader_print_file()`
Message-ID: <a62e4612e97dbe9c719ce1bf698158729bc14dd0.1724308389.git.ps@pks.im>
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

Move `reftable_reader_print_file()` into the "dump-reftable" helper.
This follows the same reasoning as the preceding commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reader.c          | 21 ---------------------
 reftable/reftable-reader.h |  2 --
 t/helper/test-reftable.c   | 23 ++++++++++++++++++++++-
 3 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/reftable/reader.c b/reftable/reader.c
index e3f58542297..fbd93b88dff 100644
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
diff --git a/reftable/reftable-reader.h b/reftable/reftable-reader.h
index a32f31d6486..7c7d1716516 100644
--- a/reftable/reftable-reader.h
+++ b/reftable/reftable-reader.h
@@ -64,8 +64,6 @@ uint64_t reftable_reader_min_update_index(struct reftable_reader *r);
 void reftable_table_from_reader(struct reftable_table *tab,
 				struct reftable_reader *reader);
 
-/* print table onto stdout for debugging. */
-int reftable_reader_print_file(const char *tablename);
 /* print blocks onto stdout for debugging. */
 int reftable_reader_print_blocks(const char *tablename);
 
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 7f37d0cd34b..19367c25f9a 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -1,5 +1,6 @@
 #include "reftable/system.h"
 #include "reftable/reftable-error.h"
+#include "reftable/reftable-generic.h"
 #include "reftable/reftable-reader.h"
 #include "reftable/reftable-stack.h"
 #include "reftable/reftable-tests.h"
@@ -28,6 +29,26 @@ static void print_help(void)
 	       "\n");
 }
 
+static int dump_reftable(const char *tablename)
+{
+	struct reftable_block_source src = { NULL };
+	int err = reftable_block_source_from_file(&src, tablename);
+	struct reftable_reader *r = NULL;
+	struct reftable_table tab = { NULL };
+	if (err < 0)
+		goto done;
+
+	err = reftable_new_reader(&r, &src, tablename);
+	if (err < 0)
+		goto done;
+
+	reftable_table_from_reader(&tab, r);
+	err = reftable_table_print(&tab);
+done:
+	reftable_reader_free(r);
+	return err;
+}
+
 int cmd__dump_reftable(int argc, const char **argv)
 {
 	int err = 0;
@@ -64,7 +85,7 @@ int cmd__dump_reftable(int argc, const char **argv)
 	if (opt_dump_blocks) {
 		err = reftable_reader_print_blocks(arg);
 	} else if (opt_dump_table) {
-		err = reftable_reader_print_file(arg);
+		err = dump_reftable(arg);
 	} else if (opt_dump_stack) {
 		err = reftable_stack_print_directory(arg, opt_hash_id);
 	}
-- 
2.46.0.164.g477ce5ccd6.dirty

