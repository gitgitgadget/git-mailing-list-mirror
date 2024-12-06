Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EC5201278
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 10:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480865; cv=none; b=NliNEgzL/PBsB2q7mBnbva0/xGXQETah7HFibA6OrnUDmKdZJqincwSczUh7iOa2bYm95zwFds0cyuCyYCskZJgz97dR8OEEmPRuY9SunotzmaeC8r883kcRq8OHM5EmImSmkWoCNlBVBRzb9IZu1fHX/QGi8PqXGvfV8oL7Opw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480865; c=relaxed/simple;
	bh=3sANn2AVJM5Xs+V7whFEWrXfntOz+y/8yQVv+8Ekskk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oruIOfo3D/XoqdWBnu8qgAhIIUe4393NEB3RkfVU7gfpIAtJZKX9wLC+sO6E/grOIXhVb2jGtWEDb3V6AIwU7UkwpLquYmMuNzdRRmfachtpd8dxiuZ5erOQEssdwxJSZL62fHiyqmujzjv5fqfwdXl37CErWXrEfBmRWUG2/Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=zRfvJEFj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yNFlfejO; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="zRfvJEFj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yNFlfejO"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C77C12540197;
	Fri,  6 Dec 2024 05:27:41 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 06 Dec 2024 05:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733480861;
	 x=1733567261; bh=6An8TOU1+GqDHXA2K+p0c3agKhpCmPZrK3YIscio5jo=; b=
	zRfvJEFjq8ewe4mOXPvOe+HIi7S4CIo39Z9bMoWjAsn04MltXXV2FAqRvOv+2RQQ
	rM3QNiuWTts5IS6Dl9uHHkQWofdWow3cpv2WBuPzgb64racTOOmMERuUzUWOuptb
	/hszLiWCMuaJae6lPeAQciMU5C7p1yrqT74S5/zANjZHpY76awP06uoLrT8cLnNg
	V68P8o32rGuultx7BwRvhio6wU2pSb7iV+YDA94bHgTPG41uXJPg5FTkUWMiOPwg
	VwAUuN58eV0isEFLZkHP8xG6gV66kEsi4vxQIRyzRDcXKByCGbLSeOxAyeGgXqg5
	jg9b6oqgXYsgq0+K/xbSHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733480861; x=
	1733567261; bh=6An8TOU1+GqDHXA2K+p0c3agKhpCmPZrK3YIscio5jo=; b=y
	NFlfejOTUwp6LcxOjsWuoushauDkeUqZHMEZpjrFyLBcY9YCB+zRHG1qywZIUeo8
	2PmBUTuNGc/JaZAyHXWM3AEkRqy5pmukUqmuRnoV9UQnR7yyLX2tN933877UJDMa
	PtjNfPGTmu/bmv9hvCA0HOeqcC3rK0xFVdNP2n9TGt4kCa3arcKFxUk6/g9z8wtt
	x4PCyyKXDV0FyU8amhEJ8VyA+q7M3vHvI25z6vxoq8NPvHASdUAMoCN89aUj/kQc
	7wrbZpnYb2Sv8Aetc9+gYmG+MmHTumsi6Q4O5LO1Z7I5bnZYy/fgRem7V1WemI2T
	gmEgaYhspDSyhVntmfQlw==
X-ME-Sender: <xms:ndFSZ9jRtPjKf7VmOdLPVkldrng8c5_yOqQ4CwG_PTNWe_sXvOnfXg>
    <xme:ndFSZyCFm2QV63jkUTwTcyqAAgP_5Ia0ZMuuPf3yxnrxUGXM_ZtC84ZxbUXqRD22q
    IAcHiac-8lFyi-SjQ>
X-ME-Received: <xmr:ndFSZ9HGsgA36utlnBBsb3yE0yIfEAGrZem4uZR2FWRLYHPk9d47cqBCmdVArobgKiHsnYe3FWpAVOd9Bg-52XRQz9ZRSY-VpQDXNkWiHaxnpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhh
    vghjihgrlhhuohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ndFSZyTZTbZr9z3JXJYDAwFIpbB0ygZauXjhGDV0Q1Kryq_yevjc0A>
    <xmx:ndFSZ6yQrzEZHgXftInVkZmUgInuk0n-LZJsNAObn_A5Y4aVWgtCiw>
    <xmx:ndFSZ469MesC7XkK32T_TOCeYJUnyMzxceIY_sdIu79UqBl7REa0kg>
    <xmx:ndFSZ_zaACpjtTtpy9APWRRkHet5vXYJlukJWjDniDGCs_E3IuEW-A>
    <xmx:ndFSZ0tNfHH2YEKBkCAvK4cG1ppJ5H2ugSSqUrixJ1uR7uiw08uvJYkZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 05:27:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 879276f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 10:26:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 11:27:21 +0100
Subject: [PATCH v4 06/16] diff.h: fix index used to loop through unsigned
 integer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-sign-compare-v4-6-0344c6dfb219@pks.im>
References: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>
In-Reply-To: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
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
index 08e99a22b04db7251c285ff56d70d5292ddd2723..95f264989bbf1a955b3be528b84ce1fe525e8459 100644
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

