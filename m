Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F289323817F
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 17:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756057402; cv=none; b=l0xnizlx+1IpXd9Ty4d67HLv7qz+48guE6m+y2CSeTMxBU64u6xm+lS5yZO5thpIWwX0dKB9EPwVs+yNe9mUoD6CuSjzjYh620jsN65wdFSj8qmCUX3IRTOcLrbDJJiuwaXNetm25KWshy30bWYqhnt+FLyPFbp4U6Wd8nsP4b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756057402; c=relaxed/simple;
	bh=SkfrJX5+TNktXG1CKUY6F/FR6BSrzOESyL7K0tqMpOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oarEg4VPtumpZVeZRHNWDLJprP3R7rRpPbyAt+WnGoRmKOnfwQrpSG17sFXYQ/TyYeDrhJEj0sYK6ensaqEdrHAdbi3O7uvyXp1D/E8RGUmnLPPfy//SULj6rFpROw4fLXOI9lpuayjnqO6jSP3tqHhpDE1sHu7IPP81LSRQpuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jT/ZVl7c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W2Zkwr/k; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jT/ZVl7c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W2Zkwr/k"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E7FB37A00C1;
	Sun, 24 Aug 2025 13:43:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 24 Aug 2025 13:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756057399;
	 x=1756143799; bh=O/znT507u9ofYZroIj9Ks1Bkx/zA/I7YnVZMGTiRFOw=; b=
	jT/ZVl7cus7iEww+cKe4DzhidaH1YAtOkhI4MpDARzCLBIAiqOmTZV0fbnwejBj8
	sbhO7aijtvCq0TaBJe57CTd9L1oDVMw6ZNFjEJf0zhe+J2eqZcoIFqTwjdGzxUZs
	bP6dtxOmsbTdsqC07F1+27QRK/D0V2TGGuMhwpvrtkmJCqn8U3k29RB0s9KY4NQ6
	tDiMdYAk81u8vjqd1r6JbvgKA6ywWpkvEZytCSo7SiZo1MGeawnmIY84byBWCwzH
	Syn988H6iBPsX6kXSAFyanpOOFvEOupEr7kGgZFVpmP0hwfB6hwtw3+DbKvKZn0u
	fXkq9X9NwaOpV1TuHcUgHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1756057399; x=
	1756143799; bh=O/znT507u9ofYZroIj9Ks1Bkx/zA/I7YnVZMGTiRFOw=; b=W
	2Zkwr/k5m5FACp/I1g7StrfrChtwlze1lk3iCzXdFNPRFyd3rx1FS1Tf5NzhlmKO
	kEcrcETnQB2MvsYeRxTS5w5g8uY9xMyMD55KTjY19DrPnj05NI/F+wbZ2X9QeJRE
	rj2oUan/0/y8Z1vnW/LrQ7tcEWsxL5MV7auQupkeAT9IJamhwmBefPReEKeKdHDi
	SGFysdKiNEw+wFAtNxy+S2QDOkfHYBN+qhm/NyGiU9U1/tH3ds4r+e8skepYS6Ue
	HkmyFyf90ZMrcUvImkvqUUY7arAey4WCn6EZ9Uj4mG4QIrXsUrorSxaTw63KPOwV
	jmZbyBMKhFUqKR7LQheFQ==
X-ME-Sender: <xms:N0-raDWml_kdrr4SjdHP3heBX7vyK-8-zkARDLHwSNAhTzQDok0N6A>
    <xme:N0-raJI-BZ-x0pX9Hb8NZuiBy_1pELF0-ztkNkVSbn4x-_7LewXeNjn977LKMKQVc
    FHFgTrgcxIvrRr9Iw>
X-ME-Received: <xmr:N0-raF0-ukTb7TcOmYIDYqeYMdx7HoiZVCp8rjeqbKYrKwP_5K2nwTqu95IeNewMXeUK1GjZZNBpUefULF-rDKezKkU_YeXs_pznlbd6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedtudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehsohhrghgrnhhovh
    esghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggr
    khhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:N0-raP7vxAJP2LBM98_Uuf2w4v_IMiHoPFZhshciXx5yIvx0oqGF8g>
    <xmx:N0-raO_C7fGvQKGNbqUArNlMkUON5cCGYqlWXs2LZVqSb-5aBulJDA>
    <xmx:N0-raGUVjQmsQ_4HSTSSzkjUkLkDN8qXjvjkL6pQ1_0HVym8rc1wCg>
    <xmx:N0-raBrVz69sJ_C-WuMDPhnh4Oc5zrYd0dqyRqlw24SD37ExEl7ulQ>
    <xmx:N0-raHDWS9Nh8iLVDmwB9fCwicwysXgS7K7fOK3r1IZFqaYbPDyfA-lx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Aug 2025 13:43:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dd76fe1e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 24 Aug 2025 17:43:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sun, 24 Aug 2025 19:42:20 +0200
Subject: [PATCH RFC v2 07/16] builtin/history: introduce subcommands to
 manage interrupted rewrites
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250824-b4-pks-history-builtin-v2-7-964ac12f65bd@pks.im>
References: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
In-Reply-To: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.2

Introduce subcommands to manage the sequencer state for git-history(1).
These aren't really useful yet, but will become useful in subsequent
commits where we will introduce git-history(1) subcommands that actually
edit history.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-history.adoc |  20 +++++++-
 builtin/history.c              | 114 +++++++++++++++++++++++++++++++++++++++--
 t/meson.build                  |   3 +-
 t/t3450-history.sh             |  32 +++++++++++-
 4 files changed, 163 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 1537960374..3e9a789b83 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -8,7 +8,9 @@ git-history - EXPERIMENTAL: Rewrite history of the current branch
 SYNOPSIS
 --------
 [synopsis]
-git history [<options>]
+git history abort
+git history continue
+git history quit
 
 DESCRIPTION
 -----------
@@ -33,6 +35,22 @@ COMMANDS
 This command requires a subcommand. Several subcommands are available to
 rewrite history in different ways:
 
+The following commands are used to manage an interrupted history-rewriting
+operation:
+
+`abort`::
+	Abort the history-rewriting operation and reset HEAD to the original
+	branch.
+
+`continue`::
+	Restart the history-rewriting process after having resolved a merge
+	conflict.
+
+`quit`::
+	Abort the history-rewriting operation but `HEAD` is not reset back to
+	the original branch. The index and working tree are also left unchanged
+	as a result.
+
 CONFIGURATION
 -------------
 
diff --git a/builtin/history.c b/builtin/history.c
index d1a40368e0..0ad45dbfef 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -1,20 +1,128 @@
 #include "builtin.h"
+#include "branch.h"
 #include "gettext.h"
 #include "parse-options.h"
+#include "sequencer.h"
+
+static int cmd_history_abort(int argc,
+			     const char **argv,
+			     const char *prefix,
+			     struct repository *repo)
+{
+	const char * const usage[] = {
+		N_("git history abort"),
+		NULL,
+	};
+	struct option options[] = {
+		OPT_END(),
+	};
+	struct replay_opts opts = REPLAY_OPTS_INIT;
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+	if (argc) {
+		ret = error(_("command does not take arguments"));
+		goto out;
+	}
+
+	opts.action = REPLAY_HISTORY_EDIT;
+	ret = sequencer_rollback(repo, &opts);
+	if (ret)
+		goto out;
+
+	ret = 0;
+
+out:
+	replay_opts_release(&opts);
+	return ret;
+}
+
+static int cmd_history_continue(int argc,
+				const char **argv,
+				const char *prefix,
+				struct repository *repo)
+{
+	const char * const usage[] = {
+		N_("git history continue"),
+		NULL,
+	};
+	struct option options[] = {
+		OPT_END(),
+	};
+	struct replay_opts opts = REPLAY_OPTS_INIT;
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+	if (argc) {
+		ret = error(_("command does not take arguments"));
+		goto out;
+	}
+
+	opts.action = REPLAY_HISTORY_EDIT;
+	ret = sequencer_continue(repo, &opts);
+	if (ret)
+		goto out;
+
+	ret = 0;
+
+out:
+	replay_opts_release(&opts);
+	return ret;
+}
+
+static int cmd_history_quit(int argc,
+			    const char **argv,
+			    const char *prefix,
+			    struct repository *repo)
+{
+	const char * const usage[] = {
+		N_("git history quit"),
+		NULL,
+	};
+	struct option options[] = {
+		OPT_END(),
+	};
+	struct replay_opts opts = REPLAY_OPTS_INIT;
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+	if (argc) {
+		ret = error(_("command does not take arguments"));
+		goto out;
+	}
+
+	opts.action = REPLAY_HISTORY_EDIT;
+	ret = sequencer_remove_state(repo, &opts);
+	if (ret)
+		goto out;
+	remove_branch_state(repo, 0);
+
+	ret = 0;
+
+out:
+	replay_opts_release(&opts);
+	return ret;
+}
 
 int cmd_history(int argc,
 		const char **argv,
 		const char *prefix,
-		struct repository *repo UNUSED)
+		struct repository *repo)
 {
 	const char * const usage[] = {
-		N_("git history [<options>]"),
+		N_("git history abort"),
+		N_("git history continue"),
+		N_("git history quit"),
 		NULL,
 	};
+	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
+		OPT_SUBCOMMAND("abort", &fn, cmd_history_abort),
+		OPT_SUBCOMMAND("continue", &fn, cmd_history_continue),
+		OPT_SUBCOMMAND("quit", &fn, cmd_history_quit),
 		OPT_END(),
 	};
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
-	return 0;
+	return fn(argc, argv, prefix, repo);
 }
diff --git a/t/meson.build b/t/meson.build
index bbeba1a8d5..966d7c14f4 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -376,6 +376,7 @@ integration_tests = [
   't3436-rebase-more-options.sh',
   't3437-rebase-fixup-options.sh',
   't3438-rebase-broken-files.sh',
+  't3450-history.sh',
   't3500-cherry.sh',
   't3501-revert-cherry-pick.sh',
   't3502-cherry-pick-merge.sh',
@@ -1214,4 +1215,4 @@ if perl.found() and time.found()
       timeout: 0,
     )
   endforeach
-endif
\ No newline at end of file
+endif
diff --git a/t/t3450-history.sh b/t/t3450-history.sh
index 9eb1ed6749..aa9d44c03b 100755
--- a/t/t3450-history.sh
+++ b/t/t3450-history.sh
@@ -6,7 +6,37 @@ test_description='tests for git-history command'
 
 test_expect_success 'refuses to do anything without subcommand' '
 	test_must_fail git history 2>err &&
-	test_grep foo err
+	test_grep "need a subcommand" err
+'
+
+test_expect_success 'abort complains about arguments' '
+	test_must_fail git history abort foo 2>err &&
+	test_grep "command does not take arguments" err
+'
+
+test_expect_success 'abort complains when no history edit is active' '
+	test_must_fail git history abort 2>err &&
+	test_grep "no history edit in progress" err
+'
+
+test_expect_success 'continue complains about arguments' '
+	test_must_fail git history continue foo 2>err &&
+	test_grep "command does not take arguments" err
+'
+
+test_expect_success 'continue complains when no history edit is active' '
+	test_must_fail git history continue 2>err &&
+	test_grep "no history edit in progress" err
+'
+
+test_expect_success 'quit complains about arguments' '
+	test_must_fail git history quit foo 2>err &&
+	test_grep "command does not take arguments" err
+'
+
+test_expect_success 'quit does not complain when no history edit is active' '
+	git history quit 2>err &&
+	test_must_be_empty err
 '
 
 test_done

-- 
2.51.0.308.g032396e0da.dirty

