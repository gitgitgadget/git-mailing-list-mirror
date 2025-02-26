Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C391E1E0E
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 08:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558150; cv=none; b=r/bDVfP1+O2x7J95TbyJtF07jNYrSVhib8Pb+jQ7s5PB2oXGDdZgT1g5ioNevS8P4NHsUXuTGeu/KP/GIEIV1WMY2MdDj7ea2/t6dr5d26LwBLEXSDGG0eIRlh7yP/Ab7o4IYzxPPeG+ZBfWftBtMvjXsBntXk0mrSeBgo0hWV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558150; c=relaxed/simple;
	bh=huwwfqucuDnpzoXtVi8KkWJf4xoiGHpgcBgc8pwmIO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Keq2hB4LA9y69GYVLQy4oUPjI9ZzAg3ccmie7kOLdvx72Oe1AKd0tcn+C9oRAfJPeGncNs/Gx5ee/Z2YeZko4usaEbCpCXekGxejn2cHV2ZiiFd9KrN75rd7y134YQDsYlEgUD1idGdq94kAWQRwmuMaM2gPDrHk5XsuQLHuDYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LDJKvwxd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FwnjU6Bk; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LDJKvwxd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FwnjU6Bk"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EB138114017B;
	Wed, 26 Feb 2025 03:22:27 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 26 Feb 2025 03:22:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740558147;
	 x=1740644547; bh=2B1EASh6pkS9IZz/bekjuHF0fxYyL77yTk9T/jkMSeM=; b=
	LDJKvwxdlJqr7h057LdTWfhVUDfFm+U7m8GelrgQqeMOIbijVqOBN3v3suh9b7oA
	uJNVcybE9ML5tl1jfBmsvRb6MFFfq9C806J39ZzFg/czH1bwe1XLO8arxU6H5OpG
	hCQLoiLn5Op6gEF7bU2oP4aA0FfMafscyzGidhrUGSU4Jub63KIXTQNkOMZQBqhI
	f3zgPz5hkVt1knP5fYuy574uiCnhOVDkd0ZgeLfdbfTkPf09Rr/y0QYtyV1KpPMB
	QmOyRhKK0oDFHLc+2q8O9KIEt2lfr8avNpSratWiDTxA30EHCXibI7NUL8XRETZY
	V6M9JZiphniIV3B5g/pxwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740558147; x=
	1740644547; bh=2B1EASh6pkS9IZz/bekjuHF0fxYyL77yTk9T/jkMSeM=; b=F
	wnjU6BkVCqUtjojiC/I9J/ZyZTT4EwgndqkEgy1vni8Tf46ckxjxXifDpdJr3FzX
	iTs46X4+eqiIXOoP36WYfI2MrJbb41CFIiIVdd6GBPBHw36uMcKM+TO14iXzMfis
	fgq8CwvooOdhFEWsO8De3oaXXth/txkqlmd/zENw+Ko0NJAvFLMNEhUsAbAnqcKY
	TxAnxPUaNaPlpLIyY28owkb2AKlFJf2nP7t9ybNc0DGZ1BmhoFIZwGEpwhjMQgIv
	yMSm55NkB4J67Ank7hVu4R/gJaX6dcWtK7lapEMWGgOWA2nVuZO9IlqZ7Fq8WcRA
	dp1zD3mxbVq7PNwzKFtNw==
X-ME-Sender: <xms:Q8--Z7gy3KCi_qnaZBiTI2kMV2IY4DdiReQdriB5oupOdNaB1M-Paw>
    <xme:Q8--Z4AE6ezroWa6KgwVSZvFwZjBRVKbCuOUv4Liez-FeaKxJEoh9S6btOF8mjzNI
    b5uuRS1ekilf00Ftw>
X-ME-Received: <xmr:Q8--Z7FCola9JIa-H6-1yL6MJz03Nj3qVaEVy9NSgDQ7AdWRDpkX15RJCju5T2jX2lP-mClle7SZirzu1ARxhaXdIvgDlkojwEOQujgi97dcc-GT>
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
X-ME-Proxy: <xmx:Q8--Z4TXEOnDEoA7HUumvbBjNB08YVgGa14aRKVos5mjf-t2IjMw1g>
    <xmx:Q8--Z4wfwL_OQAlJUEMoOLWzBUVHO4lwiSSB3h3XHKPeRS3cqfeSPQ>
    <xmx:Q8--Z-7SGz8FoRQNoxA8RJ_z4mlwCKfckjgfIACP0ARM17GT9sdutA>
    <xmx:Q8--Z9w0YCi4OiqOvDN-1NshUyj0wnnGvke7o-oTN_lo34wO-sGUfw>
    <xmx:Q8--ZysD-ZEJsBfOON49btgqOBOo6aAsmNIIF3Ts5kqJ8Rl9yiCFl4Ub>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 03:22:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 366d3a09 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Feb 2025 08:22:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 26 Feb 2025 09:22:16 +0100
Subject: [PATCH v3 06/13] meson: stop linking libcurl into all executables
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-b4-pks-meson-improvements-v3-6-60c77cf673ae@pks.im>
References: <20250226-b4-pks-meson-improvements-v3-0-60c77cf673ae@pks.im>
In-Reply-To: <20250226-b4-pks-meson-improvements-v3-0-60c77cf673ae@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

We set up libcurl via the `libgit_dependencies` variable, which gets
propagated into every user of the `libgit` dependency. This is not
necessary though, as most of our executables aren't even supposed to
link against libcurl.

Fix this by only propagating include directories as a libgit dependency
and propagating the full curl dependency via `libgit_curl`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index e58462ac4fe..39d15ee6cb8 100644
--- a/meson.build
+++ b/meson.build
@@ -927,7 +927,9 @@ if curl.found()
     use_curl_for_imap_send = true
   endif
 
-  libgit_dependencies += curl
+  # Most executables don't have to link against libcurl, but we still need its
+  # include directories so that we can resolve LIBCURL_VERSION in "help.c".
+  libgit_dependencies += curl.partial_dependency(includes: true)
   libgit_c_args += '-DCURL_DISABLE_TYPECHECK'
   build_options_config.set('NO_CURL', '')
 else
@@ -1666,7 +1668,7 @@ if get_option('curl').enabled()
       'http.c',
       'http-walker.c',
     ],
-    dependencies: [libgit_commonmain],
+    dependencies: [libgit_commonmain, curl],
   )
 
   test_dependencies += executable('git-remote-http',

-- 
2.48.1.741.g8a9f3a5cdc.dirty

