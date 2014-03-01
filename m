From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 11/27] git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
Date: Sat,  1 Mar 2014 19:12:47 +0700
Message-ID: <1393675983-3232-12-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 13:22:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJivb-000264-Rj
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 13:22:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799AbaCAMV6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Mar 2014 07:21:58 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:54673 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429AbaCAMV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 07:21:57 -0500
Received: by mail-pa0-f51.google.com with SMTP id kq14so1929503pab.10
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 04:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=CfinsYHbp9mjCE/lgXyvLA6bs+HQpWLMyh7YD0s5m0c=;
        b=HBwupl25qTRqT0I1CpvsGcY2DXXZv+T8MNpj/P1APfaX8gWLj4IGmlzQFcm4BE7K0S
         aRff/FSF6mwraG0wSAGzllkzI3X79efemZJ0YiXcEVtYaeTnJjE2t4p6UJ/Dnoimlyxu
         IZOFBHSrw/f95x7TR4dLODAoMVUseeFAuKaPWUleDab5Bsl3ZFjQpZYkFrTh+o0Apmeg
         06RM3Ho5LP0ouMARvQ1ASiZKobCJ/0PqrZXCfYv9idYoutcFe8+CxvHgvvbC4QAFBAM5
         QnmRgyQue+5atvEPxZp1TQWV10I+Z+sQ0XLv6mq3LJG5IZs6u17wp7LYE26pKRDQrT2f
         GNdw==
X-Received: by 10.68.138.165 with SMTP id qr5mr9275172pbb.123.1393676517212;
        Sat, 01 Mar 2014 04:21:57 -0800 (PST)
Received: from lanh ([115.73.238.45])
        by mx.google.com with ESMTPSA id c7sm15937311pbt.0.2014.03.01.04.21.53
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Mar 2014 04:21:56 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 01 Mar 2014 19:22:22 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243076>

If $GIT_COMMON_DIR is set, $GIT_OBJECT_DIRECTORY should be
$GIT_COMMON_DIR/objects, not $GIT_DIR/objects. Just let rev-parse
--git-path handle it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git-sh-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index fffa3c7..475ca43 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -343,7 +343,7 @@ then
 		echo >&2 "Unable to determine absolute path of git directory"
 		exit 1
 	}
-	: ${GIT_OBJECT_DIRECTORY=3D"$GIT_DIR/objects"}
+	: ${GIT_OBJECT_DIRECTORY=3D"$(git rev-parse --git-path objects)"}
 fi
=20
 peel_committish () {
--=20
1.9.0.40.gaa8c3ea
