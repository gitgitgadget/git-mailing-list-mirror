From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 3/3] We use TAP so the Perl test can run without scaffolding
Date: Wed,  9 Jun 2010 15:24:27 +0000
Message-ID: <1276097067-316-1-git-send-email-avarab@gmail.com>
References: <1276096943-32671-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 09 17:25:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMN9P-00036W-Ha
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 17:25:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158Ab0FIPYz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jun 2010 11:24:55 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57766 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932112Ab0FIPYx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 11:24:53 -0400
Received: by fxm8 with SMTP id 8so3669296fxm.19
        for <git@vger.kernel.org>; Wed, 09 Jun 2010 08:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=2z8zwYxL2IZx1QoViqjTHxY4a5pmoJY/rg7s6sNm5KU=;
        b=kMENcRV39wE92rMKfcE2JWFE7U3TElCbQ6CYLQ0Z5np0D/+koay6qvBiHkc4UY3KEy
         ewT9QFEJZsCVWSyTfS8CbiJIBR0B/LaZG1+G+wgtGntpZ6Hrp6TOI9mAgh6aGg6z8YHJ
         pHfIUlLG+0mqty7S3mk0zpgPQnza4TBsIvohU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=AIs3auhwKlPDP9bw57z3jV7y2sLcFwytnoXb4IfGuhtQd2dEtLgbalScQhSZf9re1/
         SrXO/4f8q3wbSanIJjpozY5VVumLr9sVGaQQ2Xn1d2RpKaGycjFAzHxO67CF4DoDBfTl
         Ud8ylut0NHwxbGXTH+E8ulMK7f+i0teI760Rg=
Received: by 10.204.83.80 with SMTP id e16mr950706bkl.43.1276097091697;
        Wed, 09 Jun 2010 08:24:51 -0700 (PDT)
Received: from localhost.localdomain ([188.110.74.26])
        by mx.google.com with ESMTPS id z17sm29999826bkx.12.2010.06.09.08.24.50
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 09 Jun 2010 08:24:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.243.gda92d6.dirty
In-Reply-To: <1276096943-32671-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148786>

This removes the test_external and test_external_without_stderr
functions added by Lea Wiemann in
fb32c410087e68d650b31f68e66b3d9cbcce4a56. Nothing else used them, and
now that we're using TAP they shouldn't be necessary.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

This patch removes functionality that I'm using for some new Perl
tests in my gettext patch series. If this gets accepted it's trivial
for me to send an update to the gettext series to use the new TAP-like
Perl tests.

 t/t9700-perl-git.sh |    7 ++---
 t/t9700/test.pl     |    9 +++++++
 t/test-lib.sh       |   62 -------------------------------------------=
--------
 3 files changed, 12 insertions(+), 66 deletions(-)

diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index 3999bf7..6c22dbc 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -46,8 +46,7 @@ test_expect_success \
      git config --add test.int 2k
      '
=20
-test_external_without_stderr \
-    'Perl API' \
-    "$PERL_PATH" "$TEST_DIRECTORY"/t9700/test.pl
+"$PERL_PATH" "$TEST_DIRECTORY"/t9700/test.pl
=20
-test_done
+# The Perl test finalizes the plan, so don't call test_done() here.
+GIT_EXIT_OK=3Dt
diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index 666722d..c1ac913 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -7,6 +7,13 @@ use strict;
=20
 use Test::More qw(no_plan);
=20
+BEGIN {
+	# t9700-perl-git.sh kicks off our testing, so we have to go from
+	# there.
+	$Test::Builder::Test->{Curr_Test} =3D 1;
+	$Test::Builder::Test->{No_Ending} =3D 1;
+}
+
 use Cwd;
 use File::Basename;
=20
@@ -105,3 +112,5 @@ my $last_commit =3D $r2->command_oneline(qw(rev-par=
se --verify HEAD));
 like($last_commit, qr/^[0-9a-fA-F]{40}$/, 'rev-parse returned hash');
 my $dir_commit =3D $r2->command_oneline('log', '-n1', '--pretty=3Dform=
at:%H', '.');
 isnt($last_commit, $dir_commit, 'log . does not show last commit');
+
+printf "1..%d\n", $Test::Builder::Test->{Curr_Test};
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 82fd0ef..2355a34 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -463,68 +463,6 @@ test_expect_code () {
 	echo >&3 ""
 }
=20
-# test_external runs external test scripts that provide continuous
-# test output about their progress, and succeeds/fails on
-# zero/non-zero exit code.  It outputs the test output on stdout even
-# in non-verbose mode, and announces the external script with "* run
-# <n>: ..." before running it.  When providing relative paths, keep in
-# mind that all scripts run in "trash directory".
-# Usage: test_external description command arguments...
-# Example: test_external 'Perl API' perl ../path/to/test.pl
-test_external () {
-	test "$#" =3D 4 && { prereq=3D$1; shift; } || prereq=3D
-	test "$#" =3D 3 ||
-	error >&5 "bug in the test script: not 3 or 4 parameters to test_exte=
rnal"
-	descr=3D"$1"
-	shift
-	if ! test_skip "$descr" "$@"
-	then
-		# Announce the script to reduce confusion about the
-		# test output that follows.
-		say_color "" " run $test_count: $descr ($*)"
-		# Export TEST_DIRECTORY, TRASH_DIRECTORY and GIT_TEST_LONG
-		# to be able to use them in script
-		export TEST_DIRECTORY TRASH_DIRECTORY GIT_TEST_LONG
-		# Run command; redirect its stderr to &4 as in
-		# test_run_, but keep its stdout on our stdout even in
-		# non-verbose mode.
-		"$@" 2>&4
-		if [ "$?" =3D 0 ]
-		then
-			test_ok_ "$descr"
-		else
-			test_failure_ "$descr" "$@"
-		fi
-	fi
-}
-
-# Like test_external, but in addition tests that the command generated
-# no output on stderr.
-test_external_without_stderr () {
-	# The temporary file has no (and must have no) security
-	# implications.
-	tmp=3D"$TMPDIR"; if [ -z "$tmp" ]; then tmp=3D/tmp; fi
-	stderr=3D"$tmp/git-external-stderr.$$.tmp"
-	test_external "$@" 4> "$stderr"
-	[ -f "$stderr" ] || error "Internal error: $stderr disappeared."
-	descr=3D"no stderr: $1"
-	shift
-	say >&3 "expecting no stderr from previous command"
-	if [ ! -s "$stderr" ]; then
-		rm "$stderr"
-		test_ok_ "$descr"
-	else
-		if [ "$verbose" =3D t ]; then
-			output=3D`echo; echo Stderr is:; cat "$stderr"`
-		else
-			output=3D
-		fi
-		# rm first in case test_failure exits.
-		rm "$stderr"
-		test_failure_ "$descr" "$@" "$output"
-	fi
-}
-
 # This is not among top-level (test_expect_success | test_expect_failu=
re)
 # but is a prefix that can be used in the test script, like:
 #
--=20
1.7.1.243.gda92d6.dirty
