From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 7/8] mv: combine two if(s)
Date: Sun, 10 Aug 2014 09:29:35 +0700
Message-ID: <1407637776-19794-8-git-send-email-pclouds@gmail.com>
References: <1407637776-19794-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 04:30:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGItt-0003z2-O6
	for gcvg-git-2@plane.gmane.org; Sun, 10 Aug 2014 04:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126AbaHJCaU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Aug 2014 22:30:20 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:40663 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbaHJCaS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2014 22:30:18 -0400
Received: by mail-pd0-f174.google.com with SMTP id fp1so8907518pdb.19
        for <git@vger.kernel.org>; Sat, 09 Aug 2014 19:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=KnK4t35Mtcab6G/0vdS/IulKWSU0TsgL6q01Z85onHQ=;
        b=TwQVnw4BODE/v8wTnVE8PePKDwrdTAkpWQHT4qwGmS3Gvl+CGeixTTrf/B3TG6Ysri
         ynzDySsMO2UduVMrbmTl8mPFmqZuZD8rbagNck3hu4iEGZVLFKFqg3VZRFs2yl9G3zuw
         wzs8tB0/FaQt2e7bPllwDty81RrpumssYnU6LG4Vp7tvtD7AHJMazn7h9iGLUaMsRVg7
         RRt0PlQpeTwy3cpU/bix3lDW99vV8J1neylHfE8Ha72Z+AFfsb3SgdUHCR0tOT3WEJJ8
         GY2dZ7rvg7xq2xSZxK/B2Nl4OupfrddzWo7nbNVx3L7/1PddJudag6zWgkWL8ng/0Y1B
         zFOg==
X-Received: by 10.68.137.67 with SMTP id qg3mr329835pbb.113.1407637818192;
        Sat, 09 Aug 2014 19:30:18 -0700 (PDT)
Received: from lanh ([115.73.228.225])
        by mx.google.com with ESMTPSA id kk3sm7224782pbc.51.2014.08.09.19.30.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Aug 2014 19:30:17 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 10 Aug 2014 09:30:21 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1407637776-19794-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255083>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/mv.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 988945c..cbe220f 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -275,10 +275,9 @@ int cmd_mv(int argc, const char **argv, const char=
 *prefix)
 	if (gitmodules_modified)
 		stage_updated_gitmodules();
=20
-	if (active_cache_changed) {
-		if (write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
-			die(_("Unable to write new index file"));
-	}
+	if (active_cache_changed &&
+	    write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
+		die(_("Unable to write new index file"));
=20
 	return 0;
 }
--=20
2.1.0.rc0.78.gc0d8480
