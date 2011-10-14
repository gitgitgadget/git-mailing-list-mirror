From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] daemon: return "access denied" if a service is not
 allowed
Date: Fri, 14 Oct 2011 09:10:41 -0400
Message-ID: <20111014131041.GC7808@sigill.intra.peff.net>
References: <7vsjn9etm3.fsf@alter.siamese.dyndns.org>
 <1317678909-19383-1-git-send-email-pclouds@gmail.com>
 <20111012200916.GA1502@sigill.intra.peff.net>
 <20111013044544.GA27890@duynguyen-vnpc.dek-tpc.internal>
 <20111013182816.GA17573@sigill.intra.peff.net>
 <7vvcrs181e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 14 15:10:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REhXG-0001C6-Nq
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 15:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756515Ab1JNNKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 09:10:46 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60535
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752316Ab1JNNKp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 09:10:45 -0400
Received: (qmail 8901 invoked by uid 107); 14 Oct 2011 13:10:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 14 Oct 2011 09:10:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Oct 2011 09:10:41 -0400
Content-Disposition: inline
In-Reply-To: <7vvcrs181e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183572>

On Thu, Oct 13, 2011 at 10:01:01PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So if we want to do anything, I would think it would be a hook. Except
> > that we may or may not have a repo, so it would not be a hook in
> > $GIT_DIR/hooks, but rather some script to be run passed on the command
> > line, like:
> >
> >   git daemon --informative-errors=/path/to/hook
> 
> I don't think it is necessarily good to have such a variation across
> hosting sites. Your "something like this" patch looked like it was giving
> a reasonable level of detail, IMO.

Yeah. With arbitrary messages, the client has no way of programatically
deciphering which message is which, so localization becomes impossible.
HTTP solved this by having a response code _and_ still allowing content
for custom pages.  That kind of works, though most of the time I find
things like custom 404 pages to just be junk.

Let's start with my original patch (which I'll clean and repost). And if
somebody really wants to push towards customized messages, that is easy
enough to do on top later.

-Peff
