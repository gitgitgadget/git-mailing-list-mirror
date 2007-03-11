From: James Bowes <jbowes@dangerouslyinc.com>
Subject: [PATCH 1/2] run-command: Make run_command_va_opt public and add run_command_va
Date: Sun, 11 Mar 2007 18:06:57 -0400
Message-ID: <11736508191143-git-send-email-jbowes@dangerouslyinc.com>
References: <11736508181273-git-send-email-jbowes@dangerouslyinc.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 11 23:07:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQWCE-0007Uj-34
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 23:07:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932890AbXCKWHP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 18:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932894AbXCKWHO
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 18:07:14 -0400
Received: from ms-smtp-03.southeast.rr.com ([24.25.9.102]:54214 "EHLO
	ms-smtp-03.southeast.rr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932890AbXCKWHN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Mar 2007 18:07:13 -0400
Received: from localhost (cpe-066-057-086-146.nc.res.rr.com [66.57.86.146])
	by ms-smtp-03.southeast.rr.com (8.13.6/8.13.6) with ESMTP id l2BM7B7m003236
	for <git@vger.kernel.org>; Sun, 11 Mar 2007 18:07:12 -0400 (EDT)
X-Mailer: git-send-email 1.5.0.2
In-Reply-To: <11736508181273-git-send-email-jbowes@dangerouslyinc.com>
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41996>

Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>
---
 run-command.c |    7 ++++++-
 run-command.h |    2 ++
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/run-command.c b/run-command.c
index cfbad74..34fc100 100644
--- a/run-command.c
+++ b/run-command.c
@@ -52,7 +52,7 @@ int run_command_v(const char **argv)
 	return run_command_v_opt(argv, 0);
 }
 
-static int run_command_va_opt(int opt, const char *cmd, va_list param)
+int run_command_va_opt(int opt, const char *cmd, va_list param)
 {
 	int argc;
 	const char *argv[MAX_RUN_COMMAND_ARGS];
@@ -70,6 +70,11 @@ static int run_command_va_opt(int opt, const char *cmd, va_list param)
 	return run_command_v_opt(argv, opt);
 }
 
+int run_command_va(const char *cmd, va_list param)
+{
+	return run_command_va_opt(0, cmd, param);
+}
+
 int run_command_opt(int opt, const char *cmd, ...)
 {
 	va_list params;
diff --git a/run-command.h b/run-command.h
index 59c4476..3934643 100644
--- a/run-command.h
+++ b/run-command.h
@@ -16,6 +16,8 @@ enum {
 #define RUN_COMMAND_STDOUT_TO_STDERR 4
 int run_command_v_opt(const char **argv, int opt);
 int run_command_v(const char **argv);
+int run_command_va_opt(int opt, const char *cmd, va_list param);
+int run_command_va(const char *cmd, va_list param);
 int run_command_opt(int opt, const char *cmd, ...);
 int run_command(const char *cmd, ...);
 
-- 
1.5.0.2
