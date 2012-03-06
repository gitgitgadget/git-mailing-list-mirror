From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] config: Introduce --patience config variable
Date: Tue, 6 Mar 2012 08:30:01 -0500
Message-ID: <20120306133001.GA22153@sigill.intra.peff.net>
References: <a87ed689ddfb06601dd639541199fc72d829bdaf.1331031473.git.mprivozn@redhat.com>
 <20120306114914.GB6733@sigill.intra.peff.net>
 <87pqcp6fyh.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michal Privoznik <mprivozn@redhat.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Mar 06 14:30:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4uSz-00015r-Od
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 14:30:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030464Ab2CFNaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 08:30:05 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42137
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030275Ab2CFNaE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 08:30:04 -0500
Received: (qmail 10827 invoked by uid 107); 6 Mar 2012 13:30:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 Mar 2012 08:30:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Mar 2012 08:30:01 -0500
Content-Disposition: inline
In-Reply-To: <87pqcp6fyh.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192346>

On Tue, Mar 06, 2012 at 02:01:42PM +0100, Thomas Rast wrote:

> >> --- a/Documentation/diff-config.txt
> >> +++ b/Documentation/diff-config.txt
> >> @@ -86,6 +86,9 @@ diff.mnemonicprefix::
> >>  diff.noprefix::
> >>  	If set, 'git diff' does not show any source or destination prefix.
> >>  
> >> +diff.patience:
> >> +    If set, 'git diff' will use patience algorithm.
> >> +
> >
> > Should this be a boolean? Or should we actually have a diff.algorithm
> > option where you specify the algorithm you want (e.g., "diff.algorithm =
> > patience")? That would free us up later to more easily add new values.
> >
> > In particular, I am thinking about --minimal. It is mutually exclusive
> > with --patience, and is simply ignored if you use patience diff.
> > we perhaps have "diff.algorithm" which can be one of "myers", "minimal"
> > (which is really myers + the minimal flag), and "patience".
> 
> Don't forget "histogram".  I have no idea why it's not documented
> (evidently 8c912eea slipped through the review cracks) but --histogram
> is supported since 1.7.7.

Ah, thanks. I had the vague feeling that we had a third algorithm
already, but I didn't see it in the docs. So yeah, I really think this
should be diff.algorithm, with a value of "myers", "patience", or
"histogram" (and possibly "minimal", depending how we want to treat
that).

-Peff
