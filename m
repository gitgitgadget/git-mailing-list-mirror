X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] hooks/pre-commit: add example to add Signed-off-by line to message
Date: Wed, 20 Dec 2006 16:04:12 +0000
Message-ID: <200612201604.12498.andyparkins@gmail.com>
References: <Pine.LNX.4.63.0611291219190.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 20 Dec 2006 16:04:37 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0611291219190.30004@wbgn013.biozentrum.uni-wuerzburg.de>
X-TUID: 3365bb1506cd63ad
X-UID: 200
X-Length: 1512
Content-Disposition: inline
X-OriginalArrivalTime: 20 Dec 2006 16:06:22.0166 (UTC) FILETIME=[CACB6760:01C72450]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34942>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx3ve-0005uK-Je for gcvg-git@gmane.org; Wed, 20 Dec
 2006 17:04:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965144AbWLTQES (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 11:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030181AbWLTQER
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 11:04:17 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:33301 "EHLO
 369run02s.360vision.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with
 ESMTP id S965144AbWLTQEQ (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec
 2006 11:04:16 -0500
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com
 with Microsoft SMTPSVC(5.0.2195.6713); Wed, 20 Dec 2006 16:06:22 +0000
Received: from localhost ([127.0.0.1]) by dvr.360vision.com with esmtp (Exim
 3.36 #1 (Debian)) id 1Gx3vS-0006mW-00 for <git@vger.kernel.org>; Wed, 20 Dec
 2006 16:04:14 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Based on Johannes Schindelin's earlier patch to perform the same
function.

The call to git-sh-setup was causing "Not a git repository" errors after
the pre-commit script had run.  I removed the call and used
$(git-rev-parse --git-dir) instead, which seems to have fixed the
problem.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 templates/hooks--pre-commit |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/templates/hooks--pre-commit b/templates/hooks--pre-commit
index 723a9ef..87d9ccc 100644
--- a/templates/hooks--pre-commit
+++ b/templates/hooks--pre-commit
@@ -7,6 +7,11 @@
 #
 # To enable this hook, make this file executable.
 
+# Uncomment the below to add a Signed-off-by line to the message.
+#git var GIT_AUTHOR_IDENT | \
+#sed -n "s/^\(.*\) [0-9]\+ [-+][0-9]\+$/Signed-off-by: \1/p" \
+# >> $(git-rev-parse --git-dir)/SQUASH_MSG
+
 # This is slightly modified from Andrew Morton's Perfect Patch.
 # Lines you introduce should not have trailing whitespace.
 # Also check for an indentation that has SP before a TAB.
-- 
1.4.4.2.g120e3
