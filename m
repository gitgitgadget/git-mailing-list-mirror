From: Yao Zhao <zhaox383@umn.edu>
Subject: [PATCH] GSoC Change multiple if-else statements to be table-driven
Date: Thu, 13 Mar 2014 15:20:59 -0500
Message-ID: <1394742059-7300-1-git-send-email-zhaox383@umn.edu>
References: <CAPig+cQu7D3AUghOSUOZBwf5+iHCPkxPbY1WuQmPJk1muCk7tQ@mail.gmail.com>
Cc: git@vger.kernel.org, Yao Zhao <zhaox383@umn.edu>
To: sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Thu Mar 13 21:21:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOC8M-0007wd-0L
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 21:21:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755272AbaCMUVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 16:21:38 -0400
Received: from vs-a.tc.umn.edu ([134.84.135.107]:53279 "EHLO vs-a.tc.umn.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755021AbaCMUVh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 16:21:37 -0400
Received: from mail-ig0-f177.google.com (mail-ig0-f177.google.com [209.85.213.177])
	by vs-a.tc.umn.edu (UMN smtpd) with ESMTP
	for <git@vger.kernel.org>; Thu, 13 Mar 2014 15:21:33 -0500 (CDT)
X-Umn-Remote-Mta: [N] mail-ig0-f177.google.com [209.85.213.177] #+LO+TS+TR
X-Umn-Classification: local
Received: by mail-ig0-f177.google.com with SMTP id ur14so3348692igb.4
        for <git@vger.kernel.org>; Thu, 13 Mar 2014 13:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UbdgsJCr1CiuOySPjSyacyJay/x83MLWTzbOS1Be9h8=;
        b=jrzghBuuyNeF00ce+Prr2SNoKUSZmRLUADyMCWfYYk0yAFxvmwVyvhn3kmUuQ7H3Yf
         aj8aFI7S8Vo99zHxaPYx5RJ3mu1gQ0oPBg8UaMm8mnoxlQZcf/cogGU/ZgEQUSgHQZV5
         t/XZzCreYFDtO3p+vm7nWjLTHG4opBYrwwBw7w7GpO8r5+vWC8f5SmGSd4GnLDn4+hw+
         SiTUX7JXgn/rtmYeqPmH9uA0zn+bLet6vcGI3Rormgt2Xt2nhfbUxtmdD3XCnKnU2G5d
         iexsaTpkPTec/YK3gqcb41gLknJljsQbw43VBWkEc0S1Gmq61EsJBwRdcTITrIWmClZu
         qYDw==
X-Gm-Message-State: ALoCoQkZINOh7z0AswB2WsV0eMAMyn7hxl2osFZKWbPLXO6Sh3ptTDxlBcFukbBRz529sXN49M7VxIZLiCuIvBk4BFPoERfOiRZPy6O+OMphXokc127jDKKban3Wokop2S8TzHLQyUZFP+lZHbP75tpNWhAmB0Bgvw==
X-Received: by 10.50.66.227 with SMTP id i3mr3867482igt.19.1394742092710;
        Thu, 13 Mar 2014 13:21:32 -0700 (PDT)
X-Received: by 10.50.66.227 with SMTP id i3mr3867478igt.19.1394742092628;
        Thu, 13 Mar 2014 13:21:32 -0700 (PDT)
Received: from Yao-Laptop.umn.edu (x-128-101-252-144.uofm-secure.wireless.umn.edu. [128.101.252.144])
        by mx.google.com with ESMTPSA id v2sm11708481igk.7.2014.03.13.13.21.29
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 13 Mar 2014 13:21:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <CAPig+cQu7D3AUghOSUOZBwf5+iHCPkxPbY1WuQmPJk1muCk7tQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244049>

Signed-off-by: Yao Zhao <zhaox383@umn.edu>
---
GSoC_MicroProject_#8

Hello Eric,

Thanks for reviewing my code. I implemented table-driven method this time and correct the style
problems indicated in review.

Thank you,

Yao

 branch.c | 72 ++++++++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 22 deletions(-)

diff --git a/branch.c b/branch.c
index 723a36b..6451c99 100644
--- a/branch.c
+++ b/branch.c
@@ -49,10 +49,43 @@ static int should_setup_rebase(const char *origin)
 
 void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
 {
+
 	const char *shortname = remote + 11;
 	int remote_is_branch = starts_with(remote, "refs/heads/");
 	struct strbuf key = STRBUF_INIT;
 	int rebasing = should_setup_rebase(origin);
+	int size=8, i;
+
+	typedef struct PRINT_LIST {
+		const char *print_str;
+		const char *arg2; 
+		//arg1 is always local, so I only add arg2 and arg3 in struct
+		const char *arg3;
+		int b_rebasing;
+	  int b_remote_is_branch;
+		int b_origin;
+	} PRINT_LIST;
+
+	PRINT_LIST print_list[] = {
+		{.print_str = _("Branch %s set up to track remote branch %s from %s by rebasing."), 
+				.arg2 = shortname, .arg3 = origin,
+					 .b_rebasing = 1, .b_remote_is_branch = 1, .b_origin = 1},
+	  {.print_str = _("Branch %s set up to track remote branch %s from %s."), 
+				.arg2 = shortname, .arg3 = origin,
+					 .b_rebasing = 0, .b_remote_is_branch = 1, .b_origin = 1},
+    {.print_str = _("Branch %s set up to track local branch %s by rebasing."), 
+				.arg2 = shortname, .b_rebasing = 1, .b_remote_is_branch = 1, .b_origin = 0},
+		{.print_str = _("Branch %s set up to track local branch %s."), 
+				.arg2 = shortname, .b_rebasing = 0, .b_remote_is_branch = 1, .b_origin = 0},
+		{.print_str = _("Branch %s set up to track remote ref %s by rebasing."), 
+				.arg2 = remote, .b_rebasing = 1, .b_remote_is_branch = 0, .b_origin = 1},
+		{.print_str = _("Branch %s set up to track remote ref %s."), 
+				.arg2 = remote, .b_rebasing = 0, .b_remote_is_branch = 0, .b_origin = 1},
+		{.print_str = _("Branch %s set up to track local ref %s by rebasing."), 
+				.arg2 = remote, .b_rebasing = 1, .b_remote_is_branch = 0, .b_origin = 0},
+		{.print_str = _("Branch %s set up to track local ref %s."), 
+				.arg2 = remote, .b_rebasing = 0, .b_remote_is_branch = 0, .b_origin = 0},
+};
I am confused here: I use struct initializer and I am not sure if it's ok
because it is only supported by ANSI 

 	if (remote_is_branch
 	    && !strcmp(local, shortname)
@@ -75,31 +108,26 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 		git_config_set(key.buf, "true");
 	}
 	strbuf_release(&key);
-
 	if (flag & BRANCH_CONFIG_VERBOSE) {
-		if (remote_is_branch && origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track remote branch %s from %s by rebasing.") :
-				  _("Branch %s set up to track remote branch %s from %s."),
-				  local, shortname, origin);
-		else if (remote_is_branch && !origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track local branch %s by rebasing.") :
-				  _("Branch %s set up to track local branch %s."),
-				  local, shortname);
-		else if (!remote_is_branch && origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track remote ref %s by rebasing.") :
-				  _("Branch %s set up to track remote ref %s."),
-				  local, remote);
-		else if (!remote_is_branch && !origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track local ref %s by rebasing.") :
-				  _("Branch %s set up to track local ref %s."),
-				  local, remote);
-		else
+		for (i=0;i<size;i++)
+		{
+			if (print_list[i].b_rebasing == (rebasing? 1 : 0) && 
+								print_list[i].b_remote_is_branch == (remote_is_branch? 1 : 0) &&
+								print_list[i].b_origin == (origin? 1 : 0))
+			{
+				if (print_list[i].arg3 == NULL)
+					printf_ln (print_list[i].print_str, local, print_list[i].arg2);
+				else
+					printf_ln (print_list[i].print_str, local, 
+							print_list[i].arg2, print_list[i].arg3);
+				
+				break;
+			}
+		}
+		if (i == size)
 			die("BUG: impossible combination of %d and %p",
 			    remote_is_branch, origin);
+
 	}
 }
 
-- 
1.8.3.2
