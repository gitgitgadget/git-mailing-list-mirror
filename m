From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Bug in git-svn: dcommit commits in the wrong branch after a rebase
Date: Thu, 09 Aug 2007 23:46:03 +0800
Message-ID: <46BB36BB.4030708@midwinter.com>
References: <21FC6D7F-5459-406D-AA06-D16E525B3C17@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Benoit SIGOURE <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Thu Aug 09 17:46:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJADE-0007n9-5Q
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 17:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938987AbXHIPqH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 11:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932920AbXHIPqG
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 11:46:06 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:58530 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S938928AbXHIPqF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 11:46:05 -0400
Received: (qmail 19764 invoked from network); 9 Aug 2007 15:46:03 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=MdT1Xx7MVSyLMxAZVRWdvZA9bXggRUZD6+AiLv4N+dFxfXEtPwrA1H1yZHRhXdnc  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 9 Aug 2007 15:46:03 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <21FC6D7F-5459-406D-AA06-D16E525B3C17@lrde.epita.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55457>

Benoit SIGOURE wrote:
> git-svn fetch
> git-checkout -b myb b
> git-rebase master
> git-svn dcommit # sends the commit to SVN branch `a' instead of SVN 
> branch `b'!

That's exactly what I would expect to happen. The "git-rebase" is the 
key here; it is effectively telling git to switch back to your master 
branch. Try running "git log" before and after the rebase command and 
you should get a slightly better idea of what's happening. Rebase is 
kind of a tricky beast; a basic rule of thumb is that you should only 
use it to go forward in time on a single upstream branch, not to hop 
between upstream branches. Its behavior in non-forward-in-time cases is 
predictable once you know how it works, but not necessarily intuitive.

What are you expecting rebase to do here? We can probably suggest some 
other commands that will do what you're hoping to do. My hunch is that 
you're trying to use it to effectively do a merge of your "a" and "b" 
branches, but maybe I'm wrong about that.

-Steve
