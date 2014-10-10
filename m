From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 0/5] add "unset.variable" for unsetting previously
 set variables
Date: Fri, 10 Oct 2014 04:11:07 -0400
Message-ID: <20141010081107.GA8355@peff.net>
References: <1412256292-4286-1-git-send-email-tanayabh@gmail.com>
 <xmqqvbo2meg5.fsf@gitster.dls.corp.google.com>
 <5433CBC3.5010202@gmail.com>
 <xmqq1tqjkexe.fsf@gitster.dls.corp.google.com>
 <vpqzjd7kta6.fsf@anie.imag.fr>
 <xmqqy4sqbi12.fsf@gitster.dls.corp.google.com>
 <vpq61fujtlk.fsf@anie.imag.fr>
 <xmqqk34a8hl3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Rasmus Villemoes <rv@rasmusvillemoes.dk>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 10 10:11:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcVII-0005uV-KD
	for gcvg-git-2@plane.gmane.org; Fri, 10 Oct 2014 10:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbaJJILR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2014 04:11:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:57112 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751847AbaJJILJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2014 04:11:09 -0400
Received: (qmail 1119 invoked by uid 102); 10 Oct 2014 08:11:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Oct 2014 03:11:09 -0500
Received: (qmail 31170 invoked by uid 107); 10 Oct 2014 08:11:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Oct 2014 04:11:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Oct 2014 04:11:07 -0400
Content-Disposition: inline
In-Reply-To: <xmqqk34a8hl3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 08, 2014 at 12:52:24PM -0700, Junio C Hamano wrote:

> The whole reason why the actualy diff.*.command and textconv
> commands are defined in .git/config while the filetype label is
> assigned by in-tree .gitattributes is because these commands are
> platform dependant.  So textconv on Linux, BSD and Windows may want
> to be different commands, and the project that ships an in-tree
> .gitconfig to be safe-included may want to not "set" the variable to
> one specific value, but stop at offering a suggestion, i.e. "there
> are these possibilities, perhaps you may want to pick one of them?"
> without actually making the choice for the user.

Or it could even auto-detect a sensible version based on the user's
filesystem. Which makes me wonder if safe-include is really helping that
much versus a project shipping a shell script that munges the repository
config. The latter is less safe (you are, after all, running code, but
you would at least have the chance to examine it), but is way more
flexible. And the safety is comparable to running "make" on a cloned
project.

I dunno. I do not have anything against the safe-include idea, but each
time it comes up, I think we are often left guessing about exactly which
config options projects would want to set, and to what values.

-Peff
