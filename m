From: Kevin Daudt <me@ikke.info>
Subject: Re: interactive rebase results across shared histories
Date: Wed, 24 Feb 2016 00:04:01 +0100
Message-ID: <20160223230401.GB15324@ikke.info>
References: <87io1j6laz.fsf@gmail.com>
 <56C91D21.90306@moritzneeb.de>
 <87io1f5nsi.fsf@gmail.com>
 <56CCE3C2.1050608@moritzneeb.de>
Reply-To: git@lists.ikke.info
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Moritz Neeb <lists@moritzneeb.de>, git@vger.kernel.org
To: Seb <spluque@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 00:04:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYM00-0006JX-Ko
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 00:04:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbcBWXEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 18:04:04 -0500
Received: from ikke.info ([178.21.113.177]:37361 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932108AbcBWXED (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 18:04:03 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
	id 8B6F2440082; Wed, 24 Feb 2016 00:04:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <56CCE3C2.1050608@moritzneeb.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287139>

On Tue, Feb 23, 2016 at 11:57:06PM +0100, Moritz Neeb wrote:
> On 02/23/2016 06:39 PM, Seb wrote:
> > On Sun, 21 Feb 2016 03:12:49 +0100,
> > Moritz Neeb <lists@moritzneeb.de> wrote:
> > 
> >> Hi Seb,
> >> On 02/20/2016 11:58 PM, Seb wrote:
> >>> Hello,
> > 
> >>> I've recently learnt how to consolidate and clean up the master
> >>> branch's commit history.  I've squashed/fixuped many commits thinking
> >>> these would propagate to the children branches with whom it shares
> >>> the earlier parts of the its history.  However, this is not the case;
> >>> switching to the child branch still shows the non-rebased (dirty)
> >>> commit history from master.  Am I misunderstanding something with
> >>> this?
> > 
> >> I am not sure what you meand by "child branch". If I understand
> >> corretly, you have something like:
> > 
> > [...]
> > 
> >> Maybe, to get a better understanding, you could use visualization tool
> >> like "tig" or "gitk" to observe what happens to your commits (hashes)
> >> and branches (labels) and just play around with some of these
> >> operations.
> > 
> > OK, I've followed this advice and looked at the dependency graphs in
> > gitk before and after rebasing, I've managed to obtain what I was
> > after.  The repository now has two branches: master and topic.  However,
> > Gitk reveals a problem with a string of commits that are not part of any
> > branch:
> > 
> > A---B---H---I                   (master)
> >      \
> >       C---D---E                 (loose string of commits)
> >        \
> >         D'---E'---F---G         (topic)
> > 
> > How do I remove these loose commits (C, D, E)?
> >
> 
> what you might be after is "git gc". But I never used it, it was not
> neccesary for me. I would let the automatic garbage collection drop my
> dangling commits. It's safer - who knows when you will still want to
> restore your recent "loose string of commits".
> 
> How exactly are the loose commits causing trouble?
> 

Right, you should normally not care about these commits. In any case,
the reflog is still keeping a reference to these commits, and objects
not older then 14 days are also kept.

But git is regularly running its gc to clean up older objects, and they
will not be shared when pushing.
