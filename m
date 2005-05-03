From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: questions about cg-update, cg-pull, and cg-clone.
Date: Tue, 3 May 2005 08:59:15 -0700
Message-ID: <20050503155915.GV4747@ca-server1.us.oracle.com>
References: <20050430005322.GA5408@tumblerings.org> <20050502195846.GC20818@pasky.ji.cz> <20050503152214.GA1704@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 03 17:54:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSziU-0004di-Jm
	for gcvg-git@gmane.org; Tue, 03 May 2005 17:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbVECP7u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 11:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbVECP7t
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 11:59:49 -0400
Received: from agminet02.oracle.com ([141.146.126.229]:57907 "EHLO
	agminet02.oracle.com") by vger.kernel.org with ESMTP
	id S261800AbVECP7c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2005 11:59:32 -0400
Received: from rgmgw2.us.oracle.com (rgmgw2.us.oracle.com [138.1.191.11])
	by agminet02.oracle.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id j43FxFZJ006727;
	Tue, 3 May 2005 10:59:16 -0500
Received: from rgmgw2.us.oracle.com (localhost [127.0.0.1])
	by rgmgw2.us.oracle.com (Switch-3.1.4/Switch-3.1.0) with ESMTP id j43FxFWA007461;
	Tue, 3 May 2005 09:59:15 -0600
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.118.41])
	by rgmgw2.us.oracle.com (Switch-3.1.4/Switch-3.1.0) with ESMTP id j43FxFCj007444;
	Tue, 3 May 2005 09:59:15 -0600
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.50)
	id 1DSznn-0006Sg-93; Tue, 03 May 2005 08:59:15 -0700
To: Zack Brown <zbrown@tumblerings.org>
Content-Disposition: inline
In-Reply-To: <20050503152214.GA1704@tumblerings.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, May 03, 2005 at 08:22:15AM -0700, Zack Brown wrote:
> So, suppose I'm working on your Cogito HEAD. I make some changes to my local
> tree and commit them to my tree, and then before I go forward, I want to grab
> whatever you've done recently, to make sure we're not in conflict before I add
> new changes. If I understand you right, this situation would be a 'fast forward
> merge'. So what is the command I give to just 'merge' your HEAD with mine,
> without requiring a changelog entry?

	Remember that HEAD is merely a SHA1 of the toplevel tree object.
Imagine you have the simplest tree, one directory containing one file.
The file has the has hash aaaaaa.  The tree object containing it has the
hash bbbbbb.  So, HEAD contains bbbbbb.
	Now you update from Petr, having made no changes.  You pull his
newest tree, which also has a new file.  That new file has the hash
cccccc.  The new tree object, containing both files, now has the hash
dddddd.  HEAD now contains dddddd.  As you are in a matching state to
his tree, you have not done anything interesting to your tree, and there
is no commit.  This is a "fast-forward" merge.
	Then you change the first file, adding a few functions.  You
commit it, and it now has the hash 111111.  This change means the tree
hash becomes 222222.  So, HEAD contains 222222.
	You then update from Petr again.  He's changed the second file.
It's hash is no longer cccccc, it's eeeeee.  In his tree, the hash of
the tree is 333333 (from file 1's aaaaaa and file 2's eeeeee).  But the
hash of your tree is 444444 (from your local file 1's 111111 and file 2's eeeeee).  So, the hash of the your tree becomes 444444.  Your HEAD contains 444444.
This does _not_ match his 333333 HEAD.  You are committing the
combination of his change and yours.  He is saying that this work, which
may have required hand-merging or commit resolution, is "interesting"
information.

Joel

-- 

Life's Little Instruction Book #69

	"Whistle"

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
