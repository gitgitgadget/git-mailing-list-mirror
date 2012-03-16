From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] push: Provide situational hints for non-fast-forward
 errors
Date: Fri, 16 Mar 2012 22:41:52 +0100
Message-ID: <20120316214151.GA25092@ecki>
References: <20120313232256.GA49626@democracyinaction.org>
 <vpqipi7zh3n.fsf@bauges.imag.fr>
 <7vty1rqek5.fsf@alter.siamese.dyndns.org>
 <7vlin1gl9l.fsf@alter.siamese.dyndns.org>
 <20120316091019.GB22273@ecki>
 <7v3998kb0x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christopher Tiwald <christiwald@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 16 22:42:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8ev4-0003mC-Qd
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 22:42:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758305Ab2CPVmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 17:42:37 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:14157 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757761Ab2CPVmg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 17:42:36 -0400
Received: from localhost (p5B22F52F.dip.t-dialin.net [91.34.245.47])
	by bsmtp.bon.at (Postfix) with ESMTP id 4CD85CDF83;
	Fri, 16 Mar 2012 22:42:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v3998kb0x.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193283>

On Fri, Mar 16, 2012 at 05:03:58AM -0700, Junio C Hamano wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
> 
> > On Thu, Mar 15, 2012 at 10:36:22PM -0700, Junio C Hamano wrote:
> >>
> >> +static const char message_advice_pull_before_push[] =
> >> +	N_("Update was rejected because the tip of your current branch is behind\n"
> >> +	   "the remote. Merge the remote changes (e.g. 'git pull') before\n"
> >> +	   "pushing again. See the 'Note about fast-forwards' section of\n"
> >> +	   "'git push --help' for details.");
> >> +
> >> +
> >> +static const char message_advice_use_upstream[] =
> >> +	N_("Some of your local branches were stale with respect to their\n"
> >> +	   "remote counterparts. If you did not intend to push these branches,\n"
> >> +	   "you may want to set the 'push.default' configuration variable to\n"
> >> +	   "'current' or 'upstream' to push only the current branch.");
> >> +
> >> +static const char message_advice_checkout_pull_push[] =
> >> +	N_("Updates were rejected because the tip of some of your branches are\n"
> >> +	   "behind the remote. Check out the branch and merge the remote\n"
> >> +	   "changes (e.g. 'git pull') before pushing again. See the\n"
> >> +	   "'Note about fast-forwards' section of 'git push --help'\n"
> >> +	   "for details.");
> >
> > The first sentence of the above two warnings state the same thing, but
> > in different ways. Yet the difference does not reflect the different
> > situations. They should be the same, or maybe the first one should be
> > changed to the following variant of the second:
> >
> >  "Updates were rejected because the tip of some of your branches are
> >  behind the remote branches with matching names."
> 
> That defeats the whole point of Christpher's patch and suggestion by Peff
> in the original discussion.
> 
> They apply to two different situations. If your current branch is behind,
> you get the first one, if your current branch is *NOT* behind, but some
> others are, you get the second one. The suggested solutions are different.

Sorry if I did not express myself well. I should have deleted the first
message. I was not talking about the case where the current branch is
rejected. I mean the two cases where other branches are rejected.

And the suggested solutions may be different for those too. I did not
mean to object to that either. I only object to those two sentences,
which basically say the same thing in different ways:

 "Some of your local branches were stale with respect to their\n"
 "remote counterparts.

 "Updates were rejected because the tip of some of your branches are\n"
 "behind the remote. Check out the branch and merge the remote\n"


> > We should not give advise_use_upstream if the user specified git push
> > --all. The advice_checkout_pull_push would make more sense in that case.
> 
> Yeah, "default_matching_used" variable should be looked at somewhere
> around that, but I *think* the approach Christpher and Peff took (and I
> agree with them) is to help solving the immediate problem the user has and
> can address.  Deal with the current branch first (which would solve "the
> current branch is behind" problem).  The next push may then show that
> other branches are behind, and at that time the other advice will tell him
> how to deal with it ("check out and fix them, and then push").

Again, I am not talking about the current branch situation at all. I
don't understand what you mean here.
