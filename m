From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] More permissive "git-rm --cached" behavior without -f.
Date: Fri, 13 Jul 2007 13:57:37 -0400
Message-ID: <20070713175737.GA20416@coredump.intra.peff.net>
References: <vpq8x9k9peu.fsf@bauges.imag.fr> <11843484982037-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jul 13 19:57:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9POg-00081O-R0
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 19:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757013AbXGMR5j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 13:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757000AbXGMR5j
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 13:57:39 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2992 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756657AbXGMR5j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 13:57:39 -0400
Received: (qmail 17735 invoked from network); 13 Jul 2007 17:58:04 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 13 Jul 2007 17:58:04 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jul 2007 13:57:37 -0400
Content-Disposition: inline
In-Reply-To: <11843484982037-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52407>

On Fri, Jul 13, 2007 at 07:41:38PM +0200, Matthieu Moy wrote:

> Previously, the index had to match the file *and* the HEAD. With
> --cached, the index must now match the file *or* the HEAD. The behavior
> without --cached is unchanged, but provides better error messages.

This does make more sense, but there are still some inconsistencies. Is
it OK to lose content that is only in the index, or not?

If it is OK, then --cached shouldn't need _any_ safety valve (and after
all, anything you remove in that manner is recoverable with git-fsck
until the next prune).

If it isn't OK, then you are not addressing the cases where git-rm
without --cached loses index content (that is different than HEAD and
the working tree).

-Peff
