From: Jeff King <peff@peff.net>
Subject: Re: Bug Report: git add
Date: Wed, 6 Apr 2011 21:12:40 -0400
Message-ID: <20110407011240.GA4133@sigill.intra.peff.net>
References: <4D9BA35E.6040204@dcook.org>
 <20110407005750.GC28813@sigill.intra.peff.net>
 <7vbp0ihnou.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Darren Cook <darren@dcook.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 03:12:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7dmC-0004hk-L4
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 03:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757163Ab1DGBMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 21:12:44 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40030
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756705Ab1DGBMn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 21:12:43 -0400
Received: (qmail 12955 invoked by uid 107); 7 Apr 2011 01:13:30 -0000
Received: from 70-36-146-44.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.44)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Apr 2011 21:13:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Apr 2011 21:12:40 -0400
Content-Disposition: inline
In-Reply-To: <7vbp0ihnou.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171033>

On Wed, Apr 06, 2011 at 06:09:37PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >>   mkdir settings
> >>   cd settings
> >>   git init
> >>   touch x
> >> ...
> >>   cd ..
> >>   git init
> >>   git add settings/
> >>    (should complain)
> >
> > If you do "git add settings" (without the slash) it will add the
> > repository as a submodule.  Which is not the behavior you asked for, but
> > is at least reasonable. So the real bug seems to me the fact that "git
> > add settings/" and "git add settings" behave differently.
> 
> Also if "git add settings/x" does not complain, that would be a bigger
> issue, whose solution would probably be in the same area.

It does not complain, and probably should. I'm unsure what "settings/"
should do: produce an error as "settings/x" does (or will do,
eventually, we hope), or behave as if "settings" was given.

Generally it is useful to collapse stray slashes for the user, but I
wonder if there is some use to differentiate between "settings" and "the
contents of the settings directory", as rsync does.

-Peff
