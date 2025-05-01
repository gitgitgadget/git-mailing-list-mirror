Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1172267B78
	for <git@vger.kernel.org>; Thu,  1 May 2025 23:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140407; cv=none; b=aZ2pxe7ql7Ru53ztKkgbksWMvmoX1Lgd0g1oRPVPLwC7TcSwd193MkMUaglxXtTQ8k7A18TJLvLd2xYEtFDPbScCOM3ORY57CJeiTU8Cx/aJzthzbYK3tjyU3VzvT2f9oOHrTBY6AGF21P+f6KcbtiaUWZ26yOAMExddCOwTcy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140407; c=relaxed/simple;
	bh=WPnSu/wZT360BVZ0/5FfSkhdL1GrBlWnfMBppJ/5BOk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3s1Xtz4/v46aSHZTj7JbY2j54aXCIs3avuqM5ayBWJGB1JJdgR9j2wLf9vjWpONf2xEA9HurLGTmjLqTTcclqoFbhvS0DuZIqYD+RB3RJIiGETIL2BUNip9AU9yodNKrX/5iIY6OVnsGbKbzqmFALa5BKUK9VH/4gEW74H7RY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QtAhJDzj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vI9QuNdA; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QtAhJDzj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vI9QuNdA"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B05F01140246;
	Thu,  1 May 2025 19:00:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 01 May 2025 19:00:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1746140403; x=
	1746226803; bh=mPqEbIgcWlSmfDufqWKGLuo3o01JXtCxk65CXXlE3Ps=; b=Q
	tAhJDzjkWwEd22myvvPMaVoP+buYwiNXRZv+x7TMsOjt+f+RA2LbNUBNfK4j/1Qw
	1M5pJhUzV6oSvIeZdfXmEq94a25q8rDb4+3K0g0VN79Tyx8bADkP3UNZBE3bwu2s
	ER03w4nNAtLS1Fr47yeHGnPGU5PUj6Da/UTRlmS/yiVEY+Z4tAnKSIUrUPot6zj1
	FtJecZvHSd7e7nIRFGhBxoK97FLV9TSD+/55pP3Fe60K9O5ZsSQPiFxAPgvR8V/N
	wWudn3kp6i9ihLHevY22WnJ8rVPCH1tGR4GJKJpkrM5G5ZvcO/GReuFkayi4dTKS
	IZfkVUy3am5mMgvL/oqVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1746140403; x=1746226803; bh=mPqEbIgcWlSmfDufqWKGLuo3o01J
	XtCxk65CXXlE3Ps=; b=vI9QuNdAc52YbFFJ5QVzW71ZC2anGhFViV3QRRmS8WBn
	vbK3lnBSQ63Vfvh7Fu2LijsHc+R7M0PHmMub/HW5Ih7rN8FMrfFLDaQVq3VFgBjV
	GVEEtvlMlVqiFB1wFkRg+hK2iKZuGGMEeuTFzYGSv8K0ikI8KwvU1iugPaXrZKLQ
	tooA9WSZtfAQ3C6QkjUP19HKcjEVmBWSixzZSM6Q0DY9aT5mhJwvo/G5inybOUja
	gyAFt263pGs6W9RJa+LMpexvUpxabUPjNHKnKNDPsDE/baA3CQFVfeCsqM08hEeZ
	jyoE0X/lt20fxgiaB+81bOBTJ6wRBwrmEoatMB5NWw==
X-ME-Sender: <xms:8_wTaOx7qLOaRvPYYBI5I50v04A-Cfz7ZfJD1H-8hYPw2Or1aa_Vyg>
    <xme:8_wTaKTnmAtUfqERqBj4BR3ZQv_Ndo-N9Ga8Cm0N1vGQGBiheJL55wqDXvDRuPA4D
    HCV_vNBb49PCQgvmA>
X-ME-Received: <xmr:8_wTaAVRyApTNb1qifhrtYpMTBO-mXfZOvdPDF64NVhdzdEsLyZwfQ4aG3XHyD3iq4iCDMUQzmQOfKa5KuTtXyrZ-TcDPXr_kp5B>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedtkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheple
    evieefieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:8_wTaEhplNuchlTISNVfum9qGnAJ_IvR4aPi2IVbkDSV-ZgcdjUKXg>
    <xmx:8_wTaABIa4-yTZdz9xM1KIrKOYdDDTv1PLe8RY2BTtQxOivr3lwZvQ>
    <xmx:8_wTaFJERFTQzaJCOVBmkTkh6Bppm6g_sH8GO3ZLwOr9VmVgdpRzRw>
    <xmx:8_wTaHBUqMCXagfIYGUMMPbGmEk9zsSL8vXjerCTWNgT_phyAD3uLg>
    <xmx:8_wTaCz8BS9fzgAno0x94m69E5QBOiDn85-3uZJkWqDO1xOaANWW17XD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 May 2025 19:00:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 1/2] you-still-use-that??: help deprecating commands for removal
Date: Thu,  1 May 2025 15:59:57 -0700
Message-ID: <20250501225958.2947677-2-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-599-gc9a5c860a0
In-Reply-To: <20250501225958.2947677-1-gitster@pobox.com>
References: <20250501213452.370729-1-gitster@pobox.com>
 <20250501225958.2947677-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A command slated for removal like "git pack-redundant" gains a
command line option "--i-still-use-this", and refuses to work when
the option is not given.  The message and the instruction upon
seeing what to do are both rather long, so before letting another
command to use the same mechanism, factor out the message+die part
into a small helper function, and use that.

The existing pack-redundant test lacked a test to make sure that we
require the --i-still-use-this option.  Add one while we are at it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pack-redundant.c  | 10 ++--------
 git-compat-util.h         |  2 ++
 t/t5323-pack-redundant.sh |  5 +++++
 usage.c                   | 12 ++++++++++++
 4 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 3febe732f8..6dc9e020c7 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -625,14 +625,8 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, s
 			break;
 	}
 
-	if (!i_still_use_this) {
-		fputs(_("'git pack-redundant' is nominated for removal.\n"
-			"If you still use this command, please add an extra\n"
-			"option, '--i-still-use-this', on the command line\n"
-			"and let us know you still use it by sending an e-mail\n"
-			"to <git@vger.kernel.org>.  Thanks.\n"), stderr);
-		die(_("refusing to run without --i-still-use-this"));
-	}
+	if (!i_still_use_this)
+		you_still_use_that("git pack-redundant");
 
 	if (load_all_packs)
 		load_all();
diff --git a/git-compat-util.h b/git-compat-util.h
index e123288e8f..21cab99567 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -703,6 +703,8 @@ void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
 void show_usage_if_asked(int ac, const char **av, const char *err);
 
+NORETURN void you_still_use_that(const char *command_name);
+
 #ifndef NO_OPENSSL
 #ifdef APPLE_COMMON_CRYPTO
 #include "compat/apple-common-crypto.h"
diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
index 688cd9706c..f2f20cfa40 100755
--- a/t/t5323-pack-redundant.sh
+++ b/t/t5323-pack-redundant.sh
@@ -45,6 +45,11 @@ fi
 main_repo=main.git
 shared_repo=shared.git
 
+test_expect_success 'pack-redundant needs --i-still-use-this' '
+	test_must_fail git pack-redundant >message 2>&1 &&
+	test_grep "nominated for removal" message
+'
+
 git_pack_redundant='git pack-redundant --i-still-use-this'
 
 # Create commits in <repo> and assign each commit's oid to shell variables
diff --git a/usage.c b/usage.c
index 38b46bbbfe..4aaad2b553 100644
--- a/usage.c
+++ b/usage.c
@@ -372,3 +372,15 @@ void bug_fl(const char *file, int line, const char *fmt, ...)
 	trace2_cmd_error_va(fmt, ap);
 	va_end(ap);
 }
+
+NORETURN void you_still_use_that(const char *command_name)
+{
+	fprintf(stderr,
+		_("'%s' is nominated for removal.\n"
+		  "If you still use this command, please add an extra\n"
+		  "option, '--i-still-use-this', on the command line\n"
+		  "and let us know you still use it by sending an e-mail\n"
+		  "to <git@vger.kernel.org>.  Thanks.\n"),
+		command_name);
+	die(_("refusing to run without --i-still-use-this"));
+}
-- 
2.49.0-599-gc9a5c860a0

