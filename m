From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/7] Fix tests under GETTEXT_POISON on relative dates
Date: Tue, 21 Aug 2012 11:30:58 +0700
Message-ID: <1345523464-14586-2-git-send-email-pclouds@gmail.com>
References: <1345523464-14586-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 21 06:32:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3g8Y-0006os-RN
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 06:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390Ab2HUEcO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Aug 2012 00:32:14 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62578 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079Ab2HUEbi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 00:31:38 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so7914089pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 21:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=SJpl2fw41KDxvKhRnZU1s4ylnK7NXQJl2WCvvIeagkY=;
        b=BbOdd7w6FSqeeDyHHpy765WB7/4o+NI5td6DvBz0DCOR5ezKyIM8eF3Ef0/KGabJnQ
         LEL62OGtI15SxaAnMIJuNNjCuOCJ35YKPKIFclkt7BJQOWrxKynkrL+XECkBFG/kQQuU
         SUlMVPlyz8P3Kri4IT/Zd7t1PMWbj10WTYRQ1xWiy0KZdxlIrWeZvOrYYdY4SE1+mur2
         97zBh4P7wxAw+Kb3fsGk683CLdww69WeAp5XfPrht5SGB0qMKNvzYIv+4LsWqLRgXJT+
         Xoz8ORSB9WAmfOjyGsykkxbHst26cxZWykf2WaDGxwtn+K2XFyaQYpN6FDzZOrRCF5lS
         mjyg==
Received: by 10.66.75.104 with SMTP id b8mr34954769paw.21.1345523498528;
        Mon, 20 Aug 2012 21:31:38 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id pq1sm602300pbb.3.2012.08.20.21.31.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 21:31:37 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 21 Aug 2012 11:31:22 +0700
X-Mailer: git-send-email 1.7.12.rc2
In-Reply-To: <1345523464-14586-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203928>

=46rom: Jiang Xin <worldhello.net@gmail.com>

Use a i18n-specific test_i18ncmp in t/t0006-data.sh for relative dates
tests. This issue was was introduced in v1.7.10-230-g7d29a:

    7d29a i18n: mark relative dates for translation

and been broken under GETTEXT_POISON=3DYesPlease since.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t0006-date.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 1d29810..e53cf6d 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -11,7 +11,7 @@ check_show() {
 	echo "$t -> $2" >expect
 	test_expect_${3:-success} "relative date ($2)" "
 	test-date show $t >actual &&
-	test_cmp expect actual
+	test_i18ncmp expect actual
 	"
 }
=20
--=20
1.7.12.rc2
