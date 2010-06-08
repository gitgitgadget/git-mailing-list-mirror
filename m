From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] Fix for default pager
Date: Tue, 8 Jun 2010 01:35:07 -0400
Message-ID: <20100608053507.GB15156@coredump.intra.peff.net>
References: <1275955088-32750-1-git-send-email-soft.d4rio@gmail.com>
 <1275955270-sup-2380@pinkfloyd.chass.utoronto.ca>
 <AANLkTinydWk3GqGDww8FS7pmW16jAVazRkmT_GsRMIhy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, git <git@vger.kernel.org>
To: Dario Rodriguez <soft.d4rio@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 08 07:35:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLrT4-000445-0D
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 07:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097Ab0FHFfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 01:35:11 -0400
Received: from peff.net ([208.65.91.99]:55809 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750959Ab0FHFfK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 01:35:10 -0400
Received: (qmail 1503 invoked by uid 107); 8 Jun 2010 05:35:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 08 Jun 2010 01:35:19 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Jun 2010 01:35:07 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinydWk3GqGDww8FS7pmW16jAVazRkmT_GsRMIhy@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148643>

On Mon, Jun 07, 2010 at 11:14:58PM -0300, Dario Rodriguez wrote:

> On Mon, Jun 7, 2010 at 9:04 PM, Ben Walton <bwalton@artsci.utoronto.ca> wrote:
> >
> > Why not set a sensible DEFAULT_PAGER value for the system in your
> > config.mak file instead?
> >
> > Just curious.
> >
> 
> I was thinking about it before coding the patch, and found some
> consequences. First of all, the most important thing I should
> understand is that most users will install git from binary,
> precompiled packages instead of the good download and compile. So this
> is actually a good reason to not do it that way (config.mak)... Some
> users may download the compiled binary while it's actually calling
> it's default pager.

If you are downloading a binary, the package compiler should do one of
two things:

  1. indicate a package dependency on 'less'

  2. set DEFAULT_PAGER to 'more' (or whatever is appropriate for your
     system)

Yes, auto-detection means we can more flexibly "upgrade" to less when
the package suddenly appears. But if you really care about your pager,
why not just set $PAGER?

The most important thing is that users who _don't_ care don't see
something broken, but the rules above already cover that with current
git.

> But this is not the only reason. Let me give you an example: We
> develop (I'm actually working at Accenture) using several machines.
> When we need some tool, we compile it in our first machine, and
> install it for an specific user. In some other environments we cannot
> compile things (testing environments) so we transfer (FTP) those
> binary files. It's just another case, and the default pager could
> cause problems here (in fact, i experienced such problems).

Then set DEFAULT_PAGER to 'more' (or 'cat' for that matter), and use
$PAGER on machines that are more capable.

-Peff
