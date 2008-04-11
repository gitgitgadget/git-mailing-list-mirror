From: Eric Blake <ebb9@byu.net>
Subject: Re: backdated tag bug
Date: Fri, 11 Apr 2008 20:54:51 +0000 (UTC)
Message-ID: <loom.20080411T204008-458@post.gmane.org>
References: <loom.20080411T193913-700@post.gmane.org> <alpine.LFD.1.00.0804111333270.3143@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 11 22:55:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkQHk-0005OF-KQ
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 22:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760058AbYDKUzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 16:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759184AbYDKUzD
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 16:55:03 -0400
Received: from main.gmane.org ([80.91.229.2]:52337 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759178AbYDKUzB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 16:55:01 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JkQGy-0005YA-Dc
	for git@vger.kernel.org; Fri, 11 Apr 2008 20:55:00 +0000
Received: from eblake.csw.l-3com.com ([128.170.36.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 Apr 2008 20:55:00 +0000
Received: from ebb9 by eblake.csw.l-3com.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 Apr 2008 20:55:00 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 128.170.36.124 (Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50727; InfoPath.1; .NET CLR 3.0.04506.30; .NET CLR 3.0.04506.648))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79297>

Linus Torvalds <torvalds <at> linux-foundation.org> writes:

> > According to 'git tag --help', it should be possible to create a signed, 
back-
> > dated tag.  But I can't get it to work.  Am I doing something wrong, or is 
this 
> > a git bug?  Shell transcript follows:
> 
> Tags don't have an "author". They have a "tagger", and it's taken from the 
> normal committer information. So you should use GIT_COMMITTER_DATE instead 
> of GIT_AUTHOR_DATE and it should work.

Thanks.  At first, I thought it failed: the only human-readable date string in 
the output of 'git tag -v v1' was the date of the gpg signature, which was of 
course today.  But on closer inspection, the raw seconds listing in the tagger 
line was indeed older, and 'git show v1' shows the desired human-readable back-
date of yesterday.  So, can we get the 'git tag' documentation fixed to mention 
GIT_COMMITTER_DATE, and can 'git tag -v' be improved to show the tagger date in 
human-readable form?

And I still think it would be nice if 'git mktag --help' mentioned how to use 
gpg to create a valid signed tag, rather than just vaguely stating that it can 
be done, since I couldn't figure out how to create a tag signature file that 
would pass subsequent verification.

-- 
Eric Blake
