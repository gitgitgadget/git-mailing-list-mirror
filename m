From: Jeff King <peff@peff.net>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare
	repositories?
Date: Sat, 17 Nov 2007 22:25:48 -0500
Message-ID: <20071118032547.GC4560@sigill.intra.peff.net>
References: <vpq7iknqrtp.fsf@bauges.imag.fr> <Pine.LNX.4.64.0711121755460.4362@racer.site> <vpqy7d3pck0.fsf@bauges.imag.fr> <Pine.LNX.4.64.0711121804400.4362@racer.site> <vpqoddzpc88.fsf@bauges.imag.fr> <7v4pfr2kmh.fsf@gitster.siamese.dyndns.org> <87myth58r5.fsf@osv.gnss.ru> <7vfxz8hbcf.fsf@gitster.siamese.dyndns.org> <20071118002514.GA4458@sigill.intra.peff.net> <7vejeoz7is.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergei Organov <osv@javad.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bill Lear <rael@zopyra.com>,
	Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 04:26:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItanX-0000dI-Jk
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 04:26:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754806AbXKRDZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 22:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754787AbXKRDZx
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 22:25:53 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1200 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754767AbXKRDZw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 22:25:52 -0500
Received: (qmail 7632 invoked by uid 111); 18 Nov 2007 03:25:50 -0000
Received: from ppp-216-106-96-70.storm.ca (HELO sigill.intra.peff.net) (216.106.96.70)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 17 Nov 2007 22:25:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Nov 2007 22:25:48 -0500
Content-Disposition: inline
In-Reply-To: <7vejeoz7is.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65336>

On Sat, Nov 17, 2007 at 05:06:51PM -0800, Junio C Hamano wrote:

> > Junio, can I get an ACK or NAK on the patch below?
> 
> I do not think it would hurt.  Is the "local" case the only
> codepath that needs this (iow, we would not need this message if
> other transports die more loudly and/or we cannot tell if the
> failure is wrong URL or empty remote repository)?

Good question, and the answer is yes, it is the only spot that produces
no useful output. The other errors are:

via ssh, git-daemon, or file:// (all using receive-pack) you get:
$ git-clone localhost:foo bar
Initialized empty Git repository in /home/peff/bar/.git/
fatal: no matching remote head
fetch-pack from 'localhost:foo' failed.

via http, you get:
$ git-clone http://localhost/git/foo bar
Initialized empty Git repository in /home/peff/bar/.git/
Cannot get remote repository information.
Perhaps git-update-server-info needs to be run there?

I didn't try rsync, though I expect it should be the same as http.

-Peff
