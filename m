From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH] builtin-commit: Clean up an unused variable and a debug fprintf().
Date: Wed, 14 Nov 2007 10:31:53 -0500
Message-ID: <1195054313-17607-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 14 16:32:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsKEL-0001IT-7u
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 16:32:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755987AbXKNPcY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Nov 2007 10:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755613AbXKNPcY
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 10:32:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40110 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753167AbXKNPcX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 10:32:23 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lAEFVxNI010616;
	Wed, 14 Nov 2007 10:31:59 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lAEFVwgU004970;
	Wed, 14 Nov 2007 10:31:58 -0500
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id lAEFVwQJ017482;
	Wed, 14 Nov 2007 10:31:58 -0500
X-Mailer: git-send-email 1.5.3.5.1822.g11971-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64989>

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 builtin-commit.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 7a8cb57..7841310 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -514,7 +514,7 @@ static const char commit_utf8_warn[] =3D
=20
 int cmd_commit(int argc, const char **argv, const char *prefix)
 {
-	int header_len, parent_count =3D 0;
+	int header_len;
 	struct strbuf sb;
 	const char *index_file, *reflog_msg;
 	char *nl;
@@ -550,7 +550,6 @@ int cmd_commit(int argc, const char **argv, const c=
har *prefix)
 	/* Determine parents */
 	if (initial_commit) {
 		reflog_msg =3D "commit (initial)";
-		parent_count =3D 0;
 	} else if (amend) {
 		struct commit_list *c;
 		struct commit *commit;
@@ -591,10 +590,9 @@ int cmd_commit(int argc, const char **argv, const =
char *prefix)
=20
 	/* Get the commit message and validate it */
 	header_len =3D sb.len;
-	if (!no_edit) {
-		fprintf(stderr, "launching editor, log %s\n", logfile);
+	if (!no_edit)
 		launch_editor(git_path(commit_editmsg), &sb);
-	} else if (strbuf_read_file(&sb, git_path(commit_editmsg), 0) < 0)
+	else if (strbuf_read_file(&sb, git_path(commit_editmsg), 0) < 0)
 		die("could not read commit message\n");
 	if (run_hook(index_file, "commit-msg", commit_editmsg))
 		exit(1);
--=20
1.5.3.5.1822.g11971-dirty
