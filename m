From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/18] config: use RUN_SETUP_GENTLY
Date: Sun,  7 Mar 2010 11:55:52 +0700
Message-ID: <1267937767-12504-4-git-send-email-pclouds@gmail.com>
References: <1267937767-12504-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 06:00:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No8av-0000K9-AG
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 06:00:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754139Ab0CGE7i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Mar 2010 23:59:38 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49858 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615Ab0CGE7h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 23:59:37 -0500
Received: by pwj8 with SMTP id 8so3156711pwj.19
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 20:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=f22puJ3wGocPFPNtqiM8jvvMCH/F0LvH1s2HJY2iXWU=;
        b=Pc/nUohTAA30vh6WbcqmybmPAo46Wa7aus0X7ov7xHqegKFf8jdRL+AInk1Kx2tuiC
         10Y7cyE9TazmRhFSqvEiPCTInWqpJZTWL/HL3gMNDVbwQg/pZyKTpkRMPzl0cbdKWRBC
         PQWdGv60/7AjtlwgCYYvR38rx/Ihxel5uunrc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=voKyc4r5cxod45ZktHDPEOFKR3CMwxV9gNmwNfwPvaiZ/ITD0Wsy+BU+ytEMJvp8eN
         AgiUFlKwdBF/Fnuws3d+rDPVYptZg4VCCH6MC+/JrLDM+8QOYVr7Pj4nItc8b2Ifgfft
         YTaNhILkQSM9z66S/aMiReciZQOtpkr6tu9CU=
Received: by 10.143.154.14 with SMTP id g14mr2084059wfo.153.1267937976665;
        Sat, 06 Mar 2010 20:59:36 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.223.3])
        by mx.google.com with ESMTPS id 21sm3251134pzk.4.2010.03.06.20.59.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Mar 2010 20:59:36 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  7 Mar 2010 11:56:21 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1267937767-12504-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141648>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/config.c |    6 ++----
 git.c            |    4 ++--
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 4bc46b1..ecc8f87 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -326,11 +326,9 @@ static int get_colorbool(int print)
 		return get_colorbool_found ? 0 : 1;
 }
=20
-int cmd_config(int argc, const char **argv, const char *unused_prefix)
+int cmd_config(int argc, const char **argv, const char *prefix)
 {
-	int nongit;
 	char *value;
-	const char *prefix =3D setup_git_directory_gently(&nongit);
=20
 	config_exclusive_filename =3D getenv(CONFIG_ENVIRONMENT);
=20
@@ -409,7 +407,7 @@ int cmd_config(int argc, const char **argv, const c=
har *unused_prefix)
 	}
 	else if (actions =3D=3D ACTION_EDIT) {
 		check_argc(argc, 0, 0);
-		if (!config_exclusive_filename && nongit)
+		if (!config_exclusive_filename && !startup_info->have_repository)
 			die("not in a git directory");
 		git_config(git_default_config, NULL);
 		launch_editor(config_exclusive_filename ?
diff --git a/git.c b/git.c
index 9e0e2d0..4c99319 100644
--- a/git.c
+++ b/git.c
@@ -309,7 +309,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "clean", cmd_clean, RUN_SETUP | NEED_WORK_TREE },
 		{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
-		{ "config", cmd_config },
+		{ "config", cmd_config, RUN_SETUP_GENTLY },
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
 		{ "describe", cmd_describe, RUN_SETUP },
 		{ "diff", cmd_diff },
@@ -366,7 +366,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "reflog", cmd_reflog, RUN_SETUP },
 		{ "remote", cmd_remote, RUN_SETUP },
 		{ "replace", cmd_replace, RUN_SETUP },
-		{ "repo-config", cmd_config },
+		{ "repo-config", cmd_config, RUN_SETUP_GENTLY },
 		{ "rerere", cmd_rerere, RUN_SETUP },
 		{ "reset", cmd_reset, RUN_SETUP },
 		{ "rev-list", cmd_rev_list, RUN_SETUP },
--=20
1.7.0.195.g637a2
