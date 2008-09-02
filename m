From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH 1/2] Add utilities for figuring out repositories for selected resources
Date: Tue, 2 Sep 2008 20:53:35 +0200
Message-ID: <200809022053.35419.robin.rosenberg.lists@dewire.com>
References: <1220175524-1523-1-git-send-email-robin.rosenberg@dewire.com> <1220175524-1523-2-git-send-email-robin.rosenberg@dewire.com> <20080902150323.GC28704@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 02 20:57:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kab41-0006O0-2V
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 20:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbYIBS4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 14:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbYIBS4K
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 14:56:10 -0400
Received: from av9-1-sn3.vrr.skanova.net ([81.228.9.185]:51422 "EHLO
	av9-1-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbYIBS4J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 14:56:09 -0400
Received: by av9-1-sn3.vrr.skanova.net (Postfix, from userid 502)
	id 1BEDE38047; Tue,  2 Sep 2008 20:56:06 +0200 (CEST)
Received: from smtp3-2-sn3.vrr.skanova.net (smtp3-2-sn3.vrr.skanova.net [81.228.9.102])
	by av9-1-sn3.vrr.skanova.net (Postfix) with ESMTP
	id F41483803B; Tue,  2 Sep 2008 20:56:05 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-2-sn3.vrr.skanova.net (Postfix) with ESMTP id D191C37E47;
	Tue,  2 Sep 2008 20:56:05 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080902150323.GC28704@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94691>

tisdagen den 2 september 2008 17.03.23 skrev Shawn O. Pearce:
> Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> > We want to go from selected resources to repositories and back
> > to any resource in those repositories
> ...
> > +	protected Repository[] getRepositoriesFor(final IProject[] projects) {
> > +		Set<Repository> ret = new HashSet<Repository>();
> > +		for (IProject project : projects) {
> > +			RepositoryMapping repositoryMapping = RepositoryMapping.getMapping(project);
> > +			if (repositoryMapping == null)
> > +				return new Repository[0];
> > +			ret.add(repositoryMapping.getRepository());
> > +		}
> 
> Hmm.  So if any one of the selected projects doesn't have a Git
> repository at its top level we just plain fail and pretend none of
> them have a Git repository?  That doesn't seem right to me.  We
> should just skip that project and move to another project.

That is the way everything in Eclipse work. For an operation to be applicable
to a selection, it must be applicable to eache element. Yes, I get annoyed
at that sometimes myself, but that doesn't convince me we should be
the one plugin that breaks the pattern.

Actually what happens is that the whole action gets disabled if all projects
do not satisfy the criteria.

> But I also wonder if that really makes sense when a project could
> have a linked resource under it that points to the repository's
> working directory.  In such cases we want operations on that project
> to potentially impact the inner repository as maybe the project
> repository does not have a repository itself.  IOW I'm questioning
> the idea of getRepositoriesFor(getProjectsForSelectedResources()).

Ouch for linked resources. I really think we should ignore the link as much
as we can. It's a trap! I any way it needs more fixing that this and not
only here. A patch does not have to solve all problems in the world :)

I have no experience with linked resources, other that I found them enough
awkward to use to prevent from doing that. How useful and portable is
a C:\foo on my system? I don't mind anyone solving the problem, but it is
very low on my personal agenda.

-- robin
