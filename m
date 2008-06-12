From: Stephan Beyer <s-beyer@gmx.net>
Subject: [RFC/PATCH] git-commit: Change --reuse-message to --reuse-commit.
Date: Thu, 12 Jun 2008 17:38:51 +0200
Message-ID: <1213285131-32051-1-git-send-email-s-beyer@gmx.net>
References: <20080612152928.GB6848@leksak.fem-net>
Cc: Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 17:39:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6oty-0007ut-5M
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 17:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722AbYFLPi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 11:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752834AbYFLPi4
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 11:38:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:46561 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751636AbYFLPiz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 11:38:55 -0400
Received: (qmail invoked by alias); 12 Jun 2008 15:38:53 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp048) with SMTP; 12 Jun 2008 17:38:53 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18PA19hEBwPs05Ew/nuoTJLcWkcqWo7sg8NjV36dz
	1cDXRAIgoK6TVs
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K6ot1-0008MW-V9; Thu, 12 Jun 2008 17:38:51 +0200
X-Mailer: git-send-email 1.5.5.1.510.g15d7.dirty
In-Reply-To: <20080612152928.GB6848@leksak.fem-net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84762>

The reason for the change is, that --reuse-message is
misleading, because the long option name does not tell
the user, that the authorship information is kept.
---
Hi,

I can imagine the negative feedback as
 * don't change long-time-used options
 * --reuse-commit, but --reedit-message?
 * ...

But I want to give it a try ;-)
 1. I think that the --reuse-message long option 
    is not used by anyone, but you can quickly generate
    a counterexample :)
    
    Why not used? Because it was not documented in 
    git-commit.txt until "Sun Jun 8 03:36:08 2008 +0200"
    (git show bc47c29).
 2. Later we could add something like -M/--reuse-message
    that just reuses the message and not the authorship.

See also the parent mail.
  http://article.gmane.org/gmane.comp.version-control.git/84760

Regards,
  Stephan

 Documentation/git-commit.txt |    2 +-
 builtin-commit.c             |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 7e8b4ff..f713f40 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -59,7 +59,7 @@ OPTIONS
 	told git about are not affected.
 
 -C <commit>::
---reuse-message=<commit>::
+--reuse-commit=<commit>::
 	Take an existing commit object, and reuse the log message
 	and the authorship information (including the timestamp)
 	when creating the commit.
diff --git a/builtin-commit.c b/builtin-commit.c
index 90200ed..9c0b2da 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -90,7 +90,7 @@ static struct option builtin_commit_options[] = {
 	OPT_STRING(0, "author", &force_author, "AUTHOR", "override author for commit"),
 	OPT_CALLBACK('m', "message", &message, "MESSAGE", "specify commit message", opt_parse_m),
 	OPT_STRING('c', "reedit-message", &edit_message, "COMMIT", "reuse and edit message from specified commit "),
-	OPT_STRING('C', "reuse-message", &use_message, "COMMIT", "reuse message from specified commit"),
+	OPT_STRING('C', "reuse-commit", &use_message, "COMMIT", "reuse message from specified commit"),
 	OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
 	OPT_STRING('t', "template", &template_file, "FILE", "use specified template file"),
 	OPT_BOOLEAN('e', "edit", &edit_flag, "force edit of commit"),
-- 
1.5.5.3
