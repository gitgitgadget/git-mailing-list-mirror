From: Jeff King <peff@peff.net>
Subject: Re: autocrlf=input and safecrlf (was Re: CVS import [SOLVED])
Date: Wed, 25 Feb 2009 01:56:24 -0500
Message-ID: <20090225065624.GA1678@sigill.intra.peff.net>
References: <20090220172918.GB4636@coredump.intra.peff.net> <499F3B9B.3020709@pelagic.nl> <20090223000840.GA20392@coredump.intra.peff.net> <2944.77.61.241.211.1235371848.squirrel@hupie.xs4all.nl> <20090223065615.GA24807@coredump.intra.peff.net> <1570.77.61.241.211.1235372943.squirrel@hupie.xs4all.nl> <20090223071056.GA29241@coredump.intra.peff.net> <59288.77.61.241.211.1235374197.squirrel@hupie.xs4all.nl> <20090224061134.GF4615@coredump.intra.peff.net> <14283.77.61.241.211.1235467512.squirrel@hupie.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Wed Feb 25 07:57:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcDiM-0006v5-OG
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 07:57:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289AbZBYG41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 01:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752291AbZBYG41
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 01:56:27 -0500
Received: from peff.net ([208.65.91.99]:34436 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752084AbZBYG41 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 01:56:27 -0500
Received: (qmail 23308 invoked by uid 107); 25 Feb 2009 06:56:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 25 Feb 2009 01:56:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Feb 2009 01:56:24 -0500
Content-Disposition: inline
In-Reply-To: <14283.77.61.241.211.1235467512.squirrel@hupie.xs4all.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111378>

On Tue, Feb 24, 2009 at 10:25:12AM +0100, Ferry Huberts (Pelagic) wrote:

> > So yes, in some sense it is safecrlf that is broken. I'm just concerned
> > about tweaking the user's options behind their back. The import can
> > happen differently than they expected no matter which of safecrlf or
> > autocrlf you tweak. So I think you are better off to complain and die.
> 
> The plan was:
> - when creating a new git repo for cvs import: setup safecrlf=false
> - when importing into an existing repo: check whether the safecrlf
>   setting is set to false and crash and burn when not :-)
>   (complain before going up in flames)

Why is it OK to silently change the settings in the first case, but not
the second? Don't both have the potential to screw up the user's import?

Also, are settings going to be unset after the first import? If so, then
further incremental imports will fail as described in your second case.
But if not, then safecrlf is turned off for that repo, even for
non-cvsimport commands, overriding anything in the user's ~/.gitconfig.
For somebody doing a one-shot import, they are paying that price without
any benefit.

-Peff
