Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCE71B4F31
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 13:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732110000; cv=none; b=Yn972Pk/3G+Q67x+TdeorxH65L7isq4RN3ATm48e9/i4N91yLvwP8PFzfcTufzR0eIipE+h3PJYeDuh8ij1M4J8BTrifY7M8CL/CMkSEoVGnCsNqLojeJsR96ZRthxFG5ybJVTyw34ibzlIHQ/6VaFd8rbHVTe9SAcyFiS+GcyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732110000; c=relaxed/simple;
	bh=Fudpz5Qn4J+rWmcI6YDmCrElS+pzhTPInRWbtQSA76U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bWwWnLpbmrW9M+dYGQGPMGd0K18DD7eYl+flJWygblbFRoTH0vWPmv8LJC8R/CCDXqHgTi+p37ZmL7eOFFQHtSGnlKGaj/jGb4XqFyMuywIg5n2sanlPBFuiAmXN8n0glEbc/XQHawWL35Gr+thXBnFEMPTCAKN/CMQPS106T/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jSPKAXBR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KE/t4tfX; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jSPKAXBR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KE/t4tfX"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 2FB0A1380368;
	Wed, 20 Nov 2024 08:39:58 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 20 Nov 2024 08:39:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732109998;
	 x=1732196398; bh=AYpl/qE4JAi26+pjMbG/Hkl3RW3anKoO5tHkJoZT8vU=; b=
	jSPKAXBRbonhj0oK5D/f0Puscu7uanGQOs5hdmmgVgmih0XFvu/br3c2GPJ2pklh
	tu1KysQJl0p7TvAs6AMVZu7Yg0XxHRDqYIsaItDfCYxbapTBsSKFl/oVfaV82IRO
	qAPEk9IPgbkCicsFLQHC/n9EAuoikyoxPZIbNY3W1vc/nSqask7XKlV1+qWGqpC8
	pQl2t4g27VOhrZCv1s6eeAvnrTZfaYXSYn1me7ofKZ5ZIih1g1W0BOTbSVwH030q
	GxaszP/QU8w+8/HokARdw8uGvrj+6Y9Tnmow7ZE6NCQ0azMuKUy15Tw2slVHj287
	UFKAEBOAtNTKUt09NbYWBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732109998; x=
	1732196398; bh=AYpl/qE4JAi26+pjMbG/Hkl3RW3anKoO5tHkJoZT8vU=; b=K
	E/t4tfXHecX5/vz8Q/M579XzUM2acXglVEP5ikYvDHojDMGzZTGt/PDUgcTQsu2e
	+agb7C55wyvW6I6qSaQNnhBHahtoIORMx++dQIOA2KubwGsh53NtupB3xWt/R6mh
	0Ei8zr+M5wMsDECCGUljt+fi6vF7eouLXkolSaZGTaScSU0xrML/q3yigscgFMWe
	b1PpVrM1rFiWG3yABetquRh1O+3wyEGXKRYsSSy9DjM9kDCJuwlffmd7E6g2ZG7B
	/YUv8J/m04inATLMVOB9Dmx4/Y2WijBQvw02ayi86wfobnAU3f6zCC5Zmw7ed316
	oF+eyG43BbTcVOr0iY1uw==
X-ME-Sender: <xms:ruY9Zye7Y128TeLLaiSto_eYxwcEOWWbL7wCrGhlsVrHeHEs4uHi6w>
    <xme:ruY9Z8PVhf-HFkrZu_DVuXhRPu1uwYg25DvemgB9NqkCV00HXKYPzbYyHFoLrNphY
    3Pzt1Grg1LxPliYPQ>
X-ME-Received: <xmr:ruY9ZziOLSveOloet6zHoXBQrVoGmv8wRroESPA9lFH-Qhkq4Cjw-49Rw3fFbiJmjXKk5gh0tk4Uw7lR7XYgU5OE6WGSes1GcifRYaM4QQcKPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    htohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehrjhhushhtohesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ruY9Z_9Jr0AW4Vyubi1Li4XX6dPj8pQIuX8-k1Oc78WxTyGJuoNrcw>
    <xmx:ruY9Z-tfdZzRQayTF9202Py86qM94xuzevfuhxeDF52CrxLIqiIDqw>
    <xmx:ruY9Z2GVscm1RB7Ft1e4QxmmwrYBs5RSS_RVkiT_mkC4pT5uNf1g5A>
    <xmx:ruY9Z9NR27Jk0P_411B4f7owKvlw3jSs96KYuTfCvxMkDELl6oYx1w>
    <xmx:ruY9ZwIoiHvhMWmiklzVFvFuDiO0tFPJkSaaAU4JoEO6z8BP898lvoKp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 08:39:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e6978139 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 13:39:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 20 Nov 2024 14:39:40 +0100
Subject: [PATCH v3 11/27] git: refactor builtin handling to use a `struct
 strvec`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-b4-pks-leak-fixes-pt10-v3-11-d67f08f45c74@pks.im>
References: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
In-Reply-To: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, 
 Jeff King <peff@peff.net>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

Similar as with the preceding commit, `handle_builtin()` does not
properly track lifetimes of the `argv` array and its strings. As it may
end up modifying the array this can lead to memory leaks in case it
contains allocated strings.

Refactor the function to use a `struct strvec` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git.c                  | 66 ++++++++++++++++++++++++--------------------------
 t/t0211-trace2-perf.sh |  2 +-
 2 files changed, 32 insertions(+), 36 deletions(-)

diff --git a/git.c b/git.c
index 88356afe5fb568ccc147f055e3ab253c53a1befa..159dd45b08204c4a89d1dc4ab6990978e2454eb6 100644
--- a/git.c
+++ b/git.c
@@ -696,63 +696,57 @@ void load_builtin_commands(const char *prefix, struct cmdnames *cmds)
 }
 
 #ifdef STRIP_EXTENSION
-static void strip_extension(const char **argv)
+static void strip_extension(struct strvec *args)
 {
 	size_t len;
 
-	if (strip_suffix(argv[0], STRIP_EXTENSION, &len))
-		argv[0] = xmemdupz(argv[0], len);
+	if (strip_suffix(args->v[0], STRIP_EXTENSION, &len)) {
+		char *stripped = xmemdupz(args->v[0], len);
+		strvec_replace(args, 0, stripped);
+		free(stripped);
+	}
 }
 #else
 #define strip_extension(cmd)
 #endif
 
-static void handle_builtin(int argc, const char **argv)
+static void handle_builtin(struct strvec *args)
 {
-	struct strvec args = STRVEC_INIT;
-	const char **argv_copy = NULL;
 	const char *cmd;
 	struct cmd_struct *builtin;
 
-	strip_extension(argv);
-	cmd = argv[0];
+	strip_extension(args);
+	cmd = args->v[0];
 
 	/* Turn "git cmd --help" into "git help --exclude-guides cmd" */
-	if (argc > 1 && !strcmp(argv[1], "--help")) {
-		int i;
-
-		argv[1] = argv[0];
-		argv[0] = cmd = "help";
-
-		for (i = 0; i < argc; i++) {
-			strvec_push(&args, argv[i]);
-			if (!i)
-				strvec_push(&args, "--exclude-guides");
-		}
+	if (args->nr > 1 && !strcmp(args->v[1], "--help")) {
+		const char *exclude_guides_arg[] = { "--exclude-guides" };
+
+		strvec_replace(args, 1, args->v[0]);
+		strvec_replace(args, 0, "help");
+		cmd = "help";
+		strvec_splice(args, 2, 0, exclude_guides_arg,
+			      ARRAY_SIZE(exclude_guides_arg));
+	}
 
-		argc++;
+	builtin = get_builtin(cmd);
+	if (builtin) {
+		const char **argv_copy = NULL;
+		int ret;
 
 		/*
 		 * `run_builtin()` will modify the argv array, so we need to
 		 * create a shallow copy such that we can free all of its
 		 * strings.
 		 */
-		CALLOC_ARRAY(argv_copy, argc + 1);
-		COPY_ARRAY(argv_copy, args.v, argc);
+		if (args->nr)
+			DUP_ARRAY(argv_copy, args->v, args->nr + 1);
 
-		argv = argv_copy;
-	}
-
-	builtin = get_builtin(cmd);
-	if (builtin) {
-		int ret = run_builtin(builtin, argc, argv, the_repository);
-		strvec_clear(&args);
+		ret = run_builtin(builtin, args->nr, argv_copy, the_repository);
+		strvec_clear(args);
 		free(argv_copy);
 		exit(ret);
 	}
-
-	strvec_clear(&args);
-	free(argv_copy);
 }
 
 static void execv_dashed_external(const char **argv)
@@ -815,7 +809,7 @@ static int run_argv(struct strvec *args)
 		 * process.
 		 */
 		if (!done_alias)
-			handle_builtin(args->nr, args->v);
+			handle_builtin(args);
 		else if (get_builtin(args->v[0])) {
 			struct child_process cmd = CHILD_PROCESS_INIT;
 			int i;
@@ -916,8 +910,10 @@ int cmd_main(int argc, const char **argv)
 	 * that one cannot handle it.
 	 */
 	if (skip_prefix(cmd, "git-", &cmd)) {
-		argv[0] = cmd;
-		handle_builtin(argc, argv);
+		strvec_push(&args, cmd);
+		strvec_pushv(&args, argv + 1);
+		handle_builtin(&args);
+		strvec_clear(&args);
 		die(_("cannot handle %s as a builtin"), cmd);
 	}
 
diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
index dddc130560ba6150fc5f5eac36c65ff76a2d31a1..91260ce97e5bdb39550a9e1e4abbc4d5fea48a21 100755
--- a/t/t0211-trace2-perf.sh
+++ b/t/t0211-trace2-perf.sh
@@ -2,7 +2,7 @@
 
 test_description='test trace2 facility (perf target)'
 
-TEST_PASSES_SANITIZE_LEAK=false
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Turn off any inherited trace2 settings for this test.

-- 
2.47.0.274.g962d0b743d.dirty

