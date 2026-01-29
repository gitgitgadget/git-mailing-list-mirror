Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15F42D2491
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 19:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769713582; cv=none; b=iIQ9dEurRskp6Zol2qZVT0EgnV0sq/l3hK55dRjTF7NjDN7hNXdzHpw7TfgAbeeUATyfkAuL88Xqc/cR3/2FIVLuLV/fcaEsBzGnrlG9CUxmy4be7Jytk6OSNXsW/fPwZmSdfS5N6OOG3jKtSzLrcLiLto4vxeAvlTGgJFE+K+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769713582; c=relaxed/simple;
	bh=QsPQ1IxTamIIO68NRowUoHLziA5nMyGcfg5Ar9qbkcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q+R56hq6t+kQ0atvsFNBw501jW6dS57Sk5ZuERJ1ByHq/cfe8XHE3d/0mM5aanFIRZaYyumriUKh3b7V6ijnhlyZTJhdVPFD1tmr0YPMusy9OcS20J3HfzN5Ei05FBRpwCuiw6KgkrUvtvJWJVHPPPKzuEtJCpkoKBhJ77hPvwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dBfFgWnE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HW4lcAOf; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dBfFgWnE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HW4lcAOf"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 282D314000AF;
	Thu, 29 Jan 2026 14:06:20 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 29 Jan 2026 14:06:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1769713580; x=
	1769799980; bh=EJXBww2b6rAwnRDHSiSWJT0tLmkKC+HRES68MF8B2Bg=; b=d
	BfFgWnEGQ20i/jb/fV07E0pRZ+FJOB+F5KkGlfI7+38rE9STTLTh7A4yexUNHf5V
	61W25+XJk2+9FZHBPTj33/Q1S5YVSTvzAOLcJ01lTBiOFNeAIDw9FmObQf040vjQ
	7t7hkyo1sQgSQyMZkQxbysnLFakUS5c5TKprVdeNEw7lTjPSk5HdO2nI3/5xSkEu
	w/AL2LRuDQ3cJY9xAy8ojGcNPvhMKdfaeE5CR5vylHk0Ch2P9EAhNiRPUHUGnr1a
	JE68OvY0RlEKYab/NRSlFcI09RcZXg9gQb7YLd/8FV3/hxXqybEa72tjygrf6p4x
	qGSwCLQkK7DO5aHQXHZJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1769713580; x=1769799980; bh=E
	JXBww2b6rAwnRDHSiSWJT0tLmkKC+HRES68MF8B2Bg=; b=HW4lcAOfdf2INM799
	MxBXspT76J/9iwRdtDzaX0Hh7QvIf4tabA6ORMGoCRpnup3ewy1XUeTGlPzC5SfN
	rE7AARRkvNixhi8Ug3AAeFr5do4CaoLywhvXLAy29MO0xyvxlGIRkoCiFrfN+A0Z
	neSw4On1ogeLtaJG1vv4Ag+rrOhwBw0Ld9ne1P4STofZLtEkt5JhmJPc2MZJLI07
	R9SPobP2b8uuPDcA6OZhWML46ilurNXYca3urTcPzGHDJvDZ0ojut7aC/3TG5jLT
	YPIAa3Cm2DxP4nKxPGYJc2IBzdpNrxtYk1IlWTCVed0IpIweUCV2PEOqBC0bHwRY
	zJ8TQ==
X-ME-Sender: <xms:rK97aQ5ZRCODwUQL0IGFWDYfnTp2V1tJZZctmji5uKQtvrZfMawUNw>
    <xme:rK97aY4_MwzCUKVVtd7izHhLVCprN2kh_KH4lO2Uc99ov03GuS7IyKUlb_UyXraaq
    XZFlTt8fyWmZW7FyGvrrJxqAXK8fersygIdmFw3gWl_Nc7_-7Tg_A>
X-ME-Received: <xmr:rK97aUexvWX5N-7MoMhnkbycdvSuu1iOtsznjfYpb4dhJSDtBUQ7PHMG9q9GzS_XNjYrIBu_q7bZaJmuuwDgy7zNDzwCMUtFFfKTkRU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeileelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepvdfflefhueetgfektedthfduleffudetleefieeulefhvdduieeukefhtddv
    udeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegthihqshhimhhonhesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhi
    shhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rK97aUBTnpfuacjOjVYEleN9JNCs2bzvKgoQ2H2DoZ1Z7M5FupA7_g>
    <xmx:rK97af8ndrnAocU1KUZEr0Xq-7oL4uh1PERLHP3DJDspI21MpnorkA>
    <xmx:rK97aXJv6G5G7Ia6LAx17DAnZjBnMkmrGQfOqxrqCk5lAXPi6UWvOg>
    <xmx:rK97aQjzGi598SRL94eTTRddYhJjvuxkYpCT6CUl6Jb8t6Jimyn_Vg>
    <xmx:rK97aT-WSYgCJt780zj_nw775nLUq2zH8nz-qcgDoPkGwFK6sair9jRq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jan 2026 14:06:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Simon Cheng <cyqsimon@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v2 1/2] checkout: pass program-readable token to unified "main"
Date: Thu, 29 Jan 2026 11:06:15 -0800
Message-ID: <20260129190616.645471-2-gitster@pobox.com>
X-Mailer: git-send-email 2.53.0-rc2-149-g6536429cee
In-Reply-To: <20260129190616.645471-1-gitster@pobox.com>
References: <20260127192936.904719-1-gitster@pobox.com>
 <20260129190616.645471-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "git checkout", "git switch", and "git restore" commands share a
single implementation, checkout_main(), which switches error message
it gives using the usage string passed by each of these three
front-ends.

In order to be able to tweak behaviours of the commands based on
which one we are executing, invent an enum that denotes which one of
these three commands is currently executing, and pass that to
checkout_main() instead.  With this step, there is no externally
visible behaviour change, as this enum parameter is only used to
choose among the three usage strings.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * No change relative to v1

 builtin/checkout.c | 63 +++++++++++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 20 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f9453473fe..4f189fde48 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -43,22 +43,6 @@
 #include "parallel-checkout.h"
 #include "add-interactive.h"
 
-static const char * const checkout_usage[] = {
-	N_("git checkout [<options>] <branch>"),
-	N_("git checkout [<options>] [<branch>] -- <file>..."),
-	NULL,
-};
-
-static const char * const switch_branch_usage[] = {
-	N_("git switch [<options>] [<branch>]"),
-	NULL,
-};
-
-static const char * const restore_usage[] = {
-	N_("git restore [<options>] [--source=<branch>] <file>..."),
-	NULL,
-};
-
 struct checkout_opts {
 	int patch_mode;
 	int patch_context;
@@ -1293,6 +1277,13 @@ static void setup_new_branch_info_and_source_tree(
 	}
 }
 
+
+enum checkout_command {
+	CHECKOUT_CHECKOUT = 1,
+	CHECKOUT_SWITCH = 2,
+	CHECKOUT_RESTORE = 3,
+};
+
 static char *parse_remote_branch(const char *arg,
 				 struct object_id *rev,
 				 int could_be_checkout_paths)
@@ -1767,12 +1758,44 @@ static char cb_option = 'b';
 
 static int checkout_main(int argc, const char **argv, const char *prefix,
 			 struct checkout_opts *opts, struct option *options,
-			 const char * const usagestr[])
+			 enum checkout_command which_command)
 {
 	int parseopt_flags = 0;
 	struct branch_info new_branch_info = { 0 };
 	int ret;
 
+	static const char * const checkout_usage[] = {
+		N_("git checkout [<options>] <branch>"),
+		N_("git checkout [<options>] [<branch>] -- <file>..."),
+		NULL,
+	};
+
+	static const char * const switch_branch_usage[] = {
+		N_("git switch [<options>] [<branch>]"),
+		NULL,
+	};
+
+	static const char * const restore_usage[] = {
+		N_("git restore [<options>] [--source=<branch>] <file>..."),
+		NULL,
+	};
+
+	const char * const *usagestr;
+
+	switch (which_command) {
+	case CHECKOUT_CHECKOUT:
+		usagestr = checkout_usage;
+		break;
+	case CHECKOUT_SWITCH:
+		usagestr = switch_branch_usage;
+		break;
+	case CHECKOUT_RESTORE:
+		usagestr = restore_usage;
+		break;
+	default:
+		BUG("No such checkout variant %d", which_command);
+	}
+
 	opts->overwrite_ignore = 1;
 	opts->prefix = prefix;
 	opts->show_progress = -1;
@@ -2032,7 +2055,7 @@ int cmd_checkout(int argc,
 	options = add_checkout_path_options(&opts, options);
 
 	return checkout_main(argc, argv, prefix, &opts, options,
-			     checkout_usage);
+			     CHECKOUT_CHECKOUT);
 }
 
 int cmd_switch(int argc,
@@ -2071,7 +2094,7 @@ int cmd_switch(int argc,
 	cb_option = 'c';
 
 	return checkout_main(argc, argv, prefix, &opts, options,
-			     switch_branch_usage);
+			     CHECKOUT_SWITCH);
 }
 
 int cmd_restore(int argc,
@@ -2107,5 +2130,5 @@ int cmd_restore(int argc,
 	options = add_checkout_path_options(&opts, options);
 
 	return checkout_main(argc, argv, prefix, &opts, options,
-			     restore_usage);
+			     CHECKOUT_RESTORE);
 }
-- 
2.53.0-rc2-135-gb1217c0133

