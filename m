Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E0120CCC4
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 09:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743068652; cv=none; b=BgYvxq7ZoFPCB+QnqL8zEazFsZWGY8KMmERXiVtUCKi64Kb+Zgd2mUxXah3P7B4ti8yg3JW12935NqMgANw9bYJ+nMAWCT/CpNdygnHrPwVPHoi9UO6Ke82t0TAVLfokKoAJuW56/leaq9ftI+T8RZZBnT2SgvrefG41Opk7q9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743068652; c=relaxed/simple;
	bh=aEzVlYJxjlCZzl0UKXbNapG0L3j3Z788q//A404nmjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a6Sx64CKzQZebifuk2vwlmNlS5z60ja89IztJXPzYYDEinXMhtdsHemnBfcf3LD2tUvI5R+WZlTILQLOtAB142IoOPTGaRxRHEYNvp08pT1Lt2CGWKsrT9F9X4zlD1gYU8758Ekv1ZX4SP047BqcAjJr8R/Z5fl2N34VP1Djx1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LiEcmN2l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fX6t+LIP; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LiEcmN2l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fX6t+LIP"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 096AB1140127;
	Thu, 27 Mar 2025 05:44:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 27 Mar 2025 05:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743068650;
	 x=1743155050; bh=aIeg/EwH2oWUv+GUNYgeUNsF360bSxQXJjZuSRVArmE=; b=
	LiEcmN2lj8caQDfIs58IGMhDmf4nzaFOOLVsFsRWGALQvAWW6xliluTXfp21mRie
	0RpTUOn3n/N+2GG05/0P/Bs6nPYfPCvzfynG/eC3AgZKMwvmSOiy3vu58QN8AYOB
	Fx8rh1K70fi9MQ1f/QYlC2ZPYJ5IUFP0KQFQk07CGeyNMh+VOGvlzbm5tIhFQtNg
	YxaQDRJOX/jKWXm6CIR7jLj6nlL0z2dTYzJZG4IyHgz56fQz9ZZ37MvRaXiZhjp/
	nKJaQXD3as5vcIMJ0e9/gCH6uu3AhqNLBVmjgIc1Tzad0NlE88/C62SCwlcwYFmY
	vryCSDyiU7jVX2SPGwdI9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743068650; x=
	1743155050; bh=aIeg/EwH2oWUv+GUNYgeUNsF360bSxQXJjZuSRVArmE=; b=f
	X6t+LIPtTISOKRzdLMZs/m+/3s9JE/wulrVChA8e7igHnqb1lXKqcJX7NdWw3OAI
	Fahso54FJq0WsLljd9VjrlThQklvbwAgNv7vKVZGpDfy7TCfvWhIlHRQETAaIjUn
	tzqnslUassvq1PozBMr1YVyCNhLBfdQyPECLGWfJKVwahcgttcJunooSmQW7sETE
	oGPuZyi8JYPo3TlplP3ojL90l3WN6C6+FKywYHHcQJSCPsv0AQsDtWTjUBPG25wr
	6HPVKxMIRQc027CTjU3ReroT2MV0lI++CkbspaGxEKp15H9OCKCJ0uVXMc7Rr7tL
	N86ul38CpZ7S5EX51OEpw==
X-ME-Sender: <xms:6R3lZwii8xHXO4KSuKhd4bW8A35Vzae7tHaj-nB17oxSgeiiEQumQg>
    <xme:6R3lZ5BJpR-N3s6X5ZP5TdCntYugo0CHC6FMEoRqx7AJU1lRWYWPENm7uaFz-UrkO
    VgLoVW5mG2mDjv6Pg>
X-ME-Received: <xmr:6R3lZ4EKmKGEwxCd1xpFtC5UkKoT7Gt5fX_hnHJxeBcWzR4lRPinwv-gwHXpbOd22BKm4UfG24SCB-stp38j-N8cEbrK3kMrMYQhP92Jc3nnJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieektdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:6R3lZxTL-zjcImPKMdS3lySFSYa8IqKPLV2_xdGTa3UagtBvDlRfag>
    <xmx:6R3lZ9wzXUZ8dAczTZ4Ow4jKsw4SqpE--kjcju-mmDOjGUOgbeeX9g>
    <xmx:6R3lZ_5Y_cnfoaHzT0KKkIl9Ex2OLln0137Yj_dpsW6Q1WSoSx5wcA>
    <xmx:6R3lZ6ypmF__XotsIVh8xnlayQ3lmDasRlVzVn17M5YhZS210zfW7g>
    <xmx:6h3lZwqQKUOT-eXveqXYB3PZdQTlC2peHgQ2TXwi5bRalwNOMTg5cax9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 05:44:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 416554f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Mar 2025 09:44:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 27 Mar 2025 10:43:58 +0100
Subject: [PATCH v2 03/10] builtin/cat-file: support "blob:none" objects
 filter
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-pks-cat-file-object-type-filter-v2-3-4bbc7085d7c5@pks.im>
References: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
In-Reply-To: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Implement support for the "blob:none" filter in git-cat-file(1), which
causes us to omit all blobs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-cat-file.adoc |  2 ++
 builtin/cat-file.c              | 11 ++++++++++-
 t/t1006-cat-file.sh             | 33 +++++++++++++++++++++++++++++++--
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
index f7f57b7f538..bb32f715944 100644
--- a/Documentation/git-cat-file.adoc
+++ b/Documentation/git-cat-file.adoc
@@ -86,6 +86,8 @@ OPTIONS
 	Omit objects from the list of printed objects. This can only be used in
 	combination with one of the batched modes. The '<filter-spec>' may be
 	one of the following:
++
+The form '--filter=blob:none' omits all blobs.
 
 --path=<path>::
 	For use with `--textconv` or `--filters`, to allow specifying an object
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 940900d92ad..e783dbbad58 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -472,7 +472,8 @@ static void batch_object_write(const char *obj_name,
 	if (!data->skip_object_info) {
 		int ret;
 
-		if (use_mailmap)
+		if (use_mailmap ||
+		    opt->objects_filter.choice == LOFC_BLOB_NONE)
 			data->info.typep = &data->type;
 
 		if (pack)
@@ -492,6 +493,10 @@ static void batch_object_write(const char *obj_name,
 		switch (opt->objects_filter.choice) {
 		case LOFC_DISABLED:
 			break;
+		case LOFC_BLOB_NONE:
+			if (data->type == OBJ_BLOB)
+				return;
+			break;
 		default:
 			BUG("unsupported objects filter");
 		}
@@ -1032,6 +1037,10 @@ int cmd_cat_file(int argc,
 	switch (batch.objects_filter.choice) {
 	case LOFC_DISABLED:
 		break;
+	case LOFC_BLOB_NONE:
+		if (!batch.enabled)
+			usage(_("objects filter only supported in batch mode"));
+		break;
 	default:
 		usagef(_("objects filter not supported: '%s'"),
 		       list_object_filter_config_name(batch.objects_filter.choice));
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 1246d3119f8..d00073f8add 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -1354,7 +1354,22 @@ test_expect_success PERL '--batch-command info is unbuffered by default' '
 '
 
 test_expect_success 'setup for objects filter' '
-	git init repo
+	git init repo &&
+	(
+		# Seed the repository with three different sets of objects:
+		#
+		#   - The first set is fully packed and has a bitmap.
+		#   - The second set is packed, but has no bitmap.
+		#   - The third set is loose.
+		#
+		# This ensures that we cover all these types as expected.
+		cd repo &&
+		test_commit first &&
+		git repack -Adb &&
+		test_commit second &&
+		git repack -d &&
+		test_commit third
+	)
 '
 
 test_expect_success 'objects filter with unknown option' '
@@ -1365,7 +1380,7 @@ test_expect_success 'objects filter with unknown option' '
 	test_cmp expect err
 '
 
-for option in blob:none blob:limit=1 object:type=tag sparse:oid=1234 tree:1 sparse:path=x
+for option in blob:limit=1 object:type=tag sparse:oid=1234 tree:1 sparse:path=x
 do
 	test_expect_success "objects filter with unsupported option $option" '
 		case "$option" in
@@ -1385,4 +1400,18 @@ do
 	'
 done
 
+test_objects_filter () {
+	filter="$1"
+
+	test_expect_success "objects filter: $filter" '
+		git -C repo cat-file --batch-check="%(objectname)" --batch-all-objects --filter="$filter" >actual &&
+		sort actual >actual.sorted &&
+		git -C repo rev-list --objects --no-object-names --all --filter="$filter" --filter-provided-objects >expect &&
+		sort expect >expect.sorted &&
+		test_cmp expect.sorted actual.sorted
+	'
+}
+
+test_objects_filter "blob:none"
+
 test_done

-- 
2.49.0.472.ge94155a9ec.dirty

