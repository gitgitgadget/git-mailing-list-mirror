From: Jeff King <peff@peff.net>
Subject: [PATCH] Documentation/git-diff: remove -r from --name-status
	example
Date: Sat, 28 Jul 2007 20:24:27 -0400
Message-ID: <20070729002427.GA1566@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jon Smirl <jonsmirl@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 29 02:24:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEwaS-0002B2-DW
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 02:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758155AbXG2AYb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 20:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758143AbXG2AYa
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 20:24:30 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2881 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754436AbXG2AYa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 20:24:30 -0400
Received: (qmail 21567 invoked from network); 29 Jul 2007 00:24:30 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 29 Jul 2007 00:24:30 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Jul 2007 20:24:27 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54069>

Calling 'git-diff --name-status' will recursively show any
changes already, and it has for quite some time (at least as
far back as v1.4.1).

Signed-off-by: Jeff King <peff@peff.net>
---
On Sat, Jul 28, 2007 at 05:26:27PM +0200, Jakub Narebski wrote:

> > How about --name-status?
> 
> Or -r --name-status?

The '-r' now seems to be superfluous. I checked using the following
script:

  mkdir repo && cd repo && git-init &&
    touch root && git-add root && git-commit -m root &&
    mkdir sub && touch sub/file && git-add sub/file &&
    git-diff --cached --name-status

And it correctly reports

  A sub/file

at least since v1.4.1. I didn't look further, but the example is from
the 0.99 era, so I suspect this behavior was changed with the
libification of the revision machinery and the reworking of git-diff.

Or maybe I just totally don't understand what '-r' is supposed to be
doing.

 Documentation/git-diff.txt |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 639b969..b1f5e7f 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -102,17 +102,14 @@ Limiting the diff output::
 +
 ------------
 $ git diff --diff-filter=MRC            <1>
-$ git diff --name-status -r             <2>
+$ git diff --name-status                <2>
 $ git diff arch/i386 include/asm-i386   <3>
 ------------
 +
 <1> show only modification, rename and copy, but not addition
 nor deletion.
 <2> show only names and the nature of change, but not actual
-diff output.  --name-status disables usual patch generation
-which in turn also disables recursive behavior, so without -r
-you would only see the directory name if there is a change in a
-file in a subdirectory.
+diff output.
 <3> limit diff output to named subtrees.
 
 Munging the diff output::
-- 
1.5.3.rc3.845.g88e3-dirty
