From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/32] git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
Date: Sat, 30 Aug 2014 15:33:42 +0700
Message-ID: <1409387642-24492-13-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 10:35:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNe80-0002EV-JR
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 10:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbaH3IfG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2014 04:35:06 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:48876 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbaH3IfB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 04:35:01 -0400
Received: by mail-pa0-f45.google.com with SMTP id bj1so8098571pad.32
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 01:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=uBT7+Eb3QJ5sGmMKikLZxjjwhbj6VL+M9/BwpL7m5YY=;
        b=k1VK3sDLu7qcUdeC9iP1+JTqkIM/QjYCItugeZacKKKcjrIQtRIqNGJdErbFzvHupF
         WzJ3E/2t9HJ2x3R3jWLsfJxhlP8cQy0VQ5wp4Ix4YouG38WD4QXaUGGP+sawuiEDxS50
         fK3jTcTWYWsYvcsgxaUO3woqb1g52swlu3RPFs9cAWJXgV09E1lgko6cSZYy265M3jo1
         +ssGLiYZrTQtaYAwBLIFzX05I74fJkHUTz8+dEu1vhmJbsOWwhPYndjgHFwzgtoap+Kr
         VHRf/TefLLZ0ClzX8OvkYjz6Zz9s2tn52Lq45ae4CNwLwka8HgUaP+tXJ4+9S8bYmLgr
         qTNw==
X-Received: by 10.68.135.70 with SMTP id pq6mr22342736pbb.10.1409387699798;
        Sat, 30 Aug 2014 01:34:59 -0700 (PDT)
Received: from lanh ([115.73.195.142])
        by mx.google.com with ESMTPSA id tx8sm7492173pac.42.2014.08.30.01.34.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Aug 2014 01:34:59 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 30 Aug 2014 15:35:09 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256223>

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
