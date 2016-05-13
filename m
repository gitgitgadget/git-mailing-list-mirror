From: Jeff King <peff@peff.net>
Subject: Re: Bug report: Duplicate CRLF rewrite warnings on commit
Date: Fri, 13 May 2016 15:53:48 -0400
Message-ID: <20160513195347.GD9890@sigill.intra.peff.net>
References: <20160513134953.GE2345@dinwoodie.org>
 <20160513181255.GA30700@sigill.intra.peff.net>
 <xmqq1t55agge.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 13 21:53:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1J9n-0005tI-EI
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 21:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbcEMTxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 15:53:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:39318 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932211AbcEMTxv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 15:53:51 -0400
Received: (qmail 14239 invoked by uid 102); 13 May 2016 19:53:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 May 2016 15:53:50 -0400
Received: (qmail 21178 invoked by uid 107); 13 May 2016 19:53:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 May 2016 15:53:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 May 2016 15:53:48 -0400
Content-Disposition: inline
In-Reply-To: <xmqq1t55agge.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294567>

On Fri, May 13, 2016 at 12:46:57PM -0700, Junio C Hamano wrote:

> > We don't want commits that fail the test suite, since it makes bisection
> > more difficult. But you can mark known bugs like:
> >
> >    test_expect_failure 'git-foo should output bar' '
> > 	...
> >    '
> >
> > I think it's OK to submit a patch like that. Hopefully somebody picks
> > that up and combines it with their fix patch, but if not, then it at
> > least documents the failure for later generations.
> 
> ... but we do not want to overdo this.
> 
> An expect_failure helps when somebody is actually starting to work
> on a breakage by setting a goal, but otherwise nobody would look at
> them.  I do not think we know if 120+ instances of expect_failure in
> t/ we already have are still all valid; some of them even might be
> requesting a behaviour that we decided is a wrong expectation later.

True. I almost wrote more on this, but held back. But since you seem
interested... :)

I think that it's a really nice thing to write up your test as
test_expect_failure and post it to the list as a patch that is ready to
be applied, _even if we don't apply it_. Because that format makes it
super-easy for somebody who does want to work on it to just "git am"
your patch and focus on fixing it.

And your patch can either go at the front of their series, or they
can squash it in and acknowledge you in the commit message. But either
way it reduces the amount of work they have to do (whether they work on
the bug soon, or much later).

-Peff
