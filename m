From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/6] remote.c: drop default_remote_name variable
Date: Tue, 31 Mar 2015 18:22:25 -0400
Message-ID: <20150331222224.GA31948@peff.net>
References: <20150331173339.GA17732@peff.net>
 <20150331173437.GA18912@peff.net>
 <xmqqzj6sq4xc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 00:22:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd4YK-0004z4-SF
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 00:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbbCaWW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 18:22:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:40686 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751030AbbCaWW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 18:22:28 -0400
Received: (qmail 29900 invoked by uid 102); 31 Mar 2015 22:22:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Mar 2015 17:22:27 -0500
Received: (qmail 29275 invoked by uid 107); 31 Mar 2015 22:22:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 31 Mar 2015 18:22:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Mar 2015 18:22:25 -0400
Content-Disposition: inline
In-Reply-To: <xmqqzj6sq4xc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266566>

On Tue, Mar 31, 2015 at 01:37:35PM -0700, Junio C Hamano wrote:

> > When we read the remote config from disk, we update a
> > default_remote_name variable if we see branch.*.remote
> > config for the current branch. This isn't wrong, or even all
> > that complicated, but it is a bit simpler (because it
> > reduces our overall state) to just lazily compute the
> > default when we need it.
> >
> > The ulterior motive here is that the push config uses a
> > similar structure, and _is_ much more complicated as a
> > result. That will be simplified in a future patch, and it's
> > more readable if the logic remotes and push-remotes matches.
> 
> I cannot quite parse the part after "if..."; "the logic used by
> remotes and push-remotes matches"?

Sorry, it should have been "...if the logic for remotes and push-remotes
matches".

> > +static int loaded_remotes_config;
> > +
> 
> I expect that the reason why this is not a function scope static in
> read_config() will be revealed in the later patch in this series...

No, it's not used. I was leaving it as an "out" in case somebody ever
needed to reset it in order to re-read the config, but I agree it is
probably better to let them pull it out of the function if and when that
happens.

-Peff
