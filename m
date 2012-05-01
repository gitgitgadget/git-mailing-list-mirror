From: Jeff King <peff@peff.net>
Subject: Re: gc --aggressive
Date: Tue, 1 May 2012 13:16:40 -0400
Message-ID: <20120501171640.GA16623@sigill.intra.peff.net>
References: <CAG+J_DzO=UZ56PjnSCRaTdj8pBSYc5PFofw1QHy42c5pHMK_HQ@mail.gmail.com>
 <CAG+J_DyqvCxwd6+gzixQEk6SxMZF0qsXKcJPaU6imsJdFQ-64g@mail.gmail.com>
 <vpqbomqqdxo.fsf@bauges.imag.fr>
 <20120428122533.GA12098@sigill.intra.peff.net>
 <alpine.LFD.2.02.1204281258050.21030@xanadu.home>
 <20120429113431.GA24254@sigill.intra.peff.net>
 <alpine.LFD.2.02.1204290917051.21030@xanadu.home>
 <20120501162806.GA15614@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue May 01 19:16:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPGh1-00068w-Pn
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 19:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757593Ab2EARQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 13:16:46 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53492
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755193Ab2EARQp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 13:16:45 -0400
Received: (qmail 7502 invoked by uid 107); 1 May 2012 17:17:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 May 2012 13:17:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 May 2012 13:16:40 -0400
Content-Disposition: inline
In-Reply-To: <20120501162806.GA15614@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196703>

On Tue, May 01, 2012 at 12:28:06PM -0400, Jeff King wrote:

> >  You could test this theory by commenting out the size comparisons in 
> > type_size_sort() and re-run the test.
> 
> I'll try this next.

Wow, it behaves horribly. I didn't even let the bigger tests run to
completion. Here is the output for git.git (the first line is from the
original, unmodified version of git with --window=10):

  orig | 31.4M (100%) |   54s (100%)
    10 | 44.0M (140%) |  169s (310%)
    20 | 37.7M (120%) |  232s (428%)
    40 | 33.6M (107%) |  331s (608%)
    80 | 30.9M ( 99%) |  473s (868%)
   160 | 29.4M ( 94%) |  696s (1279%)

Unless the window is increased a lot, the packs end up quite a bit
larger (and even still we spend a lot more CPU time).

-Peff
