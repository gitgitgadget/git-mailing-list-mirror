From: Jeff King <peff@peff.net>
Subject: Re: [PATCH_v1] add 'git credential' plumbing command
Date: Mon, 11 Jun 2012 14:18:40 -0400
Message-ID: <20120611181840.GC20134@sigill.intra.peff.net>
References: <1339267502-13803-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
 <20120610115619.GA6453@sigill.intra.peff.net>
 <vpqr4tl4ti9.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Javier.Roucher-Iglesias@ensimag.imag.fr, git@vger.kernel.org,
	Javier Roucher <jroucher@gmail.com>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 11 20:18:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se9CR-0001Hk-Jd
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 20:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632Ab2FKSSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 14:18:43 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:50211
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751263Ab2FKSSn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 14:18:43 -0400
Received: (qmail 6725 invoked by uid 107); 11 Jun 2012 18:18:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Jun 2012 14:18:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2012 14:18:40 -0400
Content-Disposition: inline
In-Reply-To: <vpqr4tl4ti9.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199688>

On Mon, Jun 11, 2012 at 08:02:06PM +0200, Matthieu Moy wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It's nice to have an example like this, but there's much detail missing
> > in how the format is specified. However, this format is already
> > documented in the "helpers" section of api-credentials.txt, so it
> > probably makes sense to refer to that document.
> 
> I'd do it the other way around. api-credentials.txt is in technical/,
> while the document we're writing will end-up in a man page, which cannot
> link to technical/.

We do so already in a few places:

  $ cd Documentation && git grep 'link:technical/'
  git.txt:link:technical/api-index.html[GIT API documentation].
  gitcredentials.txt:link:technical/api-credentials.html[credentials API] for details.
  user-manual.txt:found in link:technical/pack-format.txt[technical/pack-format.txt].

I think the rationale is that you would have the HTML documentation
installed into /usr/share/doc/git-doc or similar, and asciidoc does
correctly generate footnote references from those links. However, I
would be fine with putting the meat of it into git-credential, and
having api-credentials refer back to it. It's easier on the user that
way.

> >   git credential --helper=cache fill
> >
> > That will give us more flexibility later down the road.
> 
> Actually, this should already be possible with
> 
>   git -c credential.helper=cache credential fill
> 
> I suspect that this feature will never be used outside tests, and if so,
> I don't think it deserves a command-line option.

Yeah, that is even better. The tests could also use test_config.  I
would pick whichever of the two is more convenient for a particular
test.

-Peff
