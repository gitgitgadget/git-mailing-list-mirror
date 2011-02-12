From: Vasyl' Vavrychuk <vvavrychuk@gmail.com>
Subject: [PATCH 1/4] Reduce url_len variable scope
Date: Sun, 13 Feb 2011 00:38:28 +0200
Message-ID: <1297550311-17723-2-git-send-email-vvavrychuk@gmail.com>
References: <1297550311-17723-1-git-send-email-vvavrychuk@gmail.com>
Cc: Vasyl' Vavrychuk <vvavrychuk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 13 00:01:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoOT4-0003DP-Qe
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 00:01:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839Ab1BLXBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Feb 2011 18:01:24 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53004 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070Ab1BLXBW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Feb 2011 18:01:22 -0500
Received: by fxm20 with SMTP id 20so3938740fxm.19
        for <git@vger.kernel.org>; Sat, 12 Feb 2011 15:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=Y4HnR73c3RwhLvWhMnwlYm05YVaZT4AKt85RyqDzMuA=;
        b=pbvnifP3D+Sy418sAfM3/6mhDYSGCuU/pTs61CJOLZRG5s/S8Pu9TpnpshHJwDk/nn
         mcJQjl9FagWwaoVPi8Lir0Io7Ofg4xbXDhEKvFFi5jF0Cdo7wNcoiNuJACq8kEOJpJPY
         FFqbBGSz9Hka0jUzxj2/1RbFeQu31PHIuPlaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nukVaNztVKSAGL2ZrQTLs3CcARiNssQNi/CWZrH9iyoa3om6xquG/6c7sFL2KY6Ti1
         aI93vZU1lESFFYyjLlc0H+3DuXo3+FFVv8ZvJ+e7N6ZrKkhZtF24VspX52D5a5x03W1s
         7IXNE+1Qe1tGoFQypJTOBNksBn1UcOLv5cu9c=
Received: by 10.223.71.200 with SMTP id i8mr1294719faj.142.1297550321364;
        Sat, 12 Feb 2011 14:38:41 -0800 (PST)
Received: from localhost.localdomain ([91.200.115.239])
        by mx.google.com with ESMTPS id n7sm369494fam.35.2011.02.12.14.38.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 12 Feb 2011 14:38:41 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1.30.ga83dc
In-Reply-To: <1297550311-17723-1-git-send-email-vvavrychuk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166629>

Signed-off-by: Vasyl' Vavrychuk <vvavrychuk@gmail.com>
---
 builtin/fetch.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 357f3cd..2b0b11e 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -385,6 +385,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 		url_len = i + 1;
 		if (4 < i && !strncmp(".git", url + i - 3, 4))
 			url_len = i - 3;
+		url[url_len] = '\0';
 
 		note_len = 0;
 		if (*what) {
@@ -399,7 +400,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 				    rm->old_sha1),
 			rm->merge ? "" : "not-for-merge",
 			note);
-		for (i = 0; i < url_len; ++i)
+		for (i = 0; url[i]; ++i)
 			if ('\n' == url[i])
 				fputs("\\n", fp);
 			else
@@ -415,8 +416,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 				 REFCOL_WIDTH, *what ? what : "HEAD");
 		if (*note) {
 			if (verbosity >= 0 && !shown_url) {
-				fprintf(stderr, "From %.*s\n",
-						url_len, url);
+				fprintf(stderr, "From %s\n", url);
 				shown_url = 1;
 			}
 			if (verbosity >= 0)
-- 
1.7.1
