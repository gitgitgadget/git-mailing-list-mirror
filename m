From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/4] Add test for using Git at root of file system
Date: Wed, 10 Feb 2010 00:02:30 +0700
Message-ID: <1265734950-15145-4-git-send-email-pclouds@gmail.com>
References: <1265734950-15145-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org,
	=?UTF-8?q?Jo=C3=A3o=20Carlos=20Mendes=20Lu=C3=ADs?= 
	<jonny@jonny.eng.br>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Feb 09 18:06:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NetXE-0007RQ-TL
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 18:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755169Ab0BIRFj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Feb 2010 12:05:39 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53343 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755161Ab0BIRFi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 12:05:38 -0500
Received: by mail-vw0-f46.google.com with SMTP id 12so351911vws.19
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 09:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=iYJtbvHQKCqsgB7l1kAikvBD99KoDOFoXfqJFgn7d4w=;
        b=RUPkevXBvtnmcfq2Yg/VQYDcwRHIBtMzd9Kw/Q6iHqktYAlP3qH9X/5u/xhTTmfZYz
         qkOu2bksz+6Gk52bXoD1iqtT6q03QO+51n5ZLKWcsoRKIJg1/NpdhrlC75VWJrVOv+5r
         4KZG6zXWR3xnVwh57G+Q2CJE4nHJmbbkXA6/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=NzpI1yOEyYMnKBYcFy9PuboXSA8QkpLD1pBeJI5jr9uKORn3PXZ4ma0i+pUOEyQmJj
         qIRnd/s/92U+l/MeTwdCRT+PwzK6IvtsQIKgUiDO88hkWbzmx5oOUvZlTA79xr4PYOtM
         0YGnLJCinsgjpdFS7OlIqe8GOYSZON+YBkKNE=
Received: by 10.220.107.81 with SMTP id a17mr749039vcp.189.1265735137827;
        Tue, 09 Feb 2010 09:05:37 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.235.86])
        by mx.google.com with ESMTPS id 36sm2307815vws.18.2010.02.09.09.05.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Feb 2010 09:05:36 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 10 Feb 2010 00:02:55 +0700
X-Mailer: git-send-email 1.7.0.rc2.182.g3adef
In-Reply-To: <1265734950-15145-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139417>

This kind of test requires a throw-away root filesystem so that it can
play on. If you have such a system, go ahead, "chmod 777 /" and run
this test manually ("make test" with root permission won't work).

If you don't but have Linux, static linked busybox, rsync and root
permission, then run "t/t1509/prepare-chroot.sh /tmp/test". You will be
instructed to create /dev/null and given a command to chroot into.
Within chroot, you will be placed at directory "t" of Git source code
=46eel free to burn your chroot.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 May have problem committing. Anyway I don't need commit now.

 t/t1509-root-worktree.sh  |  244 +++++++++++++++++++++++++++++++++++++=
++++++++
 t/t1509/excludes          |   14 +++
 t/t1509/prepare-chroot.sh |   38 +++++++
 3 files changed, 296 insertions(+), 0 deletions(-)
 create mode 100755 t/t1509-root-worktree.sh
 create mode 100644 t/t1509/excludes
 create mode 100755 t/t1509/prepare-chroot.sh

diff --git a/t/t1509-root-worktree.sh b/t/t1509-root-worktree.sh
new file mode 100755
index 0000000..ae01b6d
--- /dev/null
+++ b/t/t1509-root-worktree.sh
@@ -0,0 +1,244 @@
+#!/bin/sh
+
+test_description=3D'Test Git when git repository is located at root
+
+This test requires write access in root. Do not bother if you do not
+have a throwaway chroot or VM.
+
+Script t1509/prepare-chroot.sh may help you setup chroot, then you
+can chroot in and execute this test from there.
+'
+
+. ./test-lib.sh
+
+test_cmp_val() {
+	echo "$1" > expected
+	echo "$2" > result
+	test_cmp expected result
+}
+
+test_vars() {
+	test_expect_success "$1: gitdir" '
+		test_cmp_val "'"$2"'" "$(git rev-parse --git-dir)"
+	'
+
+	test_expect_success "$1: worktree" '
+		test_cmp_val "'"$3"'" "$(git rev-parse --show-toplevel)"
+	'
+
+	test_expect_success "$1: prefix" '
+		test_cmp_val "'"$4"'" "$(git rev-parse --show-prefix)"
+	'
+}
+
+test_foobar_root() {
+	test_expect_success 'add relative' '
+		test -z "$(cd / && git ls-files)" &&
+		git add foo/foome &&
+		git add foo/bar/barme &&
+		git add me &&
+		( cd / && git ls-files --stage ) > result &&
+		test_cmp /ls.expected result &&
+		rm "$(git rev-parse --git-dir)/index"
+	'
+
+	test_expect_success 'add absolute' '
+		test -z "$(cd / && git ls-files)" &&
+		git add /foo/foome &&
+		git add /foo/bar/barme &&
+		git add /me &&
+		( cd / && git ls-files --stage ) > result &&
+		test_cmp /ls.expected result &&
+		rm "$(git rev-parse --git-dir)/index"
+	'
+
+}
+
+test_foobar_foo() {
+	test_expect_success 'add relative' '
+		test -z "$(cd / && git ls-files)" &&
+		git add foome &&
+		git add bar/barme &&
+		git add ../me &&
+		( cd / && git ls-files --stage ) > result &&
+		test_cmp /ls.expected result &&
+		rm "$(git rev-parse --git-dir)/index"
+	'
+
+	test_expect_success 'add absolute' '
+		test -z "$(cd / && git ls-files)" &&
+		git add /foo/foome &&
+		git add /foo/bar/barme &&
+		git add /me &&
+		( cd / && git ls-files --stage ) > result &&
+		test_cmp /ls.expected result &&
+		rm "$(git rev-parse --git-dir)/index"
+	'
+}
+
+test_foobar_foobar() {
+	test_expect_success 'add relative' '
+		test -z "$(cd / && git ls-files)" &&
+		git add ../foome &&
+		git add barme &&
+		git add ../../me &&
+		( cd / && git ls-files --stage ) > result &&
+		test_cmp /ls.expected result &&
+		rm "$(git rev-parse --git-dir)/index"
+	'
+
+	test_expect_success 'add absolute' '
+		test -z "$(cd / && git ls-files)" &&
+		git add /foo/foome &&
+		git add /foo/bar/barme &&
+		git add /me &&
+		( cd / && git ls-files --stage ) > result &&
+		test_cmp /ls.expected result &&
+		rm "$(git rev-parse --git-dir)/index"
+	'
+}
+
+if ! test_have_prereq POSIXPERM || ! [ -w / ]; then
+	say "Dangerous test skipped. Read this test if you want to execute it=
"
+	test_done
+fi
+
+if [ "$IKNOWWHATIAMDOING" !=3D "YES" ]; then
+	say "You must set env var IKNOWWHATIAMDOING=3DYES in order to run thi=
s test"
+	test_done
+fi
+
+ONE_SHA1=3Dd00491fd7e5bb6fa28c517a0bb32b8b506539d4d
+
+test_expect_success 'setup' '
+	rm -rf /foo
+	mkdir /foo &&
+	mkdir /foo/bar &&
+	echo 1 > /foo/foome &&
+	echo 1 > /foo/bar/barme &&
+	echo 1 > /me
+'
+
+say "GIT_DIR absolute, GIT_WORK_TREE set"
+
+test_expect_success 'go to /' 'cd /'
+
+cat >ls.expected <<EOF
+100644 $ONE_SHA1 0	foo/bar/barme
+100644 $ONE_SHA1 0	foo/foome
+100644 $ONE_SHA1 0	me
+EOF
+
+export GIT_DIR=3D"$TRASH_DIRECTORY/.git"
+export GIT_WORK_TREE=3D/
+
+test_vars 'abs gitdir, root' "$GIT_DIR" "/" ""
+test_foobar_root
+
+test_expect_success 'go to /foo' 'cd /foo'
+
+test_vars 'abs gitdir, foo' "$GIT_DIR" "/" "foo/"
+test_foobar_foo
+
+test_expect_success 'go to /foo/bar' 'cd /foo/bar'
+
+test_vars 'abs gitdir, foo/bar' "$GIT_DIR" "/" "foo/bar/"
+test_foobar_foobar
+
+say "GIT_DIR relative, GIT_WORK_TREE set"
+
+test_expect_success 'go to /' 'cd /'
+
+export GIT_DIR=3D"$(echo $TRASH_DIRECTORY|sed 's,^/,,')/.git"
+export GIT_WORK_TREE=3D/
+
+test_vars 'rel gitdir, root' "$GIT_DIR" "/" ""
+test_foobar_root
+
+test_expect_success 'go to /foo' 'cd /foo'
+
+export GIT_DIR=3D"../$TRASH_DIRECTORY/.git"
+export GIT_WORK_TREE=3D/
+
+test_vars 'rel gitdir, foo' "$TRASH_DIRECTORY/.git" "/" "foo/"
+test_foobar_foo
+
+test_expect_success 'go to /foo/bar' 'cd /foo/bar'
+
+export GIT_DIR=3D"../../$TRASH_DIRECTORY/.git"
+export GIT_WORK_TREE=3D/
+
+test_vars 'rel gitdir, foo/bar' "$TRASH_DIRECTORY/.git" "/" "foo/bar/"
+test_foobar_foobar
+
+say "GIT_DIR relative, GIT_WORK_TREE relative"
+
+test_expect_success 'go to /' 'cd /'
+
+export GIT_DIR=3D"$(echo $TRASH_DIRECTORY|sed 's,^/,,')/.git"
+export GIT_WORK_TREE=3D.
+
+test_vars 'rel gitdir, root' "$GIT_DIR" "/" ""
+test_foobar_root
+
+test_expect_success 'go to /' 'cd /foo'
+
+export GIT_DIR=3D"../$TRASH_DIRECTORY/.git"
+export GIT_WORK_TREE=3D..
+
+test_vars 'rel gitdir, foo' "$TRASH_DIRECTORY/.git" "/" "foo/"
+test_foobar_foo
+
+test_expect_success 'go to /foo/bar' 'cd /foo/bar'
+
+export GIT_DIR=3D"../../$TRASH_DIRECTORY/.git"
+export GIT_WORK_TREE=3D../..
+
+test_vars 'rel gitdir, foo/bar' "$TRASH_DIRECTORY/.git" "/" "foo/bar/"
+test_foobar_foobar
+
+say ".git at root"
+
+unset GIT_DIR
+unset GIT_WORK_TREE
+
+test_expect_success 'go to /' 'cd /'
+test_expect_success 'setup' '
+	rm -rf /.git
+	echo "Initialized empty Git repository in /.git/" > expected &&
+	git init > result &&
+	test_cmp expected result
+'
+
+test_vars 'auto gitdir, root' ".git" "/" ""
+test_foobar_root
+
+test_expect_success 'go to /foo' 'cd /foo'
+test_vars 'auto gitdir, foo' "/.git" "/" "foo/"
+test_foobar_foo
+
+test_expect_success 'go to /foo/bar' 'cd /foo/bar'
+test_vars 'auto gitdir, foo/bar' "/.git" "/" "foo/bar/"
+test_foobar_foobar
+
+test_expect_success 'cleanup' 'rm -rf /.git'
+
+say "auto bare gitdir"
+
+# DESTROYYYYY!!!!!
+test_expect_failure 'setup' '
+	rm -rf /refs /objects /info /hooks
+	rm /*
+	cd / &&
+	echo "Initialized empty Git repository in /" > expected &&
+	git init --bare > result &&
+	test_cmp expected result
+'
+
+test_vars 'auto gitdir, root' "." "" ""
+
+test_expect_success 'go to /foo' 'cd /foo'
+
+test_vars 'auto gitdir, root' "/" "" ""
+
+test_done
diff --git a/t/t1509/excludes b/t/t1509/excludes
new file mode 100644
index 0000000..d4d21d3
--- /dev/null
+++ b/t/t1509/excludes
@@ -0,0 +1,14 @@
+*.o
+*~
+*.bak
+*.c
+*.h
+.git
+contrib
+Documentation
+git-gui
+gitk-git
+gitweb
+t/t4013
+t/t5100
+t/t5515
diff --git a/t/t1509/prepare-chroot.sh b/t/t1509/prepare-chroot.sh
new file mode 100755
index 0000000..407f2d2
--- /dev/null
+++ b/t/t1509/prepare-chroot.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+
+die() {
+	echo >&2 "$@"
+	exit 1
+}
+
+xmkdir() {
+	while [ -n "$1" ]; do
+		[ -d "$1" ] || mkdir "$1" || die "Unable to mkdir $1"
+		shift
+	done
+}
+
+R=3D"$1"
+
+[ -n "$R" ] || die "Usage: prepare-chroot.sh <root>"
+[ -x git ] || die "This script needs to be executed at git source code=
's top directory"
+[ -x /bin/busybox ] || die "You need busybox"
+
+xmkdir "$R" "$R/bin" "$R/etc" "$R/lib" "$R/dev"
+[ -c "$R/dev/null" ] || die "/dev/null is missing. Do mknod $R/dev/nul=
l c 1 3 && chmod 666 $R/dev/null"
+echo "root:x:0:0:root:/:/bin/sh" > "$R/etc/passwd"
+echo "$(id -nu):x:$(id -u):$(id -g)::$(pwd)/t:/bin/sh" >> "$R/etc/pass=
wd"
+echo "root::0:root" > "$R/etc/group"
+echo "$(id -ng)::$(id -g):$(id -nu)" >> "$R/etc/group"
+
+[ -x "$R/bin/busybox" ] || cp /bin/busybox "$R/bin/busybox"
+[ -x "$R/bin/sh" ] || ln -s /bin/busybox "$R/bin/sh"
+[ -x "$R/bin/su" ] || ln -s /bin/busybox "$R/bin/su"
+
+mkdir -p "$R$(pwd)"
+rsync --exclude-from t/t1509/excludes -Ha . "$R$(pwd)"
+ldd git | grep '=3D> /' | sed 's,.* =3D> *\([^ ]*\) .*,\1,' | while re=
ad i; do
+	mkdir -p "$R$(dirname $i)"
+	cp "$i" "$R/$i"
+done
+echo "Execute this in root: 'chroot $R /bin/su - $(id -nu)'"
--=20
1.7.0.rc2.182.g3adef
