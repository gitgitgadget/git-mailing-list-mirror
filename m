From: David Turner <dturner@twopensource.com>
Subject: [PATCH v9 07/19] index-helper: add --detach
Date: Mon,  9 May 2016 16:48:37 -0400
Message-ID: <1462826929-7567-8-git-send-email-dturner@twopensource.com>
References: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon May 09 22:52:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azs7M-0003yU-O9
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 22:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460AbcEIUtQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2016 16:49:16 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:36227 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345AbcEIUtO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 16:49:14 -0400
Received: by mail-qg0-f49.google.com with SMTP id w36so95741860qge.3
        for <git@vger.kernel.org>; Mon, 09 May 2016 13:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u0Xdj5qAuhbyhOmEyv1bDr4WwBuQ7g7S55fbd+in02s=;
        b=CKogFxJwIwSK7ZGWHfVfP7JDtsahZ46IwKeTOtqxW/aVEfr3YU9IlLuM2ot/GidLFG
         bwWrAMdAKijEoPUjhHU7tAzbEYZ+oRCYw2ixYINn6vB6FzCYCXs9R1mK9XtA3IYHCMNa
         0k9TTmEieZ8IpoWfCerd3h2Vv4TDhIEBvQPkXDG1NagltCyFIU57SuSvpXWojNiqGR0z
         Kcno9+L64CQ8OfkaDXrCzqXgvKoRQ3l3TWt8lOJiKPQmZNnVG1gIe8A8egkwi6kYIzh7
         AampGfTLei04D6zHB/g5eRH5oA5Aa2kFwnpJuMOSVhHQSHUg/TgdIBx+ojIMzFDiNn+E
         lr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u0Xdj5qAuhbyhOmEyv1bDr4WwBuQ7g7S55fbd+in02s=;
        b=Yl1z+3RjM+c+FNKeIRYKuzEj82A14eUyvgTaQhiBhMhMVMdGfEs0knOzUyB6jQylPR
         HEa67Zd6Rjul3vE0WZsltpj22hnVfiNy4pEWBy3vvHGdmf+oDxDHo35iXxYYtdNnTd/v
         fM/BiOq+JYWvAa3ekFD2jVQYezMROaQo8MsC2M8nmw6yN8GUk+5NhJFy/o0fN6Alus57
         DrjXU4tYrp4O9dpopo29OQ3/Z6l6nYu5Ke0C7C9ZbAeqCUvHc2/2+LVAvhenXkbB7Oms
         YkApDOwbvBQ3r/QDV9GrSnfRxrBp0LVakh9oWoN4GVY/xf0XsCTxBS7exQMqzoAkOMvc
         NfKA==
X-Gm-Message-State: AOPr4FXxWYsDC8XHzbaxo2MV6eFGQySbcwc+YPxYgwpWTvcizjofuQvfj/Os1Th8Cwi3iQ==
X-Received: by 10.140.133.5 with SMTP id 5mr27677072qhf.19.1462826952973;
        Mon, 09 May 2016 13:49:12 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id n1sm12729182qkn.3.2016.05.09.13.49.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 May 2016 13:49:11 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294069>

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
