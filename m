From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Git commit won't add an untracked file given on the command
 line
Date: Wed, 19 Nov 2008 18:52:36 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0811191809430.19665@iabervon.org>
References: <20081118211237.234d8035@crow> <200811182227.20076.fge@one2team.com> <20081118214730.005fc72d@crow> <alpine.DEB.1.00.0811190206170.30769@pacific.mpi-cbg.de> <20081119095452.3018d2de@crow> <alpine.DEB.1.00.0811191226530.30769@pacific.mpi-cbg.de>
 <7vd4grsveo.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0811191247560.19665@iabervon.org> <7v7i6zs4ay.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Burton <markb@ordern.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 00:53:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2wrp-0006Pc-GJ
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 00:53:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752453AbYKSXwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 18:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752465AbYKSXwi
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 18:52:38 -0500
Received: from iabervon.org ([66.92.72.58]:56521 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752208AbYKSXwi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 18:52:38 -0500
Received: (qmail 25451 invoked by uid 1000); 19 Nov 2008 23:52:36 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Nov 2008 23:52:36 -0000
In-Reply-To: <7v7i6zs4ay.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101384>

On Wed, 19 Nov 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > I don't think that's what Mark wants, in this case. He's looking for the 
> > ability to have "git commit" act on a temporary index created by adding to 
> > the parent commit explicitly named files which aren't in the non-temporary 
> > index.
> 
> Ah, I think that it would not be an entirely unreasonable thing to do
> (cf. Message-Id: <7vtza4trdp.fsf@gitster.siamese.dyndns.org>).
> 
> You can say "git add that/directory" and .gitignore mechanism protects you
> from crufts in that/directory, so fearing "git commit that/directory" to
> add random junk to the next commit is not a reason to fear it.
> 
> But that is a huge behaviour change.  For example, I have a handful test
> scripts in my t/ directory (all named following the usual t????-*.sh
> naming convention) that I do not want to commit.  Today, after making
> changes to the tracked test scripts, I can rely on "git commit t/" not to
> include them in the commit, and I've _learned_ to trust that behaviour.
> I'd be surprised if others who have used git for more than a few months
> haven't done so as well.
> 
> Allowing what Mark wants without any explicit user customization will be a
> disaster to the end user experience.

There are two possible limits that would preserve your case while handling 
Mark's case: one is to only look at untracked files at all for names that 
don't match any tracked files, and the other (independantly) is to treat 
names as single filenames instead of patterns for untracked files.

Either of these (or both) should keep the existing behavior for using a 
pattern on the command line as a filter for which of the tracked files to 
commit (since any pattern of tracked files won't be the name of an 
individual untracked file).

	-Daniel
*This .sig left intentionally blank*
