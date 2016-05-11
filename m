From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 01/94] builtin/apply: make gitdiff_verify_name() return void
Date: Wed, 11 May 2016 15:16:12 +0200
Message-ID: <20160511131745.2914-2-chriscool@tuxfamily.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 15:18:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U27-0001XZ-Qn
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbcEKNS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:18:29 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33137 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbcEKNS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:18:28 -0400
Received: by mail-wm0-f67.google.com with SMTP id r12so9403142wme.0
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IFsmPkmxTIHt+9HTeaE85F6y7YiFpKexLmLE/at5m6I=;
        b=D6Mu+683vIH4hjpBLI9ankjVzob5zYlQgNJ7hZSK0jp4+9+tqYHgd8MzhDbBJXq9aS
         DTZiLIzenU9b5l59waD2x+ZjUXlZTHKFgRBhYsDNbTkj/RDJSATGfANNsa65yJta55xx
         d3Wq1U0BYYCRGTTGSbweYLs52vQl36pb7ExIr2ESqC+2J5343SPY0Z47arp+CNd+H23p
         QTvHxc5JhrkxJrrURCKozXgUxi4tnSuj7GNN64Po3NfL2YQtcJkz/9FNaOd91llgU2ee
         VJ9rrYNEnwebQ00cFkM1hZmaR8eY/jCcZ4wF+eVy77smlkQPXuUw7RheO6vRDvt0egvB
         AEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IFsmPkmxTIHt+9HTeaE85F6y7YiFpKexLmLE/at5m6I=;
        b=eN49XdO/1GZwfW674D2lMDiqeGGB/9LDbBEXTgjb98ugD/UDDvAwRXixImPWki2+KW
         s1GTtAncPumtdE3fRIM2+JNtyvUc3iWS/DT1jdGNffxHaCBO7AgHo7Y+OrStDVeXLVvw
         MTqJEHb/JhGE09kCFP68Xo0papC/08qP2nMagtqF2GALkydTvbhxnaRQG8A1m6pjJ5me
         ouNkMKuqzXrezaKIN32i5m0mxZ+m6ofP4MzmOR+UvoN5GOZe8G4/x0COWebrsB+ZsA6N
         glCAFZmRgkju9QPu8i/sOjzDWtUTdkBrBsLoo9bmOyYa1Qm+EmboQVSwcwl8cmhGrGtS
         jMyg==
X-Gm-Message-State: AOPr4FXVl22gNiuD7SDIlUxI1HmvxAkA2+HUyl3xRRbbMkYX/gUEUrwBlEmYxvJSurjvwQ==
X-Received: by 10.28.85.3 with SMTP id j3mr95134wmb.0.1462972707103;
        Wed, 11 May 2016 06:18:27 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.18.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:18:25 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294247>

As the value returned by gitdiff_verify_name() is put into the
same variable that is passed as a parameter to this function,
it is simpler to pass the address of the variable and have
gitdiff_verify_name() change the variable itself.

This also makes it possible to later have this function return
-1 instead of die()ing in case of error.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 8e4da2e..fe5aebd 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -925,43 +925,43 @@ static int gitdiff_hdrend(const char *line, struct patch *patch)
 #define DIFF_OLD_NAME 0
 #define DIFF_NEW_NAME 1
 
-static char *gitdiff_verify_name(const char *line, int isnull, char *orig_name, int side)
+static void gitdiff_verify_name(const char *line, int isnull, char **name, int side)
 {
-	if (!orig_name && !isnull)
-		return find_name(line, NULL, p_value, TERM_TAB);
+	if (!*name && !isnull) {
+		*name = find_name(line, NULL, p_value, TERM_TAB);
+		return;
+	}
 
-	if (orig_name) {
-		int len = strlen(orig_name);
+	if (*name) {
+		int len = strlen(*name);
 		char *another;
 		if (isnull)
 			die(_("git apply: bad git-diff - expected /dev/null, got %s on line %d"),
-			    orig_name, linenr);
+			    *name, linenr);
 		another = find_name(line, NULL, p_value, TERM_TAB);
-		if (!another || memcmp(another, orig_name, len + 1))
+		if (!another || memcmp(another, *name, len + 1))
 			die((side == DIFF_NEW_NAME) ?
 			    _("git apply: bad git-diff - inconsistent new filename on line %d") :
 			    _("git apply: bad git-diff - inconsistent old filename on line %d"), linenr);
 		free(another);
-		return orig_name;
 	} else {
 		/* expect "/dev/null" */
 		if (memcmp("/dev/null", line, 9) || line[9] != '\n')
 			die(_("git apply: bad git-diff - expected /dev/null on line %d"), linenr);
-		return NULL;
 	}
 }
 
 static int gitdiff_oldname(const char *line, struct patch *patch)
 {
-	patch->old_name = gitdiff_verify_name(line, patch->is_new, patch->old_name,
-					      DIFF_OLD_NAME);
+	gitdiff_verify_name(line, patch->is_new, &patch->old_name,
+			    DIFF_OLD_NAME);
 	return 0;
 }
 
 static int gitdiff_newname(const char *line, struct patch *patch)
 {
-	patch->new_name = gitdiff_verify_name(line, patch->is_delete, patch->new_name,
-					      DIFF_NEW_NAME);
+	gitdiff_verify_name(line, patch->is_delete, &patch->new_name,
+			    DIFF_NEW_NAME);
 	return 0;
 }
 
-- 
2.8.2.490.g3dabe57
