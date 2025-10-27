Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBDF2FB0A5
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 11:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761564863; cv=none; b=SRoFPt/Xza/mOSsNVAsv0yVRgVfn6v8Ya+L4vo5O9czo8MCKRLoN/D7oubnswRW1QScLq0fUccEzSNkUUflOLk4kShEiGhGyfYXYA4WxYyyYp/RR5e51Nyv6Sjq6Fe3C//cx4XGGjIVNp3p9jDfBBDUoOhoOoxxcY25+pD52VtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761564863; c=relaxed/simple;
	bh=GOOGxmDzCr1c77oRzTtHLEAxrN5McUcXqCMYx/GQhfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WX6A4n8smw6qI4z78zdDYtv7q5QV1J7Cv3wTJOuXdm++BnJxC7TBa+6cvCQoimtRLqM/exOV2syOTieuJAqJ6eZdHxpo5aQDbGXbIpvdg8jd+6m4PnW5m08F+GUcTj2bZLJkKjfBaZfv9VlgFL6dnqW2qq48j+iasJTR2r494cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LQPHs8Rp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AbXc+BOp; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LQPHs8Rp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AbXc+BOp"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 5AA48EC0330;
	Mon, 27 Oct 2025 07:34:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 27 Oct 2025 07:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761564860;
	 x=1761651260; bh=Jjd8UJ4s5kLSrjqypfD8UQ9d3LFLbgxotXaIeu2zdaE=; b=
	LQPHs8RpdNZWNd6Ui+FZ0vA02CZ4KmycDwmggzpOFB27Wpzzw9spiR9gsUN6OubB
	UM/n6tUByfht/k3V4hcOoXPDMdMulP3/jMepesTxLM6b++2+R4HlNvumR0LhHMdR
	tynptgG6uFtkINJUW2bAhyEMKWnMLbUFR3KqXi1qcpDdlTS3qXlTKO+14SOIThBo
	chqqyiIkP2A1L9Dy3YVozNelDkevtgc7+0kIRezs/laMsEpZhBCvvQqxWADenCPC
	514cVln18cR1DqIUVmAPl5n+shWnUpm19QDm3zgReZyUmrwhj/I8G7eEoGE4pTX5
	XBzQITVeOc/2t7azPspPYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761564860; x=
	1761651260; bh=Jjd8UJ4s5kLSrjqypfD8UQ9d3LFLbgxotXaIeu2zdaE=; b=A
	bXc+BOpW9424n9zdbafcK6YcE70auUoFKGKBpfz3depbiBmUAo+zHr+LULoQdrrh
	t3HvI5WM/wP3baf3S7lEwp2i6qgHWD8L+GVYP4L3MBPO1Hh8rTxlUYG3QS208Jya
	0R83UBG1QJAdn+VVCYzOmikckUFogVuyf+X+F7tg/LK6RIyFqEdQIXo7UBlYg3X8
	TtkmBmT04ihPKzyNEDMKHlJ9V2huz5nuCHLj84qkjt9OyjTGofcdmoLq5Vcsz5+j
	ywZ59nwtQ7UKejjZJ9i2wWlOiD9KqF/oIPTCrlyuevK6ATKaYzktKsHDXIub+yFK
	wDbO13JRGiotIV36GtXFg==
X-ME-Sender: <xms:vFj_aBGCorHmfkF4Bw3SXwhZsCHFR991F5B6ZYhC1vgc6D_rphkbsQ>
    <xme:vFj_aI6HbHvGshTT7b0sxz1PXdHPxNe-Izihoutrimf4RTWw_CSDvZIP8rcWvp0gU
    Fphzuiu28jWjplM9Hc3XpiNdEw3Vfh44J8GmG4S5CZWT_ugqfMUDeA>
X-ME-Received: <xmr:vFj_aGwgBbFWhoaDBr05YcYavvy7S6dWl7NsU5NG4CyELKqUl8IK3sQ_aMZJjdogq7W4J3xoKfJMElve8lMtQ90O1PuZEiIiYisRJG3jhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpth
    htohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhf
    vghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepshhorh
    hgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkees
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:vFj_aHOLbJPso4CllGCoJJ9uh1Abk5o7B9O4U1y3gSiU_-J7ZDGfnw>
    <xmx:vFj_aMnhBBSVWNXvG3Ol0Janxt5bTvj0Uq8uVOGWGN5u4rgDikNS6A>
    <xmx:vFj_aMRu3G15hXiC-LnKWtcTBfldkdDCtZPd31PCTtds7fFwleQ8Lg>
    <xmx:vFj_aLU9FrAzc86Q9k250cybgNXMGfyoFtpxuQkTwqhv8IkQckjHkw>
    <xmx:vFj_aMy1xfNkdAPDBURJ4eiQUINqUMY8_vzbxiTF1ZExwcbEsIe5fzjr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 07:34:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 10e4890b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 27 Oct 2025 11:34:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 27 Oct 2025 12:33:54 +0100
Subject: [PATCH v6 06/11] add-patch: split out header from
 "add-interactive.h"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-b4-pks-history-builtin-v6-6-407dd3f57ad3@pks.im>
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
In-Reply-To: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
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
index ae9a20d8f23..3594dd22534 100644
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
2.51.1.930.gacf6e81ea2.dirty

