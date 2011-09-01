From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] test-lib: save test counts across invocations
Date: Thu, 1 Sep 2011 14:45:54 -0400
Message-ID: <20110901184554.GA18737@sigill.intra.peff.net>
References: <8fe5381a6b69079b8c20452fd4d99a128764dd52.1314882443.git.trast@student.ethz.ch>
 <20110901163846.GD15018@sigill.intra.peff.net>
 <1314902334.5371.17.camel@umgah.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Alex Vandiver <alex@chmrr.net>
X-From: git-owner@vger.kernel.org Thu Sep 01 20:46:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzCH4-00086Q-4c
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 20:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757321Ab1IASp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 14:45:57 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57869
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757271Ab1IASp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 14:45:56 -0400
Received: (qmail 22639 invoked by uid 107); 1 Sep 2011 18:46:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 01 Sep 2011 14:46:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Sep 2011 14:45:54 -0400
Content-Disposition: inline
In-Reply-To: <1314902334.5371.17.camel@umgah.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180563>

On Thu, Sep 01, 2011 at 02:38:54PM -0400, Alex Vandiver wrote:

> On Thu, 2011-09-01 at 12:38 -0400, Jeff King wrote:
> > Hmm. What happens when we're wrong? Does our eye-candy just print
> > something non-sensical like "13/12", or does prove actually care that we
> > run the right number of tests?
> 
> prove very much does care -- having a mismatch between the number of
> tests planned and the number of tests run is an error in the testfile,
> and is reported as such in big red text.  This is because stating how
> many tests you plan to run gives prove a way (in addition to the exit
> status) to know if the test stopped prematurely, so all mismatches
> between plan and actual test counts are reported as testfile failures.

Thanks. I suspected something like that, but was too lazy to look. :)

Given that our methods for automatically determining the number of tests
are so flaky, and that prove will treat it so seriously, it doesn't seem
worth pursuing to me.

We already handle the premature abort case by trapping exit from the
shell before the script calls test_done. So I don't think that is a
feature of prove that we particularly care about.

> As far as I know prove doesn't have a way to print the estimated time
> remaining, though using the contents of the .prove file (if you ran
> prove --state=save) to guess it wouldn't be all that hard of a change.

That would be a neat feature. In practice, I know about how many tests
there are total (~7500), and how long it takes to run on my system (~60
seconds), so I can do the math myself. Still, a little more eye candy
couldn't hurt. ;)

If I underestand the code correctly, we could even write our own custom
"formatter" for git and use it via "prove --formatter".

-Peff
