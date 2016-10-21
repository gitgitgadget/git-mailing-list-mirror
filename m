Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47E2D20229
	for <e@80x24.org>; Fri, 21 Oct 2016 12:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755275AbcJUMYK (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 08:24:10 -0400
Received: from mout.gmx.net ([212.227.17.22]:58681 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754423AbcJUMYI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 08:24:08 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M2Glc-1cpfS70akG-00s3In; Fri, 21 Oct 2016 14:23:59
 +0200
Date:   Fri, 21 Oct 2016 14:23:57 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 02/27] sequencer: use memoized sequencer directory path
In-Reply-To: <cover.1477052405.git.johannes.schindelin@gmx.de>
Message-ID: <5da5d267fe291070af0e7a98b811dbfbced2d7ca.1477052405.git.johannes.schindelin@gmx.de>
References: <cover.1476450940.git.johannes.schindelin@gmx.de> <cover.1477052405.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:l4aeyor/5HsHtHFJFqkQO6/gb5OweW7F1M09VnK6AV+GGR//+HS
 hRuZ0/YTyFdO1wTUDR3wTfC/4LJ/hEhF8RVqoAhxUoKxCnSh35/aGZbtEERsldI/YKzlioF
 dp7/CGg3Bauwnpumw/zEh7sS/p20tcwlshZKICHzGQiN01tJArZGCW12Xgn5TXPQsTRnGur
 8clvdufG7YmfHsPk3BVrg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EBwwL/rvvws=:eaBvhF0C/YA0ZvT9fARz6Q
 V7cWMnS+mjmLED4UBw7XjF1D1thFFDwR6LwrpVNJuilJwUaqmJZPYLkd/DeHJu5czLkJYc/qo
 QaEmHn4fhrOIqFUeFKx6V75GHLhnkRrfUXoblDXgl+RAbYIZOklqEPBEY9TUoTutv3NMVYcqe
 nyPgHnyPTytN1TsalsL/EZWCdMDmJEQN/+F9nu2/0HKd7EIyMLK+K0p3d5UcvyfWASOORv63J
 yj/1DVLhOdIYTgrJZBKzn81WlfcF/nXmOnf7SeoSYXdOOdVfSE+Nsq4cROIjAGjHj92wwDTlM
 xqSyVUnhzsnzrCP3RUZeHg8HuVMFoApMHpeCbIDzF5gy7Gi2Mko+mpPTZkpXAAVB0srvrx9CV
 505sv53Md/D4k8n8vXSpI8oQ8mx+iAnoKiDX1qKj2WrzpLH7+Mwt/PjIv/EGfpvH/9rbZsxu1
 /qmqyXrh6E7uU7ncDGromdewVe7/Uz1v+jwcvjWKbthHzHX23QakVKJfEIciZ3VoGJ84JYY5U
 1aRsIZt58VOHrgoWIdeHjdMRxGrhfg0lMZzpzYZqgkA12v6nJQCnLEgMZ1ZQ37Us2KLqpJPgP
 B8JZn/PHUOseOLeyzEgm221tOXfJA9ZhFTqX4l/nuL3IzGner4QpqrgFD/CMTt0lPqYKCqMVk
 eEuQyzFeThgmf12+81SLCZPYiKrRIIL9+bmP6fmjFRhyD2MVI6iL+mS1eH/oT7DDhwZkfWstb
 n+sbHOyWYK4qJQKaZgO/81pQLCWEXPDoEZptaNJfsWaQwqyzKe6ozFObCPZHHPec5Nncan7OA
 YOR7wfa
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
2.10.1.583.g721a9e0


