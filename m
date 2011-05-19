From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2] add Android support
Date: Thu, 19 May 2011 08:20:26 -0400
Message-ID: <20110519122026.GA30240@sigill.intra.peff.net>
References: <B22B44EF-0AFB-44E3-93E3-61FA730431B9@gieschke.de>
 <7vaaej9pt3.fsf@alter.siamese.dyndns.org>
 <2218C353-80FC-4540-A60E-608385384FB5@gieschke.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Rafael Gieschke <rafael@gieschke.de>
X-From: git-owner@vger.kernel.org Thu May 19 14:20:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN2DS-0003IF-9q
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 14:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433Ab1ESMU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 08:20:28 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60979
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932345Ab1ESMU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 08:20:27 -0400
Received: (qmail 16283 invoked by uid 107); 19 May 2011 12:22:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 May 2011 08:22:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 May 2011 08:20:26 -0400
Content-Disposition: inline
In-Reply-To: <2218C353-80FC-4540-A60E-608385384FB5@gieschke.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173955>

On Thu, May 19, 2011 at 01:37:53PM +0200, Rafael Gieschke wrote:

> > (3) Add uname_S = Android (Makefile).
> > 
> > The first two would become much easier to justify if presented that
> > way. At least you won't hear from anybody "we don't want that much code to
> > not to run git on a phone!", as it is not entirely implausible to imagine
> > environments without support for one or both of these two facilities.
> 
> So, you would prefer to leave out ANDROID and use something like "ifeq
> ($(uname_S),Android)", so you will have to compile using make
> uname_S=Android? I would be fine with that, too. But I would also be
> fine with having to specify the build options on the command line or
> using a config.mak if you want to keep Android out of the Makefile.

The point of uname_S is that it would be found automatically. Sadly,
There is nothing helpful in uname to tell us that we are on android:

  $ uname -a
  Linux localhost 2.6.37.4-cyanogenmod-01332-g7f230e8 #1 PREEMPT Tue Apr
  12 12:54:14 EDT 2011 armv7l GNU/Linux

You could obviously guess from Linux on that architecture, but that
seems flaky to me. You can also figure it out by looking around the
filesystem, but that is not something I'm excited about having the
Makefile do.

So I think we are probably stuck either with the user setting an ANDROID
meta-flag that sets the other flags appropriately, or leaving it up to
the user to provide a sane config.mak.

-Peff
