Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC8D1F3D46
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 14:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735308005; cv=none; b=SYbXtSds49j1lZ8qmvPJwuTwqrOSlzbT/iecSQ6wsxbmevTtX/3t8iJEqoJdH8Cd9Sps80469JTH/d+Fnkw3oTeKFFQQ8uwLFOh30d62jcpaCnMescTEI9WW0hBPUU2Z1FRpyA/7jAkfQ3OIOtpZrR0I5KozBpuRSDtsdRK/lBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735308005; c=relaxed/simple;
	bh=YDWzGfV5zkk7Hpk9EzhsKEon5ABDfI7fMSB+XZm7C98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pnz4ve/6ljxIAHlEApY5SZaxQRDf55EHeNlBxoo1BUrdCcbNycp9EhR2SBH5dKwNjNIHCk1e78Xz9O1FJzVaNzDcKqVX/UAWm8AujeAVxqGGSVC33YvmYOYoRxrnM7pz+rVnlQcVVWznf4ORL5jHOpPc/ZPvezvSTUXXDH2x1Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OJR9ntVI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DR6Ogyis; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OJR9ntVI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DR6Ogyis"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 16F6611400D9;
	Fri, 27 Dec 2024 09:00:03 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 27 Dec 2024 09:00:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735308002;
	 x=1735394402; bh=m6PUH5hc5VnZEjAw45PgVSbEFwSbOCM6SRruq77T2TY=; b=
	OJR9ntVIw7ExjL9bLf4whA+3DOOe4CoWkQatn2057wixTiwZn+98qk4v9CierS0o
	mrxAtF+BcpHVlBYo5/9gVaZNvywBeo5YYK0GQ2AA0RBX2UNdb2DF0G4x/i6hDaOA
	yZ4zhZmZzgLKUPC4wPPNKoSQLM7Q88QcsNlqPoZ8OLoXCDJtnB1EaIYwcaGV8RJQ
	fJP0FhKzyEmmO59na0W2GsWMt+ipklfOk1WxAUOTy/Zc3JI0iYhpsVKqJgT2eVzk
	aSiw7BDU89WGBhh5JK1D4Dcok4kfdhangEAJka0+g/vC3OjUD+YNgcAYguqNBr/3
	hChO7AE2dn0a27o59BOtzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735308002; x=
	1735394402; bh=m6PUH5hc5VnZEjAw45PgVSbEFwSbOCM6SRruq77T2TY=; b=D
	R6Ogyis6HYJjF5pJ2tyyWT+OQehuwSvuE0AqKdBwgGP7AUrjqCY5Xehy6NQfVHYt
	KRV0p3if8ko5U9a/ZiPq0Lt6dT3lO1Ucgk0pxPZ98+isef22FDNOkMeYeYnp1725
	JFi3KhyO11sUlgRB/eJN0U3zujD0pb2/bSd/3GLsBL7b+01b51qbYf1Uwb2f5HJv
	pHDaaNK26MBQEBkfI7PdPJqjORzo1+HQKFCnzk5v0pC8XbTwXN+dowJpXguf3VpS
	es2odh4juXxn1pAplEd+xGyJYWmd0aLaGY5b7N/rwMalTYpXL86KDzf9emPkyCLI
	ctW0Y48BeaZSWe1n1Kl7Q==
X-ME-Sender: <xms:4rJuZ4ApCbxq3PkBV7U_RWHTG9sxxsGBhx-UhKy0a024OJWpmExiQg>
    <xme:4rJuZ6jHJdVZrc8PGwW5X7TiITgSXc5N3ykYA71aA1h6t5mErG8AeEX8DxNRdIDCJ
    c4CmRhEOF5oS6p4GQ>
X-ME-Received: <xmr:4rJuZ7lKt2jK-Ytn9L_uFjoc9mN1Q6890g_OWweUR6RKwOsGYkydRMU0nUhoPo6B7B2tD88ShMm5n0NmCCI4aDXqUplusWkeFoWmBVDGtts9Rw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeeffeeliedvteehgfduheeuffehieehheejvdehkeel
    gefftdffveeileduieetkeenucffohhmrghinheptghonhhfrdhinhdprhgsrdhinhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhk
    shdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:4rJuZ-xynNit3d3QFJ2a6r1po_ofEO1lEd3wlj5Hl2f4J4Pe_hoePA>
    <xmx:4rJuZ9S6sJ8QmGJpiDQ-WKFjdjruOTecA014G1yQkNJXn_-ExY4Yog>
    <xmx:4rJuZ5agcFqvUHygY8s4NDZltqr02KdTueCJBzRPpdH5KLX6Aa-9fQ>
    <xmx:4rJuZ2S1IEN3naiHjmQjhG9VEMWmzo7oD7DEzm95mtsE0_VhWzdQwQ>
    <xmx:4rJuZ4fOQMMrAhXDyOQwe7pdzFv7Iy4572NozCY0g9O0HqDAlMlXeIGP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 09:00:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5dec6fd0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 13:57:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 27 Dec 2024 14:59:30 +0100
Subject: [PATCH v2 02/12] meson: properly wire up dependencies for our docs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241227-b4-pks-meson-docs-v2-2-f61e63edbfa1@pks.im>
References: <20241227-b4-pks-meson-docs-v2-0-f61e63edbfa1@pks.im>
In-Reply-To: <20241227-b4-pks-meson-docs-v2-0-f61e63edbfa1@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

A couple of Meson documentation targets use `meson.current_source_dir()`
to resolve inputs. This has the downside that it does not automagically
make Meson track these inputs as a dependency. After all, string
arguments really can be anything, even if they happen to match an actual
filesystem path.

Adapt these build targets to instead use inputs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/meson.build | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/Documentation/meson.build b/Documentation/meson.build
index acd6d86ec779e63230c88b7bff937aff330d2d4f..b3c8b6c56339e10099f8c37a4d8198f402192520 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -229,7 +229,7 @@ if docs_backend == 'asciidoc'
       '@INPUT@',
       '@OUTPUT@',
     ],
-    input: meson.current_source_dir() / 'asciidoc.conf.in',
+    input: 'asciidoc.conf.in',
     output: 'asciidoc.conf',
     depends: [git_version_file],
     env: version_gen_environment,
@@ -261,7 +261,7 @@ elif docs_backend == 'asciidoctor'
       '@INPUT@',
       '@OUTPUT@',
     ],
-    input: meson.current_source_dir() / 'asciidoctor-extensions.rb.in',
+    input: 'asciidoctor-extensions.rb.in',
     output: 'asciidoctor-extensions.rb',
     depends: [git_version_file],
     env: version_gen_environment,
@@ -304,10 +304,11 @@ cmd_lists = [
 documentation_deps += custom_target(
   command: [
     perl,
-    meson.current_source_dir() / 'cmd-list.perl',
+    '@INPUT@',
     meson.project_source_root(),
     meson.current_build_dir(),
   ] + cmd_lists,
+  input: 'cmd-list.perl',
   output: cmd_lists
 )
 
@@ -315,7 +316,7 @@ foreach mode : [ 'diff', 'merge' ]
   documentation_deps += custom_target(
     command: [
       shell,
-      meson.current_source_dir() / 'generate-mergetool-list.sh',
+      '@INPUT@',
       '..',
       'diff',
       '@OUTPUT@'
@@ -324,6 +325,7 @@ foreach mode : [ 'diff', 'merge' ]
       'MERGE_TOOLS_DIR=' + meson.project_source_root() / 'mergetools',
       'TOOL_MODE=' + mode,
     ],
+    input: 'generate-mergetool-list.sh',
     output: 'mergetools-' + mode + '.txt',
   )
 endforeach
@@ -335,9 +337,10 @@ foreach manpage, category : manpages
         '--backend=' + asciidoc_docbook,
         '--doctype=manpage',
         '--out-file=@OUTPUT@',
-        meson.current_source_dir() / manpage,
+        '@INPUT@',
       ],
       depends: documentation_deps,
+      input: manpage,
       output: fs.stem(manpage) + '.xml',
     )
 
@@ -345,10 +348,8 @@ foreach manpage, category : manpages
     manpage_target = custom_target(
       command: [
         xmlto,
-        '-m',
-        meson.current_source_dir() / 'manpage-normal.xsl',
-        '-m',
-        meson.current_source_dir() / 'manpage-bold-literal.xsl',
+        '-m', '@INPUT0@',
+        '-m', '@INPUT1@',
         '--stringparam',
         'man.base.url.for.relative.links=' + get_option('prefix') / get_option('mandir'),
         'man',
@@ -356,6 +357,10 @@ foreach manpage, category : manpages
         '-o',
         meson.current_build_dir(),
       ] + xmlto_extra,
+      input: [
+        'manpage-normal.xsl',
+        'manpage-bold-literal.xsl',
+      ],
       output: manpage_path,
       install: true,
       install_dir: get_option('mandir') / 'man' + category.to_string(),
@@ -368,9 +373,10 @@ foreach manpage, category : manpages
         '--backend=' + asciidoc_html,
         '--doctype=manpage',
         '--out-file=@OUTPUT@',
-        meson.current_source_dir() / manpage,
+        '@INPUT@',
       ],
       depends: documentation_deps,
+      input: manpage,
       output: fs.stem(manpage) + '.html',
       install: true,
       install_dir: get_option('datadir') / 'doc/git-doc',

-- 
2.48.0.rc0.311.gb6c66824c1.dirty

