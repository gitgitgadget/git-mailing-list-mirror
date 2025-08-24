Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125FF2D543E
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 17:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756057431; cv=none; b=UxQRsIiXp4S6vX7r1z9wDS5LLJUjkI9XzOzTG8k++F+Rh+Ta/eFzasqU5GaXXaAxFw8dVrcGQ6V5nOF33tltNQOYd7vNzuEyC/7GIFw/4Foq/joT1FiLqftvyOkwfNyVZfZgBa2zKi89UuuqsIRVprIShbKLeUoa/IpmkVfwaOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756057431; c=relaxed/simple;
	bh=hWZVBFkx70zIvv63ndca5f1+4N2QUOoizz2AvMOvXBE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FOjc2aXYzy99oEa1bJjDa2Gl5YWItIVIn5/fW80nueQgr//HuPHL4tfg7kLrcesCtOgnjRV4WY/OjBxN71KsVY71JUVDfH3NY4CkB6nKblhy3xrvuEo7m7hm1VQV2C1icT7UGhfR93Mr3OAVhN8PR1jAmXMXv5FyuINmk8LGuS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BOArPeHo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I1CfPtxo; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BOArPeHo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I1CfPtxo"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4B5DE7A0092;
	Sun, 24 Aug 2025 13:43:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sun, 24 Aug 2025 13:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756057429;
	 x=1756143829; bh=T+b+8PQcTaRUeHytdXj6QNfbzxkevq3t87SXgFtqoFM=; b=
	BOArPeHoAJXUyGcPu8Y1H3/IPKQkoMr/4Qkv7cF2a3J8HDH4i0bNQGG/eVdMhp8C
	s4lUoe31O35OCtWeKV7VeVGL/w+U7ccj0oENksuoSioy2N4IUQ0SEgWK5qE20Rm+
	9TQu/SA84dYoHY9iBTALcdOqJD+t2KXkh5DzYWOgmWb+dkDTrS2F2JYairIRa3Fe
	8ENIcoAUZjg29dWmGRjh6oeDmFnvqF8XHziB7NPLBVUF3STyETgeGKJ/Pt/j0Pjj
	XxQtRtSAqH0Z8lAwHjNM8vp9v0SvM8nSTVMEqkpdK03tuJzoMzcP1PGDoYlVZ1I/
	tEJEHErvIZljaR3MRqHL5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1756057429; x=
	1756143829; bh=T+b+8PQcTaRUeHytdXj6QNfbzxkevq3t87SXgFtqoFM=; b=I
	1CfPtxoHPdhguxzZ+eBJFbAvSAiylqH4FvMguh4vVgAKnE1DUSNUnVlzHFCCPtev
	BVeQbF5vk0UtGk8TgPJK1AWfrbtgQU7G4NHGgP5Dq2fjgDs9KW/8PpPxk4ZMw3Y7
	gx4eaYmwhLiSLcg+U95KOq0uLUs/9GVUffEWLy6BrRrRkB8iBzuKwKsA6/cpIimh
	MnD3pbMUnRiIRS9MKPtdjZZGUHdt3Oi+rjNFYoxyTjSCdwTXxQB7uYMYf237AiUe
	EI5nblrjjse0eohqFv9E0DBASoP3BzczHbM7RHOhVrztlG1RpMHpIb4nt7jiHpLp
	ukHpkn9a/kP55Fb1toIpw==
X-ME-Sender: <xms:VE-raPHxWTCThKKatdLbn0VTsDtuNl_jNdHUbbsju9b_FG8mSur5yQ>
    <xme:VE-raJ5lGlnG9VKrB86hh2uXfuOtdnUE-NpR0j5o2r7H34jab_l1a3-zY7clPvqM_
    _IV__QEsDQSEiZ8lA>
X-ME-Received: <xmr:VE-raHmm4OeeyRtkxhWHky-VJbN21ZLn5rGbdI2hrB6uJspA5uiYGE958LohiRdNIs9i8YBOmOea7iiQAalG4zZoNNxTtllU7wXD6m76>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedtudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    sggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehmrghrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtth
    hopehjnhdrrghvihhlrgesfhhrvggvrdhfrh
X-ME-Proxy: <xmx:VU-raOpreD0tviuW65XRRtc81GsKUF_ciEXjXvXGfqaVjRXESUD47g>
    <xmx:VU-raGuOPxd5gDZolvOcBbLwrj8mYmemVBw3byexjRcWGPOylXp5zA>
    <xmx:VU-raDEhgoghsTD-l3Un0Eye0wmmuPeK_HEd444IkcH1W0Phpz5qgA>
    <xmx:VU-raPYiz64-DZGVjaRrZj2qqsO60sPyJ5Td24zejF5lFgSN5FWS2Q>
    <xmx:VU-raHxfb7IogtCHIvlmTb1eDOLly9fnsvM4I3XWLBQh8OkQlh6zcTSB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Aug 2025 13:43:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 31139f96 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 24 Aug 2025 17:43:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sun, 24 Aug 2025 19:42:23 +0200
Subject: [PATCH RFC v2 10/16] add-patch: split out header from
 "add-interactive.h"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250824-b4-pks-history-builtin-v2-10-964ac12f65bd@pks.im>
References: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
In-Reply-To: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.2

While we have a "add-patch.c" code file, its declarations are part of
"add-interactive.h". This makes it somewhat harder than necessary to
find relevant code and to identify clear boundaries between the two
subsystems.

Split up concerns and move declarations that relate to "add-patch.c"
into a new "add-patch.h" header.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 add-interactive.h | 23 +++--------------------
 add-patch.c       |  1 +
 add-patch.h       | 26 ++++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/add-interactive.h b/add-interactive.h
index 4213dcd67b..fb95b6ee05 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -1,14 +1,11 @@
 #ifndef ADD_INTERACTIVE_H
 #define ADD_INTERACTIVE_H
 
+#include "add-patch.h"
 #include "color.h"
 
-struct add_p_opt {
-	int context;
-	int interhunkcontext;
-};
-
-#define ADD_P_OPT_INIT { .context = -1, .interhunkcontext = -1 }
+struct pathspec;
+struct repository;
 
 struct add_i_state {
 	struct repository *r;
@@ -32,21 +29,7 @@ void init_add_i_state(struct add_i_state *s, struct repository *r,
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
index 302e6ba7d9..e2b002fa73 100644
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
index 0000000000..4394c74107
--- /dev/null
+++ b/add-patch.h
@@ -0,0 +1,26 @@
+#ifndef ADD_PATCH_H
+#define ADD_PATCH_H
+
+struct pathspec;
+struct repository;
+
+struct add_p_opt {
+	int context;
+	int interhunkcontext;
+};
+
+#define ADD_P_OPT_INIT { .context = -1, .interhunkcontext = -1 }
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
2.51.0.308.g032396e0da.dirty

