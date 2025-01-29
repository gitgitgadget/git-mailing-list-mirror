Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B19199239
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 07:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738134734; cv=none; b=CuURCNwLs2eLnJ3/6iAWxEJTwlaF5T0v8Hl80rVFhmUHXX0d3tlGiCiU0VOcZMr5VhlGfm4GaZVJzvcnGzcZZxIUMQ2jLdLSYHH6BdVX+3nYeWFJbUyoDZdp5WSRf4KYvhYN8DQd/oIZuqxGP1GmnxDyZbPgQNZD9X473Qa9+Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738134734; c=relaxed/simple;
	bh=gfmq9Bz/iI14EXSQeArFjuJMH63Mfimla+0Gfd1d5H0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rz7sLy5CxFBC8VMlsuVOgqvlrYa/KfzCwx8SSwXKZ2rTZnVZVvT+CHPvMBkkr90oEoSAPYxe/x+L3ql8QEJpRc8Uq2/aAgNyNvVdsKT1vcKH8lVGWQpybyFwpodV3HQWDVR/GU4XWhEtms8ywYhXEIcOK5wxoMKuTuti4hnP+/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YE/1e1Hv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zQeKgTl2; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YE/1e1Hv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zQeKgTl2"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6419F1140105
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 02:12:09 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 29 Jan 2025 02:12:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738134729;
	 x=1738221129; bh=+1iINIM4+lNJxj+3XBXnklPr4m4zzCV7g0cZRRd9kJA=; b=
	YE/1e1Hvz3n6L3vGXY0k30R/cKq2wZaSILQyxx7zGbLCRSOZyrpMZZUgMA+NH242
	r9EmhZCNsEwH02nR3hs8p7UADgESaYYNx3xDggusY7XUnxlSCceSrvwZdSAYyO25
	rGoUQkC8sFfm0b/XLmV2WIYdm1azy/S/yvkgGy0KtlmnLHkRKSMZoQHF0ApLf455
	yAxG7WIqh40GIkODkC70uVSRt9WBghvFmjSfOYlj5QiCp0ELfMq6JPj/PpPjhE98
	ZlwZCyKFGVvlNkZ2xZWF6QkbKEzTBGQDAb4Yh4gEn9/MZl1m/h5Mo3IgB3GuTJyH
	W+nQSEnFwlycCz74bTf67A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738134729; x=
	1738221129; bh=+1iINIM4+lNJxj+3XBXnklPr4m4zzCV7g0cZRRd9kJA=; b=z
	QeKgTl2xEvVwRMffXCJMz/VBG4FrYP9rRuK0kQJ2j8O66H4ZXAvskFkmqqbaP0ux
	ndF1BO/3LXmUcH7WTkbT46RlceSv4PK48InUd0mN9B7ixAl8dFJxnrr1gSKwmOuW
	ooEnDa0UTeps0EyqdnG35jEmHJ1gh42VjCjVm+rmlI9bxEOTNAgBtdwrBdViRB8z
	TWgwag5ScYPDnz5ktVPgk/nqu3MupQThDyYHDj2C7lBso1fjsrdFfh/+8arAcGgd
	5QlhrVQJZOGjzJaONNijFtibX2ghzfswec0VWfrUJVgeOgphBaBfqBoeGqzOLkAO
	LX7ZpSpmFakI/mexLtW9Q==
X-ME-Sender: <xms:ydSZZ-0LlQ_MB2d-RHc13mMGYa8RHJHuryO3TlXcJt1T48WZzSiibw>
    <xme:ydSZZxEen1cZGxVg6V6WSloyo9BXTGS08JE5YlLsjQ4MXBK4-zxN262gU1lPPIX4l
    rgeYPH2Jg0lr1O0sQ>
X-ME-Received: <xmr:ydSZZ25rz7D_dcu3KXE9P81ae3Dr9_tK_iG5c_38YHv7nb8WZgC0UrZBwCtOfvNs6EKhn7AQNUvzCeqd9qADHy4oS7O4gXm8lvjO3TSyQgR7QevLLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ydSZZ_39IFWpZoBIZr7RX8jl_iWOnoi_dBgEtYyRjgoxj-MIuohi-g>
    <xmx:ydSZZxE3vaoNquvBan4u5PnyQpbBLQ_FDoRqpXKC4SPJ6A6N_EGfew>
    <xmx:ydSZZ49UnLSWWrwT82DpXONDlt7F8zFGXgGDLMyAXx6-uslrgiCEDw>
    <xmx:ydSZZ2kM-sJanHF_77dJQsgmAtySrFn3oVZcaLhK5f2gGn8HUOdguQ>
    <xmx:ydSZZ_Pr6Gq1eUK7pACeimwLbX-Hc9t4QlLS99eejpxxcNdiXFY4NdW7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 29 Jan 2025 02:12:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7ccdbbaf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 29 Jan 2025 07:12:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 29 Jan 2025 08:11:58 +0100
Subject: [PATCH 05/11] meson: introduce `libgit_curl` dependency
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-b4-pks-meson-improvements-v1-5-ab709f0be12c@pks.im>
References: <20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im>
In-Reply-To: <20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

We've got a set of common source files that we use for those executables
that link against libcurl. The setup is somewhat repetitive though.
Simplify it by declaring a `libgit_curl` dependency that bundles all of
it together.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/meson.build b/meson.build
index 6f62728117..e022235815 100644
--- a/meson.build
+++ b/meson.build
@@ -1623,30 +1623,32 @@ bin_wrappers += executable('scalar',
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
     dependencies: [libgit_commonmain, curl],
+  )
+
+  test_dependencies += executable('git-remote-http',
+    sources: 'remote-curl.c',
+    dependencies: libgit_curl,
     install: true,
     install_dir: get_option('libexecdir') / 'git-core',
   )
-  test_dependencies += git_remote_http
 
   test_dependencies += executable('git-http-fetch',
-    sources: curl_sources + 'http-fetch.c',
-    dependencies: [libgit_commonmain, curl],
+    sources: 'http-fetch.c',
+    dependencies: libgit_curl,
     install: true,
     install_dir: get_option('libexecdir') / 'git-core',
   )
 
   if expat.found()
     test_dependencies += executable('git-http-push',
-      sources: curl_sources + 'http-push.c',
-      dependencies: [libgit_commonmain, curl],
+      sources: 'http-push.c',
+      dependencies: libgit_curl,
       install: true,
       install_dir: get_option('libexecdir') / 'git-core',
     )
@@ -1654,8 +1656,8 @@ if get_option('curl').enabled()
 
   foreach alias : [ 'git-remote-https', 'git-remote-ftp', 'git-remote-ftps' ]
     test_dependencies += executable(alias,
-      objects: git_remote_http.extract_all_objects(recursive: false),
-      dependencies: [libgit, curl],
+      sources: 'remote-curl.c',
+      dependencies: libgit_curl,
     )
 
     install_symlink(alias + executable_suffix,
@@ -1665,16 +1667,9 @@ if get_option('curl').enabled()
   endforeach
 endif
 
-imap_send_sources = ['imap-send.c']
-imap_send_dependencies = [libgit_commonmain]
-if use_curl_for_imap_send
-  imap_send_sources += curl_sources
-  imap_send_dependencies += curl
-endif
-
 test_dependencies += executable('git-imap-send',
-  sources: imap_send_sources,
-  dependencies: imap_send_dependencies,
+  sources: 'imap-send.c',
+  dependencies: use_curl_for_imap_send ? [libgit_curl] : [libgit_commonmain],
   install: true,
   install_dir: get_option('libexecdir') / 'git-core',
 )

-- 
2.48.1.362.g079036d154.dirty

