From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Use SHELL_PATH to fork commands in
 run_command.c:prepare_shell_cmd
Date: Wed, 28 Mar 2012 00:22:15 -0400
Message-ID: <20120328042215.GB30251@sigill.intra.peff.net>
References: <20120326182427.GA10333@sigill.intra.peff.net>
 <1332816078-26829-1-git-send-email-bwalton@artsci.utoronto.ca>
 <20120327032917.GB17338@sigill.intra.peff.net>
 <1332901381-sup-4406@pinkfloyd.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	jrnieder <jrnieder@gmail.com>, gitster <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Wed Mar 28 06:22:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCkOv-0000O0-VU
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 06:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047Ab2C1EWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 00:22:19 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34867
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750995Ab2C1EWS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 00:22:18 -0400
Received: (qmail 10906 invoked by uid 107); 28 Mar 2012 04:22:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 28 Mar 2012 00:22:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Mar 2012 00:22:15 -0400
Content-Disposition: inline
In-Reply-To: <1332901381-sup-4406@pinkfloyd.chass.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194103>

On Tue, Mar 27, 2012 at 10:46:15PM -0400, Ben Walton wrote:

> > > +#ifndef SHELL_PATH
> > > +# define SHELL_PATH "sh"
> > > +#endif
> > 
> > Does this default ever kick in? The Makefile defaults SHELL_PATH to
> > /bin/sh, so we will always end up with at least that.
> 
> Not when using the build system, but as Hannes mentioned, there is
> potential for this to be used outside of the default build system, so
> I think having the fallback is a good defensive option.  Should it
> maybe be set to /bin/sh though to be more consistent with system()?

Yeah, I think making it "/bin/sh" is better. It's more obvious to people
reading the code as part of git (since even though it is a repetition of
the default from the Makefile, at least it is the _same_ default), and
if it does get reused, it's probably a better default.

> Given the rest of the discussion that happened, I think I understand
> that my patch is actually ok with the following caveats:
> 
> 1. My commit message still needs work.
> 2. Possibly change the default setting of the SHELL_PATH macro from
>    "sh" to "/bin/sh"
> 3. Use the _SQ variant of SHELL_PATH.

Yeah, I think so (not that I am the final word, but that at least
matches my perception of the discussion so far, too).

> (The tracking of changes for SHELL_PATH is considered too heavy for
> now when the other _PATH items aren't tracked the same way.  This
> might make a nice separate patch series though, using the idea from
> the kernel where individual commands are tracked.)

Agreed.

-Peff
