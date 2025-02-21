Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A611FDA90
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 07:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740124060; cv=none; b=Y/EWUE0bV8A8rVdEcZ00Fi9LbEIONMHXNTG9NG5HWKqubG4DaFiot7bj4wbch/D/vmtY7zqB0fCcBbvWW896g51nIBBPjaGXISqv0giyXqhlteJvCT9tGteDTXS1Hyu3p9SyEHO5t0vHlivtjMvz4WesDS2ozkM4rNTLCXbbjYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740124060; c=relaxed/simple;
	bh=4AlhnaeVZ+yOEKDYb6v7C/FNKSyc2luOFIKGbjvGa78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gfonLqBpivwA2MT3VD5/SPBmi7qmf9A+IPdNcZndhyMrh5bMP829hqm4CqIzS3ZyQjapyrq5ioKBLafvSCWnyVjVhKvXcNx9VEIk9qKd5u+0iD+Xapf/Xw9ngTYSUpL31fT8yK28V70GMVTyS8EHnQmUD+BL1GymqsVhE0qZqoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b6jU1MOI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P6sLXhG7; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b6jU1MOI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P6sLXhG7"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E8BC5114017E
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 02:47:37 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 21 Feb 2025 02:47:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740124057;
	 x=1740210457; bh=UX/s+fN2z9ix7kU4Cm6GPNtlcCwoBwMRkRoem8L0Fr8=; b=
	b6jU1MOItD28xu16uuzbO+Q+VWhbL28Pnjgrau2IIJftXk4Qp89Y5tLLZqslSGvY
	uOXUKJ64fmIG+GZP9wbIYEazXUEwTVgGKQ+T5H5x4xB4orFJcTn3vLzYw5o45j29
	LsYMdij3uIdjVIGCRo4pbRxpmrqFIsVWybF8KQQszZoeY7kVo5f5kGBnsvyadMsn
	25giFeH59HWQiknwoTiGOEGowAebo12Kd5e2NfOgUTGvHNGa3IV/8Yb0b0GNIfZv
	BQ5fToj1saPF7Q5dq2I4jf/gSyvpXgpjVIi9L5nY6iG9SWk4n7CxyfkHiHx8oqZW
	D68c3Y8xc6VkdSAr48wd0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740124057; x=
	1740210457; bh=UX/s+fN2z9ix7kU4Cm6GPNtlcCwoBwMRkRoem8L0Fr8=; b=P
	6sLXhG7B2tB4p+ZfqgQLnZsvRzPaScWApL9uMeegAbKKUPJZ3Q6EPoc7034HKuiO
	ZMDPuJPK8jipJkg6zTw2Efi9Y7TJWZ7KEMapa6r3/QhkNho7ooPUVkKzo/S0WQZI
	exb6iNxHbYNBvXYswJ5KM8uNfub3sBCn5TC0mvloqKK+LSKNT58E2Vcqzm4kgQ5v
	L3svlUlyfHMeqHPcuMeW8XZ+p4mVFhVqxeQHHqTsnlLdeWWADTudos601Y5wFrZE
	ZCfNyLGSm+CB2bAzTFSzPfz7dvyIaqqPwY38bGDnHFE8B4eUeCussKDDhZbflH1c
	FJ/cnoO0QJzIiZ4e0k4oQ==
X-ME-Sender: <xms:mS-4Z5rsWtd4KEvzOyU4rr6EKZS7OYBvMAhxKzA5QwSr2gweeVqWyQ>
    <xme:mS-4Z7o1N1RiCxozuIogUBREbbsjDxOCcPpyLVgj9h752pAk1m9lQadp00NFNcnpW
    WbPBcp8cLdHpIcGPA>
X-ME-Received: <xmr:mS-4Z2NUn0AB9EuNxot8c8wR4XaOGGs3T3e-3p8kjno04KlMzPNOhxgy4HxkES7JgFtYZK7J9j9aqmLUBQyDczauY8bEfy99x82qvmokN-d2aA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeileegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiud
    ejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mS-4Z05Mz5MQae0IN8g8DJbyYc45cyrnS4hryfN7XcPYTWRLYeDgxQ>
    <xmx:mS-4Z45V_WVYY5eNK7h9fF8t5tw8zjUiMx2vGnwdkswS6jyGhlH5OQ>
    <xmx:mS-4Z8idiYs-MCeEAphwPwfqcygkwc1abcogBL9bLEGaunVVgutLqQ>
    <xmx:mS-4Z65vV2TCpzam2DV4btih31pWXjI4ch6mNw35AjTo8--LkWPcow>
    <xmx:mS-4Z2RTumLScLRpR2gNGQaAR6-2r92K_NmRqdseUpPwvDATylzTgcgB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 21 Feb 2025 02:47:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5d3c612f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 21 Feb 2025 07:47:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 21 Feb 2025 08:47:28 +0100
Subject: [PATCH 3/9] builtin/cat-file: support "blob:none" objects filter
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-pks-cat-file-object-type-filter-v1-3-0852530888e2@pks.im>
References: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
In-Reply-To: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
To: git@vger.kernel.org
Cc: 
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
index 7c1c888079a..c11952d9eca 100644
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
index 723644fbba8..8e5572ba43e 100644
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
index 48840a13561..97533225982 100755
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
+		git -C repo cat-file --batch-check="%(objectname)" --batch-all-objects --objects-filter="$filter" >actual &&
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
2.48.1.683.gf705b3209c.dirty

