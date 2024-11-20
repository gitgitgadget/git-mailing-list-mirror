Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB401B14FA
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732109999; cv=none; b=kcmmj5FvLwgeR+zL+brRBD0o/RsWfAhXxtPeE6iYG4/i48yXXw3mxgfMvQ7nfKGzlu7+DDHd2tzsCLygDNLJul4hXx9rqU6RwHEUT7V3mtg8v3VRRoWvnS8H/go22CK6/ejn8e0dKzzYAicwWaevgEJBGG1E3+buF8AxyeC5ShQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732109999; c=relaxed/simple;
	bh=uDsfIyzOqhRaI1hHN3EyB73JolkuLsTmZOfl6azHWok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VAxd28NiKusHfHZ2ElEPQ1QHTWTFllQCFr77+aB9VMclIMSBnJx4Va/RHcoGB0OqhUjmAtkGHNQSh+lvwFbpUetSgsgKkWiyHIi2LUjhZ4PAIRqqav78/lM46G9WvJmlpnCFA23w+XtIGxqMPYCbY8zbORveG2hOUU6xpTyoN1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UKwxdzk9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DFcMPiS0; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UKwxdzk9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DFcMPiS0"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F3C1411401D6;
	Wed, 20 Nov 2024 08:39:56 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 20 Nov 2024 08:39:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732109996;
	 x=1732196396; bh=ypWLjsRXdjoDZ+6Iwy4R6AkAX7BogZLubrzLsLdORAo=; b=
	UKwxdzk9uPlTpv4lkvep+yLqoyBMZJkl/D40LNcsHlw7Ox730RtfC6egui/uoAK0
	ZleSyJhi5oKXArElgbuh+mc4bUbPTqsMzNnigx/oUYQ0YuVzk3V5qLP/dzp5qjT4
	JZWZbof2QvgXJaWCBb7GsFdsmkSjq21FrrZGAYvExZyIsu6UBDJrg6TY4Be3Sw3s
	imOndieyDAyiW2n5ZLr8JFoY1nchbE9diltxcY2qUKBVITT9W8HeR7qN4XojWk42
	r9RCpoBDwIKtVg0+6kcn0WOIRnINrHOglCnDaHqpgGo0nVAuNO/1D+ikVlvnFrL5
	jge0JtYvsHvQzcDCP6T4og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732109996; x=
	1732196396; bh=ypWLjsRXdjoDZ+6Iwy4R6AkAX7BogZLubrzLsLdORAo=; b=D
	FcMPiS0DR81hACiMyYY53XhjLrm/0mSgOcF65AmRPms2zj7N7XiWGj916U9uexZV
	z2ZmaT2UX+pJXYYfks1DdCvg1GeiA3OARCTTAL9yG47bA9pUPNuLGMhn386DzyCF
	f6R68w1A2BE6ZSxbT+IAjwOwSWm5fA4FKxq6r6ulRdjN8Dn7xHodmtTXHQitdX+m
	Xqq/SyeQDGogrUs6S2bGnEMefq5QpnKYZ3qga8mr4ZQ53Tx93bX4tjjdi5BEvZDA
	+WKpMuXJUIT4HnJPsUKD14OWYXktYlCmeL6eDzlZ71oQ+nEkjAm/xfh5V2/+4YBt
	7x/jTOwRSjpbKGyEamdwA==
X-ME-Sender: <xms:rOY9Z3Y6XnNQjy5h1PcTnfsKh3UZjpNU3ty5qO2Hmwb0iXwHKkGprg>
    <xme:rOY9Z2YEY0hqiAHE0nJ6TyLmPmml0snQwN3ee_q2q5ptn0CbgkJufv2_6KhSBBMjr
    kYU9Tnl1a-zzcONRA>
X-ME-Received: <xmr:rOY9Z5_bhEHaTPDNLW7_ziTEqNyXiBlNNWgWHlIHm3lYFtd8lMCvb5glTIRx61KAWcJQvgdrcjg5TNcpMVYxNarmTji8xhmmVp5wdSG8bDwInQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepthhoohhnsehiohht
    tghlrdgtohhmpdhrtghpthhtoheprhhjuhhsthhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:rOY9Z9rIWeAJD0yMSjf3bZovN7Nigrl5wXRjdj6FS_SIqnpFWwQo7g>
    <xmx:rOY9Zyol6qEtEDn134kVYvfzAU7oK0RwTvPOpMPkyvijTtYFyIOO8A>
    <xmx:rOY9ZzQrtH2mqzdgFBRpOIZ97Wr_DrivU9yPsAriz44kx9Q4kb1SRg>
    <xmx:rOY9Z6quFMN3ldBwmXJ34CQkNf0geZDdkU_Hq3frSd5yCVSY1Xmcfg>
    <xmx:rOY9Z7moqSec986Ws--rWeMuhztyLuRaNGYnCBVzylwdclQedAbsQeu_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 08:39:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 93cff5e2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 13:39:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 20 Nov 2024 14:39:39 +0100
Subject: [PATCH v3 10/27] git: refactor alias handling to use a `struct
 strvec`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-b4-pks-leak-fixes-pt10-v3-10-d67f08f45c74@pks.im>
References: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
In-Reply-To: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, 
 Jeff King <peff@peff.net>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

In `handle_alias()` we use both `argcp` and `argv` as in-out parameters.
Callers mostly pass through the static array from `main()`, but once we
handle an alias we replace it with an allocated array that may contain
some allocated strings. Callers do not handle this scenario at all and
thus leak memory.

We could in theory handle the lifetime of `argv` in a hacky fashion by
letting callers free it in case they see that an alias was handled. But
while that would likely work, we still wouldn't be able to easily handle
the lifetime of strings referenced by `argv`.

Refactor the code to instead use a `struct strvec`, which effectively
removes the need for us to manually track lifetimes.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git.c            | 58 +++++++++++++++++++++++++++++++-------------------------
 t/t0014-alias.sh |  1 +
 2 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/git.c b/git.c
index c2c1b8e22c2d91824ad6d631ea9374424ab53435..88356afe5fb568ccc147f055e3ab253c53a1befa 100644
--- a/git.c
+++ b/git.c
@@ -362,7 +362,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 	return (*argv) - orig_argv;
 }
 
-static int handle_alias(int *argcp, const char ***argv)
+static int handle_alias(struct strvec *args)
 {
 	int envchanged = 0, ret = 0, saved_errno = errno;
 	int count, option_count;
@@ -370,10 +370,10 @@ static int handle_alias(int *argcp, const char ***argv)
 	const char *alias_command;
 	char *alias_string;
 
-	alias_command = (*argv)[0];
+	alias_command = args->v[0];
 	alias_string = alias_lookup(alias_command);
 	if (alias_string) {
-		if (*argcp > 1 && !strcmp((*argv)[1], "-h"))
+		if (args->nr > 1 && !strcmp(args->v[1], "-h"))
 			fprintf_ln(stderr, _("'%s' is aliased to '%s'"),
 				   alias_command, alias_string);
 		if (alias_string[0] == '!') {
@@ -390,7 +390,7 @@ static int handle_alias(int *argcp, const char ***argv)
 			child.wait_after_clean = 1;
 			child.trace2_child_class = "shell_alias";
 			strvec_push(&child.args, alias_string + 1);
-			strvec_pushv(&child.args, (*argv) + 1);
+			strvec_pushv(&child.args, args->v + 1);
 
 			trace2_cmd_alias(alias_command, child.args.v);
 			trace2_cmd_name("_run_shell_alias_");
@@ -423,15 +423,13 @@ static int handle_alias(int *argcp, const char ***argv)
 		trace_argv_printf(new_argv,
 				  "trace: alias expansion: %s =>",
 				  alias_command);
-
-		REALLOC_ARRAY(new_argv, count + *argcp);
-		/* insert after command name */
-		COPY_ARRAY(new_argv + count, *argv + 1, *argcp);
-
 		trace2_cmd_alias(alias_command, new_argv);
 
-		*argv = new_argv;
-		*argcp += count - 1;
+		/* Replace the alias with the new arguments. */
+		strvec_splice(args, 0, 1, new_argv, count);
+
+		free(alias_string);
+		free(new_argv);
 
 		ret = 1;
 	}
@@ -800,10 +798,10 @@ static void execv_dashed_external(const char **argv)
 		exit(128);
 }
 
-static int run_argv(int *argcp, const char ***argv)
+static int run_argv(struct strvec *args)
 {
 	int done_alias = 0;
-	struct string_list cmd_list = STRING_LIST_INIT_NODUP;
+	struct string_list cmd_list = STRING_LIST_INIT_DUP;
 	struct string_list_item *seen;
 
 	while (1) {
@@ -817,8 +815,8 @@ static int run_argv(int *argcp, const char ***argv)
 		 * process.
 		 */
 		if (!done_alias)
-			handle_builtin(*argcp, *argv);
-		else if (get_builtin(**argv)) {
+			handle_builtin(args->nr, args->v);
+		else if (get_builtin(args->v[0])) {
 			struct child_process cmd = CHILD_PROCESS_INIT;
 			int i;
 
@@ -834,8 +832,8 @@ static int run_argv(int *argcp, const char ***argv)
 			commit_pager_choice();
 
 			strvec_push(&cmd.args, "git");
-			for (i = 0; i < *argcp; i++)
-				strvec_push(&cmd.args, (*argv)[i]);
+			for (i = 0; i < args->nr; i++)
+				strvec_push(&cmd.args, args->v[i]);
 
 			trace_argv_printf(cmd.args.v, "trace: exec:");
 
@@ -850,13 +848,13 @@ static int run_argv(int *argcp, const char ***argv)
 			i = run_command(&cmd);
 			if (i >= 0 || errno != ENOENT)
 				exit(i);
-			die("could not execute builtin %s", **argv);
+			die("could not execute builtin %s", args->v[0]);
 		}
 
 		/* .. then try the external ones */
-		execv_dashed_external(*argv);
+		execv_dashed_external(args->v);
 
-		seen = unsorted_string_list_lookup(&cmd_list, *argv[0]);
+		seen = unsorted_string_list_lookup(&cmd_list, args->v[0]);
 		if (seen) {
 			int i;
 			struct strbuf sb = STRBUF_INIT;
@@ -873,14 +871,14 @@ static int run_argv(int *argcp, const char ***argv)
 			      " not terminate:%s"), cmd_list.items[0].string, sb.buf);
 		}
 
-		string_list_append(&cmd_list, *argv[0]);
+		string_list_append(&cmd_list, args->v[0]);
 
 		/*
 		 * It could be an alias -- this works around the insanity
 		 * of overriding "git log" with "git show" by having
 		 * alias.log = show
 		 */
-		if (!handle_alias(argcp, argv))
+		if (!handle_alias(args))
 			break;
 		done_alias = 1;
 	}
@@ -892,6 +890,7 @@ static int run_argv(int *argcp, const char ***argv)
 
 int cmd_main(int argc, const char **argv)
 {
+	struct strvec args = STRVEC_INIT;
 	const char *cmd;
 	int done_help = 0;
 
@@ -951,25 +950,32 @@ int cmd_main(int argc, const char **argv)
 	 */
 	setup_path();
 
+	for (size_t i = 0; i < argc; i++)
+		strvec_push(&args, argv[i]);
+
 	while (1) {
-		int was_alias = run_argv(&argc, &argv);
+		int was_alias = run_argv(&args);
 		if (errno != ENOENT)
 			break;
 		if (was_alias) {
 			fprintf(stderr, _("expansion of alias '%s' failed; "
 					  "'%s' is not a git command\n"),
-				cmd, argv[0]);
+				cmd, args.v[0]);
+			strvec_clear(&args);
 			exit(1);
 		}
 		if (!done_help) {
-			cmd = argv[0] = help_unknown_cmd(cmd);
+			strvec_replace(&args, 0, help_unknown_cmd(cmd));
+			cmd = args.v[0];
 			done_help = 1;
-		} else
+		} else {
 			break;
+		}
 	}
 
 	fprintf(stderr, _("failed to run command '%s': %s\n"),
 		cmd, strerror(errno));
+	strvec_clear(&args);
 
 	return 1;
 }
diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
index 854d59ec58c25ab2cfb58113bf5ea8d670829fe0..2a6f39ad9c81958d5152139995feab57c4371363 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -2,6 +2,7 @@
 
 test_description='git command aliasing'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'nested aliases - internal execution' '

-- 
2.47.0.274.g962d0b743d.dirty

