From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 3/5] git-branch: remove lego in i18n messages
Date: Mon, 30 Apr 2012 15:33:12 +0000
Message-ID: <1335799995-7667-4-git-send-email-avarab@gmail.com>
References: <1335799995-7667-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 30 17:33:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOsbf-0001J5-L7
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 17:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754894Ab2D3Pdf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 11:33:35 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39599 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753940Ab2D3Pdd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 11:33:33 -0400
Received: by bkcji2 with SMTP id ji2so383655bkc.19
        for <git@vger.kernel.org>; Mon, 30 Apr 2012 08:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=WHmXqz6e3i64S588EtZIyXPFf1tv1m27+YfvuaY1DaE=;
        b=qUf7mbvaik+HZb0ZGcN5Eja3tvXkSFuTAUzZWRZxg7dAxt+mMjZASAQtsGn1laVccT
         2W8e+6iMmP6ZJmjp10Jfi7wQF2k+xrTd+9T6xR4TbhrdxnWdWdfRsPAD+xuURzXm47ST
         QCfhs9vm/9o/lokRBTezOFlClHwse5ja17kzYso7nnb9GdOej14SdkFvtT77QsOEdTbu
         FgA8xTuoFVAIlz51Fr4m9qGCKv8SXsFBZgoWfMUP3CshXLP+zbwEJSaAVCAFNS1p28Oc
         DiDACNgUBR55Hjt/arTaMpL/6VyJgTDqL88FcOUdGMrkESx4hCDTPsVnaH8m6dXG08sI
         5lrg==
Received: by 10.204.153.21 with SMTP id i21mr1740322bkw.38.1335800012080;
        Mon, 30 Apr 2012 08:33:32 -0700 (PDT)
Received: from w.nix.is (w.nix.is. [188.40.98.140])
        by mx.google.com with ESMTPS id jr13sm27636569bkb.14.2012.04.30.08.33.31
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Apr 2012 08:33:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.546.gbaa1a.dirty
In-Reply-To: <1335799995-7667-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196568>

Instead of making translators translate "remote " and then using
"%sbranch" where "%s" is either "remote " or "" just split the two up
into separate messages. This makes the translation of this section of
git-branch much less confusing.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/branch.c |   24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 5f150b4..8813d2e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -152,21 +152,22 @@ static int delete_branches(int argc, const char *=
*argv, int force, int kinds,
 	struct commit *rev, *head_rev =3D NULL;
 	unsigned char sha1[20];
 	char *name =3D NULL;
-	const char *fmt, *remote;
+	const char *fmt;
 	int i;
 	int ret =3D 0;
+	int remote_branch =3D 0;
 	struct strbuf bname =3D STRBUF_INIT;
=20
 	switch (kinds) {
 	case REF_REMOTE_BRANCH:
 		fmt =3D "refs/remotes/%s";
-		/* TRANSLATORS: This is "remote " in "remote branch '%s' not found" =
*/
-		remote =3D _("remote ");
+		/* For subsequent UI messages */
+		remote_branch =3D 1;
+
 		force =3D 1;
 		break;
 	case REF_LOCAL_BRANCH:
 		fmt =3D "refs/heads/%s";
-		remote =3D "";
 		break;
 	default:
 		die(_("cannot use -a with -d"));
@@ -190,8 +191,9 @@ static int delete_branches(int argc, const char **a=
rgv, int force, int kinds,
=20
 		name =3D xstrdup(mkpath(fmt, bname.buf));
 		if (read_ref(name, sha1)) {
-			error(_("%sbranch '%s' not found."),
-					remote, bname.buf);
+			error(remote_branch
+			      ? _("remote branch '%s' not found.")
+			      : _("branch '%s' not found."), bname.buf);
 			ret =3D 1;
 			continue;
 		}
@@ -212,14 +214,18 @@ static int delete_branches(int argc, const char *=
*argv, int force, int kinds,
 		}
=20
 		if (delete_ref(name, sha1, 0)) {
-			error(_("Error deleting %sbranch '%s'"), remote,
+			error(remote_branch
+			      ? _("Error deleting remote branch '%s'")
+			      : _("Error deleting branch '%s'"),
 			      bname.buf);
 			ret =3D 1;
 		} else {
 			struct strbuf buf =3D STRBUF_INIT;
 			if (!quiet)
-				printf(_("Deleted %sbranch %s (was %s).\n"),
-				       remote, bname.buf,
+				printf(remote_branch
+				       ? _("Deleted remote branch %s (was %s).\n")
+				       : _("Deleted branch %s (was %s).\n"),
+				       bname.buf,
 				       find_unique_abbrev(sha1, DEFAULT_ABBREV));
 			strbuf_addf(&buf, "branch.%s", bname.buf);
 			if (git_config_rename_section(buf.buf, NULL) < 0)
--=20
1.7.10.546.gbaa1a.dirty
