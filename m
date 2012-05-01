From: Jeff King <peff@peff.net>
Subject: Re: gc --aggressive
Date: Tue, 1 May 2012 13:22:01 -0400
Message-ID: <20120501172201.GA23527@sigill.intra.peff.net>
References: <CAG+J_DzO=UZ56PjnSCRaTdj8pBSYc5PFofw1QHy42c5pHMK_HQ@mail.gmail.com>
 <CAG+J_DyqvCxwd6+gzixQEk6SxMZF0qsXKcJPaU6imsJdFQ-64g@mail.gmail.com>
 <vpqbomqqdxo.fsf@bauges.imag.fr>
 <20120428122533.GA12098@sigill.intra.peff.net>
 <alpine.LFD.2.02.1204281258050.21030@xanadu.home>
 <20120429113431.GA24254@sigill.intra.peff.net>
 <alpine.LFD.2.02.1204290917051.21030@xanadu.home>
 <20120501162806.GA15614@sigill.intra.peff.net>
 <alpine.LFD.2.02.1205011259200.21030@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue May 01 19:22:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPGmD-00007I-Ks
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 19:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757950Ab2EARWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 13:22:07 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53506
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757918Ab2EARWG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 13:22:06 -0400
Received: (qmail 7703 invoked by uid 107); 1 May 2012 17:22:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 May 2012 13:22:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 May 2012 13:22:01 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1205011259200.21030@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196705>

On Tue, May 01, 2012 at 01:17:03PM -0400, Nicolas Pitre wrote:

> However, this is possibly a good baseline to determine a default value 
> for window-memory though.  Given your number, we clearly see that good 
> packing can be achieved with relatively little memory and therefore it 
> might be a good idea not to leave this parameter unbounded by default in 
> order to catch potential pathological cases.  Maybe 64M would be a good 
> default value?  Having a repack process eating up more than 16GB of RAM 
> because its RAM usage is unbounded is certainly not nice.

Would that preclude a 65M object from being delta'd at all? If you are
putting a limit of 64M and it means we look at 50 delta candidates
instead of 60, then that is probably not going to hurt our size too
much. But if you have large objects that do happen to delta, the
difference between looking at 0 and 1 objects could have a big impact.

-Peff
