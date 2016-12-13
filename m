Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C78A8206A4
	for <e@80x24.org>; Tue, 13 Dec 2016 15:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933929AbcLMPcs (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:32:48 -0500
Received: from mout.gmx.net ([212.227.15.15]:59919 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933977AbcLMPbr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:31:47 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mdren-1bySHm3GHN-00Pe6O; Tue, 13
 Dec 2016 16:31:32 +0100
Date:   Tue, 13 Dec 2016 16:31:29 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 20/34] sequencer (rebase -i): copy commit notes at end
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de>
Message-ID: <a2ea8bd57461fe0969f3df09a0374005f12ac6c7.1481642927.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9RvPr1eW3gfs9xUcSDuPyWMHq0QqmSMMQIp215YiDFY6sQZzRGh
 p152Zby46a44JTrIjcWILKDWZIBrzeBCmvZizwtEwcoP1U011fomrAMHg5EZLRuX/jN/+UU
 GfazCltWpcRoj4rTu1Zoq6o/2vDJ3bHSyHuW/1UuOOtH6nxVH9GNmA6pvrQdz2szoS3vVag
 Nf9orlQXooT5loWMz5zdw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WXrou9PCs/k=:kyT37vxR2JQl4wkDMwacJo
 NrZMOTB8cOylmPEFDhWrxit5sHh0rzzd+YDMxX3IAmiB1alPFGRq1TaB4NSypBFj5DJxBSb0H
 7qREsMbSXWizCdM3DXjDWX+zHsxAY/eeqS0v5rfk7Y39s3U/TvXW5MszyH5hT0v3BTH18ShF6
 FKlmH8Nx6DrBZDCHZth0FCKWTi13mbp7Gx4WyN9h0e7SFkElmU3G7EMNLVJCmq+5R7dure3OA
 GGVcYvXxA5Fc+mqx+FYX8nVv/cEynWGE1+ShgvHrF05q/J+tNbltVgqM/xGRoji4TeDXuEQXZ
 R/5jT0u+QRX3iTbT3JubJq7xc2oQ5eN8ZzmhvBP5kCqkqqbfQOrgp1MhcTnSVTTBW8irv7WLZ
 pInINF776+iTv8vOW3z1BYpMvVALhxxo603wIPTfppo19tiwujBeIuuMcNLFBTemB9SRXJLxF
 n3HL6tHlhQyNl5kXZZasKwWROsLmjHLOgWKxWEH4hMmQ1NU0crNWI7J/VRA/RP11XppaXnY/4
 SSA4tgGzJnGXxvLoMUI/jBmate3QaiflcY7jXVKsCz/FeKE45zVweya9FCLDf89NMfRMpwkMz
 CGPazmX9jjpdt8Tm2iieAPRJXTXkWKtlZ6d3vN2J9AWNvckz5Y73qqKnopnEbfKEMU+WnWwQZ
 83kviq1uWmHSXjp2t6k4hCYNgMkfleSkv8Xcokg+JUDcx3NmG7yEiB+TIWUZzh8RpC6+Gl9XG
 Z6JwaeVtjZSvCO/HRHQe7uByE35TcBS84gHLzhLfjBA7u/uEajg2C5YwYRgstmf8Eq72uMVbd
 TjIWJGN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When rebasing commits that have commit notes attached, the interactive
rebase rewrites those notes faithfully at the end. The sequencer must
do this, too, if it wishes to do interactive rebase's job.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 118696f6d3..7ab533abd9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -94,6 +94,15 @@ static GIT_PATH_FUNC(rebase_path_amend, "rebase-merge/amend")
  */
 static GIT_PATH_FUNC(rebase_path_stopped_sha, "rebase-merge/stopped-sha")
 /*
+ * For the post-rewrite hook, we make a list of rewritten commits and
+ * their new sha1s.  The rewritten-pending list keeps the sha1s of
+ * commits that have been processed, but not committed yet,
+ * e.g. because they are waiting for a 'squash' command.
+ */
+static GIT_PATH_FUNC(rebase_path_rewritten_list, "rebase-merge/rewritten-list")
+static GIT_PATH_FUNC(rebase_path_rewritten_pending,
+	"rebase-merge/rewritten-pending")
+/*
  * The following files are written by git-rebase just after parsing the
  * command-line (and are only consumed, not modified, by the sequencer).
  */
@@ -883,6 +892,44 @@ static int update_squash_messages(enum todo_command command,
 	return res;
 }
 
+static void flush_rewritten_pending(void) {
+	struct strbuf buf = STRBUF_INIT;
+	unsigned char newsha1[20];
+	FILE *out;
+
+	if (strbuf_read_file(&buf, rebase_path_rewritten_pending(), 82) > 0 &&
+			!get_sha1("HEAD", newsha1) &&
+			(out = fopen(rebase_path_rewritten_list(), "a"))) {
+		char *bol = buf.buf, *eol;
+
+		while (*bol) {
+			eol = strchrnul(bol, '\n');
+			fprintf(out, "%.*s %s\n", (int)(eol - bol),
+					bol, sha1_to_hex(newsha1));
+			if (!*eol)
+				break;
+			bol = eol + 1;
+		}
+		fclose(out);
+		unlink(rebase_path_rewritten_pending());
+	}
+	strbuf_release(&buf);
+}
+
+static void record_in_rewritten(struct object_id *oid,
+		enum todo_command next_command) {
+	FILE *out = fopen(rebase_path_rewritten_pending(), "a");
+
+	if (!out)
+		return;
+
+	fprintf(out, "%s\n", oid_to_hex(oid));
+	fclose(out);
+
+	if (!is_fixup(next_command))
+		flush_rewritten_pending();
+}
+
 static int do_pick_commit(enum todo_command command, struct commit *commit,
 		struct replay_opts *opts, int final_fixup)
 {
@@ -1750,6 +1797,17 @@ static int is_final_fixup(struct todo_list *todo_list)
 	return 1;
 }
 
+static enum todo_command peek_command(struct todo_list *todo_list, int offset)
+{
+	int i;
+
+	for (i = todo_list->current + offset; i < todo_list->nr; i++)
+		if (todo_list->items[i].command != TODO_NOOP)
+			return todo_list->items[i].command;
+
+	return -1;
+}
+
 static const char *reflog_message(struct replay_opts *opts,
 	const char *sub_action, const char *fmt, ...)
 {
@@ -1808,6 +1866,9 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 					item->arg, item->arg_len, opts, res,
 					!res);
 			}
+			if (is_rebase_i(opts) && !res)
+				record_in_rewritten(&item->commit->object.oid,
+					peek_command(todo_list, 1));
 			if (res && is_fixup(item->command)) {
 				if (res == 1)
 					intend_to_amend();
@@ -1837,6 +1898,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 
 	if (is_rebase_i(opts)) {
 		struct strbuf head_ref = STRBUF_INIT, buf = STRBUF_INIT;
+		struct stat st;
 
 		/* Stopped in the middle, as planned? */
 		if (todo_list->current < todo_list->nr)
@@ -1881,6 +1943,20 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			run_command_v_opt(argv, RUN_GIT_CMD);
 			strbuf_reset(&buf);
 		}
+		flush_rewritten_pending();
+		if (!stat(rebase_path_rewritten_list(), &st) &&
+				st.st_size > 0) {
+			struct child_process child = CHILD_PROCESS_INIT;
+
+			child.in = open(rebase_path_rewritten_list(), O_RDONLY);
+			child.git_cmd = 1;
+			argv_array_push(&child.args, "notes");
+			argv_array_push(&child.args, "copy");
+			argv_array_push(&child.args, "--for-rewrite=rebase");
+			/* we don't care if this copying failed */
+			run_command(&child);
+		}
+
 		strbuf_release(&buf);
 		strbuf_release(&head_ref);
 	}
-- 
2.11.0.rc3.windows.1


