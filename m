From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] refs: support negative transfer.hideRefs
Date: Thu, 30 Jul 2015 19:28:35 -0400
Message-ID: <20150730232835.GA5805@sigill.intra.peff.net>
References: <20150728195747.GA13596@peff.net>
 <20150728195934.GB13795@peff.net>
 <CAPig+cTJuCWwhzrAt47yCEMv4yrTX-C1e9L_yBwyqJ-YbGfcuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 01:28:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKxFl-0008QB-2Q
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 01:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017AbbG3X2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 19:28:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:37122 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751610AbbG3X2k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 19:28:40 -0400
Received: (qmail 18413 invoked by uid 102); 30 Jul 2015 23:28:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Jul 2015 18:28:39 -0500
Received: (qmail 6453 invoked by uid 107); 30 Jul 2015 23:28:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Jul 2015 19:28:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Jul 2015 19:28:35 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cTJuCWwhzrAt47yCEMv4yrTX-C1e9L_yBwyqJ-YbGfcuA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275030>

On Thu, Jul 30, 2015 at 04:17:35PM -0400, Eric Sunshine wrote:

> > +       test_expect_success "Override hiding of $configsection.hiderefs" '
> > +               test_when_finished "test_unconfig $configsection.hiderefs" &&
> > +               git config --add $configsection.hiderefs refs/tags &&
> > +               git config --add $configsection.hiderefs "!refs/tags/magic" &&
> > +               git config --add $configsection.hiderefs refs/tags/magic/one &&
> > +               git ls-remote . >actual &&
> > +               verbose grep refs/tags/magic/two actual
> 
> For completeness, do you also want to add
> 
>     !grep refs/tags/magic/one actual
> 
> to confirm that the third hideRefs did indeed override the second one?

Yeah, I think that is a good change. We could also test_cmp the whole
output, but I didn't want to be dependent on other junk from previous
tests.

-Peff
