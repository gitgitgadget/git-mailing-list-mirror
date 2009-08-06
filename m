From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Show usage string for 'git log -h', 'git show -h' and 'git diff -h'
Date: Thu,  6 Aug 2009 12:47:21 +0200
Message-ID: <1249555641-342-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 06 12:47:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ0Va-0002hl-4u
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 12:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415AbZHFKre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 06:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbZHFKrd
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 06:47:33 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56071 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751332AbZHFKrd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 06:47:33 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n76AkYiQ010614
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 6 Aug 2009 12:46:34 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MZ0VH-00053r-Dz; Thu, 06 Aug 2009 12:47:23 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MZ0VH-00011g-Bl; Thu, 06 Aug 2009 12:47:23 +0200
X-Mailer: git-send-email 1.6.4.55.gc63c6.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 06 Aug 2009 12:46:35 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n76AkYiQ010614
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1250160397.74711@r4SmMfaeZsK1uxiO7QWq5g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125063>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 builtin-diff.c |    2 ++
 builtin-log.c  |    6 ++++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/builtin-diff.c b/builtin-diff.c
index 2e51f40..ffcdd05 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -218,6 +218,8 @@ static int builtin_diff_files(struct rev_info *revs, int argc, const char **argv
 			revs->max_count = 3;
 		else if (!strcmp(argv[1], "-q"))
 			options |= DIFF_SILENT_ON_REMOVED;
+		else if (!strcmp(argv[1], "-h"))
+			usage(builtin_diff_usage);
 		else
 			return error("invalid option: %s", argv[1]);
 		argv++; argc--;
diff --git a/builtin-log.c b/builtin-log.c
index 3035816..3817bf1 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -27,6 +27,10 @@ static int default_show_root = 1;
 static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
 
+static const char * const builtin_log_usage =
+	"git log [<options>] [<since>..<until>] [[--] <path>...]\n"
+	"   or: git show [options] <object>...";
+
 static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		      struct rev_info *rev)
 {
@@ -61,6 +65,8 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 			rev->show_decorations = 1;
 		} else if (!strcmp(arg, "--source")) {
 			rev->show_source = 1;
+		} else if (!strcmp(arg, "-h")) {
+			usage(builtin_log_usage);
 		} else
 			die("unrecognized argument: %s", arg);
 	}
-- 
1.6.4.55.gc63c6.dirty
