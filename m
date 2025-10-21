Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942AA274B56
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 14:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056180; cv=none; b=iiV0ZsAggnC62MoiZWd6WXtTSka7mIBdyp0qm5f8SLzE6U2kzWvKY4SUKIi7iTPJX4Z3077rVmlt7MeP1oyKPTIGTrbJ3A+pTB539pX/rqLMCerhdYdAjhnGT2HunfGeyvi7dN7erhl1C4W5V1anV/Oi/AlZnYf0oJsMF7SYt9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056180; c=relaxed/simple;
	bh=S+NYIJwQfBNV8Hcg9oig4kmsE7yez85t+hx9PQnzXH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZyAh2GY4QmJII1CHhsdx+ky8fWnx+Hl6eYvlVoTeVU1TTZ0Xd1jeWfUceAQYFs+rjDt1qSxSC8P0Pcsi9Iybn7k7vIbB334QpAkt5v+8Uo3aVjLn+tLm9y5B8RHmU/yHGhKO77FZ8rELPk+T6F0juWODiIrlnOVkTiMwSCXrUtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bpTO3YW8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xFr/a9U0; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bpTO3YW8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xFr/a9U0"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BF0AB140009E;
	Tue, 21 Oct 2025 10:16:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 21 Oct 2025 10:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761056177;
	 x=1761142577; bh=EEUJ8yA9HHCZQW1cVUgzRvTG2wvqGNKJuQ9IoEElrbU=; b=
	bpTO3YW8w7WvWbokROUHAlIRMTykZggzaZoVEZsavWqH6yIQme6GvYjI9nRzD4CD
	Kht828BXoRYHXkwd61ZDn/WhRTuKAUDPs7Xyr0fGZWeWfSvsk74SAZl6NabdCC58
	BGDJFpk3C4aSHmeeeknYvhgECodxP+Gv8xmbyYkQlOVr6GDY+azghPMK9bazDKzn
	vKe1yZR2LDeHMLM/bPyHRmQqfpqtmBQuFnpwflgvCTrK/oxlYZabrTFd6fB7z5GM
	uNyAOxe9Zgkr2PfBpX6GvW7RdbDxt4TpYtjn8dAUZp1apqNTA+o2y0kK1q2x9LwZ
	pRP1jYLwRzkbPUKzoyiV7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761056177; x=
	1761142577; bh=EEUJ8yA9HHCZQW1cVUgzRvTG2wvqGNKJuQ9IoEElrbU=; b=x
	Fr/a9U0i2/awMG2Hno6XbU/YZL+KopC+Ygc4Ky7x4KcGZKRhgdnneiFzOhP5ouMk
	UstNg7kS3AGJ/Wr6fAqy2n02e9EbCllGxYvC1yVGsHUGRyU6kiiH0470forP0IpV
	Z5GW/sFcxBbk+5b9nYgcoFDRpG2DK7ofFZhiXV/Pm2SlEcvIu606v09swh6uI+Lm
	YfoN8gYKZwY3JE+bq0NXpRU611DJ1ahsO/igfe0fGLsmPTmbxE43xQ23+zZrB7Mg
	tffm0Qjh+PQQbQjVvtOMT50ANFVhHdzxBsQo05MmEIDUoqDnR5Im5GVGm5h+Pho3
	cXjhCnP1KgzJeM2tWW/pg==
X-ME-Sender: <xms:sZX3aKkQx35q8W7eZYur2yN9IcaCMnMxOcRR-QKfcWLkCUwR_PL0YQ>
    <xme:sZX3aEbOOfDiK9xoBvD86xPfl1odXrcaJvx2mQQTJiqrAMaQGiuV1Ow3EtTMWFux-
    euGejWa2euTMsu4UDc6lp82R8BISp3gtjCUL4WwgRXGkiEV-hL14w>
X-ME-Received: <xmr:sZX3aMSMlZv47y6PxzDrBG73PjnauGwbg35iBj8_BgdYNN2ivMC0eLd-COzJJSo3Q0SinRvoVeHMGx8j35wstkKOE1HTbfChAYHeyhS37wKTKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrse
    hfrhgvvgdrfhhrpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtoh
    hm
X-ME-Proxy: <xmx:sZX3aOu8YWVherai41TZU6q26ciQZGEc6QrjMepT6i72YPUCtYYOTw>
    <xmx:sZX3aOHBfG7Ve-b4xUiwEbZzc1yBctf923NIFJlfLylPbMvY19CFaw>
    <xmx:sZX3aPxoXAzmhIiEQi_DQrGBaMht1VQYoYgdcgHacanjWiSG4DTrFg>
    <xmx:sZX3aI0XAmP-xG1DyURLH30gzQLYujlAVF_tqvGzgkulXnX3C2LFvg>
    <xmx:sZX3aEQ7HwDT2MXTEQ9mag-tpbo1DOoX1uyHxdWY3XIgcMfq2cJ6cx_a>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 10:16:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2e732996 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 14:16:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 21 Oct 2025 16:15:55 +0200
Subject: [PATCH v5 07/12] add-patch: split out header from
 "add-interactive.h"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-b4-pks-history-builtin-v5-7-78d23f578fe6@pks.im>
References: <20251021-b4-pks-history-builtin-v5-0-78d23f578fe6@pks.im>
In-Reply-To: <20251021-b4-pks-history-builtin-v5-0-78d23f578fe6@pks.im>
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
index da49502b765..2e3d1d871d2 100644
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
index 9402dc71bc6..3bb7bcf3d26 100644
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
index 00000000000..4394c741076
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
2.51.1.851.g4ebd6896fd.dirty

