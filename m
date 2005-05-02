From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: question on merges
Date: Mon, 2 May 2005 17:12:00 +0200
Message-ID: <20050502151200.GA4592@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 02 17:08:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DScUq-0003L2-TE
	for gcvg-git@gmane.org; Mon, 02 May 2005 17:06:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVEBPMH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 11:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbVEBPMH
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 11:12:07 -0400
Received: from alephnull.demon.nl ([212.238.201.82]:7608 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S261306AbVEBPMD
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 2 May 2005 11:12:03 -0400
Received: by xi.wantstofly.org (Postfix, from userid 500)
	id 7819C2B0EC; Mon,  2 May 2005 17:12:00 +0200 (MEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

If a git user has X as his most recent local commit, and merges in a
commit Y from someone else to create commit Z, shouldn't commit Z have
both commit X and Y as parents?  Or is is the other way round and is it
perfectly well possible that a 'merge commit' only has one parent?

In the current linux-2.6 git tree, gregkh clones torvalds'
7f907d7486f2519c2ff1493bfbcdc36dcacd85b7 and creates a chain of commits
starting with ac21e9ff08db3d6fac41d356c77fcb531c2e03e1 and ending in
e838a0d4d5260bce452c96914a6e86b217c53c55.  torvalds merges this chain
back into his version in a9e4820c4c170b3df0d2185f7b4130b0b2daed2c, but
that commit has as parents e838a0d4d5260bce452c96914a6e86b217c53c55
(gregkh's last commit), and c0698f2f6e4839ce9463ce731c892993215ea067,
one of jejb's intermediate commits.  But now why is
7f907d7486f2519c2ff1493bfbcdc36dcacd85b7 not a parent of
a9e4820c4c170b3df0d2185f7b4130b0b2daed2c?  I would expect it to be,
since it is linus' most recent local commit when he merges in gregkh's
tree.

This pattern happens a few more times:
- davem creates c4d541106bc5d0a2134aaf9e8735eee3c70b0db2 from torvalds'
  561bbe3235da614562fb26bb14042af684971a2d, and torvalds merges davem's
  tree back in at a2755a80f40e5794ddc20e00f781af9d6320fafb (v2.6.12-rc3),
  but that commit only has one parent (even though it's a merge.)

See this image:
	http://www.liacs.nl/~buytenh/graph_2cacb3da620a4a93f3a77e1d2c8c06bb3c74bcb0.png


cheers,
Lennert
