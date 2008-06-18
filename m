From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] parse_options: Add flag to prevent errors for further
 processing
Date: Wed, 18 Jun 2008 17:50:31 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806181709300.6439@racer>
References: <1213758236-979-1-git-send-email-shawn.bohrer@gmail.com> <1213758236-979-2-git-send-email-shawn.bohrer@gmail.com> <7v1w2v2zsh.fsf@gitster.siamese.dyndns.org> <20080618033010.GA19657@sigill.intra.peff.net>
 <7vwskn1g2p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Shawn Bohrer <shawn.bohrer@gmail.com>,
	git@vger.kernel.org, madcoder@debian.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 18:53:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K90uD-0008WM-1Y
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 18:53:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753183AbYFRQwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 12:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753133AbYFRQwL
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 12:52:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:48373 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752849AbYFRQwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 12:52:09 -0400
Received: (qmail invoked by alias); 18 Jun 2008 16:52:07 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp060) with SMTP; 18 Jun 2008 18:52:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/rXghjwtPrupr6w4YSiib33VmSAmhswcCAfWul9X
	q5YTVgEBx10dyb
X-X-Sender: gene099@racer
In-Reply-To: <7vwskn1g2p.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85391>

Hi,

On Tue, 17 Jun 2008, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think the only right way to accomplish this is to convert the revision
> > and diff parameters into a parseopt-understandable format.
> 
> Not necessarily.  You could structure individual option parsers like how 
> diff option parsers are done.  You iterate over argv[], feed diff option 
> parser the current index into argv[] and ask if it is an option diff 
> understands, have diff eat the option (and possibly its parameter) to 
> advance the index, or allow diff option to say "I do not understand 
> this", and then handle it yourself or hand it to other parsers.

AFAIR Pierre tried a few ways, and settled with a macro to introduce the 
diff options into a caller's options.

IOW it would look something like this:

static struct option builtin_what_options[] = {
	[... options specific to this command ...]
	DIFF__OPT(&diff_options)
};

Ciao,
Dscho
