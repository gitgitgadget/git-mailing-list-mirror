From: tony.luck@intel.com
Subject: [PATCH] Fix git-checkout-script exit status
Date: Tue, 23 Aug 2005 14:03:14 -0700
Message-ID: <200508232103.j7NL3EV4025364@agluck-lia64.sc.intel.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 23:05:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7fvS-0003IG-LN
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 23:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbVHWVDQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 17:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932066AbVHWVDQ
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 17:03:16 -0400
Received: from fmr23.intel.com ([143.183.121.15]:13984 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S932072AbVHWVDP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2005 17:03:15 -0400
Received: from scsfmr101.sc.intel.com (scsfmr101.sc.intel.com [10.3.253.10])
	by scsfmr003.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j7NL3F6Q025889
	for <git@vger.kernel.org>; Tue, 23 Aug 2005 21:03:15 GMT
Received: from agluck-lia64.sc.intel.com (agluck-lia64.sc.intel.com [143.183.251.239])
	by scsfmr101.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id j7NKsmwb029934
	for <git@vger.kernel.org>; Tue, 23 Aug 2005 20:54:48 GMT
Received: from agluck-lia64.sc.intel.com (agluck-lia64.sc.intel.com [127.0.0.1])
	by agluck-lia64.sc.intel.com (8.13.1/8.13.1) with ESMTP id j7NL3EQe025365
	for <git@vger.kernel.org>; Tue, 23 Aug 2005 14:03:14 -0700
Received: (from aegl@localhost)
	by agluck-lia64.sc.intel.com (8.13.1/8.13.1/Submit) id j7NL3EV4025364;
	Tue, 23 Aug 2005 14:03:14 -0700
To: git@vger.kernel.org
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7669>

Sometimes the git-read-tree in git-checkout-script fails for me.
Make sure that the failed status is passed up to caller.

Signed-off-by: Tony Luck <tony.luck@intel.com>

---

diff --git a/git-checkout-script b/git-checkout-script
--- a/git-checkout-script
+++ b/git-checkout-script
@@ -72,4 +72,6 @@ if [ "$?" -eq 0 ]; then
 	fi
 	[ "$branch" ] && ln -sf "refs/heads/$branch" "$GIT_DIR/HEAD"
 	rm -f "$GIT_DIR/MERGE_HEAD"
+else
+	exit 1
 fi
