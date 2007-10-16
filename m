From: Andrew Clausen <clausen@econ.upenn.edu>
Subject: [PATCH] helpful error message when send-pack finds no refs in common.
Date: Tue, 16 Oct 2007 17:31:39 -0400
Message-ID: <20071016213139.GF13454@econ.upenn.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tNQTSEo8WG/FKZ8E"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 17 00:37:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihv2D-0004yY-95
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 00:37:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755668AbXJPWg7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 18:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754223AbXJPWg6
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 18:36:58 -0400
Received: from MAIL2.sas.upenn.edu ([128.91.55.27]:64317 "EHLO
	mail2.sas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789AbXJPWg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 18:36:58 -0400
X-Greylist: delayed 3916 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Oct 2007 18:36:57 EDT
Received: (from clausen@localhost)
	by mail2.sas.upenn.edu (8.10.1/8.10.1/SAS.05) id l9GLVd424516
	for git@vger.kernel.org; Tue, 16 Oct 2007 17:31:39 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61270>


--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

Please cc me, I'm not subscribed.

git-push fails when pushing into an empty repository if you don't specify
a branch:

	git --bare init some-repo

	git-push some-repo

To get this to work, you need to do

	git-push some-repo master

I attached a patch so that the error message suggests trying the latter.

Cheers,
Andrew


--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-helpful-error-message-when-send-pack-finds-no-refs-i.patch"

>From ee888ea1a7d2e75a0439569e36eabe4620e8f833 Mon Sep 17 00:00:00 2001
Date: Tue, 16 Oct 2007 17:16:05 -0400
Subject: [PATCH] helpful error message when send-pack finds no refs in common.
Signed-off-by: Andrew Clausen <clausen@econ.upenn.edu>

---
 send-pack.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index f74e66a..f0b0825 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -204,7 +204,8 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
 		return -1;
 
 	if (!remote_refs) {
-		fprintf(stderr, "No refs in common and none specified; doing nothing.\n");
+		fprintf(stderr,
+			"No refs in common and none specified; doing nothing.\n"			"Perhaps you should specify a branch such as 'master'.\n");
 		return 0;
 	}
 
-- 
1.5.3.1


--tNQTSEo8WG/FKZ8E--
