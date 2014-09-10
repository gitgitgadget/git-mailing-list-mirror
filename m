From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 12/32] git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
Date: Thu, 11 Sep 2014 05:41:48 +0700
Message-ID: <1410388928-32265-13-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
 <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 00:43:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRqbb-0001eS-Mr
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 00:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211AbaIJWnK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Sep 2014 18:43:10 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:54726 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063AbaIJWnH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 18:43:07 -0400
Received: by mail-pa0-f45.google.com with SMTP id rd3so7934502pab.4
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 15:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=uBT7+Eb3QJ5sGmMKikLZxjjwhbj6VL+M9/BwpL7m5YY=;
        b=dA1nQ/lrxyKQWtiAy+m2VwzCxQc+wrJcWPBhSO72KdqX4dOn3d81jraMaxzlx403ih
         fx1pSCTJ1Cg4y2TifIbwbsMTmcwaYmjfcBBt1oigT7IzlAG4O8iRnttFdJnYBoiq9ZUG
         eUOpmSE7cRgDCUsKXP4DTb+6wq8J3cisDFl/aNjMRANgy9iyKn/JwwEoOHmVdZ0CwqKG
         qbv5km56Q8FXWZhbGDAv2wSoSLJsD6Y+ew7irl5w/o+jKdLPJuHnlu8APVdnt4dpUiPl
         nrn/GOv/Xf4o6HQphOcmFasEXtj9NbcYgvL32A6+G7uyVwRj3m6IgN1gJtJ8wFqjuWyB
         Ghxw==
X-Received: by 10.68.220.228 with SMTP id pz4mr10137242pbc.16.1410388987148;
        Wed, 10 Sep 2014 15:43:07 -0700 (PDT)
Received: from lanh ([115.73.197.210])
        by mx.google.com with ESMTPSA id yw4sm15419448pbc.69.2014.09.10.15.43.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Sep 2014 15:43:06 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 11 Sep 2014 05:43:27 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256789>

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
