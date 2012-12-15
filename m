From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] Documentation: don't link to example mail addresses
Date: Sat, 15 Dec 2012 15:03:15 +0000
Message-ID: <20121215150314.GC2725@river.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 15 16:03:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjtHF-0004SG-28
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 16:03:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754147Ab2LOPDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 10:03:20 -0500
Received: from woodbine.london.02.net ([87.194.255.145]:39159 "EHLO
	woodbine.london.02.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090Ab2LOPDR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 10:03:17 -0500
Received: from river.lan (188.222.177.116) by woodbine.london.02.net (8.5.140)
        id 4FED9DF1046A4C11; Sat, 15 Dec 2012 15:03:15 +0000
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211533>

Mail addresses in documentation are converted into mailto: hyperlinks in
the HTML output and footnotes in man pages.  This isn't desirable for
cases where the address is used as an example and is not valid.

Particularly annoying is the example "jane@laptop.(none)" which appears
in git-shortlog(1) as "jane@laptop[1].(none)", with note 1 saying:

	1. jane@laptop
	   mailto:jane@laptop

Fix this by quoting example mail addresses with "$$", preventing
Asciidoc from processing them.

In the case of mailmap.txt, render the address monospaced so that it
matches the block examples surrounding that paragraph.

Signed-off-by: John Keeping <john@keeping.me.uk>
---

I can't see any other uses of the "$$" quote in the documentation, so
it's probably worth noting that I've tested this with Asciidoc 8.6.8,
although I can't see anything in the changelog to indicate that
Asciidoc's treatment of it has changed recently.

 Documentation/git-fast-import.txt | 2 +-
 Documentation/git-tag.txt         | 2 +-
 Documentation/mailmap.txt         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index d1844ea..05913cc 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -427,7 +427,7 @@ they made it.
 
 Here `<name>` is the person's display name (for example
 ``Com M Itter'') and `<email>` is the person's email address
-(``cm@example.com'').  `LT` and `GT` are the literal less-than (\x3c)
+(``$$cm@example.com$$'').  `LT` and `GT` are the literal less-than (\x3c)
 and greater-than (\x3e) symbols.  These are required to delimit
 the email address from the other fields in the line.  Note that
 `<name>` and `<email>` are free-form and may contain any sequence
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 247534e..ed63edb 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -129,7 +129,7 @@ This option is only applicable when listing tags without annotation lines.
 CONFIGURATION
 -------------
 By default, 'git tag' in sign-with-default mode (-s) will use your
-committer identity (of the form "Your Name <your@email.address>") to
+committer identity (of the form "Your Name $$<your@email.address>$$") to
 find a key.  If you want to use a different default key, you can specify
 it in the repository configuration as follows:
 
diff --git a/Documentation/mailmap.txt b/Documentation/mailmap.txt
index 288f04e..dd89fca 100644
--- a/Documentation/mailmap.txt
+++ b/Documentation/mailmap.txt
@@ -46,7 +46,7 @@ Jane Doe         <jane@desktop.(none)>
 Joe R. Developer <joe@example.com>
 ------------
 
-Note how there is no need for an entry for <jane@laptop.(none)>, because the
+Note how there is no need for an entry for `<jane@laptop.(none)>`, because the
 real name of that author is already correct.
 
 Example 2: Your repository contains commits from the following
-- 
1.8.0
