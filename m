From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 03/10] lib-patch-mode tests: change from skip_all=* to prereq skip
Date: Fri, 13 Aug 2010 20:40:06 +0000
Message-ID: <1281732013-18284-4-git-send-email-avarab@gmail.com>
References: <1281732013-18284-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 13 22:41:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok146-0007V9-LL
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 22:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755916Ab0HMUlF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 16:41:05 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51636 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755793Ab0HMUlC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 16:41:02 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so3432822wwj.1
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 13:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=dKoNFa6jhXdZG3Aab/L5pSkS6vi7CLAEVayH5Rpv/CI=;
        b=US/UZJR8NklcPj/g+BBctRVF6+CNqU5wlBx2GFBiE5U7wsB+T4hdxvhLnz/61VsQ+0
         kKP4WYjr7eoHpYDuZN+N/ku+BZ2NciPYbdF+wdRIeyOPJFmkIuGGX6/oe4d8yav40b4m
         CI16PTYn8gYEzHkUmObvdx/yu0llvtuTLf3To=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=VPsvmdK6gBo6utPqB4dsbyksy8oK5tVo57JQMkYUe8Rf4sjHYPnxD/cUDdY7mw+iMk
         GNJA+27wJPYchIHFM6qrCm8uLW1SqOIDxmbPCoqjrMFJmhQ9MXHjFk07tC/Vt9ByoceR
         4GKwSP8qrB5dKEdHTg/RIDvNdElcS+yFT88ok=
Received: by 10.216.231.83 with SMTP id k61mr124272weq.88.1281732061743;
        Fri, 13 Aug 2010 13:41:01 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e8sm1838298wej.46.2010.08.13.13.40.59
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 13 Aug 2010 13:40:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.338.gf2379
In-Reply-To: <1281732013-18284-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153500>

Change this test to skip test with test prerequisites, and to do setup
work in tests. This improves the skipped statistics on platforms where
the test isn't run.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/lib-patch-mode.sh       |    5 -----
 t/t2016-checkout-patch.sh |   28 ++++++++++++++--------------
 t/t3904-stash-patch.sh    |   10 +++++-----
 t/t7105-reset-patch.sh    |    8 ++++----
 4 files changed, 23 insertions(+), 28 deletions(-)

diff --git a/t/lib-patch-mode.sh b/t/lib-patch-mode.sh
index 375e248..06c3c91 100644
--- a/t/lib-patch-mode.sh
+++ b/t/lib-patch-mode.sh
@@ -2,11 +2,6 @@
=20
 . ./test-lib.sh
=20
-if ! test_have_prereq PERL; then
-	skip_all=3D'skipping --patch tests, perl not available'
-	test_done
-fi
-
 set_state () {
 	echo "$3" > "$1" &&
 	git add "$1" &&
diff --git a/t/t2016-checkout-patch.sh b/t/t2016-checkout-patch.sh
index 2144184..7657ec1 100755
--- a/t/t2016-checkout-patch.sh
+++ b/t/t2016-checkout-patch.sh
@@ -4,7 +4,7 @@ test_description=3D'git checkout --patch'
=20
 . ./lib-patch-mode.sh
=20
-test_expect_success 'setup' '
+test_expect_success PERL 'setup' '
 	mkdir dir &&
 	echo parent > dir/foo &&
 	echo dummy > bar &&
@@ -18,40 +18,40 @@ test_expect_success 'setup' '
=20
 # note: bar sorts before dir/foo, so the first 'n' is always to skip '=
bar'
=20
-test_expect_success 'saying "n" does nothing' '
+test_expect_success PERL 'saying "n" does nothing' '
 	set_and_save_state dir/foo work head &&
 	(echo n; echo n) | git checkout -p &&
 	verify_saved_state bar &&
 	verify_saved_state dir/foo
 '
=20
-test_expect_success 'git checkout -p' '
+test_expect_success PERL 'git checkout -p' '
 	(echo n; echo y) | git checkout -p &&
 	verify_saved_state bar &&
 	verify_state dir/foo head head
 '
=20
-test_expect_success 'git checkout -p with staged changes' '
+test_expect_success PERL 'git checkout -p with staged changes' '
 	set_state dir/foo work index
 	(echo n; echo y) | git checkout -p &&
 	verify_saved_state bar &&
 	verify_state dir/foo index index
 '
=20
-test_expect_success 'git checkout -p HEAD with NO staged changes: abor=
t' '
+test_expect_success PERL 'git checkout -p HEAD with NO staged changes:=
 abort' '
 	set_and_save_state dir/foo work head &&
 	(echo n; echo y; echo n) | git checkout -p HEAD &&
 	verify_saved_state bar &&
 	verify_saved_state dir/foo
 '
=20
-test_expect_success 'git checkout -p HEAD with NO staged changes: appl=
y' '
+test_expect_success PERL 'git checkout -p HEAD with NO staged changes:=
 apply' '
 	(echo n; echo y; echo y) | git checkout -p HEAD &&
 	verify_saved_state bar &&
 	verify_state dir/foo head head
 '
=20
-test_expect_success 'git checkout -p HEAD with change already staged' =
'
+test_expect_success PERL 'git checkout -p HEAD with change already sta=
ged' '
 	set_state dir/foo index index
 	# the third n is to get out in case it mistakenly does not apply
 	(echo n; echo y; echo n) | git checkout -p HEAD &&
@@ -59,14 +59,14 @@ test_expect_success 'git checkout -p HEAD with chan=
ge already staged' '
 	verify_state dir/foo head head
 '
=20
-test_expect_success 'git checkout -p HEAD^' '
+test_expect_success PERL 'git checkout -p HEAD^' '
 	# the third n is to get out in case it mistakenly does not apply
 	(echo n; echo y; echo n) | git checkout -p HEAD^ &&
 	verify_saved_state bar &&
 	verify_state dir/foo parent parent
 '
=20
-test_expect_success 'git checkout -p handles deletion' '
+test_expect_success PERL 'git checkout -p handles deletion' '
 	set_state dir/foo work index &&
 	rm dir/foo &&
 	(echo n; echo y) | git checkout -p &&
@@ -79,28 +79,28 @@ test_expect_success 'git checkout -p handles deleti=
on' '
 # dir/foo.  There's always an extra 'n' to reject edits to dir/foo in
 # the failure case (and thus get out of the loop).
=20
-test_expect_success 'path limiting works: dir' '
+test_expect_success PERL 'path limiting works: dir' '
 	set_state dir/foo work head &&
 	(echo y; echo n) | git checkout -p dir &&
 	verify_saved_state bar &&
 	verify_state dir/foo head head
 '
=20
-test_expect_success 'path limiting works: -- dir' '
+test_expect_success PERL 'path limiting works: -- dir' '
 	set_state dir/foo work head &&
 	(echo y; echo n) | git checkout -p -- dir &&
 	verify_saved_state bar &&
 	verify_state dir/foo head head
 '
=20
-test_expect_success 'path limiting works: HEAD^ -- dir' '
+test_expect_success PERL 'path limiting works: HEAD^ -- dir' '
 	# the third n is to get out in case it mistakenly does not apply
 	(echo y; echo n; echo n) | git checkout -p HEAD^ -- dir &&
 	verify_saved_state bar &&
 	verify_state dir/foo parent parent
 '
=20
-test_expect_success 'path limiting works: foo inside dir' '
+test_expect_success PERL 'path limiting works: foo inside dir' '
 	set_state dir/foo work head &&
 	# the third n is to get out in case it mistakenly does not apply
 	(echo y; echo n; echo n) | (cd dir && git checkout -p foo) &&
@@ -108,7 +108,7 @@ test_expect_success 'path limiting works: foo insid=
e dir' '
 	verify_state dir/foo head head
 '
=20
-test_expect_success 'none of this moved HEAD' '
+test_expect_success PERL 'none of this moved HEAD' '
 	verify_saved_head
 '
=20
diff --git a/t/t3904-stash-patch.sh b/t/t3904-stash-patch.sh
index f37e3bc..d1819ca 100755
--- a/t/t3904-stash-patch.sh
+++ b/t/t3904-stash-patch.sh
@@ -3,7 +3,7 @@
 test_description=3D'git checkout --patch'
 . ./lib-patch-mode.sh
=20
-test_expect_success 'setup' '
+test_expect_success PERL 'setup' '
 	mkdir dir &&
 	echo parent > dir/foo &&
 	echo dummy > bar &&
@@ -19,14 +19,14 @@ test_expect_success 'setup' '
=20
 # note: bar sorts before dir, so the first 'n' is always to skip 'bar'
=20
-test_expect_success 'saying "n" does nothing' '
+test_expect_success PERL 'saying "n" does nothing' '
 	set_state dir/foo work index
 	(echo n; echo n) | test_must_fail git stash save -p &&
 	verify_state dir/foo work index &&
 	verify_saved_state bar
 '
=20
-test_expect_success 'git stash -p' '
+test_expect_success PERL 'git stash -p' '
 	(echo n; echo y) | git stash save -p &&
 	verify_state dir/foo head index &&
 	verify_saved_state bar &&
@@ -36,7 +36,7 @@ test_expect_success 'git stash -p' '
 	verify_state bar dummy dummy
 '
=20
-test_expect_success 'git stash -p --no-keep-index' '
+test_expect_success PERL 'git stash -p --no-keep-index' '
 	set_state dir/foo work index &&
 	set_state bar bar_work bar_index &&
 	(echo n; echo y) | git stash save -p --no-keep-index &&
@@ -48,7 +48,7 @@ test_expect_success 'git stash -p --no-keep-index' '
 	verify_state bar dummy bar_index
 '
=20
-test_expect_success 'none of this moved HEAD' '
+test_expect_success PERL 'none of this moved HEAD' '
 	verify_saved_head
 '
=20
diff --git a/t/t7105-reset-patch.sh b/t/t7105-reset-patch.sh
index c1f4fc3..4b629f7 100755
--- a/t/t7105-reset-patch.sh
+++ b/t/t7105-reset-patch.sh
@@ -41,27 +41,27 @@ test_expect_success 'git reset -p HEAD^' '
 # dir/foo.  There's always an extra 'n' to reject edits to dir/foo in
 # the failure case (and thus get out of the loop).
=20
-test_expect_success 'git reset -p dir' '
+test_expect_success PERL 'git reset -p dir' '
 	set_state dir/foo work work
 	(echo y; echo n) | git reset -p dir &&
 	verify_state dir/foo work head &&
 	verify_saved_state bar
 '
=20
-test_expect_success 'git reset -p -- foo (inside dir)' '
+test_expect_success PERL 'git reset -p -- foo (inside dir)' '
 	set_state dir/foo work work
 	(echo y; echo n) | (cd dir && git reset -p -- foo) &&
 	verify_state dir/foo work head &&
 	verify_saved_state bar
 '
=20
-test_expect_success 'git reset -p HEAD^ -- dir' '
+test_expect_success PERL 'git reset -p HEAD^ -- dir' '
 	(echo y; echo n) | git reset -p HEAD^ -- dir &&
 	verify_state dir/foo work parent &&
 	verify_saved_state bar
 '
=20
-test_expect_success 'none of this moved HEAD' '
+test_expect_success PERL 'none of this moved HEAD' '
 	verify_saved_head
 '
=20
--=20
1.7.2.1.338.gf2379
