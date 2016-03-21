From: Elena Petrashen <elena.petrashen@gmail.com>
Subject: [PATCH][Outreachy] branch -D: allow - as abbreviation of @{-1}
Date: Mon, 21 Mar 2016 18:15:17 +0300
Message-ID: <1458573317-15532-1-git-send-email-elena.petrashen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Elena Petrashen <elena.petrashen@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 16:15:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai1YH-000836-To
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 16:15:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756021AbcCUPP0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Mar 2016 11:15:26 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:32819 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755934AbcCUPPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 11:15:25 -0400
Received: by mail-lb0-f177.google.com with SMTP id oe12so128540410lbc.0
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 08:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3DtVu1kA9WoGYfFj/8v7lI2Lmlt/quNF44SxBn50BkI=;
        b=ILLQiq1eSZxh2iCFQlISdyQ9z3ymxOqLgOtV79hUGCcjQLB6Oe16HRG4Lx8jjTZxo6
         rAhqBO4UXkf5uSp3+7Yp3E1bQtOhYG4Y2aLTjWjN+iHvfWeewfkznmu74HdipYd0z7d+
         qpHC7YAN+om0HEOutpyVXeFrNNH48gxhurTMhZAgwk1gF9fogM9Om2bKAG+2XPI6MEem
         z4VJAyR8CHbPuXjGbuT0J81hOqu+MgVUTdU8GwbkMTaqV2DOBpYnU+YSxASE0AwTgs6x
         iik+Tn9xmFFCGcC2xY5Lz1vRLGYFL9qQF591I6buUrnMMWQxbjP7wl2VdX3m4+C1uYdo
         s+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3DtVu1kA9WoGYfFj/8v7lI2Lmlt/quNF44SxBn50BkI=;
        b=WUHXqEKLOoW/6cdZnBAydaaumYMcR3iRLVtQnTpjzeQzxHVMzWrvc0IMsJLIxchVO0
         hAOOO2OP/AlLHlaAYu/9cjrw8RZQzxvt0li7jZoM11oP4WKT7YmTiEC458aWNKUFw9hV
         P10OquTFYfp01jPKyKPJxrBjfhsWpraI3dZNz7clFFEI2ijYmEL4tnT3quiM84LBBIeC
         bD0wj65svPWFDTNgmfxoN3og0sg+Xq4b/JFmjz5VramF3ZRbGXM7Wh2wrgOAwP/GO5FX
         fF7zW+uen1AEDSUoNnXq4q9iNDnUyd4LhRTO6BL12JCXrrfi054rULG92FTrGJwRxkAO
         fsDg==
X-Gm-Message-State: AD7BkJLPZbOphQmxjnUP3GOzyNJ2NaUaQcTOE3xiUmHvX0xrLy1WhpbiCcdYwKv5CrmpjA==
X-Received: by 10.112.27.202 with SMTP id v10mr10936475lbg.34.1458573323729;
        Mon, 21 Mar 2016 08:15:23 -0700 (PDT)
Received: from localhost.localdomain ([37.153.43.108])
        by smtp.gmail.com with ESMTPSA id w6sm4479431lbo.31.2016.03.21.08.15.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Mar 2016 08:15:23 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc3.12.g047057b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289420>

Signed-off-by: Elena Petrashen <elena.petrashen@gmail.com>

---
This micro-patch is meant to allow =E2=80=9C-=E2=80=9C as a short-hand =
for
=E2=80=9C@{-1} for branch -D (Cf. $gmane/230828):

* git branch (-d | -D) is not supposed to accept any other
arguments except for branch name so it makes sense to replace
the argv[i] with @{-1}. We will not lose the opportunity to
use it for something different for other git branch uses if
we will decide it=E2=80=99s required.

* the small allow_dash_as_prev_branch_alias function can be
reused to teach git branch -m to allow =E2=80=9C-=E2=80=9C as a short-h=
and for
=E2=80=9C@{-1}  as well and possibly makes it easy to understand what=E2=
=80=99s
going on in the code

* if there=E2=80=99s no previous branch in the repository yet, a
specific warning message is given

Thank you! Looking forward to any feedback.

 Documentation/git-branch.txt |  5 ++++-
 builtin/branch.c             | 18 +++++++++++++++---
 t/t3200-branch.sh            | 10 ++++++++++
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.tx=
t
index 4a7037f..9f43665 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -64,7 +64,10 @@ to happen.
=20
 With a `-d` or `-D` option, `<branchname>` will be deleted.  You may
 specify more than one branch for deletion.  If the branch currently
-has a reflog then the reflog will also be deleted.
+has a reflog then the reflog will also be deleted.=20
+As a special case, the "@{-N}" syntax for the N-th last branch
+deletes the specified branch.  You may also specify - which is synonym=
ous
+with "@{-1}".
=20
 Use `-r` together with `-d` to delete remote-tracking branches. Note, =
that it
 only makes sense to delete remote-tracking branches if they no longer =
exist
diff --git a/builtin/branch.c b/builtin/branch.c
index 7b45b6b..9614d18 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -169,6 +169,8 @@ static int check_branch_commit(const char *branchna=
me, const char *refname,
 	return 0;
 }
=20
+
+
 static void delete_branch_config(const char *branchname)
 {
 	struct strbuf buf =3D STRBUF_INIT;
@@ -178,6 +180,12 @@ static void delete_branch_config(const char *branc=
hname)
 	strbuf_release(&buf);
 }
=20
+static void allow_dash_as_prev_branch_alias(const char **argv, int das=
h_position)
+{
+	if (!strcmp(argv[dash_position], "-"))
+		argv[dash_position] =3D "@{-1}";
+}
+
 static int delete_branches(int argc, const char **argv, int force, int=
 kinds,
 			   int quiet)
 {
@@ -210,10 +218,12 @@ static int delete_branches(int argc, const char *=
*argv, int force, int kinds,
 		if (!head_rev)
 			die(_("Couldn't look up commit object for HEAD"));
 	}
+
 	for (i =3D 0; i < argc; i++, strbuf_release(&bname)) {
 		const char *target;
 		int flags =3D 0;
=20
+		allow_dash_as_prev_branch_alias(argv, i);
 		strbuf_branchname(&bname, argv[i]);
 		if (kinds =3D=3D FILTER_REFS_BRANCHES && !strcmp(head, bname.buf)) {
 			error(_("Cannot delete the branch '%s' "
@@ -231,9 +241,11 @@ static int delete_branches(int argc, const char **=
argv, int force, int kinds,
 					    | RESOLVE_REF_ALLOW_BAD_NAME,
 					    sha1, &flags);
 		if (!target) {
-			error(remote_branch
-			      ? _("remote-tracking branch '%s' not found.")
-			      : _("branch '%s' not found."), bname.buf);
+			error(!strcmp(bname.buf, "@{-1}")
+				? _("There is no previous branch that could be referred to at the =
moment.")
+				: remote_branch
+					? _("remote-tracking branch '%s' not found.")
+					: _("branch '%s' not found."), bname.buf);
 			ret =3D 1;
 			continue;
 		}
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index a897248..d21369f 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -403,6 +403,16 @@ test_expect_success 'test deleting branch without =
config' '
 	test_i18ncmp expect actual
 '
=20
+test_expect_success 'test deleting "-" deletes previous branch' '
+	git checkout -b prev &&
+	test_commit prev &&
+	git checkout master &&
+	git branch -D - >actual &&
+	sha1=3D$(git rev-parse prev | cut -c 1-7) &&
+	echo "Deleted branch prev (was $sha1)." >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'test --track without .fetch entries' '
 	git branch --track my8 &&
 	test "$(git config branch.my8.remote)" &&
--=20
2.8.0.rc3.12.g047057b.dirty
