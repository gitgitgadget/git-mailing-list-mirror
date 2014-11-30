From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/34] git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
Date: Sun, 30 Nov 2014 15:24:37 +0700
Message-ID: <1417335899-27307-13-git-send-email-pclouds@gmail.com>
References: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 09:27:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XuzrA-0007zu-AX
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 09:27:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061AbaK3I1o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 03:27:44 -0500
Received: from mail-pd0-f174.google.com ([209.85.192.174]:51602 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011AbaK3I1n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 03:27:43 -0500
Received: by mail-pd0-f174.google.com with SMTP id w10so8898313pde.5
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 00:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=mvjcbGC2QDJ5GFsT7E5AtMFXzNJB4Zee/TYsaJ8d4lw=;
        b=knO2EUVO3YoHwciTAlMLpKz5QuhcUGJzec02mOUmZJEytNOaZ/gDgh3EWFf3/V3Ls9
         x1iYoOfBfx7OGLrDy5NfWTjFzyf3OJxjBLed9gwviZoBKCW9TSVq9Zf9JLzhBy5oiKNF
         3XQBt/2B+QUAhKKxufLPhB9oRIL77tKe0KfgRPSNcs94x9R3OaaKflZzhdeQXPgxYCA9
         WC/38KpslkyBAV78dcvwwE12yiIOmlvKbMct2GUd79N2f5ZsX/kcdbyg4kC2B9BjdzTN
         YhVoT3MRSwq6uTsg/Tn71n/P6P4Il4Apjm+a+kbT5/FCwEqkWOcK8eoio4tSTwQi+DC6
         QUHw==
X-Received: by 10.68.65.112 with SMTP id w16mr88862182pbs.114.1417336062851;
        Sun, 30 Nov 2014 00:27:42 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id ek5sm14290208pbd.4.2014.11.30.00.27.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 00:27:42 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Nov 2014 15:27:29 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260399>

If $GIT_COMMON_DIR is set, $GIT_OBJECT_DIRECTORY should be
$GIT_COMMON_DIR/objects, not $GIT_DIR/objects. Just let rev-parse
--git-path handle it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git-sh-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index d968760..94a5c6d 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -344,7 +344,7 @@ git_dir_init () {
 		echo >&2 "Unable to determine absolute path of git directory"
 		exit 1
 	}
-	: ${GIT_OBJECT_DIRECTORY=3D"$GIT_DIR/objects"}
+	: ${GIT_OBJECT_DIRECTORY=3D"$(git rev-parse --git-path objects)"}
 }
=20
 if test -z "$NONGIT_OK"
--=20
2.1.0.rc0.78.gc0d8480
