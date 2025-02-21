Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60D41FDE04
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 07:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740124061; cv=none; b=qBpMVubxPX2EqFvXEZXAh9UnZ3mMFf1c109kVhThYz8W5ToS7ugU4go7QlzGA1jeRduOjG9ZihzVtGXvkuWvixjDQvZESN0T5pyfuB/EQVjxO1IluGQMmTITCWI8xCR65yL2LRX7Tg5Eqlo2pKL2k/uDq6rMkc7i0lijYiZAHqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740124061; c=relaxed/simple;
	bh=Pa93WXVYY4CkupYsrG7kr9TMwjZQ3Vq6vZ8BXIAbwYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nUvXAZZhpLxs4l+qvEIiQRwTV93OfWf0iSnK5crdIAH9+6ynID9vCZcBPdyEC38aNlpTOCZpytJqxbC/ykuM8rWKvB4fV8bh8lOcrIY/9teA06Yp/AxCElvo13Owz/xxzeYoeLF081t7Ccd7HJXX6HV5dKOvkjeTmP8diLxuWuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PVZZaPZH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=miwdQLyM; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PVZZaPZH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="miwdQLyM"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id C2D621140181
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 02:47:38 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 21 Feb 2025 02:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740124058;
	 x=1740210458; bh=dOu8Ye2MpwNrcTN5mRrTU1PEsBEOvjj2b2jtKZClRRI=; b=
	PVZZaPZH+FgcrAwp8jJnrxWdX1KwdF4NptFzxOrH7TjCxlYHK/plINsjg2v77ug7
	1IdDEJ/3//6ATrbbxuiZ+nSuZSdedfwUfJhx04f7Plw6TXLcuqBe1deIdodOL88s
	dXAZrS59EILRBWNHDIQZMnEEyu8V3xIlNoaeJ8D82SGkOeafC92vxN80xagaYryt
	bwC2oOVT5ATgbCF2snPouxdjuP4YWSIpddmUlMwqfDqvwYdqaXKQFrGGb8SvGJrn
	puT7MAqAYTjW8Aew1mx+rcUiQ8z7ABOw3jW7qJKbJJ7zg0SHDO6KxwXCtVNBSqsU
	Yx2am7Aolg/VoKkV4XyALw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740124058; x=
	1740210458; bh=dOu8Ye2MpwNrcTN5mRrTU1PEsBEOvjj2b2jtKZClRRI=; b=m
	iwdQLyMXkgwvXhDuz0oPW0z2i+I+KuAEyE8+154Ql48u+QLg6aPC7KM4aK2PqYXA
	Ex2wXL49PkLOlsVTHfWXSXg2U6lDq6DpCytkYgv4KlMSKPB/xSzSgfz1ZLgb/Qx9
	zNJOOSDLVs5zDemQmxnNUSm41Nh1LmsF7OHGmj0dJtZfJxOmDXTWSSBIq2sctFRX
	zlgGReED1KHz+cN0/WJmzOY5AYjgdh0Vof03YugqwFXLKcsLGOJkmLAkVQQvIH8P
	C2+s25D/Yg9of4EIkiuDbtr+seViorS8OomxJgWteL5EAxDcJSJ7hRkbmERefY+f
	2F1I40cCh9/uOld+g+GOg==
X-ME-Sender: <xms:mi-4Z61b22iLq3DAvjXzQBrwyoH7oLebibBRW_XIrTcdaw6yHF4nGA>
    <xme:mi-4Z9GSNYv3-VP5pZt9AARDwP0tWsP9x0anbU8SlBw2sBRocJnTA9L9Z_jt3-iLe
    7cX0mWiZ9IlfwHeeA>
X-ME-Received: <xmr:mi-4Zy6hw_VMaROTEhaMN3hj5LYl-gCTl5HnfL4AcxbCHqlLX3oKSMFUIwRsdCGmo0_XMkfWf7utseuCfQWl_DrvKOjGuOEWnkH6rjxURtzLwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeileegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiud
    ejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mi-4Z71gZiaV1RNODWrliJIxZuFwywQovkrOlRFdPKQ_s91Eqq1mNQ>
    <xmx:mi-4Z9HCAKVL9h6vkOLNu4hsPjBnHQXnrjm3EjcB9GnAHPu1FDUGyQ>
    <xmx:mi-4Z09V7Ueqg2XjhzNosv97ekqnXHH4wniI6xMtYBMI3PqpzPwG1g>
    <xmx:mi-4ZyneI3TlV5jBvYv9F399CNSocIQKzH2YZBfE-JN5HgAS8wOPbA>
    <xmx:mi-4Z7Pm7wKOGf8hM60dzLkVOCBz_Ajes3bgPjgVlYrjlZhdbyb6kHwk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 21 Feb 2025 02:47:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6db65258 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 21 Feb 2025 07:47:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 21 Feb 2025 08:47:29 +0100
Subject: [PATCH 4/9] builtin/cat-file: support "blob:limit=" objects filter
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-pks-cat-file-object-type-filter-v1-4-0852530888e2@pks.im>
References: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
In-Reply-To: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
To: git@vger.kernel.org
Cc: 
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
index c11952d9eca..8c474418b52 100644
--- a/Documentation/git-cat-file.adoc
+++ b/Documentation/git-cat-file.adoc
@@ -88,6 +88,11 @@ OPTIONS
 	one of the following:
 +
 The form '--filter=blob:none' omits all blobs.
++
+The form '--filter=blob:limit=<n>[kmg]' omits blobs of size at least n
+bytes or units.  n may be zero.  The suffixes k, m, and g can be used
+to name units in KiB, MiB, or GiB.  For example, 'blob:limit=1k'
+is the same as 'blob:limit=1024'.
 
 --path=<path>::
 	For use with `--textconv` or `--filters`, to allow specifying an object
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 8e5572ba43e..f57bf65cb03 100644
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
index 97533225982..86c53e01b2f 100755
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
2.48.1.683.gf705b3209c.dirty

