From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/4] environment.c: fix constness for odb_pack_keep()
Date: Sun, 16 Mar 2014 20:35:00 +0700
Message-ID: <1394976904-15395-2-git-send-email-pclouds@gmail.com>
References: <1394976904-15395-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 16 14:34:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPBD2-0005nD-RT
	for gcvg-git-2@plane.gmane.org; Sun, 16 Mar 2014 14:34:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177AbaCPNeb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Mar 2014 09:34:31 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:57779 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbaCPNea (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2014 09:34:30 -0400
Received: by mail-pb0-f52.google.com with SMTP id rr13so4580150pbb.25
        for <git@vger.kernel.org>; Sun, 16 Mar 2014 06:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=hSpbCSRTPjE19iOQkMdjRfPwUxk1mJtwldwz1PSX9+4=;
        b=Z0TJfEebcZ4IDVS2P+LWeUWSLveAoHYXjwpu7E27z8ljGAUxNlQXCXf6UFG1CNv0Uh
         aef8+/KUxve94vhppGM3aiUar0f7+5h5N/u6FF5Z6/CQn/hJ4/OP4VgnY36OOrF4fZSy
         1iN1ITWZ38R+QdFndg5Iuc0wAtPLiqqIyfG1ij0KeVzttlWM8FWUHCh6Vs/3W1cEM0zq
         So+2Qj+jnS10wSLd/w2bKuM0bM6anNhwSuVS+unnXvSZfr+gU0iSqiYICeqz5tSHEU9k
         Lp2mpYWsT8MBnMJXp/3de0OPziQCQjx8AKrJd+R444YaUN7YiBug4T4XBI7DM7yeAmHt
         up4Q==
X-Received: by 10.66.121.195 with SMTP id lm3mr851309pab.154.1394976870141;
        Sun, 16 Mar 2014 06:34:30 -0700 (PDT)
Received: from lanh ([115.73.203.48])
        by mx.google.com with ESMTPSA id kt8sm9803081pab.7.2014.03.16.06.34.27
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 16 Mar 2014 06:34:29 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 16 Mar 2014 20:35:12 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1394976904-15395-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244195>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 environment.c     | 2 +-
 git-compat-util.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/environment.c b/environment.c
index c3c8606..5c4815d 100644
--- a/environment.c
+++ b/environment.c
@@ -237,7 +237,7 @@ int odb_mkstemp(char *template, size_t limit, const=
 char *pattern)
 	return xmkstemp_mode(template, mode);
 }
=20
-int odb_pack_keep(char *name, size_t namesz, unsigned char *sha1)
+int odb_pack_keep(char *name, size_t namesz, const unsigned char *sha1=
)
 {
 	int fd;
=20
diff --git a/git-compat-util.h b/git-compat-util.h
index 585ef8a..adbfb5e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -533,7 +533,7 @@ extern FILE *xfdopen(int fd, const char *mode);
 extern int xmkstemp(char *template);
 extern int xmkstemp_mode(char *template, int mode);
 extern int odb_mkstemp(char *template, size_t limit, const char *patte=
rn);
-extern int odb_pack_keep(char *name, size_t namesz, unsigned char *sha=
1);
+extern int odb_pack_keep(char *name, size_t namesz, const unsigned cha=
r *sha1);
=20
 static inline size_t xsize_t(off_t len)
 {
--=20
1.9.0.40.gaa8c3ea
