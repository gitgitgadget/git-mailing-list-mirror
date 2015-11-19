From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 0/6] Add Travis CI support
Date: Thu, 19 Nov 2015 09:14:09 -0500
Message-ID: <20151119141409.GB9353@sigill.intra.peff.net>
References: <1447923491-15330-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, luke@diamand.org, sunshine@sunshineco.com,
	gitster@pobox.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Thu Nov 19 15:14:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzPyj-0006dk-5f
	for gcvg-git-2@plane.gmane.org; Thu, 19 Nov 2015 15:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934309AbbKSOOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2015 09:14:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:59710 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934205AbbKSOOL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2015 09:14:11 -0500
Received: (qmail 17096 invoked by uid 102); 19 Nov 2015 14:14:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Nov 2015 08:14:11 -0600
Received: (qmail 16918 invoked by uid 107); 19 Nov 2015 14:14:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Nov 2015 09:14:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Nov 2015 09:14:09 -0500
Content-Disposition: inline
In-Reply-To: <1447923491-15330-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281477>

On Thu, Nov 19, 2015 at 09:58:05AM +0100, larsxschneider@gmail.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> diff to v5:
> * check if PID file still exists on P4D cleanup (thanks Luke)
> * fix space/tab formatting error
> * add sleep to timeout loops (thanks Luke)
> * replace 'date +%s' with platform independent Python function (thanks Eric and Luke)
> 
> With the patches of this series the Travis CI test stability increases.
> However, as I am "stress testing" the Travis CI infrastructure you can
> see that it is not perfect: https://travis-ci.org/larsxschneider/git/builds

I peeked at a few, and it looks like just p4 tests failing now?

> Nevertheless, I believe that Travis CI integration has still value as
> contributors can test their patches easily on Linux and OS X before
> posting them.
> 
> @junio / @peff: Do you consider merging this?

I think I'd prefer to split it into 3 separate topics (de-flaking
test_must_fail, p4 test improvements, and the Travis file). Then they
can proceed independently. I can take care of that split when applying.

> Lars Schneider (6):
>   implement test_might_fail using a refactored test_must_fail

You mentioned in the v5 cover that this one was from Junio. Should it be
"From: Junio ..." in the pseudo-header?

>   add "ok=sigpipe" to test_must_fail and use it to fix flaky tests

Looks OK.

>   git-p4: retry kill/cleanup operations in tests with timeout
>   git-p4: add p4d timeout in tests
>   git-p4: add trap to kill p4d on test exit

These are all fairly gross, and I don't have p4d to test with myself.
But if we assume they're all necessary, I suppose it's the best we can
do.

>   Add Travis CI support

I'll leave some comments directly in response to this one.

-Peff
