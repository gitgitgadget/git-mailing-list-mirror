From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 1/7] Let mingw_execve() return an int
Date: Wed, 11 Jun 2014 11:37:40 +0200
Message-ID: <1402479466-8500-2-git-send-email-kasal@ucw.cz>
References: <1402479466-8500-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRB7OG4COAKGQEU5PATQQ@googlegroups.com Wed Jun 11 11:38:09 2014
Return-path: <msysgit+bncBCU63DXMWULRB7OG4COAKGQEU5PATQQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f191.google.com ([209.85.212.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB7OG4COAKGQEU5PATQQ@googlegroups.com>)
	id 1Wueys-0004Jr-HA
	for gcvm-msysgit@m.gmane.org; Wed, 11 Jun 2014 11:38:06 +0200
Received: by mail-wi0-f191.google.com with SMTP id q5sf64563wiv.18
        for <gcvm-msysgit@m.gmane.org>; Wed, 11 Jun 2014 02:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=RLUReczeI39APufaUTDhX+CKVdaHBQEJr4x+KqPKBYg=;
        b=vUYAIUER3dKmzZq/A+sTLer69sK4HzKJcdUcBdpDJ1P89K15yropWznuofDqKWTxL/
         Wq6V7oyWTJW49I/UVC7duM53Cdb1YXX9M9XM7DVJRF1B5ZJBMNBPX7mKaVCT3GG1dxDJ
         AFM2sbeoqvAAVRopBhxNQLYgZ0EoflZXtUfoH0kD8Bkzbn/4K2cbYPKbxKodRKL9YvC+
         yPCNE+P4rktDihvMYS5DTUXsXYlcuXiTk9pHxaXOtbGDxmcBAlO6a61O68debWe4oEqU
         6ssrRfzZvdLV+erw25TWaIujWJgOVNmVyiHQLfdscTPwzABXD1ReJCm3CapNNIecdchc
         0a+g==
X-Received: by 10.152.42.225 with SMTP id r1mr8061lal.13.1402479485917;
        Wed, 11 Jun 2014 02:38:05 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.37.169 with SMTP id z9ls396114laj.66.gmail; Wed, 11 Jun
 2014 02:38:04 -0700 (PDT)
X-Received: by 10.112.163.195 with SMTP id yk3mr20406lbb.20.1402479484797;
        Wed, 11 Jun 2014 02:38:04 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id pk3si877267wic.0.2014.06.11.02.38.04
        for <msysgit@googlegroups.com>;
        Wed, 11 Jun 2014 02:38:04 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 8B2761C009E; Wed, 11 Jun 2014 11:38:04 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402479466-8500-1-git-send-email-kasal@ucw.cz>
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251352>

From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Mon, 28 May 2012 21:21:39 -0500

This is in the great tradition of POSIX. Original fix by Olivier Refalo.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/mingw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index d242557..7da73fa 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1019,7 +1019,7 @@ static int try_shell_exec(const char *cmd, char *const *argv, char **env)
 	return pid;
 }
 
-static void mingw_execve(const char *cmd, char *const *argv, char *const *env)
+static int mingw_execve(const char *cmd, char *const *argv, char *const *env)
 {
 	/* check if git_command is a shell script */
 	if (!try_shell_exec(cmd, argv, (char **)env)) {
@@ -1027,11 +1027,12 @@ static void mingw_execve(const char *cmd, char *const *argv, char *const *env)
 
 		pid = mingw_spawnve(cmd, (const char **)argv, (char **)env, 0);
 		if (pid < 0)
-			return;
+			return -1;
 		if (waitpid(pid, &status, 0) < 0)
 			status = 255;
 		exit(status);
 	}
+	return -1;
 }
 
 int mingw_execvp(const char *cmd, char *const *argv)
-- 
2.0.0.9635.g0be03cb

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
