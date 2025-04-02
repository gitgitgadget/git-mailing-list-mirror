Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4735E239560
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 11:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743592429; cv=none; b=aGPsHkhiqvWHpcYCF7MKd9Wnh0cbdHA+OgCRQ1a0zmP7ppIxrpZUA04uPiaNsV+UyrW5yFB3sdcLclrTnufYUFNf9s+yqTre7fOZaz8Aku4idB/UI6wKCEsld21GD96DPFgqYZmMkd5TSOnNWgydbZLsuliVm6NhoDtaG79tct4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743592429; c=relaxed/simple;
	bh=SfyazYC9ViilJPj1kMGWPrCS1quUlpXlS4/XhTSCVhk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AgCujETyj7NSzoSMLTNmlVe9nliY+EvB1q/+vjuNezwPlFE0v1My1bnlA5g2Tw9+2tRfUJcrc5eZkhk7dPpm2Ubv2OQYP2Sq6yK768hEr6o78jjX/lyxVAVYPi5tMiHIRvectTU7uZ39r7XUXtqLTyRe5uSc1Xl3YvF5tISiRU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TE8rR384; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oZvThmeC; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TE8rR384";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oZvThmeC"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 3DA1B1140205;
	Wed,  2 Apr 2025 07:13:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 02 Apr 2025 07:13:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743592427;
	 x=1743678827; bh=l+vhZtT5TBNChO3XXyTxcbqs2nTzePOeurtKT4lyIug=; b=
	TE8rR3848jxF5lt182o7A7jT5xYp6BaD4PocF0jvmN3bo/mOx4lxjDOoZ7tmUlGA
	/Hcycw6Lp7PdzQIWw1Wy3upmzJYZJNsE+rTfSRQK+0nQJsQq2yKtxxEAmSZYrHxh
	GtKfH/5+DrXXV0qK8Kua9WLnid3m/HdNHzbMuoWNwdpG0+00c8KB+Qp0Z8yocsTJ
	tzNsRuCBe3VN/fNWpKJElGDnI6/TNrzlenc+yCYZE/d+vG5tLNVQXfhNqE8wn+It
	0Wb4qBrBtbxBENqXLNsLdGwMoqmoQshT3waqbhr5jLYmbEYZs14O+YaoeCI1jw2h
	URFCI8zkdsejVeqe+tHhzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743592427; x=
	1743678827; bh=l+vhZtT5TBNChO3XXyTxcbqs2nTzePOeurtKT4lyIug=; b=o
	ZvThmeCQeC0iw4ENbcya5goJTh7xwDowwvafEcIyWilDd1fitdYx7sGpY44x7RO5
	At0rCkBvBWK9JE2Ws6gugTlbQ7Lbs93Jc7MpFbhcNFunJSNb8s0s207iEIjNu8nc
	CYZWEi1mbkLsi+sV+JDK7ATE7vixLqxhd9YvCf0gCmW2p5jmfLIGcS8T41E4bYUd
	hImyXFYr8wTk5gP1yXDdHJclq+MS2wsD0DAFXQ8zc1NRRhCurSCQQEIQivcDdlo4
	rNiZdX4EynohdhWKx8OZhi3UHBZQ0n98q/K0/ZRl1cNVakhfgDLJLp940ygn0MaX
	m7AZ0dzCoe9K5oYS55qrw==
X-ME-Sender: <xms:6hvtZxpZOU8Z219bRSrfmqITO3b7Ll4LdmhWrL1tHV_178iGrK3jBw>
    <xme:6hvtZzpoZjkSscQGng1vRA9MFo9pFlkGADh-IUPM2wchzblpTmqT6Cpd4_T2kyC5E
    sjuRdluQOMbk4IfRA>
X-ME-Received: <xmr:6hvtZ-PUFstAcdoirovQSfvvJGd2m_2GpbuOvV-AsYHeNYm9rS0igT5_wjvtTno4w_Nw3Fadf-CuRXihTDjAnfMiZn549S7DQB9vGZjbfuGuag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtg
    hpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopeht
    ohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6xvtZ84CJFwl2KdNbkVItxqmApkuUEkzYs_gTleZ2cdFcePAqnbB6w>
    <xmx:6xvtZw4KBgwjzS1RZbaUTGeXI7KmXaB_Xa8nKG_2k4oerZFK7zV_-Q>
    <xmx:6xvtZ0h4aXWePXa1KxN8Opy9YpyHMxcPo7ZYyXxy0FMA9AAX99NVgg>
    <xmx:6xvtZy549oSGxjPtUCVlhvIWLhvqt0-_ByaiZ8pFeUtORBkNyTwSBg>
    <xmx:6xvtZ4KRAhl1BG2NHCmYTNzQcn_YyoXiTJ3p6PJnkusMd-M_hG25fHTk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 07:13:46 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 779888b7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Apr 2025 11:13:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 02 Apr 2025 13:13:39 +0200
Subject: [PATCH v3 04/11] builtin/cat-file: support "blob:none" objects
 filter
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250402-pks-cat-file-object-type-filter-v3-4-4da6bb21871c@pks.im>
References: <20250402-pks-cat-file-object-type-filter-v3-0-4da6bb21871c@pks.im>
In-Reply-To: <20250402-pks-cat-file-object-type-filter-v3-0-4da6bb21871c@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Implement support for the "blob:none" filter in git-cat-file(1), which
causes us to omit all blobs.

Note that this new filter requires us to read the object type via
`oid_object_info_extended()` in `batch_object_write()`. But as we try to
optimize away reading objects from the database the `data->info.typep`
pointer may not be set. We thus have to adapt the logic to conditionally
set the pointer in cases where the filter is given.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-cat-file.adoc |  4 +++-
 builtin/cat-file.c              | 15 ++++++++++++-
 t/t1006-cat-file.sh             | 47 +++++++++++++++++++++++++++++++++++++++--
 3 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
index da92eed1170..afcdb0a4738 100644
--- a/Documentation/git-cat-file.adoc
+++ b/Documentation/git-cat-file.adoc
@@ -88,7 +88,9 @@ OPTIONS
 	been explicitly requested via any of the batch modes that read objects
 	via standard input (`--batch`, `--batch-check`) will be reported as
 	"filtered". Excluded objects in `--batch-all-objects` mode will not be
-	printed at all. No filters are supported yet.
+	printed at all. The '<filter-spec>' may be one of the following:
++
+The form '--filter=blob:none' omits all blobs.
 
 --path=<path>::
 	For use with `--textconv` or `--filters`, to allow specifying an object
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 0e2176c4491..bcceb646f85 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -482,7 +482,8 @@ static void batch_object_write(const char *obj_name,
 	if (!data->skip_object_info) {
 		int ret;
 
-		if (use_mailmap)
+		if (use_mailmap ||
+		    opt->objects_filter.choice == LOFC_BLOB_NONE)
 			data->info.typep = &data->type;
 
 		if (pack)
@@ -500,6 +501,14 @@ static void batch_object_write(const char *obj_name,
 		switch (opt->objects_filter.choice) {
 		case LOFC_DISABLED:
 			break;
+		case LOFC_BLOB_NONE:
+			if (data->type == OBJ_BLOB) {
+				if (!opt->all_objects)
+					report_object_status(opt, obj_name,
+							     &data->oid, "excluded");
+				return;
+			}
+			break;
 		default:
 			BUG("unsupported objects filter");
 		}
@@ -1039,6 +1048,10 @@ int cmd_cat_file(int argc,
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
index 9ce4eda6e68..7404c135b1e 100755
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
@@ -1393,4 +1408,32 @@ test_expect_success 'objects filter: disabled' '
 	test_cmp expect.sorted actual.sorted
 '
 
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
+
+	test_expect_success "objects filter prints excluded objects: $filter" '
+		# Find all objects that would be excluded by the current filter.
+		git -C repo rev-list --objects --no-object-names --all >all &&
+		git -C repo rev-list --objects --no-object-names --all --filter="$filter" --filter-provided-objects >filtered &&
+		sort all >all.sorted &&
+		sort filtered >filtered.sorted &&
+		comm -23 all.sorted filtered.sorted >expected.excluded &&
+		test_line_count -gt 0 expected.excluded &&
+
+		git -C repo cat-file --batch-check="%(objectname)" --filter="$filter" <expected.excluded >actual &&
+		awk "/excluded/{ print \$1 }" actual | sort >actual.excluded &&
+		test_cmp expected.excluded actual.excluded
+	'
+}
+
+test_objects_filter "blob:none"
+
 test_done

-- 
2.49.0.604.gff1f9ca942.dirty

