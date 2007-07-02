From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-stash: Make "save" the default operation again
Date: Mon, 2 Jul 2007 11:44:29 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707021141280.4438@racer.site>
References: <Pine.LNX.4.64.0706301853400.4438@racer.site>
 <200707010533.l615XiH6006728@mi1.bluebottle.com> <20070701080757.GA6093@coredump.intra.peff.net>
 <7vlkdz4wp3.fsf@assigned-by-dhcp.cox.net> <20070702041046.GB17384@coredump.intra.peff.net>
 <Pine.LNX.4.64.0707021129540.4438@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	GIT <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 02 12:44:50 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5JOh-00065s-Ii
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 12:44:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227AbXGBKoh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 06:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbXGBKog
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 06:44:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:37584 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751298AbXGBKog (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 06:44:36 -0400
Received: (qmail invoked by alias); 02 Jul 2007 10:44:34 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp047) with SMTP; 02 Jul 2007 12:44:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19/B3M7mW9/B7C9RkQPsu+EAPzmdMRK/XrdGtYik5
	KIH0yR6u7PYpoh
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707021129540.4438@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51350>


The default operation really should be that which you are most likely
to use. And that _is_ to stash the current changes away. Indeed, quite
often you will want it to stash away changes you never plan to commit,
like extensive debugging output.

Sometimes you will stash away changes that you realize only later will
never be needed.

So, neither "list" nor "apply" are ase often used in practice as "save".
The manpage already reflects that, so change the script to the better.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Think about it again. You tested git-stash. That is not the normal 
	modus operandi. You needed to inspect the stashed changes. In the
	examples given in the manpage, you usually want to work with the
	last stashed changes, if at all. So you _rarely_ inspect the 
	stashed changes. From my experience I agree.

	If you make "list" the default, people will get used to _that_, 
	even if it means more typing, and quite a few "Aargh, I just 
	wanted to stash the current state, and I get a list instead!" 
	moments.

	Then there is no way to change it back to some sane default 
	operation.

 git-stash.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index ec18ef6..04ce30a 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -132,7 +132,7 @@ apply_stash () {
 
 # Main command set
 case "$1" in
-list | '')
+list)
 	shift
 	if test $# = 0
 	then
@@ -152,7 +152,7 @@ apply)
 clear)
 	clear_stash
 	;;
-save)
+save|'')
 	save_stash && git-reset --hard
 	;;
 *)
-- 
1.5.2.2.3293.gad30
