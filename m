From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v3 7/9] user-manual: Use request-pull to generate "please pull"
 text
Date: Sun, 17 Feb 2013 19:15:59 -0500
Message-ID: <edd0062a7f54300cccd0123dc108e9a0f39bdccc.1361146398.git.wking@tremily.us>
References: <20130217170606.GA3432@odin.tremily.us>
 <cover.1361146398.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 18 01:17:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7EQ7-0000ml-Lq
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 01:17:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756705Ab3BRAQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 19:16:33 -0500
Received: from vms173011pub.verizon.net ([206.46.173.11]:53046 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756789Ab3BRAQb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 19:16:31 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MIE008QR3EWD390@vms173011.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 17 Feb 2013 18:16:09 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 3CC1488566D; Sun,
 17 Feb 2013 19:16:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1361146568; bh=T1yQuLpOSWvWj24o19Y848argmMpdsOrunFg/FW8i3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:	 References;
	b=h8USZLqeP8Ouzp2b/G9L3k0qoAS5KXNFCzeCtbnxSpkKMBjK3WoU5Y8vrG9cVL72M
 7FllXs0pXaH/C7RjxHVQG4xETfO1T3mCA/9dp2LUleoR2NoCD8k9cm8Ytk51NGMyHH
 AXDGbJ1wh8FFdHMKMBmLV63OvsM9OjBzbnYF31Y4=
X-Mailer: git-send-email 1.7.12.4
In-reply-to: <cover.1361146398.git.wking@tremily.us>
In-reply-to: <cover.1361146398.git.wking@tremily.us>
References: <cover.1361146398.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216416>

From: "W. Trevor King" <wking@tremily.us>

Less work and more error checking (e.g. does a merge base exist?).
Add an explicit push before request-pull to satisfy request-pull,
which checks to make sure the references are publically available.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/user-manual.txt | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index d9276d7..cf09ddf 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2304,16 +2304,11 @@ these changes, just apply directly to the `release` branch, and then
 merge that into the `test` branch.
 
 To create diffstat and shortlog summaries of changes to include in a "please
-pull" request to Linus you can use:
+pull" request to Linus you can use linkgit:git-request-pull[1]:
 
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
