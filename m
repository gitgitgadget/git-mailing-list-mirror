From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 04/10] config: avoid segfault when parsing command-line
 config
Date: Mon, 13 Jun 2011 15:22:00 -0400
Message-ID: <20110613192200.GF17845@sigill.intra.peff.net>
References: <20110609155001.GA14969@sigill.intra.peff.net>
 <20110609155243.GD25507@sigill.intra.peff.net>
 <7vhb7tod01.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Claire Fousse <claire.fousse@ensimag.imag.fr>, git@vger.kernel.org,
	Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 21:22:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWCiA-0008K4-Q5
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 21:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753092Ab1FMTWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 15:22:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38557
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752782Ab1FMTWE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 15:22:04 -0400
Received: (qmail 16512 invoked by uid 107); 13 Jun 2011 19:22:13 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 13 Jun 2011 15:22:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Jun 2011 15:22:00 -0400
Content-Disposition: inline
In-Reply-To: <7vhb7tod01.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175728>

On Mon, Jun 13, 2011 at 10:30:22AM -0700, Junio C Hamano wrote:

> > +	if (!pair[0])
> > +		return error("bogus config parameter: %s", text);
> 
> This feels wrong.
> 
> Asking strbuf_split() to split a string "foo" with "=" delimiter would
> give you one element array ("foo", NULL), a string "fo" would give you
> ("fo", NULL), and a string "f" would give you ("f", NULL).  Shouldn't we
> get ("", NULL) if we ask it to split ""?

Yeah, I was making the assumption that strbuf_split was not bugging, and
coding to its output. But I think you are right, that it is simply
returning bogus output.

-Peff
