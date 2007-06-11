From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RFC] Teach diff to imply --find-copies-harder upon -C -C
Date: Mon, 11 Jun 2007 21:12:19 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706112109180.4059@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 11 22:15:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxqIm-0005Qn-2c
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 22:15:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbXFKUPk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 16:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbXFKUPk
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 16:15:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:35419 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751449AbXFKUPj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 16:15:39 -0400
Received: (qmail invoked by alias); 11 Jun 2007 20:15:37 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp023) with SMTP; 11 Jun 2007 22:15:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18tbv57HN8tKi5NKU3r2PkJ3IzFPfP9o+vBvMEULj
	/3TLXavjKwqOhJ
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49882>


earlier, a second "-C" on the command line had no effect. But since I use 
"--find-copies-harder" quite a bit, and it is so long to type, and I am
an inherently lazy person, I'd like the second "-C" to be a shortcut for 
"--find-copies-harder".

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 diff.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 1d234d3..4aa9bbc 100644
--- a/diff.c
+++ b/diff.c
@@ -2201,6 +2201,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->detect_rename = DIFF_DETECT_RENAME;
 	}
 	else if (!prefixcmp(arg, "-C")) {
+		if (options->detect_rename == DIFF_DETECT_COPY)
+			options->find_copies_harder = 1;
 		if ((options->rename_score =
 		     diff_scoreopt_parse(arg)) == -1)
 			return -1;
