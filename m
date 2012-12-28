From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/9] compat/fnmatch: respect NO_FNMATCH* even on glibc
Date: Fri, 28 Dec 2012 11:10:46 +0700
Message-ID: <1356667854-8686-2-git-send-email-pclouds@gmail.com>
References: <1356667854-8686-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 28 05:11:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToRIB-0000g4-7g
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 05:11:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233Ab2L1ELK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Dec 2012 23:11:10 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:58169 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169Ab2L1ELJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2012 23:11:09 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so5791245pad.5
        for <git@vger.kernel.org>; Thu, 27 Dec 2012 20:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=NQsmcsODpZQ0Eo6f/BSD4/cnDgAas94/q71FFozrt48=;
        b=SghIiSrDs5Xd+86X8MuY416yBpaY5hzLpPh/SOy3Is4F3Fh+VBRTF0IMUfSJP0KDGs
         xsDJlFYxh7uFvhRDqBI7PbZUg0T60vPOL3D2Y7K5LBLbJBgzH6WRZmJFDtLmrBjYD+A2
         r5m0qCmYVxIx/f8bQeFxj68RE3x4UBi0zZfquTyhgbS/tdIbqvADMDnXoNt649+43KIX
         hCm+6R+hiJ2wu4Ck3XG4MEaqPXp7Rd8WIao+7nImVG9E2ylr8jW56KbmiwGTmTLK/Q0l
         iEQxNeAfArhGAzumCFfSXKgD5FGCqXTkSGHtRxLlFfM7pODjR9BWhDXhT8+SNQ7gZKJo
         zz5w==
X-Received: by 10.68.213.233 with SMTP id nv9mr100569656pbc.155.1356667868428;
        Thu, 27 Dec 2012 20:11:08 -0800 (PST)
Received: from lanh ([115.74.54.149])
        by mx.google.com with ESMTPS id ol4sm18916911pbb.58.2012.12.27.20.11.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 27 Dec 2012 20:11:07 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 28 Dec 2012 11:11:08 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1356667854-8686-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212224>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 compat/fnmatch/fnmatch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/compat/fnmatch/fnmatch.c b/compat/fnmatch/fnmatch.c
index 9473aed..6f7387d 100644
--- a/compat/fnmatch/fnmatch.c
+++ b/compat/fnmatch/fnmatch.c
@@ -55,7 +55,8 @@
    program understand `configure --with-gnu-libc' and omit the object =
files,
    it is simpler to just do this in the source for each such file.  */
=20
-#if defined _LIBC || !defined __GNU_LIBRARY__
+#if defined NO_FNMATCH || defined NO_FNMATCH_CASEFOLD || \
+    defined _LIBC || !defined __GNU_LIBRARY__
=20
=20
 # if defined STDC_HEADERS || !defined isascii
--=20
1.8.0.rc2.23.g1fb49df
