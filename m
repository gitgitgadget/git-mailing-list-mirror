From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 06/16] index-helper: add --detach
Date: Tue, 12 Apr 2016 20:32:59 -0400
Message-ID: <1460507589-25525-7-git-send-email-dturner@twopensource.com>
References: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.co,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 02:34:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq8l3-0002zV-7a
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 02:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758980AbcDMAeI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2016 20:34:08 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:35807 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758912AbcDMAd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 20:33:28 -0400
Received: by mail-qg0-f43.google.com with SMTP id f105so31005070qge.2
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 17:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=viTHvNEjsGMjbxMCYu+0ptjPNgctNYTDbm2AB8l0VH4=;
        b=W9v7hIzFek+A4ZdGayuZnfnGeKsin0NauSy5Rr90aA3pGQ6xbPjZUwOmNag/Pmy/3M
         DkQBF1aaEfTFMI33LY7GtXnXymcuv1D4PyM7Ht6Yx+7enEPcvvti7yXrcHNjWtMlKxEb
         ETinbQx6zXE49zvhquhPugaRk6ti+aYHbKZ2nhhpFm8k3T7Vs4mslyRbEcSf5bL8Cz0I
         jPq9pXimDu5yUvI8sKMGOGVgfvQdfpQsGzd9qBVzuyUUJ6q4DrKlfWCPCydcO1uvvSaO
         cUyslwd628vBfIUqPmyr4udKjWz7WYEL+jrSGGilP8L+BT8VDB/bWcVVEteuaVBG/mx5
         se5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=viTHvNEjsGMjbxMCYu+0ptjPNgctNYTDbm2AB8l0VH4=;
        b=FZqm1LxhT1beXm2XrkrhxjZTVHmImCMGKavkBQxYfCJE4fLntICIeO8fhEWWtOiujM
         M4VyLn08Y/DExtgMNsFXW1hBlsXdfYP0LyygB+kbTW6zYlfDi0K5ULqOcYRenLCjTMSd
         IAJG3y6IFCh1h3ylxj9FVzncsOy0/rYBs6DqlqrpoXl20xo58G93wloW8MMszOpDfcCY
         A/eim4fHgEqMjfZx5LZ7kms8gaAupX+Sqt8/WJvM6U0M6y8retR7uk+fjzqa+WOokwxs
         5Gsl0QAkq8SU+uXbgZ84VP6yr00zJ0QlRrKlTYoyj23VcLPC4TX6aGTbAHPjEZvtA/Kh
         gU+w==
X-Gm-Message-State: AOPr4FVa/bK832AQDrHzgfT+07o/PYzCVqU0cS4cvxYqbmPv8S8e1rupXlCc05XmOIG0ww==
X-Received: by 10.140.43.137 with SMTP id e9mr7580368qga.56.1460507607455;
        Tue, 12 Apr 2016 17:33:27 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id v65sm14677604qhc.6.2016.04.12.17.33.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Apr 2016 17:33:26 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291353>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

We detach after creating and opening the socket, because otherwise
we might return control to the shell before index-helper is ready to
accept commands.  This might lead to flaky tests.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/git-index-helper.txt |  3 +++
 index-helper.c                     | 11 +++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-index-helper.txt b/Documentation/git-ind=
ex-helper.txt
index 2382ba8..305ff35 100644
--- a/Documentation/git-index-helper.txt
+++ b/Documentation/git-index-helper.txt
@@ -31,6 +31,9 @@ OPTIONS
 	for reading an index, but because it will happen in the
 	background, it's not noticable. `--strict` is enabled by default.
=20
+--detach::
+	Detach from the shell.
+
 NOTES
 -----
=20
diff --git a/index-helper.c b/index-helper.c
index 9a4278f..83bfef5 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -16,7 +16,7 @@ struct shm {
=20
 static struct shm shm_index;
 static struct shm shm_base_index;
-static int to_verify =3D 1;
+static int daemonized, to_verify =3D 1;
=20
 static char *my_tmp_dir;
=20
@@ -103,6 +103,8 @@ static void cleanup_shm(void)
=20
 static void cleanup(void)
 {
+	if (daemonized)
+		return;
 	unlink(git_path("index-helper.path"));
 	cleanup_shm();
 }
@@ -354,7 +356,7 @@ static const char * const usage_text[] =3D {
 int main(int argc, char **argv)
 {
 	const char *prefix;
-	int idle_in_seconds =3D 600;
+	int idle_in_seconds =3D 600, detach =3D 0;
 	int fd;
 	struct strbuf socket_path =3D STRBUF_INIT;
 	struct option options[] =3D {
@@ -362,6 +364,7 @@ int main(int argc, char **argv)
 			    N_("exit if not used after some seconds")),
 		OPT_BOOL(0, "strict", &to_verify,
 			 "verify shared memory after creating"),
+		OPT_BOOL(0, "detach", &detach, "detach the process"),
 		OPT_END()
 	};
=20
@@ -396,6 +399,10 @@ int main(int argc, char **argv)
 		die(_("failed to delete old index-helper.path"));
 	if (symlink(get_my_tmp_dir(), git_path("index-helper.path")))
 		die(_("failed to symlink socket path into index-helper.path"));
+
+	if (detach && daemonize(&daemonized))
+		die_errno(_("unable to detach"));
+
 	loop(fd, idle_in_seconds);
=20
 	return 0;
--=20
2.4.2.767.g62658d5-twtrsrc
