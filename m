From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/3] Introduce die_errno() that appends
	strerror(errno) to die()
Date: Mon, 8 Jun 2009 18:04:24 -0400
Message-ID: <20090608220423.GA29942@sigill.intra.peff.net>
References: <200906061509.15870.trast@student.ethz.ch> <cover.1244299302.git.trast@student.ethz.ch> <3672f22723a4c14c4a6d67278e9865424c0c68dc.1244299302.git.trast@student.ethz.ch> <20090606221320.GB30064@coredump.intra.peff.net> <2325a7950906070412k3a440558h35db7511cc390e4b@mail.gmail.com> <7vzlck9e3j.fsf@alter.siamese.dyndns.org> <20090608123608.GG13775@coredump.intra.peff.net> <2325a7950906080835h6d6d2d28j2c7261f2296a3da6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>, Petr Baudis <pasky@suse.cz>
To: Alexander Potashev <aspotashev@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 00:04:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDmxG-0001Rp-Ao
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 00:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754066AbZFHWEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 18:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753670AbZFHWEY
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 18:04:24 -0400
Received: from peff.net ([208.65.91.99]:56846 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752879AbZFHWEX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 18:04:23 -0400
Received: (qmail 24395 invoked by uid 107); 8 Jun 2009 22:04:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 08 Jun 2009 18:04:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Jun 2009 18:04:24 -0400
Content-Disposition: inline
In-Reply-To: <2325a7950906080835h6d6d2d28j2c7261f2296a3da6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121120>

On Mon, Jun 08, 2009 at 07:35:55PM +0400, Alexander Potashev wrote:

> > More than that, you must support arbitrary printf format strings,
> > because the die routine is passed whatever goes to die() (a quick grep
> > revealed that we use at least %u and %c at various points). So it is an
> > undocumented requirement that the die routine process its parameters as
> > if it were from the printf family.
> 
> Your last statement is not quite true. A custom die routine may
> support all printf specifiers and some additional ones, but Thomas'
> die_errno passes the format string (and arguments list) to vsnprintf
> anyway, so the additional specifiers would be lost.

But if die() is called (_not_ die_errno), then the format is passed
unchanged. So what I am saying is that anyone supplying a die_routine
_already_ has to handle all printf format specifiers. So asking them to
handle just "%s" via die_errno is not introducing any additional
requirements.

-Peff
