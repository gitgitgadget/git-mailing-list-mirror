From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] compat: move unaligned helpers to bswap.h
Date: Thu, 23 Jan 2014 15:09:11 -0500
Message-ID: <20140123200911.GB32229@sigill.intra.peff.net>
References: <20140123183320.GA22995@sigill.intra.peff.net>
 <20140123183522.GA26447@sigill.intra.peff.net>
 <20140123194118.GT18964@google.com>
 <20140123194401.GA31412@sigill.intra.peff.net>
 <20140123195643.GV18964@google.com>
 <20140123200450.GB31920@sigill.intra.peff.net>
 <20140123200804.GW18964@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 23 21:09:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6QaW-00034y-PC
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 21:09:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbaAWUJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 15:09:14 -0500
Received: from cloud.peff.net ([50.56.180.127]:37715 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932309AbaAWUJN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 15:09:13 -0500
Received: (qmail 28268 invoked by uid 102); 23 Jan 2014 20:09:12 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Jan 2014 14:09:12 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jan 2014 15:09:11 -0500
Content-Disposition: inline
In-Reply-To: <20140123200804.GW18964@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240940>

On Thu, Jan 23, 2014 at 12:08:04PM -0800, Jonathan Nieder wrote:

> Jeff King wrote:
> > On Thu, Jan 23, 2014 at 11:56:43AM -0800, Jonathan Nieder wrote:
> 
> >> In that case I think git-compat-util.h should include something like
> >> what block-sha1/sha1.c has:
> >> 
> >> 	#if !defined(__i386__) && !defined(__x86_64__) && \
> >> 	    !defined(_M_IX86) && !defined(_M_X64) && \
> >> 	    !defined(__ppc__) && !defined(__ppc64__) && \
> >> 	    !defined(__powerpc__) && !defined(__powerpc64__) && \
> >> 	    !defined(__s390__) && !defined(__s390x__)
> >> 	#define NEEDS_ALIGNED_ACCESS
> >> 	#endif
> >>
> >> Otherwise we are relying on the person building to know their own
> >> architecture intimately, which shouldn't be necessary.
> >
> > Yeah, I agree it would be nice to autodetect.
> 
> The nice thing is that false positives are harmless, modulo slowing
> down git a little if the compiler doesn't figure out how to optimize
> the NEEDS_ALIGNED_ACCESS codepath when on an unlisted platform that
> doesn't, in fact, need aligned access.

OK, I'll refactor the knob.

-Peff
