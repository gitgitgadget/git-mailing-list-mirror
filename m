Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2944288C15
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 09:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751535037; cv=none; b=o9zSwaNQubxwpj6PB8B87l2aJuyqTf+MmB3pS3pqRtyjtrzExCe6wtU37JuVEM/i+55Q+BB0o+t88hM8BgxSCueCR/zf+PE/2wqUlaFuLS08WF9nlEz2H36aSHFUF6UEaqr1TZT2oPpt0INkqYlRGXkjRmtQzj5GCC6/8KhEuIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751535037; c=relaxed/simple;
	bh=p4RIjIIag34ZnXpMBK0x9rHPWi8Pc0ODL/WsAkwt6Eo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=roAsPLhsopPENv9bhCFbaQgwRYIYLERb9aAXgGoAFdzukGDSgqluR4P13HpVUs0LCQnvaRw8d2KECBOlaaf/fOGbUUqJvI2NPedfi6Pw7XIgyS6TvLgsijqoH6J6KxYnsCkQutrmueZZubMElDQfmPm5BDxwYg8jeVVxs0FMntw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TWI7VTi1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VEiQFGNr; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TWI7VTi1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VEiQFGNr"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id D0D361D00297;
	Thu,  3 Jul 2025 05:30:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 03 Jul 2025 05:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751535034;
	 x=1751621434; bh=iwFiOFiFOxxZx/2xZ85jZV7r34RW0lbAvDFfc7V8yZU=; b=
	TWI7VTi1UNuDvB10Bx0FAgjyCmRSt/k3VYRDNPhAVW6Q5y1HmEg8mRD9Y1NaAfez
	2qjkWv/LZGIBh7pEuvb1/NmCCLiKRpY7+vPifwdr21F7O5E73iHJ/Is0KMHGax7H
	kd5aCjYICmyXUMFo8+WlXL5Yt2xjfyIZOpbH+6XwmItP2rt48K2yac1N9r4SIF0H
	pQwM9hStrW0U/rnR5Tq7/b/i4MZxgXxqX7iPDC1fNmNEJLK7m013sF4D+X716Jzc
	LKwtpYTudc9LBgPJa2O/9VIfAwFArqB60mY8p+QadcMjxhX37iRfeX7eKMifPFV9
	HQU5hV7a5ikaeqjGurpCvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751535034; x=
	1751621434; bh=iwFiOFiFOxxZx/2xZ85jZV7r34RW0lbAvDFfc7V8yZU=; b=V
	EiQFGNrf54Ej2bX5um3QublcRIZS9NKMeSglRAfrO6vTbBIIc+mek/YaNH5WKwxY
	//mP9NORSdB499RyAKtO3INZs98K3MAKKZGkpTYJjmBmhOlnu/tkE8C6VZUb5GZS
	FGq3o+pyXvD0FXlhhmi45hyGIWJmaly5YE690eHALNT2I/0myWcCWWyL9aqyG+2J
	8XojFq/hOVIxDBsuwvxAUaHar7r+My2FLIJnSpLOflqNhwmW1hqITPwk12sQ0w79
	rdOphdHY4EYNFH4AUUTFVuX2W5R8Hq40mN3h0OrXrL0SISUZUfWWSMsRQ03b57z5
	wGu7FPU5TMBkQle09r0OQ==
X-ME-Sender: <xms:uk1maP06cBCgFujB9IVeoGODxt73d0szsJhverfvtQTJY84c898pfg>
    <xme:uk1maOGH-uM82hIacwQf86sfsqs-VAOqEkKa-c7ISfQOAYl4R4chAzEAm-c-C1EEH
    9Rj2nD0MjIPGxdFoQ>
X-ME-Received: <xmr:uk1maP5YjICGHVXvVxYwAgfMn1kCb6532cyCnCCthEtuLwZiGcW5LKLhRCsZdHbFkY1Vf7fw0WdhKRxX7cHsnEXArUDMthW4hgxLlNcIuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epudekjefgleekfeefgfejueehieffvdffledtfeegiedukeehtdffueeivefffefgnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhdpmhgvshhonhgsuhhilhgurdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvshgthhifrghr
    thiisehgvghnthhoohdrohhrghdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjh
    honhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepihhrvggttggrrdhkuhhnsehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:uk1maE2EwWaclpve1BLn2Yh4c-jLiqWvjm8YXutqtK0yRiI2RJGbWA>
    <xmx:uk1maCFHgpZMEEoZB1A1ilHswVDbq8pQSrd2cYnFnR6OsDDn4YHKPA>
    <xmx:uk1maF-LstL_Da_wmNNLcue0wFC5kFph9_hgVFKFP_TCuNmfvk1JJQ>
    <xmx:uk1maPlCbm-c6CfzjZW9KBdYoJ0zdMpFDFVYau4gA-3-_NQqK-Msjw>
    <xmx:uk1maCTFW7VW24-WjmPY0aCl121nFPlMbsgSkCTweVB4aez0tnA3iL8B>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 05:30:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9f9a4a32 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 3 Jul 2025 09:30:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 03 Jul 2025 11:28:49 +0200
Subject: [PATCH 7/8] meson: update subproject wrappers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-b4-pks-meson-cleanups-v1-7-2804c2932abe@pks.im>
References: <20250703-b4-pks-meson-cleanups-v1-0-2804c2932abe@pks.im>
In-Reply-To: <20250703-b4-pks-meson-cleanups-v1-0-2804c2932abe@pks.im>
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, irecca.kun@gmail.com, 
 Eli Schwartz <eschwartz@gentoo.org>
X-Mailer: b4 0.14.2

Update subproject wrappers to newer versions by executing `meson wrap
update` in the project's root directory

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 subprojects/expat.wrap | 18 +++++++++---------
 subprojects/pcre2.wrap | 18 +++++++++---------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/subprojects/expat.wrap b/subprojects/expat.wrap
index 2e0427dcfd1..0e9292f97bf 100644
--- a/subprojects/expat.wrap
+++ b/subprojects/expat.wrap
@@ -1,13 +1,13 @@
 [wrap-file]
-directory = expat-2.6.3
-source_url = https://github.com/libexpat/libexpat/releases/download/R_2_6_3/expat-2.6.3.tar.xz
-source_filename = expat-2.6.3.tar.bz2
-source_hash = 274db254a6979bde5aad404763a704956940e465843f2a9bd9ed7af22e2c0efc
-patch_filename = expat_2.6.3-1_patch.zip
-patch_url = https://wrapdb.mesonbuild.com/v2/expat_2.6.3-1/get_patch
-patch_hash = cf017fbe105e31428b2768360bd9be39094df4e948a1e8d1c54b6f7c76460cb1
-source_fallback_url = https://github.com/mesonbuild/wrapdb/releases/download/expat_2.6.3-1/expat-2.6.3.tar.bz2
-wrapdb_version = 2.6.3-1
+directory = expat-2.7.1
+source_url = https://github.com/libexpat/libexpat/releases/download/R_2_7_1/expat-2.7.1.tar.xz
+source_filename = expat-2.7.1.tar.bz2
+source_hash = 354552544b8f99012e5062f7d570ec77f14b412a3ff5c7d8d0dae62c0d217c30
+patch_filename = expat_2.7.1-1_patch.zip
+patch_url = https://wrapdb.mesonbuild.com/v2/expat_2.7.1-1/get_patch
+patch_hash = fe28cbbc427a7c9787d08b969ad54d19f59d8dd18294b4a18651cecfc789d4ef
+source_fallback_url = https://github.com/mesonbuild/wrapdb/releases/download/expat_2.7.1-1/expat-2.7.1.tar.bz2
+wrapdb_version = 2.7.1-1
 
 [provide]
 expat = expat_dep
diff --git a/subprojects/pcre2.wrap b/subprojects/pcre2.wrap
index 7e184472543..f45c968e2f3 100644
--- a/subprojects/pcre2.wrap
+++ b/subprojects/pcre2.wrap
@@ -1,13 +1,13 @@
 [wrap-file]
-directory = pcre2-10.44
-source_url = https://github.com/PCRE2Project/pcre2/releases/download/pcre2-10.44/pcre2-10.44.tar.bz2
-source_filename = pcre2-10.44.tar.bz2
-source_hash = d34f02e113cf7193a1ebf2770d3ac527088d485d4e047ed10e5d217c6ef5de96
-patch_filename = pcre2_10.44-2_patch.zip
-patch_url = https://wrapdb.mesonbuild.com/v2/pcre2_10.44-2/get_patch
-patch_hash = 4336d422ee9043847e5e10dbbbd01940d4c9e5027f31ccdc33a7898a1ca94009
-source_fallback_url = https://github.com/mesonbuild/wrapdb/releases/download/pcre2_10.44-2/pcre2-10.44.tar.bz2
-wrapdb_version = 10.44-2
+directory = pcre2-10.45
+source_url = https://github.com/PCRE2Project/pcre2/releases/download/pcre2-10.45/pcre2-10.45.tar.bz2
+source_filename = pcre2-10.45.tar.bz2
+source_hash = 21547f3516120c75597e5b30a992e27a592a31950b5140e7b8bfde3f192033c4
+patch_filename = pcre2_10.45-2_patch.zip
+patch_url = https://wrapdb.mesonbuild.com/v2/pcre2_10.45-2/get_patch
+patch_hash = 7c6f34b703708652a404f9dc2769c67658c437b6043573295fa3428a9b7a6807
+source_fallback_url = https://github.com/mesonbuild/wrapdb/releases/download/pcre2_10.45-2/pcre2-10.45.tar.bz2
+wrapdb_version = 10.45-2
 
 [provide]
 libpcre2-8 = libpcre2_8

-- 
2.50.0.195.g74e6fc65d0.dirty

