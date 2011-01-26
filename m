From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 0/3] trace: omit noisy repository discovery report
Date: Wed, 26 Jan 2011 00:07:15 -0500
Message-ID: <20110126050715.GA2665@sigill.intra.peff.net>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
 <1290785563-15339-2-git-send-email-pclouds@gmail.com>
 <20110126004915.GA11230@burratino>
 <AANLkTimB0rJPLkwyrQEibngeRjgHLxhrntG5sMdQ9CW0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 06:07:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhxbK-00011e-H1
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 06:07:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877Ab1AZFHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 00:07:21 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:58979 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750773Ab1AZFHV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 00:07:21 -0500
Received: (qmail 1673 invoked by uid 111); 26 Jan 2011 05:07:19 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 26 Jan 2011 05:07:19 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Jan 2011 00:07:15 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimB0rJPLkwyrQEibngeRjgHLxhrntG5sMdQ9CW0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165501>

On Wed, Jan 26, 2011 at 08:45:12AM +0700, Nguyen Thai Ngoc Duy wrote:

> > A few days ago I was tracing something or other and decided that these
> > extra lines are annoying.
> >
> > Patch 1 moves this code from trace.c to git.c, to contain its impact
> > to a single translation unit (that is, it let me experiment without
> > touching cache.h after that).
> >
> > Patch 2 removes the repo-setup tracing code, introducing a
> > test-repo-setup helper to take its place in the repo setup tests.
> >
> > Patch 3 does some cleaning up made possible by patch 2.
> >
> > Thoughts?
> 
> I'm fine with this. Although long term maybe we should support pattern
> matching or category selection in GIT_TRACE.

Yeah. I recently was peeking at the git protocol, and I wrote some
nice-ish packet-tracing support. I triggered it via:

  GIT_TRACE=$whatever GIT_TRACE_PACKET=1 git push ...

So you have to turn on tracing (to whatever destination you want) and
then turn on packet tracing with a bool. In retrospect, probably
GIT_TRACE_* should take the same type of location parameter as
GIT_TRACE, so you can get whatever subset of trace going to wherever you
like. And then the repo setup code can just go into GIT_TRACE_SETUP or
something.

-Peff
