From: David Turner <dturner@twopensource.com>
Subject: [PATCH v12 07/20] index-helper: add --detach
Date: Thu, 19 May 2016 17:45:44 -0400
Message-ID: <1463694357-6503-8-git-send-email-dturner@twopensource.com>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu May 19 23:47:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3VmW-0006fg-Qd
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 23:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbcESVqt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 May 2016 17:46:49 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33763 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754277AbcESVqq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 17:46:46 -0400
Received: by mail-qk0-f175.google.com with SMTP id n63so56493970qkf.0
        for <git@vger.kernel.org>; Thu, 19 May 2016 14:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vM15tEqildX6DO46TpEOsA1Mqlo6DFW/KBvMLBxaGtg=;
        b=Y96MC+ZbshvT8gFQ5s6VLgIBvQ1Da4OW/NpyAZPARCdXHhq+/Ms3CFaWf564iw2fLh
         BmTccX7eG8KJrmj0qUIYkdcq2lMvKsbvesUJhc1X+GQIR2F12J76vckGzWxUodYzUm8l
         sw+dobwglrXlDMbVQkDdq4oz6s9VAoONrWFk8I81fml0jBTwZ8PH+itfnxF2csP0T4hF
         Mm01U7a3k4jDA8s38t4PTkFsA6HC9GjZJf6FkaEBqvjzVy+/wXpZd0hbuiXwPbOn+ZAP
         SBA3Mu+OOTQl/cfyplGgy0DHzhNfx36uMb1SeIOkFGqXkXitcbvzdHDu8tWJeLSrlAdi
         z0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vM15tEqildX6DO46TpEOsA1Mqlo6DFW/KBvMLBxaGtg=;
        b=INvTSUyDeWSBZBnsB5+8zAe3JpROuj6eeheNOh7rcWb53NEsB/UUCQiI1PBYtDtmXX
         hldvRMykQv3tnS7LlMjt8TxGbts9GsciGXnbugrXLAnCADULWD7bwlugEZROeDzBn7lf
         3A1+Sw/gxIrg414oQkbjealTRqgj8o6OR5IpTnge7jHlUG4OsEeorznxiIivsu1I9Lw5
         BwfGgzhZAX+xYz4ij36V7KTWRquIrArmqbZLbF/WE9dkbmpmCvpdCCoaetCM4FcXCqfd
         FUsBuaXmFjk8By3ybkDp9KtvC6O7QrkplfZ89uwPmyKvamBy26ujG77F1hgRqOP+4uc8
         2R8Q==
X-Gm-Message-State: AOPr4FXn6xs7lM6rQjtyTmwMEHyJ8Tsz7yHWuK3dBfY/rMXMepz8HF+XPWAkUq1cEuPJCA==
X-Received: by 10.55.99.87 with SMTP id x84mr16650434qkb.163.1463694405693;
        Thu, 19 May 2016 14:46:45 -0700 (PDT)
Received: from twopensource.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id r124sm7424730qhr.48.2016.05.19.14.46.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 May 2016 14:46:44 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1463694357-6503-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295110>

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
index a7f8a42..6c8108f 100644
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
@@ -290,7 +292,7 @@ static const char * const usage_text[] =3D {
 int main(int argc, char **argv)
 {
 	const char *prefix;
-	int idle_in_seconds =3D 600;
+	int idle_in_seconds =3D 600, detach =3D 0;
 	int fd;
 	struct strbuf socket_path =3D STRBUF_INIT;
 	struct option options[] =3D {
@@ -298,6 +300,7 @@ int main(int argc, char **argv)
 			    N_("exit if not used after some seconds")),
 		OPT_BOOL(0, "strict", &to_verify,
 			 "verify shared memory after creating"),
+		OPT_BOOL(0, "detach", &detach, "detach the process"),
 		OPT_END()
 	};
=20
@@ -321,6 +324,8 @@ int main(int argc, char **argv)
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
