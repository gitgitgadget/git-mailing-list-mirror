From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: [PATCH] parsecvs: produce tagger fields acceptable to newer git versions
Date: Mon, 19 Jan 2009 13:02:17 +0100
Message-ID: <20090119120217.GD4390@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jay@gnu.org, jim@meyering.net,
	kedars@marvell.com
To: keithp@keithp.com
X-From: git-owner@vger.kernel.org Mon Jan 19 13:25:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOtBf-00019S-3h
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 13:25:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755408AbZASMXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 07:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754762AbZASMXj
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 07:23:39 -0500
Received: from xi.wantstofly.org ([80.101.37.227]:58737 "EHLO
	xi.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754789AbZASMXj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 07:23:39 -0500
X-Greylist: delayed 1280 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Jan 2009 07:23:38 EST
Received: by xi.wantstofly.org (Postfix, from userid 500)
	id 97C087FABA; Mon, 19 Jan 2009 13:02:17 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106350>

Signed-off-by: Lennert Buytenhek <buytenh@marvell.com>

diff --git a/git.c b/git.c
index da320d1..8f94d1b 100644
--- a/git.c
+++ b/git.c
@@ -371,11 +371,13 @@ git_mktag (rev_commit *commit, char *name)
 		"object %s\n"
 		"type commit\n"
 		"tag %s\n"
-		"tagger %s\n"
+		"tagger %s <%s> %lu +0000\n"
 		"\n",
 		commit->sha1,
 		name,
-		author ? author->full : commit->author);
+		author ? author->full : commit->author,
+		author ? author->email : commit->author,
+		commit->date);
     if (rv < 1) {
 	fprintf (stderr, "%s: %s\n", filename, strerror (errno));
 	fclose (f);
