From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 1/4] implement submodule config API for lookup of
 .gitmodules values
Date: Thu, 9 Jul 2015 11:49:03 -0400
Message-ID: <20150709154903.GA14320@peff.net>
References: <cover.1434400625.git.hvoigt@hvoigt.net>
 <ef740bdea9af35564c75efd2a6daae65f3108df5.1434400625.git.hvoigt@hvoigt.net>
 <CABURp0pyYcKvmbEeDSYqm15DtXvH7g_UXASR3utGco+=D95bOA@mail.gmail.com>
 <20150709120900.GA24040@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git <git@vger.kernel.org>, Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"W. Trevor King" <wking@tremily.us>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karsten Blees <karsten.blees@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu Jul 09 17:49:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDE4Y-000464-T8
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 17:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753939AbbGIPtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 11:49:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:58104 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753339AbbGIPtH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 11:49:07 -0400
Received: (qmail 16985 invoked by uid 102); 9 Jul 2015 15:49:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Jul 2015 10:49:06 -0500
Received: (qmail 31617 invoked by uid 107); 9 Jul 2015 15:49:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Jul 2015 11:49:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jul 2015 11:49:03 -0400
Content-Disposition: inline
In-Reply-To: <20150709120900.GA24040@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273757>

On Thu, Jul 09, 2015 at 02:09:01PM +0200, Heiko Voigt wrote:

> > Instead of test-submodule-config.c to test this new module, it could
> > be useful to implement these as extensions to rev-parse:
> > 
> >     git rev-parse --submodule-name [<ref>:]<path>
> >     git rev-parse --submodule-path [<ref>:]<name>
> >     git rev-parse --submodule-url [<ref>:]<name>
> >     git rev-parse --submodule-ignore [<ref>:]<name>
> >     git rev-parse --submodule-recurse [<ref>:]<name>
> > 
> > Has this already been considered and rejected for some reason?
> 
> No that has not been considered. But I am open to it if others agree
> that this is a sensible thing to do. We should be able to adapt the
> existing tests right?

How does git-submodule access this information? It looks like it just
hits "git config -f .gitmodules" directly. Perhaps whatever interface is
designed should be suitable for its use here (and if there really is no
more interesting interface needed, then why is "git config" not good
enough for other callers?).

Just my two cents as an observer who does not really work on submodules.

Also, I'm not excited to see more options go into the kitchen-sink of
rev-parse, but I cannot think of a better place (I would have said "git
submodule config" or something, but that is a chicken-and-egg with the
suggestion I made above :) ).

-Peff
