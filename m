X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Added description for reversing git-update-index using --index-info
Date: Thu, 2 Nov 2006 12:13:01 +0100
Message-ID: <200611021113.01812.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 2 Nov 2006 11:13:13 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-TUID: cc23275c7cf50297
X-UID: 148
X-Length: 1540
Content-Disposition: inline
X-OriginalArrivalTime: 02 Nov 2006 11:14:08.0280 (UTC) FILETIME=[03F4B980:01C6FE70]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30728>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfaVT-0004KF-6v for gcvg-git@gmane.org; Thu, 02 Nov
 2006 12:13:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752848AbWKBLNI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 06:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752850AbWKBLNH
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 06:13:07 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:24678 "EHLO
 369run02s.360vision.com") by vger.kernel.org with ESMTP id S1752848AbWKBLNE
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 06:13:04 -0500
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com
 with Microsoft SMTPSVC(5.0.2195.6713); Thu, 2 Nov 2006 11:14:08 +0000
Received: from localhost ([127.0.0.1]) by dvr.360vision.com with esmtp (Exim
 3.36 #1 (Debian)) id 1GfaVL-0003xq-00 for <git@vger.kernel.org>; Thu, 02 Nov
 2006 11:13:03 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I wanted to restore a single file from HEAD back to the index; Shawn Pearce
gave me the answer.  git-ls-tree piped to git-update-index --index-info.

This patch adds that answer to the git-update-index documentation.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 Documentation/git-update-index.txt |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 41bb7e1..5adf717 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -215,6 +215,24 @@ for that path.  After the above, we woul
 100755 8a1218a1024a212bb3db30becd860315f9f3ac52 2	frotz
 ------------
 
+One particular use of --index-info is to reverse the effect of
+"git-update-index frotz":
+
+------------
+git ls-tree HEAD frotz | git update-index --index-info
+------------
+
+This makes the index hold the file frotz from HEAD rather than from the
+working copy.  Similarly:
+
+------------
+git ls-tree -r HEAD | git update-index --index-info
+------------
+
+Will undo everything except "git add" from the index, as
+"git-ls-tree -r" lists everything in the last commit.
+
+
 
 Using "assume unchanged" bit
 ----------------------------
-- 
1.4.3.2
