From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 25/41] fast-import.c: use error_errno()
Date: Sun,  1 May 2016 18:14:41 +0700
Message-ID: <1462101297-8610-26-git-send-email-pclouds@gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:17:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpNX-0007h4-Pi
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541AbcEALRc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:17:32 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33689 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbcEALRb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:17:31 -0400
Received: by mail-pa0-f67.google.com with SMTP id vv3so18836403pab.0
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LauUMXXv2uC43czWwgzKxUfWipu6Qv639Ykrm+eOP/M=;
        b=cLUIpXPX2giunrH4FGZSDzCGI67VY9zGXrPLmIOvuWdH3ZowkrHpvAiBflPC/qQYm3
         q+JfAUF+j/q/6NqH+DSljQBu4jK05kptB5Q8wmqJMP970uhaNpjm4UTmnCXdvTV2hk0k
         83kYnObdLPjJJv0jcBCx1MwAsH7U3u9fACUW062vBNgyUg3ozbOBBD5eG3+T+3VcRTZK
         LRvANXZcOpYhczq+rHlLjhy92VHVAPKnJJpdZQ5Fe6CTuLYK7vKHvSCYPB+BCl1UmUSy
         K9lRS9Af0UeMByZOruwtDSDiqWDdH5/V/sLCd8RMtdayJlZ9BWA4JFsUyzbbViKmq6fN
         e0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LauUMXXv2uC43czWwgzKxUfWipu6Qv639Ykrm+eOP/M=;
        b=WfkzIJwC/rUwiDJ0rG9p6pARObT7GxfvikoVqVtbBq9xEThIYXW/AyRXxfnX3Jf8Qm
         /HofZSdOBpNTOFQAquPi5zWjf4lNJIHFkQnyNtAQpxC2J3k71nvaaoyap0w5DiaOOIo4
         ZhSlKklht8f8lQO0HjYTjR0yWOaaR12JP2n3rAiH8tPcS9RTwvarsLSmRphUuQ8hRsCx
         SlUOifTamJN7xEmZEzAAGlscja5kf+KoPYuqmkPw/jtj9QvvxY2CA8k291sPaEV4U70N
         bMrR9NWb6JoPxLwP+GdjUIuI7SuwoW1EuTr9XY0vujkJOf4sk7DKC35djz5VO3+Bw33o
         4noA==
X-Gm-Message-State: AOPr4FV82QPtFugVj4g3FFB5VqplxmcVp2WvkN/+0UjmzgXDc/EB7NtaM06dpqq4KLfNfg==
X-Received: by 10.67.13.78 with SMTP id ew14mr8243326pad.127.1462101450647;
        Sun, 01 May 2016 04:17:30 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id i6sm36476791pfc.65.2016.05.01.04.17.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:17:29 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:17:25 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293175>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 fast-import.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 9fc7093..21881d1 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -414,7 +414,7 @@ static void write_crash_report(const char *err)
 	struct recent_command *rc;
=20
 	if (!rpt) {
-		error("can't write crash report %s: %s", loc, strerror(errno));
+		error_errno("can't write crash report %s", loc);
 		free(loc);
 		return;
 	}
@@ -1806,8 +1806,8 @@ static void dump_marks(void)
 		return;
=20
 	if (hold_lock_file_for_update(&mark_lock, export_marks_file, 0) < 0) =
{
-		failure |=3D error("Unable to write marks file %s: %s",
-			export_marks_file, strerror(errno));
+		failure |=3D error_errno("Unable to write marks file %s",
+				       export_marks_file);
 		return;
 	}
=20
@@ -1822,8 +1822,8 @@ static void dump_marks(void)
=20
 	dump_marks_helper(f, 0, marks);
 	if (commit_lock_file(&mark_lock)) {
-		failure |=3D error("Unable to write file %s: %s",
-			export_marks_file, strerror(errno));
+		failure |=3D error_errno("Unable to write file %s",
+				       export_marks_file);
 		return;
 	}
 }
--=20
2.8.0.rc0.210.gd302cd2
