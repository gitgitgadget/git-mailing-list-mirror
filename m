From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] i18n: use test_i18ncmp in t2020 (checkout --detach)
Date: Sat, 14 Apr 2012 04:22:14 -0400
Message-ID: <20120414082213.GC11124@sigill.intra.peff.net>
References: <20110320090111.GA15641@sigill.intra.peff.net>
 <20110320090918.GB15948@sigill.intra.peff.net>
 <20120413225901.GA13220@burratino>
 <20120413233010.GA16663@sigill.intra.peff.net>
 <20120413234607.GE13995@burratino>
 <20120414022452.GA17535@sigill.intra.peff.net>
 <20120414050234.GE1791@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 14 10:22:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIyFX-00082d-AG
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 10:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753115Ab2DNIWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 04:22:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33920
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753034Ab2DNIWU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 04:22:20 -0400
Received: (qmail 28599 invoked by uid 107); 14 Apr 2012 08:22:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 14 Apr 2012 04:22:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Apr 2012 04:22:14 -0400
Content-Disposition: inline
In-Reply-To: <20120414050234.GE1791@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195480>

On Sat, Apr 14, 2012 at 12:02:34AM -0500, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > Yes, but this wasn't gettext-ed at all until 2012-02-02, and then it
> > didn't get merged into master until the week after. How often do you
> > run GETTEXT_POISON tests? I know I don't, and obviously Junio does not
> > include them as part of his process before pushing out master.
> 
> The theory is that it should be convenient to run them when we are
> considering a "gettextize" patch.

I was thinking when I wrote the above that it might be something worth
running on every test run. But it's really not. It really only matters
if you are gettextizing a string (or introducing a new string). And we
should generally catch that in code review, I would think.

So it's still a good thing to run once in a while, and when there is a
big gettext patch, but it's probably overkill to run it all the time.

> Maybe something like the following would make it easier for some
> people to always build with GETTEXT_POISON and run tests with
> GIT_GETTEXT_POISON only occasionally.

I found "make GETTEXT_POISON=1 test" to be sufficiently easy (and then
my next "make" will un-poison.

> I'd rather have a real poison locale since this would not require any
> runtime support in the git binary, though.  Does the value of
> LC_MESSAGES have to be a valid locale?  Would something like
> en_US@poison work?

That would nice. Poisoning seems like it should be a property
of the test run rather than the build. It seems like putting junk into
LC_MESSAGES will just cause the default messages to be shown (seems like
a sane thing to do), so I suspect you'd have to actually make a poison
locale (though you could probably generate one via script without too
much effort).

-Peff
