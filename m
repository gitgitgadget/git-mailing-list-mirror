From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] diff text conversion filter
Date: Mon, 6 Oct 2008 21:20:44 -0400
Message-ID: <20081007012044.GA4217@coredump.intra.peff.net>
References: <1222567618-22156-1-git-send-email-Matthieu.Moy@imag.fr> <20080928041040.GA24214@coredump.intra.peff.net> <vpqd4io1tla.fsf@bauges.imag.fr> <20080928161106.GA30199@coredump.intra.peff.net> <vpqk5ctfyp6.fsf@bauges.imag.fr> <20080930164545.GA20305@sigill.intra.peff.net> <20081005214114.GA21875@coredump.intra.peff.net> <48E9B036.6090805@viscovery.net> <vpqtzbpwy9h.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Oct 07 03:22:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn1Gy-0000WD-HS
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 03:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754570AbYJGBUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 21:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754415AbYJGBUt
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 21:20:49 -0400
Received: from peff.net ([208.65.91.99]:4829 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752565AbYJGBUs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 21:20:48 -0400
Received: (qmail 26701 invoked by uid 111); 7 Oct 2008 01:20:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 06 Oct 2008 21:20:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Oct 2008 21:20:44 -0400
Content-Disposition: inline
In-Reply-To: <vpqtzbpwy9h.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97650>

On Mon, Oct 06, 2008 at 05:15:22PM +0200, Matthieu Moy wrote:

> Actually, I understand you don't want git gui and gitk to load MS-Word
> anytime you click something, but I'd love to see the textconv+diff in
> gitk.
> 
> (yeah, that's pretty hard to specify right, the ideal requirement
> seems to be "in a gui, use the good part of the diff driver, but not
> the other" :-\).

I think it is even more complex than that. Sometimes when doing "git
show" I want to see the textconv'd version, and sometimes I don't. So I
really want a command-line flag or environment variable that I can use
to control it (with a sane default).

So probably the way forward is to stop relying on "oh, we just didn't
parse some of the config, so it won't get used" to just parsing the
config all the time and having a diffopt for "do textconv, do external
diff, etc". And then plumbing can make sure that those flags never get
set, and porcelain can tie them to command-line options.

-Peff
