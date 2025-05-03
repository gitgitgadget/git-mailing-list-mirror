Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C9C17741
	for <git@vger.kernel.org>; Sat,  3 May 2025 00:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746233901; cv=none; b=LCEumWYJEvABcj18RNMWs8GRMoI4RfyjYw2cfC/pgucQm0qyBWQnlUe92jzt5IIydDYvCSJvZ/jiUhwp7om3tZeBLjIWLIYV29wLWhrMza0EgsW2b/QF13M3bH6gBA3jZySZBs+TsrGygXpoM1R7S5vzw167Q/GBCsd8ImlB/T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746233901; c=relaxed/simple;
	bh=qTgbiRSNUDtjBGZaDaM4GGXUdE1R3V1y+ObCLxYxRCo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=laScxtXUaDTxvZ3zXSW2KjtLzAeLq+RzhzNqvYSupkoYl768s3C6Fv6x27NZlrWCdCYPg6cAVkrGjGjrRF8+oDebQU0o0qp8C7BdxwJREuBuZzehNW+yFRalOh5ArfSx0+oRvtX3Q3pP43vIZx6L/9aIc83nQtaYVKBH0R8F4N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=liKQE1aR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SSWWJfy0; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="liKQE1aR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SSWWJfy0"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DA5D511401ED;
	Fri,  2 May 2025 20:58:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 02 May 2025 20:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1746233897; x=
	1746320297; bh=+PRMeR1rRg1iStQfkxK8UJ+l0iDAT2WVf3s+OfY6gtA=; b=l
	iKQE1aRDB990jA8ZwSZOfBY9TZs8KQwwFX2JrmrpqzV0phFdY13s+5qrKYoiMAUL
	euMHtLvNRqcBt36OsW6G4gV1uWq2PsZiu2LIGveAsovJtys8gItNhbBT/+p/yZq7
	eOwa8I1/Q4BBYU9Qc4GCB1OLhduQZJSxnpkP15WS+FmAss0yt8ZbNPV974xoKqVm
	F0Ft1a4k6efmZH8N7UUCYbhYnUuLnRpT5k5MgLVI14vXucFtjtFvan9q3anmKGs5
	l6XkDYXv2f8G8YMdgyZJGkQuaD6sPQlxnUQfIfLpwgjb5eZi3XfWRAz/ppVN67yf
	mjpepDAG/ozHr5cMVDcBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1746233897; x=1746320297; bh=+PRMeR1rRg1iStQfkxK8UJ+l0iDA
	T2WVf3s+OfY6gtA=; b=SSWWJfy0GhdLEAPsd+xYJtdPV+H1KTFDXnZA6AYfVQhq
	0e32+6USG7uIO4P+SmEg/IZgzU/Hcny2OTNDK/fNL65HoE+S0YzENjFN/NX3Jfpj
	gPJFJV3jmzKQC1DGL82EB/3c/YhC0PclEYXpH/af1QrrG/LYCk+zkJavimiyP+8P
	4iC+HhrGrmbhBHdLfu873reNw02AjxyjULJCwUnAO8V4RwMcFpflnjuNeBZn9BHD
	aWCjfPwjrJe1z36FQGdaGeM1bmJZitFBtxODnxnXZSPgi0vX3NW95kETXrn0708p
	AHdoAXUcO+DfsJzg0djuh9cafD+7nlfjxWHW/rZGCw==
X-ME-Sender: <xms:KWoVaH3m3vqm13E0fLfQevIT5bogIlNlGxef6qPs13gN2QGjVtt7UA>
    <xme:KWoVaGGNLj2pzs-u2zpSzGelqgczQoFAf5D3HQ6JPtimW4_COyNXMT28wTB4h5-4G
    vZcWqcXVcG-9jI-wg>
X-ME-Received: <xmr:KWoVaH6wo0pJzqV0xf9Ts5f9b4fklD_gbYOccEWEKUb0CU007PRu1D7MVkUZqYxu9vnETiLWinXUPzF6ESs8MSOL11-ZPbm98cjL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeefleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheple
    evieefieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:KWoVaM3FThUlgsJCeCu5dg94sa6XCmDoAUJtNy8dx86iPCjT7lh6Yg>
    <xmx:KWoVaKEqgDNr8dsexK9GlRX8M442kn4PWB9P2ePLqmMPVfx55u7MDA>
    <xmx:KWoVaN9oMX9mbLxYpfPBYzdAamETX_eBhBb_-7-UvKAdjVxNm-X7kQ>
    <xmx:KWoVaHmScw4gEiVE3cM5_4ZFu6HGUKA8S20sSA9ONID5rpZ7pgy6Bg>
    <xmx:KWoVaD0DAmSJq1EvuXJKP9ApJIEJxpMK5byX0X-RPiJQ_ykIMMlnc_Lf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 20:58:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 1/6] you-still-use-that??: help deprecating commands for removal
Date: Fri,  2 May 2025 17:58:09 -0700
Message-ID: <20250503005814.3030099-2-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-601-ga5925c3955
In-Reply-To: <20250503005814.3030099-1-gitster@pobox.com>
References: <20250501225958.2947677-1-gitster@pobox.com>
 <20250503005814.3030099-1-gitster@pobox.com>
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
2.49.0-601-ga5925c3955

