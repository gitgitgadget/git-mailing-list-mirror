From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How to sync two svn repositories via git?
Date: Thu, 02 Apr 2009 09:41:31 +0200
Message-ID: <49D46C2B.3080100@drmicha.warpmail.net>
References: <20090401223052.GA28619@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 02 09:43:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpHaH-0005yd-5x
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 09:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765577AbZDBHli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 03:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764298AbZDBHlh
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 03:41:37 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:32883 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763856AbZDBHlh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Apr 2009 03:41:37 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id ED93D30BD32;
	Thu,  2 Apr 2009 03:41:34 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 02 Apr 2009 03:41:34 -0400
X-Sasl-enc: 6tlL678iE7tAsuCO0jAFmcn0oP+llat5SZapFI4IM57a 1238658094
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5FC1A35B20;
	Thu,  2 Apr 2009 03:41:34 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090401 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <20090401223052.GA28619@raven.wolf.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115449>

Josef Wolf venit, vidit, dixit 02.04.2009 00:30:
> Hello,
> 
> I have two subversion repositories which I would like to synchronize via
> git-svn.  For this, I have set up a git repository and configured two
> branches to track the subversion repositories via git-svn:
> 
>     mkdir test-sync
>     cd    test-sync
>     git svn init --stdlayout file://$REPOSDIR/svn-first
> 
>     for repos in svn-first svn-second; do
>         git config svn-remote.$repos.url      file://$REPOSDIR/$repos
>         git config svn-remote.$repos.fetch    trunk:refs/remotes/$repos/trunk
>         git config svn-remote.$repos.branches branches/*:refs/remotes/$repos/*
>         git config svn-remote.$repos.tags     tags/*:refs/remotes/$repos/tags/*
>         git svn fetch -R $repos
>         git checkout -b $repos $repos/trunk
>     done
>     git gc
> 
> This gives me two remote and two local branches:
> 
>     master                                                                                    
>     svn-first                                                                                 
>   * svn-second                                                                                
>     svn-first/trunk                                                                           
>     svn-second/trunk                                                                          
> 
> The first step I'd like to do is to "mirror" the manual merges that were
> done between the subversion repositories in the past:
> 
>     git checkout svn-first
>     git merge -s ours --log commit-of-the-first-merge-in-svn-second
> 
>     git checkout svn-second
>     git merge -s ours --log commit-of-the-first-merge-in-svn-first
> 
> This seems to work, but git-gui shows conflicts.  How can I get conflicts
> when I use the "-s ours" merge strategy?

What do git status and git diff (--stat, --combined) say?
