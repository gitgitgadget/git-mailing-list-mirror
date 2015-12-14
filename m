From: Jeff King <peff@peff.net>
Subject: Re: git bisect with temporary commits
Date: Mon, 14 Dec 2015 16:09:36 -0500
Message-ID: <20151214210936.GD14788@sigill.intra.peff.net>
References: <20151214163726.GY13519@tonks>
 <87si34hphr.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Florian Bruhin <me@the-compiler.org>, git@vger.kernel.org,
	r.seitz@beh.ch
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Dec 14 22:09:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8aNM-0007G6-Ur
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 22:09:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932650AbbLNVJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 16:09:41 -0500
Received: from cloud.peff.net ([50.56.180.127]:41497 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932325AbbLNVJj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 16:09:39 -0500
Received: (qmail 18344 invoked by uid 102); 14 Dec 2015 21:09:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Dec 2015 15:09:39 -0600
Received: (qmail 31655 invoked by uid 107); 14 Dec 2015 21:09:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Dec 2015 16:09:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Dec 2015 16:09:36 -0500
Content-Disposition: inline
In-Reply-To: <87si34hphr.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282414>

On Mon, Dec 14, 2015 at 07:08:48PM +0100, Andreas Schwab wrote:

> Florian Bruhin <me@the-compiler.org> writes:
> 
> > Now when trying to say it's good (and forgetting to remove the
> > temporary commits), I get this:
> >
> >     $ git bisect good
> >     Bisecting: a merge base must be tested
> >     [981e1093dae24b37189bcba2dd848b0c3388080c] still good and does not compile
> >
> > Is this intended behaviour? Shouldn't git either do a reset to the
> > commit we're currently bisecting, or warn the user as it was probably
> > unintended to add new commits?
> 
> You should instead tell git that HEAD^ is good, since that is what git
> asked you to test.

Another alternative is to use "git cherry-pick -n" to create a working
tree state that you can test, but leave HEAD at the original commit.
Then "git bisect good" does the right thing.

It's the same principle and I don't think there is a reason to prefer
one over the other. I just find it harder to screw up, as I usually
script the build/test, so I can stick the cherry-pick there and not have
to remember it on each "good/bad" report.

-Peff
