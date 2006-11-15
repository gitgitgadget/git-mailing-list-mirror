X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-checkout: do not allow -f and -m at the same time.
Date: Wed, 15 Nov 2006 11:06:38 -0800
Message-ID: <7vfyckmsw1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 19:07:59 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31471>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkQ6Y-00061D-2i for gcvg-git@gmane.org; Wed, 15 Nov
 2006 20:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030899AbWKOTGu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 14:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030900AbWKOTGu
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 14:06:50 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:3218 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S1030897AbWKOTGt
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 14:06:49 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061115190648.VKNR20330.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Wed, 15
 Nov 2006 14:06:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id n76u1V00y1kojtg0000000; Wed, 15 Nov 2006
 14:06:55 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Instead of silently ignoring one over the other, complain on
this incompatible combination.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 * Back to fixing usability issues one at a time instead of
   throwing everything away with bathwater.

 git-checkout.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/git-checkout.sh b/git-checkout.sh
index 119bca1..eb28b29 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -77,6 +77,11 @@ while [ "$#" != "0" ]; do
     esac
 done
 
+case "$force$merge" in
+11)
+	die "git checkout: -f and -m are incompatible"
+esac
+
 # The behaviour of the command with and without explicit path
 # parameters is quite different.
 #
-- 
1.4.4

