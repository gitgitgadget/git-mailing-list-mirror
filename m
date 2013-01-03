From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/5] t4014: a few more tests on cover letter using branch description
Date: Thu,  3 Jan 2013 21:03:09 +0700
Message-ID: <1357221791-7496-4-git-send-email-pclouds@gmail.com>
References: <1357221791-7496-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 03 15:04:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqlOq-0001Rf-UK
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 15:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753594Ab3ACOD3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jan 2013 09:03:29 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:53732 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753575Ab3ACODZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 09:03:25 -0500
Received: by mail-pa0-f54.google.com with SMTP id bi5so8605572pad.13
        for <git@vger.kernel.org>; Thu, 03 Jan 2013 06:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=gVpS3sOikWnj15lzs8yNJoUzFqOLXlRe071fwVdgH/I=;
        b=psKSKQqvPwkJAaGB4lN2qbQF7he2C5CTpMeJupCi4jWKC2MeP3rz5O41TCjOimjQRe
         sBZmZm0gUlIMQGr80rdHTQx+gEJEoNKeX6RtRS9HxFCljUoIaC3YyKUAywnyT0A70Vz1
         WDeYqGv1/W36WnDHaxwVcCcd7JEOMcEeF2fOzzx7jCbYawPS3dYo7i1gTcRKP0ptES/p
         SJev3Y2k5LgR7Of1GTDeKdOuVG3ZszfpL9qoLzrbo8vMe4xzipu8LjwawPOvwV0CkrE4
         VTmGI5sykMdAWBQM63gjYbtzToN1ylExUNva84fW4ok8QDDqwwUFvQz1ASyeMueWFxJD
         sv0w==
X-Received: by 10.68.253.161 with SMTP id ab1mr134113801pbd.97.1357221804929;
        Thu, 03 Jan 2013 06:03:24 -0800 (PST)
Received: from lanh ([115.74.34.31])
        by mx.google.com with ESMTPS id n10sm20652439pav.18.2013.01.03.06.03.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 Jan 2013 06:03:24 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 03 Jan 2013 21:03:31 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357221791-7496-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212586>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t4014-format-patch.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 16a4ca1..ec9ef9e 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -963,4 +963,25 @@ test_expect_success 'format patch ignores color.ui=
' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'cover letter using branch description (1)' '
+	git checkout rebuild-1 &&
+	test_config branch.rebuild-1.description hello &&
+	git format-patch --stdout --cover-letter master >actual &&
+	grep hello actual >/dev/null
+'
+
+test_expect_success 'cover letter using branch description (2)' '
+	git checkout rebuild-1 &&
+	test_config branch.rebuild-1.description hello &&
+	git format-patch --stdout --cover-letter rebuild-1~2..rebuild-1 >actu=
al &&
+	grep hello actual >/dev/null
+'
+
+test_expect_success 'cover letter using branch description (3)' '
+	git checkout rebuild-1 &&
+	test_config branch.rebuild-1.description hello &&
+	git format-patch --stdout --cover-letter ^master rebuild-1 >actual &&
+	grep hello actual >/dev/null
+'
+
 test_done
--=20
1.8.0.rc2.23.g1fb49df
