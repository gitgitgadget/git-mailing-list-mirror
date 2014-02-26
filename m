From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [RFC 2/3] merge: Add hints to tell users about "git merge --abort"
Date: Wed, 26 Feb 2014 13:06:24 -0500
Message-ID: <1393437985-31401-3-git-send-email-andrew.kw.w@gmail.com>
References: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 26 19:06:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIisW-0004U4-LF
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 19:06:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706AbaBZSGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 13:06:39 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:59716 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbaBZSGi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 13:06:38 -0500
Received: by mail-ie0-f169.google.com with SMTP id at1so1013383iec.0
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 10:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6jJ8JrLrL85XFRgGzN3j2nudaDJAyETen3cM+jbXRqk=;
        b=Uxw33YEbY+EpP8rtxU6sDLXbRza9On7K2FL1Rh/sS6sAvIcRHpeF27PZOHhspVGa67
         qdyhWuu8tXzV02xEpTM7S9U8TmANinECtwyyBHHDLjnv9qu/OnlfO/lLiCXrT+OlATWO
         lMbQQQA6R8QlRfVX6jiIu4OZd55M7E4T4swvTKx4bnI3JjJWna1H5yM3n/wSfKHJ3zGk
         3GswNBvMtIiXQ2DO0Kby/nJYuQyAXLQ6mkylqFHlY7KdChh+t3YfVKSF3ekBeuZOn1zc
         vXVNsngm4UWiW3WAmte0HZZMut9eM3Vr8AXXGxvNFSTNdFyDtG26A4rrywuXZX7CKu34
         J+Nw==
X-Received: by 10.50.11.36 with SMTP id n4mr27460998igb.3.1393437998235;
        Wed, 26 Feb 2014 10:06:38 -0800 (PST)
Received: from dresden.sidefx.com (nat.sidefx.com. [38.104.156.10])
        by mx.google.com with ESMTPSA id kb5sm1968331igb.1.2014.02.26.10.06.36
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 26 Feb 2014 10:06:37 -0800 (PST)
X-Mailer: git-send-email 1.9.0.7.g53f6706
In-Reply-To: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242740>

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 builtin/merge.c | 3 ++-
 wt-status.c     | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index e576a7f..07af427 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -909,7 +909,8 @@ static int suggest_conflicts(int renormalizing)
 	fclose(fp);
 	rerere(allow_rerere_auto);
 	printf(_("Automatic merge failed; "
-			"fix conflicts and then commit the result.\n"));
+			"fix conflicts and then commit the result.\n"
+			"To abort the merge, use \"git merge --abort\".\n"));
 	return 1;
 }
 
diff --git a/wt-status.c b/wt-status.c
index 6e1ad7d..54c2203 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -907,6 +907,9 @@ static void show_merge_in_progress(struct wt_status *s,
 			status_printf_ln(s, color,
 				_("  (use \"git commit\" to conclude merge)"));
 	}
+	if (s->hints)
+		status_printf_ln(s, color,
+			_("  (use \"git merge --abort\" to abort the merge)\n"));
 	wt_status_print_trailer(s);
 }
 
-- 
1.9.0.6.g16e5f9a
