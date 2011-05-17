From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] send-pack: avoid deadlock on git:// push with failed
 pack-objects
Date: Tue, 17 May 2011 01:56:05 -0400
Message-ID: <20110517055605.GE10048@sigill.intra.peff.net>
References: <20110516063944.GB25731@sigill.intra.peff.net>
 <20110516065257.GC19078@sigill.intra.peff.net>
 <4DD182C8.50308@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue May 17 07:56:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMDGP-0002X1-Ht
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 07:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123Ab1EQF4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 01:56:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53521
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751717Ab1EQF4I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2011 01:56:08 -0400
Received: (qmail 21671 invoked by uid 107); 17 May 2011 05:58:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 17 May 2011 01:58:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 May 2011 01:56:06 -0400
Content-Disposition: inline
In-Reply-To: <4DD182C8.50308@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173789>

On Mon, May 16, 2011 at 10:02:16PM +0200, Johannes Sixt wrote:

> > +			if (git_connection_is_socket(conn))
> > +				shutdown(fd[0], SHUT_WR);
> 
> We probably need a wrapper for shutdown() on Windows. I'll look into
> this tomorrow.

FWIW, we already make an identical call in transport-helper.c (I was
tempted even to use "1" instead of SHUT_WR for portability, but it seems
nobody has complained so far about the use in transport-helper).

-Peff
