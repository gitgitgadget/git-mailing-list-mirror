From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/43] mailinfo: use RUN_SETUP_GENTLY
Date: Mon,  5 Apr 2010 20:40:54 +0200
Message-ID: <1270492888-26589-10-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:42:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrFf-0005ZJ-UE
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:42:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755963Ab0DESmL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:42:11 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:62876 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755864Ab0DESmF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:42:05 -0400
Received: by mail-fx0-f227.google.com with SMTP id 27so1250782fxm.28
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=/2FKVWciVCBWnug8nc3FIkgy4JiH59TlH+5s5IBx2TI=;
        b=sH3CFB/Zs4qvTSWF9tkGjdo7oYABBy009dnyiWN8fOD3ZNjkfjLES8X5P/S9uPB8Zp
         RBmLfOmRTGeXKBDFTevJFwMkXQBUxnp6EJWeUI831JgZFoFdhI3cCtS1DqL2R57Hm9lc
         QLZ1XyVql4LJHHXcbspeVzihGxZ39Bveq9w9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=b5qcbMxW8RVqOXKgU/QPZEn527SXdC8msX2sVex/ip0sZptIL8KD+SOMIdZ3l4vzgC
         aU2RdPqqSC2M5Fku4e1bHZEjpoLWACS/is84sioV4HlusejpdOWNaYCW63hzZWfquRAO
         EqK8TJ0Lgv5L+0SEcpJF2Q5S+yHw2Al4hKSTY=
Received: by 10.223.15.21 with SMTP id i21mr6151824faa.58.1270492924583;
        Mon, 05 Apr 2010 11:42:04 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id 28sm13326093fkx.36.2010.04.05.11.42.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:42:04 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:42:02 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144006>

mailinfo may use repo config, so setup gitdir first.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c |    3 ---
 git.c              |    2 +-
 2 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index ce2ef6b..3d2c650 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -1026,9 +1026,6 @@ int cmd_mailinfo(int argc, const char **argv, con=
st char *prefix)
 {
 	const char *def_charset;
=20
-	/* NEEDSWORK: might want to do the optional .git/ directory
-	 * discovery
-	 */
 	git_config(git_mailinfo_config, NULL);
=20
 	def_charset =3D (git_commit_encoding ? git_commit_encoding : "UTF-8")=
;
diff --git a/git.c b/git.c
index 2b59f06..326f7c7 100644
--- a/git.c
+++ b/git.c
@@ -339,7 +339,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "ls-files", cmd_ls_files, RUN_SETUP },
 		{ "ls-tree", cmd_ls_tree, RUN_SETUP },
 		{ "ls-remote", cmd_ls_remote },
-		{ "mailinfo", cmd_mailinfo },
+		{ "mailinfo", cmd_mailinfo, RUN_SETUP_GENTLY },
 		{ "mailsplit", cmd_mailsplit },
 		{ "merge", cmd_merge, RUN_SETUP | NEED_WORK_TREE },
 		{ "merge-base", cmd_merge_base, RUN_SETUP },
--=20
1.7.0.rc1.541.g2da82.dirty
