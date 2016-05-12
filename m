From: David Turner <dturner@twopensource.com>
Subject: [PATCH v10 07/20] index-helper: add --detach
Date: Thu, 12 May 2016 16:20:02 -0400
Message-ID: <1463084415-19826-8-git-send-email-dturner@twopensource.com>
References: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu May 12 22:21:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0x6V-0005AB-Qx
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 22:21:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbcELUUq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 May 2016 16:20:46 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:35871 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbcELUUj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 16:20:39 -0400
Received: by mail-ig0-f176.google.com with SMTP id lr7so62827866igb.1
        for <git@vger.kernel.org>; Thu, 12 May 2016 13:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iL+1qvclEU9Aea6/XYAw6QGJAyYx/ZYUWflUFiUJUd8=;
        b=ViGLYT+b66Ka06mjDOs573tVece0pG4TW2R3GI9wT0GV7SYqAgosbIRuPnWaoOEV9Y
         QS6856WbWEz32I+B2hE2L1J6PBP5KzXgYv2pWOZgS2/MOgcv5a8gyVSiTkuz/cwP0qoG
         W9SrawsMKgUUBruWa7g4gnw3FnKTQTz7YeHtOoWtRkQ3/MjT8bnafifXwE7GboJ+WZHC
         Fyx5itb4iW4cqTuK93WksyTxOdMljJP/wVwDmwVRvGl+zTLvlY93EBCcreo2W2TN23hp
         TwE+oK1IoAqt3KI4EVjnyvWBRKdH+6SFbQTuN/eBcaVGSwPrftH7lG2pL10J1ugca6GQ
         AnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iL+1qvclEU9Aea6/XYAw6QGJAyYx/ZYUWflUFiUJUd8=;
        b=ip19gSCU0VHlcOxNW0dbWtvVmIipsQFNmyho9I4PFMmCWHDU6/XAvwsvWYazz6eHo9
         c2p27wtxYecZ8J6/LBHfaTZlMlMp37+RVIRHdFoR68wfhgjG/O/9I71F6kTRlaLqPMy7
         C1GNLL1Q2qu18LjIYpAAO++j9dCxP5FeVHDcf7H+EuzvkvmOm19Ogipwd2yX0DSVzQdZ
         M2zP/8xca8wIsrsMrmFhue/JGMedqYPvbF+Rm3UGzDwXhC5rbjv+EDujAhG9TGk4jEJ4
         cFZlnmEmHMECx1gn5GPv7cDBrfGC5ydUwqPcxq+O6QhdP5RHshyJbZwWBPU3Vr8VyDkq
         2WfQ==
X-Gm-Message-State: AOPr4FVg7wYnQmvvRe4Rzb/nHe8epR2AfJbuP9zPhu6Mmj3gTefuJiT7n5TSm3RCHzTcFA==
X-Received: by 10.50.3.73 with SMTP id a9mr27427973iga.22.1463084433616;
        Thu, 12 May 2016 13:20:33 -0700 (PDT)
Received: from twopensource.com ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id s8sm5055496igg.17.2016.05.12.13.20.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 May 2016 13:20:32 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294456>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

We detach after creating and opening the socket, because otherwise
we might return control to the shell before index-helper is ready to
accept commands.  This might lead to flaky tests.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/git-index-helper.txt | 3 +++
 index-helper.c                     | 9 +++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-index-helper.txt b/Documentation/git-ind=
ex-helper.txt
index 1f92c89..f853960 100644
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
index bc7e110..65abfd0 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -17,7 +17,7 @@ struct shm {
=20
 static struct shm shm_index;
 static struct shm shm_base_index;
-static int to_verify =3D 1;
+static int daemonized, to_verify =3D 1;
=20
 static void release_index_shm(struct shm *is)
 {
@@ -36,6 +36,8 @@ static void cleanup_shm(void)
=20
 static void cleanup(void)
 {
+	if (daemonized)
+		return;
 	unlink(git_path("index-helper.sock"));
 	cleanup_shm();
 }
@@ -287,7 +289,7 @@ static const char * const usage_text[] =3D {
 int main(int argc, char **argv)
 {
 	const char *prefix;
-	int idle_in_seconds =3D 600;
+	int idle_in_seconds =3D 600, detach =3D 0;
 	int fd;
 	struct strbuf socket_path =3D STRBUF_INIT;
 	struct option options[] =3D {
@@ -295,6 +297,7 @@ int main(int argc, char **argv)
 			    N_("exit if not used after some seconds")),
 		OPT_BOOL(0, "strict", &to_verify,
 			 "verify shared memory after creating"),
+		OPT_BOOL(0, "detach", &detach, "detach the process"),
 		OPT_END()
 	};
=20
@@ -318,6 +321,8 @@ int main(int argc, char **argv)
 	if (fd < 0)
 		die_errno(_("could not set up index-helper socket"));
=20
+	if (detach && daemonize(&daemonized))
+		die_errno(_("unable to detach"));
 	loop(fd, idle_in_seconds);
=20
 	close(fd);
--=20
2.4.2.767.g62658d5-twtrsrc
