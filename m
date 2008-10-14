From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2] Fix fetch/pull when run without --update-head-ok
Date: Tue, 14 Oct 2008 12:04:43 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0810141200140.19665@iabervon.org>
References: <alpine.DEB.1.00.0810111336350.22125@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.LNX.1.00.0810121501590.19665@iabervon.org> <alpine.DEB.1.00.0810131129110.22125@pacific.mpi-cbg.de.mpi-cbg.de> <7vod1obmlh.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0810132001230.22125@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.LNX.1.00.0810131546180.19665@iabervon.org> <alpine.DEB.1.00.0810141145491.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081014150227.GC4856@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 14 18:08:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpmPE-00046w-C2
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 18:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157AbYJNQEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 12:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752884AbYJNQEp
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 12:04:45 -0400
Received: from iabervon.org ([66.92.72.58]:57582 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156AbYJNQEp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 12:04:45 -0400
Received: (qmail 12322 invoked by uid 1000); 14 Oct 2008 16:04:43 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Oct 2008 16:04:43 -0000
In-Reply-To: <20081014150227.GC4856@spearce.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98193>

On Tue, 14 Oct 2008, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Mon, 13 Oct 2008, Daniel Barkalow wrote:
> > 
> > > On Mon, 13 Oct 2008, Johannes Schindelin wrote:
> > > 
> > > > I actually understand now why the tests started failing: the change from 
> > > > resolve_ref() to get_branch() as requested by Daniel are at fault: 
> > > > get_branch() does not check if the branch has an initial commit.
> > 
> > So, my vote is to revert back to resolve_ref(), even if it needs more 
> > lines.
> 
> Yes, I agree, resolve_ref() is the best thing to be using here,
> even if it is more code.  get_branch() validates the commit and we
> don't want that.  We really just want to know if the current branch
> is going to be updated, we don't care to what/why.

It doesn't validate the commit; it doesn't even validate the symref. The 
resolve_ref()-using code validates the symref, and I think that's an 
error; we also don't care what state we'd update the current branch from.

	-Daniel
*This .sig left intentionally blank*
