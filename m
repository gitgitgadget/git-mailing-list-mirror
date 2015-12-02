From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] clean: new option --exclude-from
Date: Wed, 2 Dec 2015 11:47:12 -0500
Message-ID: <20151202164712.GA16636@sigill.intra.peff.net>
References: <1448549065-16337-1-git-send-email-rouzier@gmail.com>
 <20151202005338.GD28197@sigill.intra.peff.net>
 <xmqq37vl7fux.fsf@gitster.mtv.corp.google.com>
 <20151202024403.GA29329@sigill.intra.peff.net>
 <xmqqlh9c6byy.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: James <rouzier@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 17:47:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4AYr-0007qB-0B
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 17:47:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756149AbbLBQrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 11:47:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:36332 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751477AbbLBQrP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 11:47:15 -0500
Received: (qmail 24285 invoked by uid 102); 2 Dec 2015 16:47:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Dec 2015 10:47:15 -0600
Received: (qmail 32050 invoked by uid 107); 2 Dec 2015 16:47:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Dec 2015 11:47:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Dec 2015 11:47:12 -0500
Content-Disposition: inline
In-Reply-To: <xmqqlh9c6byy.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281891>

On Wed, Dec 02, 2015 at 08:40:05AM -0800, Junio C Hamano wrote:

> But for this particular one, I viewed the topic as adding a new
> option as a shorter way for passing multiple -e <pattern> options on
> the command line.  When viewed that way, even if core.excludesfile
> were multi-valued, I wouldn't have imagined that people would try to
> use that mechanism for such a purpose--for one thing, the precedence
> order is wrong for that purpose, isn't it?

Good point. I didn't think about precedence at all.

I perhaps shouldn't have brought up core.excludesfile as all. I only
meant it as "you maybe can hack your way through to this without adding
any code".

I think a real option to do git-wide excludes would probably be more
like:

  git --exclude-from=/path/to/file clean ...

and that in turn would probably set GIT_EXCLUDE_FROM to a
colon-separated list of paths (or similar) so that sub-processes would
respect it, too.

On the other hand, one could make the same argument about the existing
"-e". You cannot do:

  git add --exclude='*.o' .

right now. So maybe "clean" is really the only place where people care
about such ad-hoc exclusion. Or maybe this an opportunity to add:

  git --exclude='*.o' clean

I dunno. I cannot think of a time when I would have used any of those
options myself.

-Peff
