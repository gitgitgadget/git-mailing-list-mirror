From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] tag: add --points-at list option
Date: Mon, 6 Feb 2012 02:45:58 -0500
Message-ID: <20120206074558.GA24535@sigill.intra.peff.net>
References: <1328480887-27463-1-git-send-email-tmgrennan@gmail.com>
 <20120206000420.GC28735@sigill.intra.peff.net>
 <20120206063213.GC10489@tgrennan-laptop>
 <20120206070424.GC9931@sigill.intra.peff.net>
 <20120206071302.GA10447@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, jasampler@gmail.com
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 08:46:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuJH4-0003vq-HN
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 08:46:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753535Ab2BFHqC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 02:46:02 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58640
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792Ab2BFHqB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 02:46:01 -0500
Received: (qmail 24839 invoked by uid 107); 6 Feb 2012 07:53:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Feb 2012 02:53:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Feb 2012 02:45:58 -0500
Content-Disposition: inline
In-Reply-To: <20120206071302.GA10447@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190039>

On Mon, Feb 06, 2012 at 02:13:02AM -0500, Jeff King wrote:

> > BTW, writing that helped me notice two bugs in your patch:
> > 
> >   1. You read up to 47 bytes into the buffer without ever checking
> >      whether size >= 47.
> > 
> >   2. You never check whether the object you read from read_sha1_file is
> >      actually a tag.
> 
> Hmm, the "filter->lines" code for "git tag -n" makes a similar error. It
> should probably print nothing for objects that are not tags.

Ugh, this part of builtin/tag.c is riddled with small bugs. I'm
preparing a series that will fix them, and hopefully it should make
building your points-at patch on top much more pleasant.

-Peff
