From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git rebase/pull questions
Date: Sat, 16 Feb 2008 11:50:30 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802161147470.30505@racer.site>
References: <76718490802152010udd11567v25ae456db0a59f3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 12:51:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQLZY-0001kf-W4
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 12:51:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757407AbYBPLuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 06:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753721AbYBPLui
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 06:50:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:52692 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757407AbYBPLuh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 06:50:37 -0500
Received: (qmail invoked by alias); 16 Feb 2008 11:50:35 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp048) with SMTP; 16 Feb 2008 12:50:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/y/foxpunytZXr6VZYGU/Xbq5bIndsF9lsb/zZt/
	IEeYsmVG1VyfYr
X-X-Sender: gene099@racer.site
In-Reply-To: <76718490802152010udd11567v25ae456db0a59f3b@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74038>

Hi,

On Fri, 15 Feb 2008, Jay Soffian wrote:

> Second, git-pull completely ignores -s/--strategy if also give --rebase, 
> but I wonder if it shouldn't just pass the strategy along to git-rebase.

That is just an oversight.  Could you test if this works for you 
(completely untested by me...)?

-- snip --
[PATCH] pull --rebase: respect merge strategy options

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 git-pull.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 46da0f4..e0bf582 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -174,6 +174,7 @@ fi
 
 merge_name=$(git fmt-merge-msg <"$GIT_DIR/FETCH_HEAD") || exit
 test true = "$rebase" &&
-	exec git-rebase --onto $merge_head ${oldremoteref:-$merge_head}
+	exec git-rebase $strategy_args \
+		--onto $merge_head ${oldremoteref:-$merge_head}
 exec git-merge $no_summary $no_commit $squash $no_ff $strategy_args \
 	"$merge_name" HEAD $merge_head
-- snap --

Ciao,
Dscho
