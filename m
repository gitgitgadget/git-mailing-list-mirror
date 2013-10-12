From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 01/20] merge: simplify ff-only option
Date: Sat, 12 Oct 2013 02:07:04 -0500
Message-ID: <1381561636-20717-9-git-send-email-felipe.contreras@gmail.com>
References: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:13:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtOQ-0005ga-6o
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754665Ab3JLHNk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:13:40 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:65062 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630Ab3JLHNi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:13:38 -0400
Received: by mail-oa0-f44.google.com with SMTP id l20so2585025oag.31
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lAdMWZfdvPTLlfzgBd6H2kqnnAD5kLkarnl3p/FNmLk=;
        b=ax3md44E7rGKVP2yjc1Ux8cxUlB6z/uAm3Et2V9CVK3Wer3KyocaT6TvYBrLWW2FBc
         VwLVBZGFK/pgfXLML6jssECB0NOyOYz5XJZtjNR1hCJZtOG4G6PZ1iIIihbsFDOIb3wa
         XkqLjka/rhR1SZPYPjRQZQfTA3XOdnw+mwjj5MfOOEUOB0MN8JnckmnPwWdAw9Nw/T1y
         QqaDeAG9veatxbtm2kqdJPtVsL9cdD6XQ8mQz53QqNe+Oq/IUsMqx9GPtO/mQrXfWF2j
         1XZKP/LYwl22phShvKGi1kLSN2QwydEaDAblrwOgecJJkUaety9wir866Ras5u14Z9qm
         vBWg==
X-Received: by 10.60.43.131 with SMTP id w3mr17915179oel.10.1381562017692;
        Sat, 12 Oct 2013 00:13:37 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r3sm101388732oep.2.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:13:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236017>

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
1.8.4-fc
