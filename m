From: Jeff King <peff@peff.net>
Subject: Re: parse-options does not recognize "unspecified" behavior
Date: Wed, 16 Mar 2016 17:23:09 -0400
Message-ID: <20160316212308.GA4538@sigill.intra.peff.net>
References: <CAFZEwPPd2wFqFq2LFEzN2CzhTV6C420SLPcXi1SWE=z2epOYLw@mail.gmail.com>
 <20160316204912.GA1890@sigill.intra.peff.net>
 <CAFZEwPMa3GZS6pvFwr8PLVDqKm5xmMd307nbjhpZSC_ndpw8vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 22:23:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agIuT-0004Ne-2R
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 22:23:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755824AbcCPVXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 17:23:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:32812 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755493AbcCPVXM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 17:23:12 -0400
Received: (qmail 26069 invoked by uid 102); 16 Mar 2016 21:23:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Mar 2016 17:23:11 -0400
Received: (qmail 20275 invoked by uid 107); 16 Mar 2016 21:23:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Mar 2016 17:23:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Mar 2016 17:23:09 -0400
Content-Disposition: inline
In-Reply-To: <CAFZEwPMa3GZS6pvFwr8PLVDqKm5xmMd307nbjhpZSC_ndpw8vw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289042>

On Thu, Mar 17, 2016 at 02:36:51AM +0530, Pranit Bauva wrote:

> > So I think the caller choosing "-1" here as the "not set" value is the
> > bug.
> >
> > -Peff
> 
> I agree to you on the point that parse-options should not care about
> the value passed to it. But I think plainly incrementing the value of
> the variable is not a very nice way. I have an another approach to it.
> The parse-options will first store a temporary structure. If there is
> some changes (not the "--no-" ones) then it sets the respective
> variable in temporary structure to the set value. If "--no-" is passed
> then it writes the "reset" value to the respective variable in
> temporary structure. If nothing about that options is specified then
> it copies the respective variable from original to temporary. After
> completing the entire process, it can copy temporary structure to the
> original structure.
> 
> What are your opinions about this?

I don't think that would produce the wrong behavior, but it seems like a
very complicated solution to a problem that can easily be solved by just
following the usual conventions (that verbose starts at 0, options make
it go up or down, and "--no-" resets it to zero).

Perhaps it would make more sense if I understood what your goal was in
setting verbose to -1 in the first place.

-Peff
