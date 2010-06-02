From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC v4 6/7] gettext: Sanity tests for Git's Gettext support
Date: Wed,  2 Jun 2010 01:06:03 +0000
Message-ID: <1275440764-26153-7-git-send-email-avarab@gmail.com>
References: <AANLkTimhxqGRPjYz-k5f-LTIk6KajEwUuGJWt-dAKZQT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 02 03:06:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJcPq-0004k8-TN
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 03:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757514Ab0FBBG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 21:06:28 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55589 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757504Ab0FBBGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 21:06:25 -0400
Received: by mail-fx0-f46.google.com with SMTP id 8so1482447fxm.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 18:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=0u53Eqn0j7qyy11UPw2dJKqZ75oMKU0tBZdEKLDnF3w=;
        b=O887SFwABS85fiboT0jcbBLdG/xOtFB0JfJdGU76m5Ui998CAEHWpgaSHlk5zIntgK
         d+5Cs3uOu6I9pggH4KGmZh4djbs7HAqWD+MPUn/MY0gIMWtPaRF2brvPK56RyY2pTFDV
         l62QvvBSf9U+E/QHj4IkNXAXX1JHIyu9UmR2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UqolEFqA6Trgh88tetv4vbUfmn3uCna5zYSr6bpdU3bw+CX5QN0Wx7uDIvLpc0NxaR
         Ed3wOvTiezaM6FW7NBMaVzwG0vuewr1f8/9mytmSyEc/ribOEyFbPJTHpq+siUTutRjy
         p1TYqS6wn7YDRkP9jV5v7N4nZV4J6ELI9pRfI=
Received: by 10.223.60.3 with SMTP id n3mr7854535fah.83.1275440784700;
        Tue, 01 Jun 2010 18:06:24 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id 13sm49688716fad.7.2010.06.01.18.06.22
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 18:06:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.gec7f5.dirty
In-Reply-To: <AANLkTimhxqGRPjYz-k5f-LTIk6KajEwUuGJWt-dAKZQT@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148186>

These tests check if Git's C, Shell and Perl wrappers for Gettext are
working.
---
 t/t0200-gettext.sh |   73 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 73 insertions(+), 0 deletions(-)
 create mode 100755 t/t0200-gettext.sh

diff --git a/t/t0200-gettext.sh b/t/t0200-gettext.sh
new file mode 100755
index 0000000..ff2f9f9
--- /dev/null
+++ b/t/t0200-gettext.sh
@@ -0,0 +1,73 @@
+#!/bin/sh
+D=3D`pwd`
+export GIT_TEXTDOMAINDIR=3D$D/../share/locale
+
+test_description=3D'Gettext support for Git'
+. ./test-lib.sh
+. ../../git-sh-setup
+
+test_expect_success 'sanity: $TEXTDOMAIN is git' '
+    test $TEXTDOMAIN =3D "git"
+'
+
+test_expect_success 'sanity: $TEXTDOMAINDIR exists' '
+    test -d $TEXTDOMAINDIR &&
+    test $TEXTDOMAINDIR =3D $GIT_TEXTDOMAINDIR
+'
+
+test_expect_success 'sanity: Icelandic locale was compiled' '
+    test -f $TEXTDOMAINDIR/is/LC_MESSAGES/git.mo
+'
+
+test_expect_success 'sanity: gettext("") metadata is OK' '
+    LC_ALL=3Dis_IS.UTF-8 gettext "" > expect &&
+    grep "Project-Id-Version: Git" expect &&
+    grep "Git Mailing List <git@vger.kernel.org>" expect &&
+    grep "Content-Type: text/plain; charset=3DUTF-8" expect &&
+    grep "Content-Transfer-Encoding: 8bit" expect
+'
+
+test_expect_success 'sanity: gettext(unknown) is passed through' '
+    printf "This is not a translation string"  > expect
+    gettext "This is not a translation string" > actual &&
+    test_cmp expect actual
+'
+
+test_expect_success 'sanity: C program git-status reads our message ca=
talog ' '
+    > foo &&
+    test_commit foo "a message"
+    git checkout -b topic/gettext-testing &&
+    git status | grep topic/gettext-testing > expect
+    echo "# On branch topic/gettext-testing" > actual
+    test_cmp expect actual &&
+    LC_ALL=3Dis_IS.UTF-8 git status | grep topic/gettext-testing > exp=
ect
+    echo "# =C3=81 greininni topic/gettext-testing" > actual
+    test_cmp expect actual
+'
+
+test_expect_success 'sanity: Perl program Git::I18N reads our message =
catalog ' '
+    echo "On branch " > expect &&
+    perl -I"$D/../perl" -MGit::I18N -le "print gettext(q[On branch ])"=
 > actual &&
+    test_cmp expect actual &&
+
+    echo "=C3=81 greininni " > expect &&
+    LC_ALL=3Dis_IS.UTF-8 perl -I"$D/../perl" -MGit::I18N -le "print ge=
ttext(q[On branch ])" > actual &&
+    test_cmp expect actual
+'
+
+test_expect_success 'Setup another Git repository for testing' '
+    mkdir parent &&
+    (cd parent && git init &&
+     echo one >file && git add file &&
+     git commit -m one)
+'
+
+test_expect_success 'sanity: Shell program git-pull reads our message =
catalog' '
+    cd parent &&
+    (git pull --tags "../" >out 2>err || :) &&
+    grep "Fetching tags only" err &&
+    (LC_ALL=3Dis_IS.UTF-8 git pull --tags "../" >out 2>err || :) &&
+    grep "N=C3=A6 a=C3=B0eins =C3=AD" err=20
+'
+
+test_done
--=20
1.7.1.251.gec7f5.dirty
