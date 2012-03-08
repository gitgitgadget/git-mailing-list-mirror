From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/5] i18n: mark relative dates for translation
Date: Thu,  8 Mar 2012 16:16:35 +0700
Message-ID: <1331198198-22409-3-git-send-email-pclouds@gmail.com>
References: <1331198198-22409-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 10:17:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5ZTs-0000Ji-U5
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 10:17:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755962Ab2CHJRe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 04:17:34 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:45862 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755550Ab2CHJRb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 04:17:31 -0500
Received: by pbcun15 with SMTP id un15so1326497pbc.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 01:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=GYOviy0IJZnIiVsLP0nhgXp55MlknlXmTxAiqpijoaQ=;
        b=NKKxSB/pb4aHwbeMLbuvpEna9tQABWvkFCETd/2oCr39fjMa2QzBjWsDJE7ryjamOX
         zOaXB/CIgZPhIV3SISzxUr5Ex9ojajoE4lNdBS7xtyXCHym5nvNPCmFKiPDGXOKj4REQ
         f9z3L7P0peDGyCHCmT7r8qnBqA/IbX+5wHj+qB0udd3MJGm9ijEqPEK0CRvMJ6kZKGfT
         lmRPSTVJLVai0F+EWoP+VO1XOe33YBLRDukrXE6P8ojxuOIFJoxYdpVQs4+SswvkWP/9
         qALXLzyF1WwC70C8ERI8cHC5JkpgfqmcG04NwFpG0Ansu0jMjOuLGB0gQxUiVOlfXA1R
         H+rg==
Received: by 10.68.240.164 with SMTP id wb4mr8303743pbc.57.1331198249760;
        Thu, 08 Mar 2012 01:17:29 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id d4sm2306656pbe.36.2012.03.08.01.17.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 01:17:28 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 08 Mar 2012 16:17:00 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1331198198-22409-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192542>

English dates get correct plural/singular form as a side effect.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 date.c |   46 +++++++++++++++++++++++++++++-----------------
 1 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/date.c b/date.c
index a5055ca..063f344 100644
--- a/date.c
+++ b/date.c
@@ -93,38 +93,46 @@ const char *show_date_relative(unsigned long time, =
int tz,
 {
 	unsigned long diff;
 	if (now->tv_sec < time)
-		return "in the future";
+		return _("in the future");
 	diff =3D now->tv_sec - time;
 	if (diff < 90) {
-		snprintf(timebuf, timebuf_size, "%lu seconds ago", diff);
+		snprintf(timebuf, timebuf_size,
+			 Q_("%lu second ago", "%lu seconds ago", diff), diff);
 		return timebuf;
 	}
 	/* Turn it into minutes */
 	diff =3D (diff + 30) / 60;
 	if (diff < 90) {
-		snprintf(timebuf, timebuf_size, "%lu minutes ago", diff);
+		snprintf(timebuf, timebuf_size,
+			 Q_("%lu minute ago", "%lu minutes ago", diff), diff);
 		return timebuf;
 	}
 	/* Turn it into hours */
 	diff =3D (diff + 30) / 60;
 	if (diff < 36) {
-		snprintf(timebuf, timebuf_size, "%lu hours ago", diff);
+		snprintf(timebuf, timebuf_size,
+			 Q_("%lu hour ago", "%lu hours ago", diff), diff);
 		return timebuf;
 	}
 	/* We deal with number of days from here on */
 	diff =3D (diff + 12) / 24;
 	if (diff < 14) {
-		snprintf(timebuf, timebuf_size, "%lu days ago", diff);
+		snprintf(timebuf, timebuf_size,
+			 Q_("%lu day ago", "%lu days ago", diff), diff);
 		return timebuf;
 	}
 	/* Say weeks for the past 10 weeks or so */
 	if (diff < 70) {
-		snprintf(timebuf, timebuf_size, "%lu weeks ago", (diff + 3) / 7);
+		snprintf(timebuf, timebuf_size,
+			 Q_("%lu week ago", "%lu weeks ago", (diff + 3) / 7),
+			 (diff + 3) / 7);
 		return timebuf;
 	}
 	/* Say months for the past 12 months or so */
 	if (diff < 365) {
-		snprintf(timebuf, timebuf_size, "%lu months ago", (diff + 15) / 30);
+		snprintf(timebuf, timebuf_size,
+			 Q_("%lu month ago", "%lu months ago", (diff + 15) / 30),
+			 (diff + 15) / 30);
 		return timebuf;
 	}
 	/* Give years and months for 5 years or so */
@@ -132,19 +140,23 @@ const char *show_date_relative(unsigned long time=
, int tz,
 		unsigned long totalmonths =3D (diff * 12 * 2 + 365) / (365 * 2);
 		unsigned long years =3D totalmonths / 12;
 		unsigned long months =3D totalmonths % 12;
-		int n;
-		n =3D snprintf(timebuf, timebuf_size, "%lu year%s",
-				years, (years > 1 ? "s" : ""));
-		if (months)
-			snprintf(timebuf + n, timebuf_size - n,
-					", %lu month%s ago",
-					months, (months > 1 ? "s" : ""));
-		else
-			snprintf(timebuf + n, timebuf_size - n, " ago");
+		if (months) {
+			struct strbuf sb =3D STRBUF_INIT;
+			strbuf_addf(&sb, Q_("%lu year", "%lu years", years), years);
+			/* TRANSLATORS: "%s" is "<n> years" */
+			snprintf(timebuf, timebuf_size,
+				 Q_("%s, %lu month ago", "%s, %lu months ago", months),
+				 sb.buf, months);
+			strbuf_release(&sb);
+		} else
+			snprintf(timebuf, timebuf_size,
+				 Q_("%lu year ago", "%lu years ago", years), years);
 		return timebuf;
 	}
 	/* Otherwise, just years. Centuries is probably overkill. */
-	snprintf(timebuf, timebuf_size, "%lu years ago", (diff + 183) / 365);
+	snprintf(timebuf, timebuf_size,
+		 Q_("%lu year ago", "%lu years ago", (diff + 183) / 365),
+		 (diff + 183) / 365);
 	return timebuf;
 }
=20
--=20
1.7.3.1.256.g2539c.dirty
