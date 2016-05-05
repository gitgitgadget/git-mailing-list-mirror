From: David Turner <dturner@twopensource.com>
Subject: [PATCH v8 07/19] index-helper: add --detach
Date: Thu,  5 May 2016 17:46:59 -0400
Message-ID: <1462484831-13643-8-git-send-email-dturner@twopensource.com>
References: <1462484831-13643-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Thu May 05 23:47:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayR7k-00082K-JB
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 23:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757938AbcEEVrh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2016 17:47:37 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:36674 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757433AbcEEVre (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 17:47:34 -0400
Received: by mail-qk0-f169.google.com with SMTP id x7so50844783qkd.3
        for <git@vger.kernel.org>; Thu, 05 May 2016 14:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u0Xdj5qAuhbyhOmEyv1bDr4WwBuQ7g7S55fbd+in02s=;
        b=FMI/gU0KtCfgnWqgI0/2y9pDQNdLD5FOu2w8oCkCP2HobanuSOdMnX6ZXDhpRvvUyJ
         cDNtavnzosgvfPIgiPE/G1Gqaa9N89+5EdZKdSDZGpr+qojPrYw9T829jSPh+Yo/J2kr
         hDPFQ0vHnNEnvM2kco/T/fy9CZzp2/bljIPehODYnMRpz0J8d5s2ofXVZGujsYROV90O
         lmex9N6/2XNY9OJe4whmxDuwOAIt0rDaalhQdLRq41NQ5FLRnt67/mIE6jOyzmLXFwdF
         XWk9zmvE3UVygVPvrBWEj/y+E/yyt4dnoeilHTPocTD5yplPqXAcbpX8Zf0o6oAHUQpj
         GbqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u0Xdj5qAuhbyhOmEyv1bDr4WwBuQ7g7S55fbd+in02s=;
        b=KpISLWRxO+sm0jxA/YsseI2uERKdHkltzjGwJKbRZaP7DLGwlKIWZdfBqIIVDF88tm
         Ztph89Ykm/+jlc9yPc6N7x6SynQEUjf5ODbZgERRlYwyVPkvvhIPuoKgjuvCJ+XPU5RE
         dyX72kD5t/d0Id2D/+d4HjhGVrkcWVDn7B9gQg4fKAowtIuBgVs3Dz1AGse+zIx+2JsP
         Th7xrUeZD3FoGLYH80BUweWjwOrRiBXt5rrkSOTUYth72o8sHVkCT5sPaBKKIB5Nkbrc
         TkWVjbGJhc8uFLSkG27O9fQq5BNMBtsa2DHzfCRFrgADSgiQ0puQwF0RbtF0TbLDB43u
         ureQ==
X-Gm-Message-State: AOPr4FW48n7Hb8q70qXxr4FqTgPZgr2mN+ZUpYp0tI06Wuo2f4IZYxK+zY7ehydiYgp7Lw==
X-Received: by 10.55.150.5 with SMTP id y5mr17101067qkd.144.1462484853909;
        Thu, 05 May 2016 14:47:33 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g186sm4393740qke.49.2016.05.05.14.47.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 May 2016 14:47:32 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1462484831-13643-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293689>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

We detach after creating and opening the socket, because otherwise
we might return control to the shell before index-helper is ready to
accept commands.  This might lead to flaky tests.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/git-index-helper.txt |  3 +++
 index-helper.c                     | 15 +++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-index-helper.txt b/Documentation/git-ind=
ex-helper.txt
index 9c2f5eb..e144752 100644
--- a/Documentation/git-index-helper.txt
+++ b/Documentation/git-index-helper.txt
@@ -34,6 +34,9 @@ OPTIONS
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
index 21fb431..7df7a97 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -17,7 +17,7 @@ struct shm {
=20
 static struct shm shm_index;
 static struct shm shm_base_index;
-static int to_verify =3D 1;
+static int daemonized, to_verify =3D 1;
=20
 static void log_warning(const char *warning, ...)
 {
@@ -59,6 +59,8 @@ static void cleanup_shm(void)
=20
 static void cleanup(void)
 {
+	if (daemonized)
+		return;
 	unlink(git_path("index-helper.sock"));
 	cleanup_shm();
 }
@@ -311,7 +313,7 @@ static const char * const usage_text[] =3D {
 int main(int argc, char **argv)
 {
 	const char *prefix;
-	int idle_in_seconds =3D 600;
+	int idle_in_seconds =3D 600, detach =3D 0;
 	int fd;
 	struct strbuf socket_path =3D STRBUF_INIT;
 	struct option options[] =3D {
@@ -319,6 +321,7 @@ int main(int argc, char **argv)
 			    N_("exit if not used after some seconds")),
 		OPT_BOOL(0, "strict", &to_verify,
 			 "verify shared memory after creating"),
+		OPT_BOOL(0, "detach", &detach, "detach the process"),
 		OPT_END()
 	};
=20
@@ -342,6 +345,14 @@ int main(int argc, char **argv)
 	if (fd < 0)
 		die_errno(_("could not set up index-helper socket"));
=20
+	if (!freopen("/dev/null", "w", stderr))
+		die_errno("failed to redirect stderr to /dev/null");
+
+	if (!freopen("/dev/null", "w", stdout))
+		die_errno("failed to redirect stdout to /dev/null");
+
+	if (detach && daemonize(&daemonized))
+		die_errno(_("unable to detach"));
 	loop(fd, idle_in_seconds);
=20
 	close(fd);
--=20
2.4.2.767.g62658d5-twtrsrc
