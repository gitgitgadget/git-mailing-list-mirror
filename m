From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 2/2] diff: avoid some nesting
Date: Mon, 16 Dec 2013 21:19:24 +0100
Message-ID: <1387225164-31747-2-git-send-email-t.gummerer@gmail.com>
References: <xmqqob4goa4t.fsf@gitster.dls.corp.google.co>
 <1387225164-31747-1-git-send-email-t.gummerer@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Gummerer <t.gummerer@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 16 21:21:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vseey-0005dg-PH
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 21:21:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286Ab3LPUUS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 15:20:18 -0500
Received: from mail-bk0-f49.google.com ([209.85.214.49]:53842 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332Ab3LPUUO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 15:20:14 -0500
Received: by mail-bk0-f49.google.com with SMTP id my13so2499259bkb.22
        for <git@vger.kernel.org>; Mon, 16 Dec 2013 12:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nlVhAjFZjqvZse3VBZv3VUbTJL0guN2oxe8y4AMSiiY=;
        b=gEc4kwVvgddGDZVaSs/Yq3cxH2pTZhe4QLH2JksdL6B+TIS1WOUs5SE0yAJE0QqE6V
         3+GSkou0pWPkk95HbJkpv203YbGFQNHz/Z7F3ZS6zx/yVZZsPt3odn1QKlsDBUmfPzPB
         J4dDEA+92J7p3s2lXQqp+tBicF1BDahKxWR2WVMn0jGYTkk2H5aCIi5WLxAmN+hoh+zP
         kX7QOob4wh6XhkaHWWYNe9jnaSKziNIwZdT13EZUKd4cRIgUc1nx2cR3RHCK1i6Nz26x
         1WvhDT7CQtt+otraAm5aRphp+aCZu5E1SBpZxGxZ5zzL3IzPY42YXfNVuaYytKRnlgWP
         hJyg==
X-Received: by 10.204.80.78 with SMTP id s14mr5631946bkk.6.1387225212852;
        Mon, 16 Dec 2013 12:20:12 -0800 (PST)
Received: from localhost ([2001:5c0:1400:a::1b8d])
        by mx.google.com with ESMTPSA id lr9sm11454117bkb.2.2013.12.16.12.20.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2013 12:20:11 -0800 (PST)
X-Mailer: git-send-email 1.8.5.4.g8639e57
In-Reply-To: <1387225164-31747-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239366>

Avoid some nesting in builtin/diff.c, to make the code easier to read.
There are no functional changes.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/diff.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index ea1dd65..24d6271 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -319,27 +319,26 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 
 	init_revisions(&rev, prefix);
 
-	if (no_index) {
-		if (argc != i + 2) {
-			if (no_index == DIFF_NO_INDEX_IMPLICIT) {
-				/*
-				 * There was no --no-index and there were not two
-				 * paths. It is possible that the user intended
-				 * to do an inside-repository operation.
-				 */
-				fprintf(stderr, "Not a git repository\n");
-				fprintf(stderr,
-					"To compare two paths outside a working tree:\n");
-			}
-			/* Give the usage message for non-repository usage and exit. */
-			usagef("git diff %s <path> <path>",
-			       no_index == DIFF_NO_INDEX_EXPLICIT ?
-					"--no-index" : "[--no-index]");
-
+	if (no_index && argc != i + 2) {
+		if (no_index == DIFF_NO_INDEX_IMPLICIT) {
+			/*
+			 * There was no --no-index and there were not two
+			 * paths. It is possible that the user intended
+			 * to do an inside-repository operation.
+			 */
+			fprintf(stderr, "Not a git repository\n");
+			fprintf(stderr,
+				"To compare two paths outside a working tree:\n");
 		}
+		/* Give the usage message for non-repository usage and exit. */
+		usagef("git diff %s <path> <path>",
+		       no_index == DIFF_NO_INDEX_EXPLICIT ?
+		       "--no-index" : "[--no-index]");
+
+	}
+	if (no_index)
 		/* If this is a no-index diff, just run it and exit there. */
 		diff_no_index(&rev, argc, argv, prefix);
-	}
 
 	/* Otherwise, we are doing the usual "git" diff */
 	rev.diffopt.skip_stat_unmatch = !!diff_auto_refresh_index;
-- 
1.8.5.4.g8639e57
