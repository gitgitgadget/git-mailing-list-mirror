From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Color support added to git-add--interactive.
Date: Sat, 13 Oct 2007 13:27:45 -0400
Message-ID: <20071013172745.GA2624@coredump.intra.peff.net>
References: <471045DA.5050902@gmail.com> <19271E58-5C4F-41AF-8F9D-F114F36A34AC@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan Zwell <dzwell@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sat Oct 13 19:28:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgkmP-0005dT-ON
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 19:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754931AbXJMR1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 13:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754374AbXJMR1t
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 13:27:49 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4553 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751844AbXJMR1s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 13:27:48 -0400
Received: (qmail 29006 invoked by uid 111); 13 Oct 2007 17:27:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 13 Oct 2007 13:27:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Oct 2007 13:27:45 -0400
Content-Disposition: inline
In-Reply-To: <19271E58-5C4F-41AF-8F9D-F114F36A34AC@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 13, 2007 at 04:45:41PM +0200, Wincent Colaiuta wrote:

> - as Johannes pointed out, "clear" and "reset" are not used consistently 
> even though the Term::ANSIColor documentation says that they're the same, so 
> settled on "clear"; although in any case, the changes to the 
> print_ansi_color function mean that it is now the only site where clearing 
> takes place

Please use "reset", as that is the term used by the C color code.

> - changed the regex as suggested by Johannes, and a couple of others that 
> are used when splitting hunks

I believe there are other places where the diff output is parsed, and
the colors will mess that up, too (e.g., split_hunk). All of those
regexes need to be changed, too. I am a bit concerned that we are
putting intimate knowledge of the colorization scheme here. As much as
it pains me to have two diff colorizers, I wonder if that would be a
better solution than having a diff colorizer, and a colorized diff
parser.

-Peff
