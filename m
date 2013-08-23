From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/6] sha1-lookup: handle duplicate keys with
 GIT_USE_LOOKUP
Date: Fri, 23 Aug 2013 14:56:18 -0400
Message-ID: <20130823185618.GD30130@sigill.intra.peff.net>
References: <20130822231215.GA16978@sigill.intra.peff.net>
 <20130822231404.GB17060@sigill.intra.peff.net>
 <xmqqob8opdey.fsf@gitster.dls.corp.google.com>
 <20130823182409.GA30130@sigill.intra.peff.net>
 <alpine.LFD.2.03.1308231451030.14472@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Aug 23 20:56:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCwX3-0003sW-Kx
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 20:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755621Ab3HWS4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 14:56:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:39470 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754659Ab3HWS4V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 14:56:21 -0400
Received: (qmail 14836 invoked by uid 102); 23 Aug 2013 18:56:21 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 Aug 2013 13:56:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Aug 2013 14:56:18 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.03.1308231451030.14472@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232824>

On Fri, Aug 23, 2013 at 02:54:19PM -0400, Nicolas Pitre wrote:

> On Fri, 23 Aug 2013, Jeff King wrote:
> 
> > Making the deltas was considerably less elegant, since we cannot provoke
> > pack-objects to pick arbitrary deltas (and it will not even try to delta
> > tiny objects, anyway, which would bloat our samples). I ended up with
> > the horrible patch below. We _could_ clean it up (error-checking? Who
> > needs it?) and make it a debug-and-testing-only option for pack-objects,
> > but I just didn't think the grossness was worth it. Still, it's probably
> > worth documenting here on the list in case somebody else ever needs to
> > add new samples to lib-pack.sh.
> 
> Maybe using test-delta (from test-delta.c) would have helped here?
> 
> In any case, if something needs to be permanently added into the code to 
> help in the creation of test objects, I think test-delta.c is a far 
> better place than pack-objects.c.

*forehead palm*

I didn't even know we had test-delta. Yes, that is obviously a way
better place (I initially looked at pack-objects because it has the
helpers to do compression and the type/size header properly).

-Peff
