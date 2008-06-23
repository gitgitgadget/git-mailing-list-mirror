From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 13:15:05 -0400
Message-ID: <20080623171505.GB27265@sigill.intra.peff.net>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org> <20080623082223.GA12130@artemis.madism.org> <alpine.DEB.1.00.0806231312130.6440@racer> <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org> <20080623164917.GA25474@sigill.intra.peff.net> <alpine.LFD.1.10.0806230953550.2926@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jun 23 19:16:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KApe6-0006JK-5z
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 19:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755891AbYFWRPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 13:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756908AbYFWRPJ
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 13:15:09 -0400
Received: from peff.net ([208.65.91.99]:3014 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755891AbYFWRPI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 13:15:08 -0400
Received: (qmail 27502 invoked by uid 111); 23 Jun 2008 17:15:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 23 Jun 2008 13:15:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jun 2008 13:15:05 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806230953550.2926@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85888>

On Mon, Jun 23, 2008 at 10:06:52AM -0700, Linus Torvalds wrote:

> You'd start off with argv[] looking like [ "foo" "-b" "-a" ] and then 
> after calling parse_options with that, depending on whether it has 
> PARSE_OPT_CONTINUE_ON_UNKNOWN or not, you'd either end up with the "-a" 
> handled (and argv[] now being just [ "foo" "-b" ]), or if you have 

How can that be correct, if you don't know whether "-b" takes an
argument?

> PARSE_OPT_STOP_ON_UNKNOWN then parse_options() would return without having 
> done anything, and expecting you to handle the unknown option first and 
> then restarting the argument parsing.

That is the only thing that makes sense to me, since the command line
has to be parsed left-to-right (because the syntactic function of an
element relies on the semantics of the element to its left).

-Peff
