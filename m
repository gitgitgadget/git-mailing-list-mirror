From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v3 4/4] t/t0000-basic.sh: Run the passing TODO test inside its own test-lib
Date: Thu, 19 Aug 2010 16:08:12 +0000
Message-ID: <1282234092-27429-5-git-send-email-avarab@gmail.com>
References: <1282138473-15613-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 19 18:08:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Om7fl-0001ab-9x
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 18:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752336Ab0HSQIn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Aug 2010 12:08:43 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58575 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090Ab0HSQIm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 12:08:42 -0400
Received: by mail-ww0-f44.google.com with SMTP id 17so2639812wwi.1
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 09:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=/SO4jFIRZA/Qb5/jVuceUy3F2WRppAGpjwDAHWbGd5E=;
        b=YXs6v+tZwAmmqubnxfgij/c28IU6uVH5jf9JChU5E0AFMmaq5OwDw/6x8MOj+XeSbq
         2/+LwH+zTsWkS05yzDbjVr0VZejlskzAkzdprSwYhTu3cxdR3st8q4RPlLSn9Th8GTrC
         LnXs11T44FeK60lh5eqgwaDk5VHre/0ETsTY0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=eXmd+TLXuPL3w4LSbcffRq06MBjxbNXlK5R5sSUSrfGflr5W57WdAVRZ3dC19u4NPv
         JhEdcqnieeKe2eqkKAA9G1Xd8gkeEJRhyRc95JQEBUgpcPbNobKk9Bt4xw/YVO8QUsdK
         GsXYaNNhg3kV+qZpPU6PZ6AIERbAluxyjRnKs=
Received: by 10.216.160.15 with SMTP id t15mr8981wek.75.1282234119058;
        Thu, 19 Aug 2010 09:08:39 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e8sm1118781wej.46.2010.08.19.09.08.38
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 19 Aug 2010 09:08:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.446.g168052
In-Reply-To: <1282138473-15613-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153940>

Change the passing TODO test in t0000-basic.sh to run inside its own
test-lib.sh. The motivation is to have nothing out of the ordinary on
a normal test run for test smoking purposes.

If every normal test run has a passing TODO you're more likely to turn
a blind eye to it and not to investigate cases where things really are
passing unexpectedly.

It also makes the prove(1) output less noisy. Before:

    All tests successful.

    Test Summary Report
    -------------------
    ./t0000-basic.sh                                   (Wstat: 0 Tests:=
 46 Failed: 0)
      TODO passed:   5
    Files=3D484, Tests=3D6229, 143 wallclock secs ( 4.00 usr  4.15 sys =
+ 104.77 cusr 351.57 csys =3D 464.49 CPU)
    Result: PASS

And after:

    All tests successful.
    Files=3D484, Tests=3D6228, 139 wallclock secs ( 4.07 usr  4.25 sys =
+ 104.54 cusr 350.85 csys =3D 463.71 CPU)
    Result: PASS

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t0000-basic.sh |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 9602085..f688bd3 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -54,9 +54,40 @@ test_expect_success 'success is reported like this' =
'
 test_expect_failure 'pretend we have a known breakage' '
     false
 '
+
+test_expect_success 'pretend we have fixed a known breakage (run in su=
b test-lib)' "
+    mkdir passing-todo &&
+    (cd passing-todo &&
+    cat >passing-todo.sh <<EOF &&
+#!$SHELL_PATH
+
+test_description=3D'A passing TODO test
+
+This is run in a sub test-lib so that we do not get incorrect passing
+metrics
+'
+
+# Point to the t/test-lib.sh, which isn't in ../ as usual
+TEST_DIRECTORY=3D\"$TEST_DIRECTORY\"
+. \"\$TEST_DIRECTORY\"/test-lib.sh
+
 test_expect_failure 'pretend we have fixed a known breakage' '
     :
 '
+
+test_done
+EOF
+    chmod +x passing-todo.sh &&
+    ./passing-todo.sh >out 2>err &&
+    ! test -s err &&
+cat >expect <<EOF &&
+ok 1 - pretend we have fixed a known breakage # TODO known breakage
+# fixed 1 known breakage(s)
+# passed all 1 test(s)
+1..1
+EOF
+    test_cmp expect out)
+"
 test_set_prereq HAVEIT
 haveit=3Dno
 test_expect_success HAVEIT 'test runs if prerequisite is satisfied' '
--=20
1.7.2.1.446.g168052
