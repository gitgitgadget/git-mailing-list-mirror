Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EF61DD87D
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 06:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417860; cv=none; b=EusybkBaofl89e64H+3JVWZ4FPCt12K1ueDoCGCFBtarBAB0bjl1SKRkzWhzqXjDHMsOxmP5cHLwrE3xVgaOnAZj+EmA3BKCs0YvnycMFjqaYMuWNNHrLnJGIFUR1DpETWBEhC7dqzv+DekKN79wcnbbdvp05J9ZYuGckvPy6LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417860; c=relaxed/simple;
	bh=FJyI5r4xZQiPflRI/vxdp15o4bbUrNYXPwaTD4VhKjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mfisCHdk9xH3C36RC8ajU7JylZs3m/ByL4IUmMR+S2LrRAranF/gwC8FNnvMR9U2wEI9zRdnZ9EtZskamgLiGKBBcLLGnksITSZbPgXu8vhxIcg4Iq6t+ib5lIoYamPVw9ERX9sHtsrvyOvFdiH5+ZFoV3yI2qn93uwLaUY+bV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nkfzNs4e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x/k/tlSb; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nkfzNs4e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x/k/tlSb"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 666B91140251
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 01:44:17 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 17 Dec 2024 01:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734417857;
	 x=1734504257; bh=j/taV5dwkF3Xc9sMNkslwDnek2ALS3JKLSmiRkvoP9Y=; b=
	nkfzNs4eLVnlpZ+EJ/duOO7bkgnMuXxImhcXGnhsgJ5WvJ1BHVk8J5qwsohJDOqB
	RgkegmVGVu7rpTExd4Uw0xEIkcp1ecKhXiPzqMOgezitgFobgg0ZTA1El4mYOX8Y
	SpdPq612B9jLrqaG+2u1yoUFDTf21fRsRSEnIWh9zktLnPkcxSjQWazwaLKnBKg7
	efuCKJW+dotm62kyIqaWBCXGaPbCK2XSVSyeY/UZCeTTX8w+Ibz+bJMBJb1yIzYt
	fP0UaSfiMcLCnJhxDTumQUaq+QkKbWD0LjbjyXDf7oJ1tINJUTiTnO9hKN9AaMcS
	RZrImUmepqdW0ymA1v9wwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734417857; x=
	1734504257; bh=j/taV5dwkF3Xc9sMNkslwDnek2ALS3JKLSmiRkvoP9Y=; b=x
	/k/tlSbeuM76Hth3ESIfMd4X1L6dhiGHu3NYz/H7+0gwW67VSDTaRHEzsqmxFy2M
	EGlVbyqO1fkzdtNqdk23VSnU5iCuyhxZfQ/lt/L8rT+ti5FTPegzza0RoTsFEVTe
	DjebsLj+Vdi+R9KgNX0gEZP+iVB1l2XaYcrqzOANpv7Lgw/gMpPb/nCemrB1g5Kb
	BFWxD3yqRp5k8fEKf/m+fd1TXshRTDps1Cm9SC7SxUd2DdtI/m4LjA1/3MNzMKww
	ujjEYX2Ur1k354mZm2uGiAF0AaYaHkmC4Wir7oVYwZDvygUW/74M3SQ90zvBTiU9
	0tENMKnl0A9wpUWs53fmw==
X-ME-Sender: <xms:wR1hZ85UrbLuOahvZfvJtY7Zaj4NgNuyuQ8tJDE_V3VCY6ZrC02ulQ>
    <xme:wR1hZ95L3Of3rDVLtgLHzRNSi0OYyQxxDNPj9faA24a89pQzd0LnRyTtjcY59HSly
    u_mrcgR8eQjsls7uA>
X-ME-Received: <xmr:wR1hZ7cZ_hDF6zuLL108khxD7sE_aTdY5SvmHPTE_FWS7SeVzNC3ZEiuw6-fb1d9JKyiy9IB54m_5-N5TxfWeBAIVlfpyawMTr6iLfYy5ZAAOBI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleeggdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:wR1hZxLJ4jIF87eAzzYZusLkmWmDwhTO2CEKNJdFBKtNZMtf7GNiGQ>
    <xmx:wR1hZwKNEaB3RndDVKfA9aaHCXc_-iz3EG01sazr0ODciHrY8s3Z8g>
    <xmx:wR1hZyxy5yYhHeHUdjMXC-JiAYbexLvrJ-O8vkXOOlJnj7ke8CChJA>
    <xmx:wR1hZ0K2TFwajKl3LGUe_xSMMB_YEkMOfh3VKbweNgq9GKPyJ7059A>
    <xmx:wR1hZ6gkD8MknWiAsIShSPqmqMOIVk0X7CIYMocYz51H4hxUZ9bWLq5d>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 17 Dec 2024 01:44:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id be3f6f3c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 17 Dec 2024 06:42:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 17 Dec 2024 07:43:49 +0100
Subject: [PATCH 02/14] pager: stop using `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-pks-use-the-repository-conversion-v1-2-0dba48bcc239@pks.im>
References: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
In-Reply-To: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Stop using `the_repository` in the "pager" subsystem by passing in a
repository when setting up the pager and when configuring it.

Adjust callers accordingly by using `the_repository`. While there may be
some callers that have a repository available in their context, this
trivial conversion allows for easier verification and bubbles up the use
of `the_repository` by one level.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 add-patch.c     |  2 +-
 builtin/am.c    |  4 ++--
 builtin/blame.c |  2 +-
 builtin/grep.c  |  4 ++--
 builtin/help.c  |  4 ++--
 builtin/log.c   |  4 ++--
 builtin/var.c   |  2 +-
 diff.c          |  4 ++--
 git.c           |  8 ++++----
 pager.c         | 14 ++++++--------
 pager.h         |  7 ++++---
 11 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 7b598e14df016402ca41e1998466b5ba45623f90..95c67d8c80c4f33bfa6180f69fdf2065d0b5b85c 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1464,7 +1464,7 @@ static int patch_update_file(struct add_p_state *s,
 		if (file_diff->hunk_nr) {
 			if (rendered_hunk_index != hunk_index) {
 				if (use_pager) {
-					setup_pager();
+					setup_pager(the_repository);
 					sigchain_push(SIGPIPE, SIG_IGN);
 				}
 				render_hunk(s, hunk, 0, colored, &s->buf);
diff --git a/builtin/am.c b/builtin/am.c
index 1338b606febdde6700c573b45f89aa70785f54e8..27ccca8341feefcda5e1c4a850f14fce9e4deecb 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1786,7 +1786,7 @@ static int do_interactive(struct am_state *state)
 			}
 			strbuf_release(&msg);
 		} else if (*reply == 'v' || *reply == 'V') {
-			const char *pager = git_pager(1);
+			const char *pager = git_pager(the_repository, 1);
 			struct child_process cp = CHILD_PROCESS_INIT;
 
 			if (!pager)
@@ -2246,7 +2246,7 @@ static int show_patch(struct am_state *state, enum resume_type resume_mode)
 	if (len < 0)
 		die_errno(_("failed to read '%s'"), patch_path);
 
-	setup_pager();
+	setup_pager(the_repository);
 	write_in_full(1, sb.buf, sb.len);
 	strbuf_release(&sb);
 	return 0;
diff --git a/builtin/blame.c b/builtin/blame.c
index dd78288530f06efa99ec7a1ca767aa388805fd97..1f44c341c50ecd80fd76d2f055d488884cfcd20c 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1202,7 +1202,7 @@ int cmd_blame(int argc,
 	stop_progress(&pi.progress);
 
 	if (!incremental)
-		setup_pager();
+		setup_pager(the_repository);
 	else
 		goto cleanup;
 
diff --git a/builtin/grep.c b/builtin/grep.c
index d00ee76f24cfdea8ac15e08f812aa5868906940c..d1427290f773b6cec539fcd838ada2b61acb22c8 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1084,7 +1084,7 @@ int cmd_grep(int argc,
 	}
 
 	if (show_in_pager == default_pager)
-		show_in_pager = git_pager(1);
+		show_in_pager = git_pager(the_repository, 1);
 	if (show_in_pager) {
 		opt.color = 0;
 		opt.name_only = 1;
@@ -1246,7 +1246,7 @@ int cmd_grep(int argc,
 	}
 
 	if (!show_in_pager && !opt.status_only)
-		setup_pager();
+		setup_pager(the_repository);
 
 	die_for_incompatible_opt3(!use_index, "--no-index",
 				  untracked, "--untracked",
diff --git a/builtin/help.c b/builtin/help.c
index 05136279cf7b1007ab754f5630c34536a5f9461f..c257079cebc3c09fb91f258c3b0148e2f204c0e7 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -658,7 +658,7 @@ int cmd_help(int argc,
 	case HELP_ACTION_ALL:
 		opt_mode_usage(argc, "--all", help_format);
 		if (verbose) {
-			setup_pager();
+			setup_pager(the_repository);
 			list_all_cmds_help(show_external_commands,
 					   show_aliases);
 			return 0;
@@ -692,7 +692,7 @@ int cmd_help(int argc,
 		return 0;
 	case HELP_ACTION_CONFIG:
 		opt_mode_usage(argc, "--config", help_format);
-		setup_pager();
+		setup_pager(the_repository);
 		list_config_help(SHOW_CONFIG_HUMAN);
 		printf("\n%s\n", _("'git help config' for more information"));
 		return 0;
diff --git a/builtin/log.c b/builtin/log.c
index 317335e60d450128685d9fce99eb8fe8f9860fd9..3a6a3362f3c36ee257215e79cf40085f76c9efb3 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -369,7 +369,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	if (rev->line_level_traverse)
 		line_log_init(rev, line_cb.prefix, &line_cb.args);
 
-	setup_pager();
+	setup_pager(the_repository);
 }
 
 static void cmd_log_init(int argc, const char **argv, const char *prefix,
@@ -2292,7 +2292,7 @@ int cmd_format_patch(int argc,
 		rev.commit_format = CMIT_FMT_MBOXRD;
 
 	if (use_stdout) {
-		setup_pager();
+		setup_pager(the_repository);
 	} else if (!rev.diffopt.close_file) {
 		int saved;
 
diff --git a/builtin/var.c b/builtin/var.c
index 1449656cc924f849ee9c881c18b734a3ec55e9f3..50d024de66604ab9e8faa1bd59f662127bc62159 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -42,7 +42,7 @@ static char *sequence_editor(int ident_flag UNUSED)
 
 static char *pager(int ident_flag UNUSED)
 {
-	const char *pgm = git_pager(1);
+	const char *pgm = git_pager(the_repository, 1);
 
 	if (!pgm)
 		pgm = "cat";
diff --git a/diff.c b/diff.c
index d28b4114c8dffba5cb5339152d198588550135a0..0822ae443361f80271c91a863a6f03b0e8c403c3 100644
--- a/diff.c
+++ b/diff.c
@@ -7386,6 +7386,6 @@ void setup_diff_pager(struct diff_options *opt)
 	 * --exit-code" in hooks and other scripts, we do not do so.
 	 */
 	if (!opt->flags.exit_with_status &&
-	    check_pager_config("diff") != 0)
-		setup_pager();
+	    check_pager_config(the_repository, "diff") != 0)
+		setup_pager(the_repository);
 }
diff --git a/git.c b/git.c
index 71d644dc1c59902b2f14c14914c78285ffa92638..d977ebc84cfba611c3e452cace3bda1ce13faf5d 100644
--- a/git.c
+++ b/git.c
@@ -125,7 +125,7 @@ static void commit_pager_choice(void)
 		setenv("GIT_PAGER", "cat", 1);
 		break;
 	case 1:
-		setup_pager();
+		setup_pager(the_repository);
 		break;
 	default:
 		break;
@@ -136,7 +136,7 @@ void setup_auto_pager(const char *cmd, int def)
 {
 	if (use_pager != -1 || pager_in_use())
 		return;
-	use_pager = check_pager_config(cmd);
+	use_pager = check_pager_config(the_repository, cmd);
 	if (use_pager == -1)
 		use_pager = def;
 	commit_pager_choice();
@@ -462,7 +462,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct
 	precompose_argv_prefix(argc, argv, NULL);
 	if (use_pager == -1 && run_setup &&
 		!(p->option & DELAY_PAGER_CONFIG))
-		use_pager = check_pager_config(p->cmd);
+		use_pager = check_pager_config(the_repository, p->cmd);
 	if (use_pager == -1 && p->option & USE_PAGER)
 		use_pager = 1;
 	if (run_setup && startup_info->have_repository)
@@ -750,7 +750,7 @@ static void execv_dashed_external(const char **argv)
 	int status;
 
 	if (use_pager == -1 && !is_builtin(argv[0]))
-		use_pager = check_pager_config(argv[0]);
+		use_pager = check_pager_config(the_repository, argv[0]);
 	commit_pager_choice();
 
 	strvec_pushf(&cmd.args, "git-%s", argv[0]);
diff --git a/pager.c b/pager.c
index 40b664f893c8ec61af0e6d00d58956f45b247d65..5531fff50eb73f7d22defcc7d8e752c94f741d66 100644
--- a/pager.c
+++ b/pager.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "config.h"
 #include "editor.h"
@@ -84,7 +82,7 @@ static int core_pager_config(const char *var, const char *value,
 	return 0;
 }
 
-const char *git_pager(int stdout_is_tty)
+const char *git_pager(struct repository *r, int stdout_is_tty)
 {
 	const char *pager;
 
@@ -94,7 +92,7 @@ const char *git_pager(int stdout_is_tty)
 	pager = getenv("GIT_PAGER");
 	if (!pager) {
 		if (!pager_program)
-			read_early_config(the_repository,
+			read_early_config(r,
 					  core_pager_config, NULL);
 		pager = pager_program;
 	}
@@ -143,10 +141,10 @@ void prepare_pager_args(struct child_process *pager_process, const char *pager)
 	pager_process->trace2_child_class = "pager";
 }
 
-void setup_pager(void)
+void setup_pager(struct repository *r)
 {
 	static int once = 0;
-	const char *pager = git_pager(isatty(1));
+	const char *pager = git_pager(r, isatty(1));
 
 	if (!pager)
 		return;
@@ -293,7 +291,7 @@ static int pager_command_config(const char *var, const char *value,
 }
 
 /* returns 0 for "no pager", 1 for "use pager", and -1 for "not specified" */
-int check_pager_config(const char *cmd)
+int check_pager_config(struct repository *r, const char *cmd)
 {
 	struct pager_command_config_data data;
 
@@ -301,7 +299,7 @@ int check_pager_config(const char *cmd)
 	data.want = -1;
 	data.value = NULL;
 
-	read_early_config(the_repository, pager_command_config, &data);
+	read_early_config(r, pager_command_config, &data);
 
 	if (data.value)
 		pager_program = data.value;
diff --git a/pager.h b/pager.h
index 103ecac476fdd6523930d7ff8fe542eeec038438..d070be6348971663d3ac913ed702a7ba541cb4e8 100644
--- a/pager.h
+++ b/pager.h
@@ -2,15 +2,16 @@
 #define PAGER_H
 
 struct child_process;
+struct repository;
 
-const char *git_pager(int stdout_is_tty);
-void setup_pager(void);
+const char *git_pager(struct repository *r, int stdout_is_tty);
+void setup_pager(struct repository *r);
 void wait_for_pager(void);
 int pager_in_use(void);
 int term_columns(void);
 void term_clear_line(void);
 int decimal_width(uintmax_t);
-int check_pager_config(const char *cmd);
+int check_pager_config(struct repository *r, const char *cmd);
 void prepare_pager_args(struct child_process *, const char *pager);
 
 extern int pager_use_color;

-- 
2.48.0.rc0.184.g0fc57dec57.dirty

