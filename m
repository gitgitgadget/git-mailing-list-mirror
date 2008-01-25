From: Mike <fromlists@talkingspider.com>
Subject: Re: What's a "work tree"?
Date: Fri, 25 Jan 2008 15:54:55 -0500
Message-ID: <479A4C9F.3070200@talkingspider.com>
References: <4798E26D.3040707@talkingspider.com> <20080125061421.GC21973@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 25 21:56:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIVaf-0004PU-58
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 21:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760617AbYAYUy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 15:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755998AbYAYUy7
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 15:54:59 -0500
Received: from relay01.pair.com ([209.68.5.15]:4662 "HELO relay01.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760595AbYAYUy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 15:54:57 -0500
Received: (qmail 350 invoked from network); 25 Jan 2008 20:54:56 -0000
Received: from unknown (HELO ?192.168.1.100?) (unknown)
  by unknown with SMTP; 25 Jan 2008 20:54:56 -0000
X-pair-Authenticated: 72.225.213.70
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <20080125061421.GC21973@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71738>



Jeff King wrote:
> On Thu, Jan 24, 2008 at 02:09:33PM -0500, Mike wrote:
> 
>> I'm trying to figure out what a "work tree" is.  as in --work-tree. This 
>> is a new command right, the tutorials I've read don't have it. The man 
>> page has the syntax but I don't know what it's for.
> 
> The work tree is the place where your checked out files reside. E.g.,
> in an ordinary repo (made with "git init" or "git clone") everything
> that isn't in the .git directory.
> 
>> $ cd /www/mysitedocroot
>> $ git --git-dir /gitdir/mysitegit/ add .
>> fatal: add must be run in a work tree
> 
> You are using --git-dir to point to a repository directory that isn't
> ".git". That's OK, and it will generally assume that your current
> directory is the work tree. E.g., this works:
> 
>   mkdir repo && cd repo
>   git init
>   mv .git mygitdir
>   touch file
>   git --git-dir=mygitdir add file
> 
> However, there is a config option "core.bare" which indicates that a
> repository is "bare", meaning that it has no work tree (and that is
> presumably what's happening in your example). So you could use
> --work-tree=. to override that in your example (though you might just be
> better off setting config.bare to false).
> 
> The more probable use case for --work-tree is something like
> 
>   $ cd /gitdir/mysitegit
>   $ git --work-tree=/www/mysitedocroot add .
> 
> i.e., you are in the git dir, so you specify the work tree rather than
> the other way around. You could even do this:
> 
>   $ cd /some/other/directory
>   $ git --git-dir=/gitdir/mysitegit --work-tree=/www/mysitedocroot add .
> 
> although I'm not sure it's that useful.
> 
> -Peff

Yes, thanks, I was actually following this tutorial:

http://www.kernel.org/pub/software/scm/git/docs/cvs-migration.html

Which is how I ended up with a "bare" git dir.  Which actually I think 
I'm ok with, seems to work ok.

For others with the same questions, here's how I found what work-tree 
means last night:

http://www.kernel.org/pub/software/scm/git/docs/glossary.html

I think I got there through the git wiki.

Also- I found out I needed a newish version of git to get the 
--work-tree argument. The CentOS repos have an older version, 1.2.something.

thanks
