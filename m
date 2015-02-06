From: Jeff King <peff@peff.net>
Subject: Re: BUG: 'error: invalid key: pager.show_ref' on 'git show_ref'
Date: Fri, 6 Feb 2015 15:37:16 -0500
Message-ID: <20150206203716.GA10857@peff.net>
References: <20150206124528.GA18859@inner.h.apk.li>
 <20150206193313.GA4220@peff.net>
 <xmqq386ihk5w.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Krey <a.krey@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 21:37:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJpeW-0001tQ-ML
	for gcvg-git-2@plane.gmane.org; Fri, 06 Feb 2015 21:37:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755133AbbBFUhU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2015 15:37:20 -0500
Received: from cloud.peff.net ([50.56.180.127]:46105 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752833AbbBFUhT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2015 15:37:19 -0500
Received: (qmail 6354 invoked by uid 102); 6 Feb 2015 20:37:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Feb 2015 14:37:19 -0600
Received: (qmail 11591 invoked by uid 107); 6 Feb 2015 20:37:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 06 Feb 2015 15:37:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Feb 2015 15:37:16 -0500
Content-Disposition: inline
In-Reply-To: <xmqq386ihk5w.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263425>

On Fri, Feb 06, 2015 at 12:14:35PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This is highlighting the problem with "pager.*" that Junio mentioned
> > recently, which is that the keyname has arbitrary data,...
> 
> Yes, even if it is not "arbitrary" (imagine we limit ourselves to
> the official set of commands we know about), the naming rule for the
> "git" subcommand names should not be dictated by the naming rule for
> the configuration variables, as they are unrelated.
> 
> That is one of the reasons why I had the "unbounded set, including
> the ones under our control such as subcommand names" in the draft
> update for the guideline.  I dropped that part after the discussion
> to keep other "obviously agreed" parts moving, but we may have to
> revisit it later.

I think this may be the heart of where we were disagreeing. I took
"unbounded set" to mean "a set where you might keep adding things
forever". So fsck errors would count in that. But if you mean it as "a
set where the syntax may be unbounded", then yeah, we definitely would
not want it in the key name, as that becomes an unnecessary restriction.

A list of enum-like values where we are OK confining the names to the
alnums is OK to use as an unbounded set of key values. Just like we have
color.branch.*, we just pick a name within that syntax for any new
values we add (and that is not even a burden; alnum names are what we
would have picked anyway).

-Peff
