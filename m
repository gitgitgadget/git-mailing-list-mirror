Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC2D1E9B0B
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738248258; cv=none; b=Mt1j5h2RmFtIF7FrxdLIONKGV/xnipJq4lAr9xxdn64y7fECcVixeIKW8obEHKtyuJqGWVssw/ZhGMenJ01PbPTG9+QFNWP6kHYGpVLpvUnampUXE5gwmepbq3LpRxu/++3zKx5yzFDWHt+qllhB/GEm0Wa13+/7kaT/+gkwTlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738248258; c=relaxed/simple;
	bh=BSkPnIoFw6ehQUPpYWw95PwkT6YTfEQb2O/7/haaPvk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VWoU29WSGEVzrrrzh4ag16pUIhT7MzZAQf46Icp+IUKLKUY0wXqNacR01EWIarXf4e+a99H4UXvS0c2fxX8MwfWRGL7X7kxOXKk77EL7zTqyIkFfiHH5FQGYgZgksWbtKH9Z6DWVbvrElck0FQrJypw2zWMfCKB4uz2WvDLS+QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pgZWYBwe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b9mQGTDe; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pgZWYBwe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b9mQGTDe"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EC3EE11400D8;
	Thu, 30 Jan 2025 09:44:14 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 30 Jan 2025 09:44:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738248254;
	 x=1738334654; bh=ZoVpkMShCU2vSnWl+A7LejxUGyG44PTNhIvSSjLikE0=; b=
	pgZWYBweYPtuwC3CDN0OINM7eXRZTHz/f/9avnIfJx77yroffyn7JEiT/Ycd8Oc/
	dItYPY4BW09F/NDNQYaYQcEyVJn63Bbx8wYwho0FsELbHKd3F4i2gHDmIKGSluuo
	ULLnef+2eF848QoIg1cvqaYIgTDVaIxA1banzkbXqTFaTgbsrYI7TeYLrUsnmmTb
	xy0Cfr2xBBmKzbYZV+DjgC8qdEFDaNmOuv8kuZJCspPcusnkn95lKSibzqOwIU0d
	I7DFByTC1UZ3+CaXsF370/zormqydX0H9nQawwTiaks1lRY8ONYFuSQhnaE0oyWe
	R+ayU+rmMwVLFxmWTbsbNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738248254; x=
	1738334654; bh=ZoVpkMShCU2vSnWl+A7LejxUGyG44PTNhIvSSjLikE0=; b=b
	9mQGTDeOUL2X/T0wqfiVtPqiuV4azGhEieQB3ImlkGZLFfHMNiYrwB7/mIdLyqdr
	l0SpqPeT5Xs9ofawZ13ckrVszD/6zYBLqNl4DetLpB4QwohSBvpbvFmO+XR4xcUe
	Fe3+bd78l6SznVRXVYDeLWwsM4xKtIjbZPRiy1htw2cVnjBeh0pIGvPqSNpSm9Vx
	wNKxIjdBnXVTSoT3jaZla0yIELm4KINL9WKUdWEaNgNVY6TUZeJBQtg4XdA1jjo1
	cUlXLZfZL7dobHWRGdFgnV9vArCmgaNXk0/m2FcAb8lsFcZOXKbovJl0sc386r8I
	RaapOX8eZSNqx2tT19caA==
X-ME-Sender: <xms:PpCbZ7bxErO--pXCJP8LWudYxZgWtfZSwEqNAPzvjuZYC3ZcMGodzw>
    <xme:PpCbZ6aK-DM20meLGVHHgFV6se_M7P2y1HgmBH7Vm92icsbecVsEW2QvQBFJLl_WZ
    94NuqP7te1ObS4pMA>
X-ME-Received: <xmr:PpCbZ9-EzCl_9Uot307jKkxCiMkoySYBa8dM_Y45Uxh4cYqSlFZK5l31Ip6_xe8Rjea5EejsAHoplr12PRL1zuH6eMyKRSAj7NzEqRgIVuId>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:PpCbZxpZ7K9pLcms82c03rjPHRSRdzjWrkAfKCbMAwHZWmMDMKtCdg>
    <xmx:PpCbZ2oQ6ysoevyB65EwuIqEDOAwLAn5nsIeSZe9T-PA7Lrti0M49A>
    <xmx:PpCbZ3TVc3KUcsP2QB4-3LiuqUlNx_Ovb848WbY2M_JhtyeNXK7iaQ>
    <xmx:PpCbZ-qrpZ7OXkvRGWt4L6GkcKhov7t7VNAMggmSGOoUL7pU_yYMRA>
    <xmx:PpCbZ90AnJqTnlJSJyBAimkNke2Qvy6BvaTRBPyws4TLQxe8l1CzgNa4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 09:44:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 41787da0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Jan 2025 14:44:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 30 Jan 2025 15:43:57 +0100
Subject: [PATCH v2 05/13] meson: introduce `libgit_curl` dependency
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250130-b4-pks-meson-improvements-v2-5-2f05581ffb44@pks.im>
References: <20250130-b4-pks-meson-improvements-v2-0-2f05581ffb44@pks.im>
In-Reply-To: <20250130-b4-pks-meson-improvements-v2-0-2f05581ffb44@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

We've got a set of common source files that we use for those executables
that link against libcurl. The setup is somewhat repetitive though.
Simplify it by declaring a `libgit_curl` dependency that bundles all of
it together.

Note that we don't include curl itself as a dependency. This is because
we already pull it in transitively via the libgit dependency, which is
unfortunate because libgit itself shouldn't actually link against curl
in the first place. This will get fixed in the next commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/meson.build b/meson.build
index c7d597eda8..820008f6de 100644
--- a/meson.build
+++ b/meson.build
@@ -1658,30 +1658,32 @@ bin_wrappers += executable('scalar',
 )
 
 if get_option('curl').enabled()
-  curl_sources = [
-    'http.c',
-    'http-walker.c',
-  ]
-
-  git_remote_http = executable('git-remote-http',
-    sources: curl_sources + 'remote-curl.c',
+  libgit_curl = declare_dependency(
+    sources: [
+      'http.c',
+      'http-walker.c',
+    ],
     dependencies: [libgit_commonmain],
+  )
+
+  test_dependencies += executable('git-remote-http',
+    sources: 'remote-curl.c',
+    dependencies: [libgit_curl],
     install: true,
     install_dir: get_option('libexecdir') / 'git-core',
   )
-  test_dependencies += git_remote_http
 
   test_dependencies += executable('git-http-fetch',
-    sources: curl_sources + 'http-fetch.c',
-    dependencies: [libgit_commonmain],
+    sources: 'http-fetch.c',
+    dependencies: [libgit_curl],
     install: true,
     install_dir: get_option('libexecdir') / 'git-core',
   )
 
   if expat.found()
     test_dependencies += executable('git-http-push',
-      sources: curl_sources + 'http-push.c',
-      dependencies: [libgit_commonmain],
+      sources: 'http-push.c',
+      dependencies: [libgit_curl],
       install: true,
       install_dir: get_option('libexecdir') / 'git-core',
     )
@@ -1689,8 +1691,8 @@ if get_option('curl').enabled()
 
   foreach alias : [ 'git-remote-https', 'git-remote-ftp', 'git-remote-ftps' ]
     test_dependencies += executable(alias,
-      objects: git_remote_http.extract_all_objects(recursive: false),
-      dependencies: [libgit],
+      sources: 'remote-curl.c',
+      dependencies: [libgit_curl],
     )
 
     install_symlink(alias + executable_suffix,
@@ -1700,14 +1702,9 @@ if get_option('curl').enabled()
   endforeach
 endif
 
-imap_send_sources = ['imap-send.c']
-if use_curl_for_imap_send
-  imap_send_sources += curl_sources
-endif
-
 test_dependencies += executable('git-imap-send',
-  sources: imap_send_sources,
-  dependencies: [libgit_commonmain],
+  sources: 'imap-send.c',
+  dependencies: [ use_curl_for_imap_send ? libgit_curl : libgit_commonmain ],
   install: true,
   install_dir: get_option('libexecdir') / 'git-core',
 )

-- 
2.48.1.468.gbf5f394be8.dirty

