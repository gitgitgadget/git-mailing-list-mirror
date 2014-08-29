From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] index-pack: handle duplicate base objects gracefully
Date: Fri, 29 Aug 2014 18:08:19 -0400
Message-ID: <20140829220818.GA24834@peff.net>
References: <20140829205538.GD29456@peff.net>
 <20140829205809.GB7060@peff.net>
 <xmqqegvz3qpp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Shawn Pearce <spearce@spearce.org>,
	Martin von Gagern <Martin.vGagern@gmx.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 00:08:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNULJ-00084O-Fp
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 00:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515AbaH2WIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 18:08:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:33451 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750938AbaH2WIU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 18:08:20 -0400
Received: (qmail 8560 invoked by uid 102); 29 Aug 2014 22:08:20 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Aug 2014 17:08:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Aug 2014 18:08:19 -0400
Content-Disposition: inline
In-Reply-To: <xmqqegvz3qpp.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256198>

On Fri, Aug 29, 2014 at 02:56:18PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > If a pack contains duplicates of an object, and if that
> > object has any deltas pointing at it with REF_DELTA, we will
> > try to resolve the deltas twice. While unusual, this is not
> > strictly an error, but we currently die() with an unhelpful
> > message.
> 
> Hmm, I vaguely recall Shawn declaring this as an error in the pack
> stream, though.

I agree it is probably a bug on the sending side, but I think last time
this came up we decided to try to be liberal in what we accept.  c.f.
http://thread.gmane.org/gmane.comp.version-control.git/232305/focus=232310

-Peff
