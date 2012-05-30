From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] docs/clone: mention that --local may be ignored
Date: Wed, 30 May 2012 07:09:08 -0400
Message-ID: <20120530110907.GA15550@sigill.intra.peff.net>
References: <20120530110305.GA13445@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Emeric Fermas <emeric.fermas@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 30 13:09:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZgmD-0000ny-4X
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 13:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752758Ab2E3LJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 07:09:13 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:36243
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752687Ab2E3LJM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 07:09:12 -0400
Received: (qmail 3793 invoked by uid 107); 30 May 2012 11:09:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 May 2012 07:09:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 May 2012 07:09:08 -0400
Content-Disposition: inline
In-Reply-To: <20120530110305.GA13445@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198799>

The --local flag is not "treat this like a local
repository", but rather "if we are local, turn on
optimizations". Therefore it does nothing in the case of:

  git clone --local file:///path/to/repo

Let's make that more clear in the documentation.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-clone.txt | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 6e22522..1d267f4 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -46,13 +46,16 @@ OPTIONS
 	mechanism and clones the repository by making a copy of
 	HEAD and everything under objects and refs directories.
 	The files under `.git/objects/` directory are hardlinked
-	to save space when possible.  This is now the default when
-	the source repository is specified with `/path/to/repo`
-	syntax, so it essentially is a no-op option.  To force
-	copying instead of hardlinking (which may be desirable
-	if you are trying to make a back-up of your repository),
-	but still avoid the usual "git aware" transport
-	mechanism, `--no-hardlinks` can be used.
+	to save space when possible.
++
+If the repository is specified as a local path (e.g., `/path/to/repo`),
+this is the default, and --local is essentially a no-op.  If the
+repository is specified as a URL, then this flag is ignored (and we
+never use the local optimizations).
++
+To force copying instead of hardlinking (which may be desirable if you
+are trying to make a back-up of your repository), but still avoid the
+usual "git aware" transport mechanism, `--no-hardlinks` can be used.
 
 --no-hardlinks::
 	Optimize the cloning process from a repository on a
-- 
1.7.11.rc0.12.g6048c92
