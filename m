From: Jeff King <peff@peff.net>
Subject: Re: Cross-compiling git (was: [PATCHv2] add Android support)
Date: Mon, 23 May 2011 10:30:40 -0400
Message-ID: <20110523143040.GB17743@sigill.intra.peff.net>
References: <B22B44EF-0AFB-44E3-93E3-61FA730431B9@gieschke.de>
 <7vaaej9pt3.fsf@alter.siamese.dyndns.org>
 <2218C353-80FC-4540-A60E-608385384FB5@gieschke.de>
 <20110519122026.GA30240@sigill.intra.peff.net>
 <m3k4dhzynr.fsf_-_@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Rafael Gieschke <rafael@gieschke.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 16:30:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOW9g-0007MW-Jq
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 16:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755507Ab1EWOan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 10:30:43 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45578
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754389Ab1EWOan (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 10:30:43 -0400
Received: (qmail 18911 invoked by uid 107); 23 May 2011 14:32:46 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 23 May 2011 10:32:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 May 2011 10:30:40 -0400
Content-Disposition: inline
In-Reply-To: <m3k4dhzynr.fsf_-_@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174245>

On Mon, May 23, 2011 at 12:04:44AM -0700, Jakub Narebski wrote:

> > So I think we are probably stuck either with the user setting an ANDROID
> > meta-flag that sets the other flags appropriately, or leaving it up to
> > the user to provide a sane config.mak.
> 
> By the way, how well Git supports cross-compiling (which from the
> thread is necessity to generate binaries for Android)?  `uname -a`
> trick works only when compiling on same machine.

It should work fine if you set the make variables appropriately for the
target platform. But I've never tried it. Didn't msysgit people
cross-compile for a while (or maybe still do)?

> ./configure supports --host and --build options, but I don't know if
> it pass them down to make somehow.  ANDROID=YesPlease seems wasteful:
> what about setting HOST or MACHINE, or even uname_* variables, or just
> using Autoconf's `host` (in the form of CPU-VENDOR-OS)?

I know very little about autoconf internals, but what would
CPU-VENDOR-OS look like? Your CPU is probably some arm variant, though
it will vary from device to device. Your kernel is Linux. The special
steps in this case are about some weird userspace issues. So the
equivalent would be more like finding a Linux distro that ships a crappy
libc.  I guess that is what the "vendor" slot is for?

But even if you somehow tell autoconf or the Makefile "yes, this is
android", you are still going to need to manually specify the set of
knobs that should be tweaked in that case. Whether you call it
"ANDROID=YesPlease" or some other form.

-Peff
