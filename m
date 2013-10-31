From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 01/16] merge: simplify ff-only option
Date: Thu, 31 Oct 2013 03:25:32 -0600
Message-ID: <1383211547-9145-2-git-send-email-felipe.contreras@gmail.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 31 10:32:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbocO-00087Y-Lj
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 10:32:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479Ab3JaJce (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 05:32:34 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:52079 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753449Ab3JaJcc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 05:32:32 -0400
Received: by mail-ob0-f174.google.com with SMTP id vb8so2734653obc.19
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 02:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gwy5vEaxdUX6DYYyNZGX3+qIaqw/ParrMcaAzdx8ehY=;
        b=mpEw+JVuxPFO0MLIymD1OuomllgZ3sJbyu79uBe3NlSkgLspJEgVtgeJM4B1Kywhae
         MVq8oGqgOOjjMpKQrj+xDDq4aXc5nVWpAHnNDJ/ZYwFxv9HYmUhkXIn1jTcLjduZjegk
         43qzd5Ry2LnIK9yhYKI0JQIvysjBNiLE1qmpAqPCOQgUcqTsseZ52/IivnFxXP7mMqeY
         WdQutnBoIWXvbCyE6bBL2zwIjnGJWxBHWLmeohBQdMx1UwpP8ZbvjBMkL6n7PSfw9CVA
         O/jJZDW5DYD3rheGArjflAoVRYJ3jK8Fh+kyKuzYJ3sfI2r0CrNrQpz//WoLOGhn+i/O
         2RUQ==
X-Received: by 10.60.56.3 with SMTP id w3mr1818378oep.37.1383211951865;
        Thu, 31 Oct 2013 02:32:31 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id hs4sm4490661obb.5.2013.10.31.02.32.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2013 02:32:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237086>

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/merge.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 02a69c1..41fb66d 100644
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
1.8.4.2+fc1
