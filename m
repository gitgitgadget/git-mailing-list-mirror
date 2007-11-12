From: Jing Xue <jingxue@digizenstudio.com>
Subject: [PATCH] RESUBMIT: replace reference to git-rm with git-reset in
	git-commit doc
Date: Sun, 11 Nov 2007 23:43:00 -0500
Message-ID: <20071112044300.GB7595@fawkes>
References: <20071102021711.GA28703@fawkes.hq.digizenstudio.com> <20071111140518.GA3847@efreet.light.src> <20071112003845.GA7595@fawkes> <7vsl3c8afm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 12 05:43:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrR8z-0005dR-GD
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 05:43:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754493AbXKLEnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 23:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753765AbXKLEnK
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 23:43:10 -0500
Received: from k2smtpout05-01.prod.mesa1.secureserver.net ([64.202.189.56]:42250
	"HELO k2smtpout05-01.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753159AbXKLEnI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 23:43:08 -0500
Received: (qmail 22764 invoked from network); 12 Nov 2007 04:43:08 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout05-01.prod.mesa1.secureserver.net (64.202.189.56) with ESMTP; 12 Nov 2007 04:43:08 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id EB84E100086
	for <git@vger.kernel.org>; Mon, 12 Nov 2007 04:43:07 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OIQgeUeHkATk for <git@vger.kernel.org>;
	Sun, 11 Nov 2007 23:43:01 -0500 (EST)
Received: from fawkes.hq.digizenstudio.com (ip70-187-196-88.dc.dc.cox.net [70.187.196.88])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 2A0DE10007A
	for <git@vger.kernel.org>; Sun, 11 Nov 2007 23:43:01 -0500 (EST)
Received: by fawkes.hq.digizenstudio.com (Postfix, from userid 1000)
	id 377349ACEC; Sun, 11 Nov 2007 23:43:00 -0500 (EST)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7vsl3c8afm.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64559>

On Sun, Nov 11, 2007 at 06:27:57PM -0800, Junio C Hamano wrote:
> 
> I think "changes ... can be removed" risks to give a confused
> mental model that somehow git tracks changes.

I see what you mean. "Changes" shouldn't be the subject here.

> "A file can be
> reverted back to that of the last commit with ..."  would be
> less risky.

On top of that, I somehow still want to make it relevant to that
git-reset instead of git-rm should be used to revert git-add. So how
about this?

Signed-off-by: Jing Xue <jingxue@digizenstudio.com>
---
 Documentation/git-add.txt    |    1 +
 Documentation/git-commit.txt |   13 ++++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 963e1ab..63829d9 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -224,6 +224,7 @@ See Also
 --------
 gitlink:git-status[1]
 gitlink:git-rm[1]
+gitlink:git-reset[1]
 gitlink:git-mv[1]
 gitlink:git-commit[1]
 gitlink:git-update-index[1]
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index e54fb12..4b26cae 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -154,11 +154,14 @@ EXAMPLES
 --------
 When recording your own work, the contents of modified files in
 your working tree are temporarily stored to a staging area
-called the "index" with gitlink:git-add[1].  Removal
-of a file is staged with gitlink:git-rm[1].  After building the
-state to be committed incrementally with these commands, `git
-commit` (without any pathname parameter) is used to record what
-has been staged so far.  This is the most basic form of the
+called the "index" with gitlink:git-add[1].  A file can be
+reverted back, only in the index but not in the working tree,
+to that of the last commit with `git-reset HEAD -- <file>`,
+which effectively reverts `git-add` and prevents this file from
+participating in the next commit.  After building the state to
+be committed incrementally with these commands, `git commit`
+(without any pathname parameter) is used to record what has
+been staged so far.  This is the most basic form of the
 command.  An example:
 
 ------------
