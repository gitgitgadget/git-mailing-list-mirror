From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 2/7] Tweaked --merge-order --show-breaks output in case specified head has no parent
Date: Mon, 20 Jun 2005 12:29:29 +1000
Message-ID: <20050620022929.28557.qmail@blackcubes.dyndns.org>
Cc: torvalds@osdl.org, jon.seymour@gmail.com, paulus@samba.org
X-From: git-owner@vger.kernel.org Mon Jun 20 04:25:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkByU-0006qE-BE
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 04:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVFTCa7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 22:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVFTCa6
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 22:30:58 -0400
Received: from 203-166-247-224.dyn.iinet.net.au ([203.166.247.224]:4995 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S261401AbVFTC3b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2005 22:29:31 -0400
Received: (qmail 28567 invoked by uid 500); 20 Jun 2005 02:29:29 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


      git-rev-list --merge-order --show-breaks root

Was outputing:

| root

It now outputs:

= root

Which is consistent with the behaviour of other cases.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---

 epoch.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/epoch.c b/epoch.c
--- a/epoch.c
+++ b/epoch.c
@@ -536,6 +536,8 @@ static int sort_in_merge_order(struct co
 
 	ret = parse_commit(head_of_epoch);
 
+	next->object.flags |= BOUNDARY;
+
 	while (next && next->parents && !ret && (action != STOP)) {
 		struct commit *base = NULL;
 
------------
