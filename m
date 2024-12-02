Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D12204F98
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 12:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733141107; cv=none; b=e9RniQyjqz+DlivXHce2r/DiwNjzYnLcZsggfwMpEJNaFZfH8CgX1GedEJ1QFcU4vCR4/EcArFD8oZZjysK0+IY4uS3CYtvK959SJO0Cn0Qd2Z7iE4K5EZ32ZzgORloPCrKjkWn4NNWXs6tgAYzragAv/3r+ykCMZUSyEYUWK2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733141107; c=relaxed/simple;
	bh=jjE7v03anAbDM+XIrWeTR3hgX06xZUZMI2sNg+tcuq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qI0OUSrk+WM55KMXbdjcLqfRulfmGHn9yP1dhTAgjhPO8/xyUeVGglqoORerPgX70VslsNca/GkyAmgpuK3yTN1gLoe/0zuqZEDm3di/kG5NFrMdeVIpzDxxbAOAdU3zI5fOllFuaqxm7j6ieXYzPXHfhj8UnEDiJ79eg7lsZ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=v8sWsxi0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yrOXlsji; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="v8sWsxi0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yrOXlsji"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 79FB1114017D;
	Mon,  2 Dec 2024 07:05:04 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 02 Dec 2024 07:05:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733141104;
	 x=1733227504; bh=VUjA9K+GBhfnEXU+cBQd6ymBpBV3g5nZyap4T9FHWrs=; b=
	v8sWsxi0OUjKZcHDl5y2/74DXCPqO2XyLh3XXN800URhbx2aOtSu1E70/9Smffr8
	cToViFWhdqhE1ZwyQViuWJNRgfWfQQHw/Sc29AwT0Ik2fe8Cy0l61jgJD+BKFP4s
	5MWjK9aPUUTbMVHvOTawYFMt/Ly00A37tFwpkMw0KCb7m0JEhosq1l3HqUuyF4ES
	zb5GiLuY51ZWT2yZYEIaZfDXrvC52Q/2vislTvBNZfS9+mWnaWqp4vmJ5AXnSauy
	4Ht4Za21+fX0s8dFWV5QnOIldFzrOMD9hX4InP8E95eN+/hEDfeJQD0HJDTevKlc
	ZLV6tW3r4s+AGWou06cCAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733141104; x=
	1733227504; bh=VUjA9K+GBhfnEXU+cBQd6ymBpBV3g5nZyap4T9FHWrs=; b=y
	rOXlsjiBZq5fetXxsIDRR2NIZDbNpGWF1tQ2AGKh5qQsrmIUCaxJukRrfEYmImNb
	ukKB0ZLUZP1645lrJIGQ6eN3IVA6n3+YUHqlspZVPIQNve5UqjISaqNOMJ9Tf2CX
	r1V/v5+n877H654n7jdlZuDFkjRgb2phdy1VDdv6Gag9oLKxrbJ43ZGBssWYN3+3
	MTewuU+4Sz9c/mMIROFI0ZxRxhVppZiKhO8A+RoMb2/pKUMQ1L70i8eUJtgCbZeM
	iBzUMgs3L88Gj411WLrqSZiS1OTrrVjQnex8cdk89gLLdz+UQsDIBkbo8KkCmBsr
	OCr4cy3LMRcxBd0KS2i4g==
X-ME-Sender: <xms:b6JNZ6udZ273mX6BolhZQAQRmGgbHD7vAjyEUiSM2QlRYmLyrMfJdQ>
    <xme:b6JNZ_ffXwUCUdUWOE5cRQK3gRQyFOfT-08T_UEiR8PqVMGTUisPGAP1iK273e2wW
    VSgcI1BGy7YiWJu0A>
X-ME-Received: <xmr:b6JNZ1yeHg6O3Cgkc5ZqDWTX1UWQWN6ljAPW3PGYeX24P_fJNTi73Eg14K4LHKhMlIKXWzBI1ob7XGmPl-fU4oQsaL0-nxja8pzvwmqvloCqmGukrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheelgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhi
    rghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:cKJNZ1OBA49tYTDxgiZ46SNLd4ZyDZnGGi4lhaa-eGYedTmBoUgN4g>
    <xmx:cKJNZ69mdnk64XLDFDQVMVGGy2wefy5KjawF58U4HIEcjG7BzhuzUA>
    <xmx:cKJNZ9WO5QN1BO1hzglmZpHnpv_hYglXEKkljNgvNG7yB71Qr6bH1g>
    <xmx:cKJNZzfACry5MR6cE9pKnMxcYRoMwj_yrpxuEbCuDwKklRdruwnRgw>
    <xmx:cKJNZxYav-mbc1qNWLlXKGzdveQcnBilRyg4NoNSnPDetlr9HIUygo0e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 07:05:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d70c4f08 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Dec 2024 12:03:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Dec 2024 13:04:38 +0100
Subject: [PATCH v2 06/14] diff.h: fix index used to loop through unsigned
 integer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-pks-sign-compare-v2-6-e7f0ad92a749@pks.im>
References: <20241202-pks-sign-compare-v2-0-e7f0ad92a749@pks.im>
In-Reply-To: <20241202-pks-sign-compare-v2-0-e7f0ad92a749@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

The `struct diff_flags` structure is essentially an array of flags, all
of which have the same type. We can thus use `sizeof()` to iterate
through all of the flags, which we do in `diff_flags_or()`. But while
the statement returns an unsigned integer, we used a signed integer to
iterate through the flags, which generates a warning.

Fix this by using `size_t` for the index instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/am.c                     | 1 -
 builtin/diff-tree.c              | 1 -
 builtin/merge-ours.c             | 1 -
 builtin/pack-refs.c              | 1 -
 builtin/range-diff.c             | 1 -
 builtin/reflog.c                 | 1 -
 builtin/reset.c                  | 1 -
 builtin/revert.c                 | 1 -
 builtin/shortlog.c               | 1 -
 diff-merges.c                    | 2 --
 diff.h                           | 3 +--
 diffcore-order.c                 | 2 --
 diffcore-rotate.c                | 2 --
 list-objects-filter.c            | 1 -
 patch-ids.c                      | 2 --
 reachable.c                      | 1 -
 reflog-walk.c                    | 1 -
 t/helper/test-revision-walking.c | 1 -
 18 files changed, 1 insertion(+), 23 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index f3b6546b3049a90fe32801087151e992623e7f17..1338b606febdde6700c573b45f89aa70785f54e8 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -5,7 +5,6 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
 #include "abspath.h"
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index a4df2d0c130392f74b4da38dc5d0cd493d88f0e4..40804e7b48e319f6618cd22ac3695ce510b5f51a 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
 #include "config.h"
diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
index 3672c6353f3219c48a2f10f9011cdd48d702265f..3ecd9172f18466823ad867ca28958c12a3266b85 100644
--- a/builtin/merge-ours.c
+++ b/builtin/merge-ours.c
@@ -9,7 +9,6 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "builtin.h"
diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index 71175a713a07a1e89050a869c92bd472bea15f87..4fdd68880e0c6d30ca77df1e5f0f2e3f5117097e 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
 #include "config.h"
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index aa88a46d9ee3fcc61817834c770b3de352d78e7a..433c305fc5fc3a5f9ba3515430311338f3bf13c3 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
 #include "gettext.h"
diff --git a/builtin/reflog.c b/builtin/reflog.c
index d2bda133adf6b1e7e23d9347db51cb496eaecacc..62ea0525470c51b06c6fa5e0861dad3b7ec49230 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
 #include "config.h"
diff --git a/builtin/reset.c b/builtin/reset.c
index f34d22190f489fb522fb70584ae2d777a895afbf..73b4537a9a567d1a7661fed89ed362d0f0c81c0d 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -9,7 +9,6 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
 #include "advice.h"
diff --git a/builtin/revert.c b/builtin/revert.c
index 4b57c2c38378e02342e678cb8936b80637b98c5e..aca6c293cdfb2f1ca119f6336b56e36eb3f9dfbf 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "builtin.h"
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 1c46f13a16346c9a3ba41a92e0aec0428179b939..30075b67be8dac2db7aba793a818f357c7c11cc1 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
 #include "config.h"
diff --git a/diff-merges.c b/diff-merges.c
index 0adfe7f5c06b586500361f47ed0d05124c8c9f70..45507588a2797b8d3618e3a19a2854d12051157b 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -1,5 +1,3 @@
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "git-compat-util.h"
 #include "diff-merges.h"
 
diff --git a/diff.h b/diff.h
index 5c8de795353f0a7201e1a5aa7b6c241dd2bb17ad..6e6007c17b01ada6eab3cb54e94b34b781335348 100644
--- a/diff.h
+++ b/diff.h
@@ -205,9 +205,8 @@ static inline void diff_flags_or(struct diff_flags *a,
 {
 	char *tmp_a = (char *)a;
 	const char *tmp_b = (const char *)b;
-	int i;
 
-	for (i = 0; i < sizeof(struct diff_flags); i++)
+	for (size_t i = 0; i < sizeof(struct diff_flags); i++)
 		tmp_a[i] |= tmp_b[i];
 }
 
diff --git a/diffcore-order.c b/diffcore-order.c
index ec59d3d9bcc85753352f5faba7982da1c4455b95..f91ef2247145a6157196fb6ebb063bc98d2c3e87 100644
--- a/diffcore-order.c
+++ b/diffcore-order.c
@@ -2,8 +2,6 @@
  * Copyright (C) 2005 Junio C Hamano
  */
 
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "diff.h"
diff --git a/diffcore-rotate.c b/diffcore-rotate.c
index 941a022d5e6e79592967166f1ffc7fcd62086010..67b591261adcc66ef8ab51df9677851564597d17 100644
--- a/diffcore-rotate.c
+++ b/diffcore-rotate.c
@@ -3,8 +3,6 @@
  * Based on diffcore-order.c, which is Copyright (C) 2005, Junio C Hamano
  */
 
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "diff.h"
diff --git a/list-objects-filter.c b/list-objects-filter.c
index 4afa3029dca926baff81fba4a553b31dfed551a1..dc598a081bb25283a1f0d287baf3805da2955106 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "dir.h"
diff --git a/patch-ids.c b/patch-ids.c
index 8b891980732fd33f89bb8b1ef1bf9ad6717120ec..a5683b462c6e7692ceff3218213b9747a9b6cc02 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -1,5 +1,3 @@
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "git-compat-util.h"
 #include "diff.h"
 #include "commit.h"
diff --git a/reachable.c b/reachable.c
index 34079e1ae9b20313c86c7962f518aa266b7153ea..3e9b3dd0a46cb410b8f032784115c78084c5dbd9 100644
--- a/reachable.c
+++ b/reachable.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "gettext.h"
diff --git a/reflog-walk.c b/reflog-walk.c
index b53628ed5372235d840ce481d22a90cf10ad5c8a..c7070b13b004b7c207a3f99740999f582c15c1b0 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "commit.h"
diff --git a/t/helper/test-revision-walking.c b/t/helper/test-revision-walking.c
index 3b931a34a2a2198287fb7f0175ac11e6f2ba0059..071f5bd1e21974ba2104a76305a5156ee2c2961f 100644
--- a/t/helper/test-revision-walking.c
+++ b/t/helper/test-revision-walking.c
@@ -9,7 +9,6 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "test-tool.h"
 #include "commit.h"

-- 
2.47.0.366.g5daf58cba8.dirty

