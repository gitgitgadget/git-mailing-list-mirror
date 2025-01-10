Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6F720C00B
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 12:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736513741; cv=none; b=Nq7lklwUlYiqtt4mlNTiuTsuu+SVcedQw2OyT8oaYlr9keyUyL/wNbDjPWiafxNvUTCUHlkGijMECx5eOkSFp8NO3uKCYi0sIpeJ4S+UAknE40P15jk1+6DQw2KRoG6LRxWK7WLXWpsp2Pr02WpJ2X2iJ00bE0ue9TQNjNbo+pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736513741; c=relaxed/simple;
	bh=ZKoAARlGqTTa3Geh02WFYRu9+tPh4zTOpwLaVCnZUuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EOnmP4HmIP5Fq5d20ZQbAYvmn9h12dFaZpM75c3YAWTZGH2Kb00PFXpLqumJy2OjZyySkWPCPkrpKDomk4/01fILT7S47n29XjRVOP+/KAt20ttId2bY32oDZ1Ok0+VLW9Zj10KETgDAXbTRh64TJWEaZcN6TRQsbeC40C3whWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B2VUsIOP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q4npGs4R; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B2VUsIOP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q4npGs4R"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D4076114010F
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 07:55:38 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 10 Jan 2025 07:55:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736513738;
	 x=1736600138; bh=GArF/TpaGZi8GjUM+pfLQTu50KO+CmZ1avlaPg2TWfg=; b=
	B2VUsIOPa3HlkWjwMe1LPrE542NXSqOZqxQU4ZS4j5zDHUK7uypt0H2AxjFBkzOu
	oZDNb0wxmJ3aIQTggdJWUaNSQaUqnyHOp0c43MDKVIWZLxia8qCROlqY89bY2sl7
	3oiqx/ZuzYDi47+hnjLE0TbuObXlD07cyL944GDRkTJgwTU1+PK25slhHM8eDZp8
	RfI+5pJ/x+d26Z2DnQfmZE6VQJ22pPFiWE7y7K12B/4xDYwBD+HLnFEQYQ2kIAqC
	i/8rVjveIQ+y3BpoUQVWrc6ESUJ3ov62JtUgqCd2+5Lu3vkWYNpWCUvQTFTrVOAN
	6R5q1r6b7RqZJ+vlQSkpSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736513738; x=
	1736600138; bh=GArF/TpaGZi8GjUM+pfLQTu50KO+CmZ1avlaPg2TWfg=; b=q
	4npGs4ReEScRE5qYL1bAT9l2ZEOSDaHDeLC8ifeESLkofh6vAP+ZOBHM3grCjwhD
	+jv5WeIoFrTQnL52GLfMxWa9DGY5ZUpYxl0mSj9nd2liO7UvQHqYQU2XUmU4GTb/
	3IittvJ2cCRcTZfa1VRhyMHiBFzPDE2nn3s5y5Pov0TXQEa4wQoFuTdWxDubo+/e
	GhGNhkBCArCmKXHYLLOTfYylmMHlKjseatjCDwdCAhcyB02nl+Cq58N+ahvJSKT5
	+Y6coqNbDst+brMwwnjhky1TKXBT9qldIqXKz9A+D8JH+ha2wIdewyEX7Lx3GeWA
	W3xxFBa43OGoL1v7EcZpQ==
X-ME-Sender: <xms:yhiBZ0LZlx4lLiRNm-9HwxawV8iJ1uR8KHyZgcF2RNJoXsxxJZ6IcQ>
    <xme:yhiBZ0LppkDFHBes8q1YdbcgY-N3wNwPddfP3qHmSPsw9DO2ILgo8qz9Q6coNrkVM
    8PMjs7QzTIXLuAaEA>
X-ME-Received: <xmr:yhiBZ0v12rgpGRPlPSuWHA2RW9mVPteQRY9WzxoBGjIhNPrOkZkX88OAaIrnjNO4lAK1XUik8JT_LXiOfi5LHLPPDIuTOtfsFdoCjlTG5tNAOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yhiBZxY_o92tH4BmAFnxfNEb3tWKAb1yM1mhUVSG0C8KGERLUHFZfQ>
    <xmx:yhiBZ7Zku4EJyOau7Pt_YA_A9_2K4TOVD2bG9zpSG-ZIlz1JbsAR0g>
    <xmx:yhiBZ9AB9MWfTrvL5f5GLE4cG2y86EVaTh3VeKgiuOIgaurWg1vXTQ>
    <xmx:yhiBZxY34wBqs-WJ6rOx1BFh14OokrhxaEu5kt4scQD7T1gdattaxQ>
    <xmx:yhiBZyzXvtnIobXAZXK-vfHqm2dUVuwE4xt408PxTb3M5SB4qLr1Owbl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 10 Jan 2025 07:55:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 25771f78 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 10 Jan 2025 12:55:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Jan 2025 13:55:31 +0100
Subject: [PATCH 4/8] git-compat-util: move include of "compat/zlib.h" into
 "git-zlib.h"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-pks-compat-drop-uncompress2-v1-4-965d0022a74d@pks.im>
References: <20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im>
In-Reply-To: <20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

We include "compat/zlib.h" in "git-compat-util.h", which is
unnecessarily broad given that we only have a small handful of files
that use the zlib library. Move the header into "git-zlib.h" instead and
adapt users of zlib to include that header.

One exception is the reftable library, as we don't want to use the
Git-specific wrapper of zlib there, so we include "compat/zlib.h"
instead. Furthermore, we move the include into "reftable/system.h" so
that users of the library other than Git can wire up zlib themselves.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 archive.c         | 1 +
 config.c          | 1 +
 csum-file.c       | 3 ++-
 environment.c     | 1 +
 git-compat-util.h | 2 --
 git-zlib.h        | 2 ++
 reftable/block.c  | 1 -
 reftable/system.h | 1 +
 8 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/archive.c b/archive.c
index b9c200cba618ebc642859f2b3c58731157ed0eba..8be4e7ac8db50c7ae019ad12099362d9d392e194 100644
--- a/archive.c
+++ b/archive.c
@@ -7,6 +7,7 @@
 #include "convert.h"
 #include "environment.h"
 #include "gettext.h"
+#include "git-zlib.h"
 #include "hex.h"
 #include "object-name.h"
 #include "path.h"
diff --git a/config.c b/config.c
index 50f2d17b39944626172953475a07a56a9d618740..36f76fafe53ee755c4f18d9ea398b5dbe9a614fe 100644
--- a/config.c
+++ b/config.c
@@ -19,6 +19,7 @@
 #include "convert.h"
 #include "environment.h"
 #include "gettext.h"
+#include "git-zlib.h"
 #include "ident.h"
 #include "repository.h"
 #include "lockfile.h"
diff --git a/csum-file.c b/csum-file.c
index 5716016e12eec8c35f6495141fb2fcc250732803..78e04356d3ae9eb592f580fff204b28961934c0b 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -11,9 +11,10 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "progress.h"
 #include "csum-file.h"
+#include "git-zlib.h"
 #include "hash.h"
+#include "progress.h"
 
 static void verify_buffer_or_die(struct hashfile *f,
 				 const void *buf,
diff --git a/environment.c b/environment.c
index 8389a272700eac7e07710b6899eb045c7df4f69a..e5b361bb5de4c69246098d0d458b567836d174f4 100644
--- a/environment.c
+++ b/environment.c
@@ -16,6 +16,7 @@
 #include "convert.h"
 #include "environment.h"
 #include "gettext.h"
+#include "git-zlib.h"
 #include "repository.h"
 #include "config.h"
 #include "refs.h"
diff --git a/git-compat-util.h b/git-compat-util.h
index 1ca26713221ba0270818ac61b6940f03cdf8b460..fb25fbf503cd3e4cfc9bf14c30dcc66951175c4e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1537,8 +1537,6 @@ int cmd_main(int, const char **);
 int common_exit(const char *file, int line, int code);
 #define exit(code) exit(common_exit(__FILE__, __LINE__, (code)))
 
-#include "compat/zlib-compat.h"
-
 /*
  * This include must come after system headers, since it introduces macros that
  * replace system names.
diff --git a/git-zlib.h b/git-zlib.h
index d8a670aff9fbc476b37e6848a178aec98325d19d..1e8d9aabcb4cb239bdf529926be60b56496e0d4f 100644
--- a/git-zlib.h
+++ b/git-zlib.h
@@ -1,6 +1,8 @@
 #ifndef GIT_ZLIB_H
 #define GIT_ZLIB_H
 
+#include "compat/zlib-compat.h"
+
 typedef struct git_zstream {
 	z_stream z;
 	unsigned long avail_in;
diff --git a/reftable/block.c b/reftable/block.c
index bc9b07963448e613ae14d2c4194b48764718290d..38e3081c614ab2240ce0d988db26f2f4f12b17a1 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -13,7 +13,6 @@ license that can be found in the LICENSE file or at
 #include "record.h"
 #include "reftable-error.h"
 #include "system.h"
-#include "compat/zlib-compat.h"
 
 int header_size(int version)
 {
diff --git a/reftable/system.h b/reftable/system.h
index 5274eca1d05b18bdadef9f991ff79fa83f3363e4..f194a3868634ce7806a85518ebe561a50f5a3ac0 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -14,6 +14,7 @@ license that can be found in the LICENSE file or at
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
+#include "compat/zlib-compat.h"
 
 /*
  * An implementation-specific temporary file. By making this specific to the

-- 
2.48.0.rc2.279.g1de40edade.dirty

