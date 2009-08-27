From: Johan Herland <johan@herland.net>
Subject: [PATCHv4 12/12] Add '%N'-format for pretty-printing commit notes
Date: Thu, 27 Aug 2009 03:43:57 +0200
Message-ID: <1251337437-16947-13-git-send-email-johan@herland.net>
References: <1251337437-16947-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 27 03:45:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgU2v-0004PF-DH
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 03:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbZH0Bor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 21:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbZH0Bop
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 21:44:45 -0400
Received: from smtp.getmail.no ([84.208.15.66]:52531 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932103AbZH0Bom (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Aug 2009 21:44:42 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KP0002BLI6JTPA0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 27 Aug 2009 03:44:43 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KP000MW0I5F4H50@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 27 Aug 2009 03:44:43 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.27.13316
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
In-reply-to: <1251337437-16947-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127138>

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/pretty-formats.txt |    1 +
 pretty.c                         |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 2a845b1..5fb10b3 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -123,6 +123,7 @@ The placeholders are:
 - '%s': subject
 - '%f': sanitized subject line, suitable for a filename
 - '%b': body
+- '%N': commit notes
 - '%Cred': switch color to red
 - '%Cgreen': switch color to green
 - '%Cblue': switch color to blue
diff --git a/pretty.c b/pretty.c
index 01eadd0..7f350bb 100644
--- a/pretty.c
+++ b/pretty.c
@@ -702,6 +702,10 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 	case 'd':
 		format_decoration(sb, commit);
 		return 1;
+	case 'N':
+		get_commit_notes(commit, sb, git_log_output_encoding ?
+			     git_log_output_encoding : git_commit_encoding, 0);
+		return 1;
 	}
 
 	/* For the rest we have to parse the commit header. */
-- 
1.6.4.304.g1365c.dirty
