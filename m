Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701EE2F2903
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 10:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764758939; cv=none; b=HndpZMgOdyOErKmSPTcPVNzECf92HRgcpkyXOBdIAXpcLfKiHrPRMYmwyCKt6EagZp1Slsn9cRko0R1aQ3C6uDE7wXfsz2wtEbU2wt3qz4ocIqx0M68otGU3sWM830XkcUuC9MLfJbjOTOUtAnrFQqvKwUDmSOBeEjGwLnSTzdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764758939; c=relaxed/simple;
	bh=yZUfyTPtOs2Ev7RFzEQxZakhqkBc5hWoqGbyFKBo+XY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T2qJWbs4EE81J++agYMsHMv+yx8SKIkWVzWdkRAhsjdBiE1DMS81QPBW0niB8Y4oS4460n0Tzc4foajgSnbTPCA3QLg583lNrVDPTxld6YaMWz9HpSWYlvlBmWJiqSOmuFYvxlpRbGYGak+B72vlN5xcXA7lQL8JQXr/99V5xec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nJ1JkoX2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pKUSBfFW; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nJ1JkoX2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pKUSBfFW"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id A57F4EC03AB;
	Wed,  3 Dec 2025 05:48:56 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 03 Dec 2025 05:48:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764758936;
	 x=1764845336; bh=ucF5IMsnQB3k4r0hvxemPIgex48PzTXaCYINB32dqKE=; b=
	nJ1JkoX2SSzkBvZGMdw0wTm1YLShn6IgMKx9D4qT6EuqB4dgQSS5B6LTqBFT8SPQ
	5vLYZR8jf+dgv2wZtWWwAzlpqqY1vlW9Ayd2SqiN14LZtrQpInRRCAKZalyl+FJp
	tfoBv2/I3ElmjpVHb7h1ZY9PXd04PPuCDSTK6besiDQUN6RXvsaNZc0Dj/tMJcoA
	E4U2zQdSHpKJ9jncfM0tn0hkd4078UCqUJgoQ9klccUHuL6GSorax6pJHNI53T6y
	7XGg0zI0nGouQU4cJV13p/K6q9YxmOPqXqOMle7cDajEFFl7QW8bDiFAqxDazTna
	dumIMo52zuLOEzzyhWayZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764758936; x=
	1764845336; bh=ucF5IMsnQB3k4r0hvxemPIgex48PzTXaCYINB32dqKE=; b=p
	KUSBfFW1eQ3r+5WuNFXIdHUflBKD9IBAihPSlMEhoJ8k338NFltTcLHMhkXugRok
	yas5s6XNvPjqEvB5y46UaohYPdMpUlwz+mXIV7mzN7l66tAEiNoa0cH031O4pdqN
	B7hK34sp40UZJrn7VpJjbC2ctxpI2Gng3cWQ9kvz1ktxr11G3O39ObzEU9YSRdhd
	vf62edDmJ6CuO7t9/v0rjHXn8VcWI916d2UkmzxXMO4ZNAOoesAoUi2owqdaRSik
	WcpI4THVP9Moo2bL4aP7pCBY7zz9axiokzyR3iGFGEJsfYQbM0pAVNfu482TZLMf
	c6LBbCXs5evQKSstULR+w==
X-ME-Sender: <xms:mBUwaQ69ry4tdvs4zlEto0LOqCten6q187Ch6r1q15FpV48V7TpZmw>
    <xme:mBUwaUfzSWQjrrUZZKYYnzAigA4Bg9OLyOph3305-c7s2DIX2cMP9PftaxTe6s6H2
    SWA9dSfAaqm9QpoU4UDm5Pnvk2hqjJ1YxXR1iHA2TRGzFP5If7VQA>
X-ME-Received: <xmr:mBUwaTE0oIKKQk5XIK0imz_M86k5U44pMTloM79NW6UYMEohdq-ZppkY_Jir8R2Sj2uRTW5sOdzh1ELX1u7oBTrFljUsgG7jueX4NI8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucev
    lhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsohhrghgrnhho
    vhesghhmrghilhdrtghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrh
    dprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghi
    lhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:mBUwaVT00jVT7Hw7QTRBxoTDIpw5ohTo-NM7Wp-ctJDAyM8tsus_1Q>
    <xmx:mBUwaZavRQkdFKoE7rQcRtQQqlDxvHvttx56Beowaik3ZkD0qErTTg>
    <xmx:mBUwaQ09VpKS6OLSyZ90EMHPI_LaqKUvbVV7zQJlHR7rynwqfogXaw>
    <xmx:mBUwacqolCAmM0hBx5GaUyvgduiyUw4KHq7TaWLGGv3grd1aegY8lg>
    <xmx:mBUwaS3sebsFbpoO_ewyjhBQa_I7oRTz1kgQeJp9Wv5IgHcpdsUcFJbS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Dec 2025 05:48:55 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5dad49f7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Dec 2025 10:48:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 03 Dec 2025 11:48:33 +0100
Subject: [PATCH v7 06/12] add-patch: split out header from
 "add-interactive.h"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-b4-pks-history-builtin-v7-6-9e9f849bfd0e@pks.im>
References: <20251203-b4-pks-history-builtin-v7-0-9e9f849bfd0e@pks.im>
In-Reply-To: <20251203-b4-pks-history-builtin-v7-0-9e9f849bfd0e@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

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
index da49502b76..2e3d1d871d 100644
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
@@ -35,21 +32,7 @@ void init_add_i_state(struct add_i_state *s, struct repository *r,
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
index 173a53241e..5e3481083b 100644
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
2.52.0.239.gd5f0c6e74e.dirty

