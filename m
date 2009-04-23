From: Eric Blake <ebb9@byu.net>
Subject: Re: Git-SVN on Cygwin: svn+ssh good, https awkward
Date: Thu, 23 Apr 2009 17:58:24 +0000 (UTC)
Message-ID: <loom.20090423T175124-165@post.gmane.org>
References: <op.usulh7a71e62zd@balu.cs.uni-paderborn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 23 20:00:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx3Db-00044I-Or
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 20:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752983AbZDWR6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 13:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752581AbZDWR6m
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 13:58:42 -0400
Received: from main.gmane.org ([80.91.229.2]:54172 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752446AbZDWR6k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 13:58:40 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Lx3C3-0008O6-S8
	for git@vger.kernel.org; Thu, 23 Apr 2009 17:58:40 +0000
Received: from l3-128-170-36-124.l-3com.com ([128.170.36.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 23 Apr 2009 17:58:39 +0000
Received: from ebb9 by l3-128-170-36-124.l-3com.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 23 Apr 2009 17:58:39 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 128.170.36.124 (Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; .NET CLR 3.0.04506.648; InfoPath.2))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117353>

Matthias Andree <matthias.andree <at> gmx.de> writes:

> 3. UNDERLYING CYGWIN LIMITATIONS
> 
> * unlink a file and subsequent creation of a new file in the same location  
> is not supported.
> 
> * "delete on close" (unlinking an open file) is supported.

These last two points are old information.  I would first recommend that you 
try running the new cygwin 1.7 (still in beta), where unlink() semantics have 
been greatly improved (you can actually unlink() an in-use file and recreate a 
new file by the same name while the old handle is still open).

http://cygwin.com/#beta-test

> 4. FIX SUGGESTIONS AND QUESTIONS
> 
> Can we defer unlink()ing the tempfile until all handles to it are closed?
> 
> Can we let complete and wait for all processes that hold handles to the  
> tempfile.tmp file before attempting to create a new copy?
> 
> Can we use unique tempfile names (timestamps, counter, random number  
> generator) instead of the hardcoded "tempfile.tmp"? This is probably a  
> good idea anyways to evade symlink attacks.

Although newer cygwin may fix your particular problem, this is not a bad 
suggestion for msysgit, so I suspect someone may be bothered enough by this to 
write a patch.  I, however, will not be the one doing it.

-- 
Eric Blake
