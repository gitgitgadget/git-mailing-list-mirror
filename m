From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 02/10] compat/fnmatch: respect NO_FNMATCH* even on glibc
Date: Tue,  1 Jan 2013 09:44:03 +0700
Message-ID: <1357008251-10014-3-git-send-email-pclouds@gmail.com>
References: <1357008251-10014-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 01 03:44:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TprqL-0008Qi-9g
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 03:44:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501Ab3AACoW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Dec 2012 21:44:22 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:38356 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283Ab3AACoV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 21:44:21 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so5959724dak.33
        for <git@vger.kernel.org>; Mon, 31 Dec 2012 18:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=NQsmcsODpZQ0Eo6f/BSD4/cnDgAas94/q71FFozrt48=;
        b=LOHpLaodRmbon/CbG9bbDz4YOEIkncwXx8+FugQdjOnzjbUQ/KUn3Yd1BPxv/LlI8q
         CCO9pM+PSKRqlOYrfJ0q4IFaxFEdScpJ/5pV7C3v47JNEiDPgon9Wm4P1JsLmerZbeZf
         Z5snt0m763ebf7vpdJ1kak4fPTePlE0AJQzDkakg+EyhrVNy2yYIx9o0taZzUyNzGd2W
         pBiKTJa58pVdkUzkfV+eV5emHIQkyK2rZfjySR2OYS6RVqcXvieyzKcvVxR0al7QKzUy
         sCxmR0BQOiXYhyD45PBlNzDaMyG2iPVIws+mklg3Id2KEWxUqId5N1MbvTyAIzvZck3q
         yExg==
X-Received: by 10.68.137.131 with SMTP id qi3mr131700818pbb.114.1357008261407;
        Mon, 31 Dec 2012 18:44:21 -0800 (PST)
Received: from lanh ([115.74.57.25])
        by mx.google.com with ESMTPS id s5sm26648290pay.31.2012.12.31.18.44.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 31 Dec 2012 18:44:20 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 01 Jan 2013 09:44:25 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357008251-10014-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212385>


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
