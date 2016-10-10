Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ABC4209B4
	for <e@80x24.org>; Mon, 10 Oct 2016 17:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753000AbcJJRYu (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 13:24:50 -0400
Received: from mout.gmx.net ([212.227.17.20]:57961 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752803AbcJJRYq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 13:24:46 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MVNWU-1bNAXM3zyQ-00Yhhq; Mon, 10 Oct 2016 19:24:27
 +0200
Date:   Mon, 10 Oct 2016 19:24:25 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 02/25] sequencer: use memoized sequencer directory path
In-Reply-To: <cover.1476120229.git.johannes.schindelin@gmx.de>
Message-ID: <76b7d1bce59681f84ca91db2f87bd38b74072e48.1476120229.git.johannes.schindelin@gmx.de>
References: <cover.1473590966.git.johannes.schindelin@gmx.de> <cover.1476120229.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:VXyYc7luHjWN3jptPwaf9u0rJVlIRDxif8KvSTIRF8EqIWdockk
 ZIduPaIKzws4yuxo25HHQ5WHrqrGT3Lw3Rw0vbrH8+F0m2Ngsk8FhPM7xV57NwJi/IBuDjw
 LFbHrQsWKR0pvu8F+EYzhT5L+qcv0aQPobCtlR31kw+kefPlSs+CtT/Jot6qJjLPqSu4IH0
 Zeo7WwjEFlMIPWsXBYl/Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Oz/TJa92Rq4=:eaU8bE2MZO53HQmzEIY0Ja
 vU7al+H+Kia6vA4VxC6vdCGHaNUDX6mSnB1rR82lnk2ZOtcEjgFFZqfY3JtceAEB98pGZwjSo
 SfFzMGmYqd0ZgiR5iN6DxWOABWpleNXqHaixFQBxQJzbVkmKaBY7ORlw7BknqGyMZ1vdSqugy
 0KCDqaxxeEB9Rc2YKzakYM1PPSDQ9n+hfa3fe3gTtjbOC+MkfwUzcWEumgDYIZut4EOdvRkes
 Oln+gTWThoFJ1SEIv5RtVHrjHiQNwMInWscUyIkywuX/KGz6TD+ClJpaU1oV5lPBXvy9QzMrR
 REoTmTXTScbZcmeRUacGCPCR4hHnsdSccF7oSUCk6VPz7gJYuw5go/TUag/Qd52yEQHSiDANW
 KYbmoX/WqG/xlJmZw98ia4/KM2QYtlDGbpuqjgRWCSgNBG+g8c43Ff1SGx3JJ0NU9SQlA+ZrL
 tyBB8HklR2vjS5owOHujBy7FIGckkpI39WYGvFbUcFB4OVG6YSmVnlKaxcUIu5bVlzCSxUoY7
 FD5yY6it7fTGudFcRQp1tPWAiQpc7mgk2Da9Q+uok8T5DNqRDG98WK31FBXdwIC24Zcwch95/
 okqEhuSkSEVgzMIkUPkmErpNuHfom39Vr9A3JU2EdH4Oh3LKG/Sf31Hpdnd8S9aStmspPcD14
 0xW6dpvlzpUUdHqjtTYrPj9FFyzTqZeUnH4cJDbzce3paBLmX5HM0s/AtTKWp1nK+ldqH3TIg
 03mZzBGrb1A13AxQ+iTGYxAuwZg4yD4VaBhg6DL9zIYzt3Q9pHq7r0KB8tKQ1rDsw8+/Bc1WH
 mQ9i2GV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/commit.c |  2 +-
 sequencer.c      | 11 ++++++-----
 sequencer.h      |  5 +----
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 1cba3b7..9fddb19 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -183,7 +183,7 @@ static void determine_whence(struct wt_status *s)
 		whence = FROM_MERGE;
 	else if (file_exists(git_path_cherry_pick_head())) {
 		whence = FROM_CHERRY_PICK;
-		if (file_exists(git_path(SEQ_DIR)))
+		if (file_exists(git_path_seq_dir()))
 			sequencer_in_use = 1;
 	}
 	else
diff --git a/sequencer.c b/sequencer.c
index eec8a60..cb16cbd 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -21,10 +21,11 @@
 const char sign_off_header[] = "Signed-off-by: ";
 static const char cherry_picked_prefix[] = "(cherry picked from commit ";
 
-static GIT_PATH_FUNC(git_path_todo_file, SEQ_TODO_FILE)
-static GIT_PATH_FUNC(git_path_opts_file, SEQ_OPTS_FILE)
-static GIT_PATH_FUNC(git_path_seq_dir, SEQ_DIR)
-static GIT_PATH_FUNC(git_path_head_file, SEQ_HEAD_FILE)
+GIT_PATH_FUNC(git_path_seq_dir, "sequencer")
+
+static GIT_PATH_FUNC(git_path_todo_file, "sequencer/todo")
+static GIT_PATH_FUNC(git_path_opts_file, "sequencer/opts")
+static GIT_PATH_FUNC(git_path_head_file, "sequencer/head")
 
 static int is_rfc2822_line(const char *buf, int len)
 {
@@ -112,7 +113,7 @@ static void remove_sequencer_state(void)
 {
 	struct strbuf seq_dir = STRBUF_INIT;
 
-	strbuf_addstr(&seq_dir, git_path(SEQ_DIR));
+	strbuf_addstr(&seq_dir, git_path_seq_dir());
 	remove_dir_recursively(&seq_dir, 0);
 	strbuf_release(&seq_dir);
 }
diff --git a/sequencer.h b/sequencer.h
index db425ad..dd4d33a 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -1,10 +1,7 @@
 #ifndef SEQUENCER_H
 #define SEQUENCER_H
 
-#define SEQ_DIR		"sequencer"
-#define SEQ_HEAD_FILE	"sequencer/head"
-#define SEQ_TODO_FILE	"sequencer/todo"
-#define SEQ_OPTS_FILE	"sequencer/opts"
+const char *git_path_seq_dir(void);
 
 #define APPEND_SIGNOFF_DEDUP (1u << 0)
 
-- 
2.10.0.windows.1.325.ge6089c1


