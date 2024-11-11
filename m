Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF0518BBA2
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321539; cv=none; b=ItwREOPyocjD4/Zuv1EQJhE+2KtEa0QmZMUn05ZcptYI6CYx1MlRzGLkx7vyByAXoslkR6BpJVA2t1pLerOjhcrG0Q8yBtuB7OZdx+t7SqWeyXEENykMiea3FN8raj4xcDtaiuAq+3pKJH5mfalfQAu7qwlkyqqOTMkRGkZ8b0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321539; c=relaxed/simple;
	bh=knlp0THUKFyxiqVZA9qNqTpNztKZO1YQH/w8NXuvVoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kM+MAL4WNou3ZxBkrVQMk/PpyZ/hp1mlAYxvP5y7pDWUWmRP99ZXiiFvCC/U6mdz9QKskX8QgXQxYPOysM3/woWTWdIWtwVbRpKygkME38LM1zHd+0ph6/pFGrkyyWatRSZqgerapV1B0HFkYB6tzAVwCCnS+2jVuWs/JjqaDFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SQs/l/ko; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WH5bEhdz; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SQs/l/ko";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WH5bEhdz"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id E846C1380687;
	Mon, 11 Nov 2024 05:38:56 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 11 Nov 2024 05:38:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731321536;
	 x=1731407936; bh=kPs9Rg8xOloABvi8amjp6/f1ZNDtvO6HAiTIMKQdy+g=; b=
	SQs/l/ko15Narnca/P7TXgh5CMwx/+Pr2HNBvUov5tgdvFJUKbsHM9Phd14NfVwO
	mffBnX1YIaaEkwcEfne+NhcHvIwXIjtxi0HYDdPTHfs1hrEd5d7nUXsq/kq7VONg
	0mvTP7YsRfE+oFJtkaOlv3dA2udjeV+aOjqqynfkGUphLXagm7PtRd4ixwzzcxa8
	LhXphWlPdzoxtWgv8dnV9vwjcVdnc/qWNeXUgnadWuAOb7RXxSB5yZcFa8+khmQf
	vJBk4CFc2ao/wftCGO84a+1aCirUzhxHPWHlSNbYthZBJSEWmAyMXe4QfoMTP576
	cFsfwgQyNQUFT1pbc9I6EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731321536; x=
	1731407936; bh=kPs9Rg8xOloABvi8amjp6/f1ZNDtvO6HAiTIMKQdy+g=; b=W
	H5bEhdzfdT0T+fEdSQfxklxvhY8HasXM38yFilJAuJS0Z/hmaJUT3yzHlcUp2ZtL
	yoW5FWmZYfldgtvEvDf545w9fSa11iUnX7RjuWlxzdviHPuOm15UiFn6XZzQ6XOb
	Stk6FR/DGV+A4DATFmuPaqL4N/hp7DAoF99UOzoY846qfMh7zxVPrWfQkr2jnjsl
	ivFxJq3xL+4781qK9YM0NDzkLXoZZQZzI/eZuqD0cs15T5Smy5OsUQMBY2dzslUz
	I+JLZY68dYgNHWery2jRk9Afatya7b/9rw/9998G68zXMcF5mGFnAcV63J+eFMF3
	aWw0YqLEjOc9ghEJfrWtg==
X-ME-Sender: <xms:wN4xZ-1F2II5jGib9coHKj5nW04-SxfafPXDO0f8L6ClBdG6vTDM9w>
    <xme:wN4xZxHQWknwjTfxz84qov37BshLS_MYHJnEMfDtbcNNInxrN0MvDQSrQpV03V1ox
    7eSfMSc8rVHkMqwFQ>
X-ME-Received: <xmr:wN4xZ241plfo1VbEVv-j6szZgSgMXlPDN0qUl5Oc2rmQZ4jzV7Hvbs60b_w7hVl-dXVym29eOPY0-O_sqzMcy2vmXrGQsjSIWL2s8MkFjYr7XogL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehrjhhushhtohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:wN4xZ_3_EJAJyuGA4PXWM32nbkmuMtTjruhmKLG94F5cIVKonHIxQw>
    <xmx:wN4xZxERujyE4exBA5-tBo37GusHM8a_FFH6Ueng8otA3O9t9Hq1Ag>
    <xmx:wN4xZ48mIQFVWHwjzXnFS1A2ZvdKdvWybD5m8YCtsZBbfYt59Dvz0Q>
    <xmx:wN4xZ2l2M0SXE0d4Nf9t4xCoRXwX-YFTmYQTME7YBwElWRSacZ_-XQ>
    <xmx:wN4xZ2TP1SfKNoxrqfX9TM2C_e49T9-HBdIiAjVOYW8gAyO0GXp2cK84>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 05:38:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 910f0a28 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 10:38:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 Nov 2024 11:38:40 +0100
Subject: [PATCH v2 11/27] git: refactor builtin handling to use a `struct
 strvec`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-b4-pks-leak-fixes-pt10-v2-11-6154bf91f0b0@pks.im>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
In-Reply-To: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
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
2.47.0.229.g8f8d6eee53.dirty

