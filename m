From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 2/6] Add git_env_ulong() to parse environment variable
Date: Wed, 27 Aug 2014 00:46:21 -0400
Message-ID: <20140827044621.GA32141@peff.net>
References: <1409066605-4851-1-git-send-email-prohaska@zib.de>
 <1409066605-4851-3-git-send-email-prohaska@zib.de>
 <20140826182125.GC17546@peff.net>
 <xmqq38cjhuje.fsf@gitster.dls.corp.google.com>
 <20140826203158.GA30651@peff.net>
 <xmqq38cihq7w.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	pclouds@gmail.com, john@keeping.me.uk, schacon@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 06:46:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMV7s-0000VF-4b
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 06:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbaH0EqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 00:46:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:59811 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751050AbaH0EqX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 00:46:23 -0400
Received: (qmail 4610 invoked by uid 102); 27 Aug 2014 04:46:23 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Aug 2014 23:46:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Aug 2014 00:46:21 -0400
Content-Disposition: inline
In-Reply-To: <xmqq38cihq7w.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255978>

On Tue, Aug 26, 2014 at 02:54:11PM -0700, Junio C Hamano wrote:

> A worse position is to have git_env_bool() that says "empty is
> false" and add a new git_env_ulong() that says "empty is unset".
> 
> We should pick one or the other and use it for both.

Yeah, I agree they should probably behave the same.

> > The middle ground would be to die(). That does not seem super-friendly, but
> > then we would also die with GIT_SMART_HTTP=foobar, so perhaps it is not
> > unreasonable to just consider it a syntax error.
> 
> Hmm, I am not sure if dying is better.  Unless we decide to make
> empty string no longer false everywhere and warn now and then later
> die as part of a 3.0 transition plan or something, that is.

I think it is better in the sense that while it may be unexpected, it
does not unexpectedly do something that the user cannot easily undo.

I really do not think this topic is worth the effort of a long-term
deprecation scheme (which I agree _is_ required for a change to the
config behavior). Let's just leave it as-is. We've seen zero real-world
complaints, only my own surprise after reading the code (and Steffen's
patch should be tweaked to match).

-Peff
