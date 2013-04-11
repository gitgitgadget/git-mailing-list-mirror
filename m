From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/5] check-ignore: allow incremental streaming of queries
 via --stdin
Date: Thu, 11 Apr 2013 14:33:44 -0400
Message-ID: <20130411183344.GA3177@sigill.intra.peff.net>
References: <20130408181311.GA14903@pacific.linksys.moosehall>
 <1365645575-11428-1-git-send-email-git@adamspiers.org>
 <1365645575-11428-2-git-send-email-git@adamspiers.org>
 <20130411112000.GC24296@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Thu Apr 11 20:34:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQMJq-0001t3-Be
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 20:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759250Ab3DKSdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 14:33:53 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40791 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754582Ab3DKSdw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 14:33:52 -0400
Received: (qmail 17940 invoked by uid 107); 11 Apr 2013 18:35:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 11 Apr 2013 14:35:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Apr 2013 14:33:44 -0400
Content-Disposition: inline
In-Reply-To: <20130411112000.GC24296@pacific.linksys.moosehall>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220907>

On Thu, Apr 11, 2013 at 12:20:00PM +0100, Adam Spiers wrote:

> On Thu, Apr 11, 2013 at 02:59:32AM +0100, Adam Spiers wrote:
> > +test_expect_success STDBUF 'streaming support for --stdin' '
> > +	(
> > +		echo one
> > +		sleep 2
> > +		echo two
> > +	) | stdbuf -oL git check-ignore -v -n --stdin >out &
> 
> I just noticed that this patch precedes the one in the same series
> which adds -n support.  I'll reorder them accordingly to avoid
> breaking git bisect.

Thanks for noticing. FWIW, I often do this:

  GIT_EDITOR='sed -i "/^pick /aexec make test" \
  git rebase -i origin/master

on my topics to make sure each commit compiles and passes the tests in
isolation (it will stop on a failure, at which point you can fix up and
"git rebase --continue").

It's somewhat annoying, because it runs the whole test suite, even for
commits that are obviously not going to have an impact (e.g., doc
updates, or change to a single test). But it has saved me from
embarrassment many times, when I thought for sure that my commits were
obviously correct. :)

-Peff
