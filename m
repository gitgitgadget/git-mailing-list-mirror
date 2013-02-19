From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v4 2/3] user-manual: Use request-pull to generate "please pull"
 text
Date: Tue, 19 Feb 2013 05:05:01 -0500
Message-ID: <ad7727d728227c788007ad1f6f19d37c75835f97.1361267945.git.wking@tremily.us>
References: <20130219093429.GA4024@odin.tremily.us>
 <cover.1361267945.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 19 11:05:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7k4x-0004li-Cg
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 11:05:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758600Ab3BSKFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 05:05:13 -0500
Received: from vms173011pub.verizon.net ([206.46.173.11]:43175 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758445Ab3BSKFL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 05:05:11 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MIG00EBYPCLHMB0@vms173011.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 19 Feb 2013 04:05:10 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 70AE68ABA0C; Tue,
 19 Feb 2013 05:05:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1361268309; bh=q6V2/J0ogoq9MeIbyEjiQ+i0Gt0LtneLQAUQGs3ne5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:	 References;
	b=hlE+ImUxygcBGB18UdC8KWIW2SpOkZM92YLh6LtYojY2MYW/lCrv7ZzofKBxIXgoW
 AJ/rFk2zP2g1UiMBFuJt5rJU0yEW0wouAsCaZ7aaqZypN/FGLaOR9ZrVKrbGnPeki9
 Cin2qxRoCROdv7Xe1yKWxn2V/GfRO9uhs4xmTagM=
X-Mailer: git-send-email 1.7.12.4
In-reply-to: <cover.1361267945.git.wking@tremily.us>
In-reply-to: <cover.1361267945.git.wking@tremily.us>
References: <cover.1361267945.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216591>

From: "W. Trevor King" <wking@tremily.us>

Less work and more error checking (e.g. does a merge base exist?).
Add an explicit push before request-pull to satisfy request-pull,
which checks to make sure the references are publically available.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/user-manual.txt | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index a4dbd9e..3aab106 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2305,17 +2305,13 @@ branch and then merge into each of the test and release branches.  For
 these changes, just apply directly to the "release" branch, and then
 merge that into the "test" branch.
 
-To create diffstat and shortlog summaries of changes to include in a "please
-pull" request to Linus you can use:
+After pushing your work to `mytree`, you can use
+linkgit:git-request-pull[1] to prepare a "please pull" request message
+to send to Linus:
 
 -------------------------------------------------
-$ git diff --stat origin..release
--------------------------------------------------
-
-and
-
--------------------------------------------------
-$ git log -p origin..release | git shortlog
+$ git push mytree
+$ git request-pull origin mytree release
 -------------------------------------------------
 
 Here are some of the scripts that simplify all this even further.
-- 
1.8.1.336.g94702dd
