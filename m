Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05C42207DF
	for <e@80x24.org>; Sun, 11 Sep 2016 10:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755734AbcIKKxA (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 06:53:00 -0400
Received: from mout.gmx.net ([212.227.17.20]:59615 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755694AbcIKKw6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 06:52:58 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MfmZs-1bLzDl17cC-00N8Dp; Sun, 11 Sep 2016 12:52:53
 +0200
Date:   Sun, 11 Sep 2016 12:52:37 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 02/25] sequencer: use memoized sequencer directory path
In-Reply-To: <cover.1473590966.git.johannes.schindelin@gmx.de>
Message-ID: <5c52dcbff8b21b24a360d6f5bd2710fe1139eb4a.1473590966.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <cover.1473590966.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hJaE3mxU5XPB21N6lP/C3c/6ViNhC8ah39xBM9ofP1+tX5pCz2n
 0RooDNMVuzoMJKwGBuq4auwx5ue8pshJOPaAGHeKPVGuGucUHPVSGXZ7cErPfgJhJFAspNN
 kuOrVp0Il5wGqa/R+kFt1CPMtnkDIFy9FbYs74Aa6F947Iec2iGs3V6c9yZH3zuveWGfc4s
 JUW5Jsi3cjp0fk1GtPCvQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:09MvSpWYinQ=:Ep9dlypj0mzJ/vDEeu90Fw
 NP7JSor833Yr/4tFbiq3Zfz7eESS9UhGkU1MsAb9VxjO/HoQIeCV5gAAozN521Uf8DfQg/YXg
 8S73rLo1lokpBi6wam/Q1wBh8kS/bGD0OJwWMzJ39pBhXgvMHhTJciNcyWMjkh3pWVtExKTPV
 SEt/YPX4j242GfVj+QS1fByLyyz4OyTAt50yfnq02iOmjDm+hCprRCpR99OldhsOYuShlQq+G
 lp21ODuSsu7Tn+cs3LweT1PpUJvq16/TmStZfhYw7fodv1gDw2CH4w1UkatOIsaw5pxAV1M8f
 xVuJBl/XdW50L3e66VZMdcPghnG0V6ahahJyQ8DQj+9b8KYsfu9HHdFF1VjR290LHyZSmDrI9
 cCUUOrMu7yH8IpZtEZBi6ckRZKXsaIRaxSIZv0bLymAgFTkUA17SxPhDTDVGKOdZVrjD5bm4J
 Lpuy1ZFKRdiarFIcLs016k8VViG3exSgStLR5Bx53t4IL3iAvlZf7BcEzE8JQiLDb4jeyc04J
 x2fJ9wjq6RCBM94jOaHsWb7TU7Hm9bsHyoHmz2VpncP/a/Jt7vQyicXyYtVjQ0eErtIPKZ0Va
 Ev8DpsmbLhR88ErfzEyQhx+7UAwzNtfISAZ+7U2u1ceLM4dtc8ASyUZnCLLImMiBzKYWXE8Kw
 iyDduqvWIB2ISImKRnPYyJxpWzSiN11cqB6Vnqg2dwGM/Ujbxy3bZhIbgTI6TK3TRb+YiwxmI
 wfG5QM968bGYhP9KQ1+UxrSVwaJzEoC7yUZyeZ5Nk+kISjNiLoFagpfNkQeN0D/twyUuuUqbi
 EB8lR8X
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
index bb9f79b..e79af9d 100644
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
2.10.0.windows.1.10.g803177d


