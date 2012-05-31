From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/6] Remove i18n legos in notifying new branch tracking setup
Date: Thu, 31 May 2012 20:04:37 +0700
Message-ID: <1338469482-30936-2-git-send-email-pclouds@gmail.com>
References: <1338463242-10618-1-git-send-email-worldhello.net@gmail.com>
 <1338469482-30936-1-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Thu May 31 15:09:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa57o-0006fy-4G
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 15:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757957Ab2EaNJH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 May 2012 09:09:07 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47113 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757948Ab2EaNJG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 09:09:06 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so1441131pbb.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 06:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=6tj0SiwLU/mJ6HaxrsH6c8UrViSTxi5W96VuObaGaY0=;
        b=I8OVmiZV7i/ugeki4PowFyEkvfl3Pg+6qgIsNvU7e3cof/qTYlpD4khOpRneN3YAe0
         qAFyoGwP46lEB3GdjTObXo6gysIsrVx3ME9NDB2Sa8shK+8pKBP+8496fMMSm1P1rtpU
         bZoLKwUO3/yC+fhLGQ/1/CNfdK+Qj1msPjC/MWgJCNs/l5hjO98pUGD+NR0mFSKnlG3o
         GoN0izaimdLRZC7MheXU8iicgD8p7qIzz48jTdNLeMn7BSFQqFmd2hVtN39p9FBHzPeo
         jzFKPAakANqYInGg4f5FxrIRyx43uPuzgq8S0JFt+Gv9xrvAGz+uexh5P2sBDXN7gGyP
         zQiA==
Received: by 10.68.232.103 with SMTP id tn7mr6630134pbc.86.1338469745917;
        Thu, 31 May 2012 06:09:05 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.14])
        by mx.google.com with ESMTPS id x1sm4139697pbp.50.2012.05.31.06.09.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 31 May 2012 06:09:05 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 31 May 2012 20:04:54 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338469482-30936-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198889>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 branch.c | 48 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/branch.c b/branch.c
index eccdaf9..d8facf7 100644
--- a/branch.c
+++ b/branch.c
@@ -74,25 +74,43 @@ void install_branch_config(int flag, const char *lo=
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
+		if (rebasing) {
+			if (remote_is_branch) {
+				if (origin)
+					printf("Branch %s set up to track remote branch %s from %s by reb=
asing.\n",
+					       local, shortname, origin);
+				else
+					printf("Branch %s set up to track local branch %s by rebasing.\n"=
,
+					       local, shortname);
+			} else {
+				if (origin)
+					printf("Branch %s set up to track remote ref %s by rebasing.\n",
+					       local, remote);
+				else
+					printf("Branch %s set up to track local ref %s by rebasing.\n",
+					       local, remote);
+			}
+		} else {
+			if (remote_is_branch) {
+				if (origin)
+					printf("Branch %s set up to track remote branch %s from %s.\n",
+					       local, shortname, origin);
+				else
+					printf("Branch %s set up to track local branch %s.\n",
+					       local, shortname);
+			} else {
+				if (origin)
+					printf("Branch %s set up to track remote ref %s.\n",
+					       local, remote);
+				else
+					printf("Branch %s set up to track local ref %s.\n",
+					       local, remote);
+			}
 		}
-		else
-			strbuf_addf(&key, " ref %s", remote);
-		printf("Branch %s set up to track %s%s.\n",
-		       local, key.buf,
-		       rebasing ? " by rebasing" : "");
 	}
-	strbuf_release(&key);
 }
=20
 /*
--=20
1.7.10.2.549.g9354186
