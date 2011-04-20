From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] git-p4: add option to preserve user names
Date: Tue, 19 Apr 2011 20:10:38 -0400
Message-ID: <20110420001038.GB28768@arf.padd.com>
References: <1303236078-14011-1-git-send-email-luke@diamand.org>
 <1303236078-14011-2-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Apr 20 02:10:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCL0L-0000V1-Dx
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 02:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754067Ab1DTAKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 20:10:43 -0400
Received: from honk.padd.com ([74.3.171.149]:36170 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753670Ab1DTAKm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 20:10:42 -0400
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id 65BC8F8;
	Tue, 19 Apr 2011 17:10:41 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 4C98A319E7; Tue, 19 Apr 2011 20:10:38 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1303236078-14011-2-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171826>

luke@diamand.org wrote on Tue, 19 Apr 2011 19:01 +0100:
> Patches from git passed into p4 end up with the committer
> being identified as the person who ran git-p4.
> 
> With "submit --preserve-user", git-p4 sets P4USER. If the
> submitter has sufficient p4 permissions, the p4 equivalent
> of the git email committer will be passed into perforce.

I like the idea.  Have often thought about using this approach
myself.  Some comments:

1.  Can we have a .git/config option too?

2.  p4 users output is already cached; you should use
    the same loadUserMapFromCache() and friends, or refactor
    to share the cache.

3.  Andrew will convert your tabs into spaces later, maybe save him
    the effort now.

4.  Do you need both "P4USER" and "User:" for this to work?
    Perhaps just use the "User:" one if so, it is a bit more
    concise.

5.  Document how "p4 protect" is used to give admin privileges
    needed for this to work, but won't tell you if you have them.
    I think it may be true that "p4 typemap -o" needs admin
    priviliges, and is a way to test if you ever need that.

6.  What happens if you try, and don't have admin?  Does it
    silently just use you instead?  And your comment about
    "fixup later manually": I've always wondered how actually
    to do that with p4, can you advise?

7.  Super-bonus points for a test case in t/t9800-git-p4.sh.  :)

		-- Pete
