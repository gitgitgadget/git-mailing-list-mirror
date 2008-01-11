From: "Stephen Sinclair" <radarsat1@gmail.com>
Subject: [PATCH] Add committer and author names to top of COMMIT_EDITMSG.
Date: Fri, 11 Jan 2008 15:10:53 -0500
Message-ID: <9b3e2dc20801111210n7bd7a71cw437819aa6253ae85@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 21:11:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDQDq-0005U7-2C
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 21:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757885AbYAKUKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 15:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757128AbYAKUKy
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 15:10:54 -0500
Received: from rv-out-0910.google.com ([209.85.198.188]:31721 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754090AbYAKUKy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 15:10:54 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1038551rvb.1
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 12:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=FWEBr0gczOGQOGjH+epfBbOQj4+zS2nh4DDxEooEa48=;
        b=M2u4k6Aa6/FHkA7jYRU7join3eFwmpRTCG7fnfRBB/G8zXAiDFAQMTqqFnJN3Qw7xfUrnueDH7CATBz3CJE7sVXWsNMgwxPGBq5nxfmb14r2dnKdcm/ZeXabb9uUBEclESBqP4JlZC5YIuB1HExLkw0fVBeuh8ZJ8bXRYB9JxS8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JnnaxwuaOG4C50+Zx2qd+Om4W1mS47fS0K3FNss3rexNyShFng0AXrHi+tEcQamozCHNb/gSGSUb+93ZSqPxEiL5v9pK9Y5w/ejcl2X9/sTT0U+OpPBPnHkfvi7y5FYHCYSBvpsCocDNSnEtlykROdlFgfKrZTg3O/UCMFE1JS4=
Received: by 10.140.139.3 with SMTP id m3mr2270241rvd.38.1200082253087;
        Fri, 11 Jan 2008 12:10:53 -0800 (PST)
Received: by 10.140.188.1 with HTTP; Fri, 11 Jan 2008 12:10:53 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70196>

Add committer and author names to top of COMMIT_EDITMSG.

Signed-off-by: Stephen Sinclair <radarsat1@gmail.com>
---
 builtin-commit.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 73f1e35..4fd9367 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -423,8 +423,18 @@ static int prepare_log_message(const char
*index_file, const char *prefix)
 			"#\n",
 			git_path("MERGE_HEAD"));

+    fprintf(fp, "\n");
+
+    fprintf(fp,
+            "# Committer: %s\n"
+            "# Author:    %s\n"
+            "#\n",
+            fmt_name(getenv("GIT_AUTHOR_NAME"),
+                     getenv("GIT_AUTHOR_EMAIL")),
+            fmt_name(getenv("GIT_COMMITTER_NAME"),
+                     getenv("GIT_COMMITTER_EMAIL")));
+
 	fprintf(fp,
-		"\n"
 		"# Please enter the commit message for your changes.\n"
 		"# (Comment lines starting with '#' will ");
 	if (cleanup_mode == CLEANUP_ALL)
-- 
1.5.4.rc2.85.ga7943-dirty
