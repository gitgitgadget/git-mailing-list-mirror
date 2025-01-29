Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024C719F421
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 07:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738134737; cv=none; b=K4xKjmmdEvyZ5AX5eQL1mP561OssFtWuYqIzzYcCpOWg38R3OGYR0+uNesLYcMhC9L7Zg26V5l6B3ITQMcI3e8mUPdXxaETSqCNyMWj/LRL0KNVfCaGxy1fsJ7/IGq9Vp9g2buLBsxZY5vQS54Lx/HdK6c30Sh65Tw74gz7H99o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738134737; c=relaxed/simple;
	bh=2f02/fBS99tWr+sSAW4a9mX7VbtTBXssanpCaIBVBDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bG4IWdWxe6w+Kr8Cwmd9ZyYDC11dEL8KktAQ1jMbwI2P/4vhKLuEETWuZpclUl90fUcySxVuDePRpMRQ+kh/+EqOJgvg6wz+RRweosRJ5T6bGCIGq63kmUzu9ybi2MQTQ+Ipm/n5J73lGCCbDrUtkqI3KbVuI2daps5K+1P5WwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QLKMRwAI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nj3N69X6; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QLKMRwAI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nj3N69X6"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 423941380B21
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 02:12:15 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 29 Jan 2025 02:12:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738134735;
	 x=1738221135; bh=++pFvX45/+OBIgLLbEzgsbmUbDd4EwMMAR+DgpfSkDI=; b=
	QLKMRwAIFuJ+RkDMvQl6/RbpwbZsOVdcmKljfkgKUE5Yj5y9Z7AZ47ntaW/UTijm
	UVnrNJdAt0TqSVPPaOVoycnTuBqcCtE3zUtxsNXPXVpHLWEMcDYQullLS0ThJXPc
	Vme8A/YEWgx4CoQkP0KjzZW3kRlvBzPvqAjkqSnvlxrE5F92YWvzCQz/rTLoCCXj
	tU/e1F4u5ISLRD5A/KIJVKECft730NhV6ehoRVwBGZrZ1ElY/D5K0F7GCHAeIfKF
	RlOzblJ2/WW25p8sfMvhGymWFPDOhQCB7lZznfB2Uj3MyKFbKQYuewppJHtDfKS0
	7G02my1WGddXFBR/ZsEl7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738134735; x=
	1738221135; bh=++pFvX45/+OBIgLLbEzgsbmUbDd4EwMMAR+DgpfSkDI=; b=n
	j3N69X6OfWSsV7l2p0uSILv3WwXbAJu5SyWQ3g430QNa5ueKMzXWIfHUVpudIaPl
	ZZXv0Ci2+JNzIGYd1BXO25wQX++tuScLkI88LuRHBh93OVqDm8biZChmVtN7VfSe
	3008Tk+3IWchDu3Yehs0xbObsl4piDvFWh79fESXPUOAVpxf+OQdENVOqAluC/Rr
	gpVxXxst4h8mYDIotKtYPJMh53Tmev+Jo3CSYWuGFg+9unGNQiOQT9XAOWEXTgf4
	AMlmxA0U2OZbNDErFknEH0Pw69wq3+3HFy7+yvHOat9pbtHyEczn+VCa12heFhZ4
	ewRz6S1QdUenJ5Fw3Hf8w==
X-ME-Sender: <xms:z9SZZ9jY_lILD7-J-pIWoOaLb4Fskj4Nn3oQvObmiU721LUFlIbO4Q>
    <xme:z9SZZyCAasykYFDyt2avfRXfnfFN39QTzQmzwa8Ml3l7_9bhH-CeZMdJitaYJ3M4O
    rCx0K4kfa02jmyn-g>
X-ME-Received: <xmr:z9SZZ9GlVY2EZlSomWGNYlBg28r_EvlWdm6Me6T3NT8czmz3OaHQIYcqCS8YVX3-7zPP1NAESijDAuj2Q93HpuPnL_o0WElz7utTl89EzhxoJxxgeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:z9SZZyTMAIBIwsBAARiwysR69arC6qrr84HV_Pso5CaL72Kmbuc3xw>
    <xmx:z9SZZ6wHM90FG-ao458xw3Dn4sVIAQvV0Fd8GJ2XoYvbp0mVvG0NOA>
    <xmx:z9SZZ45oFcMtFf_kabcGQ63h0gjCnldWvuoTZKq_tAiKZMSQE2a0Aw>
    <xmx:z9SZZ_ypkkWWhqtRoZmSxz0elDWHEMdZLJe_4QdCRzn5Hwy1LsbH8w>
    <xmx:z9SZZ_q3b_fKFIhmlqCk3qKYKqsKCqc6SHRqBXTQXt4LW8DyrKC4uTNJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 29 Jan 2025 02:12:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2f96b99e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 29 Jan 2025 07:12:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 29 Jan 2025 08:12:04 +0100
Subject: [PATCH 11/11] meson: consistently use custom program paths to
 resolve programs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-b4-pks-meson-improvements-v1-11-ab709f0be12c@pks.im>
References: <20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im>
In-Reply-To: <20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.48.1.362.g079036d154.dirty

