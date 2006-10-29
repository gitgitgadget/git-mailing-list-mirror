X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [StGIT PATCH] Bash snippet to show branch and patch in bash prompt
Date: Mon, 30 Oct 2006 00:37:45 +0100
Message-ID: <20061029233745.24899.1470.stgit@lathund.dewire.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
NNTP-Posting-Date: Sun, 29 Oct 2006 23:36:46 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Virus-Scanned: amavisd-new at localhost.localdomain
User-Agent: StGIT/0.10
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30473>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeKCk-0006Nn-HE for gcvg-git@gmane.org; Mon, 30 Oct
 2006 00:36:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030431AbWJ2Xgg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 18:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030452AbWJ2Xgg
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 18:36:36 -0500
Received: from [83.140.172.130] ([83.140.172.130]:13855 "EHLO
 torino.dewire.com") by vger.kernel.org with ESMTP id S1030431AbWJ2Xgf (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 18:36:35 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id 339328030A5; Mon, 30 Oct 2006 00:33:18 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 23306-07; Mon, 30 Oct
 2006 00:33:17 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.2]) by torino.dewire.com
 (Postfix) with ESMTP id D89B78003E1; Mon, 30 Oct 2006 00:33:15 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1]) by
 lathund.dewire.com (Postfix) with ESMTP id D264928E5B; Mon, 30 Oct 2006
 00:37:48 +0100 (CET)
Received: from lathund.dewire.com ([127.0.0.1]) by localhost
 (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025) with LMTP id
 xpvfz6k1OYMA; Mon, 30 Oct 2006 00:37:45 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1]) by
 lathund.dewire.com (Postfix) with ESMTP id 9BC8928E54; Mon, 30 Oct 2006
 00:37:45 +0100 (CET)
To: catalin.marinas@arm.com
Sender: git-owner@vger.kernel.org

From: Robin Rosenberg <robin.rosenberg@dewire.com>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 contrib/stgbashprompt.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/contrib/stgbashprompt.sh b/contrib/stgbashprompt.sh
new file mode 100755
index 0000000..792da53
--- /dev/null
+++ b/contrib/stgbashprompt.sh
@@ -0,0 +1,16 @@
+# include this in your bashrc or copy to /etc/bash_completions.d
+
+if [ "$PS1" ]; then
+    # trap 'PS1="\u@\h [$(stg top)] \w]\$ "' DEBUG
+    function stgtag
+    {
+	br=$(stg branch 2>/dev/null)
+	top=$(stg top 2>/dev/null)
+	if [[ -n "$br$top" ]];then
+	    echo "[$top@$br]"
+	    return
+	fi
+    }
+    PS1='\u@\h$(stgtag)\w\$ '
+
