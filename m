From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 1/7] Fix tests under GETTEXT_POISON on relative dates
Date: Mon, 27 Aug 2012 13:36:49 +0800
Message-ID: <1b42b555cd785e19e95c730ac00271a2fee64edb.1346045253.git.worldhello.net@gmail.com>
References: <cover.1346045253.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 07:37:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5s0l-0002tw-1J
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 07:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985Ab2H0FhL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Aug 2012 01:37:11 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57439 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882Ab2H0FhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 01:37:09 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6802416pbb.19
        for <git@vger.kernel.org>; Sun, 26 Aug 2012 22:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=K+wNqRrPNdNxjVkBMz4xxVL3ZbrWui+dWPoN1Z4IrMo=;
        b=bQG4Tf1Jf+E1iBARDhJLv2PwQv6+avp8OJjprVusciYTtkS8uR8d/bo0fWvUUJRZ8P
         x5H4lk3uPHXSRNLoSIXnE39m4463QXKa5sHHBGtt+Ydm9ZVA+h4jo5M3eQUng34UzHY4
         5eMCCwAz9JISIv5XXcD9kf8oJ3PlTx5eFRT/PKlrfBmmlBsK1e+o7rrMJzcbw1mLBz9B
         /fmtmJ/cKk0YsVre4cypPa6JcJU21axps7pZ8wztQ9xPHg58gjK/OYemnDxN4cYQYQ84
         qGK31ZKsTEyzpC8mCvG4HNddGt3YNlTKsRahyLcCtQml3l9xmn67LUBzH+bKa+oPzvzM
         86BA==
Received: by 10.68.138.234 with SMTP id qt10mr31493300pbb.26.1346045829456;
        Sun, 26 Aug 2012 22:37:09 -0700 (PDT)
Received: from localhost.foo.bar ([123.116.231.150])
        by mx.google.com with ESMTPS id gf3sm13924207pbc.74.2012.08.26.22.37.04
        (version=SSLv3 cipher=OTHER);
        Sun, 26 Aug 2012 22:37:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.92.gaa91cb5
In-Reply-To: <cover.1346045253.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1346045253.git.worldhello.net@gmail.com>
References: <1345523464-14586-1-git-send-email-pclouds@gmail.com> <cover.1346045253.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204320>

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
index 1d29..e53cf 100755
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
1.7.12.92.gaa91cb5
