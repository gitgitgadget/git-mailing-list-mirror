From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 0/3] fix "Funny: git -p submodule summary"
Date: Wed, 28 Jan 2009 02:30:59 -0500
Message-ID: <20090128073059.GD19165@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0901081601240.30769@pacific.mpi-cbg.de> <20090127062512.GA10487@coredump.intra.peff.net> <alpine.DEB.1.00.0901271728130.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 28 08:32:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS4uS-0006nQ-As
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 08:32:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946AbZA1HbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 02:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbZA1HbD
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 02:31:03 -0500
Received: from peff.net ([208.65.91.99]:34772 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751714AbZA1HbD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 02:31:03 -0500
Received: (qmail 19483 invoked by uid 107); 28 Jan 2009 07:31:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 28 Jan 2009 02:31:10 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Jan 2009 02:30:59 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901271728130.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107490>

On Tue, Jan 27, 2009 at 05:31:02PM +0100, Johannes Schindelin wrote:

> I like the patch series, well designed and concise (especially with the 
> fixes Hannes proposed).

Good. Response seems positive, so I will drop the RFC, then, and post a
fixed-up series meant for inclusion.

> > There are two potential downsides to the fix:
> > 
> >  1. There is an extra fork and a parent process sitting in memory for
> >     dashed externals. This is pretty necessary to any fix, since
> >     something has to wait to do pager cleanup, and we can't rely on the
> >     child to do so.
> 
> Actually, I think this is a good thing; that way, we can catch 
> segmentation fault properly and display an error message in the pager.  
> That was not possible previously.

True. On the other hand, most of our externals are shell scripts. It's
the builtins that segfault, and we don't have a watcher process for
that. :)

-Peff
