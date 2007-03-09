From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/3] git-bundle: handle thin packs in subcommand "unbundle"
Date: Fri, 9 Mar 2007 03:48:27 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703090347430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 09 03:48:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPV9p-00034O-IQ
	for gcvg-git@gmane.org; Fri, 09 Mar 2007 03:48:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992900AbXCICsa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 21:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992903AbXCICsa
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 21:48:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:44070 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2992900AbXCICs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 21:48:29 -0500
Received: (qmail invoked by alias); 09 Mar 2007 02:48:27 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 09 Mar 2007 03:48:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/iQxpoVv/ii+4dKvX5kY9GI6HSCauRT99IlM6jO1
	kkj8J1khxdXTrn
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41780>


The patch to make the packs in a bundle thin forgot the receiving side.
D'oh.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This starts a series of three brown paper bag patches.

 builtin-bundle.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-bundle.c b/builtin-bundle.c
index 6163358..33b533f 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -374,7 +374,8 @@ static int create_bundle(struct bundle_header *header, const char *path,
 static int unbundle(struct bundle_header *header, int bundle_fd,
 		int argc, const char **argv)
 {
-	const char *argv_index_pack[] = {"index-pack", "--stdin", NULL};
+	const char *argv_index_pack[] = {"index-pack",
+		"--fix-thin", "--stdin", NULL};
 	int pid, status, dev_null;
 
 	if (verify_bundle(header, 0))
-- 
1.5.0.3.2601.gc1e5-dirty
