Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3362BE056
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749438; cv=none; b=YFP2EhqBBfg6aU/u4AGXPp3XZcOUk0/o1L6zhzM8uarfR3AahdZrWiqvTWT0kcovocBmS8BMFf79sq2fAiSTUwQhPy9nMFkSQspweKK36Ra0dOLsrb85b91gE9wFLvUS0VvE6qbAS4IAjlmBMKhcKF4Kmk+YVKZFKFZoPCAlDik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749438; c=relaxed/simple;
	bh=CEFUfXAPygLeRxt7tRDjl1mz/SoH22yiXMSY0vFD070=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gEsVPyUoHsulWIosqwqo1/F6WOwg9RtCu3o63IVK78t1y3UABvLM6cRpDLsjaw2uIiOLV5JO5rPpuQID/j7ezmYzAsGqqgTqMbPVUotDNrkFTnUfQ19t66W0jTEbvNI2VUA6L+KtqPh49bST5W64BcW4lwZeGnRcLHr6RD74KAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QC3dZw4Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RRIPFaLD; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QC3dZw4Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RRIPFaLD"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 131077A01E2
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 06:50:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 17 Jul 2025 06:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752749433;
	 x=1752835833; bh=DTC+xsUVgFioYAdyvb+gddFlOpfcEy/oFXdE/UhaHkg=; b=
	QC3dZw4YqJaStQPV0eRi8R5CP7wd4G99HDDkYRfhwZgTKnHL0v3UWa0gPuBUMicA
	fqggswFzkoC4kONenDX1wddIP0Ir9nOALi+d1Qn3Jcy/LSuo0nafKB2yoHYSRYUJ
	xGRn6oN7MeWLZVHDohd9MstiA6klbz2l7FnfgBMcvLq8JG518+TWkw6n4nroWZv7
	3X5vpLgrZj34nz43DJeoMaThh/+NUs1Og3d5OUDURotlNS80FcR8bTdceW++eSRM
	VNBushIpz91VWalpbuy2fqBnXbX/igg8cGFxcBWVfsvOAv7hhqOSlUqh3ueYSpYn
	EfAv1+gp1RWCyg2oscFY7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752749433; x=
	1752835833; bh=DTC+xsUVgFioYAdyvb+gddFlOpfcEy/oFXdE/UhaHkg=; b=R
	RIPFaLDtAE0Ms0w78izNtzT5pmpcDJvyJySc+cP3o/cegrru9Mo6hW2EN+BjIPYa
	dQvM4hP8FUL4SxToqBo/CuQ3DX0G/xlob+e9VMhXfagQWKanvrYjjI5P8Xe6PjL9
	5ZpnmMBwozf2jKktcOyWkmWcqKRHpIPEwnF8EL3VfZQ112ndBPdEqn6O6Euwm1iM
	4BLI9EsxpgnXhLtO3Z2/r9NPiGGGO0pmQ9okpKFVjUhlufoyh13FaPA+7tpnMsc2
	ILbGkPecVMJxq9vq1ak6mt4YC7MAD5rOdS7TTOIubGC9iPgSA4eRCDQ9wv5o1yCS
	ejlnQsodhYEhfJ4U2RNoQ==
X-ME-Sender: <xms:edV4aC1DI0EJV3yue8yPHahEe4peXtJuc6r_TDwJ2Eyl28DAucql0g>
    <xme:edV4aHFz_Nny1fZ1lHMAsrqk0QxtJCuigz_5Aiq8-Gu1ShzSilHRFRqaELTTTIOXW
    poioMEBOZ6epi42rg>
X-ME-Received: <xmr:edV4aEQu1nLPiffaiEbEXd165sxfwB4_J95qlarSVRDLaCT3BFZoEIK5sDPWZJ45DtB5E2FFm4rehyKWd8v1CnCZVivTpxbNTkLm1TY6UlAp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitdeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:edV4aGDAl5Ksuyi8b2Jc9MLLMqCxO21CfqfQqqw2w09ANbwjq0g6gw>
    <xmx:edV4aM0Vnhs1X694KH5wgYTa8d3d1nr5D17lphtYoWBSGDeSPG4xGw>
    <xmx:edV4aMV_4LdDUUc7JLwOFzWlWxb9IDnIa9MIwls4sayK4HA4RafWIw>
    <xmx:edV4aGkEkXUMXfR7tX8YrgyffDOakyBfrU34K1m3P9VFlzJF_nC1Pw>
    <xmx:edV4aE-9s2UfoO-zO3ckUWSRn5MXj5LkJN-IEMiCO10tyYVQqAJjRtyH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 17 Jul 2025 06:50:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dd274a19 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Thu, 17 Jul 2025 10:50:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 17 Jul 2025 12:49:40 +0200
Subject: [PATCH 20/21] config: move Git config parsing into "environment.c"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-pks-config-wo-the-repository-v1-20-d888e4a17de1@pks.im>
References: <20250717-pks-config-wo-the-repository-v1-0-d888e4a17de1@pks.im>
In-Reply-To: <20250717-pks-config-wo-the-repository-v1-0-d888e4a17de1@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

In "config.c" we host both the business logic to read and write config
files as well as the logic to parse specific Git-related variables. On
the one hand this is mixing concerns, but even more importantly it means
that we cannot easily remove the dependency on `the_repository` in our
config parsing logic.

Move the logic into "environment.c". This file is a grab bag of all
kinds of global state already, so it is quite a good fit. Furthermore,
it also hosts most of the global variables that we're parsing the config
values into, making this an even better fit.

Note that there is one hidden change: in `parse_fsync_components()` we
use an `int` to iterate through `ARRAY_SIZE(fsync_component_names)`. But
as -Wsign-compare warnings are enabled in this file this causes a
compiler warning. The issue is fixed by using a `size_t` instead.

This change allows us to drop the `USE_THE_REPOSITORY_VARIABLE`
declaration.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/add.c                |   1 +
 builtin/check-ignore.c       |   1 +
 builtin/check-mailmap.c      |   1 +
 builtin/checkout--worker.c   |   1 +
 builtin/checkout-index.c     |   1 +
 builtin/clean.c              |   1 +
 builtin/commit-graph.c       |   1 +
 builtin/commit-tree.c        |   1 +
 builtin/count-objects.c      |   1 +
 builtin/credential.c         |   1 +
 builtin/fast-export.c        |   1 +
 builtin/for-each-ref.c       |   1 +
 builtin/fsmonitor--daemon.c  |   1 +
 builtin/grep.c               |   1 +
 builtin/hash-object.c        |   1 +
 builtin/help.c               |   1 +
 builtin/hook.c               |   1 +
 builtin/interpret-trailers.c |   1 +
 builtin/ls-files.c           |   1 +
 builtin/ls-tree.c            |   1 +
 builtin/merge-base.c         |   1 +
 builtin/merge-tree.c         |   1 +
 builtin/multi-pack-index.c   |   1 +
 builtin/pack-refs.c          |   1 +
 builtin/patch-id.c           |   1 +
 builtin/pull.c               |   1 +
 builtin/read-tree.c          |   1 +
 builtin/replace.c            |   1 +
 builtin/rm.c                 |   1 +
 builtin/send-pack.c          |   1 +
 builtin/show-ref.c           |   1 +
 builtin/symbolic-ref.c       |   1 +
 builtin/unpack-file.c        |   1 +
 builtin/update-ref.c         |   1 +
 builtin/update-server-info.c |   1 +
 builtin/var.c                |   1 +
 builtin/verify-commit.c      |   1 +
 builtin/verify-pack.c        |   1 +
 builtin/verify-tag.c         |   1 +
 builtin/write-tree.c         |   1 +
 commit-graph.c               |   1 +
 config.c                     | 511 ------------------------------------------
 config.h                     |   3 -
 environment.c                | 512 +++++++++++++++++++++++++++++++++++++++++++
 environment.h                |   3 +
 fsck.c                       |   1 +
 http-fetch.c                 |   1 +
 http.c                       |   1 +
 imap-send.c                  |   1 +
 mailinfo.c                   |   1 +
 reflog.c                     |   1 +
 rerere.c                     |   1 +
 t/helper/test-advise.c       |   1 +
 t/helper/test-read-cache.c   |   1 +
 xdiff-interface.c            |   1 +
 55 files changed, 566 insertions(+), 514 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 7c292ffdc6c..88d1d330fa8 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -7,6 +7,7 @@
 #include "builtin.h"
 #include "advice.h"
 #include "config.h"
+#include "environment.h"
 #include "lockfile.h"
 #include "editor.h"
 #include "dir.h"
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 03033499cb0..644c9a414ff 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -2,6 +2,7 @@
 #include "builtin.h"
 #include "config.h"
 #include "dir.h"
+#include "environment.h"
 #include "gettext.h"
 #include "quote.h"
 #include "pathspec.h"
diff --git a/builtin/check-mailmap.c b/builtin/check-mailmap.c
index 634626c6728..9cc5c598302 100644
--- a/builtin/check-mailmap.c
+++ b/builtin/check-mailmap.c
@@ -1,6 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "ident.h"
 #include "mailmap.h"
diff --git a/builtin/checkout--worker.c b/builtin/checkout--worker.c
index 27a7d4f0409..e0772b718b2 100644
--- a/builtin/checkout--worker.c
+++ b/builtin/checkout--worker.c
@@ -4,6 +4,7 @@
 #include "builtin.h"
 #include "config.h"
 #include "entry.h"
+#include "environment.h"
 #include "gettext.h"
 #include "parallel-checkout.h"
 #include "parse-options.h"
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 7f74bc702fa..188128aebd9 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -9,6 +9,7 @@
 
 #include "builtin.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "lockfile.h"
 #include "quote.h"
diff --git a/builtin/clean.c b/builtin/clean.c
index 5ee147c4acc..a1977b92dc8 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -13,6 +13,7 @@
 #include "abspath.h"
 #include "config.h"
 #include "dir.h"
+#include "environment.h"
 #include "gettext.h"
 #include "parse-options.h"
 #include "path.h"
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index c5cc601844c..4992ac146e1 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -2,6 +2,7 @@
 #include "builtin.h"
 #include "commit.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "parse-options.h"
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 2f1df28d413..5189e685a7e 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -6,6 +6,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "object-name.h"
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 433daff805a..b1148a68fa8 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -7,6 +7,7 @@
 #include "builtin.h"
 #include "config.h"
 #include "dir.h"
+#include "environment.h"
 #include "gettext.h"
 #include "path.h"
 #include "parse-options.h"
diff --git a/builtin/credential.c b/builtin/credential.c
index 52f172e80cb..a295c80b366 100644
--- a/builtin/credential.c
+++ b/builtin/credential.c
@@ -3,6 +3,7 @@
 #include "git-compat-util.h"
 #include "credential.h"
 #include "builtin.h"
+#include "environment.h"
 #include "config.h"
 
 static const char usage_msg[] =
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 17027b859e0..66a3a98c938 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -9,6 +9,7 @@
 
 #include "builtin.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "refs.h"
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 3d2207ec773..a8f7f8c7625 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "commit.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "object.h"
 #include "parse-options.h"
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 469c62b555b..242c594646d 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -5,6 +5,7 @@
 #include "abspath.h"
 #include "config.h"
 #include "dir.h"
+#include "environment.h"
 #include "gettext.h"
 #include "parse-options.h"
 #include "fsmonitor-ll.h"
diff --git a/builtin/grep.c b/builtin/grep.c
index 8fcb69dbf2c..5df65373337 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -9,6 +9,7 @@
 
 #include "builtin.h"
 #include "abspath.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "config.h"
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index c3ad1e91c96..5d900a6b8c9 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -8,6 +8,7 @@
 #include "builtin.h"
 #include "abspath.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "object-file.h"
diff --git a/builtin/help.c b/builtin/help.c
index d79ecd946a6..c09cbc8912d 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -6,6 +6,7 @@
 
 #include "builtin.h"
 #include "config.h"
+#include "environment.h"
 #include "exec-cmd.h"
 #include "gettext.h"
 #include "pager.h"
diff --git a/builtin/hook.c b/builtin/hook.c
index 044c27aa95d..7afec380d2e 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -1,6 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hook.h"
 #include "parse-options.h"
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 3141c37b853..41b0750e5af 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -6,6 +6,7 @@
  */
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
+#include "environment.h"
 #include "gettext.h"
 #include "parse-options.h"
 #include "string-list.h"
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index ff975e7be06..c06a6f33e41 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -11,6 +11,7 @@
 #include "builtin.h"
 #include "config.h"
 #include "convert.h"
+#include "environment.h"
 #include "quote.h"
 #include "dir.h"
 #include "gettext.h"
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 4ba84e51967..5d55731ca35 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -7,6 +7,7 @@
 #include "builtin.h"
 
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "object-name.h"
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 8fde35c1751..3f82781245b 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -2,6 +2,7 @@
 #include "builtin.h"
 #include "config.h"
 #include "commit.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "object-name.h"
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 99a6495fd52..203f0e6456a 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -1,6 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
+#include "environment.h"
 #include "tree-walk.h"
 #include "xdiff-interface.h"
 #include "help.h"
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 9a113f0f1f3..d3b9e98be37 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -2,6 +2,7 @@
 #include "builtin.h"
 #include "abspath.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "parse-options.h"
 #include "midx.h"
diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index e47bae1c803..5e28d0f9e80 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "parse-options.h"
 #include "refs.h"
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index a659f00531a..d26e9d0c1ea 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -3,6 +3,7 @@
 #include "builtin.h"
 #include "config.h"
 #include "diff.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hash.h"
 #include "hex.h"
diff --git a/builtin/pull.c b/builtin/pull.c
index 5ea51c31f58..e6d3535c3b5 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -11,6 +11,7 @@
 #include "builtin.h"
 #include "advice.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "merge.h"
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 00eef756e67..34f7a59f38e 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -6,6 +6,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
diff --git a/builtin/replace.c b/builtin/replace.c
index 3fe39e9df73..19897ef927f 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -11,6 +11,7 @@
 #include "builtin.h"
 #include "config.h"
 #include "editor.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "refs.h"
diff --git a/builtin/rm.c b/builtin/rm.c
index 8c0da7a3ce7..05d89e98c3c 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -9,6 +9,7 @@
 #include "builtin.h"
 #include "advice.h"
 #include "config.h"
+#include "environment.h"
 #include "lockfile.h"
 #include "dir.h"
 #include "gettext.h"
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 28b69d26b48..8b81c8a8486 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "config.h"
+#include "environment.h"
 #include "hex.h"
 #include "pkt-line.h"
 #include "run-command.h"
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 414e55b92d5..0b6f9edf86c 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -1,6 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "refs/refs-internal.h"
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index 5c4623067c5..231e41e715b 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -1,6 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "refs.h"
 #include "parse-options.h"
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index ae871adc909..87877a9fabc 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -1,6 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
+#include "environment.h"
 #include "hex.h"
 #include "object-file.h"
 #include "object-name.h"
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index cb936643243..195437e7c65 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -3,6 +3,7 @@
 
 #include "builtin.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hash.h"
 #include "hex.h"
diff --git a/builtin/update-server-info.c b/builtin/update-server-info.c
index ba702d30efd..4c12968a836 100644
--- a/builtin/update-server-info.c
+++ b/builtin/update-server-info.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "parse-options.h"
 #include "server-info.h"
diff --git a/builtin/var.c b/builtin/var.c
index beeac12dccf..a2d790d4532 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -11,6 +11,7 @@
 #include "attr.h"
 #include "config.h"
 #include "editor.h"
+#include "environment.h"
 #include "ident.h"
 #include "pager.h"
 #include "refs.h"
diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index 5f749a30daf..62398acd721 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -7,6 +7,7 @@
  */
 #include "builtin.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "object-name.h"
 #include "commit.h"
diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
index d9f66f5e767..65fd6629a00 100644
--- a/builtin/verify-pack.c
+++ b/builtin/verify-pack.c
@@ -1,6 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "run-command.h"
 #include "parse-options.h"
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index ed1c40338fd..cd6bc11095d 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -7,6 +7,7 @@
  */
 #include "builtin.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "tag.h"
 #include "object-name.h"
diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index 3465c70a48a..e3bd1a40dbf 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -6,6 +6,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "tree.h"
diff --git a/commit-graph.c b/commit-graph.c
index bd7b6f5338b..e0d92b816f5 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -4,6 +4,7 @@
 #include "git-compat-util.h"
 #include "config.h"
 #include "csum-file.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
diff --git a/config.c b/config.c
index 285cab0ce2a..947fba3d8d4 100644
--- a/config.c
+++ b/config.c
@@ -6,12 +6,10 @@
  *
  */
 
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "abspath.h"
-#include "advice.h"
 #include "date.h"
 #include "branch.h"
 #include "config.h"
@@ -20,11 +18,8 @@
 #include "environment.h"
 #include "gettext.h"
 #include "git-zlib.h"
-#include "ident.h"
 #include "repository.h"
 #include "lockfile.h"
-#include "mailmap.h"
-#include "attr.h"
 #include "exec-cmd.h"
 #include "strbuf.h"
 #include "quote.h"
@@ -32,7 +27,6 @@
 #include "string-list.h"
 #include "object-name.h"
 #include "odb.h"
-#include "pager.h"
 #include "path.h"
 #include "utf8.h"
 #include "color.h"
@@ -41,7 +35,6 @@
 #include "strvec.h"
 #include "trace2.h"
 #include "wildmatch.h"
-#include "ws.h"
 #include "write-or-die.h"
 
 struct config_source {
@@ -71,9 +64,6 @@ struct config_source {
 };
 #define CONFIG_SOURCE_INIT { 0 }
 
-static int pack_compression_seen;
-static int zlib_compression_seen;
-
 /*
  * Config that comes from trusted scopes, namely:
  * - CONFIG_SCOPE_SYSTEM (e.g. /etc/gitconfig)
@@ -1262,80 +1252,6 @@ double git_config_double(const char *name, const char *value,
 	return ret;
 }
 
-static const struct fsync_component_name {
-	const char *name;
-	enum fsync_component component_bits;
-} fsync_component_names[] = {
-	{ "loose-object", FSYNC_COMPONENT_LOOSE_OBJECT },
-	{ "pack", FSYNC_COMPONENT_PACK },
-	{ "pack-metadata", FSYNC_COMPONENT_PACK_METADATA },
-	{ "commit-graph", FSYNC_COMPONENT_COMMIT_GRAPH },
-	{ "index", FSYNC_COMPONENT_INDEX },
-	{ "objects", FSYNC_COMPONENTS_OBJECTS },
-	{ "reference", FSYNC_COMPONENT_REFERENCE },
-	{ "derived-metadata", FSYNC_COMPONENTS_DERIVED_METADATA },
-	{ "committed", FSYNC_COMPONENTS_COMMITTED },
-	{ "added", FSYNC_COMPONENTS_ADDED },
-	{ "all", FSYNC_COMPONENTS_ALL },
-};
-
-static enum fsync_component parse_fsync_components(const char *var, const char *string)
-{
-	enum fsync_component current = FSYNC_COMPONENTS_PLATFORM_DEFAULT;
-	enum fsync_component positive = 0, negative = 0;
-
-	while (string) {
-		int i;
-		size_t len;
-		const char *ep;
-		int negated = 0;
-		int found = 0;
-
-		string = string + strspn(string, ", \t\n\r");
-		ep = strchrnul(string, ',');
-		len = ep - string;
-		if (!strcmp(string, "none")) {
-			current = FSYNC_COMPONENT_NONE;
-			goto next_name;
-		}
-
-		if (*string == '-') {
-			negated = 1;
-			string++;
-			len--;
-			if (!len)
-				warning(_("invalid value for variable %s"), var);
-		}
-
-		if (!len)
-			break;
-
-		for (i = 0; i < ARRAY_SIZE(fsync_component_names); ++i) {
-			const struct fsync_component_name *n = &fsync_component_names[i];
-
-			if (strncmp(n->name, string, len))
-				continue;
-
-			found = 1;
-			if (negated)
-				negative |= n->component_bits;
-			else
-				positive |= n->component_bits;
-		}
-
-		if (!found) {
-			char *component = xstrndup(string, len);
-			warning(_("ignoring unknown core.fsync component '%s'"), component);
-			free(component);
-		}
-
-next_name:
-		string = ep;
-	}
-
-	return (current & ~negative) | positive;
-}
-
 int git_config_bool_or_int(const char *name, const char *value,
 			   const struct key_value_info *kvi, int *is_bool)
 {
@@ -1393,433 +1309,6 @@ int git_config_color(char *dest, const char *var, const char *value)
 	return 0;
 }
 
-static int git_default_core_config(const char *var, const char *value,
-				   const struct config_context *ctx, void *cb)
-{
-	/* This needs a better name */
-	if (!strcmp(var, "core.filemode")) {
-		trust_executable_bit = git_config_bool(var, value);
-		return 0;
-	}
-	if (!strcmp(var, "core.trustctime")) {
-		trust_ctime = git_config_bool(var, value);
-		return 0;
-	}
-	if (!strcmp(var, "core.checkstat")) {
-		if (!value)
-			return config_error_nonbool(var);
-		if (!strcasecmp(value, "default"))
-			check_stat = 1;
-		else if (!strcasecmp(value, "minimal"))
-			check_stat = 0;
-		else
-			return error(_("invalid value for '%s': '%s'"),
-				     var, value);
-	}
-
-	if (!strcmp(var, "core.quotepath")) {
-		quote_path_fully = git_config_bool(var, value);
-		return 0;
-	}
-
-	if (!strcmp(var, "core.symlinks")) {
-		has_symlinks = git_config_bool(var, value);
-		return 0;
-	}
-
-	if (!strcmp(var, "core.ignorecase")) {
-		ignore_case = git_config_bool(var, value);
-		return 0;
-	}
-
-	if (!strcmp(var, "core.attributesfile")) {
-		FREE_AND_NULL(git_attributes_file);
-		return git_config_pathname(&git_attributes_file, var, value);
-	}
-
-	if (!strcmp(var, "core.bare")) {
-		is_bare_repository_cfg = git_config_bool(var, value);
-		return 0;
-	}
-
-	if (!strcmp(var, "core.ignorestat")) {
-		assume_unchanged = git_config_bool(var, value);
-		return 0;
-	}
-
-	if (!strcmp(var, "core.abbrev")) {
-		if (!value)
-			return config_error_nonbool(var);
-		if (!strcasecmp(value, "auto"))
-			default_abbrev = -1;
-		else if (!git_parse_maybe_bool_text(value))
-			default_abbrev = GIT_MAX_HEXSZ;
-		else {
-			int abbrev = git_config_int(var, value, ctx->kvi);
-			if (abbrev < minimum_abbrev)
-				return error(_("abbrev length out of range: %d"), abbrev);
-			default_abbrev = abbrev;
-		}
-		return 0;
-	}
-
-	if (!strcmp(var, "core.disambiguate"))
-		return set_disambiguate_hint_config(var, value);
-
-	if (!strcmp(var, "core.loosecompression")) {
-		int level = git_config_int(var, value, ctx->kvi);
-		if (level == -1)
-			level = Z_DEFAULT_COMPRESSION;
-		else if (level < 0 || level > Z_BEST_COMPRESSION)
-			die(_("bad zlib compression level %d"), level);
-		zlib_compression_level = level;
-		zlib_compression_seen = 1;
-		return 0;
-	}
-
-	if (!strcmp(var, "core.compression")) {
-		int level = git_config_int(var, value, ctx->kvi);
-		if (level == -1)
-			level = Z_DEFAULT_COMPRESSION;
-		else if (level < 0 || level > Z_BEST_COMPRESSION)
-			die(_("bad zlib compression level %d"), level);
-		if (!zlib_compression_seen)
-			zlib_compression_level = level;
-		if (!pack_compression_seen)
-			pack_compression_level = level;
-		return 0;
-	}
-
-	if (!strcmp(var, "core.autocrlf")) {
-		if (value && !strcasecmp(value, "input")) {
-			auto_crlf = AUTO_CRLF_INPUT;
-			return 0;
-		}
-		auto_crlf = git_config_bool(var, value);
-		return 0;
-	}
-
-	if (!strcmp(var, "core.safecrlf")) {
-		int eol_rndtrp_die;
-		if (value && !strcasecmp(value, "warn")) {
-			global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
-			return 0;
-		}
-		eol_rndtrp_die = git_config_bool(var, value);
-		global_conv_flags_eol = eol_rndtrp_die ?
-			CONV_EOL_RNDTRP_DIE : 0;
-		return 0;
-	}
-
-	if (!strcmp(var, "core.eol")) {
-		if (value && !strcasecmp(value, "lf"))
-			core_eol = EOL_LF;
-		else if (value && !strcasecmp(value, "crlf"))
-			core_eol = EOL_CRLF;
-		else if (value && !strcasecmp(value, "native"))
-			core_eol = EOL_NATIVE;
-		else
-			core_eol = EOL_UNSET;
-		return 0;
-	}
-
-	if (!strcmp(var, "core.checkroundtripencoding")) {
-		FREE_AND_NULL(check_roundtrip_encoding);
-		return git_config_string(&check_roundtrip_encoding, var, value);
-	}
-
-	if (!strcmp(var, "core.editor")) {
-		FREE_AND_NULL(editor_program);
-		return git_config_string(&editor_program, var, value);
-	}
-
-	if (!strcmp(var, "core.commentchar") ||
-	    !strcmp(var, "core.commentstring")) {
-		if (!value)
-			return config_error_nonbool(var);
-		else if (!strcasecmp(value, "auto"))
-			auto_comment_line_char = 1;
-		else if (value[0]) {
-			if (strchr(value, '\n'))
-				return error(_("%s cannot contain newline"), var);
-			comment_line_str = value;
-			FREE_AND_NULL(comment_line_str_to_free);
-			auto_comment_line_char = 0;
-		} else
-			return error(_("%s must have at least one character"), var);
-		return 0;
-	}
-
-	if (!strcmp(var, "core.askpass")) {
-		FREE_AND_NULL(askpass_program);
-		return git_config_string(&askpass_program, var, value);
-	}
-
-	if (!strcmp(var, "core.excludesfile")) {
-		FREE_AND_NULL(excludes_file);
-		return git_config_pathname(&excludes_file, var, value);
-	}
-
-	if (!strcmp(var, "core.whitespace")) {
-		if (!value)
-			return config_error_nonbool(var);
-		whitespace_rule_cfg = parse_whitespace_rule(value);
-		return 0;
-	}
-
-	if (!strcmp(var, "core.fsync")) {
-		if (!value)
-			return config_error_nonbool(var);
-		fsync_components = parse_fsync_components(var, value);
-		return 0;
-	}
-
-	if (!strcmp(var, "core.fsyncmethod")) {
-		if (!value)
-			return config_error_nonbool(var);
-		if (!strcmp(value, "fsync"))
-			fsync_method = FSYNC_METHOD_FSYNC;
-		else if (!strcmp(value, "writeout-only"))
-			fsync_method = FSYNC_METHOD_WRITEOUT_ONLY;
-		else if (!strcmp(value, "batch"))
-			fsync_method = FSYNC_METHOD_BATCH;
-		else
-			warning(_("ignoring unknown core.fsyncMethod value '%s'"), value);
-
-	}
-
-	if (!strcmp(var, "core.fsyncobjectfiles")) {
-		if (fsync_object_files < 0)
-			warning(_("core.fsyncObjectFiles is deprecated; use core.fsync instead"));
-		fsync_object_files = git_config_bool(var, value);
-		return 0;
-	}
-
-	if (!strcmp(var, "core.createobject")) {
-		if (!value)
-			return config_error_nonbool(var);
-		if (!strcmp(value, "rename"))
-			object_creation_mode = OBJECT_CREATION_USES_RENAMES;
-		else if (!strcmp(value, "link"))
-			object_creation_mode = OBJECT_CREATION_USES_HARDLINKS;
-		else
-			die(_("invalid mode for object creation: %s"), value);
-		return 0;
-	}
-
-	if (!strcmp(var, "core.sparsecheckout")) {
-		core_apply_sparse_checkout = git_config_bool(var, value);
-		return 0;
-	}
-
-	if (!strcmp(var, "core.sparsecheckoutcone")) {
-		core_sparse_checkout_cone = git_config_bool(var, value);
-		return 0;
-	}
-
-	if (!strcmp(var, "core.precomposeunicode")) {
-		precomposed_unicode = git_config_bool(var, value);
-		return 0;
-	}
-
-	if (!strcmp(var, "core.protecthfs")) {
-		protect_hfs = git_config_bool(var, value);
-		return 0;
-	}
-
-	if (!strcmp(var, "core.protectntfs")) {
-		protect_ntfs = git_config_bool(var, value);
-		return 0;
-	}
-
-	if (!strcmp(var, "core.maxtreedepth")) {
-		max_allowed_tree_depth = git_config_int(var, value, ctx->kvi);
-		return 0;
-	}
-
-	/* Add other config variables here and to Documentation/config.adoc. */
-	return platform_core_config(var, value, ctx, cb);
-}
-
-static int git_default_sparse_config(const char *var, const char *value)
-{
-	if (!strcmp(var, "sparse.expectfilesoutsideofpatterns")) {
-		sparse_expect_files_outside_of_patterns = git_config_bool(var, value);
-		return 0;
-	}
-
-	/* Add other config variables here and to Documentation/config/sparse.adoc. */
-	return 0;
-}
-
-static int git_default_i18n_config(const char *var, const char *value)
-{
-	if (!strcmp(var, "i18n.commitencoding")) {
-		FREE_AND_NULL(git_commit_encoding);
-		return git_config_string(&git_commit_encoding, var, value);
-	}
-
-	if (!strcmp(var, "i18n.logoutputencoding")) {
-		FREE_AND_NULL(git_log_output_encoding);
-		return git_config_string(&git_log_output_encoding, var, value);
-	}
-
-	/* Add other config variables here and to Documentation/config.adoc. */
-	return 0;
-}
-
-static int git_default_branch_config(const char *var, const char *value)
-{
-	if (!strcmp(var, "branch.autosetupmerge")) {
-		if (value && !strcmp(value, "always")) {
-			git_branch_track = BRANCH_TRACK_ALWAYS;
-			return 0;
-		} else if (value && !strcmp(value, "inherit")) {
-			git_branch_track = BRANCH_TRACK_INHERIT;
-			return 0;
-		} else if (value && !strcmp(value, "simple")) {
-			git_branch_track = BRANCH_TRACK_SIMPLE;
-			return 0;
-		}
-		git_branch_track = git_config_bool(var, value);
-		return 0;
-	}
-	if (!strcmp(var, "branch.autosetuprebase")) {
-		if (!value)
-			return config_error_nonbool(var);
-		else if (!strcmp(value, "never"))
-			autorebase = AUTOREBASE_NEVER;
-		else if (!strcmp(value, "local"))
-			autorebase = AUTOREBASE_LOCAL;
-		else if (!strcmp(value, "remote"))
-			autorebase = AUTOREBASE_REMOTE;
-		else if (!strcmp(value, "always"))
-			autorebase = AUTOREBASE_ALWAYS;
-		else
-			return error(_("malformed value for %s"), var);
-		return 0;
-	}
-
-	/* Add other config variables here and to Documentation/config.adoc. */
-	return 0;
-}
-
-static int git_default_push_config(const char *var, const char *value)
-{
-	if (!strcmp(var, "push.default")) {
-		if (!value)
-			return config_error_nonbool(var);
-		else if (!strcmp(value, "nothing"))
-			push_default = PUSH_DEFAULT_NOTHING;
-		else if (!strcmp(value, "matching"))
-			push_default = PUSH_DEFAULT_MATCHING;
-		else if (!strcmp(value, "simple"))
-			push_default = PUSH_DEFAULT_SIMPLE;
-		else if (!strcmp(value, "upstream"))
-			push_default = PUSH_DEFAULT_UPSTREAM;
-		else if (!strcmp(value, "tracking")) /* deprecated */
-			push_default = PUSH_DEFAULT_UPSTREAM;
-		else if (!strcmp(value, "current"))
-			push_default = PUSH_DEFAULT_CURRENT;
-		else {
-			error(_("malformed value for %s: %s"), var, value);
-			return error(_("must be one of nothing, matching, simple, "
-				       "upstream or current"));
-		}
-		return 0;
-	}
-
-	/* Add other config variables here and to Documentation/config.adoc. */
-	return 0;
-}
-
-static int git_default_mailmap_config(const char *var, const char *value)
-{
-	if (!strcmp(var, "mailmap.file")) {
-		FREE_AND_NULL(git_mailmap_file);
-		return git_config_pathname(&git_mailmap_file, var, value);
-	}
-
-	if (!strcmp(var, "mailmap.blob")) {
-		FREE_AND_NULL(git_mailmap_blob);
-		return git_config_string(&git_mailmap_blob, var, value);
-	}
-
-	/* Add other config variables here and to Documentation/config.adoc. */
-	return 0;
-}
-
-static int git_default_attr_config(const char *var, const char *value)
-{
-	if (!strcmp(var, "attr.tree")) {
-		FREE_AND_NULL(git_attr_tree);
-		return git_config_string(&git_attr_tree, var, value);
-	}
-
-	/*
-	 * Add other attribute related config variables here and to
-	 * Documentation/config/attr.adoc.
-	 */
-	return 0;
-}
-
-int git_default_config(const char *var, const char *value,
-		       const struct config_context *ctx, void *cb)
-{
-	if (starts_with(var, "core."))
-		return git_default_core_config(var, value, ctx, cb);
-
-	if (starts_with(var, "user.") ||
-	    starts_with(var, "author.") ||
-	    starts_with(var, "committer."))
-		return git_ident_config(var, value, ctx, cb);
-
-	if (starts_with(var, "i18n."))
-		return git_default_i18n_config(var, value);
-
-	if (starts_with(var, "branch."))
-		return git_default_branch_config(var, value);
-
-	if (starts_with(var, "push."))
-		return git_default_push_config(var, value);
-
-	if (starts_with(var, "mailmap."))
-		return git_default_mailmap_config(var, value);
-
-	if (starts_with(var, "attr."))
-		return git_default_attr_config(var, value);
-
-	if (starts_with(var, "advice.") || starts_with(var, "color.advice"))
-		return git_default_advice_config(var, value);
-
-	if (!strcmp(var, "pager.color") || !strcmp(var, "color.pager")) {
-		pager_use_color = git_config_bool(var,value);
-		return 0;
-	}
-
-	if (!strcmp(var, "pack.packsizelimit")) {
-		pack_size_limit_cfg = git_config_ulong(var, value, ctx->kvi);
-		return 0;
-	}
-
-	if (!strcmp(var, "pack.compression")) {
-		int level = git_config_int(var, value, ctx->kvi);
-		if (level == -1)
-			level = Z_DEFAULT_COMPRESSION;
-		else if (level < 0 || level > Z_BEST_COMPRESSION)
-			die(_("bad pack compression level %d"), level);
-		pack_compression_level = level;
-		pack_compression_seen = 1;
-		return 0;
-	}
-
-	if (starts_with(var, "sparse."))
-		return git_default_sparse_config(var, value);
-
-	/* Add other config variables here and to Documentation/config.adoc. */
-	return 0;
-}
-
 /*
  * All source specific fields in the union, die_on_error, name and the callbacks
  * fgetc, ungetc, ftell of top need to be initialized before calling
diff --git a/config.h b/config.h
index 87baf8eeffe..65fc47966e6 100644
--- a/config.h
+++ b/config.h
@@ -165,9 +165,6 @@ struct config_context {
 typedef int (*config_fn_t)(const char *, const char *,
 			   const struct config_context *, void *);
 
-int git_default_config(const char *, const char *,
-		       const struct config_context *, void *);
-
 /**
  * Read a specific file in git-config format.
  * This function takes the same callback and data parameters as `repo_config`.
diff --git a/environment.c b/environment.c
index 7c2480b22e5..ae1427bb9e8 100644
--- a/environment.c
+++ b/environment.c
@@ -12,22 +12,34 @@
 
 #include "git-compat-util.h"
 #include "abspath.h"
+#include "advice.h"
+#include "attr.h"
 #include "branch.h"
+#include "color.h"
 #include "convert.h"
 #include "environment.h"
 #include "gettext.h"
 #include "git-zlib.h"
+#include "ident.h"
+#include "mailmap.h"
+#include "object-name.h"
 #include "repository.h"
 #include "config.h"
 #include "refs.h"
 #include "fmt-merge-msg.h"
 #include "commit.h"
 #include "strvec.h"
+#include "pager.h"
 #include "path.h"
+#include "quote.h"
 #include "chdir-notify.h"
 #include "setup.h"
+#include "ws.h"
 #include "write-or-die.h"
 
+static int pack_compression_seen;
+static int zlib_compression_seen;
+
 int trust_executable_bit = 1;
 int trust_ctime = 1;
 int check_stat = 1;
@@ -231,3 +243,503 @@ int print_sha1_ellipsis(void)
 	}
 	return cached_result;
 }
+
+static const struct fsync_component_name {
+	const char *name;
+	enum fsync_component component_bits;
+} fsync_component_names[] = {
+	{ "loose-object", FSYNC_COMPONENT_LOOSE_OBJECT },
+	{ "pack", FSYNC_COMPONENT_PACK },
+	{ "pack-metadata", FSYNC_COMPONENT_PACK_METADATA },
+	{ "commit-graph", FSYNC_COMPONENT_COMMIT_GRAPH },
+	{ "index", FSYNC_COMPONENT_INDEX },
+	{ "objects", FSYNC_COMPONENTS_OBJECTS },
+	{ "reference", FSYNC_COMPONENT_REFERENCE },
+	{ "derived-metadata", FSYNC_COMPONENTS_DERIVED_METADATA },
+	{ "committed", FSYNC_COMPONENTS_COMMITTED },
+	{ "added", FSYNC_COMPONENTS_ADDED },
+	{ "all", FSYNC_COMPONENTS_ALL },
+};
+
+static enum fsync_component parse_fsync_components(const char *var, const char *string)
+{
+	enum fsync_component current = FSYNC_COMPONENTS_PLATFORM_DEFAULT;
+	enum fsync_component positive = 0, negative = 0;
+
+	while (string) {
+		size_t len;
+		const char *ep;
+		int negated = 0;
+		int found = 0;
+
+		string = string + strspn(string, ", \t\n\r");
+		ep = strchrnul(string, ',');
+		len = ep - string;
+		if (!strcmp(string, "none")) {
+			current = FSYNC_COMPONENT_NONE;
+			goto next_name;
+		}
+
+		if (*string == '-') {
+			negated = 1;
+			string++;
+			len--;
+			if (!len)
+				warning(_("invalid value for variable %s"), var);
+		}
+
+		if (!len)
+			break;
+
+		for (size_t i = 0; i < ARRAY_SIZE(fsync_component_names); ++i) {
+			const struct fsync_component_name *n = &fsync_component_names[i];
+
+			if (strncmp(n->name, string, len))
+				continue;
+
+			found = 1;
+			if (negated)
+				negative |= n->component_bits;
+			else
+				positive |= n->component_bits;
+		}
+
+		if (!found) {
+			char *component = xstrndup(string, len);
+			warning(_("ignoring unknown core.fsync component '%s'"), component);
+			free(component);
+		}
+
+next_name:
+		string = ep;
+	}
+
+	return (current & ~negative) | positive;
+}
+
+static int git_default_core_config(const char *var, const char *value,
+				   const struct config_context *ctx, void *cb)
+{
+	/* This needs a better name */
+	if (!strcmp(var, "core.filemode")) {
+		trust_executable_bit = git_config_bool(var, value);
+		return 0;
+	}
+	if (!strcmp(var, "core.trustctime")) {
+		trust_ctime = git_config_bool(var, value);
+		return 0;
+	}
+	if (!strcmp(var, "core.checkstat")) {
+		if (!value)
+			return config_error_nonbool(var);
+		if (!strcasecmp(value, "default"))
+			check_stat = 1;
+		else if (!strcasecmp(value, "minimal"))
+			check_stat = 0;
+		else
+			return error(_("invalid value for '%s': '%s'"),
+				     var, value);
+	}
+
+	if (!strcmp(var, "core.quotepath")) {
+		quote_path_fully = git_config_bool(var, value);
+		return 0;
+	}
+
+	if (!strcmp(var, "core.symlinks")) {
+		has_symlinks = git_config_bool(var, value);
+		return 0;
+	}
+
+	if (!strcmp(var, "core.ignorecase")) {
+		ignore_case = git_config_bool(var, value);
+		return 0;
+	}
+
+	if (!strcmp(var, "core.attributesfile")) {
+		FREE_AND_NULL(git_attributes_file);
+		return git_config_pathname(&git_attributes_file, var, value);
+	}
+
+	if (!strcmp(var, "core.bare")) {
+		is_bare_repository_cfg = git_config_bool(var, value);
+		return 0;
+	}
+
+	if (!strcmp(var, "core.ignorestat")) {
+		assume_unchanged = git_config_bool(var, value);
+		return 0;
+	}
+
+	if (!strcmp(var, "core.abbrev")) {
+		if (!value)
+			return config_error_nonbool(var);
+		if (!strcasecmp(value, "auto"))
+			default_abbrev = -1;
+		else if (!git_parse_maybe_bool_text(value))
+			default_abbrev = GIT_MAX_HEXSZ;
+		else {
+			int abbrev = git_config_int(var, value, ctx->kvi);
+			if (abbrev < minimum_abbrev)
+				return error(_("abbrev length out of range: %d"), abbrev);
+			default_abbrev = abbrev;
+		}
+		return 0;
+	}
+
+	if (!strcmp(var, "core.disambiguate"))
+		return set_disambiguate_hint_config(var, value);
+
+	if (!strcmp(var, "core.loosecompression")) {
+		int level = git_config_int(var, value, ctx->kvi);
+		if (level == -1)
+			level = Z_DEFAULT_COMPRESSION;
+		else if (level < 0 || level > Z_BEST_COMPRESSION)
+			die(_("bad zlib compression level %d"), level);
+		zlib_compression_level = level;
+		zlib_compression_seen = 1;
+		return 0;
+	}
+
+	if (!strcmp(var, "core.compression")) {
+		int level = git_config_int(var, value, ctx->kvi);
+		if (level == -1)
+			level = Z_DEFAULT_COMPRESSION;
+		else if (level < 0 || level > Z_BEST_COMPRESSION)
+			die(_("bad zlib compression level %d"), level);
+		if (!zlib_compression_seen)
+			zlib_compression_level = level;
+		if (!pack_compression_seen)
+			pack_compression_level = level;
+		return 0;
+	}
+
+	if (!strcmp(var, "core.autocrlf")) {
+		if (value && !strcasecmp(value, "input")) {
+			auto_crlf = AUTO_CRLF_INPUT;
+			return 0;
+		}
+		auto_crlf = git_config_bool(var, value);
+		return 0;
+	}
+
+	if (!strcmp(var, "core.safecrlf")) {
+		int eol_rndtrp_die;
+		if (value && !strcasecmp(value, "warn")) {
+			global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
+			return 0;
+		}
+		eol_rndtrp_die = git_config_bool(var, value);
+		global_conv_flags_eol = eol_rndtrp_die ?
+			CONV_EOL_RNDTRP_DIE : 0;
+		return 0;
+	}
+
+	if (!strcmp(var, "core.eol")) {
+		if (value && !strcasecmp(value, "lf"))
+			core_eol = EOL_LF;
+		else if (value && !strcasecmp(value, "crlf"))
+			core_eol = EOL_CRLF;
+		else if (value && !strcasecmp(value, "native"))
+			core_eol = EOL_NATIVE;
+		else
+			core_eol = EOL_UNSET;
+		return 0;
+	}
+
+	if (!strcmp(var, "core.checkroundtripencoding")) {
+		FREE_AND_NULL(check_roundtrip_encoding);
+		return git_config_string(&check_roundtrip_encoding, var, value);
+	}
+
+	if (!strcmp(var, "core.editor")) {
+		FREE_AND_NULL(editor_program);
+		return git_config_string(&editor_program, var, value);
+	}
+
+	if (!strcmp(var, "core.commentchar") ||
+	    !strcmp(var, "core.commentstring")) {
+		if (!value)
+			return config_error_nonbool(var);
+		else if (!strcasecmp(value, "auto"))
+			auto_comment_line_char = 1;
+		else if (value[0]) {
+			if (strchr(value, '\n'))
+				return error(_("%s cannot contain newline"), var);
+			comment_line_str = value;
+			FREE_AND_NULL(comment_line_str_to_free);
+			auto_comment_line_char = 0;
+		} else
+			return error(_("%s must have at least one character"), var);
+		return 0;
+	}
+
+	if (!strcmp(var, "core.askpass")) {
+		FREE_AND_NULL(askpass_program);
+		return git_config_string(&askpass_program, var, value);
+	}
+
+	if (!strcmp(var, "core.excludesfile")) {
+		FREE_AND_NULL(excludes_file);
+		return git_config_pathname(&excludes_file, var, value);
+	}
+
+	if (!strcmp(var, "core.whitespace")) {
+		if (!value)
+			return config_error_nonbool(var);
+		whitespace_rule_cfg = parse_whitespace_rule(value);
+		return 0;
+	}
+
+	if (!strcmp(var, "core.fsync")) {
+		if (!value)
+			return config_error_nonbool(var);
+		fsync_components = parse_fsync_components(var, value);
+		return 0;
+	}
+
+	if (!strcmp(var, "core.fsyncmethod")) {
+		if (!value)
+			return config_error_nonbool(var);
+		if (!strcmp(value, "fsync"))
+			fsync_method = FSYNC_METHOD_FSYNC;
+		else if (!strcmp(value, "writeout-only"))
+			fsync_method = FSYNC_METHOD_WRITEOUT_ONLY;
+		else if (!strcmp(value, "batch"))
+			fsync_method = FSYNC_METHOD_BATCH;
+		else
+			warning(_("ignoring unknown core.fsyncMethod value '%s'"), value);
+
+	}
+
+	if (!strcmp(var, "core.fsyncobjectfiles")) {
+		if (fsync_object_files < 0)
+			warning(_("core.fsyncObjectFiles is deprecated; use core.fsync instead"));
+		fsync_object_files = git_config_bool(var, value);
+		return 0;
+	}
+
+	if (!strcmp(var, "core.createobject")) {
+		if (!value)
+			return config_error_nonbool(var);
+		if (!strcmp(value, "rename"))
+			object_creation_mode = OBJECT_CREATION_USES_RENAMES;
+		else if (!strcmp(value, "link"))
+			object_creation_mode = OBJECT_CREATION_USES_HARDLINKS;
+		else
+			die(_("invalid mode for object creation: %s"), value);
+		return 0;
+	}
+
+	if (!strcmp(var, "core.sparsecheckout")) {
+		core_apply_sparse_checkout = git_config_bool(var, value);
+		return 0;
+	}
+
+	if (!strcmp(var, "core.sparsecheckoutcone")) {
+		core_sparse_checkout_cone = git_config_bool(var, value);
+		return 0;
+	}
+
+	if (!strcmp(var, "core.precomposeunicode")) {
+		precomposed_unicode = git_config_bool(var, value);
+		return 0;
+	}
+
+	if (!strcmp(var, "core.protecthfs")) {
+		protect_hfs = git_config_bool(var, value);
+		return 0;
+	}
+
+	if (!strcmp(var, "core.protectntfs")) {
+		protect_ntfs = git_config_bool(var, value);
+		return 0;
+	}
+
+	if (!strcmp(var, "core.maxtreedepth")) {
+		max_allowed_tree_depth = git_config_int(var, value, ctx->kvi);
+		return 0;
+	}
+
+	/* Add other config variables here and to Documentation/config.adoc. */
+	return platform_core_config(var, value, ctx, cb);
+}
+
+static int git_default_sparse_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "sparse.expectfilesoutsideofpatterns")) {
+		sparse_expect_files_outside_of_patterns = git_config_bool(var, value);
+		return 0;
+	}
+
+	/* Add other config variables here and to Documentation/config/sparse.adoc. */
+	return 0;
+}
+
+static int git_default_i18n_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "i18n.commitencoding")) {
+		FREE_AND_NULL(git_commit_encoding);
+		return git_config_string(&git_commit_encoding, var, value);
+	}
+
+	if (!strcmp(var, "i18n.logoutputencoding")) {
+		FREE_AND_NULL(git_log_output_encoding);
+		return git_config_string(&git_log_output_encoding, var, value);
+	}
+
+	/* Add other config variables here and to Documentation/config.adoc. */
+	return 0;
+}
+
+static int git_default_branch_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "branch.autosetupmerge")) {
+		if (value && !strcmp(value, "always")) {
+			git_branch_track = BRANCH_TRACK_ALWAYS;
+			return 0;
+		} else if (value && !strcmp(value, "inherit")) {
+			git_branch_track = BRANCH_TRACK_INHERIT;
+			return 0;
+		} else if (value && !strcmp(value, "simple")) {
+			git_branch_track = BRANCH_TRACK_SIMPLE;
+			return 0;
+		}
+		git_branch_track = git_config_bool(var, value);
+		return 0;
+	}
+	if (!strcmp(var, "branch.autosetuprebase")) {
+		if (!value)
+			return config_error_nonbool(var);
+		else if (!strcmp(value, "never"))
+			autorebase = AUTOREBASE_NEVER;
+		else if (!strcmp(value, "local"))
+			autorebase = AUTOREBASE_LOCAL;
+		else if (!strcmp(value, "remote"))
+			autorebase = AUTOREBASE_REMOTE;
+		else if (!strcmp(value, "always"))
+			autorebase = AUTOREBASE_ALWAYS;
+		else
+			return error(_("malformed value for %s"), var);
+		return 0;
+	}
+
+	/* Add other config variables here and to Documentation/config.adoc. */
+	return 0;
+}
+
+static int git_default_push_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "push.default")) {
+		if (!value)
+			return config_error_nonbool(var);
+		else if (!strcmp(value, "nothing"))
+			push_default = PUSH_DEFAULT_NOTHING;
+		else if (!strcmp(value, "matching"))
+			push_default = PUSH_DEFAULT_MATCHING;
+		else if (!strcmp(value, "simple"))
+			push_default = PUSH_DEFAULT_SIMPLE;
+		else if (!strcmp(value, "upstream"))
+			push_default = PUSH_DEFAULT_UPSTREAM;
+		else if (!strcmp(value, "tracking")) /* deprecated */
+			push_default = PUSH_DEFAULT_UPSTREAM;
+		else if (!strcmp(value, "current"))
+			push_default = PUSH_DEFAULT_CURRENT;
+		else {
+			error(_("malformed value for %s: %s"), var, value);
+			return error(_("must be one of nothing, matching, simple, "
+				       "upstream or current"));
+		}
+		return 0;
+	}
+
+	/* Add other config variables here and to Documentation/config.adoc. */
+	return 0;
+}
+
+static int git_default_mailmap_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "mailmap.file")) {
+		FREE_AND_NULL(git_mailmap_file);
+		return git_config_pathname(&git_mailmap_file, var, value);
+	}
+
+	if (!strcmp(var, "mailmap.blob")) {
+		FREE_AND_NULL(git_mailmap_blob);
+		return git_config_string(&git_mailmap_blob, var, value);
+	}
+
+	/* Add other config variables here and to Documentation/config.adoc. */
+	return 0;
+}
+
+static int git_default_attr_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "attr.tree")) {
+		FREE_AND_NULL(git_attr_tree);
+		return git_config_string(&git_attr_tree, var, value);
+	}
+
+	/*
+	 * Add other attribute related config variables here and to
+	 * Documentation/config/attr.adoc.
+	 */
+	return 0;
+}
+
+int git_default_config(const char *var, const char *value,
+		       const struct config_context *ctx, void *cb)
+{
+	if (starts_with(var, "core."))
+		return git_default_core_config(var, value, ctx, cb);
+
+	if (starts_with(var, "user.") ||
+	    starts_with(var, "author.") ||
+	    starts_with(var, "committer."))
+		return git_ident_config(var, value, ctx, cb);
+
+	if (starts_with(var, "i18n."))
+		return git_default_i18n_config(var, value);
+
+	if (starts_with(var, "branch."))
+		return git_default_branch_config(var, value);
+
+	if (starts_with(var, "push."))
+		return git_default_push_config(var, value);
+
+	if (starts_with(var, "mailmap."))
+		return git_default_mailmap_config(var, value);
+
+	if (starts_with(var, "attr."))
+		return git_default_attr_config(var, value);
+
+	if (starts_with(var, "advice.") || starts_with(var, "color.advice"))
+		return git_default_advice_config(var, value);
+
+	if (!strcmp(var, "pager.color") || !strcmp(var, "color.pager")) {
+		pager_use_color = git_config_bool(var,value);
+		return 0;
+	}
+
+	if (!strcmp(var, "pack.packsizelimit")) {
+		pack_size_limit_cfg = git_config_ulong(var, value, ctx->kvi);
+		return 0;
+	}
+
+	if (!strcmp(var, "pack.compression")) {
+		int level = git_config_int(var, value, ctx->kvi);
+		if (level == -1)
+			level = Z_DEFAULT_COMPRESSION;
+		else if (level < 0 || level > Z_BEST_COMPRESSION)
+			die(_("bad pack compression level %d"), level);
+		pack_compression_level = level;
+		pack_compression_seen = 1;
+		return 0;
+	}
+
+	if (starts_with(var, "sparse."))
+		return git_default_sparse_config(var, value);
+
+	/* Add other config variables here and to Documentation/config.adoc. */
+	return 0;
+}
diff --git a/environment.h b/environment.h
index 3d806ced6e4..8cfce41015b 100644
--- a/environment.h
+++ b/environment.h
@@ -104,6 +104,9 @@ int use_optional_locks(void);
 const char *get_git_namespace(void);
 const char *strip_namespace(const char *namespaced_ref);
 
+int git_default_config(const char *, const char *,
+		       const struct config_context *, void *);
+
 /*
  * TODO: All the below state either explicitly or implicitly relies on
  * `the_repository`. We should eventually get rid of these and make the
diff --git a/fsck.c b/fsck.c
index 23965e1880f..171b424dd57 100644
--- a/fsck.c
+++ b/fsck.c
@@ -3,6 +3,7 @@
 #include "git-compat-util.h"
 #include "date.h"
 #include "dir.h"
+#include "environment.h"
 #include "hex.h"
 #include "odb.h"
 #include "path.h"
diff --git a/http-fetch.c b/http-fetch.c
index 17b9fe4ff8c..1922e23fcd3 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -2,6 +2,7 @@
 
 #include "git-compat-util.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "http.h"
diff --git a/http.c b/http.c
index d94e8f63b57..33ae9429fd8 100644
--- a/http.c
+++ b/http.c
@@ -3,6 +3,7 @@
 
 #include "git-compat-util.h"
 #include "git-curl-compat.h"
+#include "environment.h"
 #include "hex.h"
 #include "http.h"
 #include "config.h"
diff --git a/imap-send.c b/imap-send.c
index 9b26c669c01..254ec83ab78 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -28,6 +28,7 @@
 #include "advice.h"
 #include "config.h"
 #include "credential.h"
+#include "environment.h"
 #include "gettext.h"
 #include "run-command.h"
 #include "parse-options.h"
diff --git a/mailinfo.c b/mailinfo.c
index b4e815b2d8b..99ac596e096 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -2,6 +2,7 @@
 
 #include "git-compat-util.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex-ll.h"
 #include "utf8.h"
diff --git a/reflog.c b/reflog.c
index 39c205fd26e..a9740051346 100644
--- a/reflog.c
+++ b/reflog.c
@@ -3,6 +3,7 @@
 
 #include "git-compat-util.h"
 #include "config.h"
+#include "environment.h"
 #include "gettext.h"
 #include "parse-options.h"
 #include "odb.h"
diff --git a/rerere.c b/rerere.c
index c7c3e535ce5..6ec55964e2a 100644
--- a/rerere.c
+++ b/rerere.c
@@ -5,6 +5,7 @@
 #include "abspath.h"
 #include "config.h"
 #include "copy.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
diff --git a/t/helper/test-advise.c b/t/helper/test-advise.c
index 77c15a46cfa..81ed93a05c9 100644
--- a/t/helper/test-advise.c
+++ b/t/helper/test-advise.c
@@ -3,6 +3,7 @@
 #include "test-tool.h"
 #include "advice.h"
 #include "config.h"
+#include "environment.h"
 #include "setup.h"
 
 int cmd__advise_if_enabled(int argc, const char **argv)
diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index b2da48eda05..9ae71cefb30 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -2,6 +2,7 @@
 
 #include "test-tool.h"
 #include "config.h"
+#include "environment.h"
 #include "read-cache-ll.h"
 #include "repository.h"
 #include "setup.h"
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 0e5d38c9600..4971f722b3e 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -2,6 +2,7 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
+#include "environment.h"
 #include "gettext.h"
 #include "config.h"
 #include "hex.h"

-- 
2.50.1.465.gcb3da1c9e6.dirty

