From: Paul Mackerras <paulus@samba.org>
Subject: reducing line crossings in gitk
Date: Sat, 11 Jun 2005 21:47:03 +1000
Message-ID: <17066.53047.660907.453399@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jun 11 13:43:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dh4O7-0003Sb-W2
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 13:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbVFKLrB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Jun 2005 07:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbVFKLrB
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jun 2005 07:47:01 -0400
Received: from ozlabs.org ([203.10.76.45]:52924 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261688AbVFKLq6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Jun 2005 07:46:58 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id BE6C067B17; Sat, 11 Jun 2005 21:46:56 +1000 (EST)
To: git@vger.kernel.org
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

At the moment, the commit graph that gitk draws always displays the
parents of a merge in left-to-right order as they are listed in the
commit (provided that none of the parents already has a line, i.e., is
the parent of an previously drawn commit).  That means that for the
typical merge, the branch coming out to the right is the stuff that
was pulled in by the merge.

That can lead to a later line crossing if an ancestor of the stuff
being pulled in already has a line that is to the left of the merge.
For an example of what I mean, look at the kernel repository with gitk
at around commit 5ea6f2c33f0c8b126136dbf1776ffbc444772cd7 (Automatic
merge of /spare/repo/netdev-2.6 branch natsemi).

I could add a heuristic to look for this case and reverse the order of
the parents, which would reduce the line crossings and make the graph
look neater.  Would this be worth the slight loss of information (in
that the stuff pulled in would no longer always be to the right)?

Paul.
