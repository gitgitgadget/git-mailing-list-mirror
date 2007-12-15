From: Jeff King <peff@peff.net>
Subject: Re: git-cvsexportcommit fails for huge commits
Date: Sat, 15 Dec 2007 05:09:50 -0500
Message-ID: <20071215100950.GB1692@coredump.intra.peff.net>
References: <20071211200418.GA13815@mkl-desktop> <20071214044554.GB10169@sigill.intra.peff.net> <20071214091546.GA20907@coredump.intra.peff.net> <200712141447.05039.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Markus Klinik <markus.klinik@gmx.de>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 11:10:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3TyK-00013R-2b
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 11:10:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752820AbXLOKJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 05:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752641AbXLOKJx
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 05:09:53 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3576 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751961AbXLOKJw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 05:09:52 -0500
Received: (qmail 1973 invoked by uid 111); 15 Dec 2007 10:09:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 15 Dec 2007 05:09:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 15 Dec 2007 05:09:50 -0500
Content-Disposition: inline
In-Reply-To: <200712141447.05039.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68381>

On Fri, Dec 14, 2007 at 02:47:03PM +0100, Robin Rosenberg wrote:

> > So here is a cleaned up patch. It bumps the maximum size to 64kB, adds
> > scalar support (nobody uses it, but it makes sense for the interface to
> > match that of safe_pipe_capture -- I am even tempted to just replace
> > safe_pipe_capture entirely and convert the few other callers), and
> > cleans up the unused safe_pipe_capture_blob.
> 
> Wouldn't using the POSIX::ARG_MAX constant work?

It does seem to produce sensible results. Does it work reasonably on
Windows?

Note that it would also need to be ARG_MAX - slop, where slop accounts
for the environment (which maybe we can get accurately by counting the
keys and values of %ENV, adding NUL terminators?).

-Peff
