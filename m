From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/8] compat/fnmatch: respect NO_FNMATCH* even on glibc
Date: Sat, 22 Dec 2012 14:57:01 +0700
Message-ID: <1356163028-29967-2-git-send-email-pclouds@gmail.com>
References: <1356163028-29967-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 22 08:58:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmJyA-0008UB-5Q
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 08:58:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024Ab2LVH5k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Dec 2012 02:57:40 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:41499 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799Ab2LVH5i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 02:57:38 -0500
Received: by mail-pa0-f50.google.com with SMTP id hz10so3269890pad.9
        for <git@vger.kernel.org>; Fri, 21 Dec 2012 23:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=NQsmcsODpZQ0Eo6f/BSD4/cnDgAas94/q71FFozrt48=;
        b=LIEWcy4iUOM3UMKXodgubwAtkpZBZJAHJoN0cvOzJhL+CA/tZ2pFG2CWa4hpiujPNI
         0zkRmZiFtVrhVcFBpi3PShWblXKHfqkYvCMr1nEKZcBnHnJ2PQlX36nsIK9FflZykjoM
         VV/zfBg3wWgwSQerJ+beCFRCeIIB6fag65z6ZIUdS5xP/BjBljt477FxCjlLTt5D0f3G
         wh0eQWDGeCB7Of7MyNAZ3sm+oJvwjieFvGKIZInJo49idOfF4Lke33M4qsXgSEZFEPWE
         kT/0dRa2nr2aDG0v97LS6/RTig9H2D4NuywStaW7AonuuCQH6BkrTXZQxLowV9Ke1u6i
         WHzQ==
X-Received: by 10.68.216.134 with SMTP id oq6mr46677436pbc.162.1356163042854;
        Fri, 21 Dec 2012 23:57:22 -0800 (PST)
Received: from lanh ([115.74.46.73])
        by mx.google.com with ESMTPS id vo8sm8431351pbc.16.2012.12.21.23.57.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 21 Dec 2012 23:57:22 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 22 Dec 2012 14:57:18 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1356163028-29967-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212027>


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
