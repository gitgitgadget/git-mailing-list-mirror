From: Robert Fitzsimons <robfitz@273k.net>
Subject: [PATCH 1/9] Fix git patch header processing in git-apply.
Date: Sun, 28 Aug 2005 15:24:27 +0000
Message-ID: <11252426672473-git-send-email-robfitz@273k.net>
Reply-To: Robert Fitzsimons <robfitz@273k.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Robert Fitzsimons <robfitz@273k.net>
X-From: git-owner@vger.kernel.org Sun Aug 28 17:22:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9Ozg-0006KZ-3X
	for gcvg-git@gmane.org; Sun, 28 Aug 2005 17:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbVH1PWn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Aug 2005 11:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbVH1PWn
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Aug 2005 11:22:43 -0400
Received: from igraine.blacknight.ie ([217.114.173.147]:35053 "EHLO
	igraine.blacknight.ie") by vger.kernel.org with ESMTP
	id S1751200AbVH1PWm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2005 11:22:42 -0400
Received: from [212.17.39.138] (helo=earth)
	by igraine.blacknight.ie with smtp (Exim 4.42)
	id 1E9OzO-0004PE-UJ; Sun, 28 Aug 2005 16:22:31 +0100
In-Reply-To: 20050828152251.GA26331@localhost
X-Mailer: git-send-email-script
To: git@vger.kernel.org
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam, SpamAssassin (score=0,
	required 7.5)
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7870>

Stop processing and return NULL if we encounter a '\n' character
before we have two matching names in the git header.

Signed-off-by: Robert Fitzsimons <robfitz@273k.net>

---

 apply.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

289e53f770e37dfe25c740788256d24c19c2e16d
diff --git a/apply.c b/apply.c
--- a/apply.c
+++ b/apply.c
@@ -387,7 +387,7 @@ static char *git_header_name(char *line)
 		default:
 			continue;
 		case '\n':
-			break;
+			return NULL;
 		case '\t': case ' ':
 			second = name+len;
 			for (;;) {
