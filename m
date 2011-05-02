From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] t1011: fix sparse-checkout initialization and add new file
Date: Mon,  2 May 2011 19:47:43 +0700
Message-ID: <1304340464-14829-2-git-send-email-pclouds@gmail.com>
References: <1304340464-14829-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: skillzero@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 02 14:51:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGsaV-0006bt-Dc
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 14:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758023Ab1EBMuu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2011 08:50:50 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:46438 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756303Ab1EBMut (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 08:50:49 -0400
Received: by pwi15 with SMTP id 15so2650894pwi.19
        for <git@vger.kernel.org>; Mon, 02 May 2011 05:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=BwrfI2kC+aFrBKk/6P87YX980WFT77Zy4y3RvfxeORA=;
        b=Q08bug/qRoHj/b+fctepfoekFdpTyl417LPCVQjHXVKtBgQiN5Gkt+tchJ9MjmUsPC
         zwGn0jN8uUZHiJqVTheN29BqR4FvI/mtYegNYdE1NvZV+df8KIslO4AOP953QVoOwaHM
         fAbA5eTC2tbEEOULEfmEZNAwznbxsqutBx4NM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=EupHeLKgdFQ2wPycqoiIU43lj8LnLcPnFiIqpxe6rCmsemAAKqSNpRjdi21bT9ek2u
         gL4s5HW+XTg85YOmYCw5JiDiY8uPhhVgb0yf978FQfCyk1cwcAiYPCIuwgPX4zmDeXJl
         EO12uHpNHX4o4zj9cTq/Zu6qcWg6UzSlyXXCs=
Received: by 10.68.43.99 with SMTP id v3mr442362pbl.387.1304340649265;
        Mon, 02 May 2011 05:50:49 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.248.91])
        by mx.google.com with ESMTPS id i7sm3805588pbs.7.2011.05.02.05.50.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 02 May 2011 05:50:47 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 02 May 2011 19:47:55 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1304340464-14829-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172580>

Do not append to $GIT_DIR/info/sparse-checkout at each test, overwrite
it instead.

Also add sub/addedtoo for more complex tests later on

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1011-read-tree-sparse-checkout.sh |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-s=
parse-checkout.sh
index de84e35..3f9d66f 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -17,19 +17,21 @@ test_expect_success 'setup' '
 	cat >expected <<-\EOF &&
 	100644 77f0ba1734ed79d12881f81b36ee134de6a3327b 0	init.t
 	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	sub/added
+	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	sub/addedtoo
 	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	subsub/added
 	EOF
 	cat >expected.swt <<-\EOF &&
 	H init.t
 	H sub/added
+	H sub/addedtoo
 	H subsub/added
 	EOF
=20
 	test_commit init &&
 	echo modified >>init.t &&
 	mkdir sub subsub &&
-	touch sub/added subsub/added &&
-	git add init.t sub/added subsub/added &&
+	touch sub/added sub/addedtoo subsub/added &&
+	git add init.t sub/added sub/addedtoo subsub/added &&
 	git commit -m "modified and added" &&
 	git tag top &&
 	git rm sub/added &&
@@ -83,6 +85,7 @@ test_expect_success 'match directories with trailing =
slash' '
 	cat >expected.swt-noinit <<-\EOF &&
 	S init.t
 	H sub/added
+	H sub/addedtoo
 	S subsub/added
 	EOF
=20
@@ -95,7 +98,7 @@ test_expect_success 'match directories with trailing =
slash' '
 '
=20
 test_expect_success 'match directories without trailing slash' '
-	echo sub >>.git/info/sparse-checkout &&
+	echo sub >.git/info/sparse-checkout &&
 	git read-tree -m -u HEAD &&
 	git ls-files -t >result &&
 	test_cmp expected.swt-noinit result &&
@@ -104,7 +107,7 @@ test_expect_success 'match directories without trai=
ling slash' '
 '
=20
 test_expect_success 'match directory pattern' '
-	echo "s?b" >>.git/info/sparse-checkout &&
+	echo "s?b" >.git/info/sparse-checkout &&
 	git read-tree -m -u HEAD &&
 	git ls-files -t >result &&
 	test_cmp expected.swt-noinit result &&
@@ -116,6 +119,7 @@ test_expect_success 'checkout area changes' '
 	cat >expected.swt-nosub <<-\EOF &&
 	H init.t
 	S sub/added
+	S sub/addedtoo
 	S subsub/added
 	EOF
=20
--=20
1.7.4.74.g639db
