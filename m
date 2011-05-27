From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] docs: make sure literal "->" isn't converted to arrow
Date: Thu, 26 May 2011 22:32:41 -0400
Message-ID: <20110527023241.GC25362@sigill.intra.peff.net>
References: <30543.1305828072@plover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 27 04:32:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPmr3-000390-LK
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 04:32:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758546Ab1E0Cco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 22:32:44 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59482
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753081Ab1E0Ccn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 22:32:43 -0400
Received: (qmail 20759 invoked by uid 107); 27 May 2011 02:32:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 May 2011 22:32:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2011 22:32:41 -0400
Content-Disposition: inline
In-Reply-To: <30543.1305828072@plover.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174597>

Recent versions of asciidoc will treat "->" as a
single-glyph arrow symbol, unless it is inside a literal
code block. This is a problem if we are discussing literal
output and want to show the ASCII characters.

Our usage falls into three categories:

  1. Inside a code block. These can be left as-is.

  2. Discussing literal output or code, but inside a
     paragraph. This patch escapes these as "\->".

  3. Using the arrow as a symbolic element, such as "use the
     Edit->Account Settings menu". In this case, the
     arrow symbol is preferable, so we leave it as-is.

Signed-off-by: Jeff King <peff@peff.net>
---
I noticed this while checking the output of my git-status.txt changes.
No idea when asciidoc started doing this (I am running 8.6.4 from debian
unstable).

 Documentation/git-cvsserver.txt |    2 +-
 Documentation/git-status.txt    |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 88d814a..827bc98 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -252,7 +252,7 @@ Configuring database backend
 
 'git-cvsserver' uses the Perl DBI module. Please also read
 its documentation if changing these variables, especially
-about `DBI->connect()`.
+about `DBI\->connect()`.
 
 gitcvs.dbname::
 	Database name. The exact meaning depends on the
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index edacf6b..38cb741 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -94,12 +94,12 @@ In the short-format, the status of each path is shown as
 
 	XY PATH1 -> PATH2
 
-where `PATH1` is the path in the `HEAD`, and the ` -> PATH2` part is
+where `PATH1` is the path in the `HEAD`, and the ` \-> PATH2` part is
 shown only when `PATH1` corresponds to a different path in the
 index/worktree (i.e. the file is renamed). The 'XY' is a two-letter
 status code.
 
-The fields (including the `->`) are separated from each other by a
+The fields (including the `\->`) are separated from each other by a
 single space. If a filename contains whitespace or other nonprintable
 characters, that field will be quoted in the manner of a C string
 literal: surrounded by ASCII double quote (34) characters, and with
@@ -165,8 +165,8 @@ format, with a few exceptions:
 
 There is also an alternate -z format recommended for machine parsing. In
 that format, the status field is the same, but some other things
-change.  First, the '->' is omitted from rename entries and the field
-order is reversed (e.g 'from -> to' becomes 'to from'). Second, a NUL
+change.  First, the '\->' is omitted from rename entries and the field
+order is reversed (e.g 'from \-> to' becomes 'to from'). Second, a NUL
 (ASCII 0) follows each filename, replacing space as a field separator
 and the terminating newline (but a space still separates the status
 field from the first filename).  Third, filenames containing special
-- 
1.7.4.5.26.g0c6a2
