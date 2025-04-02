Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDE723957C
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 11:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743592432; cv=none; b=O01Im43/Oko/cedR5m1e6WWs1LIakn/A28qjXi4+NzzQCS8J4brDZONYJCcebVtcgDOAaQvdbM4Js347Q1D11rLVQO2sgD4RVeZU9QBV6SL0bnD1Wqyq0sk5rCkMlwUN5caKqETMpEQzpSdnMqMybf7Oocdx6LgbftGzI736hgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743592432; c=relaxed/simple;
	bh=FOHW73+2ZLwXvdHblAoMa1el2GJB1t8DVBlyF2wq8BU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=khPqwECBCm9ozViqkXH+xi3Sgsx+H9nMc5BrkxSk6somnUa/Czt7CiSg18cpHFa7XykiWzj7cjxgNjsmTBIIyiz/nvc6fMqbMi/SdPj2WxpJ3fG7GwlHEJLPcLX34bdN11zb7matIFa8jH354qLsBoN76I6WAxCc/WZeXD2pi1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HkxjeIgO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uu0bCg15; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HkxjeIgO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uu0bCg15"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 62BE0254005F;
	Wed,  2 Apr 2025 07:13:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 02 Apr 2025 07:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743592430;
	 x=1743678830; bh=aAvYdq2FOZEO2lT4TrzOvrYGdC7O7x9cU1a3SlgxyDs=; b=
	HkxjeIgOR8pg4eJf6ayct1D3axLofuzZWMescTZZF66Oc5a+c5Nbv2T7VY2phltC
	5fQXbDerSGj9UnaLRHt36CA4mPTtZxXaJWNgmyu1FCmypxXuLKfvKRvIC5gsSoKc
	laE43F6aByuXZDLP13WGThwU4AlPi8NzUcFDS7AqtA9jTEe+BIymP7Qmu4ugWsy+
	oZgdGusJxNpMCQRcr2PrKnrWElD1AeHWuIJn2nWIa+Npd+ncF8etnzrHBWGMmHGt
	xQNRNXovN8u3S8yPttGq6NGE0yOQg1mXPbkLbe64WEMZqsuOIJ/8i5a03r9M2Ht4
	fup+db3cmlu1XwK7roevVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743592430; x=
	1743678830; bh=aAvYdq2FOZEO2lT4TrzOvrYGdC7O7x9cU1a3SlgxyDs=; b=u
	u0bCg15940HHUhxEWCOv3GKeOe1ZBRdmNytnhXT6u60jlndtipm93EWrQcwJW3pC
	Up86x66/hc37yzqthYykCb8YnxrQQruYv6kf7eUKwtBwMjFJUAtP0hL8VeTyRrrX
	j9ASdndrQh3XZjKCfT/Z1pXjMVVsdTymkljcjjkTg2t5SdZVuaY9zCMyrQ5b0zQA
	dWIGFM1B3MmtIs2M0eVPOJrszoHqWVJWV9mgWC4j6jrEOitabJzaATXoRlpl94X0
	i2MxliV1l3BmxwSmHyAk5u33xG1dgDm7SiblJAmV++qyP+mgbheAG0DcTE+plU1p
	InRGToZ9AAoY5Z5wisaFw==
X-ME-Sender: <xms:7hvtZ3cBvMeKl2PqAZySmR0roxLUtdiW7EdODpTh3iLosjq1P8Y39Q>
    <xme:7hvtZ9OlB8hOEGDtMMtADWnVwhrd0I5idG0K3nwmpvo6L4CLijGQfH3zS-0qloMbZ
    Fb1TnLuzBsW8RiZeA>
X-ME-Received: <xmr:7hvtZwiFIdqd3OBxl_IE_Q1R9Frj8_kF69YHenBjfcg9ToMed2Hxnei9Y_rD2CEXuHDQu7dGE5dIUNPjtUB32-9eKaUuK5_mLjiTeYNfgylltA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtph
    htthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:7hvtZ49ADtYbrPRhcwuioLyz1qbb0UXBkG3j-Cd5Lv8CqfxT_FEWiQ>
    <xmx:7hvtZzu7KbQUrJ5nFMnv_v4NKXHR4T6Ma7WAGq5A8g4mmP4m_jrIfQ>
    <xmx:7hvtZ3FWRnn_a3xm3ZNZ6TGdvckgkHrO2m5z-TzKCtpePXgHSl60aQ>
    <xmx:7hvtZ6PlZfWSSiV5PYR7znm2QAdEG4Tez8WWm2MEn0hzFzDgwj-I7Q>
    <xmx:7hvtZ5Ryy5oytBY_-1svmEI2AyZSEGedzcFgBCxrnjPI-oN9Ddbv7ufT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 07:13:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 40ff3657 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Apr 2025 11:13:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 02 Apr 2025 13:13:41 +0200
Subject: [PATCH v3 06/11] builtin/cat-file: support "object:type=" objects
 filter
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250402-pks-cat-file-object-type-filter-v3-6-4da6bb21871c@pks.im>
References: <20250402-pks-cat-file-object-type-filter-v3-0-4da6bb21871c@pks.im>
In-Reply-To: <20250402-pks-cat-file-object-type-filter-v3-0-4da6bb21871c@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Implement support for the "object:type=" filter in git-cat-file(1),
which causes us to omit all objects that don't match the provided object
type.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-cat-file.adoc |  3 +++
 builtin/cat-file.c              | 12 +++++++++++-
 t/t1006-cat-file.sh             |  6 +++++-
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
index 48e05e1af52..74d71c3282e 100644
--- a/Documentation/git-cat-file.adoc
+++ b/Documentation/git-cat-file.adoc
@@ -96,6 +96,9 @@ The form '--filter=blob:limit=<n>[kmg]' omits blobs of size at least n
 bytes or units.  n may be zero.  The suffixes k, m, and g can be used to name
 units in KiB, MiB, or GiB.  For example, 'blob:limit=1k' is the same as
 'blob:limit=1024'.
++
+The form '--filter=object:type=(tag|commit|tree|blob)' omits all objects which
+are not of the requested type.
 
 --path=<path>::
 	For use with `--textconv` or `--filters`, to allow specifying an object
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 629c6cddcb2..0f17175a549 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -484,7 +484,8 @@ static void batch_object_write(const char *obj_name,
 
 		if (use_mailmap ||
 		    opt->objects_filter.choice == LOFC_BLOB_NONE ||
-		    opt->objects_filter.choice == LOFC_BLOB_LIMIT)
+		    opt->objects_filter.choice == LOFC_BLOB_LIMIT ||
+		    opt->objects_filter.choice == LOFC_OBJECT_TYPE)
 			data->info.typep = &data->type;
 		if (opt->objects_filter.choice == LOFC_BLOB_LIMIT)
 			data->info.sizep = &data->size;
@@ -521,6 +522,14 @@ static void batch_object_write(const char *obj_name,
 				return;
 			}
 			break;
+		case LOFC_OBJECT_TYPE:
+			if (data->type != opt->objects_filter.object_type) {
+				if (!opt->all_objects)
+					report_object_status(opt, obj_name,
+							     &data->oid, "excluded");
+				return;
+			}
+			break;
 		default:
 			BUG("unsupported objects filter");
 		}
@@ -1062,6 +1071,7 @@ int cmd_cat_file(int argc,
 		break;
 	case LOFC_BLOB_NONE:
 	case LOFC_BLOB_LIMIT:
+	case LOFC_OBJECT_TYPE:
 		if (!batch.enabled)
 			usage(_("objects filter only supported in batch mode"));
 		break;
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 4f14840b71a..98638fa2b9c 100755
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
@@ -1447,5 +1447,9 @@ test_objects_filter "blob:limit=1"
 test_objects_filter "blob:limit=500"
 test_objects_filter "blob:limit=1000"
 test_objects_filter "blob:limit=1k"
+test_objects_filter "object:type=blob"
+test_objects_filter "object:type=commit"
+test_objects_filter "object:type=tag"
+test_objects_filter "object:type=tree"
 
 test_done

-- 
2.49.0.604.gff1f9ca942.dirty

