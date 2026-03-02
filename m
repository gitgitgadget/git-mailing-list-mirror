Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6C9366802
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 12:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772453596; cv=none; b=gLjD7LuAH4DixwbPCcf4O1xXrLgFk/3aMBjkj8er1yCvHPGD5iBeavFOiq9SlZMZFfBjMPmfuTg4wBIguo6YRgDOfm56HYOeO1otcLX2KcYuHvjKHO2lybEkYHO/VdZ8f2+PoOaj7IiswYTVDF01uShTpX2XfZjsGX4ZKHZvKWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772453596; c=relaxed/simple;
	bh=iSp/LLiWcyXr45UVtc/apCqi4uJ6hSAHqFKVowWWWGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nshUx/fkFA4ZFhDQyE6ANDeerTYjZbnT3aNEmtaLBQLQfDFZyoqsz0ii64pry0goXT6UkUSOKobcllSpy/NQlEC4La+qX5zFtUbI6hCRCSJWYhu57GkLHyOrATOMGF7t5mQUpacsusJ8eietSI/QkmViHqgkK0nS+m1SWce5sDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T7yJ0af4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nfa0TCj6; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T7yJ0af4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nfa0TCj6"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CF11B7A014B;
	Mon,  2 Mar 2026 07:13:14 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 02 Mar 2026 07:13:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772453594;
	 x=1772539994; bh=EFLZLAp6JXtlN2zqAv/9CtBo+RjODFKl9DjgZmEpyZ0=; b=
	T7yJ0af4rE9VYZ9+WQfQcRImmTPc8scCPkcA/1OhZ5zoIfoHMO+bju/MpuZ68qcD
	rYSCGJ4sdBlQGVe1T9mzFzF5CguE5MD3kB+32P6H455iracHGF/qZb2WNZ/VkRYj
	UdRY4GwGalD0fax1xFAuZRs5IuE+NWRbb4P+VAfjucwZ9oRnk9MnKxKznawocql9
	S7s7L0qBe1xo4mdjtanAUZlvW80O0PV7VpLholtfYTyVNs3KZKUjOh2W1d5M7tWw
	ypgEIX8DmTE/ZbVUiNjZ8Zbkrhh58tJYS9sHrNURpjjoOIKweu0SDPUY1hklHFYN
	+JFzt5CiddsdBbAsIlq/Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772453594; x=
	1772539994; bh=EFLZLAp6JXtlN2zqAv/9CtBo+RjODFKl9DjgZmEpyZ0=; b=N
	fa0TCj6vnAWY9hVF3kCTdqBY/6ue+sVR2Zm4Xs+1LxjwvdWW+kzS6lH5UmuZgB8C
	d6TefeuS3AbpUH8mwZL2hvYA7GoxqhbLwacEGgNwaYRnLX6ph6lgvBnT6Ohkq9YU
	nQ4oXsVjXuQDTRthbzb/bydvEX8X4LflvaOAYeL0XMVu2yzX687XKUmIGIvi00Xx
	s7vPA+C+klgVtH+c3EeWRVU+Mb5PaPbxzCrhSIOo8rJI+F5lD7sIlG6nxXJ7ZQbE
	yu9kFKwg8BqrtqWAh0FLz7hObF0ud0vhtUp3DIWSJXy9eUYF7TmUvGWtR88wicW4
	gZcGPMjDjMktoZnkAmwyg==
X-ME-Sender: <xms:2n6laRwuSx-1Wgm0k0pVKuv_H-bmRGGG0ihcz9AwVUpyv44Seq6EMQ>
    <xme:2n6laXRp04AMdjelIP3FRuN3KtQKYA3mzIByXkCSpNbIQi-DRQ2MaKRhNwxjSaY2d
    uo0yHYxgQ9jh3twjLnHz3tiucbaQkZSB3jra9Gs5DlYUB212DGMCg>
X-ME-Received: <xmr:2n6laY8U-81zavgPcb7juUIzDcGh3-L-3Pn3jexEL7PyfdxdzjJHpfuvsexlWgY9H2Judx_cg4dDUe1_Kf3lj7pR6EaRHhl-eKcIhb_yPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheejieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvg
    hnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:2n6laeqDDmY6LTUeYtIYr5FEqTCBP_YjK9zPmeUf8mZyx5n-7W-zuQ>
    <xmx:2n6laVnkMPDvIfVCdqhRoiwevrYkjaIPk1Nhj0eAZxr2RhW_403aGw>
    <xmx:2n6laVIbnX8nVES-DYNS9VzrXfMV4Hrw_ZBSyhoHvxgo9IJF37CWhg>
    <xmx:2n6laawAnaMzNQohiTyk-fTnnkyQ25DMUX667SOudq8eWH-UvBPVjA>
    <xmx:2n6ladiqznXrjSRg6Zx47HXvCAvIvUM_TvlvpD3cGEwaOUc7CqWmdBLn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 07:13:13 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e5def94e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Mar 2026 12:13:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Mar 2026 13:13:05 +0100
Subject: [PATCH 1/8] add-patch: split out header from "add-interactive.h"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-pks-history-split-v1-1-444fc987a324@pks.im>
References: <20260302-pks-history-split-v1-0-444fc987a324@pks.im>
In-Reply-To: <20260302-pks-history-split-v1-0-444fc987a324@pks.im>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
X-Mailer: b4 0.14.3

While we have a "add-patch.c" code file, its declarations are part of
"add-interactive.h". This makes it somewhat harder than necessary to
find relevant code and to identify clear boundaries between the two
subsystems.

Split up concerns and move declarations that relate to "add-patch.c"
into a new "add-patch.h" header.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 add-interactive.h | 24 +++---------------------
 add-patch.c       |  1 +
 add-patch.h       | 27 +++++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/add-interactive.h b/add-interactive.h
index 7843397775..6c62489bfe 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -1,15 +1,11 @@
 #ifndef ADD_INTERACTIVE_H
 #define ADD_INTERACTIVE_H
 
+#include "add-patch.h"
 #include "color.h"
 
-struct add_p_opt {
-	int context;
-	int interhunkcontext;
-	int auto_advance;
-};
-
-#define ADD_P_OPT_INIT { .context = -1, .interhunkcontext = -1, .auto_advance = 1 }
+struct pathspec;
+struct repository;
 
 struct add_i_state {
 	struct repository *r;
@@ -37,21 +33,7 @@ void init_add_i_state(struct add_i_state *s, struct repository *r,
 		      struct add_p_opt *add_p_opt);
 void clear_add_i_state(struct add_i_state *s);
 
-struct repository;
-struct pathspec;
 int run_add_i(struct repository *r, const struct pathspec *ps,
 	      struct add_p_opt *add_p_opt);
 
-enum add_p_mode {
-	ADD_P_ADD,
-	ADD_P_STASH,
-	ADD_P_RESET,
-	ADD_P_CHECKOUT,
-	ADD_P_WORKTREE,
-};
-
-int run_add_p(struct repository *r, enum add_p_mode mode,
-	      struct add_p_opt *o, const char *revision,
-	      const struct pathspec *ps);
-
 #endif
diff --git a/add-patch.c b/add-patch.c
index 8c03f710d3..8ce2fc02f6 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -3,6 +3,7 @@
 
 #include "git-compat-util.h"
 #include "add-interactive.h"
+#include "add-patch.h"
 #include "advice.h"
 #include "editor.h"
 #include "environment.h"
diff --git a/add-patch.h b/add-patch.h
new file mode 100644
index 0000000000..88b00ca788
--- /dev/null
+++ b/add-patch.h
@@ -0,0 +1,27 @@
+#ifndef ADD_PATCH_H
+#define ADD_PATCH_H
+
+struct pathspec;
+struct repository;
+
+struct add_p_opt {
+	int context;
+	int interhunkcontext;
+	int auto_advance;
+};
+
+#define ADD_P_OPT_INIT { .context = -1, .interhunkcontext = -1, .auto_advance = 1 }
+
+enum add_p_mode {
+	ADD_P_ADD,
+	ADD_P_STASH,
+	ADD_P_RESET,
+	ADD_P_CHECKOUT,
+	ADD_P_WORKTREE,
+};
+
+int run_add_p(struct repository *r, enum add_p_mode mode,
+	      struct add_p_opt *o, const char *revision,
+	      const struct pathspec *ps);
+
+#endif

-- 
2.53.0.697.g625c4fb2da.dirty

