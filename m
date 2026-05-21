Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6685F36167B
	for <git@vger.kernel.org>; Thu, 21 May 2026 08:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779351764; cv=none; b=AQmEO3thLYLShu3NLytbmYxDVoJDmN9CVQZyTBHFlfFDcP/eoKtSa4BGXSxqpR0SxXtqak1Tlz3jAFPRQhI1iCz/+7gmisr4RxrN6dn5yj7WvztTJ3hR+kVZeFepu7JyBdJUVG7XIXc0xhinn2xW0W0aWMSL2fyhS5mthTN1uy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779351764; c=relaxed/simple;
	bh=N57oXcxtlbH6y8wQF0ULW62huLiLJQIT2Ap+hXXbO+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aO7dVmMzO4N2aGEsqLGtoxu5SDzNjPBceBI0hcpIwn/nlFNBqaVvJDFTQBTTwYhh6HQQZwQLVAobhnGbKsxBK+sGaazjOs+0kgauG5o7DxGt3g+848kyzlSvx8aJF81GNdrX6nWfTQuky1n2DkFWs0oczdkLNrcZWIsEBwsufY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Lt8vMm1S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VEDxusV9; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Lt8vMm1S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VEDxusV9"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 59FBCEC0038
	for <git@vger.kernel.org>; Thu, 21 May 2026 04:22:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 21 May 2026 04:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779351761;
	 x=1779438161; bh=NNkIPsxZ7IT6TjSCwtLVkb0UXkVBhbs0DpQv4V3JGCI=; b=
	Lt8vMm1SPqOc1VT986Z/EIGXnf7JWxktm/QsrAIYZuW5EqfKxS3njH1ki66z/5VW
	PcVNHvHYUkQXdDWskeXKD7iXw2FYcHJ8PARUafF7R60oxMZ2BDDiPVZx23aOkPMi
	kRY6PYawjXnBOSGs1E0FqBDHOuxwmno3EFuEgC4AmW3jIIpBebqHoJJL5bADCmNg
	ryqkJwBZ69diBLPgX+wwFrgy9dLPa2v7phhK9D+V1f3UBCvXpizWqNAywu6XJUVc
	eFwyFJmmDwh8l14vbWHLOlpWfgPIbt8yMGzeLkJO8i45jyNcbs03r+3vUSVhQQ4q
	2wg1npC2xN9Lc4FuHqri7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779351761; x=
	1779438161; bh=NNkIPsxZ7IT6TjSCwtLVkb0UXkVBhbs0DpQv4V3JGCI=; b=V
	EDxusV9sWCZ9XPS6Zz+OmeBTRmolPYTE27aKUOGd+prA84Rs7N2KVvWU0Z987iWF
	5XKb9A+4RQlFzR1Ylm88ZsZTOaYLPPplWy65k7WIGtzO/wh+fzsPk9yCX8WQr6py
	vxI6WAcIcRVGdXY/osf5Cw22Kbz0AFJ1FPE+TXVLq27JYDET6Jdwj+Nd0rNDwxRJ
	I+ddOuhM0Gel5fE7iR1AIxlRVn8zcPLaF8Z54gjBZbLr6CUlfRdC/tZYUXAXAFAM
	XMQiCcRmFoNfN6oluqHCh/AS3StycrgHXqL96jK/N5rTDfUhLJG/QxDF4SLDvSXm
	L69MthUXhwtW9759vNRGw==
X-ME-Sender: <xms:0cAOauR6J88lXKV6d5qhW8n7NFXmVW_IZa36f3gzcvcFytIKY91hwQ>
    <xme:0cAOaqs_CFWH42xjTfO3ox_xbXkbv1L8KIKAqmquT9PCIsfF7vjk8rR-DUK49dosY
    5--GDoZXDgBgsRPqHur00143VGCu73n3rGI859j45GdMps3UumXVw>
X-ME-Received: <xmr:0cAOahcpfRWCEwwTRemQ6AVYegrbwW9z6SAxOpJobNOAQBrJLGRQ8Uk74-RYy8VbUep6rUvw9vx6otjrdF6HP66UIC5mpg22YaDpkMZ39P0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:0cAOavKp3tQAC2rKlOFEuHyoVEpukfDZesLSEGlfDlt0T9LM8i5sVA>
    <xmx:0cAOana9utd0y6CKVSJhDzmFA8O98WHHwl7CMz5qagveHP37r_1b_w>
    <xmx:0cAOaiucLV-FP-TQMZrNAivn0TnEBRAstZfn4dYg_NsrA7pyhoxKpw>
    <xmx:0cAOasspXdGTklTPD8rALWAAesyq8oj0WQqcIe7Yji8QSwGcQhS2YA>
    <xmx:0cAOauRZee1K2PVR2-XwSKonDXpkXyA-KJBV7iYAagHx9o5VbO3EhfYT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 21 May 2026 04:22:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id eebeb159 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 21 May 2026 08:22:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 May 2026 10:22:24 +0200
Subject: [PATCH 04/18] odb/source-loose: wire up `reprepare()` callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-b4-pks-odb-source-loose-v1-4-6553b399be2d@pks.im>
References: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
In-Reply-To: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Move `odb_source_loose_reprepare()` from "object-file.c" into
"odb/source-loose.c" and wire it up as the `reprepare()` callback of the
loose source.

While at it, make `odb_source_loose_clear_cache()` static, as it is no
longer needed outside of its file.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c      | 6 ------
 object-file.h      | 3 ---
 odb/source-files.c | 2 +-
 odb/source-loose.c | 9 ++++++++-
 odb/source-loose.h | 2 --
 5 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/object-file.c b/object-file.c
index 977d959d33..0f4f1e7bdc 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2041,12 +2041,6 @@ static struct oidtree *odb_source_loose_cache(struct odb_source *source,
 	return files->loose->cache;
 }
 
-void odb_source_loose_reprepare(struct odb_source *source)
-{
-	struct odb_source_files *files = odb_source_files_downcast(source);
-	odb_source_loose_clear_cache(files->loose);
-}
-
 static int check_stream_oid(git_zstream *stream,
 			    const char *hdr,
 			    unsigned long size,
diff --git a/object-file.h b/object-file.h
index 02c9680980..420a0fff2e 100644
--- a/object-file.h
+++ b/object-file.h
@@ -21,9 +21,6 @@ struct object_info;
 struct odb_read_stream;
 struct odb_source;
 
-/* Reprepare the loose source by emptying the loose object cache. */
-void odb_source_loose_reprepare(struct odb_source *source);
-
 int odb_source_loose_read_object_info(struct odb_source *source,
 				      const struct object_id *oid,
 				      struct object_info *oi,
diff --git a/odb/source-files.c b/odb/source-files.c
index ccc637311b..10832e81e4 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -42,7 +42,7 @@ static void odb_source_files_close(struct odb_source *source)
 static void odb_source_files_reprepare(struct odb_source *source)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
-	odb_source_loose_reprepare(&files->base);
+	odb_source_reprepare(&files->loose->base);
 	packfile_store_reprepare(files->packed);
 }
 
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 92e18f5adb..e0fe0d513d 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -7,7 +7,7 @@
 #include "odb/source-loose.h"
 #include "oidtree.h"
 
-void odb_source_loose_clear_cache(struct odb_source_loose *loose)
+static void odb_source_loose_clear_cache(struct odb_source_loose *loose)
 {
 	oidtree_clear(loose->cache);
 	FREE_AND_NULL(loose->cache);
@@ -15,6 +15,12 @@ void odb_source_loose_clear_cache(struct odb_source_loose *loose)
 	       sizeof(loose->subdir_seen));
 }
 
+static void odb_source_loose_reprepare(struct odb_source *source)
+{
+	struct odb_source_loose *loose = odb_source_loose_downcast(source);
+	odb_source_loose_clear_cache(loose);
+}
+
 static void odb_source_loose_reparent(const char *name UNUSED,
 				      const char *old_cwd,
 				      const char *new_cwd,
@@ -47,6 +53,7 @@ struct odb_source_loose *odb_source_loose_new(struct odb_source_files *files)
 	loose->files = files;
 
 	loose->base.free = odb_source_loose_free;
+	loose->base.reprepare = odb_source_loose_reprepare;
 
 	if (!is_absolute_path(loose->base.path))
 		chdir_notify_register(NULL, odb_source_loose_reparent, loose);
diff --git a/odb/source-loose.h b/odb/source-loose.h
index 441da9e418..825e703072 100644
--- a/odb/source-loose.h
+++ b/odb/source-loose.h
@@ -44,6 +44,4 @@ static inline struct odb_source_loose *odb_source_loose_downcast(struct odb_sour
 	return container_of(source, struct odb_source_loose, base);
 }
 
-void odb_source_loose_clear_cache(struct odb_source_loose *loose);
-
 #endif

-- 
2.54.0.926.g75ba10bac6.dirty

