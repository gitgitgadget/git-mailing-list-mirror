From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 04/10] pkt-line: change error message for oversized
 packet
Date: Mon, 18 Feb 2013 05:26:28 -0500
Message-ID: <20130218102628.GO5096@sigill.intra.peff.net>
References: <20130218091203.GB17003@sigill.intra.peff.net>
 <20130218092221.GD5096@sigill.intra.peff.net>
 <20130218101523.GD7049@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 11:26:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Nvy-0001Qn-Hj
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 11:26:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757727Ab3BRK0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 05:26:31 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51781 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752854Ab3BRK0a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 05:26:30 -0500
Received: (qmail 18445 invoked by uid 107); 18 Feb 2013 10:28:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Feb 2013 05:28:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Feb 2013 05:26:28 -0500
Content-Disposition: inline
In-Reply-To: <20130218101523.GD7049@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216470>

On Mon, Feb 18, 2013 at 02:15:23AM -0800, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > --- a/pkt-line.c
> > +++ b/pkt-line.c
> > @@ -160,7 +160,8 @@ static int packet_read_internal(int fd, char *buffer, unsigned size, int gently)
> >  	}
> >  	len -= 4;
> >  	if (len >= size)
> > -		die("protocol error: bad line length %d", len);
> > +		die("protocol error: line too large: (expected %u, got %d)",
> > +		    size, len);
> 
> Makes sense.  I think this should say "expected < %u, got %d", since we
> don't actually expect most lines to be 1004 bytes in practice.

Yeah, I had toyed with writing "expected max %u" for the same reason.
I'll tweak it in the re-roll.

-Peff
