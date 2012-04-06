From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] tests: add initial bash completion tests
Date: Fri, 6 Apr 2012 17:34:48 -0400
Message-ID: <20120406213448.GA5436@sigill.intra.peff.net>
References: <1333740519-3792-1-git-send-email-felipe.contreras@gmail.com>
 <20120406201926.GA1677@sigill.intra.peff.net>
 <CAMP44s0n+dyp-QNOPtiKtGX1VNOsM8GJOLLCksqwPArR+FS8ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 23:34:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGGo3-0005Dm-Oq
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 23:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584Ab2DFVev convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Apr 2012 17:34:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52765
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754150Ab2DFVeu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 17:34:50 -0400
Received: (qmail 11864 invoked by uid 107); 6 Apr 2012 21:34:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Apr 2012 17:34:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2012 17:34:48 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s0n+dyp-QNOPtiKtGX1VNOsM8GJOLLCksqwPArR+FS8ng@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194911>

On Sat, Apr 07, 2012 at 12:21:35AM +0300, Felipe Contreras wrote:

> On Fri, Apr 6, 2012 at 11:19 PM, Jeff King <peff@peff.net> wrote:
> > On Fri, Apr 06, 2012 at 10:28:39PM +0300, Felipe Contreras wrote:
>=20
> > I think you need to start with something like:
> >
> > =C2=A0#!/bin/sh
>=20
> That is irrelevant, even if it's '#!/bin/foobar', it wouldn't make an=
y
> difference since the actual command would be something like
> '$(SHELL_PATH) t9902-completion.sh'.

True; I thought "prove" would run them directly, but even it uses
$(SHELL_PATH) to run the tests. However, doesn't that mean your test
will fail completely when $(SHELL_PATH) isn't bash?

So yes, the #! isn't relevant to "make test" (though marking it as
#!/bin/sh does serve as documentation for what you expect, and does let
people with a sane /bin/sh more easily run the test directly).

But my point still stands that you cannot assume that you are running
bash, and you need to either find bash, or gracefully exit the test
script if it is not available. Anything else will cause "make test" to
fail on some systems (and indeed, applying and running your test, it
breaks "make test" on my debian box with dash as /bin/sh).

>Plus /bin/sh does not always point to bash, even when bash is availabl=
e
>(see debian).

Yes, that was my point, and why the example code I showed executed bash
explicitly instead of relying on $(SHELL_PATH) to be set to it.

-Peff
