Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E12232A3EB
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 10:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600987; cv=none; b=T2K0iIUfv3T3k8hj2cICO8stEIAlAiopnBBYAA784igjI15OouhvLy8G4/hHU4+oCVlv9NDhqPt5ohLvJOz3Ld6EKuEexiSUxPC9ydmAYbHob2l6YpcvZmVuoRLWF1uBMMF8x7cE2D5vnbQTIDWZnJeBaNXWeM8LhhV8rUAAPqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600987; c=relaxed/simple;
	bh=b5Q467jB/trmbb5zZkDc+aCb8OF9Z7cWWnHwjLu72dM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NuqRHi7VLsRGEN7su64JDzFZZH+TaQApYt3QDXXRoNNG+mUKGebuOxuAKNvHeU64MoCzRdz1vRGUBDsPUF7Pm31KMaM7z80VejEq6GF9c5ezd2MHgdQot1Q2ISxIXL+6fP+cuYc+mSHBIOjoFREUXo7IwpKimQDv2eewJzI0Id4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G6X9CIUJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CVaupHxV; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G6X9CIUJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CVaupHxV"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D2CFA7A02A3
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 06:56:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 19 Aug 2025 06:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755600984;
	 x=1755687384; bh=4LOUmMWCi/67dlQUh0+pUDTFCcXn0+2e6s2ky5BMNPo=; b=
	G6X9CIUJnxYrwFoJ9/b/6qXdiFESkP/5y5hINEwrXY2rvB1KeRfeWGPGV9wrwIOB
	KnmBqC/euHiZqRMmxVCX8/CcfIz4MO9lA1GSXqPWB80eyFHDl6NmhQRMBtgiJT3C
	Rz2vbey6F6rGyy0VmMukB8L+gSctOSHwB+M2u67J4H/UWP6TVpDRW8mIMJUV3ktV
	Hg5K3Ihw2X8+boHoMmUkjQ3umkwS1xr5N+GVVkrCGGs0656N68SwzcqzzQqLoErm
	NEen7+g0MOixSqaohFZvw9quubAyho8dHMUQ6VVBIToPcsB7YwrvN4PA2LEql0R2
	m/3YSFMuoM+9qWb/eCbnEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755600984; x=
	1755687384; bh=4LOUmMWCi/67dlQUh0+pUDTFCcXn0+2e6s2ky5BMNPo=; b=C
	VaupHxVSRHqDMv39JkUmhO0c4rnrI8ypOnECOxv8lCrhqEXnHhGsoCzCrovGlq6d
	V2bXbBUy+jh6neQankulTv3Vil+nYeskzvL++zq8kEMz+5+I8qhDvQQZ6b+ln2DE
	AopWWwFCCuc1EA69hrqYjWSXj05F+nu2I4eRtSF/6UqXf4Vcz9/WwJlDJ2Wz7XS4
	BU0BHjaXSxrC4LvmmVXS7bbEJ0MQkNe+2RtI8d5WpqZTG0KNiXS0v/qyR9flVYr0
	j790kZd4s60y71j6NvfJX5MgqG4dPTBtus8GwmFcq6YfyHOIugB8B5dMY8NMuz1m
	7EqZeeuZJucqgwjumn/wA==
X-ME-Sender: <xms:WFikaMVpv04GCGlJqKoxOYNzQiAQWgXUu60fjp8eRB4nLMC_gxLCpg>
    <xme:WFikaClyRVQBxfualsvrDY8ZgRz5iy3v3NDOb9ebSVTrRRdGlANLnRplX2LkP7R3p
    _jaPlCWnv-0UhN79A>
X-ME-Received: <xmr:WFikaJzyY3q2Kuxz4g1oicPwd-5RVopwdNxGfyv2OFNZsiKJoypFl4MAF2YJsXSYQAFc6CVj-xqwhPbG6tJguLUPPyyLr_vtpdKeYKHe-kGG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheehfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:WFikaNhpe3kMT_30Sr0yhSQlTYmShOxABGfhFTocflSqKiiea7bXHw>
    <xmx:WFikaOUNbz864oBtdyG7OVPCaePPkIlcd-TOiFweOSyxbEz34_hgQQ>
    <xmx:WFikaP2x3zzzWOGFHFhARb5HJSztlssVO3u0AHu2NuVf6JTkaIHBTA>
    <xmx:WFikaEG29zgpZ0oNLN2qSeBttgQVZ28dIyy98wtGdNzbtNO6R0RkAA>
    <xmx:WFikaMe0NJdTgLpmelk3c7iK0xPo5awkRddZ6Bw8Ryxfx1TffjCs1CjN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 19 Aug 2025 06:56:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2d6bbc98 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 19 Aug 2025 10:56:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Aug 2025 12:56:03 +0200
Subject: [PATCH RFC 07/11] add-patch: split out header from
 "add-interactive.h"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-b4-pks-history-builtin-v1-7-9b77c32688fe@pks.im>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
In-Reply-To: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.51.0.261.g7ce5a0a67e.dirty

