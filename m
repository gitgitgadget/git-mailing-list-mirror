From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 050/144] t4204-patch-id.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:55 -0700
Message-ID: <1395735989-3396-51-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:33:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMo0-0006bp-8M
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:33:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753496AbaCYIdu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:33:50 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:58996 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753789AbaCYI1d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:33 -0400
Received: by mail-pb0-f44.google.com with SMTP id rp16so132818pbb.17
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ft0jDjckdkjkwE7zjcoNB2hGKBXY4/mk4fbSLGS7TOI=;
        b=wA2oWVrzs8+LdekauZ0QJ5AkNbTZ3BeHEzuAYeNTHHN2c9rkAJztjajkMRNTO24XDb
         PEV41Sp2YVLAC4VVj86c12zfgGDG5yLzco669LnM3O6Tyv9YaPUDcbm6YXeeM/eUsVxj
         ipis5qNt6u8dMCnv33rohWgaybXTA/P2jloYRr2puF4Y/Ks8NxqJTs/HMD+tuANS2MfO
         TGXaEwKM/sI/8SWvmpv5otFv8B/L17RlAiyRK73C9StgrrUrMhZAoN0d6/gxC9okxVDY
         XQwtI8TzYAM3v3IUg11L2/09Bng6EXm1azEyxwOsVTZTmb/eY+Rniu7pLTSI7LaPgvy5
         0C+Q==
X-Received: by 10.68.194.65 with SMTP id hu1mr8994466pbc.158.1395736053187;
        Tue, 25 Mar 2014 01:27:33 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244979>

The Git CodingGuidelines prefer the $( ... ) construct for command
substitution instead of using the back-quotes, or grave accents (`..`).

The backquoted form is the historical method for command substitution,
and is supported by POSIX. However,all but the simplest uses become
complicated quickly. In particular,embedded command substitutions
and/or the use of double quotes require careful escaping with the backs=
lash
character. Because of this the POSIX shell adopted the $(=E2=80=A6) fea=
ture from
the Korn shell.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t4204-patch-id.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
index d2c930d..7940f6f 100755
--- a/t/t4204-patch-id.sh
+++ b/t/t4204-patch-id.sh
@@ -45,8 +45,8 @@ test_expect_success 'patch-id supports git-format-pat=
ch output' '
 	git checkout same &&
 	git format-patch -1 --stdout | calc_patch_id same &&
 	test_cmp patch-id_master patch-id_same &&
-	set `git format-patch -1 --stdout | git patch-id` &&
-	test "$2" =3D `git rev-parse HEAD`
+	set $(git format-patch -1 --stdout | git patch-id) &&
+	test "$2" =3D $(git rev-parse HEAD)
 '
=20
 test_expect_success 'whitespace is irrelevant in footer' '
--=20
1.7.10.4
