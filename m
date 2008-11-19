From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Git commit won't add an untracked file given on the command
 line
Date: Wed, 19 Nov 2008 13:01:04 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0811191247560.19665@iabervon.org>
References: <20081118211237.234d8035@crow> <200811182227.20076.fge@one2team.com> <20081118214730.005fc72d@crow> <alpine.DEB.1.00.0811190206170.30769@pacific.mpi-cbg.de> <20081119095452.3018d2de@crow> <alpine.DEB.1.00.0811191226530.30769@pacific.mpi-cbg.de>
 <7vd4grsveo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Burton <markb@ordern.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 19:02:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2rNg-0006Fb-US
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 19:02:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906AbYKSSBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 13:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752388AbYKSSBI
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 13:01:08 -0500
Received: from iabervon.org ([66.92.72.58]:54883 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752107AbYKSSBG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 13:01:06 -0500
Received: (qmail 14973 invoked by uid 1000); 19 Nov 2008 18:01:04 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Nov 2008 18:01:04 -0000
In-Reply-To: <7vd4grsveo.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101362>

On Wed, 19 Nov 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Wed, 19 Nov 2008, Mark Burton wrote:
> >
> >> Having said that, I still like the concept of being able to add named 
> >> files without touching the index.
> >
> > That's just impossible.  You cannot create a tree object, let alone a 
> > commit object, without touching the index (AKA staging area).
> 
> I do not think Mark really _means_ "not in the index".
> 
> The wish is more like "I want to let git know that I am interested in this
> path, but I'm not ready to say what exact content I want for that path in
> the next commit, not just yet".
> 
> I do not think that is an unreasonable wish.  On the other hand, it is
> unreasonable for anybody to insist that we satisfy the wish without
> touching the index.  The index is the most natural place to do that.

I don't think that's what Mark wants, in this case. He's looking for the 
ability to have "git commit" act on a temporary index created by adding to 
the parent commit explicitly named files which aren't in the non-temporary 
index. That is, Mark doesn't want to touch *the* index, which is fine; git 
can commit with *an* index.

> We have a half (probably a quarter) of what we need for that implemented
> already, by the way.

I've looked into what you're suggesting on occasion; the main issue is 
getting the various index users to avoid getting confused. I was stumped 
by the diff code, which was confusing the "intent to add something" token 
with its "compare against the work tree" token. I'd say, it's half 
implemented, but testing is a major unstarted undertaking.

	-Daniel
*This .sig left intentionally blank*
