From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] Add 'git credential' plumbing command
Date: Tue, 12 Jun 2012 10:34:11 -0400
Message-ID: <20120612143411.GA7524@sigill.intra.peff.net>
References: <1339511044-29977-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
 <vpq3960r48q.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Javier.Roucher-Iglesias@ensimag.imag.fr, git@vger.kernel.org,
	Javier Roucher <jroucher@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 12 16:34:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeSAl-0001Vp-QG
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 16:34:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753021Ab2FLOeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 10:34:14 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:51032
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752000Ab2FLOeN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 10:34:13 -0400
Received: (qmail 20118 invoked by uid 107); 12 Jun 2012 14:34:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Jun 2012 10:34:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jun 2012 10:34:11 -0400
Content-Disposition: inline
In-Reply-To: <vpq3960r48q.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199792>

On Tue, Jun 12, 2012 at 04:31:33PM +0200, Matthieu Moy wrote:

> Javier.Roucher-Iglesias@ensimag.imag.fr writes:
> 
> > +git credential <fill|approve|reject>
> 
> You didn't take Jeff's suggestions into account:
> 
> http://thread.gmane.org/gmane.comp.version-control.git/199552/focus=199591
> 
> It's clearly too late to implement the whole suggested API, but I do
> like the suggestion of allowing either a URL as argument or individual
> fields on stdin, or both combined, by using the --stdin argument.
> 
> To allow further patches to implement this without breaking backward
> compatibility, your implementation could require the use of --stdin on
> the command-line.

Actually, after further discussion, I think that --stdin is unnecessary.
If you are providing a URL, you should always provide it via stdin
because of the password-disclosure issue. It's tempting to provide a
command-line alternative because it's easier, but I think it would just
encourage lazy developers to do the wrong thing.

I do still think respecting "url=" when reading a credential makes
sense, but that is easy to add later.

-Peff
