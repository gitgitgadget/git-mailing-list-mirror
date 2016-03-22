From: Elena Petrashen <elena.petrashen@gmail.com>
Subject: [PATCH v2] branch -D: allow - as abbreviation of '@{-1}'
Date: Tue, 22 Mar 2016 11:24:16 +0300
Message-ID: <1458635056-26633-1-git-send-email-elena.petrashen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Matthieu.Moy@grenoble-inp.fr, sbeller@google.com,
	Elena Petrashen <elena.petrashen@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 22 09:26:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiHdX-0004JS-4v
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 09:25:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758297AbcCVIZq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Mar 2016 04:25:46 -0400
Received: from mail-lb0-f196.google.com ([209.85.217.196]:34618 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943AbcCVIZj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 04:25:39 -0400
Received: by mail-lb0-f196.google.com with SMTP id vk4so13628136lbb.1
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 01:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+RZE896MVrNSZfmBy7AyQRDmHG0ttbLdDGN6yGudG+I=;
        b=PbL2OEn8QOYrjxbo3WQENGYuYUKGhfvyU7i9vTzDAvsILyWZmhMMh6jRfcoeVZeQVk
         i7tC7o7nmRsfFvOnpQzt/ZelbaoV/OQhX3GcyFl8dagP3drozG/ZD4qqmykoiB9zNbGT
         ByiA7WXkAy3XJTBFo9eaOA9O8uoHZiolTqfBFvEYOpSBKUAUCjGYX6M5MRu5fOwHWzZU
         uQJmQunDR65IeA74I8OZNsg4jyRf1I3rlPy9QAbcbGTFr1QsQavfigL2ISmA/ktMaYc2
         4ImRBU0NrfOgDuYN+oa4hxZiD8faPtxyFSG2Ux0F+hz3CMoRKA7h3L/u05bHxJH5tNmG
         lG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+RZE896MVrNSZfmBy7AyQRDmHG0ttbLdDGN6yGudG+I=;
        b=PBwQ2LIvWUo42eQvfAkqCC22fSRMYRT+Isp4Jl7OJyNYrnNipf2ESvelK/wy8WfKvC
         0j/weTSUG9gRBSQEd77kF/RupryLRMvJJOmPu91jjU6gfyO/PCNsRJKFQaU+3scYcs8J
         n8DYZ0PktjT+JLvE2q3gnE3ZgNpcZyS111sIDfaHQLq+rHA/eyDCqozcwJp7SX/eZMi1
         4bT/lIQ3cGm2SKjWLxYvre2hHgHUcIeU8SlVviCJu7m+ELBnJqcAIRGXger2wqQDvTaB
         cH299bIc5deTLbH84Nhj9o0+DGuV/nFBlW0ECYqZmtv1Q2gc613krjSPUJY1RUton15Q
         zFUg==
X-Gm-Message-State: AD7BkJKBd0dkTIY7SGsXLxm4uzOAwyXNfdvMp7eo+01U6RLTKLjqMMcIFUsXh69qrNWTpg==
X-Received: by 10.25.207.76 with SMTP id f73mr13317439lfg.11.1458635136771;
        Tue, 22 Mar 2016 01:25:36 -0700 (PDT)
Received: from localhost.localdomain ([37.153.43.108])
        by smtp.gmail.com with ESMTPSA id xg1sm5061039lbb.10.2016.03.22.01.25.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Mar 2016 01:25:35 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc3.12.g047057b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289494>

Signed-off-by: Elena Petrashen <elena.petrashen@gmail.com>
---
This micro-patch is meant to allow =E2=80=9C-=E2=80=9C as a short-hand =
for
=E2=80=9C@{-1} for branch -D (Cf. $gmane/230828):

* based on the discussion on the previous version of the patch,
added the advice on how to restore the deleted branch using
git branch deleted_name sha1 - to ensure safety and=20
newbie-friendliness

* git branch (-d | -D) is not supposed to accept any other
arguments except for branch name so it makes sense to replace
the argv[i] with @{-1}. We will not lose the opportunity to
use it for something different for other git branch uses if
we will decide it=E2=80=99s required.

* the small expand_dash_shortcut function can be reused to teach
git branch -m or other modifications to allow =E2=80=9C-=E2=80=9C as a =
short-hand
for =E2=80=9C@{-1}  as well and possibly makes it easy to understand wh=
at=E2=80=99s
going on in the code

* if there=E2=80=99s no previous branch in the repository yet, a
specific warning message is given

Thank you! Looking forward to any feedback.
 Documentation/git-branch.txt |  2 ++
 builtin/branch.c             | 26 ++++++++++++++++++++++----
 t/t3200-branch.sh            | 16 ++++++++++++++++
 3 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.tx=
t
index 4a7037f..42b96ed 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -65,6 +65,8 @@ to happen.
 With a `-d` or `-D` option, `<branchname>` will be deleted.  You may
 specify more than one branch for deletion.  If the branch currently
 has a reflog then the reflog will also be deleted.
+The "@{-N}" syntax for the N-th last branch deletes the specified bran=
ch.
+You may also specify - which is synonymous with "@{-1}".
=20
 Use `-r` together with `-d` to delete remote-tracking branches. Note, =
that it
 only makes sense to delete remote-tracking branches if they no longer =
exist
diff --git a/builtin/branch.c b/builtin/branch.c
index 7b45b6b..8b33533 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -178,6 +178,15 @@ static void delete_branch_config(const char *branc=
hname)
 	strbuf_release(&buf);
 }
=20
+static int expand_dash_shortcut(const char **argv, int dash_position)
+{
+	if (!strcmp(argv[dash_position], "-")){
+		argv[dash_position] =3D "@{-1}";
+		return 1;
+	}
+	return 0;
+}
+
 static int delete_branches(int argc, const char **argv, int force, int=
 kinds,
 			   int quiet)
 {
@@ -187,6 +196,7 @@ static int delete_branches(int argc, const char **a=
rgv, int force, int kinds,
 	const char *fmt;
 	int i;
 	int ret =3D 0;
+	int dash_shortcut =3D 0;
 	int remote_branch =3D 0;
 	struct strbuf bname =3D STRBUF_INIT;
=20
@@ -213,7 +223,8 @@ static int delete_branches(int argc, const char **a=
rgv, int force, int kinds,
 	for (i =3D 0; i < argc; i++, strbuf_release(&bname)) {
 		const char *target;
 		int flags =3D 0;
-
+		if (expand_dash_shortcut (argv, i))
+			dash_shortcut =3D 1;
 		strbuf_branchname(&bname, argv[i]);
 		if (kinds =3D=3D FILTER_REFS_BRANCHES && !strcmp(head, bname.buf)) {
 			error(_("Cannot delete the branch '%s' "
@@ -231,9 +242,12 @@ static int delete_branches(int argc, const char **=
argv, int force, int kinds,
 					    | RESOLVE_REF_ALLOW_BAD_NAME,
 					    sha1, &flags);
 		if (!target) {
-			error(remote_branch
-			      ? _("remote-tracking branch '%s' not found.")
-			      : _("branch '%s' not found."), bname.buf);
+			error(dash_shortcut
+				? _("There is no previous branch that could be"
+					" referred to at the moment.")
+				: remote_branch
+					? _("remote-tracking branch '%s' not found.")
+					: _("branch '%s' not found."), bname.buf);
 			ret =3D 1;
 			continue;
 		}
@@ -262,6 +276,10 @@ static int delete_branches(int argc, const char **=
argv, int force, int kinds,
 			       (flags & REF_ISBROKEN) ? "broken"
 			       : (flags & REF_ISSYMREF) ? target
 			       : find_unique_abbrev(sha1, DEFAULT_ABBREV));
+			if (dash_shortcut =3D=3D 1)
+			       printf( _("\nIf that happened by mistake, you may want to re=
store"
+				" it with:\n\ngit branch %s %s\n"), bname.buf,
+				find_unique_abbrev(sha1, DEFAULT_ABBREV));
 		}
 		delete_branch_config(bname.buf);
 	}
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index a897248..535a507 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -403,6 +403,22 @@ test_expect_success 'test deleting branch without =
config' '
 	test_i18ncmp expect actual
 '
=20
+test_expect_success 'test deleting "-" deletes previous branch' '
+	git checkout -b prev &&
+	test_commit prev &&
+	git checkout master &&
+	git branch -D - >actual &&
+	sha1=3D$(git rev-parse --short prev) &&
+	cat >expected <<EOF &&
+Deleted branch prev (was $sha1).
+
+If that happened by mistake, you may want to restore it with:
+
+git branch prev $sha1
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'test --track without .fetch entries' '
 	git branch --track my8 &&
 	test "$(git config branch.my8.remote)" &&
--=20
2.8.0.rc3.12.g047057b.dirty
