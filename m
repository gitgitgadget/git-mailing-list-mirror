Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA66E20408A
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 15:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905861; cv=none; b=QrlUffVvmA93p7KnbgdW5cCigS7JlXPCr8wGaL1aeK/REoOFSh3TSd+nMIoZvEvC613TMcLYS9ndYsIX36q5FOaJ45h01+elueGLOqOdw2VHF294BLNcPsZMc6X+JBNh6M0Cpn5ZzQbGawPAXJ34Rpdu687zU7NchB9jLofmio8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905861; c=relaxed/simple;
	bh=SrK+5qkyOWcyUh0/VHLc/mHOVBoqx7xSUJybG1FZo1g=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwbh2fazaieac6h2CEnQGZSLIsZLEJlTNKrAV3/ja6TeCSpjX2f7LrDO68gEfdD5bl/me+cfIdqmeF5vMStGHt7vHyeeysKDOn9jLoPYa9EmFs/Msb3Vs/LVMvS6TpKV7Szj42g+fe2ltX0EuC9mm6H5nXz2PwW/1E56XIOP7c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nof/PbqB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CK/IdXs7; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nof/PbqB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CK/IdXs7"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id BC2D51380689
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 10:10:58 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 06 Nov 2024 10:10:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730905858; x=1730992258; bh=4vMHyFLCY/
	PuK3weqTrAbKwSBDpX20gDbrQIQ8b4lHM=; b=nof/PbqBpgzrvgO1GQ+RjjxNYV
	BeKVlp7fATmeEkFzFu8baaZxZrNr7mkmBtMbE+kjUYoCxNwsFSxF+rhBsHUA7kCI
	pbu/NWxoHs3OVbsBoSpoboGKEw6gVlVVmBvMSGMzejY3GZjCG4woefahPTLCPCsb
	7h7lcuznv8LGtPGe1lDL9GR8hDjPPKLj7qhtluylr1qCjDXSVtSL9TIVo9kj6/SF
	ZYwtiLMcXVjkCfBE/GnFxUyT+fStmrDW3fktTXU8z54mmFwgaVRShUT7wlQiJrVl
	zKVyPtZ/jkPgih5PVeKUkRMAv71MfEFgVotAshwV7LYfVbB6xVhSSmdWJ4JA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730905858; x=1730992258; bh=4vMHyFLCY/PuK3weqTrAbKwSBDpX20gDbrQ
	IQ8b4lHM=; b=CK/IdXs7VvOM+KDFduued/VjbWZMMjr/kmCvejy8CUa4ZKapsZj
	c3bPPWnpe6BgWl0ET0UWC90g50FP8L6TL31Xq2xRBPw3ANqRZe/zV8eBHp9YCCx+
	EjBJ6V9+waM8YHWVTOQCYDEEImgl5ZwaDee3+lDP2hlfhHUPKRk2U0ZdZGoI/0DC
	lLijka9TSD/2Va2UOWXsBBJnCGcxx3Ul6Dy+Du/7iET0g3sRX+z5F9VZAabSx4WA
	Jr3M14UiJoExnSD+QYswfAAurZTk69CEUGPkS/XKtp+9vZkSsOw4+LedUJ6MLDQo
	dDNQLfLcaSoZjpqOCaxTN9vel2mlfCTBQEA==
X-ME-Sender: <xms:AocrZ5pIt7tOBMdBZ2kQAiLuFsXwC7ZByrupqkb-ydOnzXZ_7_dPfg>
    <xme:AocrZ7phMloxfvuxZXQgbj__6wYz1RyEHbXLXZYsco4QYRUZVtRP10p8r3ZhZpPvc
    gw_zJdHwHyZP3wQYQ>
X-ME-Received: <xmr:AocrZ2MQGQYgxkXrqQCqzXwdnjEf8ZR6YuzVuSV6Ho0OdIe1-Fvutdh9J-Gpw8xOBkDF3nVApgnRq-R-SeBZYXb68uIu6XD629iYtSTCHq0REg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukf
    hfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeeggedvge
    dvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghrufhi
    iigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:AocrZ05YjFddKDkjBoN2g8eNSjodi0bV1_nn9dqrFif-PsJ9fk2qSA>
    <xmx:AocrZ45xQ6YJfqm0YwfNYSn7X0v_b9nN25D5ygpey2rD8uJ3DobMnw>
    <xmx:AocrZ8iJi7YpH3gTY30zXMgSFClXL-cmWjX6ViHzg5zFG670jLSm1w>
    <xmx:AocrZ67rMP6vxgmG-VLf_auj3e8ODYvvQp1h5-3uJiWLS-o_pFGfVg>
    <xmx:AocrZ2TfjMRFAMC5SfVXFWLZFa3KHdZ_U6bIZZfLRXGHqHDoCmWo6kFG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Nov 2024 10:10:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 668d6c2f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Nov 2024 15:10:33 +0000 (UTC)
Date: Wed, 6 Nov 2024 16:10:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 11/26] git: refactor builtin handling to use a `struct strvec`
Message-ID: <eae8f7e223f9ec9cbb35a001be75536fbcbe8c66.1730901926.git.ps@pks.im>
References: <cover.1730901926.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730901926.git.ps@pks.im>

Similar as with the preceding commit, `handle_builtin()` does not
properly track lifetimes of the `argv` array and its strings. As it may
end up modifying the array this can lead to memory leaks in case it
contains allocated strings.

Refactor the function to use a `struct strvec` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git.c                  | 66 ++++++++++++++++++++----------------------
 t/t0211-trace2-perf.sh |  2 +-
 2 files changed, 32 insertions(+), 36 deletions(-)

diff --git a/git.c b/git.c
index 88356afe5fb..159dd45b082 100644
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
index dddc130560b..91260ce97e5 100755
--- a/t/t0211-trace2-perf.sh
+++ b/t/t0211-trace2-perf.sh
@@ -2,7 +2,7 @@
 
 test_description='test trace2 facility (perf target)'
 
-TEST_PASSES_SANITIZE_LEAK=false
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Turn off any inherited trace2 settings for this test.
-- 
2.47.0.229.g8f8d6eee53.dirty

