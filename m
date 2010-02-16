From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 22/26] help: move up gitdir setup to run_builtin()
Date: Tue, 16 Feb 2010 23:05:13 +0700
Message-ID: <1266336317-607-23-git-send-email-pclouds@gmail.com>
References: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 17:11:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhQ0O-0000l4-2x
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 17:10:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984Ab0BPQKW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2010 11:10:22 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:35786 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788Ab0BPQKV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 11:10:21 -0500
Received: by yxe38 with SMTP id 38so4319427yxe.4
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 08:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=EDb9N+8sPuqJ9TyMIqRTTbx8O0fOKI7uUre0kzuLyuk=;
        b=A64pLC1f4Kkt1uXqHnHFRC4QjahcIz14amldfjEYE9zO91903efsag3hU0CR3wPo0Y
         WXnZoAzs3j7qLxwPf+7D3g1loBedMygr82CBSTUfHxZ4dIntn1/BZv/PQ3QT7P5DSamm
         CIHCGCB+TweryBgKboUc3TLJe8/8+GaIQmeQU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=SXFkk2aTqIQaeJ8s3MIGHV41fY6A/HhLC4uimtfMZAZiAW8KLJGw9bn2Znw2qTLCrF
         29Tnq1WKIFPHUQz0CxaU4649OV5aeqjZXmOtd0ncw+ENwFS2zvhu3OYtN8d3l4t9OEXP
         kNsD6OWaqjOJcyLSe25ov+pRiH1T1IDNpNH9E=
Received: by 10.100.246.14 with SMTP id t14mr1878732anh.181.1266336620550;
        Tue, 16 Feb 2010 08:10:20 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.207.162])
        by mx.google.com with ESMTPS id 6sm2835323ywd.22.2010.02.16.08.10.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 08:10:19 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Feb 2010 23:07:37 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140115>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-help.c |    2 --
 git.c          |    2 +-
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/builtin-help.c b/builtin-help.c
index 3182a2b..4988629 100644
--- a/builtin-help.c
+++ b/builtin-help.c
@@ -414,7 +414,6 @@ static void show_html_page(const char *git_cmd)
=20
 int cmd_help(int argc, const char **argv, const char *prefix)
 {
-	int nongit;
 	const char *alias;
 	enum help_format parsed_help_format;
 	load_command_list("git-", &main_cmds, &other_cmds);
@@ -437,7 +436,6 @@ int cmd_help(int argc, const char **argv, const cha=
r *prefix)
 		return 0;
 	}
=20
-	setup_git_directory_gently(&nongit);
 	git_config(git_help_config, NULL);
=20
 	if (parsed_help_format !=3D HELP_FORMAT_NONE)
diff --git a/git.c b/git.c
index 0a0588b..c922400 100644
--- a/git.c
+++ b/git.c
@@ -344,7 +344,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "get-tar-commit-id", cmd_get_tar_commit_id },
 		{ "grep", cmd_grep, RUN_SETUP_GENTLY | USE_PAGER },
 		{ "hash-object", cmd_hash_object, RUN_SETUP_GENTLY },
-		{ "help", cmd_help },
+		{ "help", cmd_help, RUN_SETUP_GENTLY },
 		{ "index-pack", cmd_index_pack },
 		{ "init", cmd_init_db },
 		{ "init-db", cmd_init_db },
--=20
1.7.0.195.g637a2
