From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 10/10] t/t9602-cvsimport-branches-tags.sh: Add a PERL prerequisite
Date: Fri, 13 Aug 2010 20:40:13 +0000
Message-ID: <1281732013-18284-11-git-send-email-avarab@gmail.com>
References: <1281732013-18284-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 13 22:41:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok149-0007V9-Uh
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 22:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756038Ab0HMUlU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 16:41:20 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50532 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755793Ab0HMUlS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 16:41:18 -0400
Received: by mail-wy0-f174.google.com with SMTP id 32so3042131wyb.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 13:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=RDBQOgR2M47v2y9P3vfI7VXlx3+QPEN6kew+VDdFUOo=;
        b=S/TVAFRX3jfXHkjgWkV8HRfwUtmrb4tQYPj1lbrC6trOLJ6f1O9b/FZMbfnv32Rph3
         fA/atSOqNLZb/v7QqPPfA6XN60HKA9cwnK0kvUA0AGlSTwygqUaqYNHDv0F1k8Ff1+Dw
         QHdjRHL6yxFMQ/3WAxWBlVNEx+nWa2BBxGVMg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=XQK3smfxMKOUCk66/URkZ6B5nP6HAfqJ7rjHI8J/fgWa5dmv2v81nCsCPMYnCXkFzU
         r4mW5rez8HXwnipPKc117YI+xLfDk5/sScflIElnTGkDjqUcw8vHsNBO6dVZ3eObPFUN
         UHB9J1b2nGIDZQfXIyH02JFPUDBPVKYSfov00=
Received: by 10.216.188.81 with SMTP id z59mr1671891wem.106.1281732077398;
        Fri, 13 Aug 2010 13:41:17 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e8sm1838298wej.46.2010.08.13.13.41.15
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 13 Aug 2010 13:41:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.338.gf2379
In-Reply-To: <1281732013-18284-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153501>

Change this test to declare a PERL prerequisite. These tests use the
-p switch, so they implicitly depend on Perl code, but nothing was
declaring this.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t9602-cvsimport-branches-tags.sh |   28 +++++++++++++++-------------
 1 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/t/t9602-cvsimport-branches-tags.sh b/t/t9602-cvsimport-bra=
nches-tags.sh
index 67878b2..89da4ae 100755
--- a/t/t9602-cvsimport-branches-tags.sh
+++ b/t/t9602-cvsimport-branches-tags.sh
@@ -6,70 +6,72 @@
 test_description=3D'git cvsimport handling of branches and tags'
 . ./lib-cvs.sh
=20
-CVSROOT=3D"$TEST_DIRECTORY"/t9602/cvsroot
-export CVSROOT
+test_expect_success PERL 'setup CVSROOT' '
+	CVSROOT=3D"$TEST_DIRECTORY"/t9602/cvsroot &&
+	export CVSROOT
+'
=20
-test_expect_success 'import module' '
+test_expect_success PERL 'import module' '
=20
 	git cvsimport -C module-git module
=20
 '
=20
-test_expect_success 'test branch master' '
+test_expect_success PERL 'test branch master' '
=20
 	test_cmp_branch_tree master
=20
 '
=20
-test_expect_success 'test branch vendorbranch' '
+test_expect_success PERL 'test branch vendorbranch' '
=20
 	test_cmp_branch_tree vendorbranch
=20
 '
=20
-test_expect_failure 'test branch B_FROM_INITIALS' '
+test_expect_failure PERL 'test branch B_FROM_INITIALS' '
=20
 	test_cmp_branch_tree B_FROM_INITIALS
=20
 '
=20
-test_expect_failure 'test branch B_FROM_INITIALS_BUT_ONE' '
+test_expect_failure PERL 'test branch B_FROM_INITIALS_BUT_ONE' '
=20
 	test_cmp_branch_tree B_FROM_INITIALS_BUT_ONE
=20
 '
=20
-test_expect_failure 'test branch B_MIXED' '
+test_expect_failure PERL 'test branch B_MIXED' '
=20
 	test_cmp_branch_tree B_MIXED
=20
 '
=20
-test_expect_success 'test branch B_SPLIT' '
+test_expect_success PERL 'test branch B_SPLIT' '
=20
 	test_cmp_branch_tree B_SPLIT
=20
 '
=20
-test_expect_failure 'test tag vendortag' '
+test_expect_failure PERL 'test tag vendortag' '
=20
 	test_cmp_branch_tree vendortag
=20
 '
=20
-test_expect_success 'test tag T_ALL_INITIAL_FILES' '
+test_expect_success PERL 'test tag T_ALL_INITIAL_FILES' '
=20
 	test_cmp_branch_tree T_ALL_INITIAL_FILES
=20
 '
=20
-test_expect_failure 'test tag T_ALL_INITIAL_FILES_BUT_ONE' '
+test_expect_failure PERL 'test tag T_ALL_INITIAL_FILES_BUT_ONE' '
=20
 	test_cmp_branch_tree T_ALL_INITIAL_FILES_BUT_ONE
=20
 '
=20
-test_expect_failure 'test tag T_MIXED' '
+test_expect_failure PERL 'test tag T_MIXED' '
=20
 	test_cmp_branch_tree T_MIXED
=20
--=20
1.7.2.1.338.gf2379
