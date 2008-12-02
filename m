From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [StGit PATCH] Do not append a new line to the backwards compat files
	(bug #12656)
Date: Tue, 02 Dec 2008 14:38:39 +0000
Message-ID: <20081202143839.24221.90893.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 15:40:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7WPw-0008Hk-VS
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 15:40:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226AbYLBOio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 09:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754239AbYLBOio
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 09:38:44 -0500
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:43122 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754226AbYLBOio (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Dec 2008 09:38:44 -0500
Received: from aamtaout01-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20081202143842.OUOT1869.mtaout01-winn.ispmail.ntl.com@aamtaout01-winn.ispmail.ntl.com>;
          Tue, 2 Dec 2008 14:38:42 +0000
Received: from localhost.localdomain ([86.9.203.187])
          by aamtaout01-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20081202143842.PSCB19264.aamtaout01-winn.ispmail.ntl.com@localhost.localdomain>;
          Tue, 2 Dec 2008 14:38:42 +0000
User-Agent: StGit/0.14.3.290.g44ed
X-Cloudmark-Analysis: v=1.0 c=1 a=z9CQwz9bKOAA:10 a=hMUFf96KDaAA:10 a=pGLkceISAAAA:8 a=D7Aeg_Lqh4ownzhcXvgA:9 a=aUQvfjEA8lAN4S_CYF4A:7 a=ryUybFFZ5y0VaBtuGROjty-LIQ4A:4 a=JcB9aHnUDh0A:10 a=b5Ty8kZ7TbYA:10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102137>

Since the multiline argument wasn't passed to the utils.write_string()
function when writing the compatibility description file from the new
infrastructure, any older command like push would have committed these
new lines.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 stgit/lib/stack.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/stgit/lib/stack.py b/stgit/lib/stack.py
index 47679b6..a72ee22 100644
--- a/stgit/lib/stack.py
+++ b/stgit/lib/stack.py
@@ -58,7 +58,7 @@ class Patch(object):
         write('authdate', d.author.date)
         write('commname', d.committer.name)
         write('commemail', d.committer.email)
-        write('description', d.message)
+        write('description', d.message, multiline = True)
         write('log', write_patchlog().sha1)
         write('top', new_commit.sha1)
         write('bottom', d.parent.sha1)
