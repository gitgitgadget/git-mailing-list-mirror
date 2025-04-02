Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12E123909C
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 11:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743592431; cv=none; b=UxTlvCtm1zeYl2g6m5Ff0VKuB52izFXga8lQs/pCgPmksP0aXbrJ8wTYg7dDcx2h1ePmr2I8PgysHDMdUzs4SRXyrJJCQ5vYGdaCWB1UZG9PPvfonxUZZ2yJW4zxtxB5IOXokM+zkzBw/R3EIAGN422C/sIILip7nuTPqA9F7RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743592431; c=relaxed/simple;
	bh=rE9YxizXvHuJ1AkUp50tg9PqQguItZ8WI7lK5w2KNq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g6vJDoqPu3R/EOvoTEnSLECmPDZhGaKvU7OqTkuiKh7vB5Kxgz9ytC/6LWH9CiH+ELBbqj+lJKAFe1f4/kRgSLAXen6b+zBxx9GTN3JheYPOlRKFS4tuYsPAJlIdzt7jCBJNv5Aw81KEXKjVDDke9MfxVgsAcCcJ8BxbvQnKBxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ij+/jTvJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AmVcMvKu; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ij+/jTvJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AmVcMvKu"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CD1752540170;
	Wed,  2 Apr 2025 07:13:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 02 Apr 2025 07:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743592428;
	 x=1743678828; bh=0L4So13E3xUll4DP9krphxzS0plX/03/qcciZy3GmOs=; b=
	ij+/jTvJvDxD4E3eqNOQz6Y+7MybEjsmb4RwDwZKzGWcFI/qI979znvzEBb0Q92W
	VF/kBz4olGddiurswtbdfoXzNnGgoZm/pmlSEziacZo7kYBFQTwxa+iAEIgjBzco
	kCTpRWAppzv+/vjScSh5/QhmGifkPiUWD8rT99BfJQL6hi2j2qm6jTsstJ4oecdn
	596uwBwHO4R2q1Pu6OCfHJe7mwpWLnGqaWDLNUb8o1fdOSo5AKiWIT4LP1VIyZAp
	DcSE6WWOjzqkF75qj0Y0gSa1DYYsCHJOal0+/B0mcGxuKEsFKkFJ0jjci+loiJon
	yOtEHidFiXey/manYQToiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743592428; x=
	1743678828; bh=0L4So13E3xUll4DP9krphxzS0plX/03/qcciZy3GmOs=; b=A
	mVcMvKu4glCvZbvXMVrcRkpP6MKaz6rBihG9clIBbxt8f1ia/ASlyF6tR+dntibZ
	N3xIlywGlqNoF0BUmiEcZhgYM2U4ZsxXJzQT9yiRu3ALbQ5yxdhdrreEK2cB+eVf
	DMLPKTRgQ/VGSxCG/ELuuMWgvLQrKfTm+I0KEsh2a94aHgh0BIwjnew7HuVAZpZF
	msijn/QLHkSn5tlf1OMyrYj1OPRDsvXC8PQxnMySzlYCuUQVtecm6uFSfVl6HLoj
	JYNd+LUWExQ3Q2ISjHgN5EGPNDZ515lmqwsrfVWe150pgZUHIB7RwxWrzdTogub1
	WFj1KITb3dDSHeT1bYJEQ==
X-ME-Sender: <xms:7BvtZ6hdPCbmft_NNsisQ7Vwtqp5YwNILwaPi3h8jjN92bf-xnq0rg>
    <xme:7BvtZ7DsrtLCfE71dYa4j8ptDFll3ll5B2YaA2OnDOSS4RcnsO6UIZkU35yAYdfIX
    OMW2mpQEXgxETSa6w>
X-ME-Received: <xmr:7BvtZyE_wabXMyUnGxm93BV_ZIFGaFsnsjkJm-h6ymihYSoMLFYDljnCyi3itCR3q33OeUoVDZT8V41Aw3QzFi5PA3bXwAuzE-EVU0YVDGySWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:7BvtZzTzTrSehPsfplh5lyNkjja7u9fY-bGn51KHpMj-XGvZLBsV5g>
    <xmx:7BvtZ3wJUjxJTDT24Jj6LIE27tPCpr8klxs8cNlNOxRKZnvyrChQ_w>
    <xmx:7BvtZx4OqipDcbdELAYSdqj7yMrPCP9Rt4TlE747Jo4brK5pXlcbrw>
    <xmx:7BvtZ0yIXG3FrDFFFGRsImI6th_tdC_BTkqYGqOwZnMcB6rpUO1yvw>
    <xmx:7BvtZ0jO6oGCEfwhQWX4VSkac6ZzXxteGJPGKeUC4YP88dk275O3wJ8L>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 07:13:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4e650078 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Apr 2025 11:13:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 02 Apr 2025 13:13:40 +0200
Subject: [PATCH v3 05/11] builtin/cat-file: support "blob:limit=" objects
 filter
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250402-pks-cat-file-object-type-filter-v3-5-4da6bb21871c@pks.im>
References: <20250402-pks-cat-file-object-type-filter-v3-0-4da6bb21871c@pks.im>
In-Reply-To: <20250402-pks-cat-file-object-type-filter-v3-0-4da6bb21871c@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Implement support for the "blob:limit=" filter in git-cat-file(1), which
causes us to omit all blobs that are bigger than a certain size.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-cat-file.adoc |  5 +++++
 builtin/cat-file.c              | 15 ++++++++++++++-
 t/t1006-cat-file.sh             | 18 +++++++++++++++---
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
index afcdb0a4738..48e05e1af52 100644
--- a/Documentation/git-cat-file.adoc
+++ b/Documentation/git-cat-file.adoc
@@ -91,6 +91,11 @@ OPTIONS
 	printed at all. The '<filter-spec>' may be one of the following:
 +
 The form '--filter=blob:none' omits all blobs.
++
+The form '--filter=blob:limit=<n>[kmg]' omits blobs of size at least n
+bytes or units.  n may be zero.  The suffixes k, m, and g can be used to name
+units in KiB, MiB, or GiB.  For example, 'blob:limit=1k' is the same as
+'blob:limit=1024'.
 
 --path=<path>::
 	For use with `--textconv` or `--filters`, to allow specifying an object
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index bcceb646f85..629c6cddcb2 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -483,8 +483,11 @@ static void batch_object_write(const char *obj_name,
 		int ret;
 
 		if (use_mailmap ||
-		    opt->objects_filter.choice == LOFC_BLOB_NONE)
+		    opt->objects_filter.choice == LOFC_BLOB_NONE ||
+		    opt->objects_filter.choice == LOFC_BLOB_LIMIT)
 			data->info.typep = &data->type;
+		if (opt->objects_filter.choice == LOFC_BLOB_LIMIT)
+			data->info.sizep = &data->size;
 
 		if (pack)
 			ret = packed_object_info(the_repository, pack, offset,
@@ -509,6 +512,15 @@ static void batch_object_write(const char *obj_name,
 				return;
 			}
 			break;
+		case LOFC_BLOB_LIMIT:
+			if (data->type == OBJ_BLOB &&
+			    data->size >= opt->objects_filter.blob_limit_value) {
+				if (!opt->all_objects)
+					report_object_status(opt, obj_name,
+							     &data->oid, "excluded");
+				return;
+			}
+			break;
 		default:
 			BUG("unsupported objects filter");
 		}
@@ -1049,6 +1061,7 @@ int cmd_cat_file(int argc,
 	case LOFC_DISABLED:
 		break;
 	case LOFC_BLOB_NONE:
+	case LOFC_BLOB_LIMIT:
 		if (!batch.enabled)
 			usage(_("objects filter only supported in batch mode"));
 		break;
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 7404c135b1e..4f14840b71a 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -1356,11 +1356,12 @@ test_expect_success PERL '--batch-command info is unbuffered by default' '
 test_expect_success 'setup for objects filter' '
 	git init repo &&
 	(
-		# Seed the repository with three different sets of objects:
+		# Seed the repository with four different sets of objects:
 		#
 		#   - The first set is fully packed and has a bitmap.
 		#   - The second set is packed, but has no bitmap.
 		#   - The third set is loose.
+		#   - The fourth set is loose and contains big objects.
 		#
 		# This ensures that we cover all these types as expected.
 		cd repo &&
@@ -1368,7 +1369,14 @@ test_expect_success 'setup for objects filter' '
 		git repack -Adb &&
 		test_commit second &&
 		git repack -d &&
-		test_commit third
+		test_commit third &&
+
+		for n in 1000 10000
+		do
+			printf "%"$n"s" X >large.$n || return 1
+		done &&
+		git add large.* &&
+		git commit -m fourth
 	)
 '
 
@@ -1380,7 +1388,7 @@ test_expect_success 'objects filter with unknown option' '
 	test_cmp expect err
 '
 
-for option in blob:limit=1 object:type=tag sparse:oid=1234 tree:1 sparse:path=x
+for option in object:type=tag sparse:oid=1234 tree:1 sparse:path=x
 do
 	test_expect_success "objects filter with unsupported option $option" '
 		case "$option" in
@@ -1435,5 +1443,9 @@ test_objects_filter () {
 }
 
 test_objects_filter "blob:none"
+test_objects_filter "blob:limit=1"
+test_objects_filter "blob:limit=500"
+test_objects_filter "blob:limit=1000"
+test_objects_filter "blob:limit=1k"
 
 test_done

-- 
2.49.0.604.gff1f9ca942.dirty

