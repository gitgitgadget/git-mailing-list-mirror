From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v3 2/4] test-lib: Use "$GIT_BUILD_DIR" instead of "$TEST_DIRECTORY"/../
Date: Thu, 19 Aug 2010 16:08:10 +0000
Message-ID: <1282234092-27429-3-git-send-email-avarab@gmail.com>
References: <1282138473-15613-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 19 18:08:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Om7fk-0001ab-7n
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 18:08:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899Ab0HSQIh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Aug 2010 12:08:37 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:34318 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653Ab0HSQIg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 12:08:36 -0400
Received: by mail-ww0-f42.google.com with SMTP id 26so4268384wwf.1
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 09:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=YYd2aORvrX3ZP2jVYHxS4FWjw2i5LQgoutP6en9OixA=;
        b=vklQ7QTb6gU7M5PMCN6T5zyp2ZjeOafumN5cBQ56jbplNGImH9Q+NBTAeA1BZX8P7P
         HZDxxmlE8wi/alb5TYHJQ6m5Zm2bm0jLv6m/S0V+xcYEuq7G8L/J1DYVhJq0mTKn8nkL
         HCa4qbn9ss90brl1qfVyxo0KmwLRmahicvS0E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=g2ARZEsI0OjNapMXbREYo269RhURvEuZXZkB8Olxyq8bxLSd+W/Ayh97j+OPXdENYj
         Jn4Cf01OKXOIlYdFvQ1zEfwzeXc4c7sagjzLNsUHEorrevjBR4DBfL9t2oLUvgX2WGtW
         HontUY3GiSyTQhyYWGHqg26rAISyBXveRLzZU=
Received: by 10.227.136.69 with SMTP id q5mr5356wbt.202.1282234116059;
        Thu, 19 Aug 2010 09:08:36 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e8sm1118781wej.46.2010.08.19.09.08.34
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 19 Aug 2010 09:08:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.446.g168052
In-Reply-To: <1282138473-15613-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153939>

Change code that used $TEST_DIRECTORY/.. to use $GIT_BUILD_DIR
instead, the two are equivalent, but the latter is easier to read.

This required moving the assignment od GIT_BUILD_DIR to earlier in the
test-lib.sh file.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/test-lib.sh |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 0e460f9..689aa29 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -685,7 +685,7 @@ test_create_repo () {
 	repo=3D"$1"
 	mkdir -p "$repo"
 	cd "$repo" || error "Cannot setup test environment"
-	"$GIT_EXEC_PATH/git-init" "--template=3D$TEST_DIRECTORY/../templates/=
blt/" >&3 2>&4 ||
+	"$GIT_EXEC_PATH/git-init" "--template=3D$GIT_BUILD_DIR/templates/blt/=
" >&3 2>&4 ||
 	error "cannot run git init -- have you built things yet?"
 	mv .git/hooks .git/hooks-disabled
 	cd "$owd"
@@ -748,6 +748,8 @@ test_done () {
 # Test the binaries we have just built.  The tests are kept in
 # t/ subdirectory and are run in 'trash directory' subdirectory.
 TEST_DIRECTORY=3D$(pwd)
+GIT_BUILD_DIR=3D"$TEST_DIRECTORY"/..
+
 if test -n "$valgrind"
 then
 	make_symlink () {
@@ -774,7 +776,7 @@ then
 		test -x "$1" || return
=20
 		base=3D$(basename "$1")
-		symlink_target=3D$TEST_DIRECTORY/../$base
+		symlink_target=3D$GIT_BUILD_DIR/$base
 		# do not override scripts
 		if test -x "$symlink_target" &&
 		    test ! -d "$symlink_target" &&
@@ -793,7 +795,7 @@ then
 	# override all git executables in TEST_DIRECTORY/..
 	GIT_VALGRIND=3D$TEST_DIRECTORY/valgrind
 	mkdir -p "$GIT_VALGRIND"/bin
-	for file in $TEST_DIRECTORY/../git* $TEST_DIRECTORY/../test-*
+	for file in $GIT_BUILD_DIR/git* $GIT_BUILD_DIR/test-*
 	do
 		make_valgrind_symlink $file
 	done
@@ -814,10 +816,10 @@ then
 elif test -n "$GIT_TEST_INSTALLED" ; then
 	GIT_EXEC_PATH=3D$($GIT_TEST_INSTALLED/git --exec-path)  ||
 	error "Cannot run git from $GIT_TEST_INSTALLED."
-	PATH=3D$GIT_TEST_INSTALLED:$TEST_DIRECTORY/..:$PATH
+	PATH=3D$GIT_TEST_INSTALLED:$GIT_BUILD_DIR:$PATH
 	GIT_EXEC_PATH=3D${GIT_TEST_EXEC_PATH:-$GIT_EXEC_PATH}
 else # normal case, use ../bin-wrappers only unless $with_dashes:
-	git_bin_dir=3D"$TEST_DIRECTORY/../bin-wrappers"
+	git_bin_dir=3D"$GIT_BUILD_DIR/bin-wrappers"
 	if ! test -x "$git_bin_dir/git" ; then
 		if test -z "$with_dashes" ; then
 			say "$git_bin_dir/git is not executable; using GIT_EXEC_PATH"
@@ -825,13 +827,12 @@ else # normal case, use ../bin-wrappers only unle=
ss $with_dashes:
 		with_dashes=3Dt
 	fi
 	PATH=3D"$git_bin_dir:$PATH"
-	GIT_EXEC_PATH=3D$TEST_DIRECTORY/..
+	GIT_EXEC_PATH=3D$GIT_BUILD_DIR
 	if test -n "$with_dashes" ; then
-		PATH=3D"$TEST_DIRECTORY/..:$PATH"
+		PATH=3D"$GIT_BUILD_DIR:$PATH"
 	fi
 fi
-GIT_BUILD_DIR=3D"$TEST_DIRECTORY"/..
-GIT_TEMPLATE_DIR=3D"$TEST_DIRECTORY"/../templates/blt
+GIT_TEMPLATE_DIR=3D"$GIT_BUILD_DIR"/templates/blt
 unset GIT_CONFIG
 GIT_CONFIG_NOSYSTEM=3D1
 GIT_CONFIG_NOGLOBAL=3D1
@@ -849,22 +850,22 @@ then
 	fi
 fi
=20
-GITPERLLIB=3D"$TEST_DIRECTORY"/../perl/blib/lib:"$TEST_DIRECTORY"/../p=
erl/blib/arch/auto/Git
+GITPERLLIB=3D"$GIT_BUILD_DIR"/perl/blib/lib:"$GIT_BUILD_DIR"/perl/blib=
/arch/auto/Git
 export GITPERLLIB
-test -d "$TEST_DIRECTORY"/../templates/blt || {
+test -d "$GIT_BUILD_DIR"/templates/blt || {
 	error "You haven't built things yet, have you?"
 }
=20
 if test -z "$GIT_TEST_INSTALLED" && test -z "$NO_PYTHON"
 then
-	GITPYTHONLIB=3D"$TEST_DIRECTORY/../git_remote_helpers/build/lib"
+	GITPYTHONLIB=3D"$GIT_BUILD_DIR/git_remote_helpers/build/lib"
 	export GITPYTHONLIB
-	test -d "$TEST_DIRECTORY"/../git_remote_helpers/build || {
+	test -d "$GIT_BUILD_DIR"/git_remote_helpers/build || {
 		error "You haven't built git_remote_helpers yet, have you?"
 	}
 fi
=20
-if ! test -x "$TEST_DIRECTORY"/../test-chmtime; then
+if ! test -x "$GIT_BUILD_DIR"/test-chmtime; then
 	echo >&2 'You need to build test-chmtime:'
 	echo >&2 'Run "make test-chmtime" in the source (toplevel) directory'
 	exit 1
--=20
1.7.2.1.446.g168052
