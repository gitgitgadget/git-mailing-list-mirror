From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] revision.c: Fix a sparse warning
Date: Sat, 27 Jul 2013 19:39:31 +0100
Message-ID: <51F413E3.7000608@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: trast@inf.ethz.ch
X-From: git-owner@vger.kernel.org Sat Jul 27 21:07:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V39pm-0005LQ-Qt
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 21:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752733Ab3G0TG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jul 2013 15:06:57 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:55483 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752719Ab3G0TG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jul 2013 15:06:57 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id BA5BC1280BF;
	Sat, 27 Jul 2013 20:06:54 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 1D6071280B5;
	Sat, 27 Jul 2013 20:06:54 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP;
	Sat, 27 Jul 2013 20:06:53 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231251>


Sparse issues an "symbol 'saved_parents_slab' was not declared. Should
it be static?" warning. In order to suppress the warning, since this
symbol does not require more than file visibility, we simply add the
static modifier to its declaration.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Thomas,

In addition to the gcc warning, sparse weighs in with this warning,
provoked by commit 3b3d83e5 ("[PERHAPS LIKE THIS] log: use true parents
for diff even when rewriting", 22-07-2013).

If you update this commit, could you please squash this into the new patch.

Thanks!

ATB,
Ramsay Jones

 revision.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index f242363..fa355d0 100644
--- a/revision.c
+++ b/revision.c
@@ -3074,7 +3074,7 @@ void put_revision_mark(const struct rev_info *revs, const struct commit *commit)
 }
 
 define_commit_slab(saved_parents, struct commit_list *);
-struct saved_parents saved_parents_slab;
+static struct saved_parents saved_parents_slab;
 static int saved_parents_initialized;
 
 void save_parents(struct commit *commit)
-- 
1.8.3
