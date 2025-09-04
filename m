Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA71D3164D5
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996095; cv=none; b=OxrmVeb3xlO/15J3pQLoVUxppGIkmpy6r0/nHnL/id+S9tKPfURCVj2rgYjClzc8xjxo0xZJWFuhndNymnjt6wJCKN4+tSuOIEIJQswDp3F5CuOAQ1xxw+aPePJRqfWBuwyCQ7V66BxejkWh0pPnu+9Co+7Ik3fRSBO5UJg6gW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996095; c=relaxed/simple;
	bh=cgzbL6jJ4YIjB7tGkKk1Htcji9YidoW+qHIX2lhVoiQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sp3Gx6a+CuKyVIoROq17K+TGTlN45uFR8E+kafg1kW6OgMWXc/HPsfxd7ENYtiClE2f/tEM1kZuQmenTzsToqJGC6B8LUuH5zpbQVFjCY7/j88+KYquOfRU5gG05H+w9+/dWlmAyXUSfSIeWgeax51dBQuePY/R8IZ2gIEXuvoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Hk5Rhd3G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XDpUIiWe; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Hk5Rhd3G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XDpUIiWe"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id D5C211D0028C;
	Thu,  4 Sep 2025 10:28:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 04 Sep 2025 10:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756996092;
	 x=1757082492; bh=T3sNjOBPfHqYETFc/rODYknh8/+Njd+T/dv6TqFTz0k=; b=
	Hk5Rhd3Gd4pFwKv/tsrux+qUk0LQNJWBL0jnHIVGaR4NNd7VPd0Kws/BkdMs+CZh
	bLs8MIDpAPOWfidcPW3rGdpxwtbYScfz7ctSIEEL7BXTWcNWj4RbcAyJm8LebXmw
	PBpnR75HckVEoTHoJfCs5izadYfL6YWoHfv24y/giM9MNdbwvMigo2lxnkBGoS/L
	a82TyXQ0nGFUcG4br45t/UyqC+DIoN91Fd12vM48HNWDjrwUxXCzmy/scJmy5SfN
	OeNENmENFg5j64Wij08sJzZiv+uPhmKbFXxwJ+AYavOAxXnskUtdAbLGshzG6J/C
	vn6xaty1LfYbbIMroqn35Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756996092; x=
	1757082492; bh=T3sNjOBPfHqYETFc/rODYknh8/+Njd+T/dv6TqFTz0k=; b=X
	DpUIiWen6hMbZ6lXQPzuTKhZlQoK+hi+HL993ud2LgThuszm4Ly+t5+KHSLG68ie
	Fb/ZkdsI72HTHj7nC073vuWXNqPtIq7CJ4obyItaSG0TsDqu7nTa1rPY4ksObAVj
	LJ6YeFNf8Brz3XycdMkNkOquYEkZgqpiyeMZqdr4ooPYSGCKhLM9zC9T4ngcCp+P
	NsCbtuj8Cg6Vi6C7fLMfsU11LmY69JLZJQWOEotpy/wP3h4wLV1C3Y/m8eyfgNSo
	MwNwAHx0Ux78cHqUxwt9z4SNg5jtZwSClIOVsbO+/vjk3IuAktRowrDerZsSD9jT
	fycokSuuWRoQHTZprqscw==
X-ME-Sender: <xms:_KG5aE0ZHRO5tStp_AU6dQt-RrMzJ0iNOAbncPLd1sL7I7_uN4q79A>
    <xme:_KG5aMrPXkwjIlDNZvLZPIgmqYRVDc1S6B-n3-NCAYrX8GYPNdJZMP_U5grfd4HLs
    YnY1QLKAXnsjea4uA>
X-ME-Received: <xmr:_KG5aDVj9fukz-FjayIDrw-cAyBnXVknwEhBiazrmcyVYvJK4sIxCs4ahZdl-JR_yCGzRTsoGDAkbB0AUv687zklnO7cr9XmRlMHn_7Y7CFfVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucev
    lhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmrghrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehjnhdrrghvih
    hlrgesfhhrvggvrdhfrhdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtgho
    mhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhf
    vghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:_KG5aPavLXE0EVxvz-HNi4KJogRNhnxNgXbbpGh9lXkZOhJKIRvgZA>
    <xmx:_KG5aIdPoBkvjqc32nwma-oRjrqwxXGnJTw1xppFmk8XZ1x23B8wfQ>
    <xmx:_KG5aB2CA8eQLqnxXwAvoFW2ZNt9gY_UmBoS62J_wRzk9k0AmTm5aw>
    <xmx:_KG5aHJviYrQRlGdnTWfWU3Tgbk-gWauBmUbRmE_-_AOHHmTHBpcyA>
    <xmx:_KG5aKhbGsspTPuyJHttjl_rOLR6WxeBZQFK1dpw_QJDNyDhhtprRIk7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 10:28:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5eeea92a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 4 Sep 2025 14:28:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Sep 2025 16:27:41 +0200
Subject: [PATCH RFC v3 11/18] add-patch: split out header from
 "add-interactive.h"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-b4-pks-history-builtin-v3-11-509053514755@pks.im>
References: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
In-Reply-To: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
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
2.51.0.417.g1ba7204a04.dirty

