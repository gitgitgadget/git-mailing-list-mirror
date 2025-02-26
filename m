Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8839F1E1DEB
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 08:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558149; cv=none; b=B2IDJOgHqRHwLm8Rw5h8u3Za16brMz48xcO8qiIrLzzTUJk+3GOitSSm+X4Y67df+YyAPQc/H4YNP7MgW842Ci9WtgHs6Po6AhsBf6FtZj+fYa5ubSthZDVxE7bWmnbNJCmH5yMf+YYIqqAwqWu55pLHauz+XfLb+roH72NKoTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558149; c=relaxed/simple;
	bh=xnuJjfCa3utU9sSlx/YK/MSJY/e8f7ElPndf9ILuGJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UaCZ259sABvrM4A12LFDkqHYpDnrXAVvfgXI7e939a/djHryJBrglYLD7kVciIyf/HzRVtysIOUDfdamAipjytchuUIZ3DMFoGQ5xlzcBlunNPvXpmURcCNYQh4rmm3sHVW1UoxVBUgwaVoP5sGIg8YFOAhG+Y0z4IfFAy109eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S7SxARlR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M7a2wAsw; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S7SxARlR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M7a2wAsw"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 86E9A13809BD;
	Wed, 26 Feb 2025 03:22:26 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 26 Feb 2025 03:22:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740558146;
	 x=1740644546; bh=3z4IgqTtBqy2OCeClMtfezlyNdAQMq/TvAj26yGE4tM=; b=
	S7SxARlRTgN+CNJx17C0Rat81P2xhl/LSDzkM1QQ/1jtncamKOH7AIk8w8LmdKi5
	woqQtQ1ohfByHAKhUKacMVEO8Pg37OK1RuGyP9EdkTbblg7XzvozKqNMP4F4lwlC
	ch/ZaXt5LU/ccf8Fo+JnwkyXjk/En3DrmgJRqZGJSjGCsS30ffDLPfl8Mlgmo4NT
	nQoYtH/Nc1nqlOg71s9iXAKhheqIKfP7xPxdrTseuKgHh2D/56PeJJnl8aZzqFMl
	ZAJqlaXLCXd+sY9YlFNh9YmkVBFdg6nHUFQIhdlm1ITt7xcWUqjx5qIFkmkk8sO8
	N/BL2Llk7TYjjbU/uwO0/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740558146; x=
	1740644546; bh=3z4IgqTtBqy2OCeClMtfezlyNdAQMq/TvAj26yGE4tM=; b=M
	7a2wAswqI4c6fI6L86pbSkANEvcef2Y7xQyrpRabyZcoHQcB5Pa0ZO/8vqZOII1P
	rnCmKTiZjXbnIaSMiUq/Y6O28x5072X1H4orLOyjvortOwJ7PaqUsQVwdS7IG4t8
	fmkW8rhZY1mZyN7iESxqCq5Do4hw07VrvqZrpAiGQlAGI/TI0OMgBf21clKPj/NT
	zcTmV2+rbRXNN/V9bjPeypAB+eDtME7GjmXOD3r5FlUdb1Ts+dSKNp9OCuBu6TDe
	MroG27TUoayPtd/Lu/p/JuHtnuwaZ4aHYsHMohSv1RJ72ntrWdIV+aFoFsFoC9ZF
	Jwoc2CUkEI4ukGSNudlhQ==
X-ME-Sender: <xms:Qs--Zz5KfjCIuin2d2VmB0KYnzOlLID4A0X190dSARwgoraT2b7fOg>
    <xme:Qs--Z45sl5l7CyK5t1JtJHKlY46B54I4Ut3MFWymjiNdbei3Fao_Or0GokwshArB2
    naWviJa0pKowGzEDw>
X-ME-Received: <xmr:Qs--Z6ckSZ-lTKd9Bg-WqxBQwScLHhcA0AwbaDemDNCoSCFb2CNYtNL2IBDzotVRorfcoshzhtawBeEdgol-cSDEy2ygnC_aWZZ3AZqp5k1VKf95>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrd
    gtohhm
X-ME-Proxy: <xmx:Qs--Z0IR6mlSz1244wodkpF2U4p542kejPCrDckATGKDRox18Q2aCg>
    <xmx:Qs--Z3JpRsU8SgiZOPXsespFjhkM6eCM5lj_IdUb_vG8Iu1v1ZY2Lw>
    <xmx:Qs--Z9zttdPJgnDUTLyS_VA5idPEFd9LameW6W2QhkUbjYCh0kpJ2A>
    <xmx:Qs--ZzKAlxlYhJmiIR7IcgdYG5h6IwSNotdhal3eTbnu0C76B86Otg>
    <xmx:Qs--Z0EjUk9LbKTThRn5W-a5q_uKqpME7SOulRTKLCxLxnGS_knUDEAa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 03:22:25 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6d188ae9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Feb 2025 08:22:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 26 Feb 2025 09:22:15 +0100
Subject: [PATCH v3 05/13] meson: introduce `libgit_curl` dependency
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-b4-pks-meson-improvements-v3-5-60c77cf673ae@pks.im>
References: <20250226-b4-pks-meson-improvements-v3-0-60c77cf673ae@pks.im>
In-Reply-To: <20250226-b4-pks-meson-improvements-v3-0-60c77cf673ae@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Junio C Hamano <gitster@pobox.com>
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
index 7236c163374..e58462ac4fe 100644
--- a/meson.build
+++ b/meson.build
@@ -1661,30 +1661,32 @@ bin_wrappers += executable('scalar',
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
@@ -1692,8 +1694,8 @@ if get_option('curl').enabled()
 
   foreach alias : [ 'git-remote-https', 'git-remote-ftp', 'git-remote-ftps' ]
     test_dependencies += executable(alias,
-      objects: git_remote_http.extract_all_objects(recursive: false),
-      dependencies: [libgit_commonmain],
+      sources: 'remote-curl.c',
+      dependencies: [libgit_curl],
     )
 
     install_symlink(alias + executable_suffix,
@@ -1703,14 +1705,9 @@ if get_option('curl').enabled()
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
2.48.1.741.g8a9f3a5cdc.dirty

