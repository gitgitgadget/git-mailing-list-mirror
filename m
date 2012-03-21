From: Jeff King <peff@peff.net>
Subject: Re: Clone fails on a repo with too many heads/tags
Date: Wed, 21 Mar 2012 16:17:23 -0400
Message-ID: <20120321201722.GA15021@sigill.intra.peff.net>
References: <loom.20120318T083216-96@post.gmane.org>
 <m3fwd550j3.fsf@localhost.localdomain>
 <20120318190659.GA24829@sigill.intra.peff.net>
 <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com>
 <20120319024436.GB10426@sigill.intra.peff.net>
 <4F69B5F0.2060605@gmx.net>
 <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com>
 <20120321171423.GA13140@sigill.intra.peff.net>
 <4F6A33C5.2080909@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Ivan Todoroski <grnch_lists@gmx.net>
X-From: git-owner@vger.kernel.org Wed Mar 21 21:17:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SARyN-0005sq-08
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 21:17:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758478Ab2CUUR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 16:17:26 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55420
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758171Ab2CUURZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 16:17:25 -0400
Received: (qmail 26347 invoked by uid 107); 21 Mar 2012 20:17:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 Mar 2012 16:17:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Mar 2012 16:17:23 -0400
Content-Disposition: inline
In-Reply-To: <4F6A33C5.2080909@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193612>

On Wed, Mar 21, 2012 at 09:02:13PM +0100, Ivan Todoroski wrote:

> >Something in me feels slightly uncomfortable with that, just because
> >simple newline-delimited formats make it easy for people to hack on the
> >tool and feed input from unexpected sources.
> 
> I understand what you mean. How about this:
> 
> If both --stdin and --stateless-rpc are specified to fetch-pack, it
> will use pkt-line to read the refs from stdin before handing off
> stdin to get_remote_heads().
> 
> However, if only --stdin is specified, it will read refs from stdin
> in a script-friendly newline delimited format, one ref per line. This
> is okay because when --stateless-rpc is not specified
> get_remote_heads() reads from an fd different from stdin so there is
> no issue with residual buffers in this case.
> 
> This way you preserve scriptability for any other callers who don't
> use --stateless-rpc.
> 
> How does this sound?

I think that sounds quite reasonable, and shouldn't be more than a few
extra lines to implement.

-Peff
