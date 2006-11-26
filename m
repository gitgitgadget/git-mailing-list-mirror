X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Anand Kumria <wildfire@progsoc.org>
Subject: [PATCH]  Make logAllRefUpdates true by default
Date: Mon, 27 Nov 2006 02:36:43 +1100
Message-ID: <11645554033331-git-send-email-wildfire@progsoc.org>
NNTP-Posting-Date: Sun, 26 Nov 2006 15:38:01 +0000 (UTC)
Cc: Anand Kumria <wildfire@progsoc.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.3.3
X-SA-Exim-Connect-IP: 203.7.227.146
X-SA-Exim-Mail-From: anand@eve.kumria.com
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on giskard.kumria.com)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32353>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoM4g-0000i4-Vh for gcvg-git@gmane.org; Sun, 26 Nov
 2006 16:37:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934376AbWKZPhm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 10:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934381AbWKZPhm
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 10:37:42 -0500
Received: from 133.105.233.220.exetel.com.au ([220.233.105.133]:54689 "EHLO
 giskard.kumria.com") by vger.kernel.org with ESMTP id S934376AbWKZPhl (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 10:37:41 -0500
Received: from caliban.kumria.com ([203.7.227.146] helo=eve.kumria.com
 ident=anand) by giskard.kumria.com with esmtp (Exim 4.50) id
 1GoM4M-0003CT-EI; Mon, 27 Nov 2006 02:37:32 +1100
Received: from anand by eve.kumria.com with local (Exim 4.63) (envelope-from
 <anand@eve.kumria.com>) id 1GoM3f-0004WB-5V; Mon, 27 Nov 2006 02:36:43 +1100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

reflog support, which allows you to determine what the state of a branch
was at a particular date/time, is often cited as something that would be
useful to have on by default.  Modify git init-db, so that newly created
repositories have this on.

Signed-off-by: Anand Kumria <wildfire@progsoc.org>
---
 Documentation/config.txt |    2 +-
 builtin-init-db.c        |    3 +++
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9d3c71c..e8d0bc1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -80,7 +80,7 @@ core.logAllRefUpdates::
 
 	This information can be used to determine what commit
 	was the tip of a branch "2 days ago".  This value is
-	false by default (no automated creation of log files).
+	true by default.
 
 core.repositoryFormatVersion::
 	Internal variable identifying the repository format and layout
diff --git a/builtin-init-db.c b/builtin-init-db.c
index 235a0ee..4ea865d 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -239,6 +239,9 @@ static void create_default_files(const c
 		git_config_set("core.filemode",
 			       filemode ? "true" : "false");
 	}
+
+	git_config_set("core.logAllRefUpdates", "true");
+
 }
 
 static const char init_db_usage[] =
-- 
1.4.3.3
