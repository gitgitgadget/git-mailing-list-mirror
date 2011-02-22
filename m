From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 11/73] gettextize: git-add "The following paths are ignored" message
Date: Tue, 22 Feb 2011 23:41:30 +0000
Message-ID: <1298418152-27789-12-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:47:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1xW-0001bt-Du
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755820Ab1BVXre convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:47:34 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39209 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754679Ab1BVXnm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:43:42 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866615bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=JxdHdtcmULUeDeogMg3xPIjqoRAP/rqjXxDAD9N9XzM=;
        b=Jnmv4Ic7DDNrE3g5ZVD9x2wZRZGkaDhl6o0kTHdHAD+oG62sue8hlFtgfZNKjcFGGI
         BBas+SsZKUpnya3vALOgy8aqEj1k/gO6vNtKeE3XoDssIs/HH7ORzPJ0qMDQPlwnQlqm
         9cNrZje0cjaNnn/HPVrj1KYAiUWJTAArR8FPY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=tn7gA3OvHtqfZSajwHgPJ/hNhsFM13yup87eSV4/VcbP3M76i3tEKBcnUmOPxqo2no
         b0RzHL2X33hlaz547fXom5XfUKSW/R6tEy4TjZEINrW6Ph5i6OYgvHFNIxhwkXKmLhDd
         ap91OQFxort5Rlg47vc3cQVQSSa/q2PxRIQyQ=
Received: by 10.204.58.135 with SMTP id g7mr3065924bkh.187.1298418221319;
        Tue, 22 Feb 2011 15:43:41 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.43.40
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:43:40 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167658>

The tests t2204 (.gitignore) and t3700 (add) explicitly check for
these messages, so while at it, split each relevant test into a part
that just checks "git add"'s exit status and a part that checks
porcelain output.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/add.c          |    8 ++++----
 t/t2204-add-ignored.sh |   37 +++++++++++++++++++++++++------------
 t/t3700-add.sh         |    5 ++++-
 3 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index a9a78f4..21776ac 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -307,7 +307,7 @@ static int edit_patch(int argc, const char **argv, =
const char *prefix)
 static struct lock_file lock_file;
=20
 static const char ignore_error[] =3D
-"The following paths are ignored by one of your .gitignore files:\n";
+N_("The following paths are ignored by one of your .gitignore files:\n=
");
=20
 static int verbose =3D 0, show_only =3D 0, ignored_too =3D 0, refresh_=
only =3D 0;
 static int ignore_add_errors, addremove, intent_to_add, ignore_missing=
 =3D 0;
@@ -344,11 +344,11 @@ static int add_files(struct dir_struct *dir, int =
flags)
 	int i, exit_status =3D 0;
=20
 	if (dir->ignored_nr) {
-		fprintf(stderr, ignore_error);
+		fprintf(stderr, _(ignore_error));
 		for (i =3D 0; i < dir->ignored_nr; i++)
 			fprintf(stderr, "%s\n", dir->ignored[i]->name);
-		fprintf(stderr, "Use -f if you really want to add them.\n");
-		die("no files added");
+		fprintf(stderr, _("Use -f if you really want to add them.\n"));
+		die(_("no files added"));
 	}
=20
 	for (i =3D 0; i < dir->nr; i++)
diff --git a/t/t2204-add-ignored.sh b/t/t2204-add-ignored.sh
index 24afdab..4975336 100755
--- a/t/t2204-add-ignored.sh
+++ b/t/t2204-add-ignored.sh
@@ -31,18 +31,21 @@ do
 		rm -f .git/index &&
 		test_must_fail git add "$i" 2>err &&
 		git ls-files "$i" >out &&
-		! test -s out &&
-		grep -e "Use -f if" err &&
-		cat err
+		! test -s out
+	'
+
+	test_expect_success C_LOCALE_OUTPUT "complaints for ignored $i output=
" '
+		grep -e "Use -f if" err
 	'
=20
 	test_expect_success "complaints for ignored $i with unignored file" '
 		rm -f .git/index &&
 		test_must_fail git add "$i" file 2>err &&
 		git ls-files "$i" >out &&
-		! test -s out &&
-		grep -e "Use -f if" err &&
-		cat err
+		! test -s out
+	'
+	test_expect_success C_LOCALE_OUTPUT "complaints for ignored $i with u=
nignored file output" '
+		grep -e "Use -f if" err
 	'
 done
=20
@@ -54,9 +57,14 @@ do
 			cd dir &&
 			test_must_fail git add "$i" 2>err &&
 			git ls-files "$i" >out &&
-			! test -s out &&
-			grep -e "Use -f if" err &&
-			cat err
+			! test -s out
+		)
+	'
+
+	test_expect_success C_LOCALE_OUTPUT "complaints for ignored $i in dir=
 output" '
+		(
+			cd dir &&
+			grep -e "Use -f if" err
 		)
 	'
 done
@@ -69,9 +77,14 @@ do
 			cd sub &&
 			test_must_fail git add "$i" 2>err &&
 			git ls-files "$i" >out &&
-			! test -s out &&
-			grep -e "Use -f if" err &&
-			cat err
+			! test -s out
+		)
+	'
+
+	test_expect_success C_LOCALE_OUTPUT "complaints for ignored $i in sub=
 output" '
+		(
+			cd sub &&
+			grep -e "Use -f if" err
 		)
 	'
 done
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index ec71083..ac115ed 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -283,7 +283,10 @@ add 'track-this'
 EOF
=20
 test_expect_success 'git add --dry-run --ignore-missing of non-existin=
g file' '
-	test_must_fail git add --dry-run --ignore-missing track-this ignored-=
file >actual.out 2>actual.err &&
+	test_must_fail git add --dry-run --ignore-missing track-this ignored-=
file >actual.out 2>actual.err
+'
+
+test_expect_success C_LOCALE_OUTPUT 'git add --dry-run --ignore-missin=
g of non-existing file output' '
 	test_cmp expect.out actual.out &&
 	test_cmp expect.err actual.err
 '
--=20
1.7.2.3
