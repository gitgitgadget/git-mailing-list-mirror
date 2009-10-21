From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] pull: refuse complete src:dst fetchspec arguments
Date: Tue, 20 Oct 2009 20:55:25 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910202044150.14365@iabervon.org>
References: <d561e70f0aa802ceb96eba16d3bb2316134d69c8.1256062808.git.trast@student.ethz.ch> <BLU0-SMTP97AA2287062D9A104101C8AEC00@phx.gbl> <alpine.LNX.2.00.0910202001050.14365@iabervon.org> <BLU0-SMTP889B2109047E949E039EFDAEBF0@phx.gbl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Sean Estabrooks <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Wed Oct 21 02:55:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0PUD-000322-Mr
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 02:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451AbZJUAzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 20:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752341AbZJUAzW
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 20:55:22 -0400
Received: from iabervon.org ([66.92.72.58]:52541 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751782AbZJUAzW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 20:55:22 -0400
Received: (qmail 19662 invoked by uid 1000); 21 Oct 2009 00:55:25 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Oct 2009 00:55:25 -0000
In-Reply-To: <BLU0-SMTP889B2109047E949E039EFDAEBF0@phx.gbl>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130875>

On Tue, 20 Oct 2009, Sean Estabrooks wrote:

> On Tue, 20 Oct 2009 20:15:23 -0400 (EDT)
> Daniel Barkalow <barkalow@iabervon.org> wrote:
> 
> Hi Daniel,
> 
> > Surely, "where you want the head stored locally" is somewhere that's 
> > information about a remote repository, and therefore under "refs/remotes/" 
> > (or "refs/tags/" or something) and therefore not possible to be checked 
> > out (in the "HEAD is a symref to it" sense).
> 
> Maybe, but it could also just be to create a temp local branch for
> merging into additional branches afterward with "checkout other;
> merge temp".   This is especially helpful when pulling from an
> annoyingly long URL instead of from a configured remote.

Maybe it should be fine to do:

$ git fetch long-url-here master:temp
$ git merge temp
$ git checkout other-branch-that-also-needs-it
$ git merge temp

But "temp" is "refs/remotes/temp", not "refs/heads/temp"?

> > Actually, I think it would be good to prohibit fetching into a new or 
> > existing local branch, whether or not it is checked out. We'd probably 
> > need to provide a plumbing method of doing a fetch, though, for script 
> > environments that aren't using the normal porcelain meanings of refs/ 
> > subdirectories. (Defining a bare repo with --mirror as not having local 
> > branches, of course)
> 
> I'm hoping you don't mean that all fetching to a new local branch should
> be prohibited and you're only talking about the current issue of full
> refspecs on and the pull command.   Otherwise i'd say it seems
> unnecessarily restrictive.

I think, actually, that creating or changing a local branch is really not 
what "fetch" (or the fetch part of pull) is about. I think that just leads 
to confusion about what's locally-controlled and what's a local memory of 
something remotely-controlled.

	-Daniel
*This .sig left intentionally blank*
