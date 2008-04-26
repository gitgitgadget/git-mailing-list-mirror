From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git-format-patch: add a new format.cc configuration variable
Date: Sat, 26 Apr 2008 23:19:06 +0200
Message-ID: <1209244746-12649-1-git-send-email-vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 23:20:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JproX-0006yE-9r
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 23:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbYDZVTW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2008 17:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbYDZVTW
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 17:19:22 -0400
Received: from virgo.iok.hu ([193.202.89.103]:45229 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751214AbYDZVTV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2008 17:19:21 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 8EB841B25A1;
	Sat, 26 Apr 2008 23:19:20 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 2F9E344659;
	Sat, 26 Apr 2008 23:15:42 +0200 (CEST)
Received: from vmobile.example.net (dsl5401CCC2.pool.t-online.hu [84.1.204.194])
	by genesis.frugalware.org (Postfix) with ESMTP id DE83B11901AE;
	Sat, 26 Apr 2008 23:19:19 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 8FE01186104; Sat, 26 Apr 2008 23:19:06 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80394>

Some projects prefer to always CC patches to a given mailing list. In
these cases, it's handy to configure that address once.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Documentation/git-format-patch.txt |    1 +
 builtin-log.c                      |    7 +++++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index b5207b7..b2bdcb2 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -168,6 +168,7 @@ and file suffix, and number patches when outputting more than one.
         subjectprefix = CHANGE
         suffix = .txt
         numbered = auto
+        cc = <email>
 ------------
 
 
diff --git a/builtin-log.c b/builtin-log.c
index 1670d0b..d7907c9 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -485,6 +485,13 @@ static int git_format_config(const char *var, const char *value)
 		fmt_patch_suffix = xstrdup(value);
 		return 0;
 	}
+	if (!strcmp(var, "format.cc")) {
+		if (!value)
+			return config_error_nonbool(var);
+		ALLOC_GROW(extra_cc, extra_cc_nr + 1, extra_cc_alloc);
+		extra_cc[extra_cc_nr++] = xstrdup(value);
+		return 0;
+	}
 	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
 		return 0;
 	}
-- 
1.5.5.1.91.g499fc.dirty
