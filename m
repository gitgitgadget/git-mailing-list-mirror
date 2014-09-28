From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 12/32] git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
Date: Sun, 28 Sep 2014 08:22:26 +0700
Message-ID: <1411867366-3821-13-git-send-email-pclouds@gmail.com>
References: <xmqqk34r9z3r.fsf@gitster.dls.corp.google.com>
 <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 28 03:24:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XY3DU-0002Mf-LO
	for gcvg-git-2@plane.gmane.org; Sun, 28 Sep 2014 03:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbaI1BX4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Sep 2014 21:23:56 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33293 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbaI1BX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2014 21:23:56 -0400
Received: by mail-pa0-f50.google.com with SMTP id kx10so1164149pab.37
        for <git@vger.kernel.org>; Sat, 27 Sep 2014 18:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=uBT7+Eb3QJ5sGmMKikLZxjjwhbj6VL+M9/BwpL7m5YY=;
        b=oKcxyE9w5/d35h3bqdm8H4zlRfcQXaJ4JNSL0O4kN8aCMSRI4iTIlV3r/1WGE/P7V3
         leUUpa0cH4uxOcjyguf81hfrSoDXk+dH58BAWNnXrpnyVtEd2h7jTcW8Z/RO0A38opVT
         a+YlxZ+C/cOcR4UQTvjI3PJbdwBGCzJlf7PU1CVatXjs4iQVHBIIzmyMRwPP40Azz6Ud
         AymYPOxOvEmeYEgy/u7Yqequ4IQnJdx322bgq6kMsVeRLAt100BWBzexpaJOyUHVYBR7
         szEiqV0ghZsgCeceyEMB5OiQ7syAqJ9HaSL7wvD+ANqvMLzRqTIL9fZd1/b6yLJbOl3y
         mbVQ==
X-Received: by 10.68.202.225 with SMTP id kl1mr45729428pbc.21.1411867435568;
        Sat, 27 Sep 2014 18:23:55 -0700 (PDT)
Received: from lanh ([115.73.212.224])
        by mx.google.com with ESMTPSA id n2sm8561633pdh.30.2014.09.27.18.23.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Sep 2014 18:23:54 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 28 Sep 2014 08:23:58 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257571>

If $GIT_COMMON_DIR is set, $GIT_OBJECT_DIRECTORY should be
$GIT_COMMON_DIR/objects, not $GIT_DIR/objects. Just let rev-parse
--git-path handle it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.1.0.rc0.78.gc0d8480
