From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Makefile: suppress false positive warnings of empty
 format string.
Date: Mon, 30 Sep 2013 19:23:50 -0400
Message-ID: <20130930232349.GB23218@sigill.intra.peff.net>
References: <7vfvvkpt2k.fsf@alter.siamese.dyndns.org>
 <1380456534-7582-1-git-send-email-stefanbeller@googlemail.com>
 <20130929190017.GA2482@elie.Belkin>
 <20130930201429.GA14433@sigill.intra.peff.net>
 <5249EF59.4080607@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Oct 01 01:23:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQmom-0008HP-Kj
	for gcvg-git-2@plane.gmane.org; Tue, 01 Oct 2013 01:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755175Ab3I3XXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Sep 2013 19:23:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:59471 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753024Ab3I3XXw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Sep 2013 19:23:52 -0400
Received: (qmail 13078 invoked by uid 102); 30 Sep 2013 23:23:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 30 Sep 2013 18:23:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Sep 2013 19:23:50 -0400
Content-Disposition: inline
In-Reply-To: <5249EF59.4080607@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235636>

On Mon, Sep 30, 2013 at 11:38:33PM +0200, Stefan Beller wrote:

> > To be honest, I'm surprised that "-Wall" doesn't create problems for
> > older "cc" implementations. We've had patches for compiling with
> > antique SUNWspro and MIPSpro compilers, and I sort of assumed that those
> > don't handle "-Wall". But maybe they do. Or maybe people doing that just
> > set CFLAGS themselves.
> 
> Well actually I do think people are encouraged to play around with their
> CFLAGS as much as they like. I do add link time optimisation usually.

Oh, absolutely. I didn't mean to give the impression that you should not
tweak CFLAGS. That's what it's there for. I just meant that I do not
recall seeing complaints from people on such compilers, so either it
actually works, or they are savvy enough to tweak CFLAGS without making
a complaint. Or they no longer exist. The patches I'm thinking of were
from 2008, and the compilers and systems were old then.

> However I do have the strong opinion that any serious project should
> compile without any warning/error with the standard compilers of
> the current time. That's why I started an attempt again to have
> -Wno-format-zero-length in there by default. Most of the people (I
> assume so) are using gcc. So it should build fine there without any
> warnings.

Yeah, I'd agree it is a good goal.

> Sure it should build without errors as well on other architectures, so
> I do understand the issue to check if we're really using gcc and can
> omit this flag if using another compiler.

Right, agreed.

> and here
> http://thread.gmane.org/gmane.comp.version-control.git/230806

Thanks, I didn't recall that one.

I still think if we are going to start doing gcc auto-detection in the
Makefile, it is slightly less ugly to just tweak the few callsites to
prevent the warning in the first place. I think gcc is being silly to
warn about, but it is the path of least resistance and maintenance.

-Peff
