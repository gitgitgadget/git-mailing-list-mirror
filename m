From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 4/5] Retain extra blank lines between the summary and the
 body
Date: Mon, 18 Feb 2008 22:56:10 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802182254240.5816@iabervon.org>
References: <cover.1203392527.git.barkalow@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 04:57:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRJbT-0002Fp-Qy
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 04:57:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754290AbYBSD4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 22:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754318AbYBSD42
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 22:56:28 -0500
Received: from iabervon.org ([66.92.72.58]:54156 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754198AbYBSD4L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 22:56:11 -0500
Received: (qmail 22308 invoked by uid 1000); 19 Feb 2008 03:56:10 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Feb 2008 03:56:10 -0000
In-Reply-To: <cover.1203392527.git.barkalow@iabervon.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74370>

This is so that it's possible to have a message that will generate an
email with the first line blank. If the email you're generating is
actually a template, you may have a single line filling in for a
~3-line paragraph, meaning that the space starts with a blank line,
which was impossible before as output from the message-splitting code.

Furthermore, extra blank lines that aren't at the beginning of the
body portion aren't stripped, so this is more consistant overall.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 pretty.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/pretty.c b/pretty.c
index d5db1bd..1c57920 100644
--- a/pretty.c
+++ b/pretty.c
@@ -713,7 +713,6 @@ void pp_remainder(enum cmit_fmt fmt,
 		  struct strbuf *sb,
 		  int indent)
 {
-	int first = 1;
 	for (;;) {
 		const char *line = *msg_p;
 		int linelen = get_one_line(line);
@@ -723,12 +722,9 @@ void pp_remainder(enum cmit_fmt fmt,
 			break;
 
 		if (is_empty_line(line, &linelen)) {
-			if (first)
-				continue;
 			if (fmt == CMIT_FMT_SHORT)
 				break;
 		}
-		first = 0;
 
 		strbuf_grow(sb, linelen + indent + 20);
 		if (indent) {
-- 
1.5.4.1.191.gfbf10
