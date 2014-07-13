From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 12/31] git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
Date: Sun, 13 Jul 2014 11:50:49 +0700
Message-ID: <1405227068-25506-13-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
 <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 13 06:54:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6Bnm-00005Q-6x
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 06:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752765AbaGMEyO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jul 2014 00:54:14 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:43968 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633AbaGMEyL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 00:54:11 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so3554559pab.8
        for <git@vger.kernel.org>; Sat, 12 Jul 2014 21:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=y4fjiYOCRQyT1y3KXCYFMRdCUViRVbjaw2FcmxnpjJY=;
        b=S+aLMhrb8FKc/06JSPqgmC/KoQC6v7qK27p9AJ5zTm9zi5PdN7zavQ+FMUKIsbflhG
         pJe9jT6T1TChhIH+ruQ+/cB6csieagZ1LsBZ1KkoKXozxAS1GIC3j+9gJ4QynWmkJMXk
         itf9/hOajwRKbMwD4sw6JGy7yEs2GIGXF3iB98SV74qEbwXtsWkCTcy53383f54v5yXl
         lu3TBmTY97OZu0QBuZUU6Ho5sV0wInAYZbR1Er9vs+rRHBif7k8OWEsM7/rvwVVjRsO1
         BLDRF+ni1RkzDRWPQ7eeYMk3f7zDhA919zOCy0N+67kAbM8a7yoODaBxwOLItIC1JqeC
         zvKw==
X-Received: by 10.70.91.170 with SMTP id cf10mr8946807pdb.72.1405227251400;
        Sat, 12 Jul 2014 21:54:11 -0700 (PDT)
Received: from lanh ([115.73.227.1])
        by mx.google.com with ESMTPSA id wt2sm6737622pbc.93.2014.07.12.21.54.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jul 2014 21:54:10 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jul 2014 11:54:11 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253415>

If $GIT_COMMON_DIR is set, $GIT_OBJECT_DIRECTORY should be
$GIT_COMMON_DIR/objects, not $GIT_DIR/objects. Just let rev-parse
--git-path handle it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git-sh-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 9447980..d3dbb2f 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -345,7 +345,7 @@ then
 		echo >&2 "Unable to determine absolute path of git directory"
 		exit 1
 	}
-	: ${GIT_OBJECT_DIRECTORY=3D"$GIT_DIR/objects"}
+	: ${GIT_OBJECT_DIRECTORY=3D"$(git rev-parse --git-path objects)"}
 fi
=20
 peel_committish () {
--=20
1.9.1.346.ga2b5940
