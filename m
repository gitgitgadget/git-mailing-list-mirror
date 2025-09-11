Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5580F2E9EA4
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 09:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757582183; cv=none; b=h18Rj0Wd06jWFWcUMSI3hP7K3J5CdF0Iudop6cAMpl8lWQro/V03meVTgwg57TAw9hWBcqA3T8kIN+XS9IhkQC3BgIBmQbf/df4abYtQnHkdg05638QANHRwvcJVJERaki85u+RXsQENz9qtIkgGBMATSUpctim5IPidA1vfSJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757582183; c=relaxed/simple;
	bh=TspVTl2MeCmc4oRZDNhCAo1zo5IsxEM2U/4TWQBxkMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lyuUmRwv9eoc0tVDggohQZ32g8TMvhGjfm2I3sp5677NO0pxb3ifhzfBwWooI7bIG8ffxXZEcrAxlsgHC74wV7q+atA5KP/IUw18hKUxLnbM/WoeynWNDt872nvIypspexUwQVC/5lkKJT8beExRD/s2chDBlumVgwq2bxloYHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZjyCzo9Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fKSzwig3; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZjyCzo9Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fKSzwig3"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 4F1FE1D000ED;
	Thu, 11 Sep 2025 05:16:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 11 Sep 2025 05:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757582180;
	 x=1757668580; bh=e8Ygwvew7/BmmpujPsMMAg2NAUIqnAq2I/7WhHBadGc=; b=
	ZjyCzo9Q/eg1E19UTCA/ln/o6w4nj0jBP7VZKBxM3fQ2xfu8rCy/TggOxJTl3VQd
	QoHYuBUB0/Izq4M0jz1Nn7IdcxOBgehOPm5gOWWAgqJij4ZqCFgD9fYYY9J16pLr
	kCZrjaeoe8UVLuH5TTVrXthJZZ8rg+mXz4dsCBj7SNRF2p9EKj2dLVafXHXuCiIx
	EFQMMQ2ewTiARtX1niKStuJqRi+VsutYXJ3aYq80gHyzav4XgP7zELXGr81NZrnR
	rtzt+DDWn82PSbfBP1oBSEOILeMZ8HVbS86acUwyhd+t9Jh5e1VtsLRs9oZwjJ3/
	v+7LPwfLGnXIjSQhGOuOxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757582180; x=
	1757668580; bh=e8Ygwvew7/BmmpujPsMMAg2NAUIqnAq2I/7WhHBadGc=; b=f
	KSzwig3IkaSQpI/XNMIQzbY6P7R9KhIImkxpbuWVCIONb3cc3NWCMDOoBPmbXtIT
	QtR3faAwqmcbVTPlZDim7VI+PcwuiGo6NGwaUsJqkJZ4PWqtc2unsOmZQKZS2jwH
	b2/Gf9hfsEz7+JbOwv4YTfVCcW6Ppkl64rJgOXeMSDG2ClQ/YxHw10rugKvkiAZq
	zLB2Q6D6hH54f7M9517IIHwDBkLVbzhvRHU8WRDiSRbyv4MTxrC1WqIUsZ6CY2KK
	REieisTG8cgKm0Eho/FEssmNPYMRjkEJRPUKq5/JY3TjH+66gQnlO0/m0HbrHM2r
	Wb5dCVs0l6y09mgYiht4A==
X-ME-Sender: <xms:ZJPCaNjcxRAL5Mxb0lTXHc4hn1md9i3lOrGh9NAnFQZUSSTwr3wfWQ>
    <xme:ZJPCaCMOEgSIkXvdZi6Kj8nKFZZDx2DI0KUoBdkK9cp5pSeDND7AMy9lT8Aru8azq
    re45ZUKadPmFFu6BQ>
X-ME-Received: <xmr:ZJPCaO6_gX6Gao_aBH9G_VuXoes3EBO7DoJwfTc3sTo8pZynFnLe76oW2WBsgbNu5YKrYmqE7Yz2FVL5hWa87Hl0SgLVlok_riBkMIX6-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ZJPCaA0K3axrXz_bsO4cvGSrRHPvjTkra9rOL9OBI3MLMiLDJaj1eQ>
    <xmx:ZJPCaPbguFgMQHGzzheE0lc_sV-9zDB0IT3wJ9sxZIqjOO29RfWA-g>
    <xmx:ZJPCaIB_MXN6lpyNBt8aennX4qxCzW8b_KQpFdYbNde1C94Kjm0g6A>
    <xmx:ZJPCaB9BcsDzVAJsTuQF-EeuSduI_mYWLYwQnw6x91-Y85ek60mL8Q>
    <xmx:ZJPCaCx37j4M3NVqxhL7x3e0WWvdYKo7OiFVF-mFL0haTi23T3sZtQEw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Sep 2025 05:16:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 681f245a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 11 Sep 2025 09:16:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 11 Sep 2025 11:16:06 +0200
Subject: [PATCH 1/3] meson: introduce a "docs" alias to compile
 documentation only
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-b4-pks-meson-docs-target-v1-1-a92c666ecef9@pks.im>
References: <20250911-b4-pks-meson-docs-target-v1-0-a92c666ecef9@pks.im>
In-Reply-To: <20250911-b4-pks-meson-docs-target-v1-0-a92c666ecef9@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.14.2

Meson does not currently provide a target to compile documentation,
only. Instead, users needs to compile the whole project, which may be
way more than they really intend to do.

Introduce a new "docs" alias to plug this gap. This alias can be invoked
e.g. with `meson compile docs`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/howto/meson.build     | 4 ++--
 Documentation/meson.build           | 8 ++++----
 Documentation/technical/meson.build | 4 ++--
 contrib/contacts/meson.build        | 4 ++--
 contrib/subtree/meson.build         | 4 ++--
 meson.build                         | 7 +++++++
 6 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/Documentation/howto/meson.build b/Documentation/howto/meson.build
index 81000028c0..ece20244af 100644
--- a/Documentation/howto/meson.build
+++ b/Documentation/howto/meson.build
@@ -29,7 +29,7 @@ howto_index = custom_target(
   output: 'howto-index.adoc',
 )
 
-custom_target(
+doc_targets += custom_target(
   command: asciidoc_html_options,
   input: howto_index,
   output: 'howto-index.html',
@@ -51,7 +51,7 @@ foreach howto : howto_sources
     capture: true,
   )
 
-  custom_target(
+  doc_targets += custom_target(
     command: asciidoc_html_options,
     input: howto_stripped,
     output: fs.stem(howto_stripped.full_path()) + '.html',
diff --git a/Documentation/meson.build b/Documentation/meson.build
index e34965c5b0..44f94cdb7b 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -377,7 +377,7 @@ foreach manpage, category : manpages
       output: fs.stem(manpage) + '.xml',
     )
 
-    custom_target(
+    doc_targets += custom_target(
       command: [
         xmlto,
         '-m', '@INPUT0@',
@@ -400,7 +400,7 @@ foreach manpage, category : manpages
   endif
 
   if get_option('docs').contains('html')
-    custom_target(
+    doc_targets += custom_target(
       command: asciidoc_common_options + [
         '--backend=' + asciidoc_html,
         '--doctype=manpage',
@@ -452,7 +452,7 @@ if get_option('docs').contains('html')
     depends: documentation_deps,
   )
 
-  custom_target(
+  doc_targets += custom_target(
     command: [
       xsltproc,
       '--xinclude',
@@ -481,7 +481,7 @@ if get_option('docs').contains('html')
   ]
 
   foreach article : articles
-    custom_target(
+    doc_targets += custom_target(
       command: asciidoc_common_options + [
         '--backend=' + asciidoc_html,
         '--out-file=@OUTPUT@',
diff --git a/Documentation/technical/meson.build b/Documentation/technical/meson.build
index a13aafcfbb..858af811a7 100644
--- a/Documentation/technical/meson.build
+++ b/Documentation/technical/meson.build
@@ -46,7 +46,7 @@ api_index = custom_target(
   output: 'api-index.adoc',
 )
 
-custom_target(
+doc_targets += custom_target(
   command: asciidoc_html_options,
   input: api_index,
   output: 'api-index.html',
@@ -56,7 +56,7 @@ custom_target(
 )
 
 foreach article : api_docs + articles
-  custom_target(
+  doc_targets += custom_target(
     command: asciidoc_html_options,
     input: article,
     output: fs.stem(article) + '.html',
diff --git a/contrib/contacts/meson.build b/contrib/contacts/meson.build
index 73d82dfe52..c8fdb35ed9 100644
--- a/contrib/contacts/meson.build
+++ b/contrib/contacts/meson.build
@@ -20,7 +20,7 @@ if get_option('docs').contains('man')
     output: 'git-contacts.xml',
   )
 
-  custom_target(
+  doc_targets += custom_target(
     command: [
       xmlto,
       '-m', '@INPUT@',
@@ -39,7 +39,7 @@ if get_option('docs').contains('man')
 endif
 
 if get_option('docs').contains('html')
-  custom_target(
+  doc_targets += custom_target(
     command: asciidoc_common_options + [
       '--backend=' + asciidoc_html,
       '--doctype=manpage',
diff --git a/contrib/subtree/meson.build b/contrib/subtree/meson.build
index 98dd8e0c8e..46cdbcc30c 100644
--- a/contrib/subtree/meson.build
+++ b/contrib/subtree/meson.build
@@ -38,7 +38,7 @@ if get_option('docs').contains('man')
     output: 'git-subtree.xml',
   )
 
-  custom_target(
+  doc_targets += custom_target(
     command: [
       xmlto,
       '-m', '@INPUT@',
@@ -57,7 +57,7 @@ if get_option('docs').contains('man')
 endif
 
 if get_option('docs').contains('html')
-  custom_target(
+  doc_targets += custom_target(
     command: asciidoc_common_options + [
       '--backend=' + asciidoc_html,
       '--doctype=manpage',
diff --git a/meson.build b/meson.build
index b3dfcc0497..40b2a2dc54 100644
--- a/meson.build
+++ b/meson.build
@@ -2101,11 +2101,18 @@ endif
 
 subdir('bin-wrappers')
 if get_option('docs') != []
+  doc_targets = []
   subdir('Documentation')
 endif
 
 subdir('contrib')
 
+# Note that the target is intentionally configured after including the
+# 'contrib' directory, as some tool there also have their own manpages.
+if get_option('docs') != []
+  alias_target('docs', doc_targets)
+endif
+
 exclude_from_check_headers = [
   'compat/',
   'unicode-width.h',

-- 
2.51.0.450.g87641ccf93.dirty

