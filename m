From: Jeff King <peff@peff.net>
Subject: Re: groff .ft command use in asciidoc
Date: Fri, 19 Nov 2010 13:37:53 -0500
Message-ID: <20101119183753.GA14189@sigill.intra.peff.net>
References: <20101117095233.GA23817@basil.fritz.box>
 <20101117101516.GA12416@burratino>
 <20101117143855.GA1987@sigill.intra.peff.net>
 <20101117154829.GE23656@basil.fritz.box>
 <20101119175424.GA13276@sigill.intra.peff.net>
 <20101119182230.GA26187@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andi Kleen <andi@firstfloor.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Chris Johnsen <chris_johnsen@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 19 19:38:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJVqr-0006n4-1n
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 19:38:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756285Ab0KSSiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 13:38:00 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:52448 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755247Ab0KSSh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 13:37:59 -0500
Received: (qmail 26860 invoked by uid 111); 19 Nov 2010 18:37:58 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 19 Nov 2010 18:37:58 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Nov 2010 13:37:53 -0500
Content-Disposition: inline
In-Reply-To: <20101119182230.GA26187@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161774>

On Fri, Nov 19, 2010 at 12:22:30PM -0600, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > --- a/Documentation/Makefile
> > +++ b/Documentation/Makefile
> > @@ -63,35 +63,28 @@ endif
> [...]
> > -#	-1.68.1,	set ASCIIDOC_NO_ROFF? (based on changelog from 1.73.0)
> > -#	1.69.0,		no extra settings are needed?
> > +#	-1.68.1,	no extra settings are needed?
> > +#	1.69.0,		set ASCIIDOC_ROFF?
> >  #	1.69.1-1.71.0,	set DOCBOOK_SUPPRESS_SP?
> > -#	1.71.1,		no extra settings are needed?
> > +#	1.71.1,		set ASCIIDOC_ROFF?
> 
> I would like to see these question marks go away.

I would, too, but not enough to put work into building and testing
various combinations of software that hopefully nobody is using anymore.

> I believe the
> initial introduction of ASCIIDOC_NO_ROFF happened conservatively:
> i.e., do not change anything unless this particular toolset
> requires the change.  Which is a shame, because it means it is not
> obvious what ASCIIDOC_ROFF is working around.

Yeah, the name ASCIIDOC_ROFF is kind of awful. I tried to make this
patch as dirt-simple as possible: just switch the defaults around (it
would be nice if we could simply set ASCIIDOC8=Yes, but because we use
"ifdef" and not "if" in the makefile, it has to be a separate variable).

I suspect there could really be some cleanup in this area, and you seem
to, too...

> Given all that, I suspect (but haven't checked) that the only knob we
> would need to cover all historically supported versions of DocBook is
> 
> 	DOCBOOK_MESSES_UP_SCREEN_TAG = YesUnfortunately
> 
> to be set with docbook versions in the 1.68 series.  Everyone else
> can use <screen>, with the <literallayout> fixup to add some space
> after it.

Yeah, that would be great and much simpler if it works. I encourage you
to test it. :)

> > However, I think it is worth it to avoid the hassle for the vast
> > majority of people on modern systems.
> 
> Yes!  Your patch takes care of that, so ack.

Thanks.

-Peff
