Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B2E19DF41
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732886033; cv=none; b=fbI/QHFI1bSCJIoDeEUl/EqRTw6mt2kl8SWikhWOcwANqg+gU4vWsbB133KuUujgU54Fa2ijZJVRwFlI0ao/prYpl0ijk6VIjqJmhZGF/dbofYkrUCeOn/tkmXK5ydLGRddUySfrDtSKYnMFm8/YprlJzcfQuC7eUn3AAqHx4Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732886033; c=relaxed/simple;
	bh=IIkeczCXYr/lOGQLsZeVBoF7wEE7NvHb0j/btragAjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AxCL84sgDVbbdkiB57HNc7Ds7L1NkB4xYthF7h0HTGoSRbqhp9KQUyE85lG2qSJA7+t3La0c5DPH2LZtWHvL5rPCApJF1DmYZXS0WLEvLMGtw2rVbl0okvOTJqKph3XjVjZV/FWNiJ6mkMegzZGhOVFYy4A1l9BgCE1o5ylTnH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GYEzD256; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nJKYt6I6; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GYEzD256";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nJKYt6I6"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 562751140158
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 08:13:50 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 29 Nov 2024 08:13:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732886030;
	 x=1732972430; bh=njjDJHGoZKcYB/65h6M/qcT+eRDlraZ53ERG6VvnqDw=; b=
	GYEzD256EzVBhJT8hkeQYXs5je+jgFizPIbivQq2QF4fiydm1F8Pu8k+ZZEomaXD
	Iy/ZDYAwxHZl9WOJq2anUzvlU3+vRfgAj0oa7BTpjquoc6MYInHmoDn5lunPmANs
	klqakepoA4G1SalmYu4blAqR5dZD7f44G6HOQomWBUXx8yeAgnAC3X9Kh8kr6fef
	FHLBdPTaqGjDCHSCNUCfhhYLOZ9TEGKdhi1ru4idFJSl3HhrTUU9WzhVAnDWbbol
	DblU3tpHv6sHiS/XlnRwXNNlLn35rzXlmMMyki2zMTlXO/k4aYdiilbUaqvtCUES
	Xwg6QeX9OfthVWOljkHPXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732886030; x=
	1732972430; bh=njjDJHGoZKcYB/65h6M/qcT+eRDlraZ53ERG6VvnqDw=; b=n
	JKYt6I6dG/p0DXj9tzHQ1RxdFgACfrQFj2DLX5ty+BwIyX+X0W3FcWAcgekdPNFS
	VEVX05PjwEgmgU7GzmMzY7P8nDSmhNQEf2vKfRHPldvaKnqckrNtmDzmkPqgN8nu
	l9vipA1AIzNBAY2mrwWTV6MprSduHXMS+ZEyU3EVyVsK405Q35cGU6E4KmfDNJy/
	gsvDyg2ROjADZmSDjS/CvKn0M+4IUHHZiLCHyzGBC/8JwXeWbFhyyPjAKRwg8H7p
	/exCP6adFaVUaWfglwGsXQEhQQ41IGHkvwTVgywftctJyWxo0WGWfxzKK43BoKT9
	xF/XzipFPEnmJORII0dow==
X-ME-Sender: <xms:Dr5JZ-kzzg5VGTNe6z-4BhV9gtl3TgFie35cwA5tGUE0_PpqeRUlxw>
    <xme:Dr5JZ12MMcGX4lbkiEBDmjqwGF3hhJxcIxbjj1CTwnyvaX9kewbpyC8wLkSwaXkPT
    dfYUTs-eMa6CZHliA>
X-ME-Received: <xmr:Dr5JZ8qpUMnYdrGtbFJV5XgYv7c5f8HDbXPM_ifJX-X5Fg2n9L1ygV-lmT4JX2chRafXKi7iEMBvh7AZA59eZ71O0lACowwUDPUQwI3YBlIkq2M2gw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheefgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Dr5JZykz_yZdDEgHefNtyodcfbH0JQHPoFbJ7wKaIQbzICiLg3tmJg>
    <xmx:Dr5JZ81ir9ZoYja0Rz2ZaoHB0d5s7ROGiE_2-Eqtcl_9-FnuaTnkLg>
    <xmx:Dr5JZ5vbU1dgPnxUSeNhMgwQmNruuk8WhYdQI-U_-T-gFezbmx2cJA>
    <xmx:Dr5JZ4VUg9XDv2xRosJr4ATfPF2ljcnW2uw5naqcumAmZenQUzIFxA>
    <xmx:Dr5JZ58a8H7bHD2BWN7H8d34i6qMDoAw8CTWBcJrsJT4g8S0mU3pbH_f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 29 Nov 2024 08:13:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2f343cd2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 29 Nov 2024 13:12:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 29 Nov 2024 14:13:28 +0100
Subject: [PATCH 07/10] diff.h: fix index used to loop through unsigned
 integer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241129-pks-sign-compare-v1-7-fc406b984bc9@pks.im>
References: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
In-Reply-To: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
To: git@vger.kernel.org
Cc: 
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
 builtin/blame.c                  | 1 -
 builtin/diff-tree.c              | 1 -
 builtin/merge-ours.c             | 1 -
 builtin/pack-refs.c              | 1 -
 builtin/patch-id.c               | 1 -
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
 20 files changed, 1 insertion(+), 25 deletions(-)

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
diff --git a/builtin/blame.c b/builtin/blame.c
index 6c6b0c7ef1a4d992064c7664bbf1229ef0286b97..9f8568bf01b69f717e3c7296e4dbd938f53f515d 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -6,7 +6,6 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
 #include "config.h"
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
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 87fa586c4d552ba61cd2ac2cf079d68241eb3275..027e0c0b1133f517a3ddf3f73e4ddb266f97760d 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
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

