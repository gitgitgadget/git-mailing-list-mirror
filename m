From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fixed compilation with Visual Studio by including poll.h
Date: Fri, 20 Apr 2012 16:23:19 -0700
Message-ID: <20120420232319.GA14109@sigill.intra.peff.net>
References: <4F91C8FF.7070402@tu-clausthal.de>
 <20120420204722.GD13103@sigill.intra.peff.net>
 <xmqqty0ekr5t.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sven Strickroth <sven.strickroth@tu-clausthal.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 01:23:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLNAp-00016O-D2
	for gcvg-git-2@plane.gmane.org; Sat, 21 Apr 2012 01:23:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280Ab2DTXXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 19:23:25 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39452
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932192Ab2DTXXY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 19:23:24 -0400
Received: (qmail 16101 invoked by uid 107); 20 Apr 2012 23:23:33 -0000
Received: from c-67-169-43-61.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (67.169.43.61)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 20 Apr 2012 19:23:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Apr 2012 16:23:19 -0700
Content-Disposition: inline
In-Reply-To: <xmqqty0ekr5t.fsf@junio.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196030>

On Fri, Apr 20, 2012 at 02:51:58PM -0700, Junio C Hamano wrote:

> > It looks like we will prefer sys/poll.h if it exists. The official XSI
> > location is "poll.h", but I guess in practice they are equivalent on
> > most systems if you have both (certainly on Linux, poll.h just includes
> > sys/poll.h).
> 
> There actually is no preference between the two from _our_ side. It is
> up to the builder to know and define necessary make variables.

I say "prefer" only because if you set nothing, you get "sys/poll.h". So
it is up to the builder to say "no, I do not have that non-standard
location. Use the standard one instead". Which seems a little backwards.

Of course "standard" here is just what POSIX says; sys/poll.h may be
much more standard in the real world (I don't know).

> > Does your environments have a sys/poll.h that exists isn't sufficient to
> > use poll? Maybe we need to tweak git-compat-util to include both if they
> > both exist.
> 
> Both?  I guess, but I suspect that on most sane systems one would
> include the other if there are both provided (iow, just so that you can
> complile sources written both for XSI and for systems in the field).

I would think one or the other would be fine. But the fact that Sven's
patch works makes me think that he has sys/poll.h, but it is not
sufficient. Hopefully including "poll.h" would be enough, but it's not
clear to me.

-Peff
