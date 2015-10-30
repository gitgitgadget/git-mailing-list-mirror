From: Jeff King <peff@peff.net>
Subject: Re: git-credential-cache--daemon quits on SIGHUP, can we change it
 to ignore instead?
Date: Thu, 29 Oct 2015 20:50:57 -0400
Message-ID: <20151030005057.GA23251@sigill.intra.peff.net>
References: <xmqqfv18awj4.fsf@gitster.mtv.corp.google.com>
 <CAM-tV-8VXtB5uRgqP9dFpww6AaLzasPV46tCiquz=nz=ksBNng@mail.gmail.com>
 <CAM-tV-9sNgHncsWRPh36tEY3YFORUJBA-Q6W5R=mvX_KhSmWEQ@mail.gmail.com>
 <xmqqfv0ylwa7.fsf@gitster.mtv.corp.google.com>
 <20151026215016.GA17419@sigill.intra.peff.net>
 <xmqqoafkci6j.fsf@gitster.mtv.corp.google.com>
 <20151027184702.GB12717@sigill.intra.peff.net>
 <CAM-tV--B3HaC1DcORfnx9bWW9-quyk0=pQDxmvonc=6dgrMOxA@mail.gmail.com>
 <20151030001000.GA2123@sigill.intra.peff.net>
 <CAM-tV-_dc_YEE0Dh2T=8+_DcBiq_rvynOw2cFi+8QizkeGTusw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Noam Postavsky <npostavs@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Oct 30 01:51:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrxuO-0008MS-Ng
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 01:51:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758085AbbJ3AvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2015 20:51:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:50136 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757245AbbJ3Au7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2015 20:50:59 -0400
Received: (qmail 32187 invoked by uid 102); 30 Oct 2015 00:50:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Oct 2015 19:50:59 -0500
Received: (qmail 17969 invoked by uid 107); 30 Oct 2015 00:51:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Oct 2015 20:51:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Oct 2015 20:50:57 -0400
Content-Disposition: inline
In-Reply-To: <CAM-tV-_dc_YEE0Dh2T=8+_DcBiq_rvynOw2cFi+8QizkeGTusw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280467>

On Thu, Oct 29, 2015 at 08:43:58PM -0400, Noam Postavsky wrote:

> > I'm not clear on when the pre-helper would be run. Git runs the helper
> > when it needs a credential. What git command would start it?
> 
> I was just thinking in terms of our current workaround, it would have
> been helpful to be able to run a command just before the helpers are
> run. Or in other words, as the first helper. (doing "git -c
> credential.helper=foo" puts foo as the last helper).

If you know the helper you want to run, you are free to just run "git
credential-foo". So I don't think that helps the inelegance of your
workaround (the real inelegance is that you are assuming that "foo"
needs run in the first place).

I'm still not sure how the pre-helper would work. What git command kicks
off the pre-helper command? Wouldn't it also be subject to the SIGHUP
problem?

-Peff
