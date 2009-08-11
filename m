From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Unable to checkout a branch after cloning
Date: Tue, 11 Aug 2009 14:04:25 +0200
Message-ID: <4A815E49.60406@drmicha.warpmail.net>
References: <4A814392.4080803@bubblegen.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthew Lear <matt@bubblegen.co.uk>
X-From: git-owner@vger.kernel.org Tue Aug 11 14:05:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Maq6P-0004GO-Be
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 14:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752984AbZHKMEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 08:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752981AbZHKMEn
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 08:04:43 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:41205 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752940AbZHKMEj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 08:04:39 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4121B12414;
	Tue, 11 Aug 2009 08:04:40 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 11 Aug 2009 08:04:40 -0400
X-Sasl-enc: YjhxMhjjIESmxUZ5Mvm/x61FL2ql/1SQLEoQ94BYV/Q+ 1249992279
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3D4E714D77;
	Tue, 11 Aug 2009 08:04:39 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.3pre) Gecko/20090811 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <4A814392.4080803@bubblegen.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125521>

Matthew Lear venit, vidit, dixit 11.08.2009 12:10:
> Hi all,
> 
> Apologies for perhaps a silly question, but I'd very much appreciate a
> little bit of assistance.
> 
> I've set up a git repository on a machine accessible from the internet
> with the intention to share code with another developer. We clone the
> repository, commit changes then push back as you'd expect. The server
> runs gitweb for repository browsing. Clients are running git v1.6.0.6.
> 
> When I created the initial repository I also created two additional
> branches - 'upstream' and 'custom'. The former is to act as a 'vendor
> branch' and the latter contains code specific to the custom platform
> that we're working on. The master branch contains merges from the
> upstream branch and also changes that we've made. The custom branch
> contains merges from master with custom platform specific changes.
> 
> I've committed changes and on both upstream and custom branches as work
> progressed, merged them where appropriate, added tags etc and pushed
> everything to the remote repository. No problem. I can view the
> branches, tags etc in gitweb and everything looks fine.
> 
> However, I can clone a new repository just fine but I'm unable to
> checkout the upstream or custom branches. After cloning, only the master
> branch is available, ie:
> 
>> git checkout upstream
> error: pathspec 'upstream' did not match any file(s) known to git.
> 
>> git branch -a
> * master
>   origin/HEAD
>   origin/master
> 
> .git/config:
> 
> [core]
>         repositoryformatversion = 0
>         filemode = true
>         bare = false
>         logallrefupdates = true
> [remote "origin"]
>         url = https://mysite/git/project.git
>         fetch = +refs/heads/*:refs/remotes/origin/*
> [branch "master"]
>         remote = origin
>         merge = refs/heads/master
> 
> But the initial local repository where I work (ie created the branches,
> committed changes, tag, push etc) seems to be fine, ie
> 
>> git checkout upstream
> Switched to branch "upstream"
> 
>> git branch -a
>   custom
> * master
>   upstream
> 
> .git/config:
> 
> [core]
>         repositoryformatversion = 0
>         filemode = true
>         bare = false
>         logallrefupdates = true
> [remote "origin"]
>         url = https://mysite/git/project.git
>         fetch = +refs/heads/*:refs/remotes/origin/*
> 
> 
> Developers need to be able to clone the repository and then switch to
> the appropriate branch in order to work. However it seems that after a
> clone, only the master branch is available.
> 
> Why is this?
> 
> Any help would be much appreciated indeed.

If I understand you correctly you have 3 repos: the "initial" one on
which everything is as expected, the "server" one and the "new clone"
which is missing branches.

Now: How's the server one doing, i.e. what does "git ls-remote
https://mysite/git/project.git" say? I suspect that one either does not
have the branches (you haven't told us how you pushed) or in the wrong
place (remotes/).

Michael
