From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] git gui: visually wrap lines of commit message
Date: Sat, 9 Aug 2008 18:05:57 +0200
Message-ID: <20080809160557.GA902@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Aug 09 18:21:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRrCN-0002iE-VK
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 18:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbYHIQUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 12:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbYHIQUp
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 12:20:45 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:14092 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbYHIQUp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 12:20:45 -0400
X-Greylist: delayed 912 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Aug 2008 12:20:44 EDT
Received: from darc.dyndns.org ([84.154.99.38]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 9 Aug 2008 18:05:29 +0200
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1KRqx3-0000LS-V5; Sat, 09 Aug 2008 18:05:57 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 09 Aug 2008 16:05:29.0894 (UTC) FILETIME=[BEA9D460:01C8FA39]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91770>

Visually wrap lines in the commit message text box. That way we can avoid
a horizontal scroll bar (which was not available anyways).

Note: This does _not_ break lines in the actual commit message.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

I also tried to get automatic line breaks but was unable to do so. I managed
to implement a callback function triggered by the <<Modified>> event, and I
also managed to query the end position of the insertion using the 'insert'
index. So with this information it would be possible to implement automatic
line breaks. Unfortunately, this is not enough for pasting. If there is more
than one new character, the start position of the insertion is unknown.

I then tried to track cursor movement, but no luck there either. Any ideas
are welcome. For now I'll simply have to "git commit --amend<CR>gqG:x<CR>"
each time I use git gui.

Clemens

 git-gui/git-gui.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 14b2d9a..3949f7d 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -2528,6 +2528,7 @@ text $ui_comm -background white -foreground black \
 	-autoseparators true \
 	-relief sunken \
 	-width $repo_config(gui.commitmsgwidth) -height 9 -wrap none \
+	-wrap char \
 	-font font_diff \
 	-yscrollcommand {.vpane.lower.commarea.buffer.sby set}
 scrollbar .vpane.lower.commarea.buffer.sby \
-- 
1.5.6.4
