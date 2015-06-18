From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] format-patch: introduce format.outputDirectory
 configuration
Date: Thu, 18 Jun 2015 16:13:24 -0400
Message-ID: <20150618201323.GB14550@peff.net>
References: <1434626280-4610-1-git-send-email-kuleshovmail@gmail.com>
 <xmqq616ley7y.fsf@gitster.dls.corp.google.com>
 <20150618195751.GA14550@peff.net>
 <xmqqoakceq8s.fsf@gitster.dls.corp.google.com>
 <xmqqk2v0eq75.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 22:13:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5gBn-0007JU-TZ
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 22:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755748AbbFRUN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 16:13:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:48410 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753398AbbFRUN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 16:13:27 -0400
Received: (qmail 24763 invoked by uid 102); 18 Jun 2015 20:13:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Jun 2015 15:13:26 -0500
Received: (qmail 8055 invoked by uid 107); 18 Jun 2015 20:13:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 18 Jun 2015 16:13:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Jun 2015 16:13:24 -0400
Content-Disposition: inline
In-Reply-To: <xmqqk2v0eq75.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272063>

On Thu, Jun 18, 2015 at 01:06:54PM -0700, Junio C Hamano wrote:

> >> Don't we load the config before parsing options here? In that case, we
> >> can use our usual strategy to just set output_directory (which is
> >> already a static global) from the config callback, and everything Just
> >> Works.
> >>
> >> We do have to bump the definition of output_directory up above the
> >> config callback, like so (while we are here, we might also want to
> >> drop the unnecessary static initializers, which violate our style guide):
> >
> > You would also need to remove the "oh you gave me -o twice?" check,
> > and change the semantics to "later -o overrides an earlier one",
> > wouldn't you?  Otherwise you would never be able to override what
> > you read from the config, I am afraid.
> 
> By the way, I actually think "later -o overrides an earlier one" is
> a good change by itself, regardless of this new configuration.

Ah, I didn't realize we did that. Yeah, I think we should switch to
"later overrides earlier". There is no need for "-o" to behave
completely differently than all of our other options.

-Peff
