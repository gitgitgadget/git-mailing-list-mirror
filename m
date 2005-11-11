From: Petr Baudis <pasky@suse.cz>
Subject: Re: tracking a tree that doesn't progress linearly
Date: Fri, 11 Nov 2005 12:06:25 +0100
Message-ID: <20051111110625.GO30496@pasky.or.cz>
References: <17268.3463.252020.591687@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 12:07:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaWjm-0000WF-Q1
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 12:06:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbVKKLG2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 06:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbVKKLG2
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 06:06:28 -0500
Received: from w241.dkm.cz ([62.24.88.241]:13987 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750886AbVKKLG1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 06:06:27 -0500
Received: (qmail 25801 invoked by uid 2001); 11 Nov 2005 12:06:25 +0100
To: Paul Mackerras <paulus@samba.org>
Content-Disposition: inline
In-Reply-To: <17268.3463.252020.591687@cargo.ozlabs.ibm.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11584>

Dear diary, on Fri, Nov 11, 2005 at 04:18:31AM CET, I got a letter
where Paul Mackerras <paulus@samba.org> said that...
> I want to be able to publish a git tree for others to follow but I
> also want to be retain the freedom to remove commits and/or rebase
> commits in the tree.  For example, if someone sends me a patch and I
> put it in the tree, then they send me a revised version, I want to be
> able to roll back to just before I applied the older patch and start
> again from there.
> 
> What this means, AFAICS, is that the head of the published tree won't
> always be a descendent of all previous values of the head.  If
> somebody is following the state of the tree by doing a git pull every
> so often, and I have rolled back the tree and applied some new
> patches, then the git pull will try to merge the old and new state,
> which is not what we want.  What we want is something that just gets
> the local tree to the same state as the remote tree.
> 
> Is there a git command which does the equivalent of a git fetch,
> followed by setting the head and checking it out?

I plan to change the fast-forward condition in Cogito from

	is_ancestor(current, new_head)

to

	current == old_head || is_ancestor(current, new_head)

which should enable you to do this - just rebase, and it will Just Work
for those cg-update'ing from you; the only problem si that cg-fetch +
cg-merge will NOT work, but I have no simple workaround for that.

I already proposed this several times and it was always passed in
silence, so I assume there are no problems with this approach.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
