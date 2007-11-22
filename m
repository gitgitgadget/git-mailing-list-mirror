From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/5] Don't return 'undef' in case called in a vector
	context.
Date: Thu, 22 Nov 2007 07:06:19 -0500
Message-ID: <20071122120619.GE12913@sigill.intra.peff.net>
References: <20071017015152.GN13801@spearce.org> <20071022164048.71a3dceb@danzwell.com> <20071023042702.GB28312@coredump.intra.peff.net> <20071023035221.66ea537f@danzwell.com> <20071102224100.71665182@paradox.zwell.net> <20071104045735.GA12359@segfault.peff.net> <7v640ivagv.fsf@gitster.siamese.dyndns.org> <20071104054305.GA13929@sigill.intra.peff.net> <20071110180109.34febc3f@paradox.zwell.net> <20071122045534.435f01bb@paradox.zwell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Dan Zwell <dzwell@zwell.net>
X-From: git-owner@vger.kernel.org Thu Nov 22 13:06:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvApP-0005GC-0J
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 13:06:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005AbXKVMGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 07:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753432AbXKVMGX
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 07:06:23 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1869 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753624AbXKVMGW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 07:06:22 -0500
Received: (qmail 23207 invoked by uid 111); 22 Nov 2007 12:06:20 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 22 Nov 2007 07:06:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Nov 2007 07:06:19 -0500
Content-Disposition: inline
In-Reply-To: <20071122045534.435f01bb@paradox.zwell.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65813>

On Thu, Nov 22, 2007 at 04:55:34AM -0600, Dan Zwell wrote:

> Previously, the Git->repository()->config('non-existent.key')
> evaluated to as true in a vector context. Call 'return' with
> no argument, instead.

I think the reason this works is a subtle issue (well, I had to look it
up, anyway): return without an argument automatically checks the calling
context and returns the empty list in a list context. So we are
returning an empty list now, instead of a list containing a single
undef. I think it might be useful to explain this a bit better in the
commit message.

-Peff
