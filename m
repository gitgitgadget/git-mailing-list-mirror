Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8829720CCEA
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 09:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743068653; cv=none; b=YyysLlpAF2jtXL4QiAp+QtwCVO4HNCRXGtKB9QlMrqBH62NnasRGaIrvo78M1oNJCqaMWSFx3nXMptY+CRVj9e9fMaOoghkK/EdpUmXhjtUwBnLVw5+wsheshAulYrKSyXf7aCH2SmBCqU/VPfBkH3QcL6BCRGW78ZyWBdHEqVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743068653; c=relaxed/simple;
	bh=GGpRyf2rHVoMGrIXKQ/P10wQlPCpxJg302aWWp2VQEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tfils46oSiyV5hqMjUyXUNS7YzA7CJT1qxhtehhKCBOFiEG9kTMx/ZJfYwnzN9bM+3S1MJJJACpABtopkGTj9gDt3hSQwfDI80CLwJcyRLMQ1qbAv1Z+7BlUD1V8aZUXNBbQ4vmCKvtRdyIwXuXO/qWOA2DcE4fLKmjDRdtKAk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iFdEKmim; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mb0omeDp; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iFdEKmim";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mb0omeDp"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id A2F5813838C3;
	Thu, 27 Mar 2025 05:44:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 27 Mar 2025 05:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743068650;
	 x=1743155050; bh=aOnJpoz7OXfzZg00KVh0bzuJUVsalnBt8K80Tf9p9l4=; b=
	iFdEKmim0DrffEEOhgyB8jhLvQpc414IpN2n3Pjf/3smsmzW1BVdQ4fzXWfssbvQ
	3IQVsI9KvYDAyw9lXRAoYHtzJfVcJlm5Azc9Vx6T9AsAY06nk/UIKAY6LggNwMum
	kJvB+T4FuTtf6kvdXCTKJImA0fhLljgLocGALGGKsD/d6Qg/cVDu8/PkkRd60Ezu
	ouH5tPk/U7/NoKac6oidHQVkJW8d8ln430ypclMPdP01KZ70e37pwrPT+HxFyujL
	YfNtRCtfQjiEvXLmS2c33cLAQ1SysovWnGmtRKdmvkvu1855LGojp6fZ3Y/WNPHk
	yJXYvBqy1bb+qjyvcJ2Izw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743068650; x=
	1743155050; bh=aOnJpoz7OXfzZg00KVh0bzuJUVsalnBt8K80Tf9p9l4=; b=m
	b0omeDp+VYlMDxrf+8Gn9vi7EIXL5NC+XQSkuE/+ZHbVbBUfkwSZT+nSk9RrSrDd
	+U1XogErrLynqfIKlBoWIzvCcRGjM0OEP452igvRFMR3A6FiRh4Nl/6zc6fefJ68
	os7TN9AMSRZH9keseFvs0Mi4UrOQ89WFf2DzJrEOM/r6mmZvFzMnQjmAE8B81RzE
	HLNd+5FY9ymX9xY9O+yJVCiDPzo2cn70QCJtOO8YdOkqk68AoXxD7sT78yLRVY9i
	O0VuonVKB+XwtEneYzZRgFrae4xJBJoK5PjrbVXS2eiwVjy+p6vlZY83MhakK2GC
	iziDPOLOlfdFRv7mAnnwg==
X-ME-Sender: <xms:6h3lZ1TuLlVKGRXgzowhMm_MbVuA1FSny6y1mJ3B73kQ39eqG-1hQA>
    <xme:6h3lZ-wNgUQ2lTiGPUKVBTT_2QIAZrSgeubQt9vI8U4dR02dAJpRT480VZFnmpihx
    HnFqZyQyPP6AdmeaA>
X-ME-Received: <xmr:6h3lZ61NZZIK2fsYPgEGWa2Rycj-jme8dDcALyq9nCIMO87XWfF2LudZ-eim7Na8dDQ79dsx-CixR-gWlOM3xEPModukXjJ3RILSkPMOq3hZzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieektdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehtohhonhes
    ihhothgtlhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6h3lZ9DsSj8O1-BeKmyD_6VXNN-_aXTAsl46Ll3yRSXNUyrV0wJCqA>
    <xmx:6h3lZ-h4rS922f2ry1vBzI7LEjtgabkNLwBbeHj7vkR20dQD46vHeg>
    <xmx:6h3lZxqHQ07E7j8ezcqJc7yIHRXKS7Xgi-f1W3zpQI8rlUnU1YZ_-Q>
    <xmx:6h3lZ5hzt4gEMPwacI_NuP3UtRD0els6Fbmis8xqAMcb1CbfBlVH8g>
    <xmx:6h3lZwbF10T7KvZ5C8XdWfweBxiLr2b6p3LiUxPJGDgpmP3x4xF2KP3v>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 05:44:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f56b1c42 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Mar 2025 09:44:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 27 Mar 2025 10:44:00 +0100
Subject: [PATCH v2 05/10] builtin/cat-file: support "object:type=" objects
 filter
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-pks-cat-file-object-type-filter-v2-5-4bbc7085d7c5@pks.im>
References: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
In-Reply-To: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Implement support for the "object:type=" filter in git-cat-file(1),
which causes us to omit all objects that don't match the provided object
type.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-cat-file.adoc | 3 +++
 builtin/cat-file.c              | 8 +++++++-
 t/t1006-cat-file.sh             | 6 +++++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
index 62bfb00f4b1..9931840567b 100644
--- a/Documentation/git-cat-file.adoc
+++ b/Documentation/git-cat-file.adoc
@@ -93,6 +93,9 @@ The form '--filter=blob:limit=<n>[kmg]' omits blobs of size at least n
 bytes or units.  n may be zero.  The suffixes k, m, and g can be used to name
 units in KiB, MiB, or GiB.  For example, 'blob:limit=1k' is the same as
 'blob:limit=1024'.
++
+The form '--filter=object:type=(tag|commit|tree|blob)' omits all objects which
+are not of the requested type.
 
 --path=<path>::
 	For use with `--textconv` or `--filters`, to allow specifying an object
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 55755a461bc..430320adfe9 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -474,7 +474,8 @@ static void batch_object_write(const char *obj_name,
 
 		if (use_mailmap ||
 		    opt->objects_filter.choice == LOFC_BLOB_NONE ||
-		    opt->objects_filter.choice == LOFC_BLOB_LIMIT)
+		    opt->objects_filter.choice == LOFC_BLOB_LIMIT ||
+		    opt->objects_filter.choice == LOFC_OBJECT_TYPE)
 			data->info.typep = &data->type;
 		if (opt->objects_filter.choice == LOFC_BLOB_LIMIT)
 			data->info.sizep = &data->size;
@@ -505,6 +506,10 @@ static void batch_object_write(const char *obj_name,
 			    data->size >= opt->objects_filter.blob_limit_value)
 				return;
 			break;
+		case LOFC_OBJECT_TYPE:
+			if (data->type != opt->objects_filter.object_type)
+				return;
+			break;
 		default:
 			BUG("unsupported objects filter");
 		}
@@ -1047,6 +1052,7 @@ int cmd_cat_file(int argc,
 		break;
 	case LOFC_BLOB_NONE:
 	case LOFC_BLOB_LIMIT:
+	case LOFC_OBJECT_TYPE:
 		if (!batch.enabled)
 			usage(_("objects filter only supported in batch mode"));
 		break;
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 1a0931bd2ca..9edd3d0c048 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -1388,7 +1388,7 @@ test_expect_success 'objects filter with unknown option' '
 	test_cmp expect err
 '
 
-for option in object:type=tag sparse:oid=1234 tree:1 sparse:path=x
+for option in sparse:oid=1234 tree:1 sparse:path=x
 do
 	test_expect_success "objects filter with unsupported option $option" '
 		case "$option" in
@@ -1425,5 +1425,9 @@ test_objects_filter "blob:limit=1"
 test_objects_filter "blob:limit=500"
 test_objects_filter "blob:limit=1000"
 test_objects_filter "blob:limit=1g"
+test_objects_filter "object:type=blob"
+test_objects_filter "object:type=commit"
+test_objects_filter "object:type=tag"
+test_objects_filter "object:type=tree"
 
 test_done

-- 
2.49.0.472.ge94155a9ec.dirty

