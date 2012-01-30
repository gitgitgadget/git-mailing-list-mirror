From: Frederik Schwarzer <schwarzerf@gmail.com>
Subject: i18n: Avoid sentence puzzles
Date: Mon, 30 Jan 2012 12:31:20 +0100
Message-ID: <201201301231.21090.schwarzerf@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_I+nJPi+asyYoMt4"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 12:31:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrpSa-0001wH-Bn
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 12:31:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752448Ab2A3Lb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 06:31:29 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47369 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275Ab2A3Lb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 06:31:27 -0500
Received: by bkas6 with SMTP id s6so3065670bka.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 03:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :message-id;
        bh=0XpXF+Lv4X4Lr34wvh6GfXQ6h3/e+/lmJIQeqB/1vnM=;
        b=ohiYlq1QdaNrTmTNRUBX1kN5P/hl4yJQ0Pa6kRYnf/cq4obUj2Nl2hQAYILSGS0x9e
         H1xTU7llbr5ZuPmjR9Bdb1Bfe7rcKbvf6otNLm3qfHd4nPeldeXP7y/CV3FN7yBz+UF3
         d+vL8rzN0OSL+CBpfIN5MF6zjC9ju3lo73IYM=
Received: by 10.205.129.141 with SMTP id hi13mr8124461bkc.7.1327923086586;
        Mon, 30 Jan 2012 03:31:26 -0800 (PST)
Received: from tamaki.localnet (77-23-27-98-dynip.superkabel.de. [77.23.27.98])
        by mx.google.com with ESMTPS id fg16sm36881628bkb.16.2012.01.30.03.31.24
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jan 2012 03:31:25 -0800 (PST)
User-Agent: KMail/1.13.7 (Linux/3.2.1-fs; KDE/4.7.4; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189346>

--Boundary-00=_I+nJPi+asyYoMt4
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

in order to enable translators to prepare proper translations, 
sentence puzzles have to be avoided. While it makes perfect sense for 
English, some languages may have to separate those words to sound or 
even be correct.

The attached patch demonstrates a change to achive that. I did not 
test it because its purpose is only to raise awareness and start a 
discussion about this topic. After all the question is, how important 
translations are for a tool like Git. I have started a German 
translation but many things are really hard to translate.
1) Many words are used in a germanised way, so translating them
   not only feels awkward in some cases but it also might confuse
   users who are used to the original wording.
2) English is a language that can be used in a very compact way.
   In German that can feel dumb or even rude. So texts can grow
   up to twice or thrice their size. That can clutter the terminal
   appearance quite a bit.

Given those problems many people avoid using command line tools in 
their language and I see the usefulness of translations rather 
limited.

So my question would be: Is it considered worth it to extend the code 
for translators' and translations' sake? If so, I would be glad to 
help with that.

Regards

--Boundary-00=_I+nJPi+asyYoMt4
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-Avoid-puzzle-sentences.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Avoid-puzzle-sentences.patch"

=46rom 7b1475cbffe120fdae1b46a2974a7b94846702c4 Mon Sep 17 00:00:00 2001
=46rom: Frederik Schwarzer <schwarzerf@gmail.com>
Date: Mon, 30 Jan 2012 12:02:46 +0100
Subject: [PATCH] Avoid puzzle sentences.

=2D--
 builtin/branch.c |   27 ++++++++++++++++++---------
 1 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 7095718..a07ac54 100644
=2D-- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -154,18 +154,17 @@ static int delete_branches(int argc, const char **arg=
v, int force, int kinds)
 	const char *fmt, *remote;
 	int i;
 	int ret =3D 0;
+	int is_remote =3D 0;
 	struct strbuf bname =3D STRBUF_INIT;
=20
 	switch (kinds) {
 	case REF_REMOTE_BRANCH:
 		fmt =3D "refs/remotes/%s";
=2D		/* TRANSLATORS: This is "remote " in "remote branch '%s' not found" */
=2D		remote =3D _("remote ");
+		is_remote =3D 1;
 		force =3D 1;
 		break;
 	case REF_LOCAL_BRANCH:
 		fmt =3D "refs/heads/%s";
=2D		remote =3D "";
 		break;
 	default:
 		die(_("cannot use -a with -d"));
@@ -189,8 +188,11 @@ static int delete_branches(int argc, const char **argv=
, int force, int kinds)
=20
 		name =3D xstrdup(mkpath(fmt, bname.buf));
 		if (read_ref(name, sha1)) {
=2D			error(_("%sbranch '%s' not found."),
=2D					remote, bname.buf);
+			if (is_remote) {
+				error(_("remote branch '%s' not found."), bname.buf);
+			} else {
+				error(_("branch '%s' not found."), bname.buf);
+			}
 			ret =3D 1;
 			continue;
 		}
@@ -211,14 +213,21 @@ static int delete_branches(int argc, const char **arg=
v, int force, int kinds)
 		}
=20
 		if (delete_ref(name, sha1, 0)) {
=2D			error(_("Error deleting %sbranch '%s'"), remote,
=2D			      bname.buf);
+			if (is_remote) {
+				error(_("Error deleting remote branch '%s'"), bname.buf);
+			} else {
+				error(_("Error deleting branch '%s'"), bname.buf);
+			}
 			ret =3D 1;
 		} else {
 			struct strbuf buf =3D STRBUF_INIT;
=2D			printf(_("Deleted %sbranch %s (was %s).\n"), remote,
=2D			       bname.buf,
+			if (is_remote) {
+				printf(_("Deleted remote branch %s (was %s).\n"), bname.buf,
 			       find_unique_abbrev(sha1, DEFAULT_ABBREV));
+			} else {
+				printf(_("Deleted branch %s (was %s).\n"), bname.buf,
+			       find_unique_abbrev(sha1, DEFAULT_ABBREV));
+			}
 			strbuf_addf(&buf, "branch.%s", bname.buf);
 			if (git_config_rename_section(buf.buf, NULL) < 0)
 				warning(_("Update of config-file failed"));
=2D-=20
1.7.8.3


--Boundary-00=_I+nJPi+asyYoMt4--
