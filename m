From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/4] Add testcases showing how pathspecs are ignored with rev-list --objects
Date: Mon,  6 Sep 2010 14:47:06 +1000
Message-ID: <1283748429-31076-2-git-send-email-pclouds@gmail.com>
References: <1283645647-1891-8-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 06:47:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsTcG-0001Nt-84
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 06:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021Ab0IFErZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 00:47:25 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51923 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001Ab0IFErY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 00:47:24 -0400
Received: by pwi3 with SMTP id 3so983840pwi.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 21:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=NgB5oncu3FpXLvE0D/1aG5n+XnmsXTPxapdOlypVdI8=;
        b=RE6DgQ4bsouVu3ROkUCQzmiZDjMLXbiCsSOyeoyYmM9w/U6KoxGUvdzT99fpCIP10A
         M3l9IUaP3g/jd5pMeyfYoHY0lgUpG+br8K0LRoYv/Q1kPbD1m3tQ9JCp1nRYuwR08iZN
         rTyapGu7feZGuouAIQZFlIbAGXln2m/0IyhFI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=m2VM0IM2tMR5FbDeCi4pjp79PUlkYrwn7BAv42I+KcHnz12BE1eHczyvR7fpJSHs3X
         1qrVsaSHruwisc4aqUfUtqxo8ik3YXazP5SCyUcInELE9s81+dIKFecLuJRIuBTlscSD
         nyl1jFYbydeeaElh1edS3rVO/WbpudPZ3J3L8=
Received: by 10.114.111.9 with SMTP id j9mr3152885wac.178.1283748443889;
        Sun, 05 Sep 2010 21:47:23 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id r37sm10431244wak.11.2010.09.05.21.47.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Sep 2010 21:47:22 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  6 Sep 2010 14:47:17 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1283645647-1891-8-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155523>

=46rom: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 No changes.

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
1.7.1.rc1.69.g24c2f7
