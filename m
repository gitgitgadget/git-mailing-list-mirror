From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 2/7] t/t5705-clone-2gb: change from skip_all=* to prereq skip
Date: Tue, 10 Aug 2010 19:52:43 +0000
Message-ID: <1281469968-25670-3-git-send-email-avarab@gmail.com>
References: <1281469968-25670-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 10 21:53:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oiusz-0008HM-W7
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 21:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754830Ab0HJTxJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 15:53:09 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52267 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754530Ab0HJTxG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 15:53:06 -0400
Received: by wyb32 with SMTP id 32so1089905wyb.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 12:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=9OoB9UGUQgPrPxRHMBgCH5+j6mm+T0NxEJq1RU6PL+o=;
        b=flL+3f7VQNU0MVcGYRFBnYO4MV1q3gDQtlBGtwYPvaf3dmSGKTKvB/dvpdYYHUxYZg
         gZfkJT0hBuNtNax/5MfH06YSx82kv1RdU1HAJjLzy6DOt+35EaTXmaI6EUoWa6png9qB
         /O+DuEiDEJXgU6pNbkplHiDZdHxKuIiLp3stQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=kLiSMYIQKS0PdaFr8tDXkUs9xjq/vZMPBmijwcMb+986haqDzI33lfszQlaaEuWTdy
         Uewc54M5URFStTGSZIAr2FIZ7SR5yCaMWw9sfwo+7iTXXFcwuoW/AM+gayN0i1AIoAaD
         1xu5IQcF/xD2gEMJEXUvT3aXe1kQf/Oq58LP4=
Received: by 10.227.157.84 with SMTP id a20mr14556852wbx.32.1281469985524;
        Tue, 10 Aug 2010 12:53:05 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id p45sm3602981weq.21.2010.08.10.12.53.02
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Aug 2010 12:53:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.295.gd03d
In-Reply-To: <1281469968-25670-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153146>

Change this test to skip test with test prerequisites, and to do setup
work in tests. This improves the skipped statistics on platforms where
the test isn't run.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t5705-clone-2gb.sh |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/t/t5705-clone-2gb.sh b/t/t5705-clone-2gb.sh
index e4d1b6a..694e28d 100755
--- a/t/t5705-clone-2gb.sh
+++ b/t/t5705-clone-2gb.sh
@@ -3,12 +3,9 @@
 test_description=3D'Test cloning a repository larger than 2 gigabyte'
 . ./test-lib.sh
=20
-test -z "$GIT_TEST_CLONE_2GB" &&
-skip_all=3D"Skipping expensive 2GB clone test; enable it with GIT_TEST=
_CLONE_2GB=3Dt" &&
-test_done &&
-exit
+test -n "$GIT_TEST_CLONE_2GB" && test_set_prereq CLONE_2GB
=20
-test_expect_success 'setup' '
+test_expect_success CLONE_2GB 'setup' '
=20
 	git config pack.compression 0 &&
 	git config pack.depth 0 &&
@@ -36,13 +33,13 @@ test_expect_success 'setup' '
=20
 '
=20
-test_expect_success 'clone - bare' '
+test_expect_success CLONE_2GB 'clone - bare' '
=20
 	git clone --bare --no-hardlinks . clone-bare
=20
 '
=20
-test_expect_success 'clone - with worktree, file:// protocol' '
+test_expect_success CLONE_2GB 'clone - with worktree, file:// protocol=
' '
=20
 	git clone file://. clone-wt
=20
--=20
1.7.2.1.295.gd03d
