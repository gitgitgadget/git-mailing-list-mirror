From: Michael Coleman <tutufan@gmail.com>
Subject: [PATCH] fix uninitialized use of msg buffer
Date: Sat,  3 Feb 2007 10:49:23 -0600
Message-ID: <11705213662728-git-send-email-tutufan@gmail.com>
References: <11705213633209-git-send-email-tutufan@gmail.com>
Cc: Michael Coleman <tutufan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 03 17:49:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDO55-0004Zc-TZ
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 17:49:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992430AbXBCQtc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 11:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992431AbXBCQtc
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 11:49:32 -0500
Received: from py-out-1112.google.com ([64.233.166.182]:41295 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992430AbXBCQtb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 11:49:31 -0500
Received: by py-out-1112.google.com with SMTP id a29so567120pyi
        for <git@vger.kernel.org>; Sat, 03 Feb 2007 08:49:31 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=i/86zb0iXuyq4LY7fzwUnvYfOAzsycMTSDFndLAnP+kLACYv/Bo/phAD+apXIwt37OsEr2F5n6mBLRc6ltXolBiVEomEUWJyn2tB/6yigKbDHJ0wKRmL5tM1aLo41PxOvxjiJKhpTzKwpOxPAxqMdqEAZaj9nfyMhFWOz952De8=
Received: by 10.35.40.10 with SMTP id s10mr9528096pyj.1170521370923;
        Sat, 03 Feb 2007 08:49:30 -0800 (PST)
Received: from tutufan@gmail.com ( [69.154.213.42])
        by mx.google.com with ESMTP id 15sm22441358nzo.2007.02.03.08.49.28;
        Sat, 03 Feb 2007 08:49:29 -0800 (PST)
Received: by tutufan@gmail.com (sSMTP sendmail emulation); Sat,  3 Feb 2007 10:49:26 -0600
X-Mailer: git-send-email 1.5.0.rc3
In-Reply-To: <11705213633209-git-send-email-tutufan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38576>

---
 builtin-branch.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index d60690b..ac64b99 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -315,7 +315,7 @@ static void create_branch(const char *name, const char *start_name,
 	struct ref_lock *lock;
 	struct commit *commit;
 	unsigned char sha1[20];
-	char ref[PATH_MAX], msg[PATH_MAX + 20];
+	char ref[PATH_MAX], msg[PATH_MAX + 20] = { 0 };
 
 	snprintf(ref, sizeof ref, "refs/heads/%s", name);
 	if (check_ref_format(ref))
-- 
1.5.0.rc3
