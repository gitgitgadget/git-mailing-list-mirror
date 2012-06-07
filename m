From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/6] Remove i18n legos in notifying new branch tracking setup
Date: Thu,  7 Jun 2012 19:05:10 +0700
Message-ID: <1339070715-31417-1-git-send-email-pclouds@gmail.com>
References: <0001-Remove-i18n-legos-in-notifying-new-branch-tracking-s.patch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 07 14:10:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScbXS-0000Um-8y
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 14:10:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754121Ab2FGMJu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jun 2012 08:09:50 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42519 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036Ab2FGMJr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 08:09:47 -0400
Received: by pbbrp8 with SMTP id rp8so990370pbb.19
        for <git@vger.kernel.org>; Thu, 07 Jun 2012 05:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=mBXn0q7/4gBQl/ndTLzo1yB5OD2UzF4d8aJeuwIhiMk=;
        b=cOpo98RPUASEQ1VNruNySWnxyOe/ZQp6X5kf/ff+mbT3XBkqjmj9Dpe3SpEDlTJjPs
         lcfRGclALfuWkF5DihMsPs59SnmGe1EJBkr34KQy+6pR5zK9lMveEwTWcs3fI+kthely
         a8YUa1Nj7iYIVlvdGv8SLzxp3Xroa4Xifce8VQT26YvcKZeTDaZEnLkzIhFJTAbV9OLf
         92/YkDyI3V2WA2XtsPRFzY4/mq4Xv3VkKKxEOPK9m3QMx+q7FxEpWQt1i6goCCkOgiPB
         drOquUQe/H0PmhT08a/ZRyFlj3Rgy0j1SOKNV0MvevNneRwgQdqSIqsbYzzvpItxuRL3
         jOiQ==
Received: by 10.68.131.38 with SMTP id oj6mr8874333pbb.39.1339070986927;
        Thu, 07 Jun 2012 05:09:46 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.55.113])
        by mx.google.com with ESMTPS id hb5sm3915158pbc.58.2012.06.07.05.09.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Jun 2012 05:09:45 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 07 Jun 2012 19:05:25 +0700
X-Mailer: git-send-email 1.7.8
In-Reply-To: <0001-Remove-i18n-legos-in-notifying-new-branch-tracking-s.patch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199396>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 More compact code compared to the lasst version while maintaining
 -Wformat's effectiveness.

 branch.c |   38 +++++++++++++++++++++++---------------
 1 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/branch.c b/branch.c
index eccdaf9..2bef1e7 100644
--- a/branch.c
+++ b/branch.c
@@ -74,25 +74,33 @@ void install_branch_config(int flag, const char *lo=
cal, const char *origin, cons
 		strbuf_addf(&key, "branch.%s.rebase", local);
 		git_config_set(key.buf, "true");
 	}
+	strbuf_release(&key);
=20
 	if (flag & BRANCH_CONFIG_VERBOSE) {
-		strbuf_reset(&key);
-
-		strbuf_addstr(&key, origin ? "remote" : "local");
-
-		/* Are we tracking a proper "branch"? */
-		if (remote_is_branch) {
-			strbuf_addf(&key, " branch %s", shortname);
-			if (origin)
-				strbuf_addf(&key, " from %s", origin);
-		}
+		if (remote_is_branch && origin)
+			printf(rebasing ?
+			       "Branch %s set up to track remote branch %s from %s by rebas=
ing.\n" :
+			       "Branch %s set up to track remote branch %s from %s.\n",
+			       local, shortname, origin);
+		else if (remote_is_branch && !origin)
+			printf(rebasing ?
+			       "Branch %s set up to track local branch %s by rebasing.\n" :
+			       "Branch %s set up to track local branch %s.\n",
+			       local, shortname);
+		else if (!remote_is_branch && origin)
+			printf(rebasing ?
+			       "Branch %s set up to track remote ref %s by rebasing.\n" :
+			       "Branch %s set up to track remote ref %s.\n",
+			       local, remote);
+		else if (!remote_is_branch && !origin)
+			printf(rebasing ?
+			       "Branch %s set up to track local ref %s by rebasing.\n" :
+			       "Branch %s set up to track local ref %s.\n",
+			       local, remote);
 		else
-			strbuf_addf(&key, " ref %s", remote);
-		printf("Branch %s set up to track %s%s.\n",
-		       local, key.buf,
-		       rebasing ? " by rebasing" : "");
+			die("BUG: impossible combination of %d and %p",
+			    remote_is_branch, origin);
 	}
-	strbuf_release(&key);
 }
=20
 /*
--=20
1.7.8
