From: Jeff King <peff@peff.net>
Subject: Re: Clone fails on a repo with too many heads/tags
Date: Wed, 21 Mar 2012 13:14:23 -0400
Message-ID: <20120321171423.GA13140@sigill.intra.peff.net>
References: <loom.20120318T083216-96@post.gmane.org>
 <m3fwd550j3.fsf@localhost.localdomain>
 <20120318190659.GA24829@sigill.intra.peff.net>
 <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com>
 <20120319024436.GB10426@sigill.intra.peff.net>
 <4F69B5F0.2060605@gmx.net>
 <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ivan Todoroski <grnch_lists@gmx.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 21 18:14:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAP7O-0001Y2-80
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 18:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758709Ab2CUROc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 13:14:32 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55249
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758326Ab2CURO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 13:14:28 -0400
Received: (qmail 24195 invoked by uid 107); 21 Mar 2012 17:14:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 Mar 2012 13:14:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Mar 2012 13:14:23 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193590>

On Wed, Mar 21, 2012 at 07:28:24AM -0700, Shawn O. Pearce wrote:

> > Would it be OK for fetch-pack.c to use the packetized format (pkt-line.h)
> > for reading the list of refs from stdin?
> 
> This is probably the easiest way to implement the sneak-into-stdin
> patch. Use a pkt-line for each argument that should have been in the
> argv array from the command line, and a flush pkt to terminate the
> list.

Something in me feels slightly uncomfortable with that, just because
simple newline-delimited formats make it easy for people to hack on the
tool and feed input from unexpected sources.

But stateless-rpc is already a pretty deep internal interface anyway,
and the format is already weird (the second half is already packetized
input from a remote anyway). So it's probably not worth caring about
hackability here.

-Peff
