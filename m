From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: [PATCH] Add Pascal/Delphi (.pas file) funcname pattern.
Date: Fri,  1 Aug 2008 17:00:15 -0400
Message-ID: <1217624415-14736-1-git-send-email-apenwarr@gmail.com>
Cc: "Avery Pennarun" <apenwarr@gmail.com>
To: <gitster@pobox.com>, <git@vger.kernel.org>, <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Aug 01 23:01:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP1ki-0005Mh-VZ
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 23:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756014AbYHAVAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 17:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755393AbYHAVAb
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 17:00:31 -0400
Received: from static-216-18-85-234.gtcust.grouptelecom.net ([216.18.85.234]:23301
	"EHLO mailhost.pwcorp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755956AbYHAVAb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2008 17:00:31 -0400
X-Brightmail-Tracker: AAAAAQAAA+k=
thread-index: Acj0GaSxvLCNT8H9QhGnzDGQraWBIg==
X-Language-Identified: TRUE
Received: from weaver.open.versabanq.com ([10.65.1.2]) by mailhost.pwcorp.com with Microsoft SMTPSVC(6.0.3790.3959); Fri, 1 Aug 2008 17:00:35 -0400
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4133
Content-Class: urn:content-classes:message
Importance: normal
Received: (qmail 15338 invoked from network); 1 Aug 2008 21:00:18 -0000
Received: from unknown (HELO weaver.open.versabanq.com) (10.65.1.2)  by weaver.open.versabanq.com with SMTP; 1 Aug 2008 21:00:18 -0000
Received: (qmail 15331 invoked from network); 1 Aug 2008 21:00:17 -0000
Received: from unknown (HELO weaver.open.versabanq.com) (10.65.1.2)  by weaver.open.versabanq.com with SMTP; 1 Aug 2008 21:00:17 -0000
Received: (qmail 15283 invoked from network); 1 Aug 2008 21:00:15 -0000
Received: from unknown (HELO stasis.open.versabanq.com) (10.65.1.127)  by weaver.open.versabanq.com with SMTP; 1 Aug 2008 21:00:15 -0000
Received: by stasis.open.versabanq.com (sSMTP sendmail emulation); Fri, 01 Aug 2008 17:00:15 -0400
X-Mailer: git-send-email 1.6.0.rc1.34.g5ccee.dirty
X-OriginalArrivalTime: 01 Aug 2008 21:00:35.0453 (UTC) FILETIME=[A4B1BAD0:01C8F419]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91099>

Finds classes, records, functions, procedures, and sections.  Most lines
need to start at the first column, or else there's no way to differentiate
a procedure's definition from its declaration.

Signed-off-by: Avery Pennarun <apenwarr@gmail.com>
---
 diff.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)
 
Changes since v1:

- Tried using '\n' to separate the two parts of the regex, but it doesn't
  work.  Seems the lines are combined with AND instead of OR.  Also can't
  reduce the number of parens since only the part in parens is returned
  as the result string.
  
- Rename 'pas' type to 'pascal'

- Remove unnecessary 'type' match.

diff --git a/diff.c b/diff.c
index cbf2547..2f88e6d 100644
--- a/diff.c
+++ b/diff.c
@@ -1380,6 +1380,12 @@ static struct builtin_funcname_pattern {
 			"^[ 	]*\\(\\([ 	]*"
 			"[A-Za-z_][A-Za-z_0-9]*\\)\\{2,\\}"
 			"[ 	]*([^;]*\\)$" },
+	{ "pascal", "^\\(\\(procedure\\|function\\|constructor\\|"
+			"destructor\\|interface\\|implementation\\|"
+			"initialization\\|finalization\\)[ \t]*.*\\)$"
+			"\\|"
+			"^\\(.*=[ \t]*\\(class\\|record\\).*\\)$" 
+			},
 	{ "tex", "^\\(\\\\\\(sub\\)*section{.*\\)$" },
 };
 
-- 
1.5.6
