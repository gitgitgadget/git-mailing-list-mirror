From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: recur status on linux-2.6
Date: Fri, 18 Aug 2006 12:00:18 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608181155130.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0608131550290.10541@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v64gwmv2j.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0608132006510.10541@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vveowl8sm.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0608132221030.10541@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vwt96d6s1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 12:00:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GE19M-0003y7-2p
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 12:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWHRKAV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 06:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWHRKAV
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 06:00:21 -0400
Received: from mail.gmx.de ([213.165.64.20]:26798 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751335AbWHRKAU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Aug 2006 06:00:20 -0400
Received: (qmail invoked by alias); 18 Aug 2006 10:00:18 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 18 Aug 2006 12:00:18 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwt96d6s1.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25643>

Hi,

On Thu, 17 Aug 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Sun, 13 Aug 2006, Junio C Hamano wrote:
> >
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> 
> >> > I fail to see how this is worse than -recursive...
> >> 
> >> These are what I got.  ls-files -u output followed by git diff.
> >
> > I am a little confused here: I thought it would be enough to compare the 
> > outputs of "git-ls-files --stage". But that seems wrong.
> >
> > What are the stages for, again?
> 
> I do not offhand remember what git-merge-recursive and
> git-merge-recur store in stage #1 when they recurse to create a
> virtual common ancestor.  I expected it would contain the blob
> used as the base for the final file-level three-way merge
> (i.e. the blob in the virtual common ancestor), and if that is
> the case, i.e. if the blob matches the second argument for
> "merge" (from RCS), it should be enough to check that the stages
> match to verify two implementations do the same thing.
> 
> But in practice, stage #1 is not very interesting nor useful
> after a conflicted merge (git diff --ours and git diff --theirs
> are more useful, so is git log -p --merge), so it is possible
> that merge-recursive is leaving the blob from one of the true
> common ancestors there while using the blob from the virtual
> common ancestor to produce the final result in the working tree
> and nobody has noticed.  I dunno.

Makes sense.

I finally got around to do updated tests, with both git-ls-files --stage 
and "git diff". It seems like the only issue in the git repository _is_ 
10a6653c8. I have not yet had the time to analyze this merge (it is 
huge!), but I guess recur becomes confused by the timestamps.

Ciao,
Dscho
