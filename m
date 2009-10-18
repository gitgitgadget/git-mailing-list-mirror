From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Creating something like increasing revision numbers
Date: Sun, 18 Oct 2009 17:43:39 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910181727130.32515@iabervon.org>
References: <20091018144158.GA9789@gandalf.dynalias.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Norbert Preining <preining@logic.at>
X-From: git-owner@vger.kernel.org Sun Oct 18 23:43:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzdXW-00045H-Lw
	for gcvg-git-2@lo.gmane.org; Sun, 18 Oct 2009 23:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754325AbZJRVng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 17:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753311AbZJRVng
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 17:43:36 -0400
Received: from iabervon.org ([66.92.72.58]:38975 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751877AbZJRVnf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 17:43:35 -0400
Received: (qmail 5008 invoked by uid 1000); 18 Oct 2009 21:43:39 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Oct 2009 21:43:39 -0000
In-Reply-To: <20091018144158.GA9789@gandalf.dynalias.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130613>

On Sun, 18 Oct 2009, Norbert Preining wrote:

> Dear all,
> 
> (please Cc)
> 
> I am managing some of my projects with git and I am quite happy about it.
> 
> There is another project I am working that is quite big, the subversion
> checkout is about 14Gb. Doing svn up is a pain, it has to open tens of
> thousands of files and directories traversing the whole tree, trashing
> the fs cache and taking ages.
> 
> My idea was to move to git, from what I read it should be more capable
> in handling these type of projects.
> 
> Now, there is one show-stopper I see. From our repository we create a
> set of "packages", and the maximum of the "last-changed" revisions of
> the contained files determine the "version" of the package. This 
> guarantees that any change in a file will increase the revision number
> of the package (some tricks for removals have to be done). This is necessary
> since we are distributing the packages from servers and the version number
> pf a package determines whether it should be upgraded (well known concept).
> 
> Now my question, is there any way to set up something similar with git?
> 
> My idea is that git - like subversion - could (if asked to) count each
> commit (global to the repository, irrelevant of the branch) and give it
> a version number. Since we all will use a bare repository on a server
> and pull/push from/to there, I think that something similar could be possible.

It's possible as long as you don't think of the "version number" as a 
property of the commit, but rather a property that some commits get by 
virtue of having been at some time the commit that's what would be found 
on that particular server at that particular time. Even though the history 
of the *content* is non-linear, the sequence of values stored in 
refs/heads/master on your central server is linear, local, and easy to 
enumerate.

Of course, when someone does a bunch of development in parallel with other 
people, does a final merge, and pushes it back to the server, this only 
increases the version by one, and only the final merge actually has a 
version number at all. For your application, this shouldn't be a problem, 
because the intermediate commits don't ever get packages created of them 
to need to be compared to other packages.

	-Daniel
*This .sig left intentionally blank*
