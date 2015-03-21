From: Jeff King <peff@peff.net>
Subject: Re: Bug? git submodule add SSL certificate problem: unable to get
 local issuer certificate
Date: Sat, 21 Mar 2015 09:22:59 -0400
Message-ID: <20150321132259.GA11843@peff.net>
References: <F24DBF8D-40EE-4C8D-AE9C-463E59C4AAD7@aschemann.net>
 <27F61CEE-F1D3-4B7F-B394-8D06A4AD8976@aschemann.net>
 <20150309074339.GA31866@peff.net>
 <54FEB1CA.7020204@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Aschemann Gerd <gerd@aschemann.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Mar 21 14:23:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZJMu-00034G-3N
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 14:23:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbbCUNXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2015 09:23:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:36441 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751237AbbCUNXD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2015 09:23:03 -0400
Received: (qmail 12504 invoked by uid 102); 21 Mar 2015 13:23:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 21 Mar 2015 08:23:02 -0500
Received: (qmail 1374 invoked by uid 107); 21 Mar 2015 13:23:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 21 Mar 2015 09:23:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Mar 2015 09:22:59 -0400
Content-Disposition: inline
In-Reply-To: <54FEB1CA.7020204@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266020>

On Tue, Mar 10, 2015 at 09:56:42PM +1300, Jens Lehmann wrote:

> >Config like this is in a funny boat. We do not want it to cross
> >transport boundaries, so that if we run:
> >
> >   git -c foo=bar clone /some/local/path
> >
> >the process serving /some/local/path should not see the "foo" option[1].
> >But for submodules in the same repository, keeping the shared config is
> >probably more reasonable (I can imagine a config variable that you might
> >want to behave differently between the submodule and the main project,
> >but I could not think of any off-hand, and I expect it would be a rare
> >exception).
> >
> >Submodule folks (cc'd) may have opinions.
> 
> I tend to rather not share configs. While I agree that for the example
> which started this it would be correct to simply pass http.sslverify,
> that doesn't always make sense (e.g. it never does for a setting like
> core.worktree).
> 
> We already have two options for submodule add and update that are
> passed to the clone command (--reference & --depth), maybe it is time
> to add another one for passing config options to clone (which then get
> set permanently in the submodule's config).

Sorry, I missed this earlier, as it fell into a spam trap.

What you're proposing does make sense to me. We already have "git clone
-c", so I think it would just be a matter of passing along that option
in the submodule code.

-Peff
