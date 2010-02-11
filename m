From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/5] Add test for using Git at root directory
Date: Thu, 11 Feb 2010 21:43:23 +0700
Message-ID: <1265899403-15904-6-git-send-email-pclouds@gmail.com>
References: <1265899403-15904-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org,
	=?UTF-8?q?Jo=C3=A3o=20Carlos=20Mendes=20Lu=C3=ADs?= 
	<jonny@jonny.eng.br>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Feb 11 15:46:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfaJg-0006Hd-7F
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 15:46:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755897Ab0BKOqr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Feb 2010 09:46:47 -0500
Received: from mail-yw0-f189.google.com ([209.85.211.189]:39879 "EHLO
	mail-yw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832Ab0BKOqq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 09:46:46 -0500
Received: by mail-yw0-f189.google.com with SMTP id 27so1085732ywh.1
        for <git@vger.kernel.org>; Thu, 11 Feb 2010 06:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=TpMZ+H1x5Rti/3RrqL55l1gl6BB+LfZv136kYVKJBF8=;
        b=ZPJYXdTLu5A5GXQeWvCJNMlzmv5QmfmIDfsAQ5zTX8GBpgssA8dAfAb0mVlOifTBke
         5OBWzy87jUqTuKVdpb1BfqmMykXy8U6iyCvEpf4CEnHWlnJoa0NTA1qrLU0VWDx1ckWP
         qoipiHt8T9CLhMHiyfucTa+iMaheUvnWawWso=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=xaznQIPihhnnzYO57SzuVG1ww51u57JR25r6qoj5k+N0x2RgwPAPtxvL1Vvq2TkTSH
         VlMYOlRv1PV4MAthQrIo5nEkb3Jmb742R8JmB72nfwsl5Y14eHC3/uABNVYX+ldRiElU
         QgnRUIcW1jUFlQRALLzXt7ENkuimWLZshYKKU=
Received: by 10.90.20.33 with SMTP id 33mr170074agt.110.1265899601213;
        Thu, 11 Feb 2010 06:46:41 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.243.56])
        by mx.google.com with ESMTPS id 23sm935887ywh.33.2010.02.11.06.46.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Feb 2010 06:46:40 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 11 Feb 2010 21:43:59 +0700
X-Mailer: git-send-email 1.7.0.rc2.182.g3adef
In-Reply-To: <1265899403-15904-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139595>

This kind of test requires a throw-away root filesystem so that it can
play on. If you have such a system, go ahead, "chmod 777 /" and run
this test manually. Because this is a dangerous test, you are required
to set an env variable, and not to use root to run it.

Script prepare-root.sh may help you set up a chroot environment with
Git test suite inside. You will need Linux, static linked busybox,
rsync and root permission to use it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1509-root-worktree.sh  |  249 +++++++++++++++++++++++++++++++++++++=
++++++++
 t/t1509/excludes          |   14 +++
 t/t1509/prepare-chroot.sh |   38 +++++++
 3 files changed, 301 insertions(+), 0 deletions(-)
 create mode 100755 t/t1509-root-worktree.sh
 create mode 100644 t/t1509/excludes
 create mode 100755 t/t1509/prepare-chroot.sh

diff --git a/t/t1509-root-worktree.sh b/t/t1509-root-worktree.sh
new file mode 100755
index 0000000..5322a3b
--- /dev/null
+++ b/t/t1509-root-worktree.sh
@@ -0,0 +1,249 @@
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
+if [ "$UID" =3D 0 ]; then
+	say "No you can't run this with root"
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
+test_expect_success 'setup' '
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
