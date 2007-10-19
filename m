From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] Documentation/git-gc: improve description of --auto
Date: Thu, 18 Oct 2007 22:05:10 -0400
Message-ID: <20071019020510.GB7711@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steven Grimm <koreth@midwinter.com>,
	Brian Gernhardt <benji@silverinsanity.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 04:06:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IihFY-0005uO-Rs
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 04:06:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965706AbXJSCFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 22:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965715AbXJSCFP
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 22:05:15 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3710 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965702AbXJSCFN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 22:05:13 -0400
Received: (qmail 7223 invoked by uid 111); 19 Oct 2007 02:05:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 18 Oct 2007 22:05:11 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2007 22:05:10 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61599>

This patch tries to make the description of --auto a little
more clear for new users, especially those referred by the
"git-gc --auto" notification message.

It also cleans up some grammatical errors and typos in the
original description, as well as rewording for clarity.

Signed-off-by: Jeff King <peff@peff.net>
---
I started by just trying to fix a couple of grammar issues, but it
seemed quite awkward, and somehow this came out. I think it reads better
than the original, but I'm open to comment.

It is a little bit odd that there is so much low-level detail in the
'--auto' description versus the rest of the page. But I think it reads
OK. Also note that the previous incarnation (and my changes) use the
`foo` form to monospace arguments, while the rest of the page uses 'foo'
(which actually means emphasis). I think the former is more correct, but
asciidoc renders the latter much more pleasantly in manpages. I will see
if I can tweak asciidoc to make this look better.

 Documentation/git-gc.txt |   29 +++++++++++++++++------------
 1 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 83843a5..872056e 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -45,18 +45,23 @@ OPTIONS
 	few hundred changesets or so.
 
 --auto::
-	With this option, `git gc` checks if there are too many
-	loose objects in the repository and runs
-	gitlink:git-repack[1] with `-d -l` option to pack them.
-	The threshold for loose objects is set with `gc.auto` configuration
-	variable, and can be disabled by setting it to 0.  Some
-	Porcelain commands use this after they perform operation
-	that could create many loose objects automatically.
-	Additionally, when there are too many packs are present,
-	they are consolidated into one larger pack by running
-	the `git-repack` command with `-A` option.  The
-	threshold for number of packs is set with
-	`gc.autopacklimit` configuration variable.
+	With this option, `git gc` checks whether any housekeeping is
+	required; if not, it exits without performing any work.
+	Some git commands run `git gc --auto` after performing
+	operations that could create many loose objects.
++
+Housekeeping is required if there are too many loose objects or
+too many packs in the repository. If the number of loose objects
+exceeds the value of the `gc.auto` configuration variable, then
+all loose objects are combined into a single pack using
+`git-repack -d -l`.  Setting the value of `gc.auto` to 0
+disables automatic packing of loose objects.
++
+If the number of packs exceeds the value of `gc.autopacklimit`,
+then existing packs (except those marked with a `.keep` file)
+are consolidated into a single pack by using the `-A` option of
+`git-repack`. Setting `gc.autopacklimit` to 0 disables
+automatic consolidation of packs.
 
 Configuration
 -------------
-- 
1.5.3.4.1249.g895be-dirty
