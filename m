From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: StGIT (or guilt) + git-svn?
Date: Wed, 25 Jul 2007 18:25:09 -0400
Message-ID: <20070725222509.GA21274@dervierte>
References: <46A5D279.7060601@midwinter.com> <20070724112706.GA9540@dervierte> <46A5EE4B.7020905@midwinter.com> <20070724234817.GA29700@dervierte> <46A6EF24.4040606@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Walter <stevenrwalter@gmail.com>,
	'git' <git@vger.kernel.org>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 00:25:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDpIG-0003ZS-P6
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 00:25:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758658AbXGYWZP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 18:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756767AbXGYWZP
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 18:25:15 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:23224 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551AbXGYWZN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 18:25:13 -0400
Received: by py-out-1112.google.com with SMTP id d32so634030pye
        for <git@vger.kernel.org>; Wed, 25 Jul 2007 15:25:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=dvU5ko9e/3OPy78hnLyK1zOfovAcpqWlGd3I84YWBMF4cnIlM7sSBtMx8YtpppzEvVTEn+1c9hL4hUPgL9aa0/v7zGDrZqpzVHvwn9FiVUmRRh6GHEX8sxYxDWsXffpp7EdnZnG25c6oN2Yt59XL69I1LqSkw+Ie2eQbpykE28o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=Jqt4Ks4LzysjM/yQxghIZlAgYfGqo2A2QqletaOBjRN7wPhdiKSX9JoucR9H7eACcyhHwC+386fXCeW432zDsQCYmyB9q4vztF7aZ8Q959avC5Ssm2IOvm8a+ns6eIaQVeFKAKH6OK0psgUnGowV7hkNtqxpjZyHHxOMz4DJ8DQ=
Received: by 10.35.69.11 with SMTP id w11mr10212921pyk.1185402312149;
        Wed, 25 Jul 2007 15:25:12 -0700 (PDT)
Received: from dasbrennen.isa-geek.org ( [74.131.192.220])
        by mx.google.com with ESMTPS id f10sm1595269pyh.2007.07.25.15.25.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 Jul 2007 15:25:11 -0700 (PDT)
Received: by dasbrennen.isa-geek.org (Postfix, from userid 1000)
	id 01EF7CFF09F; Wed, 25 Jul 2007 18:25:09 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <46A6EF24.4040606@midwinter.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53726>

On Wed, Jul 25, 2007 at 02:35:16PM +0800, Steven Grimm wrote:
> Do you mix your public and private commits on the private branch, then 
> cherry-pick some of them over to the public branch before running 
> dcommit? Or do you have some other workflow?

Yes, what you describe is what I usually do.

> That was actually my first suggestion to him, but he pointed out (and I 
> had to agree) that that would mean he's always just one mistake away 
> from publishing his local changes. All it takes is getting interrupted 
> for a moment and mistakenly thinking he already switched to the public 
> branch. He wants some less human-error-prone way to tell the system that 
> a particular change and/or a particular file is not intended for 
> publication, and for the system to just honor that without further human 
> intervention.

If I wanted to be argumentative, you're still only one step from
disaster with stgit.  In order to build, you'd have to keep your local
changes applied.  If you forgot to pop them before a dcommit, they would
be published.

> Actually, one could argue that the above isn't a git-svn issue at all. 
> You could reasonably want the same thing from git-push too (and even 
> from pull, though that'd be trickier.) I guess it'd take the form of 
> marking a commit as local-only, and having the system automatically 
> rebase all the local-only commits on top of the public ones.
> 
> Maybe a wrapper than maintains a pair of underlying git branches for 
> each user-visible branch would work. If you have a branch "foo" with 
> some public and some private changes (private ones in lower case here):
> 
> A---B---C---D---e---f---g   foo
>            ^ foo-public
> 
> Now if you commit a new private revision, it's like normal:
> 
> A---B---C---D---e---f---g---h   foo
>            ^ foo-public
> 
> But if you commit a new public revision, we do something like
> 
> git commit
> git checkout foo-public
> git cherry-pick foo
> git checkout foo
> git rebase foo-public
> 
> to get
> 
> A---B---C---D---H---e---f---g   foo
>                ^ foo-public
> 
> Then, when it comes time to do the push / dcommit, we always switch to 
> the foo-public branch first. We push / dcommit, then checkout foo and 
> rebase it on foo-public again (since svn dcommit will leave foo-public 
> pointing at a different revision.)
> 
> This seems like it should work in the context of git-svn with its 
> mostly-linear history. Not sure if it'd fall flat on its face in the 
> presence of lots of branching and merging.
> 
> I also suspect I've more or less just described StGIT and this would be 
> a big waste of time to reinvent from scratch.

This actually sounds fairly useful, as it's mostly the automation of my
existing workflow.  Let me know if you follow up on this.
-- 
-Steven Walter <stevenrwalter@gmail.com>
"A human being should be able to change a diaper, plan an invasion,
butcher a hog, conn a ship, design a building, write a sonnet, balance
accounts, build a wall, set a bone, comfort the dying, take orders,
give orders, cooperate, act alone, solve equations, analyze a new
problem, pitch manure, program a computer, cook a tasty meal, fight
efficiently, die gallantly. Specialization is for insects."
   -Robert Heinlein
