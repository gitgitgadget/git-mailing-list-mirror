From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] Facilitate debugging Git executables in tests with
 gdb
Date: Fri, 30 Oct 2015 15:26:52 -0400
Message-ID: <20151030192652.GA5336@sigill.intra.peff.net>
References: <cover.1445865176.git.johannes.schindelin@gmx.de>
 <082d6474a31c405b16087f76de7bc5d01faba529.1445865176.git.johannes.schindelin@gmx.de>
 <20151026191724.GE7881@google.com>
 <alpine.DEB.1.00.1510271036100.31610@s15462909.onlinehome-server.info>
 <xmqqr3kge0d3.fsf@gitster.mtv.corp.google.com>
 <20151027232848.GA4172@sigill.intra.peff.net>
 <alpine.DEB.1.00.1510301923010.31610@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 30 20:27:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsFKF-0004tk-RG
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 20:27:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110AbbJ3T0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 15:26:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:50579 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751024AbbJ3T0z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 15:26:55 -0400
Received: (qmail 7192 invoked by uid 102); 30 Oct 2015 19:26:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Oct 2015 14:26:55 -0500
Received: (qmail 25692 invoked by uid 107); 30 Oct 2015 19:27:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Oct 2015 15:27:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Oct 2015 15:26:52 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1510301923010.31610@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280528>

On Fri, Oct 30, 2015 at 07:25:24PM +0100, Johannes Schindelin wrote:

> > I agree doing so would be crazy. But would:
> > 
> >   ./t1234-frotz.sh --gdb=17
> > 
> > be sane to run gdb only inside test 17?
> 
> It would probably be sane, but I never encountered the need for something
> like that. It was always much easier to run the test using `sh -x t... -i
> -v` to find out what command was behaving funnily (mind you, that can be a
> pretty hard thing todo, we have some quite convoluted test scripts in our
> code base) and then edit the test.
> 
> I would expect that `--gdb=<n>` thing to drive me crazy: first, I would
> choose the wrong number. Next, I would probably forget that test_commit
> and other commands *also* calls Git.

Yeah, good points. You somehow have to say "debug _this_ git
invocation", and there is probably not a more precise way to do that
than sticking something in the code on the right line.

I do think I like Junio's "debug git foo" rather than setting the
environment variable, as its syntactically a little simpler to type (and
of course it would probably be implemented with an environment variable,
so one could whichever style they prefer).

-Peff
