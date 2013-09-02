From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/6] merge: simplify ff-only option
Date: Mon,  2 Sep 2013 17:17:53 -0500
Message-ID: <1378160278-14872-2-git-send-email-felipe.contreras@gmail.com>
References: <1378160278-14872-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 03 00:22:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGcWL-0000xA-Si
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 00:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759062Ab3IBWWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 18:22:47 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:54223 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756218Ab3IBWWq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 18:22:46 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so4957548obc.40
        for <git@vger.kernel.org>; Mon, 02 Sep 2013 15:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DpGIxzfH4Ytwt9F5m96OPkze8ga4mp3lU3SBuENUiHA=;
        b=RCy+QpWGiwTjZFZMCOQ6JD3fCTJWZ8YWGb0qcGOeWHjQkp2J+s4sw2MPw4E7LMeDq0
         xx0yVtLYZVYJLoJ5d1y4eyz+W+GLaFvl20y5Pnxztox6MS4dQj1NE7JMLjM+gxLzPF8b
         Ps/nNIWn+8nCTTBQ6uT+YpZn6z+kL4bZiiasFsuYs9C+l/0zfcfKcYVIozBn/ZTxPrb1
         iajPcKv8RyrZiO2mi3ViP8PvzGbxITwhlKT6z2nPhP0whMlE/Lui+BkzJe8LNSQ+ugby
         I3kQp4HPO0yrnEJ+aLOFOBC9uzgRJmc1cWzmeaSsM4buLYytARBnQ5cJuaSNU2/VcGaf
         Fv9g==
X-Received: by 10.182.230.135 with SMTP id sy7mr18252087obc.24.1378160565949;
        Mon, 02 Sep 2013 15:22:45 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id b5sm15163610obj.8.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 02 Sep 2013 15:22:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-338-gefd7fa6
In-Reply-To: <1378160278-14872-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233666>

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/merge.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 34a6166..da9fc08 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -186,13 +186,6 @@ static int option_parse_n(const struct option *opt,
 	return 0;
 }
 
-static int option_parse_ff_only(const struct option *opt,
-			  const char *arg, int unset)
-{
-	fast_forward = FF_ONLY;
-	return 0;
-}
-
 static struct option builtin_merge_options[] = {
 	{ OPTION_CALLBACK, 'n', NULL, NULL, NULL,
 		N_("do not show a diffstat at the end of the merge"),
@@ -210,9 +203,9 @@ static struct option builtin_merge_options[] = {
 	OPT_BOOL('e', "edit", &option_edit,
 		N_("edit message before committing")),
 	OPT_SET_INT(0, "ff", &fast_forward, N_("allow fast-forward (default)"), FF_ALLOW),
-	{ OPTION_CALLBACK, 0, "ff-only", NULL, NULL,
+	{ OPTION_SET_INT, 0, "ff-only", &fast_forward, NULL,
 		N_("abort if fast-forward is not possible"),
-		PARSE_OPT_NOARG | PARSE_OPT_NONEG, option_parse_ff_only },
+		PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, FF_ONLY },
 	OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
 	OPT_BOOL(0, "verify-signatures", &verify_signatures,
 		N_("Verify that the named commit has a valid GPG signature")),
-- 
1.8.4-338-gefd7fa6
