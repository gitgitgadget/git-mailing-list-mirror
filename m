Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2821A1946A2
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 07:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738134731; cv=none; b=orLjvll+ZCZwaqtv6fIKYkNtzeR3ZRVP5WvxuDChS10k9GlMBA5cK0RwdMTsITrxQZP/j46eKvMIwvKFezAb5IJJeDsnmZjCER1th+IlwFDROo0svX/cDQzFI/1Bi0gLGAp7LnCzAu//Dxkr9kdOhnH3E4P9oE9MddF9vSThVqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738134731; c=relaxed/simple;
	bh=mzxnLWcu0jyL6XKxghNDi90pMpmT82FbVmhwsBlcWbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TdzaC/6WuPtjkF0sRi5lYhtwolAvx5QZTehE9Urt6onXzNmWyJjrITeDcA4AU04Z3zDoo1n9KWKsu+2nNIv/lzIAEO4ZHg1pln842J0yFFU3idlZfZ0oNR0EV1eyLWRvuxvmfZr+jqdxhsGhtG8ktcKIsmcwAquy73lexWqa+as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qeJaSh/m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KwvvHu9X; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qeJaSh/m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KwvvHu9X"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 2138E1380B21
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 02:12:09 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 29 Jan 2025 02:12:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738134729;
	 x=1738221129; bh=o/lcstWhiGCauDf1ODB6rRGvcEyzdW3p7VarEvia6mw=; b=
	qeJaSh/mpdZHvY38eEsPq8OF53+Vv/JHIDQHZqj2o0AsdpBub9iyKe7UlVxMTh4n
	rvzzS0IsWFTCso40o1lxjhxoWbUKJsrG69zAgH5CZwVsukyLAoE8/0OAve+23w3h
	0OEFuDvfREqKM/LZI35ptRVLkwF6tKR8Rf6ki4uQpZaQq4eF0FTq0/YqpVWdT6D6
	6CBbW+ZyOjFQmmPpBWVtZVDgFzPBxxyFzK384dloF7vuGV7TYGbvqBzRHARf/k5x
	3d+R2jBCUCbeo6vXqXZ8PiaM4IowIQ1cdWvvo+fBuoaTmb/lg179HjeCz04xNGQR
	H+ai2T1W4lKgx+h5sIpBxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738134729; x=
	1738221129; bh=o/lcstWhiGCauDf1ODB6rRGvcEyzdW3p7VarEvia6mw=; b=K
	wvvHu9XXvXOEUjHQ6S1E4IlzXk7l4+o6Oo2k3C4gLEbTfDjwGDWysNYNvB0wxPlT
	ZlV41ARDNWwyyyB0RuyT6KiaAmRwwxjNwGN44PwVsFhLmEYYO7PL1TlgDqMmBkm8
	8eMXdpWI+LfInTpZ6VOdvBULQn7rVTqKYqxohR8K4CkbDJiMQ3LaJk8Uqz+T4nPC
	VI5HzvZO1AqiaX5EKO6bN79AwPFF1y/ttjHpDsbv6Tn2MZmrL5aXKvkB/B+o5cYM
	0rtIuZ4OMEZjsQYaXMqKIAygTvR46iBkx/rqqQlLBO5UdHy+SiPqpi2mT1o4rBei
	XH8b9mSqrjSPQmZhm5aig==
X-ME-Sender: <xms:yNSZZ5QYpWixgA3K8NdBhh1DEHpZfhwiIU8MHOSYK9bZWS2LHHdEwg>
    <xme:yNSZZyyLxioHKns8KG8LB5wC_sru886lgXT-WngKLNMw4iZswGcoJfSjM5djRPJHY
    jUy0jbiHBn0hXl5ag>
X-ME-Received: <xmr:yNSZZ-0hgwOH5imjDA6ubfkDH2PDhpjBBH7nyr9AzNrAR-RuIVkyMWCrJ7QwXtZTnaDcNudJFLkPw-RjbtllfeQeMxef9lSVy_t7agC2fNxORv3ZSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yNSZZxDMr2DwOppQ13v_gQKxv_68ypUcj6U8flT9ldrEl6PgO5RWIg>
    <xmx:yNSZZygHNFepIYIWDyKBeHrBtfgkrs0USr1AJfoAQzBfWhXaKyRcfw>
    <xmx:yNSZZ1qYW6lzoZdIEskJSoZ9p7mg5lOFGd4xOu6yR3EENxB8le_oxw>
    <xmx:yNSZZ9hLdliBS52RD7AAql61lABsjmbO8C35_c13yTg_klVNBkX0HQ>
    <xmx:ydSZZ2ZJDjAqkQMWBKwGiBQHBgIf6G8zdeyAhf3b_7m-H8jh7KI4VjIT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 29 Jan 2025 02:12:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f5bf208b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 29 Jan 2025 07:12:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 29 Jan 2025 08:11:57 +0100
Subject: [PATCH 04/11] meson: stop linking libcurl into all executables
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-b4-pks-meson-improvements-v1-4-ab709f0be12c@pks.im>
References: <20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im>
In-Reply-To: <20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

We set up libcurl via the `libgit_dependencies` variable, which gets
propagated into every user of the `libgit` dependency. This is not
necessary though, as most of our executables aren't even supposed to
link against libcurl.

Fix this by only linking against libcurl as required.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/meson.build b/meson.build
index 82b6e62029..6f62728117 100644
--- a/meson.build
+++ b/meson.build
@@ -911,7 +911,6 @@ if curl.found()
     use_curl_for_imap_send = true
   endif
 
-  libgit_dependencies += curl
   libgit_c_args += '-DCURL_DISABLE_TYPECHECK'
   build_options_config.set('NO_CURL', '')
 else
@@ -1631,7 +1630,7 @@ if get_option('curl').enabled()
 
   git_remote_http = executable('git-remote-http',
     sources: curl_sources + 'remote-curl.c',
-    dependencies: [libgit_commonmain],
+    dependencies: [libgit_commonmain, curl],
     install: true,
     install_dir: get_option('libexecdir') / 'git-core',
   )
@@ -1639,7 +1638,7 @@ if get_option('curl').enabled()
 
   test_dependencies += executable('git-http-fetch',
     sources: curl_sources + 'http-fetch.c',
-    dependencies: [libgit_commonmain],
+    dependencies: [libgit_commonmain, curl],
     install: true,
     install_dir: get_option('libexecdir') / 'git-core',
   )
@@ -1647,7 +1646,7 @@ if get_option('curl').enabled()
   if expat.found()
     test_dependencies += executable('git-http-push',
       sources: curl_sources + 'http-push.c',
-      dependencies: [libgit_commonmain],
+      dependencies: [libgit_commonmain, curl],
       install: true,
       install_dir: get_option('libexecdir') / 'git-core',
     )
@@ -1656,7 +1655,7 @@ if get_option('curl').enabled()
   foreach alias : [ 'git-remote-https', 'git-remote-ftp', 'git-remote-ftps' ]
     test_dependencies += executable(alias,
       objects: git_remote_http.extract_all_objects(recursive: false),
-      dependencies: [libgit],
+      dependencies: [libgit, curl],
     )
 
     install_symlink(alias + executable_suffix,
@@ -1667,13 +1666,15 @@ if get_option('curl').enabled()
 endif
 
 imap_send_sources = ['imap-send.c']
+imap_send_dependencies = [libgit_commonmain]
 if use_curl_for_imap_send
   imap_send_sources += curl_sources
+  imap_send_dependencies += curl
 endif
 
 test_dependencies += executable('git-imap-send',
   sources: imap_send_sources,
-  dependencies: [libgit_commonmain],
+  dependencies: imap_send_dependencies,
   install: true,
   install_dir: get_option('libexecdir') / 'git-core',
 )

-- 
2.48.1.362.g079036d154.dirty

