From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/3] merge: simplify ff-only option
Date: Sat, 31 Aug 2013 17:38:08 -0500
Message-ID: <1377988690-23460-2-git-send-email-felipe.contreras@gmail.com>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 01 00:43:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFtsp-00079V-HW
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 00:43:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755484Ab3HaWnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 18:43:00 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:48318 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755284Ab3HaWmz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 18:42:55 -0400
Received: by mail-ob0-f170.google.com with SMTP id eh20so3268481obb.15
        for <git@vger.kernel.org>; Sat, 31 Aug 2013 15:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BA9E4LsRnnX5hko35sliDFbPrycl3LMYnpe3FrUZVKw=;
        b=yCjsmyBbkAdW33dto9jKrPnirFU9r6jGIA5wVO4Q9rHUaXW/NjUsBOQCT09CsYaQ/j
         ypQQj6bDK3FHmRW+5sjGxoltb2n3tx1AAS1RFCywchs55g09zNdLMe1yDk/jUaSdeJZu
         rZTUPcmjDvm3hweQLQmXTz20HIvoXMni6rK2jPgJUOYy+J2kWzU2TmtrtCVu+VX8pmfB
         fMr+4kkH4ojeOFpvJVUFNAZGR0x636aIFvlGE3C1ZVS9wj/YE0KEk62Bj3x2kMliigC4
         umsWQI3kcxT/6MyU2QQTidijpqCY1ixHGYp872uzYisAJUXrj8lPgaqPH12UpbpfSATv
         C0Rg==
X-Received: by 10.60.46.193 with SMTP id x1mr11784213oem.36.1377988974176;
        Sat, 31 Aug 2013 15:42:54 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id d8sm5606675oeu.6.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 31 Aug 2013 15:42:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-337-g7358a66-dirty
In-Reply-To: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233555>

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
1.8.4-337-g7358a66-dirty
