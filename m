From: Johan Herland <johan@herland.net>
Subject: [PATCHv6 09/14] Add '%N'-format for pretty-printing commit notes
Date: Sat, 12 Sep 2009 18:08:43 +0200
Message-ID: <1252771728-27206-10-git-send-email-johan@herland.net>
References: <200909121752.07523.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Sep 12 18:10:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmVAd-0008SS-1e
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 18:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750AbZILQJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 12:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754698AbZILQJd
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 12:09:33 -0400
Received: from smtp.getmail.no ([84.208.15.66]:39547 "EHLO
	get-mta-out03.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754651AbZILQJZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Sep 2009 12:09:25 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPV003BG8VRQZ70@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Sat, 12 Sep 2009 18:09:27 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPV0048W8V0EM30@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 12 Sep 2009 18:09:27 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.9.12.155718
X-Mailer: git-send-email 1.6.4.304.g1365c.dirty
In-reply-to: <200909121752.07523.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128268>

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
