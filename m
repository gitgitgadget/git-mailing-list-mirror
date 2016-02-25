From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv19 06/11] run-command: expose default_{start_failure, task_finished}
Date: Thu, 25 Feb 2016 15:48:34 -0800
Message-ID: <1456444119-6934-7-git-send-email-sbeller@google.com>
References: <CAPc5daWbkNXp8T4U2tiYftB4kSOjf9Cv1fgmbYbpuoKdJPRHGA@mail.gmail.com>
 <1456444119-6934-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, sunshine@sunshineco.com, jrnieder@gmail.com
To: sbeller@google.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 26 00:49:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ5eZ-0008Ca-Ku
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 00:49:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747AbcBYXs5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 18:48:57 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35160 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbcBYXs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 18:48:56 -0500
Received: by mail-pa0-f43.google.com with SMTP id ho8so41411771pac.2
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 15:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FvCdp4S4HwLahP21ct3uMjFDIejPx52HXPUXQXmvmWg=;
        b=jZ5we+M6xQLJT5QT2YjSZwriTSfS9g6L3DIUxQXTMvTyYCTgTtK99skkc4twQC9UZi
         xKgOJpnlEyyjWnG99vpxekgIVP+wHEGIjStL+9LdbQEGPOpeD/3GH1ip8UL49DSNHG3r
         zvwg2EPR8VZehx5N0m6sHIj4QDiOUzVkCZc8iQ0fap/l0xwNedbCUrOXSBe7IlntymSO
         hAPVWsBbtMHrWKDqEWQZqVxUpY6o/QUsAKuyQMJ7ree2PELJrh9Wrj8YZZghZN0HHvNm
         dZBzeFDkFnr3xI7WfVWv9X0Z56Dv59XziY8i1lZyPP/+7tadX5U+QA+1d9eW5h0Z9/Rb
         NIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FvCdp4S4HwLahP21ct3uMjFDIejPx52HXPUXQXmvmWg=;
        b=lfPY/DoylHtw726vVYlUCTo3iEWjhymLhQOcgBRxx1T3Hsb21Zum0sdXAGnVrXBjC4
         V6hycFUSVAVAIpgijeJpSBqG68+vtJLClmBoo0KtMn/fziKiB+nopzg1S2h83ifNzEK4
         E5agwxVH7A/JVIFnrVyN6rU2Ac9Nm9niFU6a5xkAIW6Inc9piplTBWXJzpJqMNXYh3g1
         fyJ+yHTym9sAR57fl9Sz19D+b8NAUI16rpbAaxmHAyDkqTp72+hrrhlmT+h0EZc8omnT
         CryzrjzmTxSKKSenxGgp7JDycJ0aljg6TATRqjXw8JGQRJ4ed1qJgfIZ+5p+o6PuUf6t
         +o5A==
X-Gm-Message-State: AG10YOSO8XWqUY7wLMO11ISSGpN8MZXrn2r+LM6rIhgSG/U3NxoS8MfFA4WtcF/iOixX/mYn
X-Received: by 10.66.252.100 with SMTP id zr4mr65817650pac.111.1456444135311;
        Thu, 25 Feb 2016 15:48:55 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a893:1c03:aadb:c3d])
        by smtp.gmail.com with ESMTPSA id ud10sm14629464pab.27.2016.02.25.15.48.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 Feb 2016 15:48:54 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.36.g75877e4.dirty
In-Reply-To: <1456444119-6934-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287498>

We want to reuse the error reporting facilities in a later patch.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
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
2.7.0.rc0.36.g75877e4.dirty
