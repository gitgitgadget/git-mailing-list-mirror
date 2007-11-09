From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: git rebase --skip
Date: Fri, 9 Nov 2007 11:26:34 -0500
Message-ID: <20071109162634.GB26826@fieldses.org>
References: <20071107222105.GA31666@glandium.org> <20071108032308.GA5638@sigill.intra.peff.net> <20071108102412.GA31187@atjola.homenet> <4732E5A8.3020101@op5.se> <20071108104403.GB31187@atjola.homenet> <20071108231632.GC29840@sigill.intra.peff.net> <7vir4cz45z.fsf@gitster.siamese.dyndns.org> <20071109032227.GA31760@sigill.intra.peff.net> <Pine.LNX.4.64.0711091056530.4362@racer.site> <20071109161945.GA26826@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	Andreas Ericsson <ae@op5.se>, Mike Hommey <mh@glandium.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 09 17:27:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqWhC-0006F6-7B
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 17:27:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbXKIQ0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 11:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbXKIQ0r
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 11:26:47 -0500
Received: from mail.fieldses.org ([66.93.2.214]:43620 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133AbXKIQ0q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 11:26:46 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1IqWgk-0007kx-BV; Fri, 09 Nov 2007 11:26:34 -0500
Content-Disposition: inline
In-Reply-To: <20071109161945.GA26826@fieldses.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64212>

On Fri, Nov 09, 2007 at 11:19:46AM -0500, J. Bruce Fields wrote:
> On Fri, Nov 09, 2007 at 10:59:57AM +0000, Johannes Schindelin wrote:
> > Hi,
> > 
> > On Thu, 8 Nov 2007, Jeff King wrote:
> > 
> > > So I am fine with the original patch (unconditional reset --hard), but 
> > > it would be nice to see the people who care submit concrete proposals 
> > > for such a safety valve.
> > 
> > Isn't having to say "--skip" instead of "--continue" enough?  Some people 
> > might complain that it's too easy to get your fingers wired to type 
> > --skip.
> > 
> > In that case, I might beg to differ for two reasons: --skip is definitely 
> > not the default operation, so the fingers do not get any chance to do 
> > that, and even if, they would get wired to --force --skip just as easily.
> > 
> > Besides, after my patch to rebase on a detached HEAD, it is very easy to 
> > go back to the original state and try again.
> 
> We can't make --skip do an automatic reset --hard.  I expect --skip to
> tell me if I haven't finished resolving conflicts.  If it doesn't do
> that, I'll lose work.  I can't be the only user with that expectation.
> 
> (To be more specific: the work I lose is the work spent resolving how
> however many conflicts I've dealt with so far.  It isn't always the case
> that I get to a certain point in a rebase and say "ah, yes, I know this
> is already applied, I can reset and skip it."  More often I want to go
> through each conflict and decide individually.  So I do that for a few,
> I run --continue or --skip when I think I'm done (but don't actually
> check first, 'cause I count on rebase to do that), then fix up anything
> remaining.)

(Eh, now that I think of it: what I actually usually do is run
--continue, git says there's one more conflict, I fix that up and run
--continue again, it tells me there's nothing to commit, I say huh?
Then eventually I remember I need to run --skip instead, cursing it for
not just figuring that out on its own....  So actually it may be that
the only time I run --skip is after --continue has told me I need to.  I
can't *swear* that that's the case, so I'm still nervous about the idea
of --skip automatically resetting.  Oh well.  Take that one user's
experience for what it's worth.)

--b.
