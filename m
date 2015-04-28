From: Jeff King <peff@peff.net>
Subject: Re: Fwd: Can't override username of default credential context to
 have different username in custom context.
Date: Tue, 28 Apr 2015 01:25:39 -0400
Message-ID: <20150428052539.GG24580@peff.net>
References: <CAK9djV0CqO4sXPMqKCnH3VZFQ4G=XFbNPRF-ZMXjNRLjqfcngw@mail.gmail.com>
 <20150428052502.GF24580@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>, git@vger.kernel.org
To: Vladislav Kostenko <vkostenko@netlabsystems.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 07:25:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ymy1i-0006x7-BY
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 07:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbbD1FZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 01:25:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:50964 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751343AbbD1FZl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 01:25:41 -0400
Received: (qmail 18082 invoked by uid 102); 28 Apr 2015 05:25:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Apr 2015 00:25:41 -0500
Received: (qmail 11554 invoked by uid 107); 28 Apr 2015 05:26:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Apr 2015 01:26:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Apr 2015 01:25:39 -0400
Content-Disposition: inline
In-Reply-To: <20150428052502.GF24580@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267896>

[+cc Kyle, who I forgot on the initial send. Oops!]

On Tue, Apr 28, 2015 at 01:25:02AM -0400, Jeff King wrote:

> On Mon, Apr 27, 2015 at 09:19:31PM +0500, Vladislav Kostenko wrote:
> 
> > Here is my scenario:
> > 
> > 1. First I set default username
> > git config --global credential.username myUsername
> > 
> > 2. Then I want to have different username for my other repository
> > git config --global
> > credential.https://myOtherRepository.visualstudio.com.username
> > myOtherUsername
> > 
> > 3. When I try to pull new changes, git asks for password of myUsername
> > Password for 'https://myUsername@myOtherRepository.visualstudio.com':
> > 
> > But I want to have:
> > Password for 'https://myOtherUsername@myOtherRepository.visualstudio.com':
> > 
> > Is there any way to accomplish overriding?
> 
> Only by changing the ordering in the config file, as you noticed.
> 
> The other http.* options will choose the most-specific match, but the
> credential code predates that, and blindly goes in config order. Kyle
> (cc'd) added the urlmatch support for http.*, and might be able to say
> whether it could be adapted for the credential code. If so, then I think
> it would need somebody to volunteer to work on it.
> 
> That would technically be a backwards-incompatible change to switch the
> lookup order at this point in time, but I'm somewhat of the opinion that
> in any case it matters, the new behavior would be a strict improvement.
> 
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
