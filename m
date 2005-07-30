From: Paul Mackerras <paulus@samba.org>
Subject: Display of merges in gitk
Date: Fri, 29 Jul 2005 20:51:40 -0500
Message-ID: <17130.56620.137642.941175@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jul 30 05:50:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyiMI-0006rp-2k
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 05:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262799AbVG3Dth (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 23:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbVG3Dtg
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 23:49:36 -0400
Received: from ozlabs.org ([203.10.76.45]:26777 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262799AbVG3Dtc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 23:49:32 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 750FE67DE9; Sat, 30 Jul 2005 13:49:28 +1000 (EST)
To: git@vger.kernel.org
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I have reworked the way gitk displays merges.  Previously it would
display all the diffs between the child and each parent.  That
displayed a lot of unnecessary stuff; for example, for the famous
octopus (pentapus?) merge, each diff was shown 4 times.  It also shows
diffs when the merge is perfectly straightforward, i.e. when any given
file has been modified in at most one of the parents, and the child's
version is the same as the parent's.

Now gitk will only list a file as having a difference in a merge if
one or more of the parents has a version of the file that is different
both from the child and from the common ancestor of the parents (if a
common ancestor exists).  If there is no common ancestor, then a file
is listed if it is different in the child from all of the parents.

I now also display the diffs for a file in one unified difference
listing.  Lines are color-coded according to which parent they come
from, and are in bold with a + at the start of the line if they ended
up in the merge result (the child), or in normal font with a - at the
start of the line if they didn't.  In the usual case of two parents,
lines from the first parent are in red and lines from the second
parent are in blue.  Lines in the result that don't correspond to
either parent are in bold black.

Linus, could you do a pull from the usual place to pick this up?
(rsync://rsync.kernel.org/pub/scm/gitk/gitk.git).  I also included a
patch from Junio.

Paul.
