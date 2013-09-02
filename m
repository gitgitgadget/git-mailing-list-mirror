From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v2 4/7] use 'committish' instead of 'commit-ish'
Date: Mon,  2 Sep 2013 01:34:23 -0400
Message-ID: <1378100066-31889-5-git-send-email-rhansen@bbn.com>
References: <1378100066-31889-1-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Sep 02 08:20:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGNVL-0007ht-3K
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 08:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757248Ab3IBGUr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Sep 2013 02:20:47 -0400
Received: from smtp.bbn.com ([128.33.0.80]:32830 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757181Ab3IBGUq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Sep 2013 02:20:46 -0400
Received: from socket.bbn.com ([192.1.120.102]:55319)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VGMmj-000NLV-06; Mon, 02 Sep 2013 01:34:45 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 3DB734015A
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1378100066-31889-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233605>

Replace all instances of 'commit-ish' with 'committish':
  * to standardize on a single spelling (the documentation contained a
    mix of 'committish' and 'commit-ish')
  * to be consistent with variable names (hyphens are not usually
    allowed in variable names)
  * to be consistent with 'treeish'
  * some search engines don't handle hyphens gracefully

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 Documentation/git-rebase.txt        |  2 +-
 Documentation/git-rev-parse.txt     |  2 +-
 Documentation/git.txt               |  4 ++--
 builtin/revert.c                    |  4 ++--
 contrib/examples/git-reset.sh       |  2 +-
 contrib/examples/git-revert.sh      |  4 ++--
 po/de.po                            |  4 ++--
 po/fr.po                            |  4 ++--
 po/git.pot                          |  4 ++--
 po/sv.po                            |  4 ++--
 po/vi.po                            |  8 ++++----
 po/zh_CN.po                         |  4 ++--
 remote.c                            |  2 +-
 t/t1512-rev-parse-disambiguation.sh | 16 ++++++++--------
 14 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
index 6b2e1c8..f8ac62d 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -174,7 +174,7 @@ would result in the removal of commits F and G:
=20
 This is useful if F and G were flawed in some way, or should not be
 part of topicA.  Note that the argument to --onto and the <upstream>
-parameter can be any valid commit-ish.
+parameter can be any valid committish.
=20
 In case of conflict, 'git rebase' will stop at the first problematic c=
ommit
 and leave conflict markers in the tree.  You can use 'git diff' to loc=
ate
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-pa=
rse.txt
index d068a65..56f643d 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -100,7 +100,7 @@ If you want to make sure that the output actually n=
ames an object in
 your object database and/or can be used as a specific type of object
 you require, you can add "^{type}" peeling operator to the parameter.
 For example, `git rev-parse "$VAR^{commit}"` will make sure `$VAR`
-names an existing object that is a commit-ish (i.e. a commit, or an
+names an existing object that is a committish (i.e. a commit, or an
 annotated tag that points at a commit).  To make sure that `$VAR`
 names an existing object of any type, `git rev-parse "$VAR^{object}"`
 can be used.
diff --git a/Documentation/git.txt b/Documentation/git.txt
index c07915b..9d9ae26 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -606,9 +606,9 @@ Identifier Terminology
 	operate on a <tree> object but automatically dereferences
 	<commit> and <tag> objects that point at a <tree>.
=20
-<commit-ish>::
+<committish>::
 	Indicates a commit or tag object name.  A
-	command that takes a <commit-ish> argument ultimately wants to
+	command that takes a <committish> argument ultimately wants to
 	operate on a <commit> object but automatically dereferences
 	<tag> objects that point at a <commit>.
=20
diff --git a/builtin/revert.c b/builtin/revert.c
index 1d2648b..9339816 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -19,13 +19,13 @@
  */
=20
 static const char * const revert_usage[] =3D {
-	N_("git revert [options] <commit-ish>..."),
+	N_("git revert [options] <committish>..."),
 	N_("git revert <subcommand>"),
 	NULL
 };
=20
 static const char * const cherry_pick_usage[] =3D {
-	N_("git cherry-pick [options] <commit-ish>..."),
+	N_("git cherry-pick [options] <committish>..."),
 	N_("git cherry-pick <subcommand>"),
 	NULL
 };
diff --git a/contrib/examples/git-reset.sh b/contrib/examples/git-reset=
=2Esh
index bafeb52..ac06274 100755
--- a/contrib/examples/git-reset.sh
+++ b/contrib/examples/git-reset.sh
@@ -2,7 +2,7 @@
 #
 # Copyright (c) 2005, 2006 Linus Torvalds and Junio C Hamano
 #
-USAGE=3D'[--mixed | --soft | --hard]  [<commit-ish>] [ [--] <paths>...=
]'
+USAGE=3D'[--mixed | --soft | --hard]  [<committish>] [ [--] <paths>...=
]'
 SUBDIRECTORY_OK=3DYes
 . git-sh-setup
 set_reflog_action "reset $*"
diff --git a/contrib/examples/git-revert.sh b/contrib/examples/git-reve=
rt.sh
index 6bf155c..6f1dd66 100755
--- a/contrib/examples/git-revert.sh
+++ b/contrib/examples/git-revert.sh
@@ -9,12 +9,12 @@ case "$0" in
 	test -t 0 && edit=3D-e
 	replay=3D
 	me=3Drevert
-	USAGE=3D'[--edit | --no-edit] [-n] <commit-ish>' ;;
+	USAGE=3D'[--edit | --no-edit] [-n] <committish>' ;;
 *-cherry-pick* )
 	replay=3Dt
 	edit=3D
 	me=3Dcherry-pick
-	USAGE=3D'[--edit] [-n] [-r] [-x] <commit-ish>'  ;;
+	USAGE=3D'[--edit] [-n] [-r] [-x] <committish>'  ;;
 * )
 	echo >&2 "What are you talking about?"
 	exit 1 ;;
diff --git a/po/de.po b/po/de.po
index 00519b2..4cdb2aa 100644
--- a/po/de.po
+++ b/po/de.po
@@ -8742,7 +8742,7 @@ msgstr ""
 "erster Verwendung aus."
=20
 #: builtin/revert.c:22
-msgid "git revert [options] <commit-ish>..."
+msgid "git revert [options] <committish>..."
 msgstr "git revert [Optionen] <Commit-Angabe>..."
=20
 #: builtin/revert.c:23
@@ -8750,7 +8750,7 @@ msgid "git revert <subcommand>"
 msgstr "git revert <Unterkommando>"
=20
 #: builtin/revert.c:28
-msgid "git cherry-pick [options] <commit-ish>..."
+msgid "git cherry-pick [options] <committish>..."
 msgstr "git cherry-pick [Optionen] <Commit-Angabe>..."
=20
 #: builtin/revert.c:29
diff --git a/po/fr.po b/po/fr.po
index 8d74171..60046ee 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -8032,7 +8032,7 @@ msgid ""
 msgstr ""
=20
 #: builtin/revert.c:22
-msgid "git revert [options] <commit-ish>..."
+msgid "git revert [options] <committish>..."
 msgstr ""
=20
 #: builtin/revert.c:23
@@ -8040,7 +8040,7 @@ msgid "git revert <subcommand>"
 msgstr ""
=20
 #: builtin/revert.c:28
-msgid "git cherry-pick [options] <commit-ish>..."
+msgid "git cherry-pick [options] <committish>..."
 msgstr ""
=20
 #: builtin/revert.c:29
diff --git a/po/git.pot b/po/git.pot
index 928268f..d101f1b 100644
--- a/po/git.pot
+++ b/po/git.pot
@@ -8146,7 +8146,7 @@ msgid ""
 msgstr ""
=20
 #: builtin/revert.c:22
-msgid "git revert [options] <commit-ish>..."
+msgid "git revert [options] <committish>..."
 msgstr ""
=20
 #: builtin/revert.c:23
@@ -8154,7 +8154,7 @@ msgid "git revert <subcommand>"
 msgstr ""
=20
 #: builtin/revert.c:28
-msgid "git cherry-pick [options] <commit-ish>..."
+msgid "git cherry-pick [options] <committish>..."
 msgstr ""
=20
 #: builtin/revert.c:29
diff --git a/po/sv.po b/po/sv.po
index cdee340..e118303 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -8528,7 +8528,7 @@ msgstr ""
 "varianten."
=20
 #: builtin/revert.c:22
-msgid "git revert [options] <commit-ish>..."
+msgid "git revert [options] <committish>..."
 msgstr "git revert [flaggor] <incheckning-igt>..."
=20
 #: builtin/revert.c:23
@@ -8536,7 +8536,7 @@ msgid "git revert <subcommand>"
 msgstr "git revert <underkommando>"
=20
 #: builtin/revert.c:28
-msgid "git cherry-pick [options] <commit-ish>..."
+msgid "git cherry-pick [options] <committish>..."
 msgstr "git cherry-pick [flaggor] <incheckning-igt>..."
=20
 #: builtin/revert.c:29
diff --git a/po/vi.po b/po/vi.po
index ebc079c..263873c 100644
--- a/po/vi.po
+++ b/po/vi.po
@@ -8673,16 +8673,16 @@ msgstr ""
 "Ch=E1=BA=A1y l=E1=BB=87nh \"git rev-parse --parseopt -h\" =C4=91=E1=BB=
=83 c=C3=B3 th=C3=AAm th=C3=B4ng tin v=E1=BB=81 c=C3=A1ch d=C3=B9ng."
=20
 #: builtin/revert.c:22
-msgid "git revert [options] <commit-ish>..."
-msgstr "git revert [c=C3=A1c-t=C3=B9y-ch=E1=BB=8Dn] <commit-ish>..."
+msgid "git revert [options] <committish>..."
+msgstr "git revert [c=C3=A1c-t=C3=B9y-ch=E1=BB=8Dn] <committish>..."
=20
 #: builtin/revert.c:23
 msgid "git revert <subcommand>"
 msgstr "git revert <l=E1=BB=87nh-con>"
=20
 #: builtin/revert.c:28
-msgid "git cherry-pick [options] <commit-ish>..."
-msgstr "git cherry-pick [c=C3=A1c-t=C3=B9y-ch=E1=BB=8Dn] <commit-ish>.=
=2E."
+msgid "git cherry-pick [options] <committish>..."
+msgstr "git cherry-pick [c=C3=A1c-t=C3=B9y-ch=E1=BB=8Dn] <committish>.=
=2E."
=20
 #: builtin/revert.c:29
 msgid "git cherry-pick <subcommand>"
diff --git a/po/zh_CN.po b/po/zh_CN.po
index 497d847..66e2e60 100644
--- a/po/zh_CN.po
+++ b/po/zh_CN.po
@@ -8496,7 +8496,7 @@ msgstr ""
 "=E5=88=9D=E6=AC=A1=E4=BD=BF=E7=94=A8=E6=97=B6=E6=89=A7=E8=A1=8C \"git=
 rev-parse --parseopt -h\" =E6=9D=A5=E8=8E=B7=E5=BE=97=E6=9B=B4=E5=A4=9A=
=E4=BF=A1=E6=81=AF=E3=80=82"
=20
 #: builtin/revert.c:22
-msgid "git revert [options] <commit-ish>..."
+msgid "git revert [options] <committish>..."
 msgstr "git revert [=E9=80=89=E9=A1=B9] <=E6=8F=90=E4=BA=A4=E5=8F=B7>.=
=2E."
=20
 #: builtin/revert.c:23
@@ -8504,7 +8504,7 @@ msgid "git revert <subcommand>"
 msgstr "git revert <=E5=AD=90=E5=91=BD=E4=BB=A4>"
=20
 #: builtin/revert.c:28
-msgid "git cherry-pick [options] <commit-ish>..."
+msgid "git cherry-pick [options] <committish>..."
 msgstr "git cherry-pick [=E9=80=89=E9=A1=B9] <=E6=8F=90=E4=BA=A4=E5=8F=
=B7>..."
=20
 #: builtin/revert.c:29
diff --git a/remote.c b/remote.c
index efcba93..9099cb3 100644
--- a/remote.c
+++ b/remote.c
@@ -1663,7 +1663,7 @@ int ref_newer(const unsigned char *new_sha1, cons=
t unsigned char *old_sha1)
 	int found =3D 0;
=20
 	/*
-	 * Both new and old must be commit-ish and new is descendant of
+	 * Both new and old must be committish and new is descendant of
 	 * old.  Otherwise we require --force.
 	 */
 	o =3D deref_tag(parse_object(old_sha1), NULL, 0);
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-di=
sambiguation.sh
index 840bb6e..4b311c7 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -86,8 +86,8 @@ test_expect_success 'first commit' '
 	git commit -m a2onsxbvj
 '
=20
-test_expect_success 'disambiguate commit-ish' '
-	# feed commit-ish in an unambiguous way
+test_expect_success 'disambiguate committish' '
+	# feed committish in an unambiguous way
 	git rev-parse --verify 0000000000e4f^{commit} &&
=20
 	# ambiguous at the object name level, but there is only one
@@ -104,7 +104,7 @@ test_expect_success 'disambiguate commit' '
 	test $(git rev-parse $commit^) =3D $(git rev-parse 0000000000e4f)
 '
=20
-test_expect_success 'log name1..name2 takes only commit-ishes on both =
ends' '
+test_expect_success 'log name1..name2 takes only committishes on both =
ends' '
 	# These are underspecified from the prefix-length point of view
 	# to disambiguate the commit with other objects, but there is only
 	# one commit that has 00000* prefix at this point.
@@ -116,19 +116,19 @@ test_expect_success 'log name1..name2 takes only =
commit-ishes on both ends' '
 	git log 000000000...
 '
=20
-test_expect_success 'rev-parse name1..name2 takes only commit-ishes on=
 both ends' '
+test_expect_success 'rev-parse name1..name2 takes only committishes on=
 both ends' '
 	# Likewise.
 	git rev-parse 000000000..000000000 &&
 	git rev-parse ..000000000 &&
 	git rev-parse 000000000..
 '
=20
-test_expect_success 'git log takes only commit-ish' '
+test_expect_success 'git log takes only committish' '
 	# Likewise.
 	git log 000000000
 '
=20
-test_expect_success 'git reset takes only commit-ish' '
+test_expect_success 'git reset takes only committish' '
 	# Likewise.
 	git reset 000000000
 '
@@ -138,7 +138,7 @@ test_expect_success 'first tag' '
 	git tag -a -m j7cp83um v1.0.0
 '
=20
-test_expect_failure 'two semi-ambiguous commit-ish' '
+test_expect_failure 'two semi-ambiguous committish' '
 	# At this point, we have a tag 0000000000f8f that points
 	# at a commit 0000000000e4f, and a tree and a blob that
 	# share 0000000000 prefix with these tag and commit.
@@ -249,7 +249,7 @@ test_expect_success 'parse describe name not ignori=
ng ambiguity' '
 	test_must_fail git rev-parse --verify v1.0.0-1-g000000000
 '
=20
-test_expect_success 'ambiguous commit-ish' '
+test_expect_success 'ambiguous committish' '
 	# Now there are many commits that begin with the
 	# common prefix, none of these should pick one at
 	# random.  They all should result in ambiguity errors.
--=20
1.8.4
