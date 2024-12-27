Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA301F4E33
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735308010; cv=none; b=Qo8A86QUNj1OIVnvYdBpmR6bii94IuqYx+xIYxEWcGyYyx79So1h7TeQHtoOgqc2Z/arpwATcayzfUg5os6xajffZzAY+KW34geU1IpgDMFvxRdb5XAzWSOYB+MglfkIMwbh/IfMv+uvwgFYrhVmw3gbd0ITXMcN5E/NPgIoYVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735308010; c=relaxed/simple;
	bh=zOd5jXNRzQ19wQYT18g6HeoYGZDffEfQA2JtOamqBFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tqVebu7DpY5qlAyrGui3Alb79+zjVKLLM4yg0Gbcy3v5E9w+DggiE5+TFYDXM4nOFPBJUk7+RDVvljvDl7WMd4ImFgZDNCBzwrho0xJNesOnVDtLx2pD6OxbCvhbhxO1kbNBaPLcwbfkdUhcPWR7soum9xMVg3GI8eGA17KIf4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ogcLW9Xp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cURVMxsk; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ogcLW9Xp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cURVMxsk"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 952362540181;
	Fri, 27 Dec 2024 09:00:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 27 Dec 2024 09:00:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735308008;
	 x=1735394408; bh=lAOOcmSFvyccUhlaF6nhWCaRod8ZSqSjvKYAMi68YcI=; b=
	ogcLW9XpVfjTZ/r54QtcsVAXLEwZLffSIghgCfVp3/tEkcHo0ozvegHbHDyjLOiL
	1HBqtJ3vEUu+0FaMcRcePOoA0waR/wFp91wTiftyNkVfmm/EjZ638Ur//1MnNBL0
	yq4zE0tDrUwip68e7Okr5XHBFakc9k59SAng+C6QnM4unuiQNBJMDF8tOpKwaBWw
	svf58pM/DRn6n7GsRKdN0eapOB8BcdehyOIDstgsTw5yOJQs26YcN8e2ZkgWkoxU
	6VjXlhUK7rqUrtfzOtsrggkAZwfyXbiCzK6AU6fMmhQT0utU8PwpOTZdRAwsHEjD
	/fx6JbgHnYw4Z8xKmShsXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735308008; x=
	1735394408; bh=lAOOcmSFvyccUhlaF6nhWCaRod8ZSqSjvKYAMi68YcI=; b=c
	URVMxsknbOJrdAsZ04OkX4tdCOTwYnc4w03t1/Uk+lZ1RyLOsUrUpKEO+uskXa+G
	cuYA0mVbk/puA8hri7AQLZLRjf5QeIfFuB4VHofBgM/bwB5kS8sQ9u6VhzK/RSBd
	zjMsu9B4NDTiQc0hTe9pSxbVYf6Y4o+nehOjRrX+m40A0Q/QEcoKevWp0RG0IA+C
	OjW7GH5VDbxpqx1BdXS4aWUviyjfOMdrXnvpPMZrz6msjYutv1kEe91zQgwpFip4
	gam3V6VFKdZoN7FYTg/XK/rH05nLSQgBKvQN/KhtW4SupljApotBUrnI7VD5Y/u8
	3CJZxs0NoiATfS1w1vOLg==
X-ME-Sender: <xms:6LJuZwi2GY7AdexOZl-E3fx4xjO9UVyTUi0JAuioNvgj92pj0CD46A>
    <xme:6LJuZ5DN06ELqBymJTEHRj3F9gZo9KPfXqjVIpKbGt3U1rBj_KgjYXZcfXnUBzbz9
    DWaLU2Rv78ekJx_yw>
X-ME-Received: <xmr:6LJuZ4E-_om4ABr6LGLWIcCJU0XLmkfm6tY9aXOHHfnVzM1RE68POWtvyvcFTZi7gvkvYZ5oJygbCp98DqbfH_7IbcPggnMPcCf7ydPomHvxoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6LJuZxTvN-9bqIvMDgN74iPMDJOCSee6poaR2CijODzDZowxeiZtyw>
    <xmx:6LJuZ9yHUBZdXbZlF_4gygBM3ELeJWYKHJhDX0NxOHQ-RP50YWE-KA>
    <xmx:6LJuZ_4cEGIFD318CbFYxQ7di52s1EmRkw0s0cwejKhlmoXd6blm3A>
    <xmx:6LJuZ6wdrqvwsbPzA7CxdNV27JS3sfwCLP_aa3eGC_4vN_7vWAw9GA>
    <xmx:6LJuZ480WugXxUhvQZGg5W9fGIcQ1KC-4YyFzi3hKISrYsM2zriY0WuI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 09:00:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 70a0140b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 13:57:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 27 Dec 2024 14:59:34 +0100
Subject: [PATCH v2 06/12] meson: generate user manual
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241227-b4-pks-meson-docs-v2-6-f61e63edbfa1@pks.im>
References: <20241227-b4-pks-meson-docs-v2-0-f61e63edbfa1@pks.im>
In-Reply-To: <20241227-b4-pks-meson-docs-v2-0-f61e63edbfa1@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

Our documentation contains a user manual that gives people a short
introduction to Git. Our Makefile knows to generate the manual into
three different formats: an HTML page, a PDF and an info page. The Meson
build instructions don't yet generate any of these.

While wiring up all these formats I hit a couple of road blocks with how
we generate our info pages. Even though I eventually resolved these, it
made me question whether anybody actually uses info pages in the first
place. Checking through a couple of downstream consumers I couldn't find
a single user of either the info pages nor of our PDF manual in Arch
Linux, Debian, Fedora, Ubuntu, FreeBSD or OpenBSDFedora. So it's rather
safe to assume that there aren't really any users out there, and thus
the added complexity does not seem worth it.

Wire up support for building the user manual in HTML format and
conciously skip over the other two formats. This is basically a form of
silent deprecation: if people out there use the other two formats they
will eventually complain about them missing in Meson, which means we can
wire them up at a later point. If they don't we can phase out these
formats eventually.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/meson.build | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/meson.build b/Documentation/meson.build
index 48583e9a7f4b037de218358f16f59ce08141cbe8..404cb20d10a2fbbe4e014bd8a7df74c49dad40a7 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -382,3 +382,35 @@ foreach manpage, category : manpages
     )
   endif
 endforeach
+
+if get_option('docs').contains('html')
+  xsltproc = find_program('xsltproc')
+
+  user_manual_xml = custom_target(
+    command: asciidoc_common_options + [
+      '--backend=' + asciidoc_docbook,
+      '--doctype=book',
+      '--out-file=@OUTPUT@',
+      '@INPUT@',
+    ],
+    input: 'user-manual.txt',
+    output: 'user-manual.xml',
+    depends: documentation_deps,
+  )
+
+  custom_target(
+    command: [
+      xsltproc,
+      '--xinclude',
+      '--stringparam', 'html.stylesheet', 'docbook-xsl.css',
+      '--param', 'generate.consistent.ids', '1',
+      '--output', '@OUTPUT@',
+      '@INPUT@',
+      user_manual_xml,
+    ],
+    input: 'docbook.xsl',
+    output: 'user-manual.html',
+    install: true,
+    install_dir: get_option('datadir') / 'doc/git-doc',
+  )
+endif

-- 
2.48.0.rc0.311.gb6c66824c1.dirty

