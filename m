From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/25] list-files: new indicator '&' for submodules when -F is used
Date: Mon,  6 Apr 2015 20:52:22 +0700
Message-ID: <1428328354-14897-14-git-send-email-pclouds@gmail.com>
References: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: 1425896314-10941-1-git-send-email-pclouds@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 15:54:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yf7TZ-0005Zz-T2
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 15:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753417AbbDFNyA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 09:54:00 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36471 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313AbbDFNyA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 09:54:00 -0400
Received: by pabsx10 with SMTP id sx10so45108823pab.3
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 06:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=UA4SQg8TD3LRdRZcMfSsYaejaBE2DjnZRYiBUyDVkvA=;
        b=sRnKLmckepxYz/3nriKCyTAWl7nCAyNlGHWtXKgOYSOg0lgHtBETahi11zKax1Htt9
         y55gkJ9p7Wvr8xqPnaaZxyT73J87PcUD8uTk/Ao+xLr6h6But1QYXwuGncjdLdejJh4I
         4wLDX9RC3HSf8ewtiHD8gYIOSLFCIYhmt88rheCDjRcF4rPtDRwWcKuagQKfA/7jlU+L
         qdd05vOnhvutt/vvl6odFKIl82SDZZGvdj0P268bLZl0KvoJZJMfZWqCJ1g+66GDzpTH
         TuQR5/A6C8Di14lR5EWZOgrgci30nl6fkbXcEl0iAvuCM9DIDfSncnsdO5+nSPsOpel4
         9/mw==
X-Received: by 10.70.43.225 with SMTP id z1mr14008169pdl.45.1428328439917;
        Mon, 06 Apr 2015 06:53:59 -0700 (PDT)
Received: from lanh ([115.73.245.217])
        by mx.google.com with ESMTPSA id u8sm3241381pdj.46.2015.04.06.06.53.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2015 06:53:59 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 06 Apr 2015 20:54:11 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266858>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/list-files.c  | 2 ++
 t/t7013-list-files.sh | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/list-files.c b/builtin/list-files.c
index 31f1f25..7c18848 100644
--- a/builtin/list-files.c
+++ b/builtin/list-files.c
@@ -221,6 +221,8 @@ static void append_indicator(struct strbuf *sb, mod=
e_t mode)
 		c =3D '|';
 	else if (S_ISSOCK(mode))
 		c =3D '=3D';
+	else if (S_ISGITLINK(mode))
+		c =3D '&';
 #ifdef S_ISDOOR
 	else if (S_ISDOOR(mode))
 		c =3D '>';
diff --git a/t/t7013-list-files.sh b/t/t7013-list-files.sh
index 16d000e..37dd403 100755
--- a/t/t7013-list-files.sh
+++ b/t/t7013-list-files.sh
@@ -161,7 +161,7 @@ test_expect_success '--classify' '
 	cat >expected <<-\EOF &&
 	dir/
 	file
-	gitlink
+	gitlink&
 	EOF
 	test_cmp expected actual
 	)
--=20
2.3.0.rc1.137.g477eb31
