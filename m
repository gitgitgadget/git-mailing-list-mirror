From: Jeff King <peff@peff.net>
Subject: Re: add -i not able to find get_colorbool
Date: Mon, 17 Dec 2007 09:31:00 -0500
Message-ID: <20071217143100.GA21122@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0712171400250.9446@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 17 15:31:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4H0E-0001rH-Nl
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 15:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753648AbXLQObF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 09:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752662AbXLQObF
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 09:31:05 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2150 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753417AbXLQObE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 09:31:04 -0500
Received: (qmail 9308 invoked by uid 111); 17 Dec 2007 14:31:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 17 Dec 2007 09:31:01 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Dec 2007 09:31:00 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0712171400250.9446@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68567>

On Mon, Dec 17, 2007 at 02:04:21PM +0000, Johannes Schindelin wrote:

> The second line of git-add--interactive reads thusly:
> 
> 	use lib (split(/:/, $ENV{GITPERLLIB} || 
> 		"/home/gitte/lib/perl5/site_perl/5.8.8"));
> 
> and this puzzles me:
> 
> 	$ grep -n get_colorbool /home/gitte/lib/perl5/site_perl/5.8.8/Git.pm
> 	584:=item get_colorbool ( NAME )
> 	591:sub get_colorbool {
> 
> So it has it, but cannot locate get_colorbool?

That does seem odd. Can you try running git-add--interactive in the perl
debugger and doing this:

  x \&Git::get_colorbool
  x \&Git::repository

It should tell you where it is getting the functions from (in the first
case, it will presumably not find it at all, but you seem to have a
Git::repository, so it should point to the file that has been loaded).

-Peff
