From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/8] Add testcases showing how pathspecs are ignored with rev-list --objects
Date: Thu,  9 Sep 2010 01:50:20 +1000
Message-ID: <1283961023-4491-6-git-send-email-pclouds@gmail.com>
References: <1283961023-4491-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 09 05:23:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtXjF-0000Kq-0C
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 05:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200Ab0IIDXJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Sep 2010 23:23:09 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35424 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047Ab0IIDXG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 23:23:06 -0400
Received: by pzk34 with SMTP id 34so311287pzk.19
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 20:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Nn9X07xXlQnZ2kiRWjXPYhXD5a5OPt56Sk51xxpAS/k=;
        b=Ua8MU2/ozxLotdnQOcr/CwvftgzLa5ZpqtrAlvkXfPPtx8PYRaHDvSx4xpLzEqX3aW
         4zytqaosD/7fZeH3D55i21pl5HiYVXqPt7/vcNB4AVoZ0vd2//VpBI5pPaEsWqaC8xtO
         WsRUj3VxCyQHUOPEL0DD6FxcaQ+NLcD3daZFc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=DxPot5Ja+OCDuWogo5PjzRfNGXq57AsDvegehNr1M4FvBpgg2aYidsVLdwtF/igmR+
         dZ6GQkRSfAxA3uwDd0sTY2edY39WrhdPrqBztrAhqDuA8ZpHYq6WAR5i+R+lYNzzcJeM
         pN5FOovwMNsWYnQ6+pe9gxHsN/Yk7gtGRCpyU=
Received: by 10.114.112.16 with SMTP id k16mr703132wac.206.1284002584770;
        Wed, 08 Sep 2010 20:23:04 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id c24sm1312077wam.19.2010.09.08.20.23.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Sep 2010 20:23:03 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Thu,  9 Sep 2010 01:51:08 +1000
X-Mailer: git-send-email 1.7.1.rc1.70.g13aff
In-Reply-To: <1283961023-4491-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155834>

=46rom: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t6000-rev-list-misc.sh |   51 ++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)
 create mode 100755 t/t6000-rev-list-misc.sh

diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
new file mode 100755
index 0000000..b3c1dd8
--- /dev/null
+++ b/t/t6000-rev-list-misc.sh
@@ -0,0 +1,51 @@
+#!/bin/sh
+
+test_description=3D'miscellaneous rev-list tests'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo content1 >wanted_file &&
+	echo content2 >unwanted_file &&
+	git add wanted_file unwanted_file &&
+	git commit -m one
+'
+
+test_expect_failure 'rev-list --objects heeds pathspecs' '
+	git rev-list --objects HEAD -- wanted_file >output &&
+	grep wanted_file output &&
+	! grep unwanted_file output
+'
+
+test_expect_failure 'rev-list --objects with pathspecs and deeper path=
s' '
+	mkdir foo &&
+	>foo/file &&
+	git add foo/file &&
+	git commit -m two &&
+
+	git rev-list --objects HEAD -- foo >output &&
+	grep foo/file output &&
+
+	git rev-list --objects HEAD -- foo/file >output &&
+	grep foo/file output &&
+	! grep unwanted_file output
+'
+
+test_expect_failure 'rev-list --objects with pathspecs and copied file=
s' '
+	git checkout --orphan junio-testcase &&
+	git rm -rf . &&
+
+	mkdir two &&
+	echo frotz >one &&
+	cp one two/three &&
+	git add one two/three &&
+	test_tick &&
+	git commit -m that &&
+
+	ONE=3D$(git rev-parse HEAD:one)
+	git rev-list --objects HEAD two >output &&
+	grep "$ONE two/three" output &&
+	! grep one output
+'
+
+test_done
--=20
1.7.1.rc1.70.g13aff
