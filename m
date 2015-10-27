From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] Facilitate debugging Git executables in tests with
 gdb
Date: Tue, 27 Oct 2015 19:28:49 -0400
Message-ID: <20151027232848.GA4172@sigill.intra.peff.net>
References: <cover.1445865176.git.johannes.schindelin@gmx.de>
 <082d6474a31c405b16087f76de7bc5d01faba529.1445865176.git.johannes.schindelin@gmx.de>
 <20151026191724.GE7881@google.com>
 <alpine.DEB.1.00.1510271036100.31610@s15462909.onlinehome-server.info>
 <xmqqr3kge0d3.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 00:28:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrDfl-0001Sd-1W
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 00:28:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753794AbbJ0X2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 19:28:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:48866 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753532AbbJ0X2v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 19:28:51 -0400
Received: (qmail 8539 invoked by uid 102); 27 Oct 2015 23:28:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Oct 2015 18:28:51 -0500
Received: (qmail 29966 invoked by uid 107); 27 Oct 2015 23:29:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Oct 2015 19:29:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Oct 2015 19:28:49 -0400
Content-Disposition: inline
In-Reply-To: <xmqqr3kge0d3.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280315>

On Tue, Oct 27, 2015 at 09:34:48AM -0700, Junio C Hamano wrote:

> Yeah, that was my first reaction when I saw this patch.  Instead of
> having to munge that line to "gdb -whatever-args git", you can do a
> single-shot debugging in a convenient way.  And quite honestly,
> because nobody sane will run:
> 
>      $ cd t && TEST_GDB_GIT=1 sh ./t1234-frotz.sh
> 
> and can drive all the "git" running under gdb at the same time, I
> think what you showed would be the _only_ practical use case.

I agree doing so would be crazy. But would:

  ./t1234-frotz.sh --gdb=17

be sane to run gdb only inside test 17?

I suspect it would work about half the time. Many tests will call git
only once per snippet, but many make multiple git calls, and we are only
interested in debugging one.

I dunno. Maybe that is making things more complicated than they need to
be. I usually use the "tweak the test script" approach, but I have
always found it annoying to have to untweak it later.

-Peff
