Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082B520CCD9
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 09:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743068652; cv=none; b=og286NGJ40po1jmUlLA0UMukJRu6cFCqWV+hTUPVmtaz3kjLqslnCK76IM7O0HS4As6rQIckKxa47TJ8XujFU/J0LehhBmnfoFT3p13MsAed4bKHcZsLFkldlshxcZddaSM3TG9N+qrIPRcpizkv+UOb5e1yZeU76JPvCcf/eyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743068652; c=relaxed/simple;
	bh=wEg0eEXhH6xlSVsDCmXxBLCHLeb27nviHNFtgJ26haU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SncXTt2z30HOHRpV9wrh+ZrQiyADGe2r1Y4oAh6z+CItnElGuKYTFgQILda7aaxHk9+oOX5lUSvBbKhRfqlAlH6CQyXSHe1ZBPMLkJQqx3HOVA1jr9bwqq0ZhoxL3T6bzch9ABHg00brSgRIPLqHdpU+YlsWqKbMf7XwT/rn6uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kVLVTTxH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ba1H9bsm; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kVLVTTxH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ba1H9bsm"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 1225E1383844;
	Thu, 27 Mar 2025 05:44:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 27 Mar 2025 05:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743068650;
	 x=1743155050; bh=mK0qHGFuOa3GJ+rF+VuvqtDgdAWCWtw1b2YAyxNgnIQ=; b=
	kVLVTTxHpwqQxoUcLNYqHEafyJ5GEtsTbU5XSfQ9+wgOr8P+zx60CUubx1VkXheM
	TFWLyWNHpIolv3ktzghz/Rv5+iOsgwFZmSZWPMs5y2fNWCm1mnCIty+GLOy8zHEk
	HHQa2AJm6KWm7bzQ7DogtlRX97FXD/NVAk7soes91bEl1cIZd7Tzneu3zw66YpSN
	tjjOx21o+L+IYivIs4DgeJRqHrNf/HJAEhwGkm/q3PI/uwomSOotT/RES/anT70X
	3y4lOE7krBTYiu3FFM2LjFX/HihIB7RVYlkwkazp/M14HDAjMC/wynCTDNqHtCAN
	w+/ZmznOtw499L6SddG6Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743068650; x=
	1743155050; bh=mK0qHGFuOa3GJ+rF+VuvqtDgdAWCWtw1b2YAyxNgnIQ=; b=b
	a1H9bsmiGv+pXijfk7xD6IHp5/N/2sCS4hJkLbXceaLJH1isfwTkf5Bef8aQUL5P
	2YaVjjVeqklidOOYZqyfOfmn3WbzwKdVsMYwYTWg+gLAzc+NFnxSi471WATsKbH4
	8Sdbr+Sw+QCze2qCxHPvOWr+qFjtk17Sr0AzHYrQMThn9m0Zb7cn92SNf5f0aX3N
	yRfYmuvJPu3Azg2WAedk0u/tJaTxSTGu4SdLsi6vnB1qdMrfVwfHMk3J63IDeXaT
	70GTle1NyQMG4XCcQEKHXQGiY0MDLreKZrH2HwKi7RKgoYGtN2/fdg3hSiwkewZo
	J50W7QOXDWdRH/B4x2Yrw==
X-ME-Sender: <xms:6R3lZ1_B9P_zJlmD-JC5lJ8ZYkR-Hf53x0JbF3lEsfbNx63Taa5OpA>
    <xme:6R3lZ5vLe85W_umZlI1hsTHfFW4sWagBQCOE5y5cZ3ijnPJHy0KAIpVR437m0wWc4
    8UV8HVgtCCDu2Ef9A>
X-ME-Received: <xmr:6R3lZzBL5zePMWXbElOI0ynbDm1Ni4ZSZt3wrIWSUoTND-fPwHuXl1HsjPXeOb5uAIa-pKu8HqmbTwnElE01ug-63bC0jrdHNUzjWsJZHGWMFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieektdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtoh
    hmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:6R3lZ5ePK9CRJsZQnuweWT-yZ6ZH4-X4HGrXz4Lew3__IcLOvFKdAA>
    <xmx:6R3lZ6ORBVNmeqqSVOUsd1_XvHAt51aFt7RDWTDyFX3b1Cdc6l_8RQ>
    <xmx:6R3lZ7kQYncMetNxS2-OmhkjSy0iSBl5MOdZk9CrF-0u2eWbYerBCQ>
    <xmx:6R3lZ0vm8Doys4avniB-yzXPxkgZy4yiettM3luahrfus68OB1fgvQ>
    <xmx:6h3lZx2doKdaFtXXguv8r8LBpxkcsgP3XSiP2yajHAk4sbQxNpOLBL2P>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 05:44:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d7becf3f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Mar 2025 09:44:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 27 Mar 2025 10:43:59 +0100
Subject: [PATCH v2 04/10] builtin/cat-file: support "blob:limit=" objects
 filter
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-pks-cat-file-object-type-filter-v2-4-4bbc7085d7c5@pks.im>
References: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
In-Reply-To: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Implement support for the "blob:limit=" filter in git-cat-file(1), which
causes us to omit all blobs that are bigger than a certain size.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-cat-file.adoc |  5 +++++
 builtin/cat-file.c              | 11 ++++++++++-
 t/t1006-cat-file.sh             | 18 +++++++++++++++---
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
index bb32f715944..62bfb00f4b1 100644
--- a/Documentation/git-cat-file.adoc
+++ b/Documentation/git-cat-file.adoc
@@ -88,6 +88,11 @@ OPTIONS
 	one of the following:
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
index e783dbbad58..55755a461bc 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -473,8 +473,11 @@ static void batch_object_write(const char *obj_name,
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
@@ -497,6 +500,11 @@ static void batch_object_write(const char *obj_name,
 			if (data->type == OBJ_BLOB)
 				return;
 			break;
+		case LOFC_BLOB_LIMIT:
+			if (data->type == OBJ_BLOB &&
+			    data->size >= opt->objects_filter.blob_limit_value)
+				return;
+			break;
 		default:
 			BUG("unsupported objects filter");
 		}
@@ -1038,6 +1046,7 @@ int cmd_cat_file(int argc,
 	case LOFC_DISABLED:
 		break;
 	case LOFC_BLOB_NONE:
+	case LOFC_BLOB_LIMIT:
 		if (!batch.enabled)
 			usage(_("objects filter only supported in batch mode"));
 		break;
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index d00073f8add..1a0931bd2ca 100755
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
@@ -1413,5 +1421,9 @@ test_objects_filter () {
 }
 
 test_objects_filter "blob:none"
+test_objects_filter "blob:limit=1"
+test_objects_filter "blob:limit=500"
+test_objects_filter "blob:limit=1000"
+test_objects_filter "blob:limit=1g"
 
 test_done

-- 
2.49.0.472.ge94155a9ec.dirty

