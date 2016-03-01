From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv21 00/10] Expose submodule parallelism to the user
Date: Mon, 29 Feb 2016 18:07:10 -0800
Message-ID: <1456798040-30129-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, pclouds@gmail.com,
	Jens.Lehmann@web.de, peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 01 03:07:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaZim-0002tF-SG
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 03:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbcCACH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 21:07:27 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33965 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996AbcCACH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 21:07:26 -0500
Received: by mail-pa0-f44.google.com with SMTP id fy10so102190683pac.1
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 18:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=oqXkH0+/BXFmahwqSmFGR7laHTxyKPIW8tkgI1HbRSk=;
        b=O+V38BXq9/jaJM+LBgOoagY3xS3l/yOs1r71B5bCYi8E55GplLLrcMEk1ogWx91lfp
         /7wsTgQQcAWN+yn3krdkiWZJ76RKxNEYiB3NtUWzJ85s55JtBPTLNLVmwLhPpQNlulC7
         LsCPcMSrz/pf5C92MmsPHRCeL42Yllbyksbf8S2EsNMJHpd0dNk3Ymsn/di4NqZLglBX
         iWD8SvQXuDPbPXHGyt0uYyXWbmpz2fzGIX7yEAGgv+tCsJnHM1wGHym4/NQ7ivpPMnli
         xzRlNtx5ENbcAPHJ+RocWCdLnuFtZ67CQ3zJi1gq9Bx1akgStnEl5KFWUjcQjWgs8OX5
         IQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oqXkH0+/BXFmahwqSmFGR7laHTxyKPIW8tkgI1HbRSk=;
        b=gkKahus7WJdmSbcowb3PgYmjeP2oetD//34a2YnY9roYn6EaAnv+N14siAPeohApYY
         Q52njhP2oqvNTVY/Zy3ik/18EBW6Mi6ak9k4uv90i2mWg+r6JD/CmfEaLSfTd3/8eDQo
         uW/Ca5FRghRaf+iKPrKwCSMk0FmqFaxWGeOB0RvePZCRCbKMfzFKsPsJdYhAJwOPUIUW
         rGKThl9ACIJJ3F2rvhTUpNh0c18SpJYQVGOQoa2y0gmbnAvYKkQExdi+sgWp6C3frSsJ
         Dg3YOsCB3aNrQLRgnhjwp2H8IAiMwPrx2LNCzDtuCWqtRmYHxktJkrQED3FBl1RL/fgP
         rAJQ==
X-Gm-Message-State: AD7BkJLFNmoW41BqfwSWcHeKg/aWFJjWf3csMu6FhAOBJz+yTK5PlN6g2DNQqAvb3Mrghhex
X-Received: by 10.66.62.134 with SMTP id y6mr26666693par.43.1456798045382;
        Mon, 29 Feb 2016 18:07:25 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e195:dbe1:d842:476])
        by smtp.gmail.com with ESMTPSA id 88sm7991532pft.44.2016.02.29.18.07.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 Feb 2016 18:07:23 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc0.1.g68b4e3f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287984>

* evicted patches:
  run-command: expose default_{start_failure, task_finished}
  run_processes_parallel: correctly terminate callbacks with an LF
* rebased on top of origin/sb/no-child-process-access-in-run-parallel-callbacks
* followed Jonathans advice on improving the situation for translators.

Junio wrote:
> Yup, let's stop rerolling this during pre-release period, and
> instead concentrate on fixing what's already in 'master' ;-)

Ok, feel free to ignore this series, I just want to put out
my latest version. Once you pick that up I'll likely put patches on top,
rather than rerolling as both Jonathan and me have the impression this
series has wedged out the rough errors by now and now we do subtle fixes
only.

Thanks,
Stefan
  

git diff origin/sb/submodule-parallel-update which is v20 of the series,
but as v21 has a different anchor point, the commit
origin/sb/no-child-process-access-in-run-parallel-callbacks is included
in this diff.

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 0272c98..a484945 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -298,13 +298,12 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	int needs_cloning = 0;
 
 	if (ce_stage(ce)) {
-		if (suc->recursive_prefix) {
-			strbuf_addf(out, "Skipping unmerged submodule %s/%s\n",
-				    suc->recursive_prefix, ce->name);
-		} else {
-			strbuf_addf(out, "Skipping unmerged submodule %s\n",
-				    ce->name);
-		}
+		if (suc->recursive_prefix)
+			strbuf_addf(&sb, "%s/%s", suc->recursive_prefix, ce->name);
+		else
+			strbuf_addf(&sb, "%s", ce->name);
+		strbuf_addf(out, _("Skipping unmerged submodule %s"), sb.buf);
+		strbuf_addch(out, '\n');
 		goto cleanup;
 	}
 
@@ -319,8 +318,8 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	if (suc->update.type == SM_UPDATE_NONE
 	    || (suc->update.type == SM_UPDATE_UNSPECIFIED
 		&& sub->update_strategy.type == SM_UPDATE_NONE)) {
-		strbuf_addf(out, "Skipping submodule '%s'\n",
-			    displaypath);
+		strbuf_addf(out, _("Skipping submodule '%s'"), displaypath);
+		strbuf_addch(out, '\n');
 		goto cleanup;
 	}
 
@@ -337,10 +336,15 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		 * Only mention uninitialized submodules when their
 		 * path have been specified
 		 */
-		if (suc->warn_if_uninitialized)
-			strbuf_addf(out, _("Submodule path '%s' not initialized\n"
-				    "Maybe you want to use 'update --init'?\n"),
-				    displaypath);
+		if (suc->warn_if_uninitialized) {
+			strbuf_addf(out,
+				_("Submodule path '%s' not initialized"),
+				displaypath);
+			strbuf_addch(out, '\n');
+			strbuf_addstr(out,
+				_("Maybe you want to use 'update --init'?"));
+			strbuf_addch(out, '\n');
+		}
 		goto cleanup;
 	}
 
@@ -400,21 +404,16 @@ static int update_clone_get_next_task(struct child_process *child,
 	return 0;
 }
 
-static int update_clone_start_failure(struct child_process *child,
-				      struct strbuf *err,
+static int update_clone_start_failure(struct strbuf *err,
 				      void *suc_cb,
 				      void *void_task_cb)
 {
 	struct submodule_update_clone *suc = suc_cb;
-
-	default_start_failure(child, err, suc_cb, void_task_cb);
 	suc->quickstop = 1;
-
 	return 1;
 }
 
 static int update_clone_task_finished(int result,
-				      struct child_process *child,
 				      struct strbuf *err,
 				      void *suc_cb,
 				      void *void_task_cb)
@@ -424,9 +423,7 @@ static int update_clone_task_finished(int result,
 	if (!result)
 		return 0;
 
-	default_task_finished(result, child, err, suc_cb, void_task_cb);
 	suc->quickstop = 1;
-
 	return 1;
 }
 
@@ -525,13 +522,13 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	if (argc < 2)
-		die(_("fatal: submodule--helper subcommand must be "
+		die(_("submodule--helper subcommand must be "
 		      "called with a subcommand"));
 
 	for (i = 0; i < ARRAY_SIZE(commands); i++)
 		if (!strcmp(argv[1], commands[i].cmd))
 			return commands[i].fn(argc - 1, argv + 1, prefix);
 
-	die(_("fatal: '%s' is not a valid submodule--helper "
+	die(_("'%s' is not a valid submodule--helper "
 	      "subcommand"), argv[1]);
 }
diff --git a/run-command.c b/run-command.c
index 6fad42f..62c6721 100644
--- a/run-command.c
+++ b/run-command.c
@@ -902,37 +902,18 @@ struct parallel_processes {
 	struct strbuf buffered_output; /* of finished children */
 };
 
-int default_start_failure(struct child_process *cp,
-			  struct strbuf *out,
-			  void *pp_cb,
-			  void *pp_task_cb)
+static int default_start_failure(struct strbuf *out,
+				 void *pp_cb,
+				 void *pp_task_cb)
 {
-	int i;
-
-	strbuf_addstr(out, "Starting a child failed:");
-	for (i = 0; cp->argv[i]; i++)
-		strbuf_addf(out, " %s", cp->argv[i]);
-	strbuf_addch(out, '\n');
-
 	return 0;
 }
 
-int default_task_finished(int result,
-			  struct child_process *cp,
-			  struct strbuf *out,
-			  void *pp_cb,
-			  void *pp_task_cb)
+static int default_task_finished(int result,
+				 struct strbuf *out,
+				 void *pp_cb,
+				 void *pp_task_cb)
 {
-	int i;
-
-	if (!result)
-		return 0;
-
-	strbuf_addf(out, "A child failed with return code %d:", result);
-	for (i = 0; cp->argv[i]; i++)
-		strbuf_addf(out, " %s", cp->argv[i]);
-	strbuf_addch(out, '\n');
-
 	return 0;
 }
 
@@ -1050,8 +1031,7 @@ static int pp_start_one(struct parallel_processes *pp)
 	pp->children[i].process.no_stdin = 1;
 
 	if (start_command(&pp->children[i].process)) {
-		code = pp->start_failure(&pp->children[i].process,
-					 &pp->children[i].err,
+		code = pp->start_failure(&pp->children[i].err,
 					 pp->data,
 					 &pp->children[i].data);
 		strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
@@ -1119,7 +1099,7 @@ static int pp_collect_finished(struct parallel_processes *pp)
 
 		code = finish_command(&pp->children[i].process);
 
-		code = pp->task_finished(code, &pp->children[i].process,
+		code = pp->task_finished(code,
 					 &pp->children[i].err, pp->data,
 					 &pp->children[i].data);
 
diff --git a/run-command.h b/run-command.h
index 2bd8fee..05cde5f 100644
--- a/run-command.h
+++ b/run-command.h
@@ -158,21 +158,11 @@ typedef int (*get_next_task_fn)(struct child_process *cp,
  * To send a signal to other child processes for abortion, return
  * the negative signal number.
  */
-typedef int (*start_failure_fn)(struct child_process *cp,
-				struct strbuf *out,
+typedef int (*start_failure_fn)(struct strbuf *out,
 				void *pp_cb,
 				void *pp_task_cb);
 
 /**
- * If a command fails to start, then print an error message stating the
- * exact command which failed.
- */
-int default_start_failure(struct child_process *cp,
-			  struct strbuf *out,
-			  void *pp_cb,
-			  void *pp_task_cb);
-
-/**
  * This callback is called on every child process that finished processing.
  *
  * You must not write to stdout or stderr in this function. Add your
@@ -187,22 +177,11 @@ int default_start_failure(struct child_process *cp,
  * the negative signal number.
  */
 typedef int (*task_finished_fn)(int result,
-				struct child_process *cp,
 				struct strbuf *out,
 				void *pp_cb,
 				void *pp_task_cb);
 
 /**
- * If the child process returns with a non zero error code, print
- * an error message of the exact command which failed.
- */
-int default_task_finished(int result,
-			  struct child_process *cp,
-			  struct strbuf *out,
-			  void *pp_cb,
-			  void *pp_task_cb);
-
-/**
  * Runs up to n processes at the same time. Whenever a process can be
  * started, the callback get_next_task_fn is called to obtain the data
  * required to start another child process.
diff --git a/submodule.c b/submodule.c
index 051f722..4bd14de 100644
--- a/submodule.c
+++ b/submodule.c
@@ -732,8 +732,7 @@ static int get_next_submodule(struct child_process *cp,
 	return 0;
 }
 
-static int fetch_start_failure(struct child_process *cp,
-			       struct strbuf *err,
+static int fetch_start_failure(struct strbuf *err,
 			       void *cb, void *task_cb)
 {
 	struct submodule_parallel_fetch *spf = cb;
@@ -743,8 +742,8 @@ static int fetch_start_failure(struct child_process *cp,
 	return 0;
 }
 
-static int fetch_finish(int retvalue, struct child_process *cp,
-			struct strbuf *err, void *cb, void *task_cb)
+static int fetch_finish(int retvalue, struct strbuf *err,
+			void *cb, void *task_cb)
 {
 	struct submodule_parallel_fetch *spf = cb;
 
diff --git a/test-run-command.c b/test-run-command.c
index fbe0a27..30a64a9 100644
--- a/test-run-command.c
+++ b/test-run-command.c
@@ -41,7 +41,6 @@ static int no_job(struct child_process *cp,
 }
 
 static int task_finished(int result,
-			 struct child_process *cp,
 			 struct strbuf *err,
 			 void *pp_cb,
 			 void *pp_task_cb)


Stefan Beller (10):
  submodule-config: keep update strategy around
  submodule-config: drop check against NULL
  fetching submodules: respect `submodule.fetchJobs` config option
  submodule update: direct error message to stderr
  run_processes_parallel: treat output of children as byte array
  run_processes_parallel: rename parameters for the callbacks
  git submodule update: have a dedicated helper for cloning
  submodule helper: remove double 'fatal: ' prefix
  submodule update: expose parallelism to the user
  clone: allow an explicit argument for parallel submodule clones

 Documentation/config.txt        |   6 +
 Documentation/git-clone.txt     |   6 +-
 Documentation/git-submodule.txt |   7 +-
 builtin/clone.c                 |  19 ++-
 builtin/fetch.c                 |   2 +-
 builtin/submodule--helper.c     | 256 +++++++++++++++++++++++++++++++++++++++-
 git-submodule.sh                |  56 ++++-----
 run-command.c                   |  12 +-
 run-command.h                   |  10 +-
 strbuf.c                        |   6 +
 strbuf.h                        |   6 +
 submodule-config.c              |  19 ++-
 submodule-config.h              |   2 +
 submodule.c                     |  37 +++++-
 submodule.h                     |  18 +++
 t/t5526-fetch-submodules.sh     |  14 +++
 t/t7400-submodule-basic.sh      |   4 +-
 t/t7406-submodule-update.sh     |  27 +++++
 18 files changed, 445 insertions(+), 62 deletions(-)

-- 
2.8.0.rc0.1.g68b4e3f
