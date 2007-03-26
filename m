From: Tim Allen <tim@commsecure.com.au>
Subject: Git performance problems with many tags
Date: Mon, 26 Mar 2007 14:53:41 +1000
Message-ID: <20070326045341.GE10545@ws35.commsecure.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 26 07:55:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HViB7-0003I8-MZ
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 07:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932760AbXCZFzf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 01:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933602AbXCZFzf
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 01:55:35 -0400
Received: from ip-61-14-142-100.asianetcom.net ([61.14.142.100]:40284 "EHLO
	pymail.commsecure.com.au" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S932760AbXCZFze (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Mar 2007 01:55:34 -0400
X-Greylist: delayed 3710 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Mar 2007 01:55:33 EDT
Received: from ws35.commsecure.com.au (unknown [172.16.15.35])
	by pymail.commsecure.com.au (Postfix) with ESMTP id 08E4B2802F
	for <git@vger.kernel.org>; Mon, 26 Mar 2007 14:53:42 +1000 (EST)
Received: by ws35.commsecure.com.au (Postfix, from userid 2136)
	id E19B97065C; Mon, 26 Mar 2007 14:53:41 +1000 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43114>

I'm not subscribed, please Cc me on replies.

My company is considering switching from CVS to a more branch-friendly
version-control tool, and so of course we've been playing with git.
We imported our CVS repository into git with git-cvsimport, which worked
well enough, and resulted in a tree about the same size as the official
kernel repository: 454121 objects, 334977 deltas.

However, operations like 'git-fetch' take much, much longer in our
repository than in the kernel repository: a git-fetch that pulls no
updates in the kernel repository takes 1.7s, while our repository
(fetching from one repository to a clone on the same local disk) takes
about 20 seconds. After some experimentation, we discovered that
deleting all the 5557 imported CVS tags made things fast again.
(Interestingly, "git-fetch --no-tags" was not appreciably quicker, while
the tags were still around)

I searched the mailing list archives for similar problems, and the
closest thread I could find was this one:

    http://thread.gmane.org/gmane.comp.version-control.git/20682/

...however, that thread seems to have decided that large numbers of
binary files were the problem, which is not the case in our repository.

Does git have known scalability problems with large numbers of tags? Is
there anything we can do to mitigate this slowdown, apart from just not
using git's tag feature at all? Are there any details I've overlooked or
misunderstood?

Tim Allen
