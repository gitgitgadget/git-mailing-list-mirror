From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 05/15] sequencer: use logmsg_reencode in get_message
Date: Tue, 10 Jun 2014 17:50:22 -0400
Message-ID: <20140610215022.GC19107@sigill.intra.peff.net>
References: <20140609180236.GA24644@sigill.intra.peff.net>
 <20140609181039.GE20315@sigill.intra.peff.net>
 <xmqq7g4o8mup.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 23:50:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuTw3-0004oG-TE
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 23:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753434AbaFJVuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 17:50:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:41471 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752607AbaFJVuX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 17:50:23 -0400
Received: (qmail 20552 invoked by uid 102); 10 Jun 2014 21:50:23 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jun 2014 16:50:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jun 2014 17:50:22 -0400
Content-Disposition: inline
In-Reply-To: <xmqq7g4o8mup.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251266>

On Tue, Jun 10, 2014 at 02:40:30PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Note that we may be fixing a bug here. The existing code
> > does:
> >
> >   if (same_encoding(to, from))
> > 	  reencode_string(buf, to, from);
> >
> > That probably should have been "!same_encoding".
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > I didn't actually test for the bug, so it's possible that I'm missing
> > something clever...
> 
> Thanks for spotting.  There is nothing clever going on.
> 
> 0e18bcd5 (reencode_string(): introduce and use same_encoding(),
> 2012-10-18) has this misconversion.

Ah, thanks, I tried digging but didn't see anything obvious (and somehow
my eyes glossed over the s/same_encoding/strcmp/ while reading the
history). I feel much better about the change now.

-Peff
