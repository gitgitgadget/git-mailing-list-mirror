From: Nicolas Pitre <nico@cam.org>
Subject: Re: Fetching SHA id's instead of named references?
Date: Wed, 08 Apr 2009 16:38:52 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904081624410.6741@xanadu.home>
References: <33f4f4d70904060513k320fb6a0ya928c714dcd11e89@mail.gmail.com>
 <alpine.DEB.1.00.0904061431020.6619@intel-tinevez-2-302>
 <20090406144047.GE23604@spearce.org>
 <33f4f4d70904060922t5c868ec0x89ed5891cf4b19c2@mail.gmail.com>
 <alpine.LFD.2.00.0904061245111.6741@xanadu.home>
 <33f4f4d70904061640j1b03c499x1765da1a72a411f3@mail.gmail.com>
 <alpine.LFD.2.00.0904062214170.6741@xanadu.home>
 <4CBB910C-24F5-4F51-A02D-7760839CCE18@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Users List <git@vger.kernel.org>
To: Klas Lindberg <klas.lindberg@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 22:41:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lrea0-00067M-2i
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 22:41:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763115AbZDHUjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 16:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761696AbZDHUjT
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 16:39:19 -0400
Received: from relais.videotron.ca ([24.201.245.36]:31135 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761054AbZDHUjS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 16:39:18 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KHS006JLUN28BA0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 08 Apr 2009 16:37:50 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <4CBB910C-24F5-4F51-A02D-7760839CCE18@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116119>

On Wed, 8 Apr 2009, Klas Lindberg wrote:

> 7 apr 2009 kl. 04.34 skrev Nicolas Pitre:
> 
> > In git terms, this is called "history rewriting".  And you really don't
> > want to do that if your repository is pulled by other people, unless
> > there is an explicit statement about that fact.
> 
> I thought you had to use filter-branch to qualify for history rewriting?

That, or 'git rebase', or 'git reset', or 'git commit --amend' on an 
already published commit, or reusing a branch name for a different line 
of development.  Anything that would look like the past has changed to a 
client fetching from you.

> Anyway, the scenario I have in mind is when a new branch is created from the
> old one, the old one deleted and then the name of the old one gets reused. The
> deltas are still there, intact, but now you have to use a different named
> reference to reach them  :-(

Right.  And normally you would use a good name for the new branch that 
clearly indicate its archiving purpose.

> > Thing is, with the distributed nature of git, nothing prevents you from
> > keeping a local version of the commit you're interested in.  Unlike with
> > a central repository where someone else might delete a branch you need,
> > with git you will still have access to that particular commit locally
> > regardless if the remote repository has deleted it or not.
> 
> This is true, and Git is indeed very good at saving your ass on the client
> side. Other systems spend much more effort on saving your ass on the server
> side. My problem is that "my" people responsible for the overall system are
> mostly interested in the server side. At least that is where they put the
> tough requirements on perpetual availability.

Just never allow for any branch to be deleted nor rewound on the server 
then.

> However, it is good enough if there is some way to somehow guarantee that a
> branch or tag will never be misused as outlined above. This could be solved
> through basic file system mechanisms (like write protecting the refs/tags
> files perhaps?) or a backup mechanism that raises an alarm on forbidden
> manipulations, or a host of other more or less weird mechanisms. Git doesn't
> have to provide the mechanism directly, but it would be nice for enterprise
> users if it did.

Git provides you with hooks.  Have a look here:

   http://www.kernel.org/pub/software/scm/git/docs/githooks.html


Nicolas
