Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC7319B5B8
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 08:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734079749; cv=none; b=AfI2kCxFe6Pxg0PSyhf41XqCXvKjp9k22h+juGfW5Qg93SosjxW8+XDKabZAA4hvMExVaJ8v/CQ3W7LB4VXvVzF+qUM7M+v1ecx/g+4ywOVhg2VnN38uioFu5TPIxX49R+qDY+sJLWPFez0FMy7ezqLOSmd1RDTn+84Om8GOwRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734079749; c=relaxed/simple;
	bh=9PzGLP6uVL1zyQmJ8OpwzkJ1WdYuGzEux+zgt+eUKzo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qCgN/GTLRHbXV462fZpeeRwlFPOxD8bUTZhLGGxAq2mS6kLvDjUz9vmFWrR6PyP0UIXB62Vfz+27gAjU5jDuphHiDRNLExff33+M9acOpDT4OS5Hdcamy5fpdsEHFW7G0Y0rxGOuS0k2gg2HylcCFuFusxUusYIpCh5XzzVSDOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BiVJ/HFf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NJap8FPn; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BiVJ/HFf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NJap8FPn"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CDA9B25401E2
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 03:49:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 13 Dec 2024 03:49:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734079745;
	 x=1734166145; bh=Avww8VDu4sOZ9ILceCGje7QI9GWDpYMgEEsuhx6A2XY=; b=
	BiVJ/HFf/5cFX9MFAJI3ejF6Y1NPqZ7vmQRhmw5eG+skrEM5vCaunIYHjMmH4j1p
	hCzrj1W8hD43ze2yxEAlSDz/GJ9JG7moHQYruNx6xDQJDpvgK41HTjSobOrMdoZ4
	zWA1ZlighIzcBamFloqverx+wFMuJNOlI9PHeXOx9B1vwAJSZbFlA+S18MAN85iR
	Ys4nwiSZ/xrONKvKxH04jWczDBjf6oDVQME2kCkWACqn6vQys2a5utSJhTiZEJy2
	06yNIwfAADGjj2Z6IOdJ1eVMKVs4dhTSaLNlUN0FYgUOizj9QtX36PF0MIspRcnJ
	3p69XbsJKhivXowF7d7paw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734079745; x=
	1734166145; bh=Avww8VDu4sOZ9ILceCGje7QI9GWDpYMgEEsuhx6A2XY=; b=N
	Jap8FPnmL0SMYlcix/NS7zULR6OpLkzT1Ys+1i5LEa3eI0paVeRpeXRGP1ZTRuvu
	OpLCYHbxRZvLALgL/H3XW3F0bp8ev9ZW+YAV6OEyODQA+t1QAXUVLBezk3iys6yU
	K9GUmmdEP1vWS5PihlWRNHRGL2mHogivE5SxQsoNxvzi5GHPbdXC66rx2zFAanT9
	H/YWW+C27uTOpvPp312DC5TcpEoy7r6rlxj2HH4/m/i5EZrBy9ha52dUhG+c9QUt
	7Ezl+1oi1F46jczV1b94GhVWI1qNwR5rT+O3ui0nv6KZdsOm7M3aJCSL/eGVd6UB
	CGPR2t6arioowOYMW5L6A==
X-ME-Sender: <xms:AfVbZ6sX_F1neH6Ro-cI0EIozhqLtsJ8eVyaxYrUojz6aLyr4QzcmQ>
    <xme:AfVbZ_fRM-UX3ogGvPRI9zgla0x07nYVOwOP3jF-BOpRlhZy0yMnYHYGEtsODniny
    eYkzgWAeixwk5UGbQ>
X-ME-Received: <xmr:AfVbZ1yoyN7O9Amsczzs8z59_xrG_lq2pcgtvUZTxFWQS0OKWRhM2qjUJ4466WcPIIe7cXWdfIt-q8V4fu6sLXiFKfmoEbHj72vobBKHyyr7JFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeigdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgovfgvgihtqfhnlhihqd
    dqteefjeefqddtgeculdehtddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeer
    tdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesph
    hkshdrihhmqeenucggtffrrghtthgvrhhnpeeffeeliedvteehgfduheeuffehieehheej
    vdehkeelgefftdffveeileduieetkeenucffohhmrghinheptghonhhfrdhinhdprhgsrd
    hinhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehp
    shesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:AfVbZ1PDZWSikjn3tOcinZNPJ6PZ6_S-2C4kgJuTa325kzDRwygX6w>
    <xmx:AfVbZ6-AmHP75aqVGz6COlAeQZetqmRJ-7dsxhci-2R5H9b1IgP9og>
    <xmx:AfVbZ9Wgxh8y3G2UvLOQXpUe3MldHzWgmD7YZj8zlAlzFRrgeijeIA>
    <xmx:AfVbZzdqC2n5llfg52HMz8gj5d8GXCja77c2qJdoO3hOoEgFSvhq9g>
    <xmx:AfVbZwnGxAhIK5_LmLtGK04GOU5SCmxGPZ7ev50haJM_ndJvGKGJ3heX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 13 Dec 2024 03:49:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 81891169 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 13 Dec 2024 08:47:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 13 Dec 2024 09:48:31 +0100
Subject: [PATCH 02/10] meson: properly wire up dependencies for our docs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-b4-pks-meson-docs-v1-2-0c7895952cd3@pks.im>
References: <20241213-b4-pks-meson-docs-v1-0-0c7895952cd3@pks.im>
In-Reply-To: <20241213-b4-pks-meson-docs-v1-0-0c7895952cd3@pks.im>
To: git@vger.kernel.org
Cc: 
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
index d62b0846d3f8ebc412f5fa9f775f037a3656093a..d23ed82795026e511379ff1e77355d2ec33ec499 100644
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
   )
@@ -260,7 +260,7 @@ elif docs_backend == 'asciidoctor'
       '@INPUT@',
       '@OUTPUT@',
     ],
-    input: meson.current_source_dir() / 'asciidoctor-extensions.rb.in',
+    input: 'asciidoctor-extensions.rb.in',
     output: 'asciidoctor-extensions.rb',
     depends: [git_version_file],
   )
@@ -302,10 +302,11 @@ cmd_lists = [
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
 
@@ -313,7 +314,7 @@ foreach mode : [ 'diff', 'merge' ]
   documentation_deps += custom_target(
     command: [
       shell,
-      meson.current_source_dir() / 'generate-mergetool-list.sh',
+      '@INPUT@',
       '..',
       'diff',
       '@OUTPUT@'
@@ -322,6 +323,7 @@ foreach mode : [ 'diff', 'merge' ]
       'MERGE_TOOLS_DIR=' + meson.project_source_root() / 'mergetools',
       'TOOL_MODE=' + mode,
     ],
+    input: 'generate-mergetool-list.sh',
     output: 'mergetools-' + mode + '.txt',
   )
 endforeach
@@ -333,9 +335,10 @@ foreach manpage, category : manpages
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
 
@@ -343,10 +346,8 @@ foreach manpage, category : manpages
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
@@ -354,6 +355,10 @@ foreach manpage, category : manpages
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
@@ -366,9 +371,10 @@ foreach manpage, category : manpages
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
2.47.1.668.gf74b3f243a.dirty

