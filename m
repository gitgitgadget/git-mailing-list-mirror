From: Thorsten Glaser <tg@debian.org>
Subject: [PATCH] builtin/tag.c: Add tag name to user message
Date: Fri, 30 Aug 2013 00:03:10 +0200
Message-ID: <201405070749.s477nvCL000897@herc.mirbsd.org>
Cc: Richard Hartmann <richih@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 10:05:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhwrQ-0003XV-Bw
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 10:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbaEGIFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 04:05:47 -0400
Received: from eurynome.mirbsd.org ([81.169.181.30]:43165 "EHLO
	eurynome.mirbsd.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbaEGIFp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 04:05:45 -0400
X-Greylist: delayed 884 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 May 2014 04:05:42 EDT
Received: from herc.mirbsd.org (root@herc.mirbsd.org [IPv6:2a01:198:25d:0:202:b3ff:feb7:54e8])
	by eurynome.mirbsd.org (8.14.5.Beta0/8.14.3) with ESMTP id s477on5P026590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Wed, 7 May 2014 07:50:54 GMT
Received: from herc.mirbsd.org (tg@localhost [IPv6:::1])
	by herc.mirbsd.org (8.14.5/8.14.5) with ESMTP id s477nwb5008378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 May 2014 07:50:01 GMT
Received: (from tg@localhost)
	by herc.mirbsd.org (8.14.5/8.14.5/Submit) id s477nvCL000897;
	Wed, 7 May 2014 07:49:57 GMT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248289>

Display the tag name about to be added to the user during interactive
editing.

Signed-off-by: Thorsten Glaser <tg@debian.org>
Signed-off-by: Richard Hartmann <richih@debian.org>
---
 builtin/tag.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 6c7c6bd..8a7265b 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -278,11 +278,11 @@ static int do_sign(struct strbuf *buffer)
 }
 
 static const char tag_template[] =
-	N_("\nWrite a tag message\n"
+	N_("\nWrite a message for tag:\n  %s\n"
 	"Lines starting with '%c' will be ignored.\n");
 
 static const char tag_template_nocleanup[] =
-	N_("\nWrite a tag message\n"
+	N_("\nWrite a message for tag:\n  %s\n"
 	"Lines starting with '%c' will be kept; you may remove them"
 	" yourself if you want to.\n");
 
@@ -378,9 +378,9 @@ static void create_tag(const unsigned char *object, const char *tag,
 			struct strbuf buf = STRBUF_INIT;
 			strbuf_addch(&buf, '\n');
 			if (opt->cleanup_mode == CLEANUP_ALL)
-				strbuf_commented_addf(&buf, _(tag_template), comment_line_char);
+				strbuf_commented_addf(&buf, _(tag_template), tag, comment_line_char);
 			else
-				strbuf_commented_addf(&buf, _(tag_template_nocleanup), comment_line_char);
+				strbuf_commented_addf(&buf, _(tag_template_nocleanup), tag, comment_line_char);
 			write_or_die(fd, buf.buf, buf.len);
 			strbuf_release(&buf);
 		}
-- 
2.0.0.rc0
