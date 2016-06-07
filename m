From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 3/5] t1404: add more tests of update-ref error handling
Date: Tue,  7 Jun 2016 13:50:08 +0200
Message-ID: <9077546cf7c0fd3968f4cca34e75b92e395f88e1.1465299118.git.mhagger@alum.mit.edu>
References: <cover.1465299118.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 13:51:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAFWm-0004Ls-AC
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 13:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161120AbcFGLuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 07:50:24 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:61998 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161079AbcFGLuU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2016 07:50:20 -0400
X-AuditID: 1207440f-8bbff700000008e4-38-5756b4fc6b6c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 22.26.02276.CF4B6575; Tue,  7 Jun 2016 07:50:20 -0400 (EDT)
Received: from michael.fritz.box (p548D6137.dip0.t-ipconnect.de [84.141.97.55])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u57BoCa2014544
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 7 Jun 2016 07:50:18 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1465299118.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsUixO6iqPtnS1i4wftdfBbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WF2YPP4+/4Dk8fOWXfZPZ717mH0uHhJ2WPB8/vsHp83yQWw
	RXHbJCWWlAVnpufp2yVwZ8w4s4GpoM2z4vHJk8wNjBNtuxg5OSQETCQOdfxi7GLk4hAS2Moo
	sf7yd1YI5xiTxPdd/WwgVWwCuhKLepqZQGwRgQiJhlctYB3MAvsYJU6um8/SxcjBISzgLrHh
	pRlIDYuAqsTvPe9ZQcK8AlESs64UQCyTk7g8/QHYSE4BC4kT71aC2UIC5hIXWzYxTmDkWcDI
	sIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI10QvN7NELzWldBMjJJz4dzB2rZc5xCjAwajEwyvw
	PTRciDWxrLgy9xCjJAeTkijvQ++wcCG+pPyUyozE4oz4otKc1OJDjBIczEoivAlrgXK8KYmV
	ValF+TApaQ4WJXFe9SXqfkIC6YklqdmpqQWpRTBZGQ4OJQlea2DcCAkWpaanVqRl5pQgpJk4
	OEGGc0mJFKfmpaQWJZaWZMSDIiC+GBgDICkeoL2vNoPsLS5IzAWKQrSeYlSUEufdBpIQAElk
	lObBjYUliVeM4kBfCvPuBaniASYYuO5XQIOZgAYvuxYMMrgkESEl1cA4Ye6JI0qXrK0v3dpc
	wVWunvG1cMvh9FRuJ1bBqQGaTEIHD7RLGi+uPVddffOg756cnCWKWUZmn+TbGV4/+1e2Zff8
	v/sOT2PZVXpz70Yln2XCTu8bFI/NlFTjEqllFOJ2+dDwLVYkQlX4DdO0qGcrL5VN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296628>

Some of the error messages will be improved in subsequent commits.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t1404-update-ref-errors.sh | 221 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 219 insertions(+), 2 deletions(-)

diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index a62d62a..0dcc16c 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -34,8 +34,9 @@ test_expect_success 'setup' '
 	git commit --allow-empty -m Initial &&
 	C=$(git rev-parse HEAD) &&
 	git commit --allow-empty -m Second &&
-	D=$(git rev-parse HEAD)
-
+	D=$(git rev-parse HEAD) &&
+	git commit --allow-empty -m Third &&
+	E=$(git rev-parse HEAD)
 '
 
 test_expect_success 'existing loose ref is a simple prefix of new' '
@@ -182,4 +183,220 @@ test_expect_success 'empty directory should not fool 1-arg delete' '
 	git update-ref --stdin
 '
 
+# Test various errors when reading the old values of references...
+
+test_expect_success 'missing old value blocks update' '
+	prefix=refs/missing-update &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/foo$Q: unable to resolve reference $Q$prefix/foo$Q
+	EOF
+	printf "%s\n" "update $prefix/foo $E $D" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_success 'incorrect old value blocks update' '
+	prefix=refs/incorrect-update &&
+	git update-ref $prefix/foo $C &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/foo$Q: is at $C but expected $D
+	EOF
+	printf "%s\n" "update $prefix/foo $E $D" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_success 'existing old value blocks create' '
+	prefix=refs/existing-create &&
+	git update-ref $prefix/foo $C &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/foo$Q: reference already exists
+	EOF
+	printf "%s\n" "create $prefix/foo $E" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_success 'incorrect old value blocks delete' '
+	prefix=refs/incorrect-delete &&
+	git update-ref $prefix/foo $C &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/foo$Q: is at $C but expected $D
+	EOF
+	printf "%s\n" "delete $prefix/foo $D" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_success 'missing old value blocks indirect update' '
+	prefix=refs/missing-indirect-update &&
+	git symbolic-ref $prefix/symref $prefix/foo &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/foo$Q: unable to resolve reference $Q$prefix/foo$Q
+	EOF
+	printf "%s\n" "update $prefix/symref $E $D" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_success 'incorrect old value blocks indirect update' '
+	prefix=refs/incorrect-indirect-update &&
+	git symbolic-ref $prefix/symref $prefix/foo &&
+	git update-ref $prefix/foo $C &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/symref$Q: is at $C but expected $D
+	EOF
+	printf "%s\n" "update $prefix/symref $E $D" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_success 'existing old value blocks indirect create' '
+	prefix=refs/existing-indirect-create &&
+	git symbolic-ref $prefix/symref $prefix/foo &&
+	git update-ref $prefix/foo $C &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/symref$Q: reference already exists
+	EOF
+	printf "%s\n" "create $prefix/symref $E" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_success 'incorrect old value blocks indirect delete' '
+	prefix=refs/incorrect-indirect-delete &&
+	git symbolic-ref $prefix/symref $prefix/foo &&
+	git update-ref $prefix/foo $C &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/symref$Q: is at $C but expected $D
+	EOF
+	printf "%s\n" "delete $prefix/symref $D" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_success 'missing old value blocks indirect no-deref update' '
+	prefix=refs/missing-noderef-update &&
+	git symbolic-ref $prefix/symref $prefix/foo &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/symref$Q: can${Q}t resolve old value
+	EOF
+	printf "%s\n" "option no-deref" "update $prefix/symref $E $D" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_success 'incorrect old value blocks indirect no-deref update' '
+	prefix=refs/incorrect-noderef-update &&
+	git symbolic-ref $prefix/symref $prefix/foo &&
+	git update-ref $prefix/foo $C &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/symref$Q: is at $C but expected $D
+	EOF
+	printf "%s\n" "option no-deref" "update $prefix/symref $E $D" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_failure 'existing old value blocks indirect no-deref create' '
+	prefix=refs/existing-noderef-create &&
+	git symbolic-ref $prefix/symref $prefix/foo &&
+	git update-ref $prefix/foo $C &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/symref$Q: reference already exists
+	EOF
+	printf "%s\n" "option no-deref" "create $prefix/symref $E" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_success 'incorrect old value blocks indirect no-deref delete' '
+	prefix=refs/incorrect-noderef-delete &&
+	git symbolic-ref $prefix/symref $prefix/foo &&
+	git update-ref $prefix/foo $C &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/symref$Q: is at $C but expected $D
+	EOF
+	printf "%s\n" "option no-deref" "delete $prefix/symref $D" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_success 'non-empty directory blocks create' '
+	prefix=refs/ne-create &&
+	mkdir -p .git/$prefix/foo/bar &&
+	: >.git/$prefix/foo/bar/baz.lock &&
+	test_when_finished "rm -f .git/$prefix/foo/bar/baz.lock" &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/foo$Q: there is a non-empty directory $Q.git/$prefix/foo$Q blocking reference $Q$prefix/foo$Q
+	EOF
+	printf "%s\n" "update $prefix/foo $C" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/foo$Q: unable to resolve reference $Q$prefix/foo$Q
+	EOF
+	printf "%s\n" "update $prefix/foo $D $C" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_success 'broken reference blocks create' '
+	prefix=refs/broken-create &&
+	mkdir -p .git/$prefix &&
+	echo "gobbledigook" >.git/$prefix/foo &&
+	test_when_finished "rm -f .git/$prefix/foo" &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/foo$Q: unable to resolve reference $Q$prefix/foo$Q: reference broken
+	EOF
+	printf "%s\n" "update $prefix/foo $C" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/foo$Q: unable to resolve reference $Q$prefix/foo$Q: reference broken
+	EOF
+	printf "%s\n" "update $prefix/foo $D $C" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_success 'non-empty directory blocks indirect create' '
+	prefix=refs/ne-indirect-create &&
+	git symbolic-ref $prefix/symref $prefix/foo &&
+	mkdir -p .git/$prefix/foo/bar &&
+	: >.git/$prefix/foo/bar/baz.lock &&
+	test_when_finished "rm -f .git/$prefix/foo/bar/baz.lock" &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/foo$Q: there is a non-empty directory $Q.git/$prefix/foo$Q blocking reference $Q$prefix/foo$Q
+	EOF
+	printf "%s\n" "update $prefix/symref $C" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/foo$Q: unable to resolve reference $Q$prefix/foo$Q
+	EOF
+	printf "%s\n" "update $prefix/symref $D $C" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_success 'broken reference blocks indirect create' '
+	prefix=refs/broken-indirect-create &&
+	git symbolic-ref $prefix/symref $prefix/foo &&
+	echo "gobbledigook" >.git/$prefix/foo &&
+	test_when_finished "rm -f .git/$prefix/foo" &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/foo$Q: unable to resolve reference $Q$prefix/foo$Q: reference broken
+	EOF
+	printf "%s\n" "update $prefix/symref $C" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/foo$Q: unable to resolve reference $Q$prefix/foo$Q: reference broken
+	EOF
+	printf "%s\n" "update $prefix/symref $D $C" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
 test_done
-- 
2.8.1
