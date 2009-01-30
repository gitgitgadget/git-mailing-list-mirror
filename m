From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] push: Learn to set up branch tracking with '--track'
Date: Fri, 30 Jan 2009 00:09:25 -0500
Message-ID: <20090130050925.GA18809@coredump.intra.peff.net>
References: <cover.1233236267u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0901291438030.3586@pacific.mpi-cbg.de> <20090129223308.GB12871@coredump.intra.peff.net> <20090129231715.GA17399@coredump.intra.peff.net> <alpine.DEB.1.00.0901300127450.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 30 06:10:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSleX-0000Sg-6E
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 06:10:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbZA3FJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 00:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbZA3FJ2
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 00:09:28 -0500
Received: from peff.net ([208.65.91.99]:42044 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751072AbZA3FJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 00:09:27 -0500
Received: (qmail 27137 invoked by uid 107); 30 Jan 2009 05:09:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 30 Jan 2009 00:09:37 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Jan 2009 00:09:25 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901300127450.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107773>

On Fri, Jan 30, 2009 at 01:28:38AM +0100, Johannes Schindelin wrote:

> > Something like the patch below (which is obviously missing all of the 
> > infrastructure for doing this optionally, but is meant to illustrate 
> > what I'm talking about).
> 
> Except that you miss http:// and rsync:// protocols.  Those were the 
> reasons I did not touch send-pack.

You didn't comment on the part of my email where I said exactly that,
but that I think this is still the right path forward.

Pushing through those protocols is sorely in need of update (actually,
I thought rsync was all but dead at this point). But http push is
missing the update of tracking refs, the usual status output (it still
has the "Maybe you are not up-to-date and need to pull first?" message
that was removed from send-pack a year and a half ago), and who knows
what other tweaks made to do_send_pack (which it appears to have been
copy-and-pasted from in 2006) in the last few years.

So either we don't care about http-push being consistent with send-pack,
and it is OK to have this feature in one but not the other. Or we do,
and we really need to clean up the current divergence.

-Peff
