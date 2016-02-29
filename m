From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv20 06/12] run-command: expose default_{start_failure, task_finished}
Date: Mon, 29 Feb 2016 11:14:04 -0800
Message-ID: <1456773250-5510-7-git-send-email-sbeller@google.com>
References: <1456773250-5510-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon Feb 29 20:14:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaTHK-0005nN-Jq
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 20:14:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674AbcB2TOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 14:14:35 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36611 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333AbcB2TOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 14:14:25 -0500
Received: by mail-pa0-f44.google.com with SMTP id yy13so96658501pab.3
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 11:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MOpxx3cO5WM5JXr4w25ZjtUa/WxzUKl22eU+0nbS08A=;
        b=TuSkWC9vecV1ecIpeCaqkIOv5/4geZmCvfnZBpEqwVgrM+zmH7i0txyCEvDWQhLOKf
         htwaqbf/nOUc3XHP1+jkk6KgP6W8ZJQM5O5wg+Q2jMOYFBFW1bbKmk0d4Rz/dps4FCoA
         dacx9YtiBcALxMnyI6i8iFxRa2CtjtE+oXb7XvNr/wHzB1bLyINkQHHm4xusioPar3jO
         iQ/oYAJp+jKbiNN7Gutg+ENhx/8HODiF9Fezy+FOw9fzTSJiA39mTfRN9C9pApuXXHaR
         S4R26SwJvpVU3B/E9MOyD0q5grQsIfK6TPLcUIeKtb9oOzjUvS375+TJgRmI5XjVwqdU
         LQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MOpxx3cO5WM5JXr4w25ZjtUa/WxzUKl22eU+0nbS08A=;
        b=ceDq+lg0C8sNW0UKFBbfbGYGhGIerW+4toLaP3RavTGTi1gVG6SYKkuIOPRFLOoyjJ
         Ek1cNO2Peqt3WDr/J1mYG0R/NBOejeBEw++witLw76ufYyKY8TVj0NNaFxpiJpssrlH4
         /I3baOAMoev717YV8n9un9nr2c+lzZvzU8HGOH+jBUIW04B9xOfOUJpgGQuYGTzPbiwD
         +iYDOtDBYOOvKPfTqrcjzyq0PTN+NVCFpOoLaVIviiHMzSF30uMOnhj1Gs2oTEbtGELb
         EnAblrsjzC/pdlxNvBw5ic37Q/Wu0yhOnNIS3TrUOTKRVurJTjH6pA2UK7FOLLsD6dCy
         Te6Q==
X-Gm-Message-State: AD7BkJJG7bhZefABKTX/yayur8xjsbwOgQ5HaGgVTnC6h7d4BNXgHg+cnwuQBPkliL/Goi5k
X-Received: by 10.66.145.68 with SMTP id ss4mr24334366pab.79.1456773264953;
        Mon, 29 Feb 2016 11:14:24 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e195:dbe1:d842:476])
        by smtp.gmail.com with ESMTPSA id h72sm8071171pfh.43.2016.02.29.11.14.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 Feb 2016 11:14:24 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.37.gb7b9e8e
In-Reply-To: <1456773250-5510-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287881>

We want to reuse the error reporting facilities in a later patch.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 run-command.c | 18 +++++++++---------
 run-command.h | 19 +++++++++++++++++++
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/run-command.c b/run-command.c
index 2f8f222..c9b13cf 100644
--- a/run-command.c
+++ b/run-command.c
@@ -902,10 +902,10 @@ struct parallel_processes {
 	struct strbuf buffered_output; /* of finished children */
 };
 
-static int default_start_failure(struct child_process *cp,
-				 struct strbuf *err,
-				 void *pp_cb,
-				 void *pp_task_cb)
+int default_start_failure(struct child_process *cp,
+			  struct strbuf *err,
+			  void *pp_cb,
+			  void *pp_task_cb)
 {
 	int i;
 
@@ -916,11 +916,11 @@ static int default_start_failure(struct child_process *cp,
 	return 0;
 }
 
-static int default_task_finished(int result,
-				 struct child_process *cp,
-				 struct strbuf *err,
-				 void *pp_cb,
-				 void *pp_task_cb)
+int default_task_finished(int result,
+			  struct child_process *cp,
+			  struct strbuf *err,
+			  void *pp_cb,
+			  void *pp_task_cb)
 {
 	int i;
 
diff --git a/run-command.h b/run-command.h
index d5a57f9..a054fa6 100644
--- a/run-command.h
+++ b/run-command.h
@@ -164,6 +164,15 @@ typedef int (*start_failure_fn)(struct child_process *cp,
 				void *pp_task_cb);
 
 /**
+ * If a command fails to start, then print an error message stating the
+ * exact command which failed.
+ */
+int default_start_failure(struct child_process *cp,
+			  struct strbuf *err,
+			  void *pp_cb,
+			  void *pp_task_cb);
+
+/**
  * This callback is called on every child process that finished processing.
  *
  * You must not write to stdout or stderr in this function. Add your
@@ -184,6 +193,16 @@ typedef int (*task_finished_fn)(int result,
 				void *pp_task_cb);
 
 /**
+ * If the child process returns with a non zero error code, print
+ * an error message of the exact command which failed.
+ */
+int default_task_finished(int result,
+			  struct child_process *cp,
+			  struct strbuf *err,
+			  void *pp_cb,
+			  void *pp_task_cb);
+
+/**
  * Runs up to n processes at the same time. Whenever a process can be
  * started, the callback get_next_task_fn is called to obtain the data
  * required to start another child process.
-- 
2.7.0.rc0.37.gb7b9e8e
