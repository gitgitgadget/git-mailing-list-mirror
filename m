X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] Documentation: Transplanting branch with git-rebase --onto
Date: Mon, 6 Nov 2006 19:12:45 +0100
Message-ID: <200611061912.46436.jnareb@gmail.com>
References: <200611042205.58212.jnareb@gmail.com> <7vbqnmwvib.fsf@assigned-by-dhcp.cox.net> <200611051122.17623.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 6 Nov 2006 18:41:43 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=hVa+0dhkyL/I04kpNV4KEg1yjdBZswrBokdtUqTt5oM2IeAytPzJjl86PTrAHiS3NzcyZerX3IscALEBo5CKkbP26zurLDS9CUvGIjeDU2FE0L0CBhigTJbjz35xQ8sotijvntdFF41D9PnRMwMcH5ywOcZu6bv1eFGAZxtMiQ4=
User-Agent: KMail/1.9.3
In-Reply-To: <200611051122.17623.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31024>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gh8xK-0005s2-0N for gcvg-git@gmane.org; Mon, 06 Nov
 2006 19:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753750AbWKFSMR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 13:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753751AbWKFSMR
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 13:12:17 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:48057 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1753749AbWKFSMQ
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 13:12:16 -0500
Received: by ug-out-1314.google.com with SMTP id m3so960336ugc for
 <git@vger.kernel.org>; Mon, 06 Nov 2006 10:12:15 -0800 (PST)
Received: by 10.67.22.14 with SMTP id z14mr7753570ugi.1162836734918; Mon, 06
 Nov 2006 10:12:14 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id x26sm4818492ugc.2006.11.06.10.12.14; Mon, 06 Nov
 2006 10:12:14 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Added example of transplantig feature branch from one development
branch (for example "next") into the other development branch (for
example "master").

[jn: with a little help from Junio]

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
What about this?

The second example I think has place in tutorial or GitTips on GitWiki


 Documentation/git-rebase.txt |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 10f2924..9e822c5 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -65,6 +65,40 @@ would be:
     D---E---F---G master
 ------------
 
+
+Here is how you would transplant a topic branch based on one
+branch to another, to pretend that you forked the topic branch
+from the latter branch, using `rebase --onto`.
+
+First let's assume your 'topic' is based on branch 'next'.
+For example feature developed in 'topic' depends on some
+functionality which is found in 'next'.
+
+------------
+    o---o---o---o---o  master
+         \
+          o---o---o---o---o  next
+                           \
+                            o---o---o  topic
+------------
+
+We would want to make 'topic' forked from branch 'master',
+for example because the functionality 'topic' branch depend on
+got merged into more stable 'master' branch, like this:
+
+------------
+    o---o---o---o---o  master
+        |            \
+        |             o'--o'--o'  topic
+         \
+          o---o---o---o---o  next
+------------
+
+We can get this using the following command:
+
+    git-rebase --onto master next topic
+
+
 In case of conflict, git-rebase will stop at the first problematic commit
 and leave conflict markers in the tree.  You can use git diff to locate
 the markers (<<<<<<) and make edits to resolve the conflict.  For each
-- 
1.4.3.4
