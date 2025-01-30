Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C691EE017
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 14:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738248263; cv=none; b=oGklmbFsiP+pzs7W7Oa8BGj1A95nX5cAx10/8qYKLXRXD3eQu9/8Ltbfx3Nh75dTnOIqEzvJCb/OG8+/YSyWHh2y2QhrzLIldKbE3hRNn56W/lN3BYn5mQtK0h6oGKsyY1F7fhi5u3QyCf5PbLR37Osfpa7i1TM4JUe0DWxlLh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738248263; c=relaxed/simple;
	bh=vbL2dEi9vlBVe6jJ1DPUFh7hbF8qjYobTxrDVrLmk/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i7uAI1bDsUfsIGhj1uNlDnv1gP1tQNHHaEB/LzVeProR+DXQopVsa80Zcz3xF5acpoZr345A8gG2BWr+hrYCw2qfeyAEzfzFv1nc7wdr/+Mzo/ntdNr5JQvgP0jWQxZZzPcPFCMk1+nLNtkU/tpH5EG12s8Ul1ey9yxKJzW/Xp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cnpIzgY7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZrJRDEn+; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cnpIzgY7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZrJRDEn+"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 1CCF11380137;
	Thu, 30 Jan 2025 09:44:21 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 30 Jan 2025 09:44:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738248261;
	 x=1738334661; bh=mgrMs1Uaa+C9N+mTCMn4h+oL04i6sUPJMFx5j2e29rE=; b=
	cnpIzgY7TUUNQ90uregKBVootdLYWstg9uaDe21isf+BLwVyHVTt4uIFxq5lfGey
	CzDHH+R85BD73ZpuTPPhzFCdnLWVRpzsvMTbbz/wp5xE6KSlqjTajdB2LOoKbj8P
	wmreJPad1m2ttZJN4wqhhW8nJ0AWLDAH1W8V8f2EpUMKm0BM3YzWV8nnF4EgjYTw
	qE6+9UL+GtSALxKMdY1GLMzf6NqccURMvOOHLF1dCM3Z17nZhDq7GNGBgy0d1SHI
	x83iAV7/QcZy15F6fEWVD8pQ2OZxH+J2cFaHEN43NaK6CJxhCkNUeSkibRXLPLHj
	nxHouESa//5yxnTbD+O65Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738248261; x=
	1738334661; bh=mgrMs1Uaa+C9N+mTCMn4h+oL04i6sUPJMFx5j2e29rE=; b=Z
	rJRDEn+xc8b9Ltf6G0OCRMpHZvUVJBp7fkDJEwL9ekykmZLB6AE+1jAtKgkZ1XkX
	YvjSRzTQvzi1PvEmg8xLbPu0izKRF1r4FKpKcqOV1HxO8wAlp6qDM+XBDVBRW4sh
	LCHCQEpj6nNOi/oDUhdQneSYr2vrqki1t95as3JyAUdVvGpG8PDAqQYxc4jVSUxL
	ts6azifi2z+M/A7MJGmMfMZwng/ox/w1ZoAEH2r6/S3UMfb4VWki/YybHwSi9ip8
	OOT40pOV4QVyqzzUCOp6h0E2ZJAxeGAJnZZT2yoArPzQUKIGJ0g+eX+1i0ueeaT/
	gjVNTamlPcYOaaDC3nR6w==
X-ME-Sender: <xms:RJCbZ3bB1tke3lWfVSOosRSs6mEmAGwBsXFizCis1hELEt3HFaHokA>
    <xme:RJCbZ2Z__qb55BOoQmIB-vWOG6QbRw4y3xVjGJwhN0DZLCppQM_YrH6UUpo-dcsqa
    I2s-KFWN5-Uiff1LQ>
X-ME-Received: <xmr:RJCbZ586Op503pEB0AtG900__h7Hi9fyumTsOTK8hiqkBGsND0oESJcWHDkSsuAzd8MDb5ntt0kC77HgaxsQlkK4CTc5ixHsTJ8mkMKwezlC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:RJCbZ9o77eDOpstHYLgrQs__fNnfNnNQv5vKu2RXDMFCm8GoSaEVxA>
    <xmx:RZCbZyocBF5QlHe75LRa7yByn2rz7ihkYsPNyKIMm4HMKGxo9G_LhQ>
    <xmx:RZCbZzRWrJzicFhmgu4LuBqRJwjqoaItiCxxIw671c0vfC8SA_lyaA>
    <xmx:RZCbZ6r9YI08e42GS9onvtUM118XJuCU84dn3JWlJjWCVmV3QM8XgA>
    <xmx:RZCbZ53E4pD-0UX_BM82mLpNsAZO7t2BRlAuLeU8sNrZ1szKS4nb10KS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 09:44:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5c0c10e0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Jan 2025 14:44:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 30 Jan 2025 15:44:04 +0100
Subject: [PATCH v2 12/13] meson: consistently use custom program paths to
 resolve programs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250130-b4-pks-meson-improvements-v2-12-2f05581ffb44@pks.im>
References: <20250130-b4-pks-meson-improvements-v2-0-2f05581ffb44@pks.im>
In-Reply-To: <20250130-b4-pks-meson-improvements-v2-0-2f05581ffb44@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

The calls to `find_program()` in our documentation don't use our custom
program path. This variable gets populated on Windows with the location
of Git for Windows so that we can use it to provide our build tools.
Consequently, we may not be able to find all necessary binaries on
Windows.

Adapt the calls to use the program path to fix this. While at it, drop
`required: true` arguments, which are the default anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/meson.build | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/meson.build b/Documentation/meson.build
index 6438fa6792..c6117366ff 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -206,9 +206,9 @@ manpages = {
 
 docs_backend = get_option('docs_backend')
 if docs_backend == 'auto'
-  if find_program('asciidoc', required: false).found()
+  if find_program('asciidoc', dirs: program_path, required: false).found()
     docs_backend = 'asciidoc'
-  elif find_program('asciidoctor', required: false).found()
+  elif find_program('asciidoctor', dirs: program_path, required: false).found()
     docs_backend = 'asciidoctor'
   else
     error('Neither asciidoc nor asciidoctor were found.')
@@ -216,7 +216,7 @@ if docs_backend == 'auto'
 endif
 
 if docs_backend == 'asciidoc'
-  asciidoc = find_program('asciidoc', required: true)
+  asciidoc = find_program('asciidoc', dirs: program_path)
   asciidoc_html = 'xhtml11'
   asciidoc_docbook = 'docbook'
   xmlto_extra = [ ]
@@ -245,7 +245,7 @@ if docs_backend == 'asciidoc'
     asciidoc_conf,
   ]
 elif docs_backend == 'asciidoctor'
-  asciidoctor = find_program('asciidoctor', required: true)
+  asciidoctor = find_program('asciidoctor', dirs: program_path)
   asciidoc_html = 'xhtml5'
   asciidoc_docbook = 'docbook5'
   xmlto_extra = [
@@ -283,7 +283,7 @@ elif docs_backend == 'asciidoctor'
   ]
 endif
 
-xmlto = find_program('xmlto')
+xmlto = find_program('xmlto', dirs: program_path)
 
 cmd_lists = [
   'cmds-ancillaryinterrogators.txt',
@@ -404,7 +404,7 @@ if get_option('docs').contains('html')
     pointing_to: 'git.html',
   )
 
-  xsltproc = find_program('xsltproc')
+  xsltproc = find_program('xsltproc', dirs: program_path)
 
   user_manual_xml = custom_target(
     command: asciidoc_common_options + [

-- 
2.48.1.468.gbf5f394be8.dirty

