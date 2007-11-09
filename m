From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: git rebase --skip
Date: Fri, 9 Nov 2007 11:19:46 -0500
Message-ID: <20071109161945.GA26826@fieldses.org>
References: <20071107222105.GA31666@glandium.org> <20071108032308.GA5638@sigill.intra.peff.net> <20071108102412.GA31187@atjola.homenet> <4732E5A8.3020101@op5.se> <20071108104403.GB31187@atjola.homenet> <20071108231632.GC29840@sigill.intra.peff.net> <7vir4cz45z.fsf@gitster.siamese.dyndns.org> <20071109032227.GA31760@sigill.intra.peff.net> <Pine.LNX.4.64.0711091056530.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	Andreas Ericsson <ae@op5.se>, Mike Hommey <mh@glandium.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 09 17:21:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqWbO-0003hJ-Aw
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 17:21:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbXKIQUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 11:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753640AbXKIQUF
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 11:20:05 -0500
Received: from mail.fieldses.org ([66.93.2.214]:51790 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754656AbXKIQUD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 11:20:03 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1IqWaA-0007YI-4I; Fri, 09 Nov 2007 11:19:46 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711091056530.4362@racer.site>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64211>

On Fri, Nov 09, 2007 at 10:59:57AM +0000, Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 8 Nov 2007, Jeff King wrote:
> 
> > So I am fine with the original patch (unconditional reset --hard), but 
> > it would be nice to see the people who care submit concrete proposals 
> > for such a safety valve.
> 
> Isn't having to say "--skip" instead of "--continue" enough?  Some people 
> might complain that it's too easy to get your fingers wired to type 
> --skip.
> 
> In that case, I might beg to differ for two reasons: --skip is definitely 
> not the default operation, so the fingers do not get any chance to do 
> that, and even if, they would get wired to --force --skip just as easily.
> 
> Besides, after my patch to rebase on a detached HEAD, it is very easy to 
> go back to the original state and try again.

We can't make --skip do an automatic reset --hard.  I expect --skip to
tell me if I haven't finished resolving conflicts.  If it doesn't do
that, I'll lose work.  I can't be the only user with that expectation.

(To be more specific: the work I lose is the work spent resolving how
however many conflicts I've dealt with so far.  It isn't always the case
that I get to a certain point in a rebase and say "ah, yes, I know this
is already applied, I can reset and skip it."  More often I want to go
through each conflict and decide individually.  So I do that for a few,
I run --continue or --skip when I think I'm done (but don't actually
check first, 'cause I count on rebase to do that), then fix up anything
remaining.)

--b.
