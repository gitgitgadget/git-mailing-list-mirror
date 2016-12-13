Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC7962042F
	for <e@80x24.org>; Tue, 13 Dec 2016 15:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934233AbcLMPdx (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:33:53 -0500
Received: from mout.gmx.net ([212.227.17.20]:59287 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932948AbcLMPdr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:33:47 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MMkgl-1cGXQj3fhf-008XDj; Tue, 13
 Dec 2016 16:32:51 +0100
Date:   Tue, 13 Dec 2016 16:32:49 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 33/34] sequencer (rebase -i): write the progress into
 files
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de>
Message-ID: <546a6947e7a864a9a950ca4d5e4a87a4b0e8ea76.1481642927.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:vj+XcFWGgHHmYsGSmlwm8KBPuY4m1+O4v/N57HUMKx5TUmbmtUV
 V/2UHST6Q4GbovUiG8wx5ADBh/9zdlo3KL/Hw9JJMNwo5Q3HmBVUvgr+wmGkw1+CI7fJ8t6
 zv/LLm/pX2sbErWYZge0x892+ttUmbAxnv22gNdv9y5J12tA3op5+BkGdoKGvNlFBaS6XuP
 l9HAT63uawMtgjkcnkBqA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rVThVGM8OrM=:PaU+18b67yrlNrz6DQ3/FN
 hmLy0vxp/XT4uCF/15Yt9iGxYH99gYiRcpCIuH1mvlKPVF+WCz9gtTKVghID6Ayd8zcBmBP3e
 DjMiU9D8iRp2mq+WbLURjke8Qb6TwF1PgX5DvXKqvP5wK3mAVhY5b4chgxJIcJt70NUaNYKJo
 l9FYNAp8yqsJjBI5La3mcuND8TZAzqrXL2FMKUDIQQt1HSVbjH+R//BkP2l7HyqNTxU4rRNgF
 fONM9eLrdrnZX9I+7rxO5i8hk4/Fs2s9SedBLeuwHHihFbJQPJvUxru+McHSn6Q3kPHhJgjK5
 DNsZFa/tN31lSIg/6eJE/TZZebt0elI5Me5JaIcEBV2x+6+038E5HVtV+yFq0EC4bgbTNf9pD
 uqkwNGQLjIKxPw0yins9T+s2nmdKqpuJXl/1LXAQy8NZD88nSahF2tv+jmDvlYbRpiSOWIq9Q
 j8uVE88m437BdGzjTDa2cPuYBKoNExtdeQeHiV5tdIxDL/OXI9x9PEOX1fW47/lsaeM3ZNLeF
 XTEXBu7Nr4KGzlYdNcPbNI+9sKeCBr3OotoY7jWVFpOFbNh03rlK2REcadGPMKaRQ3jimqGj8
 4cMr1XN46HmRuTenUy+/LD5Ag8L2SYtbUSsKHw0186NTmSu+ecY/hIqxSeGc6NF4TC2/QMH6B
 yGqS8+B5dOMn/ONV7mLXgNyHjo6JdvbwjmCc4q5pRjziNhgvxaHkVi6Tc+DR6iFnopdJ0wxua
 A8DcbhDcKqYmDoyTyoLbBg4ESOaB6VoYwZJG+/RQ+3fHqyyUDIhQ+fclKULxniAMpaawVx/pZ
 TDM4JtL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For the benefit of e.g. the shell prompt, the interactive rebase not
only displays the progress for the user to see, but also writes it into
the msgnum/end files in the state directory.

Teach the sequencer this new trick.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 35d5ef4ef6..cb5e7f35fc 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -45,6 +45,16 @@ static GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
  */
 static GIT_PATH_FUNC(rebase_path_done, "rebase-merge/done")
 /*
+ * The file to keep track of how many commands were already processed (e.g.
+ * for the prompt).
+ */
+static GIT_PATH_FUNC(rebase_path_msgnum, "rebase-merge/msgnum");
+/*
+ * The file to keep track of how many commands are to be processed in total
+ * (e.g. for the prompt).
+ */
+static GIT_PATH_FUNC(rebase_path_msgtotal, "rebase-merge/end");
+/*
  * The commit message that is planned to be used for any changes that
  * need to be committed following a user interaction.
  */
@@ -1394,6 +1404,7 @@ static int read_populate_todo(struct todo_list *todo_list,
 
 	if (is_rebase_i(opts)) {
 		struct todo_list done = TODO_LIST_INIT;
+		FILE *f = fopen(rebase_path_msgtotal(), "w");
 
 		if (strbuf_read_file(&done.buf, rebase_path_done(), 0) > 0 &&
 				!parse_insn_buffer(done.buf.buf, &done))
@@ -1403,8 +1414,12 @@ static int read_populate_todo(struct todo_list *todo_list,
 
 		todo_list->total_nr = todo_list->done_nr
 			+ count_commands(todo_list);
-
 		todo_list_release(&done);
+
+		if (f) {
+			fprintf(f, "%d\n", todo_list->total_nr);
+			fclose(f);
+		}
 	}
 
 	return 0;
@@ -1955,11 +1970,20 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 		if (save_todo(todo_list, opts))
 			return -1;
 		if (is_rebase_i(opts)) {
-			if (item->command != TODO_COMMENT)
+			if (item->command != TODO_COMMENT) {
+				FILE *f = fopen(rebase_path_msgnum(), "w");
+
+				todo_list->done_nr++;
+
+				if (f) {
+					fprintf(f, "%d\n", todo_list->done_nr);
+					fclose(f);
+				}
 				fprintf(stderr, "Rebasing (%d/%d)%s",
-					++(todo_list->done_nr),
+					todo_list->done_nr,
 					todo_list->total_nr,
 					opts->verbose ? "\n" : "\r");
+			}
 			unlink(rebase_path_message());
 			unlink(rebase_path_author_script());
 			unlink(rebase_path_stopped_sha());
-- 
2.11.0.rc3.windows.1


