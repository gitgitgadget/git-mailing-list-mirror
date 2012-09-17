From: Jeff King <peff@peff.net>
Subject: Re: How do I run tests under Valgrind?
Date: Mon, 17 Sep 2012 13:44:39 -0400
Message-ID: <20120917174439.GD1179@sigill.intra.peff.net>
References: <CALkWK0m_9OsAfG_pF3hUDW+EKCyZCn9NiDKKEW6AEOMmAw=yuA@mail.gmail.com>
 <20120917172022.GA1179@sigill.intra.peff.net>
 <CALkWK0m378ApSwa1xiYUqEjMny5m0wt3KacqdDRU1qt=cw6k8g@mail.gmail.com>
 <20120917173531.GB1179@sigill.intra.peff.net>
 <CALkWK0kDPGY_3v5SLPtyf+azUwA7msvQOvA+MaCgueZ71i2yGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 19:44:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDfNL-00012E-JE
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 19:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756846Ab2IQRon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 13:44:43 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:46662 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045Ab2IQRom (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 13:44:42 -0400
Received: (qmail 9505 invoked by uid 107); 17 Sep 2012 17:45:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Sep 2012 13:45:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Sep 2012 13:44:39 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0kDPGY_3v5SLPtyf+azUwA7msvQOvA+MaCgueZ71i2yGw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205723>

On Mon, Sep 17, 2012 at 11:09:27PM +0530, Ramkumar Ramachandra wrote:

> Hi again,
> 
> Jeff King wrote:
> > That's certainly odd. It sounds like the valgrind setup is broken for
> > you. Can you run:
> >
> >   sh -x t0000-basic.sh --valgrind
> >
> > and see what's happening near those weird errors?
> 
> Not helpful:
> 
> + . ./test-lib.sh
> + mkdir -p test-results
> + basename t0000-basic.sh .sh
> + BASE=test-results/t0000-basic
> + GIT_TEST_TEE_STARTED=done /usr/bin/zsh t0000-basic.sh --valgrind
> + tee test-results/t0000-basic.out

Oh, bleh. Stupid automatic --tee for valgrind. Try this:

  SHELL="/usr/bin/zsh -x" ./t0000-basic.sh --valgrind

I am also doing my tests with "dash" as my shell. You might try setting
your SHELL to /bin/sh to see if it makes a difference.

> >> test_cmp:1: command not found: diff -u
> >
> > Lack of diff is going to be a problem. What OS is this? Do you really
> > not have diff? Or is there something funny going on with your PATH?
> 
> It's plain Ubuntu.  Ofcourse I have `diff`- I don't know what's going on.

Maybe the PATH-munging in test-lib.sh is screwing up your PATH somehow.
But it all looks pretty simple. The "sh -x" output can maybe tell us
more.

-Peff
