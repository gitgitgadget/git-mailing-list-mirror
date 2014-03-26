From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 11/17] ls: -u does not imply showing stages
Date: Wed, 26 Mar 2014 20:48:11 +0700
Message-ID: <1395841697-11742-12-git-send-email-pclouds@gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
 <1395841697-11742-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 26 14:48:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSoCQ-0000Jr-4i
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 14:48:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754803AbaCZNsx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Mar 2014 09:48:53 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:49387 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754785AbaCZNsw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 09:48:52 -0400
Received: by mail-pd0-f170.google.com with SMTP id v10so1896292pde.15
        for <git@vger.kernel.org>; Wed, 26 Mar 2014 06:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=n2vvfJw+ornJaeIwTDK0wfApkp52mTn0ais69EiUP/k=;
        b=BQoWkPyuiFEjpHYa952o4hWcF3iw8lmCkCIfVzquAIeAEhkgcmQhT73+wE43VXN7En
         qYhMXNSsSeHoYUsBnaxoxxkbV9IO9L1fDrMRuSSijwBzBPEoEhHnE3X7ueK+MT4ZPWBa
         hloMYtfjdD611Z1/NqyOFq24bGfiKwC6eDFy/Ecd29lYLMn9XxF9wJieQaJp2/4/0aEw
         NcVngb2ZwkO80rVtC50zin8qn+CDcP8DrYU/TV4S3WIHV4Gl4UJVvicax31UQsasjwfb
         Wd+oNAJkpKmWbC+dfEGj0yckrs3FKNsxbq+11e4GPx+1SojcBFFq3mS+P8f9LpxOYVAa
         oo+w==
X-Received: by 10.68.66.1 with SMTP id b1mr86358628pbt.43.1395841732290;
        Wed, 26 Mar 2014 06:48:52 -0700 (PDT)
Received: from lanh ([115.73.224.106])
        by mx.google.com with ESMTPSA id qq5sm58545977pbb.24.2014.03.26.06.48.49
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 26 Mar 2014 06:48:51 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 26 Mar 2014 20:49:45 +0700
X-Mailer: git-send-email 1.9.1.345.ga1a145c
In-Reply-To: <1395841697-11742-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245190>

Showing full index entry information is something for ls-files
only. The users of "git ls" may just want to know what entries are not
unmerged.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-files.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 74eb3c2..1638983 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -527,7 +527,7 @@ static int ls_files(const char **argv, const char *=
prefix)
 	}
 	if (show_modified || show_others || show_deleted || (dir.flags & DIR_=
SHOW_IGNORED) || show_killed)
 		require_work_tree =3D 1;
-	if (show_unmerged)
+	if (show_unmerged && !porcelain)
 		/*
 		 * There's no point in showing unmerged unless
 		 * you also show the stage information.
--=20
1.9.1.345.ga1a145c
