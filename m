From: Jeff King <peff@peff.net>
Subject: Re: Problems with git 1.8.5.3 on HP-UX 11.11
Date: Fri, 28 Mar 2014 16:02:19 -0400
Message-ID: <20140328200218.GA3145@sigill.intra.peff.net>
References: <9D24AD27564FAE4CB8D0C15D080DEFCB0106A89226@m4ukex08.intranet.macro4.com>
 <8FDD21D28EC16844948E2A773083574A03363EBC@m4ukex08.intranet.macro4.com>
 <20140328190156.GA30739@sigill.intra.peff.net>
 <CAPig+cQKZ-oKTQ4Y2=qDaeQRXVZYOKRcSadOx2RwfjCziuu6fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Gerhard Grimm <gerhard.grimm@detec.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 21:02:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTcyy-0007iZ-Id
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 21:02:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbaC1UCV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 16:02:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:49588 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751435AbaC1UCV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 16:02:21 -0400
Received: (qmail 4112 invoked by uid 102); 28 Mar 2014 20:02:20 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 28 Mar 2014 15:02:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Mar 2014 16:02:19 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cQKZ-oKTQ4Y2=qDaeQRXVZYOKRcSadOx2RwfjCziuu6fw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245424>

On Fri, Mar 28, 2014 at 03:43:29PM -0400, Eric Sunshine wrote:

> On Fri, Mar 28, 2014 at 3:01 PM, Jeff King <peff@peff.net> wrote:
> > On Fri, Mar 28, 2014 at 11:09:14AM -0000, Gerhard Grimm wrote:
> >> git submodule init
> >>
> >> fails with the output
> >>
> >>     Assertion failed: err == REG_ESPACE, file compat/regex/regexec.c, line 1096
> >>     No submodule mapping found in .gitmodules for path 'module'
> >
> > The regexes we use here are not particularly complicated. So either
> > there is a bug (but nobody else has reported anything on any other
> > platform) or your system regex library has some problem with what we are
> > feeding it. The simplest solution may be to compile with:
> >
> >   NO_REGEX=YesPlease
> >
> > which will build and use the glibc implementation in compat/regex
> > instead.
> 
> Based upon the assertion-failure message, it looks like he's already
> using compat/regex.

Heh, I didn't even notice that. I just looked at all of the libc calls
at the top of the backtrace, but of course that is just from assert() on
up.

So now it seems doubly odd to me, since it is running the same regex
library that is used elsewhere.

-Peff
