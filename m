From: Nazri Ramliy <ayiehere@gmail.com>
Subject: [PATCH v2] Teach git to change to a given directory using -C option
Date: Mon, 2 Sep 2013 21:39:58 +0800
Message-ID: <20130902133911.GA23924@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 02 15:39:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGUM0-0002Lv-9W
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 15:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758291Ab3IBNjg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Sep 2013 09:39:36 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33140 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758212Ab3IBNjf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 09:39:35 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so4758242pdj.26
        for <git@vger.kernel.org>; Mon, 02 Sep 2013 06:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        bh=SDKfGrttJ+NQtOEO9w+99lwrXPDkYq0M6R51XUs4+SE=;
        b=gJK3RJ+GRM00HFgTOGCUX+IKX1oRyr7pPBvUF+i0PzE8lcvmGl+OzKvMXq20QhMA7j
         GQcZmYQn8td5c9PIfdbn86ZxsQgxLYt8Dj5S5mltFzw5yXu+RD3TdTnKxprT9iTiV+NT
         CLy7R8NwD24ftuS9a+oFTn72V8WKBKemPaVZrXc4HuhajvqjVo6W1VvOX9izPxrtTAr+
         0GL5/Ay+tRrp0jQZfC3OJK4Tc3NFRQ4kH0cY7Tke9w4saScejGs/5YrJkSrGMAyiTG6w
         rmz25zv6k1OAk5ug78tzjrzV/LIzFlM8ZCFcsf2a4lZSmTDko0HfPQdWFsEdUzdGeqxY
         FejQ==
X-Received: by 10.66.164.199 with SMTP id ys7mr26773258pab.104.1378129174558;
        Mon, 02 Sep 2013 06:39:34 -0700 (PDT)
Received: from gmail.com (lbn-26-27.tm.net.my. [202.188.26.27])
        by mx.google.com with ESMTPSA id mr3sm15998652pbb.27.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 02 Sep 2013 06:39:33 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233636>

On Sun, Sep 01, 2013 at 12:48:23AM -0400, Eric Sunshine wrote:
> On Fri, Aug 30, 2013 at 9:35 AM, Nazri Ramliy <ayiehere@gmail.com> wr=
ote:
>> With this new option, the above can be done with less keystrokes:
>
> Grammar: s/less/fewer/
>
> More below...

Thanks for taking the time to review this patch! The fix for the
above, and the following issues are in the re-roll below.

> The synopsis at the top of git.txt mentions --git-dir and --work-tree=
=2E
> For consistency, -C probably ought to be mentioned there, as well.

=46ixed.


> Other options which accept a directory, such as --git-dir and
> --work-tree, are documented as accepting <path>, but -C is
> inconsistently documented as accepting <directory>.

=46ixed.


>> + =A0 =A0 =A0 Run as if git were started in <directory> instead of t=
he current
>> + =A0 =A0 =A0 working directory. If multiple -C options are given, s=
ubsequent
>> + =A0 =A0 =A0 directory arguments are interpreted relative to the pr=
evious one: -C
>> + =A0 =A0 =A0 /usr -C src is equivalent to -C /usr/src. This option =
affects options
>
> The fragment "interpreted relative" seems ambiguous when absolute
> paths are involved.

In this re-roll the above text is now:

 -C <path>::
 	Run as if git were started in <path> instead of the current working
 	directory. If multiple -C options are given, subsequent relative <pat=
h>
 	arguments is interpreted relative to the previous effective directory=
:
 	"-C /usr -C src" is equivalent to "-C /usr/src", while "-C src -C /us=
r"
 	is equivalent to "C /usr". This option ...


> For existing options accepting an argument, the argument is formatted
> as <argument>. The -C option does not follow suit.
>
> As mentioned above, all other options accepting a directory are
> documented as taking <path>, but -C is inconsistent and is documented
> as taking 'directory' instead.

=46ixed as "[-C <path>]"


>> +test_description=3D'"-C <directory>" option and it effects on other=
 path-related options'
>
> s/it/its/
> s/<directory>/<path>/

=46ixed.


>> +test_expect_success '"git -C <dir>" runs git from the directory <di=
r>' '
>
> s/<dir>/<path>/g

=46ixed.


> Modern git tests tend to place the expected and actual outputs in
> files and then use test_cmp to verify that they are identical. For
> instance:
>
> =A0 =A0 echo "initial in dir1" >expected &&
> =A0 =A0 git -C dir1 log --format=3D"%s" >actual &&
> =A0 =A0 test_cmp expected actual

=46ixed.


> It would make sense also to test multiple -C options with combination=
s
> of absolute and and relative paths.

=46ixed - I've added one more test for testing that "-C ./here -C /ther=
e"
is equivalent to "-C /there" at the end of t0056-git-C.sh.

nazri
-- >8 --
Subject: [PATCH] Teach git to change to a given directory using -C opti=
on

This is similar in spirit to to "make -C dir ..." and "tar -C dir ...".

Currently it takes more effort (keypresses) to invoke git command in a
different directory than the current one without leaving the current
directory:

    1. (cd ~/foo && git status)
       git --git-dir=3D~/foo/.git --work-dir=3D~/foo status
       GIT_DIR=3D~/foo/.git GIT_WORK_TREE=3D~/foo git status
    2. (cd ../..; git grep foo)
    3. for d in d1 d2 d3; do (cd $d && git svn rebase); done

While doable the methods shown above are arguably more suitable for
scripting than quick command line invocations.

With this new option, the above can be done with fewer keystrokes:

    1. git -C ~/foo status
    2. git -C ../.. grep foo
    3. for d in d1 d2 d3; do git -C $d svn rebase; done

A new test script is added to verify the behavior of this option with
other path-related options like --git-dir and --work-tree.

Signed-off-by: Nazri Ramliy <ayiehere@gmail.com>
---
 Documentation/git.txt | 16 +++++++++-
 git.c                 | 15 ++++++++--
 t/t0056-git-C.sh      | 83 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 111 insertions(+), 3 deletions(-)
 create mode 100755 t/t0056-git-C.sh

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 83edf30..7a1369a 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -9,7 +9,7 @@ git - the stupid content tracker
 SYNOPSIS
 --------
 [verse]
-'git' [--version] [--help] [-c <name>=3D<value>]
+'git' [--version] [--help] [-C <path>] [-c <name>=3D<value>]
     [--exec-path[=3D<path>]] [--html-path] [--man-path] [--info-path]
     [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]
     [--git-dir=3D<path>] [--work-tree=3D<path>] [--namespace=3D<name>]
@@ -395,6 +395,20 @@ displayed. See linkgit:git-help[1] for more inform=
ation,
 because `git --help ...` is converted internally into `git
 help ...`.
=20
+-C <path>::
+	Run as if git were started in <path> instead of the current working
+	directory. If multiple -C options are given, subsequent relative <pat=
h>
+	arguments are interpreted relative to the previous effective director=
y:
+	"-C /usr -C src" is equivalent to "-C /usr/src", while "-C src -C /us=
r"
+	is equivalent to "C /usr". This option affects options that expect pa=
th
+	name like --git-dir and --work-tree in that their interpretations of
+	the path names would be made relative to the effective working
+	directory caused by the -C option. For example the following
+	invocations are equivalent:
+
+	    git --git-dir=3Da.git --work-tree=3Db -C c status
+	    git --git-dir=3Dc/a.git --work-tree=3Dc/b status
+
 -c <name>=3D<value>::
 	Pass a configuration parameter to the command. The value
 	given will override values from configuration files.
diff --git a/git.c b/git.c
index 2025f77..52bce74 100644
--- a/git.c
+++ b/git.c
@@ -7,7 +7,7 @@
 #include "commit.h"
=20
 const char git_usage_string[] =3D
-	"git [--version] [--help] [-c name=3Dvalue]\n"
+	"git [--version] [--help] [-C <path>] [-c name=3Dvalue]\n"
 	"           [--exec-path[=3D<path>]] [--html-path] [--man-path] [--in=
fo-path]\n"
 	"           [-p|--paginate|--no-pager] [--no-replace-objects] [--bare=
]\n"
 	"           [--git-dir=3D<path>] [--work-tree=3D<path>] [--namespace=3D=
<name>]\n"
@@ -54,7 +54,18 @@ static int handle_options(const char ***argv, int *a=
rgc, int *envchanged)
 		/*
 		 * Check remaining flags.
 		 */
-		if (!prefixcmp(cmd, "--exec-path")) {
+		if (!strcmp(cmd, "-C")) {
+			if (*argc < 2) {
+				fprintf(stderr, "No directory given for -C.\n" );
+				usage(git_usage_string);
+			}
+			if (chdir((*argv)[1]))
+				die_errno("Cannot change to '%s'", (*argv)[1]);
+			if (envchanged)
+				*envchanged =3D 1;
+			(*argv)++;
+			(*argc)--;
+		} else if (!prefixcmp(cmd, "--exec-path")) {
 			cmd +=3D 11;
 			if (*cmd =3D=3D '=3D')
 				git_set_argv_exec_path(cmd + 1);
diff --git a/t/t0056-git-C.sh b/t/t0056-git-C.sh
new file mode 100755
index 0000000..7dc1e48
--- /dev/null
+++ b/t/t0056-git-C.sh
@@ -0,0 +1,83 @@
+#!/bin/sh
+
+test_description=3D'"-C <path>" option and its effects on other path-r=
elated options'
+
+. ./test-lib.sh
+
+test_expect_success '"git -C <path>" runs git from the directory <path=
>' '
+	test_create_repo dir1 &&
+	echo 1 >dir1/a.txt &&
+	(cd dir1 && git add a.txt && git commit -m "initial in dir1") &&
+	echo "initial in dir1" >expected &&
+	git -C dir1 log --format=3D%s >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Multiple -C options: "-C dir1 -C dir2" is equival=
ent to "-C dir1/dir2"' '
+	test_create_repo dir1/dir2 &&
+	echo 1 >dir1/dir2/a.txt &&
+	git -C dir1/dir2 add a.txt &&
+	expected=3D"initial in dir1/dir2"
+	echo $expected >expected &&
+	git -C dir1/dir2 commit -m "$expected" &&
+	git -C dir1 -C dir2 log --format=3D%s >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Effect on --git-dir option: "-C c --git-dir=3Da.g=
it" is equivalent to "--git-dir c/a.git"' '
+	mkdir c &&
+	mkdir c/a &&
+	mkdir c/a.git &&
+	(cd c/a.git && git init --bare) &&
+	echo 1 >c/a/a.txt &&
+	git --git-dir c/a.git --work-tree=3Dc/a add a.txt &&
+	git --git-dir c/a.git --work-tree=3Dc/a commit -m "initial" &&
+	git --git-dir=3Dc/a.git log -1 --format=3D%s >expected &&
+	git -C c --git-dir=3Da.git log -1 --format=3D%s >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Order should not matter: "--git-dir=3Da.git -C c"=
 is equivalent to "-C c --git-dir=3Da.git"' '
+	git -C c --git-dir=3Da.git log -1 --format=3D%s >expected &&
+	git --git-dir=3Da.git -C c log -1 --format=3D%s >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Effect on --work-tree option: "-C c/a.git --work-=
tree=3D../a"  is equivalent to "--work-tree=3Dc/a --git-dir=3Dc/a.git"'=
 '
+	rm c/a/a.txt &&
+	git --git-dir=3Dc/a.git --work-tree=3Dc/a status >expected &&
+	git -C c/a.git --work-tree=3D../a status >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Order should not matter: "--work-tree=3D../a -C c=
/a.git" is equivalent to "-C c/a.git --work-tree=3D../a"' '
+	git -C c/a.git --work-tree=3D../a status >expected &&
+	git --work-tree=3D../a -C c/a.git status >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Effect on --git-dir and --work-tree options - "-C=
 c --git-dir=3Da.git --work-tree=3Da" is equivalent to "--git-dir=3Dc/a=
=2Egit --work-tree=3Dc/a"' '
+	git --git-dir=3Dc/a.git --work-tree=3Dc/a status >expected &&
+	git -C c --git-dir=3Da.git --work-tree=3Da status >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Order should not matter: "-C c --git-dir=3Da.git =
--work-tree=3Da" is equivalent to "--git-dir=3Da.git -C c --work-tree=3D=
a"' '
+	git -C c --git-dir=3Da.git --work-tree=3Da status >expected &&
+	git --git-dir=3Da.git -C c --work-tree=3Da status >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Order should not matter: "-C c --git-dir=3Da.git =
--work-tree=3Da" is equivalent to "--git-dir=3Da.git --work-tree=3Da -C=
 c"' '
+	git -C c --git-dir=3Da.git --work-tree=3Da status >expected &&
+	git --git-dir=3Da.git --work-tree=3Da -C c status >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'Relative followed by fullpath: "-C ./here -C /the=
re" is equivalent to "-C /there"' '
+	echo "initial in dir1/dir2" >expected &&
+	git -C dir1 -C "$PWD/dir1/dir2" log --format=3D%s >actual &&
+	test_cmp expected actual
+'
+
+test_done
--=20
1.8.4.24.g5fcd118
