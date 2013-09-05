From: Jeff King <peff@peff.net>
Subject: Re: Zero padded file modes...
Date: Thu, 5 Sep 2013 15:10:38 -0400
Message-ID: <20130905191038.GA15910@sigill.intra.peff.net>
References: <CAEBDL5W3DL0v=TusuB7Vg-4bWdAJh5d2Psc1N0Qe+KK3bZH3=Q@mail.gmail.com>
 <20130905153646.GA12372@sigill.intra.peff.net>
 <alpine.LFD.2.03.1309051302570.14472@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Szakmeister <john@szakmeister.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Sep 05 21:10:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHex4-0002In-5I
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 21:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755807Ab3IETKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 15:10:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:48175 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755575Ab3IETKl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 15:10:41 -0400
Received: (qmail 30272 invoked by uid 102); 5 Sep 2013 19:10:42 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 Sep 2013 14:10:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Sep 2013 15:10:38 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.03.1309051302570.14472@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233982>

On Thu, Sep 05, 2013 at 01:09:34PM -0400, Nicolas Pitre wrote:

> On Thu, 5 Sep 2013, Jeff King wrote:
> 
> > There are basically two solutions:
> > 
> >   1. Add a single-bit flag for "I am 0-padded in the real data". We
> >      could probably even squeeze it into the same integer.
> > 
> >   2. Have a "classic" section of the pack that stores the raw object
> >      bytes. For objects which do not match our expectations, store them
> >      raw instead of in v4 format. They will not get the benefit of v4
> >      optimizations, but if they are the minority of objects, that will
> >      only end up with a slight slow-down.
> 
> That is basically what I just suggested.  But instead of a special 
> section, simply using a special object type number would do it.

Yeah, I think we are in agreement. I only suggested a separate section
because I hadn't carefully read the v4 patches yet, and didn't know if
there was room in the normal sequence. A special object number seems
much more elegant.

-Peff
