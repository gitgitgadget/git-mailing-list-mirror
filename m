From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] checkout: Do not show local changes when in quiet mode
Date: Thu, 25 Sep 2008 10:35:38 +0200
Message-ID: <20080925083537.GA10273@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 25 10:36:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KimLF-0004JO-Qw
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 10:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489AbYIYIfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 04:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752215AbYIYIfo
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 04:35:44 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:57021 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752147AbYIYIfn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 04:35:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 3F7B052C3EC;
	Thu, 25 Sep 2008 10:35:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gq-LeI4kOcqB; Thu, 25 Sep 2008 10:35:40 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 3781A52C3F8;
	Thu, 25 Sep 2008 10:35:38 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id C16766DFDED; Thu, 25 Sep 2008 10:35:04 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 20C881A4001; Thu, 25 Sep 2008 10:35:38 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96734>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 builtin-checkout.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

 I noticed this while using topgit which checkouts out a detached head
 with the -q flag and later does a final checkout, which caused local
 changes to be shown twice.

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 9aeb61d..b572b3b 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -461,7 +461,7 @@ static int merge_working_tree(struct checkout_opts *opts,
 	    commit_locked_index(lock_file))
 		die("unable to write new index file");
 
-	if (!opts->force)
+	if (!opts->force && !opts->quiet)
 		show_local_changes(&new->commit->object);
 
 	return 0;
-- 
tg: (47a765d..) jf/checkout-quiet (depends on: next)

-- 
Jonas Fonseca
