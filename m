From: Javier.Roucher-Iglesias@ensimag.imag.fr
Subject: =?UTF-8?q?=5BPATCH=20v3=5D=20add=20=27git=20credential=27=20plumbing=20command?=
Date: Mon, 11 Jun 2012 20:44:54 +0200
Message-ID: <1339440294-8010-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Javier Roucher <jroucher@gmail.com>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 11 20:45:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se9bz-0007ox-Ux
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 20:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299Ab2FKSpG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 14:45:06 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:34874 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321Ab2FKSpF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 14:45:05 -0400
Received: by weyu7 with SMTP id u7so2294899wey.19
        for <git@vger.kernel.org>; Mon, 11 Jun 2012 11:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=Ig/3viOEpKJRO4CSR204fAkvqrWlZx8BwWBpXxGq5Fk=;
        b=H/v4CelSxUtNHrdPTwK6ld96BbJxziobLqD1iHT9hWscQvw8J9CeUugWONVQelh5sO
         54LGkojJM+lMSuprBCKp0IFhhYqOQIUAxT2n2EJvpii83Xuh7DYCvMbTp39Y9PurWf80
         HIB0/8tVxvgmjSmarSsBhRt3aLBhDeBChh2eSToFw2O91OGpdUIq+zDg6vw2217fjV4P
         5Z1RcHR5vSxsyN76yrgl7omWtqSuDeHhIh2j04uoHpE09M2vYlhQRkqJMbZnPEvCV0qJ
         NpaAzG1aCMlk4KqkuH6+uj1kpp8VNcSMvlFhDH15H3grlas6xz9ZKT/TcfjuCZuLU6vp
         CqNw==
Received: by 10.180.24.39 with SMTP id r7mr23048743wif.9.1339440302918;
        Mon, 11 Jun 2012 11:45:02 -0700 (PDT)
Received: from SuperNova.grenet.fr (etu-190-203.vpn-inp.grenoble-inp.fr. [147.171.190.203])
        by mx.google.com with ESMTPS id f19sm287776wiw.11.2012.06.11.11.45.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jun 2012 11:45:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.rc2.4.gfbe8a84.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199694>

=46rom: Javier Roucher <jroucher@gmail.com>

The credential API is in C, and not available to scripting languages.
Expose the functionalities of the API by wrapping them into a new
plumbing command "git credentials".

Changes in the version2 vs version1:
=C2=B7 Doc have been changed.
=C2=B7 Correction of git.c:
	{ "credential", cmd_credential, RUN_SETUP_GENTLY },
=C2=B7 Delete a few lines of code in builtin/credential.c
	for (i =3D 2; i < argc; i++)
		string_list_append(&c.helpers, argv[i]);
=C2=B7 Correction of the name of the PATCH v2 vs PATCH_v1
=C2=B7 Code style correction

If i miss some correction, please remember me. Thanks.

Adding to the next patch, version3:
=C2=B7 Tests files

Signed-off-by: Pavel Volek <Pavel.Volek@ensimag.imag.fr>
Signed-off-by: NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>
Signed-off-by: ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>

---
 .gitignore                       |  1 +
 Documentation/git-credential.txt | 74 ++++++++++++++++++++++++++++++++=
++++++++
 Makefile                         |  1 +
 builtin.h                        |  1 +
 builtin/credential.c             | 37 ++++++++++++++++++++
 git.c                            |  1 +
 6 files changed, 115 insertions(+)
 create mode 100644 Documentation/git-credential.txt
 create mode 100644 builtin/credential.c

diff --git a/.gitignore b/.gitignore
index bf66648..7d1d86e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -31,6 +31,7 @@
 /git-commit-tree
 /git-config
 /git-count-objects
+/git-credential
 /git-credential-cache
 /git-credential-cache--daemon
 /git-credential-store
diff --git a/Documentation/git-credential.txt b/Documentation/git-crede=
ntial.txt
new file mode 100644
index 0000000..ad4e6c7
--- /dev/null
+++ b/Documentation/git-credential.txt
@@ -0,0 +1,74 @@
+git-credential(7)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+NAME
+----
+git-credential - Provides and store user credentials to git
+
+SYNOPSIS
+--------
+------------------
+git credential <fill|approve|reject>
+
+------------------
+
+DESCRIPTION
+-----------
+
+Git-credential permits to the user of the script to save:
+username, password, host, path and protocol. When the user of script
+invoke git-credential, the script can ask for a password, using the co=
mmand
+'git credential fill'.
+Taking data from the standard input, the program treats each line as a
+separate data item, and the end of series of data item is signalled by=
 a=20
+blank line.
+
+		username=3Dadmin\n=20
+		protocol=3D[http|https]\n
+		host=3Dlocalhost\n
+		path=3D/dir\n\n
+
+-If git-credential system has the password already stored
+git-credential will answer with by STDOUT:
+=09
+		username=3Dadmin
+		password=3D*****
+
+-If it is not stored, the user will be prompt for a password:
+	=09
+		> Password for '[http|https]admin@localhost':
+
+
+Then if the password is correct, (note: it's not git credential that
+decides if the password is correct or not. That part is done by the=20
+external system) it can be stored using command 'git crendential appro=
ve'=20
+by providing the structure, by STDIN.
+
+		username=3Dadmin
+		password=3D*****
+		protocol=3D[http|https]
+		host=3Dlocalhost
+		path=3D/dir
+
+If the password is refused, it can be deleted using command
+'git credential reject' by providing the same structure.
+
+
+REQUESTING CREDENTIALS
+----------------------
+
+1. The 'git credential fill' makes the structure,
+with this structure it will be able to save your
+credentials, and if the credential is already stored,
+it will fill the password.
+
+		username=3Dfoo
+		password=3D****
+		protocol=3D[http|https]
+		localhost=3Durl
+		path=3D/direction
+
+2. Then 'git credential approve' to store them.
+
+3. Otherwise, if the credential is not correct you can do
+  'git credential reject' to delete the credential.
diff --git a/Makefile b/Makefile
index 4592f1f..3f53da8 100644
--- a/Makefile
+++ b/Makefile
@@ -827,6 +827,7 @@ BUILTIN_OBJS +=3D builtin/commit-tree.o
 BUILTIN_OBJS +=3D builtin/commit.o
 BUILTIN_OBJS +=3D builtin/config.o
 BUILTIN_OBJS +=3D builtin/count-objects.o
+BUILTIN_OBJS +=3D builtin/credential.o
 BUILTIN_OBJS +=3D builtin/describe.o
 BUILTIN_OBJS +=3D builtin/diff-files.o
 BUILTIN_OBJS +=3D builtin/diff-index.o
diff --git a/builtin.h b/builtin.h
index 338f540..48feddc 100644
--- a/builtin.h
+++ b/builtin.h
@@ -66,6 +66,7 @@ extern int cmd_commit(int argc, const char **argv, co=
nst char *prefix);
 extern int cmd_commit_tree(int argc, const char **argv, const char *pr=
efix);
 extern int cmd_config(int argc, const char **argv, const char *prefix)=
;
 extern int cmd_count_objects(int argc, const char **argv, const char *=
prefix);
+extern int cmd_credential(int argc, const char **argv, const char *pre=
fix);
 extern int cmd_describe(int argc, const char **argv, const char *prefi=
x);
 extern int cmd_diff_files(int argc, const char **argv, const char *pre=
fix);
 extern int cmd_diff_index(int argc, const char **argv, const char *pre=
fix);
diff --git a/builtin/credential.c b/builtin/credential.c
new file mode 100644
index 0000000..a6b6962
--- /dev/null
+++ b/builtin/credential.c
@@ -0,0 +1,37 @@
+#include <stdio.h>
+#include "cache.h"
+#include "credential.h"
+#include "string-list.h"
+
+static const char usage_msg[] =3D
+"credential <fill|approve|reject>";
+
+void cmd_credential (int argc, char **argv, const char *prefix) {
+	const char *op;
+	struct credential c =3D CREDENTIAL_INIT;
+	int i;
+
+	op =3D argv[1];
+	if (!op)
+		usage(usage_msg);
+
+	if (credential_read(&c, stdin) < 0)
+		die("unable to read credential from stdin");
+
+	if (!strcmp(op, "fill")) {
+		credential_fill(&c);
+		if (c.username)
+			printf("username=3D%s\n", c.username);
+		if (c.password)
+			printf("password=3D%s\n", c.password);
+	}
+	else if (!strcmp(op, "approve")) {
+		credential_approve(&c);
+	}
+	else if (!strcmp(op, "reject")) {
+		credential_reject(&c);
+	}
+	else {
+		usage(usage_msg);
+	}
+}
diff --git a/git.c b/git.c
index d232de9..660c926 100644
--- a/git.c
+++ b/git.c
@@ -353,6 +353,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
 		{ "config", cmd_config, RUN_SETUP_GENTLY },
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
+		{ "credential", cmd_credential, RUN_SETUP_GENTLY },
 		{ "describe", cmd_describe, RUN_SETUP },
 		{ "diff", cmd_diff },
 		{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE },
--=20
1.7.11.rc2.4.gfbe8a84.dirty
