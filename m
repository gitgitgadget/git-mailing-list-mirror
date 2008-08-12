From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: [PATCH 2/2] Teach git diff about BibTeX head hunk patterns
Date: Tue, 12 Aug 2008 16:24:26 +0200
Message-ID: <1218551066-13012-2-git-send-email-hendeby@isy.liu.se>
References: <1218551066-13012-1-git-send-email-hendeby@isy.liu.se>
Cc: Gustaf Hendeby <hendeby@isy.liu.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 12 16:25:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSuoi-00066H-EY
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 16:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860AbYHLOYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 10:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752029AbYHLOYc
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 10:24:32 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:37674 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651AbYHLOYa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 10:24:30 -0400
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 236F525A6A
	for <git@vger.kernel.org>; Tue, 12 Aug 2008 16:24:28 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 20151-02; Sun, 31 Dec 1967 01:00:02 +0100 (MET)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	by bogotron.isy.liu.se (Postfix) with ESMTP id B1F6225A63;
	Tue, 12 Aug 2008 16:24:26 +0200 (MEST)
Received: by pluring.isy.liu.se (Postfix, from userid 2087)
	id 9E64A2ED76; Tue, 12 Aug 2008 16:24:26 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc2.37.gbb9f5.dirty
In-Reply-To: <1218551066-13012-1-git-send-email-hendeby@isy.liu.se>
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92100>

All BibTeX entries starts with an @ followed by an entry type.  Since
there are many entry types and own can be defined, the pattern matches
legal entry type names instead of just the default types (which would
be a long list).  The pattern also matches strings and comments since
they will also be useful to position oneself in a bib-file.

Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>
---

I know this is the wrong time to introduce something new, late in the
rc cycle.  However I had it bundled with the documentation update I
think should be considered now.  Feel free to ignore for the moment
and I'll resend post 1.6.0.

A quick question here is what the policy there is for introducing new
built in head hunk patterns, and if a BibTeX pattern fits there.  If
not, may I suggest a list somewhere with suggested patterns so that
each user doesn't have to reinvent the wheel?

/Gustaf

 Documentation/gitattributes.txt |    2 ++
 diff.c                          |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index c61a58d..db16b0c 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -310,6 +310,8 @@ configuration file (you still need to enable this with the
 attribute mechanism, via `.gitattributes`).  The following built in
 patterns are available:
 
+- `bibtex` suitable for files with BibTeX coded references.
+
 - `java` suitable for source code in the Java lanugage.
 
 - `pascal` suitable for source code in the Pascal/Delphi language.
diff --git a/diff.c b/diff.c
index 6954f99..fa8c620 100644
--- a/diff.c
+++ b/diff.c
@@ -1387,7 +1387,7 @@ static struct builtin_funcname_pattern {
 			"\\|"
 			"^\\(.*=[ \t]*\\(class\\|record\\).*\\)$"
 			},
+	{ "bibtex", "\\(@[a-zA-Z]\\{1,\\}[ \t]*{\\{0,1\\}[ \t]*[^ \t\"@',\\#}{~%]*\\).*$" },
 	{ "tex", "^\\(\\\\\\(\\(sub\\)*section\\|chapter\\|part\\)\\*\\{0,1\\}{.*\\)$" },
 	{ "ruby", "^\\s*\\(\\(class\\|module\\|def\\)\\s.*\\)$" },
 };
-- 
1.6.0.rc2.30.gf3f0.dirty
